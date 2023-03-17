Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A742F6BE9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCQMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCQMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:51:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF7B0B82
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:51:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4161A21A50;
        Fri, 17 Mar 2023 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679057482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3qXpE4qhvPbVyC/H/CPe13n8aQ2FsNteOPKSQagJOc=;
        b=tvJrLPs2sZsSBesrHL4wEdIvDbUJQIEkyk8aSX4M0Zx6+CqimvkdJyjqBJynWDQckTS+LH
        VjUZQIkTVlNWjrO1g1AoR+wz+m+GgaocNY9EQyNdIZMHZw8xChCzRW6CXbGMFu+onU6Fay
        +8zsjeis05JBRnZot76ApUFie3d7gKE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA7CE2C141;
        Fri, 17 Mar 2023 12:51:21 +0000 (UTC)
Date:   Fri, 17 Mar 2023 13:51:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
Message-ID: <ZBRiRu7hlwxSKHBg@alley>
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-16 11:29:26, Guillermo Rodriguez Garcia wrote:
> Hi all,
> 
> We have several embedded systems where pass console= or console=null
> in production to disable the console.
> 
> Later we check for this in user space: in our inittab we check if fd0
> is "associated with a terminal" (test -t 0); if so, we are in
> development mode and we open a debug shell; otherwise (console
> disabled) we just start the application.
> 
> Recently [1] this behaviour has changed and now if we pass console= or
> console=null, the new ttynull driver is used. This breaks the check we
> were doing (test -t 0 always true now).
>
> [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/

This is actually exactly the problem that the change tried to solve.
Some systems failed to boot when there was no console and they tried
to write something at stdout.

> Is there a way to get the previous behaviour? If not, is there an easy
> way for userspace to detect whether the console device is a "real" tty
> or ttynull (other than trying to parse the kernel boot args, which
> would be a bit fragile).

A solution would be to check that /proc/consoles has ttynull as the
only registred console, for example:

grep -q ttynull /proc/consoles && test `cat /proc/consoles | wc -l` -eq 1

Would this work for you, please?

Best Regards,
Petr
