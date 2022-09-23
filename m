Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC2E5E7E32
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiIWPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiIWPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:21:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6851432BD;
        Fri, 23 Sep 2022 08:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 951C9B82262;
        Fri, 23 Sep 2022 15:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB207C433C1;
        Fri, 23 Sep 2022 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663946481;
        bh=AMZ3inSGZV5OrcGYLzh5KGNiffZgtOou0tt0f3HvGlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2X7zt//NkB40O1aMKJTGAbK4XfPetHPPFGz0WW9DBdnL+8LTuw5+Gn8s/8JZevy/m
         +iC7556NR+rHqa0lwr3FNB2yTBtyplSqAmVpS8q1p0HIJNBXwETVIxHhl3CxF6EybL
         6TcIUJiiZNPBDbfr7as/Yf1+IdlKhtG0WWqfQA1A=
Date:   Fri, 23 Sep 2022 17:21:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org
Subject: Re: KASAN: use-after-free Read in f_hidg_read
Message-ID: <Yy3O7sHsaSpdUQ1z@kroah.com>
References: <CAB7eex+oUZ2Vfa1ZvTkXCYf94k_-6t1v4XzMaoMRaxhk+QCp3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eex+oUZ2Vfa1ZvTkXCYf94k_-6t1v4XzMaoMRaxhk+QCp3Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:13:39PM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
> triggered.
> 
> HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
> git tree: upstream
> 
> kernel config: https://pastebin.com/raw/xtrgsXP3
> C reproducer: https://pastebin.com/raw/NeCr7cX0
> console output: https://pastebin.com/raw/4uH5CL2k
> 
> Basically, in the c reproducer, we use the gadget module to emulate
> attaching a USB device(vendor id: 0x5ac, product id: 0x30a) and
> executing some simple sequence of system calls.
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
> the trick.
> 
> I would appreciate it if you have any idea how to solve this bug.

Please see my response to other recent syzbot-found-issues on this
mailing list in the past few days as to what I would recommend doing
here.

thanks,

greg k-h
