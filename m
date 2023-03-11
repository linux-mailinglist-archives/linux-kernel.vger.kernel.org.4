Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1406B596C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCKILB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCKIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:10:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8AA5E7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:10:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4037A609EB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A59C433EF;
        Sat, 11 Mar 2023 08:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678522253;
        bh=O1RUhPN/GmioYSQfO19oEWifAQg4f/SmTr52PPhbLGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqMwzf92FLs8CP4YS81Bph+YAiviE3/xpmv3s5aZJpEAnIPD/2jYPXMXxldeNyANG
         jS9J0QJ8Y4Zp2N750LdoDkb4cxSN2NOban4BfVOL3oFI5LhYNDZYcdH3k/d9jjuDyR
         WkYvRb50EOB9yI3swBfrlyLS9f/bYzKzQCmJ1W5E=
Date:   Sat, 11 Mar 2023 09:10:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH 3/4] kobject: validate ktype release function during add
Message-ID: <ZAw3iu+EquTj4y5U@kroah.com>
References: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
 <20230311-kobject-warning-v1-3-1ebba4f71fb5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311-kobject-warning-v1-3-1ebba4f71fb5@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 03:14:48AM +0000, Thomas Weißschuh wrote:
> Validating the ktype during cleanup is suboptimal.
> Many kobjects are only destroyed during shutdown which makes it hard to
> observe the messages.
> 
> Instead perform the validation when the object is added.

As much as I would like to do this, it will cause way too many
false-positives at this point in time, sorry.

Yes, kobjects should always have a release function, but for some, they
are static structures and so do not have them, which is why we only
report the problem when the object is going away as that is when it
matters.

So if you fix up all the in-kernel static kobjects first, then we can
take this type of change, sorry.

Your first 2 are great though, I'll go queue them up next week, thanks
for the cleanups there.

greg k-h
