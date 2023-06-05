Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B610C722CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjFEQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFEQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E871CD;
        Mon,  5 Jun 2023 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B7C96139D;
        Mon,  5 Jun 2023 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4E6C433A8;
        Mon,  5 Jun 2023 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685982917;
        bh=hyLqcZ6pOY8sxQnXV1QbLzvX42WT38l/ZT38FiyIQDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTQrtoy7M6xNugBYnObcI+DjQAlS6WXzEUznVNjt3MvEuiFrizOMaBTSGjhvrrv+2
         XNLi6B5u7aXkw2BkV+W4eJyNqX2bnfmSkgeRH1QndY8MiHqfCRPxaK1G9Y0XdLlOVs
         dA5aCBdOmlGeuwr3zmOa3lKkh8as5pLpQ1ZzYWP2I8WsOeYS5qE4QSNS0SqvuyGpxN
         Ra0vjjNmbaRaeaEo1sh36R/Q+JhnkAjWmNs4luPmVG0RqddTsHt/kbO0SDAjwvdtVq
         JNbNDRyETewk4DyPOgd0hUpEu95dkTKL9lObVm06G1SfuWtv1zmDh09AV00uDdlh9b
         L8oWXxDIQs7xA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cci: Slightly optimize cci_pmu_sync_counters()
Date:   Mon,  5 Jun 2023 17:35:02 +0100
Message-Id: <168597318508.3035025.8084369387360495178.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <88d4e20d595f771396e9d558c1587eb4494057db.1682022422.git.christophe.jaillet@wanadoo.fr>
References: <88d4e20d595f771396e9d558c1587eb4494057db.1682022422.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 22:27:24 +0200, Christophe JAILLET wrote:
> When the 'mask' bitmap is cleared, it is better to use its full maximum
> size instead of only the needed size.
> This lets the compiler optimize it because the size is now known at compile
> time. HW_CNTRS_MAX is small (i.e. currently 9), so a call to memset() is
> saved.
> 
> Also, as 'mask' is local to the function, the non-atomic __set_bit() can
> also safely be used here.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cci: Slightly optimize cci_pmu_sync_counters()
      https://git.kernel.org/will/c/f818947a0618

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
