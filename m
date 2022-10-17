Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE0601641
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJQS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJQS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:27:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969E74DF6;
        Mon, 17 Oct 2022 11:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E040B819F9;
        Mon, 17 Oct 2022 18:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF08C433D6;
        Mon, 17 Oct 2022 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666031239;
        bh=ie+LBfbPtybq5ABwS/hbUDwehgR4IFlNsMhlYBK5YDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKAmrJ3endzmAGguVtBA0NlTsvoqP/bPZIM3bd02KdzRzMroPWx42wFytJPiSMT8O
         mZFbbHjlU4txnX8/0xDp3ZqQBKz+Z3htlTQt1PXbEDNtBscLoaWFtL0ZoKJTcbjQQz
         5Hugq59GDvxOfhhZ7Q24UthHL8DMykepIpHcFi9L91cAzHM+twA4onQoTEHS2ikFWu
         pPPCupaQnkgxoapJ0SBaP880nMoj16R8KFUTbDFp36IFDNWc21uapCHywjwOhCifrr
         9Kv1RPvwdmcBY6vlNOaIrlduo1g4EnkERxKKMzEnfaU3MYHOkNKFQTLVedX4QA48E7
         JIgxvOrU9mE0Q==
Date:   Mon, 17 Oct 2022 11:27:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        sneves@dei.uc.pt
Subject: Re: [PATCH] random: use rejection sampling for uniform bounded
 random integers
Message-ID: <Y02ehdiCtHyLErB8@sol.localdomain>
References: <20221017023752.3907-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017023752.3907-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 08:37:53PM -0600, Jason A. Donenfeld wrote:
> In order to be efficient, we implement a kernel-specific variant of
> Daniel Lemire's algorithm from "Fast Random Integer Generation in an
> Interval", linked below. The kernel's variant takes advantage of
> constant folding to avoid divisions entirely in the vast majority of
> cases, works on both 32-bit and 64-bit architectures, and requests a
> minimal amount of bytes from the RNG.
> 
> Link: https://arxiv.org/pdf/1805.10941.pdf

Thanks for doing this!  Your code looks correct, but it was hard for me to
understand until I read the paper that is linked to.  Could you include a brief
comment in the code that explains the algorithm?  Also, though the code looks
correct, I assume that you've also explicitly tested that each of the four code
paths produce uniform random numbers as intended?

- Eric
