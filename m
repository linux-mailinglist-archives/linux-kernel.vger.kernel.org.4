Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FBD659CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 23:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiL3WLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 17:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiL3WK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 17:10:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975F1928F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 14:10:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FAA61C2C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9B8C433D2;
        Fri, 30 Dec 2022 22:10:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cNfgAfr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672438254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANdsmCLGFl3adJKDrU26y3FV7jGPIEv2301jMP+DTIo=;
        b=cNfgAfr3kz1oYOh86w5HBs9adgDTpNYJBr0ji86TzPLguutgKoeaSjbR8pt7SGyr+6Isw9
        CHBQ3zQMQ9hqvA9YOJYQFFpOkxX8+2Cp+1f2VpPtqIocJIgzsqeyUWcq7OKG8D6ppRj2tW
        Z4KjB3jogZk0fuHiiBoKes7v7fP6e/s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eb1d6463 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Dec 2022 22:10:54 +0000 (UTC)
Date:   Fri, 30 Dec 2022 23:10:50 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y69h6ur79SMhu61F@zx2c4.com>
References: <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com>
 <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 01:58:39PM -0800, H. Peter Anvin wrote:
> See the other thread fork. They have identified the problem already.

Not sure I follow. Is there another thread where somebody worked out why
this 62meg limit was happening?

Note that I sent v2/v3, to fix the original problem in a different way,
and if that looks good to the QEMU maintainers, then we can all be happy
with that. But I *haven't* addressed and still don't fully understand
why the 62meg limit applied to my v1 in the way it does. Did you find a
bug there to fix? If so, please do CC me.

Jason
