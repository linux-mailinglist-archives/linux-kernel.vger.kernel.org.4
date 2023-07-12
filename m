Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94B750D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjGLPyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGLPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:54:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F28A2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:54:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6689430d803so4058294b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689177245; x=1691769245;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENdFWLGX+AvB1bK16Fr9PBznhwFYP6hI+FTTAL1DdV8=;
        b=0/jJ62zVzIfwALA4eRjxinRTnh/WUikNk2zee5HN0Wi0PTj9bBLdpuDgWKgpbtHNgF
         /9NmaWoKkKs6y3YgpNQQvOpw3snzBTHfl/tUJhcmZ5tWEJ+KrPhL3w2PjBQUNyDeefCS
         JxHABTFsAtuqGNeOenWh19XcFxjk+djS2nIyjMKPRm6VWKBloW2BNv9E9jYAkvEQBahV
         u6sH3CehvS8tGzMJ6Kk2iHIcIgK7V/cQVg1Li5LjP62qDhd8VBt3dOxNdvA9cUnlpNec
         TAwgkZOotNNOmY2V5PSjdZJHbr2kJmB/juNVErlmlK4VSGCuWPY3Un7c6JSMzZIkC6U1
         qJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177245; x=1691769245;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENdFWLGX+AvB1bK16Fr9PBznhwFYP6hI+FTTAL1DdV8=;
        b=PWqv2u7oTQlrrEMGYdizSN5rKYQ30mNmZ/Ip1aeZrQNOMnDdMc7sBuWiT4gxTdbiAr
         D1SdFydtH5s9gBvzVtLv36LCgpLvcXguSr5LyBDpwKw9+V6Ni37PYU4bwq30Wka0YQps
         Sx40BWcO8KLxRimozibaiH/JWDZbwnvTHnsp1KbqfwYqkbr1v5khhK+eCJyZlUjCnz9S
         o2GWXz4ShqLNkgHVhGmxK1Imaxc98acSB8fmpBsdbr7nhH5x0oOn9aPKN7v4MPJkz/Hu
         VURYEcnMk6MWRj4N9qRlD69PeQMz5pd6nitkBBhJSpX6gPcOaEpARkHwB0e5np/BV6ub
         j4uA==
X-Gm-Message-State: ABy/qLZh7qCEAw3+fH2FOXDUrdCWwKpvNOcr1pPkBHXeFR76lz0AagTx
        YX0UJQzvIinzvPXVyOuKNxrriA==
X-Google-Smtp-Source: APBJJlHhaZBQFN1lImTkqj2V2kw6YUqtObcnav1KaqjNyu1xB33lnBAPhj2UEL91h7/Ka6qOCQc5Fw==
X-Received: by 2002:a05:6a00:1492:b0:680:40b2:5424 with SMTP id v18-20020a056a00149200b0068040b25424mr20292863pfu.23.1689177244772;
        Wed, 12 Jul 2023 08:54:04 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b006749c22d079sm3739070pff.167.2023.07.12.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:54:04 -0700 (PDT)
In-Reply-To: <20230710154328.19574-1-eric.lin@sifive.com>
References: <20230710154328.19574-1-eric.lin@sifive.com>
Subject: Re: [PATCH] perf: RISC-V: Remove PERF_HES_STOPPED flag checking in
 riscv_pmu_start()
Message-Id: <168917713751.21773.4886524771952268051.b4-ty@rivosinc.com>
Date:   Wed, 12 Jul 2023 08:52:17 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Lin <eric.lin@sifive.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Jul 2023 15:43:28 +0000, Eric Lin wrote:
> Since commit 096b52fd2bb4 ("perf: RISC-V: throttle perf events") the
> perf_sample_event_took() function was added to report time spent in
> overflow interrupts. If the interrupt takes too long, the perf framework
> will lower the sysctl_perf_event_sample_rate and max_samples_per_tick.
> When hwc->interrupts is larger than max_samples_per_tick, the
> hwc->interrupts will be set to MAX_INTERRUPTS, and events will be
> throttled within the __perf_event_account_interrupt() function.
> 
> [...]

Applied, thanks!

[1/1] perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()
      https://git.kernel.org/palmer/c/66843b14fb71

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

