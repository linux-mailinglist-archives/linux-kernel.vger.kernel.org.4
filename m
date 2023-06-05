Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE36722CBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjFEQf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjFEQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012594;
        Mon,  5 Jun 2023 09:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DFF62395;
        Mon,  5 Jun 2023 16:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31B9C4339C;
        Mon,  5 Jun 2023 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685982920;
        bh=PGCW96JiQOoQ+srOEeKWAWw1o+ime25VSyyUsDf6T7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFfMJmoqJHMfuhevocY5Ej1nQyRqHICePni5FK6+IHXSNHZ9fs9HA1c41WKGYQCHL
         yfvMilAtCuW+uAqHrwbXR/5dyPcde50kNAodtMGSiaBMKfIyv4Ic0nG8PY0zTejLVt
         OWCUiDE3oae0r6848b4NhceZ52JL1uGUju1fIduWXGbh/HDvqVs2RxxsngGKL0WRDk
         8qw+Kox7t++ToevORZBue5QAjBpxzzFjG7ajCKDl3OSG1mc5rMvAkw3Czy6uftDWKF
         mD5+0MJ0NBQuGG+zril0338ZUhxdA/gBGs10CFHGhZb/2MgOJFtg6plauFcfCROGew
         rFM7ltNJr+cDA==
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Leeder <nleeder@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: qcom_l2_pmu: Make l2_cache_pmu_probe_cluster() more robust
Date:   Mon,  5 Jun 2023 17:35:03 +0100
Message-Id: <168597368753.3035523.1877159803159338194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <6a0f5bdb6b7b2ed4ef194fc49693e902ad5b95ea.1684397879.git.christophe.jaillet@wanadoo.fr>
References: <6a0f5bdb6b7b2ed4ef194fc49693e902ad5b95ea.1684397879.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 10:18:08 +0200, Christophe JAILLET wrote:
> If an error occurs after calling list_add(), the &l2cache_pmu->clusters
> list will reference some memory that will be freed when the managed
> resources will be released.
> 
> Move the list_add() at the end of the function when everything is in fine.
> 
> This is harmless because if l2_cache_pmu_probe_cluster() fails, then
> l2_cache_pmu_probe() will fail as well and 'l2cache_pmu' will be released
> as well.
> But it looks cleaner and could silence static checker warning.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: qcom_l2_pmu: Make l2_cache_pmu_probe_cluster() more robust
      https://git.kernel.org/will/c/7bd42f122c7c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
