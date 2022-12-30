Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78E0659A38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiL3Pyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3Pyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:54:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583E178BE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF544B81CC2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368B7C433D2;
        Fri, 30 Dec 2022 15:54:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cthGg0NM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672415676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BxfkqOG1X9KuqUurA2SWp45MzpX2tzl76AOrYBX8vQ0=;
        b=cthGg0NM0dVWdKvV1zp+jB5rca47a21IO6n3zxLLzOp65JWqNPbQJNl3WrtYsGIT0TEPPN
        TorQyQeFPOUl9l7L9+CP2bIPR07oP181k7iAQDPwvaZ4N5oBMkcWM641IcoE9QcEecKgFu
        0vJZQPICKmJERWhDOqV+okWpoUilnf8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2838488f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 15:54:35 +0000 (UTC)
Date:   Fri, 30 Dec 2022 16:54:27 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y68Js5b0jW/2nLU4@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y62MdawGaasXmoVL@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 01:47:49PM +0100, Borislav Petkov wrote:
> On Wed, Dec 28, 2022 at 11:31:34PM -0800, H. Peter Anvin wrote:
> > As far as a crash... that sounds like a big and a pretty serious one at that.
> > 
> > Could you let me know what kernel you are using and how *exactly* you are booting it?
> 
> Right, with CONFIG_X86_VERBOSE_BOOTUP=y in a guest here, it says:
> 
> early console in extract_kernel
> input_data: 0x000000000be073a8
> input_len: 0x00000000008cfc43
> output: 0x0000000001000000
> output_len: 0x000000000b600a98
> kernel_total_size: 0x000000000ac26000
> needed_size: 0x000000000b800000
> trampoline_32bit: 0x000000000009d000
> 
> so that's a ~9M kernel which gets decompressed at 0x1000000 and the
> output len is, what, ~180M which looks like plenty to me...

I think you might have misunderstood the thread. First, to reproduce the
bug that this patch fixes, you need a kernel with a compressed size of
around 16 megs, not 9. Secondly, that crash is well understood and
doesn't need to be reproduced; this patch fixes it. Rather, the question
now is how to improve this patch to remove the 62 meg limit. I'll follow
up with hpa's request for reproduction info.

Jason
