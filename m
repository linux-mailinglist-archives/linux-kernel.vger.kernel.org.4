Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B866E4C51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjDQPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDQPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BE7D8A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4505561FE3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67510C433EF;
        Mon, 17 Apr 2023 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681743793;
        bh=4zLCQQLPHhd9U3NrW2oybo5omrLbQqct9gaX3Vlktc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcXRN8NHKHZ4jUdOw5dLi+CZreHW/xr/v8W+UqOfapglOWdi/AtwGVP1O/Ke9uAy4
         Zx1uyqDUaH2/Zod+Xbj8K8mG/PxhFG2gTCateKkpMopCzvplpn5DYnrlJciNK+19XF
         oWcmfl9B+8C6bYMBnUcjs0w+UV6TkycsDYPXi/jSFONBZmNhwtEPjLUYgp41+Zm9kY
         MbO898F5MBsMUw6PLm9AvepfCN552xVL0hM1/eKGtlEl85Y7R6q0GELk/Czad8FXzq
         sPcNO7d1YX5sQAtZtlhsAukdrS8dKQ9rJuT997iMUN86FFednibqolw/y7i5bKk9fL
         ZEYxLLTvg/Fyg==
From:   Will Deacon <will@kernel.org>
To:     Junhao He <hejunhao3@huawei.com>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, yangyicong@huawei.com,
        shenyang39@huawei.com, f.fangjian@huawei.com, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, prime.zeng@hisilicon.com
Subject: Re: [PATCH 0/2]Fix NULL pointer and doing cleanup
Date:   Mon, 17 Apr 2023 16:03:03 +0100
Message-Id: <168173365122.3729437.735931240907393778.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230403081423.62460-1-hejunhao3@huawei.com>
References: <20230403081423.62460-1-hejunhao3@huawei.com>
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

On Mon, 3 Apr 2023 16:14:21 +0800, Junhao He wrote:
> Fix NULL pointer and cleanup redundant initialized.
> 
> Junhao He (2):
>   drivers/perf: hisi: Remove redundant initialized of pmu->name
>   drivers/perf: hisi: add NULL check for name
> 
> drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  |  2 +-
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 19 +++++++++++--------
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  9 ++++++---
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 13 ++++++-------
>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |  2 +-
>  drivers/perf/hisilicon/hisi_uncore_pmu.c      |  4 +---
>  drivers/perf/hisilicon/hisi_uncore_pmu.h      |  3 +--
>  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c |  2 +-
>  8 files changed, 28 insertions(+), 26 deletions(-)
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: hisi: Remove redundant initialized of pmu->name
      https://git.kernel.org/will/c/25d8c25025a4
[2/2] drivers/perf: hisi: add NULL check for name
      https://git.kernel.org/will/c/257aedb72e73

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
