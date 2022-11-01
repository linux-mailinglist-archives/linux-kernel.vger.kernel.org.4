Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94772614C35
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKAOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKAOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EBA1A835
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A14B81D9F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2B0C433D6;
        Tue,  1 Nov 2022 14:05:54 +0000 (UTC)
Date:   Tue, 1 Nov 2022 14:05:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5] random: remove early archrandom abstraction
Message-ID: <Y2Env04RIXEpNstS@arm.com>
References: <20221101115616.232884-1-Jason@zx2c4.com>
 <20221101122527.323843-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101122527.323843-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:25:28PM +0100, Jason A. Donenfeld wrote:
> The arch_get_random*_early() abstraction is not completely useful and
> adds complexity, because it's not a given that there will be no calls to
> arch_get_random*() between random_init_early(), which uses
> arch_get_random*_early(), and init_cpu_features(). During that gap,
> crng_reseed() might be called, which uses arch_get_random*(), since it's
> mostly not init code.
> 
> Instead we can test whether we're in the early phase in
> arch_get_random*() itself, and in doing so avoid all ambiguity about
> where we are. Fortunately, the only architecture that currently
> implements arch_get_random*_early() also has an alternatives-based cpu
> feature system, one flag of which determines whether the other flags
> have been initialized. This makes it possible to do the early check with
> zero cost once the system is initialized.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
