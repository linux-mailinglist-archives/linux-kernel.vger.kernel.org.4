Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD971F88E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjFBClN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 22:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjFBClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:41:11 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38418D;
        Thu,  1 Jun 2023 19:41:10 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ba1815e12efso1465830276.3;
        Thu, 01 Jun 2023 19:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685673669; x=1688265669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVZyL/O31PWOCOA/BG7GrWW4VzwpPJxkkhP5MOBTY0I=;
        b=TV3P8nE7l8W7YyS259p9ZoAOl5Bmh5VEBeK6dFZEUVO9dw3zwXfKx7BDRV1NQyrKld
         8XdK9RTXrZ9Arqm4N+N44uwm9yVjrklD63/2nBOio6J0YC99wwo0GFmhWT+IumxrCvlG
         kaIJ5mJXQqec9Eo33xcqzei0RteYFCKgVS+yL/yc8VsgBlRUfXgRR2xGa8/sEMp5Nuw0
         GdvSrx8taqgR0Dno93womQKlEdJubeeOm95n3kBvf+ZtFNI95V9FNVIavmHLuBYMu7ou
         PDfAnEWlefvaF+f2oU4KySYnxAzgZ3GlqJuyvcCDhmANMuzR4Zy2+glr85hxzNuLjMgD
         iiDg==
X-Gm-Message-State: AC+VfDyIrX+RQYFrmbeB/9hEY/iefChpslyEHtZX7ldrL6Sb3I05A1o9
        QNwL3nKPo/EEl/Zcm4brsKGqOE0b+xwBGcdvAco=
X-Google-Smtp-Source: ACHHUZ6Y19sHUXPnAHUMH7OeXfOEz3N2O7lT+04ZG9ZYlsL6EOk62eVasjT19xblc3/8/TgpqXLOxsEIKM73GJVxiiY=
X-Received: by 2002:a25:a287:0:b0:ba6:a923:4744 with SMTP id
 c7-20020a25a287000000b00ba6a9234744mr1797524ybi.44.1685673669398; Thu, 01 Jun
 2023 19:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040428.501523-1-anshuman.khandual@arm.com> <20230531040428.501523-9-anshuman.khandual@arm.com>
In-Reply-To: <20230531040428.501523-9-anshuman.khandual@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 19:40:58 -0700
Message-ID: <CAM9d7cihqiUULBR7JoizDGySVYdOx3TH_CJV=QDpeck3p8z5wg@mail.gmail.com>
Subject: Re: [PATCH V11 08/10] arm64/perf: Add struct brbe_regset helper functions
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

On Tue, May 30, 2023 at 9:15 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> The primary abstraction level for fetching branch records from BRBE HW has
> been changed as 'struct brbe_regset', which contains storage for all three
> BRBE registers i.e BRBSRC, BRBTGT, BRBINF. Whether branch record processing
> happens in the task sched out path, or in the PMU IRQ handling path, these
> registers need to be extracted from the HW. Afterwards both live and stored
> sets need to be stitched together to create final branch records set. This
> adds required helper functions for such operations.
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
> +
> +static inline void copy_brbe_regset(struct brbe_regset *src, int src_idx,
> +                                   struct brbe_regset *dst, int dst_idx)
> +{
> +       dst[dst_idx].brbinf = src[src_idx].brbinf;
> +       dst[dst_idx].brbsrc = src[src_idx].brbsrc;
> +       dst[dst_idx].brbtgt = src[src_idx].brbtgt;
> +}
> +
> +/*
> + * This function concatenates branch records from stored and live buffer
> + * up to maximum nr_max records and the stored buffer holds the resultant
> + * buffer. The concatenated buffer contains all the branch records from
> + * the live buffer but might contain some from stored buffer considering
> + * the maximum combined length does not exceed 'nr_max'.
> + *
> + *     Stored records  Live records
> + *     ------------------------------------------------^
> + *     |       S0      |       L0      |       Newest  |
> + *     ---------------------------------               |
> + *     |       S1      |       L1      |               |
> + *     ---------------------------------               |
> + *     |       S2      |       L2      |               |
> + *     ---------------------------------               |
> + *     |       S3      |       L3      |               |
> + *     ---------------------------------               |
> + *     |       S4      |       L4      |               nr_max
> + *     ---------------------------------               |
> + *     |               |       L5      |               |
> + *     ---------------------------------               |
> + *     |               |       L6      |               |
> + *     ---------------------------------               |
> + *     |               |       L7      |               |
> + *     ---------------------------------               |
> + *     |               |               |               |
> + *     ---------------------------------               |
> + *     |               |               |       Oldest  |
> + *     ------------------------------------------------V
> + *
> + *
> + * S0 is the newest in the stored records, where as L7 is the oldest in
> + * the live reocords. Unless the live buffer is detetcted as being full
> + * thus potentially dropping off some older records, L7 and S0 records
> + * are contiguous in time for a user task context. The stitched buffer
> + * here represents maximum possible branch records, contiguous in time.
> + *
> + *     Stored records  Live records
> + *     ------------------------------------------------^
> + *     |       L0      |       L0      |       Newest  |
> + *     ---------------------------------               |
> + *     |       L0      |       L1      |               |
> + *     ---------------------------------               |
> + *     |       L2      |       L2      |               |
> + *     ---------------------------------               |
> + *     |       L3      |       L3      |               |
> + *     ---------------------------------               |
> + *     |       L4      |       L4      |             nr_max
> + *     ---------------------------------               |
> + *     |       L5      |       L5      |               |
> + *     ---------------------------------               |
> + *     |       L6      |       L6      |               |
> + *     ---------------------------------               |
> + *     |       L7      |       L7      |               |
> + *     ---------------------------------               |
> + *     |       S0      |               |               |
> + *     ---------------------------------               |
> + *     |       S1      |               |    Oldest     |
> + *     ------------------------------------------------V
> + *     |       S2      | <----|
> + *     -----------------      |
> + *     |       S3      | <----| Dropped off after nr_max
> + *     -----------------      |
> + *     |       S4      | <----|
> + *     -----------------
> + */
> +static int stitch_stored_live_entries(struct brbe_regset *stored,
> +                                     struct brbe_regset *live,
> +                                     int nr_stored, int nr_live,
> +                                     int nr_max)
> +{
> +       int nr_total, nr_excess, nr_last, i;
> +
> +       nr_total = nr_stored + nr_live;
> +       nr_excess = nr_total - nr_max;
> +
> +       /* Stored branch records in stitched buffer */
> +       if (nr_live == nr_max)
> +               nr_stored = 0;
> +       else if (nr_excess > 0)
> +               nr_stored -= nr_excess;
> +
> +       /* Stitched buffer branch records length */
> +       if (nr_total > nr_max)
> +               nr_last = nr_max;
> +       else
> +               nr_last = nr_total;
> +
> +       /* Move stored branch records */
> +       for (i = 0; i < nr_stored; i++)
> +               copy_brbe_regset(stored, i, stored, nr_last - nr_stored - 1 + i);

I'm afraid it can overwrite some entries if nr_live is small
and nr_stored is big.  Why not use memmove()?

Also I think it'd be simpler if you copy store to live.
It'll save copying live in the IRQ but it will copy the
whole content to store again for the sched switch.

Thanks,
Namhyung


> +
> +       /* Copy live branch records */
> +       for (i = 0; i < nr_live; i++)
> +               copy_brbe_regset(live, i, stored, i);
> +
> +       return nr_last;
> +}
> +
>  /*
>   * Generic perf branch filters supported on BRBE
>   *
> --
> 2.25.1
>
