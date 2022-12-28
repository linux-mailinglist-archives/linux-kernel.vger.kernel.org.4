Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243176584F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiL1REL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiL1RDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:03:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1792B1929A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:58:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A945B61562
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479BC433F1;
        Wed, 28 Dec 2022 16:58:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f9G1NL6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672246678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/TBVDGYdRlG5U31yqV7pynGEXacXzLmZlTrofPWf0ws=;
        b=f9G1NL6Pa1K0WeUCjN7cMRJECqjZIM1uJkStKJn7z//z/h+IKVbcjv0PFYqXkrpvLYMlc4
        MFiI9xta0v+DDtKg8n5Sv6wxgOGVNuYZQdXb9mH6TmB6+/ffQxgoZ2nwbKqFCnBpJ5YZss
        2bhQJzstgm+VLqf3A2Muu+bd7kZKoVw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 46f0ad33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 28 Dec 2022 16:57:58 +0000 (UTC)
Date:   Wed, 28 Dec 2022 17:57:54 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     hpa@zytor.com
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y6x1knb8udpSyMSp@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6xvJheSYC83voCZ@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HELLO H. PETER ANVIN,
E
L
L
O

On Wed, Dec 28, 2022 at 05:30:30PM +0100, Jason A. Donenfeld wrote:
> > Fix looks good, glad you figured out the problem.
> 
> I mean, kind of. The solution here sucks, especially given that in the
> worst case, setup_data just gets dropped. I'm half inclined to consider
> this a kernel bug instead, and add some code to relocate setup_data
> prior to decompression, and then fix up all the links. It seems like
> this would be a lot more robust.
> 
> I just wish the people who wrote this stuff would chime in. I've had
> x86@kernel.org CC'd but so far, no input from them.

Apparently you are the x86 boot guru. What do you want to happen here?
Your input would be very instrumental.

Jason
