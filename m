Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09A26D5FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjDDMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjDDMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B64220;
        Tue,  4 Apr 2023 05:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A36F61774;
        Tue,  4 Apr 2023 12:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A6C4339E;
        Tue,  4 Apr 2023 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680609810;
        bh=oxjQvXBiMtX0M82oh4PK7j3KaNk995eVAXcg7XjUDMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2yluT70VrrXTiykWvAVpFjUKwC/S61zinZbFbR+NhTZu8rCkxmUHhPtlAqlZrB5v
         BKP0u/ye9XwzAV+YYDE8v1xtr9GvkUO2yfGb6hfiTZeB9kasrb7ZWbXK0TvRvY/6U2
         SrEYMq+1VtvitH3QqWTqlA/sX6CbnNpAvQuk5CAg=
Date:   Tue, 4 Apr 2023 14:03:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kay Sievers <kay.sievers@vrfy.org>, stable <stable@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [RESEND PATCH] memstick: fix memory leak if card device is never
 registered
Message-ID: <2023040411-outhouse-faceless-60e8@gregkh>
References: <20230401200327.16800-1-gregkh@linuxfoundation.org>
 <CAPDyKFq3VUVM2-ATNykGyutMoNDO3EkbT2foZBQjxzKr7cTnFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq3VUVM2-ATNykGyutMoNDO3EkbT2foZBQjxzKr7cTnFg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:54:03PM +0200, Ulf Hansson wrote:
> On Sat, 1 Apr 2023 at 22:03, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling dev_set_name() memory is allocated for the name for the
> > struct device.  Once that structure device is registered, or attempted
> > to be registerd, with the driver core, the driver core will handle
> > cleaning up that memory when the device is removed from the system.
> >
> > Unfortunatly for the memstick code, there is an error path that causes
> > the struct device to never be registered, and so the memory allocated in
> > dev_set_name will be leaked.  Fix that leak by manually freeing it right
> > before the memory for the device is freed.
> >
> > Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> > Cc: Alex Dubov <oakad@yahoo.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Kay Sievers <kay.sievers@vrfy.org>
> > Cc: linux-mmc@vger.kernel.org
> > Fixes: 0252c3b4f018 ("memstick: struct device - replace bus_id with dev_name(),
> > Cc: stable <stable@kernel.org>
> > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Applied for fixes and by adding Mirsad's sob tag (according to the
> other thread [1]), thanks!

Wonderful, thanks for picking up that tag, and the patch.

greg k-h
