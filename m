Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED865A437
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiLaMzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 07:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLaMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:55:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1464FD
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:55:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A07ADB80759
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 12:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB69C433EF;
        Sat, 31 Dec 2022 12:54:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DkUn8CJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672491297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7/PSeae4emuwI8+qvT80CZJIbxy+A9eTBLm8a0VJcc=;
        b=DkUn8CJZuGF2WlUWlRRQ6xrmk4cBTb0n1YKAlWgk5zVMnNPVFeKyFXYfaA9kV4qaepWunX
        A1XVU/5J/kLHds4iLja+2GZRwLbzsozbAVMcPPliZzAWOvBHymFRNaWkYbqMc9ub4/V9FY
        8i7XsYEPfDBm3x7o3MITAbeFYIJBKao=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 249602d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 31 Dec 2022 12:54:57 +0000 (UTC)
Date:   Sat, 31 Dec 2022 13:54:50 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7AxGiGQYZNJWpCr@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y68K4mPuz6edQkCX@zx2c4.com>
 <Y7AFYKWPRXYs7S4m@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7AFYKWPRXYs7S4m@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 10:48:16AM +0100, Borislav Petkov wrote:
> On Fri, Dec 30, 2022 at 04:59:30PM +0100, Jason A. Donenfeld wrote:
> > I'll attach a .config file. Apply the patch at the top of this thread to
> > qemu,
> 
> Hmm, so the patch at the top of this thread is fixing the clobbering of
> setup_data.
> 
> But I tried latest qemu with your .config and it boots ok here. So how do I
> repro the original issue you're trying to fix?

Nothing special... `-kernel bzImage` should be enough to do it. Eric
reported it, and then I was able to repro trivially. Sure you got the
right version?

Jason
