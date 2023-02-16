Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BFC699FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjBPWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBPWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:14:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89F3B227
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:14:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C73DB8285B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9556C433D2;
        Thu, 16 Feb 2023 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676585675;
        bh=OgkLP7LObRG0ZbrcGDX3ekINH6RV/j319dT72sxlC0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbjsSgCQI/rHutHbfTkQxyp5aHEzOT1ha3mP53D5KBqBAxKIOp7sWGAvRRmFICNPV
         pBXzXMYSSJQ7FxikPiaorcFpqonfplCp3IZLdBL618CG77PMTS8nt7L/yFt0T6sCJt
         AIqls63lMzQ8vftNVa6TZZJ2S7ARTrRfvPwr/+CLE4kX0hrBG9m7eOxBtz9tsnDL4q
         lvfEAcequMaYUuDt09VvKX49BPVSnjc/or5CWghfTme8l3gCP0yMYqiZNj7umHdKwM
         tD0tRR9L57thMNeBciU5akqHAUxDfaz6tCyqd5HoDdAhlHYFj966YmOZjbgwk5JhO9
         OK/8emq0VlnUA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, peterz@infradead.org,
        ravi.bangoria@amd.com, j@jannau.net, ecurtin@redhat.com,
        lina@asahilina.net, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm_pmu: fix fallout from context handling rewrite
Date:   Thu, 16 Feb 2023 22:14:29 +0000
Message-Id: <167658263371.3504721.1571106036263387483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230216141240.3833272-1-mark.rutland@arm.com>
References: <20230216141240.3833272-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 14:12:37 +0000, Mark Rutland wrote:
> Janne reports [1] that perf has been broken on Apple M1 as of commit:
> 
>   bd27568117664b8b ("perf: Rewrite core context handling")
> 
> This is due to changes to pmu::filter_match() and
> arm_pmu::filter_match(), which have been renamed and had their polarity
> inverted, but the conversion was inconsistent, and so in some cases we
> return the opposite result relative to what we had intended. This
> results in consistently losing events on Apple M1.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm_pmu: fix event CPU filtering
      https://git.kernel.org/arm64/c/61d038627343
[2/2] arm64: perf: reject CHAIN events at creation time
      https://git.kernel.org/arm64/c/853e2dac25c1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
