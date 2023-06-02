Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5F71F823
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjFBBpW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjFBBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:45:14 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E819A;
        Thu,  1 Jun 2023 18:45:13 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ba829e17aacso1656162276.0;
        Thu, 01 Jun 2023 18:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685670312; x=1688262312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9MJQkBhtwwKWv5RYg7/ssZ/hoTZuhiN+qGeOfkLWAQ=;
        b=RLRaOIml2mn9su/HRawc1CqNw5odiQOFuZmMWJStMJlQ+a8rjLpW1P48WpTh47L6Q2
         0Ctghl7yBKakag6Y/upYZZ3uQ+cXM87uaRXQHQC9OfGhhNWABklhYT8/ZoG9V0cW7X8Z
         //m1OE0n+qftvelIKt50jFlJxVqDxShhkuz3X6jpOTncZ9F2VYD+hE55m/+LLBh9nagx
         eSwW2sXxpfgZ6XuuP9O3EXPaMYMyDBVWS2PoAe3elLVN/6ZX49f58D/5lnmYSpTLFqm9
         Isu4Qy3l4e6i8oBmM3SQP3Ut59OgIfnK/N17jhJbBfQMfxjY0/4Q+FCPjhDBVc422PXN
         X6nQ==
X-Gm-Message-State: AC+VfDxQ5ZVovHV4iFRfwLZrvUQzkJ9Ykul2vPd/nhOuhDDYfPBHuftn
        +gL2dph8NtYEK1sZInIQndcw80WCi66LGlPVFeNnmfjA
X-Google-Smtp-Source: ACHHUZ4A+tgKfJzI54aXqcM8nK42xCurnWJ5rTaeKC7IhFVyPV0klo0TQmsqoYAt025oapu7mgNsPz14d/XbC7g4LaM=
X-Received: by 2002:a25:507:0:b0:bad:347:cbdf with SMTP id 7-20020a250507000000b00bad0347cbdfmr1514782ybf.65.1685670311958;
 Thu, 01 Jun 2023 18:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040428.501523-1-anshuman.khandual@arm.com> <20230531040428.501523-7-anshuman.khandual@arm.com>
In-Reply-To: <20230531040428.501523-7-anshuman.khandual@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 18:45:00 -0700
Message-ID: <CAM9d7cgvXwsoZqC8tG=X-rkCWEAeQVdyBFTMjMZg8EiX5Y=5Ew@mail.gmail.com>
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via FEAT_BRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 30, 2023 at 9:21 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This enables branch stack sampling events in ARMV8 PMU, via an architecture
> feature FEAT_BRBE aka branch record buffer extension. This defines required
> branch helper functions pmuv8pmu_branch_XXXXX() and the implementation here
> is wrapped with a new config option CONFIG_ARM64_BRBE.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

[SNIP]
> +void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +       struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
> +       u64 brbfcr, brbcr;
> +       int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
> +
> +       brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> +       brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +
> +       /* Ensure pause on PMU interrupt is enabled */
> +       WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
> +
> +       /* Pause the buffer */
> +       write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +       isb();
> +
> +       /* Determine the indices for each loop */
> +       loop1_idx1 = BRBE_BANK0_IDX_MIN;
> +       if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
> +               loop1_idx2 = brbe_attr->brbe_nr - 1;
> +               loop2_idx1 = BRBE_BANK1_IDX_MIN;
> +               loop2_idx2 = BRBE_BANK0_IDX_MAX;

Is this to disable the bank1?  Maybe need a comment.


> +       } else {
> +               loop1_idx2 = BRBE_BANK0_IDX_MAX;
> +               loop2_idx1 = BRBE_BANK1_IDX_MIN;
> +               loop2_idx2 = brbe_attr->brbe_nr - 1;
> +       }

The loop2_idx1 is the same for both cases.  Maybe better
to move it out of the if statement.

Thanks,
Namhyung


> +
> +       /* Loop through bank 0 */
> +       select_brbe_bank(BRBE_BANK_IDX_0);
> +       for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
> +               if (!capture_branch_entry(cpuc, event, idx))
> +                       goto skip_bank_1;
> +       }
> +
> +       /* Loop through bank 1 */
> +       select_brbe_bank(BRBE_BANK_IDX_1);
> +       for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
> +               if (!capture_branch_entry(cpuc, event, idx))
> +                       break;
> +       }
> +
> +skip_bank_1:
> +       cpuc->branches->branch_stack.nr = idx;
> +       cpuc->branches->branch_stack.hw_idx = -1ULL;
> +       process_branch_aborts(cpuc);
> +
> +       /* Unpause the buffer */
> +       write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +       isb();
> +       armv8pmu_branch_reset();
> +}
