Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7350646FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiLHMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:30:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A4303FC;
        Thu,  8 Dec 2022 04:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95D1761F0A;
        Thu,  8 Dec 2022 12:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10221C433C1;
        Thu,  8 Dec 2022 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670502613;
        bh=vuyR8NSZXgKNwfmsYoMv4Ol+ici2HnAMRbBD2K6WyGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Twma8AYQ06LUktSgKmq71rkrveB+1CUCh9pDKVdsZGc543B9CJHs7cHmyyyLzeKC/
         eKR5Bs7pQ2t49ZXvntQpsXNQFEMIFTlSduIq7VVzNhldG6uG+Y74gSLUm1Lv4kC8SJ
         tiD7E8VomIU384oLv8pTZGpoJ+3ptYH0z3Q7i7+RZFVOGWQDGc/7eZAfVzlPtCwJjr
         J0j2Yyvu4sH8O1M/R15XSQS4aScmrpZrqT2SOSthasErjuKtrnUIRPMeHhboJ4yKxJ
         Bsr/y9PorPjqN8tY9eod5rU1W5W+0NiQiXKRdCakYWNCabDSEBJnbn2Rl0CjnwONE8
         MxBxBfIE996Gg==
Date:   Thu, 8 Dec 2022 12:30:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: qcom_rpm: Fix an error handling path in
 qcom_rpm_probe()
Message-ID: <Y5HYzzwdWCrpWOTv@google.com>
References: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022, Christophe JAILLET wrote:

> If an error occurs after the clk_prepare_enable() call, a corresponding
> clk_disable_unprepare() should be called.
> 
> Simplify code and switch to devm_clk_get_enabled() to fix it.
> 
> Fixes: 3526403353c2 ("mfd: qcom_rpm: Handle message RAM clock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of the clean-ups if the .remove() function is called
> but it looks fine to me.
> ---
>  drivers/mfd/qcom_rpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Something funny going on here.

I received 3 identical versions of the same patch.

-- 
Lee Jones [李琼斯]
