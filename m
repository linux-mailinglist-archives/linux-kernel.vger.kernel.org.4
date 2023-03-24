Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8589D6C7A86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjCXI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjCXI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7E2940F;
        Fri, 24 Mar 2023 01:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57FB629B4;
        Fri, 24 Mar 2023 08:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26BCC433EF;
        Fri, 24 Mar 2023 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679648211;
        bh=ID879acp8ijAkdLZPuK+UIbtPtpqeggUHZ0gt2kpBqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Szu4kdYkoNlVIZ6fakQf96VshFIqhfuNWgA7lpiKW4+16juuA91OJWyaaveoOXpJD
         Vp4vhQmzveLq+L6hSDWo50CBBGVWhGsMtGKDkCVp1Guz3syNERr25vgmecbSxVwRhH
         dbfWzh2GTwQ4Bcgzjposd0zyxsSkBrypm3Kr/7qY=
Date:   Fri, 24 Mar 2023 09:56:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/19] cpuidle: move to use bus_get_dev_root()
Message-ID: <ZB1lyFkeQavXmThE@kroah.com>
References: <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
 <20230322090557.2943479-1-gregkh@linuxfoundation.org>
 <CAJZ5v0h_oTjn5FGuyDvGzewY9VDqo7U0YN1X+XZcsQqLhtNCSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h_oTjn5FGuyDvGzewY9VDqo7U0YN1X+XZcsQqLhtNCSg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:27:45PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 22, 2023 at 10:06 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Direct access to the struct bus_type dev_root pointer is going away soon
> > so replace that with a call to bus_get_dev_root() instead, which is what
> > it is there for.
> >
> > This allows us to clean up the cpuidle_add_interface() call a bit as it
> > was only called in one place, with the same argument so just put that
> > into the function itself.  Note that cpuidle_remove_interface() should
> > also probably be removed in the future as there are no callers of it for
> > some reason.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Great, thanks for the quick reviews!

greg k-h
