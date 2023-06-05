Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80ED7233C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFEXt3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFEXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:49:27 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B6CEC;
        Mon,  5 Jun 2023 16:49:26 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bad102ce9eeso6052893276.0;
        Mon, 05 Jun 2023 16:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686008965; x=1688600965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yY5d/V8MfrMaTZ9YnTPCdi3pO6uRZ4QgR85u/BK5vQ8=;
        b=IJx6+gdTbz1Va3yGo3fNO5DinNs9XWr6SR7m63cid3lS1BmYpivzyF4B0+ljd9CGwd
         0rUfXcY3YAKNplQgyrYH7RGzSAQrgW8mYudiTcHksWQvSQgodhJqK73el5XirQwBYYiA
         mBY/5m+tud1v/dffbpzlaO955VzTSiZ5CJx8Phnz9BanHgkHdbqc7lOwyVWdUrre8Z2I
         bQJET0JWLxieYItPeGVo5GRChD/G+PUIx7jkru8Pjrlne7cepciH+TllrQfhQnZ5Yny3
         bWQH7an3vFFz3sGEsDB5MJGxm+ZjApLKtfZd5XRZVrpeXml+HGzaGaKntYr4ETxf88Xo
         C2sg==
X-Gm-Message-State: AC+VfDyQedfNZYIuzdg/lL96FMIftJYCTcCR4MmiqWL0RibOvB3Q+GHT
        +J+XmhgLuP5F7t1H8E1Jxop5lwj3Qx2r5vTyu14=
X-Google-Smtp-Source: ACHHUZ5QaBOM4jsq5PEqc+/gCqzu8a1Q/qltI0rnQ+ttL7pR9eKQSKtoJ6nRtwz4F+mrKQTHdILvU/ZdO4r9Gpd4Muc=
X-Received: by 2002:a25:2fd7:0:b0:bad:74d:f9ed with SMTP id
 v206-20020a252fd7000000b00bad074df9edmr156488ybv.2.1686008965638; Mon, 05 Jun
 2023 16:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-9-anshuman.khandual@arm.com> <CAM9d7cihqiUULBR7JoizDGySVYdOx3TH_CJV=QDpeck3p8z5wg@mail.gmail.com>
 <a11beb49-7b4f-08f0-b1e2-782a0ba973ea@arm.com>
In-Reply-To: <a11beb49-7b4f-08f0-b1e2-782a0ba973ea@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 5 Jun 2023 16:49:14 -0700
Message-ID: <CAM9d7cgzEJgNWvXn32cj82GaAvn3CPhE1PyLr+FtFfrauj0X6g@mail.gmail.com>
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

On Sun, Jun 4, 2023 at 8:15 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 6/2/23 08:10, Namhyung Kim wrote:
> > On Tue, May 30, 2023 at 9:15 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> The primary abstraction level for fetching branch records from BRBE HW has
> >> been changed as 'struct brbe_regset', which contains storage for all three
> >> BRBE registers i.e BRBSRC, BRBTGT, BRBINF. Whether branch record processing
> >> happens in the task sched out path, or in the PMU IRQ handling path, these
> >> registers need to be extracted from the HW. Afterwards both live and stored
> >> sets need to be stitched together to create final branch records set. This
> >> adds required helper functions for such operations.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Tested-by: James Clark <james.clark@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >
> > [SNIP]
> >> +
> >> +static inline void copy_brbe_regset(struct brbe_regset *src, int src_idx,
> >> +                                   struct brbe_regset *dst, int dst_idx)
> >> +{
> >> +       dst[dst_idx].brbinf = src[src_idx].brbinf;
> >> +       dst[dst_idx].brbsrc = src[src_idx].brbsrc;
> >> +       dst[dst_idx].brbtgt = src[src_idx].brbtgt;
> >> +}
> >> +
> >> +/*
> >> + * This function concatenates branch records from stored and live buffer
> >> + * up to maximum nr_max records and the stored buffer holds the resultant
> >> + * buffer. The concatenated buffer contains all the branch records from
> >> + * the live buffer but might contain some from stored buffer considering
> >> + * the maximum combined length does not exceed 'nr_max'.
> >> + *
> >> + *     Stored records  Live records
> >> + *     ------------------------------------------------^
> >> + *     |       S0      |       L0      |       Newest  |
> >> + *     ---------------------------------               |
> >> + *     |       S1      |       L1      |               |
> >> + *     ---------------------------------               |
> >> + *     |       S2      |       L2      |               |
> >> + *     ---------------------------------               |
> >> + *     |       S3      |       L3      |               |
> >> + *     ---------------------------------               |
> >> + *     |       S4      |       L4      |               nr_max
> >> + *     ---------------------------------               |
> >> + *     |               |       L5      |               |
> >> + *     ---------------------------------               |
> >> + *     |               |       L6      |               |
> >> + *     ---------------------------------               |
> >> + *     |               |       L7      |               |
> >> + *     ---------------------------------               |
> >> + *     |               |               |               |
> >> + *     ---------------------------------               |
> >> + *     |               |               |       Oldest  |
> >> + *     ------------------------------------------------V
> >> + *
> >> + *
> >> + * S0 is the newest in the stored records, where as L7 is the oldest in
> >> + * the live reocords. Unless the live buffer is detetcted as being full
> >> + * thus potentially dropping off some older records, L7 and S0 records
> >> + * are contiguous in time for a user task context. The stitched buffer
> >> + * here represents maximum possible branch records, contiguous in time.
> >> + *
> >> + *     Stored records  Live records
> >> + *     ------------------------------------------------^
> >> + *     |       L0      |       L0      |       Newest  |
> >> + *     ---------------------------------               |
> >> + *     |       L0      |       L1      |               |
> >> + *     ---------------------------------               |
> >> + *     |       L2      |       L2      |               |
> >> + *     ---------------------------------               |
> >> + *     |       L3      |       L3      |               |
> >> + *     ---------------------------------               |
> >> + *     |       L4      |       L4      |             nr_max
> >> + *     ---------------------------------               |
> >> + *     |       L5      |       L5      |               |
> >> + *     ---------------------------------               |
> >> + *     |       L6      |       L6      |               |
> >> + *     ---------------------------------               |
> >> + *     |       L7      |       L7      |               |
> >> + *     ---------------------------------               |
> >> + *     |       S0      |               |               |
> >> + *     ---------------------------------               |
> >> + *     |       S1      |               |    Oldest     |
> >> + *     ------------------------------------------------V
> >> + *     |       S2      | <----|
> >> + *     -----------------      |
> >> + *     |       S3      | <----| Dropped off after nr_max
> >> + *     -----------------      |
> >> + *     |       S4      | <----|
> >> + *     -----------------
> >> + */
> >> +static int stitch_stored_live_entries(struct brbe_regset *stored,
> >> +                                     struct brbe_regset *live,
> >> +                                     int nr_stored, int nr_live,
> >> +                                     int nr_max)
> >> +{
> >> +       int nr_total, nr_excess, nr_last, i;
> >> +
> >> +       nr_total = nr_stored + nr_live;
> >> +       nr_excess = nr_total - nr_max;
> >> +
> >> +       /* Stored branch records in stitched buffer */
> >> +       if (nr_live == nr_max)
> >> +               nr_stored = 0;
> >> +       else if (nr_excess > 0)
> >> +               nr_stored -= nr_excess;
> >> +
> >> +       /* Stitched buffer branch records length */
> >> +       if (nr_total > nr_max)
> >> +               nr_last = nr_max;
> >> +       else
> >> +               nr_last = nr_total;
> >> +
> >> +       /* Move stored branch records */
> >> +       for (i = 0; i < nr_stored; i++)
> >> +               copy_brbe_regset(stored, i, stored, nr_last - nr_stored - 1 + i);
> >
> > I'm afraid it can overwrite some entries if nr_live is small
> > and nr_stored is big.  Why not use memmove()?
>
> nr_stored is first adjusted with nr_excess if both live and stored entries combined
> exceed the maximum branch records in the HW. I am wondering how it can override ?

Say nr_stored = 40 and nr_live = 20, wouldn't it copy stored[0] to stored[20]?
Then stored[20:39] will be lost.  Also I'm not sure "-1" is correct.

>
> >
> > Also I think it'd be simpler if you copy store to live.
> > It'll save copying live in the IRQ but it will copy the
> > whole content to store again for the sched switch.
>
> But how that is better than the current scheme ?

I guess normally the live buffer is full, then it can skip
the copy and use the buffer directly for IRQ, right?

Thanks,
Namhyung
