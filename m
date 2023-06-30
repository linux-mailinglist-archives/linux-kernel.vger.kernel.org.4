Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680F743514
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjF3Gc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjF3Gcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:32:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D045C2D71;
        Thu, 29 Jun 2023 23:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68B76616D6;
        Fri, 30 Jun 2023 06:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55162C433C0;
        Fri, 30 Jun 2023 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688106760;
        bh=BPDk7H+jhHuLFprW64J6/fgB0XfVTAIjuo57afaHL1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hqrl+j6yUVvzd5yy01tfh4aj1nl0Bfoeruq5nxt1TUOmR6KjdyGVsbrz4mvsF/J/p
         /GBo7GBGnk3mYZrbBV5SvwxaDyfwzGDRuO7SfSxcnBSB/ztGG9udF3BrRfYpDmbYFG
         Rt0UFPBwYbNntQ+XvvL0YbtE1roZlUGGyR/wTjW0=
Date:   Fri, 30 Jun 2023 08:32:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/29] 6.4.1-rc2 review
Message-ID: <2023063030-overgrown-unfunded-7523@gregkh>
References: <20230630055626.202608973@linuxfoundation.org>
 <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:20:45PM -0700, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 22:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Linus Torvalds <torvalds@linux-foundation.org>
> >     gup: add warning if some caller would seem to want stack expansion
> 
> Did you decide to take that one after all?

For now, yes.

> It's not exactly wrong, and it might help find any odd cases, but I do
> suspect you can get syzbot etc to trigger the warning. It's designed
> to find crazy users, and syzbot is - pretty much by definition and by
> design - one of the craziest out there.

I think the "crazy users" reports might be triggered sooner with stable
updates than from your tree as well, so this might be a early-warning
type system.  I am pretty sure at least one "distro" has enabled it in
their kernel already as well.

But if this starts triggering a bunch of warnings, and they are causing
problems, I'll drop it (and recommend you revert it in your tree too.)

I wanted to be "warning compatible" here for now to ensure the backports
were working properly.

thanks,

greg k-h
