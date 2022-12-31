Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61365A4B1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiLaNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:42:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2BCB2C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19B0FB80761
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 13:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35666C433EF;
        Sat, 31 Dec 2022 13:42:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bYJMYrnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672494149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2wmlHvVomyofqRCJf8xfYVH8sZL3Dd8L4/TPehW1Yw=;
        b=bYJMYrnXsYoytmbfdMfU0ed34teYzMX4TFMO/F2u1WxepKWG81VNgq532j1ZgGNU75XY9I
        g0yeZe4ANe0vceStz6ryhNhxgacZZCUAVPJPgmVAMN+duJaumLvF9fvRwS2e8NrDxyiDws
        1e/81cMdmUhtOPoKwxMNzl7TiPTdCBw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e6787442 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 31 Dec 2022 13:42:29 +0000 (UTC)
Date:   Sat, 31 Dec 2022 14:42:26 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7A8QiYgoYU3QdLm@zx2c4.com>
References: <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y68K4mPuz6edQkCX@zx2c4.com>
 <Y7AFYKWPRXYs7S4m@zn.tnic>
 <Y7AxGiGQYZNJWpCr@zx2c4.com>
 <Y7A6sTOSudSxSWLB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7A6sTOSudSxSWLB@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 02:35:45PM +0100, Borislav Petkov wrote:
> On Sat, Dec 31, 2022 at 01:54:50PM +0100, Jason A. Donenfeld wrote:
> > Nothing special... `-kernel bzImage` should be enough to do it. Eric
> > reported it, and then I was able to repro trivially. Sure you got the
> > right version?
> 
> Yeah, qemu executables confusion here - had wrongly something older of the
> version 7.1...
> 
> Now made sure I'm actually booting with the latest qemu:
> 
> QEMU emulator version 7.2.50 (v7.2.0-333-g222059a0fccf)
> 
> With that the kernel with your config hangs early during boot and the stack
> trace is below.
> 
> Seeing how it says trapnr 14, then that looks like something you are seeing.
> 
> But lemme poke at it more.

Yes. The cause is what I've described in the commit message. There are
two proposed fixes, the v1, which has the 62 MiB limitation due to a
kernel bug, and the v3, which seems to work fine, and is simpler, and I
suspect that's the one QEMU upstream should take.

https://lore.kernel.org/lkml/20221230220725.618763-1-Jason@zx2c4.com/
