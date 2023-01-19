Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7F672E16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjASB3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjASB21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:28:27 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F9539BB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:23:13 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Ny4d56k6mz9v4s;
        Thu, 19 Jan 2023 02:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1674091385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yTvl3bYC8lgaHjUY9ZdvsmW2CY6hrVGhvn4YRYR2XkU=;
        b=RmdiNpX0gEfj8DRafrxzTjUD+HRAlYa1jcr3i9DsdWaSIbqv2ix/hO6lo/wLvanvGqHWMv
        1mC6CzBSPqpAfZ0DaajSZwBXK38qXSNbqigrWMtropV18XAB2Li/d0rotGqSTawTmRTc1L
        Jy41uhdtsmkPwuxvApLfQGPIwe3PXABvgqt94YCqd+YqAOaAHr/UXkXq4IrP0EyRXlrXX5
        fu4/2rqQF5KQUXLfWyVgnv6szIqCw/PsLlbGDFJVNwJknrv7yX7aGHBVs8YN+ljsA5O1Nz
        /7/ikykTmqqIpqzNUMdQ1Ocf2i6k0XjO0Tv/0o5wFP3XXzS5mngaIzlOwQdqvw==
Date:   Thu, 19 Jan 2023 02:23:03 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     sandipan.das@amd.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: [bisected] clang 15 built kernel fails to boot, stuck at "Loading
 Linux 6.1.1 ...", gcc 12 built kernel with same config boots fine
Message-ID: <20230119022303.177052e4@yea>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ruy6j333za5rgdjxtmu7didokyopiyez
X-MBO-RS-ID: 58a2f9e79f68a331ec3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I did a kernel bisect for an issue I originally posted on https://github.com/ClangBuiltLinux/linux/issues/1774

It is about kernel 6.1.x not booting on my machines when built with clang. A gcc built kernel with the same config just works fine. Turns out kernel v6.2-rc4 and earlier v6.2-rc are still affected.

I did a kernel bisect which revealed this commit:

 # git bisect bad
706460a96fc654e80b6bed1f562b00d2ce9f2f4d is the first bad commit
commit 706460a96fc654e80b6bed1f562b00d2ce9f2f4d
Author: Sandipan Das <sandipan.das@amd.com>
Date:   Thu Aug 11 17:59:51 2022 +0530

    perf/x86/amd/core: Add generic branch record interfaces
    
    AMD processors that are capable of recording branches support either Branch
    Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
    Branch Record Extension Version 2 (LbrExtV2) support, introduce new static
    calls which act as gateways to call into the feature-dependent functions
    based on what is available on the processor.
    
    Signed-off-by: Sandipan Das <sandipan.das@amd.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lore.kernel.org/r/b75dbc32663cb395f0d701167e952c6a6b0445a3.1660211399.git.sandipan.das@amd.com

 arch/x86/events/amd/core.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)


For more details please have a look at https://github.com/ClangBuiltLinux/linux/issues/1774

Regards,
Erhard
