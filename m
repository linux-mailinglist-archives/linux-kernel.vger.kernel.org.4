Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52574B904
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGGV6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjGGV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:58:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E6213D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:58:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c5e67d75e0cso2631727276.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688767094; x=1691359094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urIvIMoYHR6wFIwBX4+MGbcbTxdcdrDtNJHB7IMO87E=;
        b=LzoJ48zhQ01CEQcGZQgcWyFBP2tt4XI/gDQzFMqhrmUWH6IZeqBr+xxsG4aJjf8JEs
         Cr1OziFQ0fplCqTgPiUF4PS6BCVN5Y7JYJkiI5yL2UQEAJyUY8sJirG5DzWfcgSz+FJR
         ZfsHZG7gisqF59/YmUNdWD9kvFrYn1CKTWRIsO1jT4KYLLdE46JCyANNif5tyP/09p6E
         0R5wUAmKSKsMRd8q4QXcQmFVKCxIp1YyPkaRniUbuLuS9YgRC5ZQwvWg2uTFvt8rQo3p
         af6VVxZT0HF92GXqfPMRZiqT0ouNxurol7mrLGzX7Z9qRb1xYWDVPzR545lQDtGBTrNQ
         w8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688767094; x=1691359094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urIvIMoYHR6wFIwBX4+MGbcbTxdcdrDtNJHB7IMO87E=;
        b=JwGHvWU7jgPihhV3zu+DFumr5UmZFMbsJ/p6tGGbm3hGmF07drVLSFNZ/eim7CdOtw
         g4/dkcrYDzgJ+y6PMVdVj56fod335sNrE0F6hRbZBP1KFO8aLiCL2ZG6L0OUUru6g5aB
         wsdd2YMNKsIjxFTU3Fd731OjMSsuSurL0NtjfE7MBNhPPwCA5HxibPyByDM3me1jKFEB
         WWewx/0CoA5Xmxo6NVeWFqv2BNES0kH8oRP1NfOMxG0j/QTyjIki412NYNaNkhUAnFLE
         KyfiJGjSmMsn3XIGgU1w1mpkyIPzP9sQQ6z9dI6qpMcgzeQqMxWFJBrkCjCu9JMEuuKC
         80Vg==
X-Gm-Message-State: ABy/qLa14mnQbcsC8g+Dr4MpCT1Xh1BN8H7bntaggrv83CsyYy+QZq7B
        f3cILU5DmKaMNV/KtndjQUfvWaB3i+1fxUg2V8t2uA==
X-Google-Smtp-Source: APBJJlEZ0aMW1BynuZY1nBJ104lyyGw5RKn8yW+B+2efS9x6d0pBfqski96kniXhXoHcmqrJCpb/RXTj+uLYfd7aszU=
X-Received: by 2002:a25:41c8:0:b0:c61:daee:2c8e with SMTP id
 o191-20020a2541c8000000b00c61daee2c8emr4839504yba.63.1688767094263; Fri, 07
 Jul 2023 14:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230622-devcoredump_patch-v4-0-e304ddbe9648@quicinc.com>
 <20230622-devcoredump_patch-v4-6-e304ddbe9648@quicinc.com>
 <0493c891-9cde-8284-a988-b6e95135db85@linaro.org> <ee853769-d1ba-5189-1afd-62731c62966c@quicinc.com>
In-Reply-To: <ee853769-d1ba-5189-1afd-62731c62966c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 8 Jul 2023 00:58:03 +0300
Message-ID: <CAA8EJprRtR1obKOOhHN1FAKs9O0na=ZjFBqrphaZ4vW92mSnUQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] drm/msm/dpu: Update dev core dump to dump
 registers of sub-blocks
To:     Ryan McCann <quic_rmccann@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        quic_jesszhan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 23:49, Ryan McCann <quic_rmccann@quicinc.com> wrote:
>
> My apologies for the private email, I hit reply instead of reply all by
> accident.

No problem, it happens sometimes.

>
> On 7/6/2023 5:24 PM, Dmitry Baryshkov wrote:
> > On 06/07/2023 23:48, Ryan McCann wrote:
> >> Currently, the device core dump mechanism does not dump registers of
> >> sub-blocks within the DSPP, SSPP, DSC, and PINGPONG blocks. Edit
> >> dpu_kms_mdp_snapshot function to account for sub-blocks.
> >>
> >> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 66
> >> ++++++++++++++++++++++++++++++---
> >>   1 file changed, 60 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> index 70dbb1204e6c..afc45d597d65 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> >> @@ -903,25 +903,58 @@ static void dpu_kms_mdp_snapshot(struct
> >> msm_disp_state *disp_state, struct msm_k
> >>                           cat->ctl[i].base, cat->ctl[i].name);
> >>       /* dump DSPP sub-blocks HW regs info */
> >> -    for (i = 0; i < cat->dspp_count; i++)
> >> +    for (i = 0; i < cat->dspp_count; i++) {
> >>           msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len,
> >> dpu_kms->mmio +
> >>                           cat->dspp[i].base, cat->dspp[i].name);
> >> +        if (cat->dspp[i].sblk && cat->dspp[i].sblk->pcc.len > 0)
> >> +            msm_disp_snapshot_add_block(disp_state,
> >> cat->dspp[i].sblk->pcc.len,
> >> +                            dpu_kms->mmio + cat->dspp[i].base +
> >> +                            cat->dspp[i].sblk->pcc.base, "%s_%s",
> >
> > This might look simpler in the following form. Could you please consider
> > it?
> >
> >
> > void *base =  dpu_kms + cat->dspp[i].base;
> >
> > msm_disp_snapshot_add_block(..., base, cat->dspp[i].name)
> >
> > if (!cat->dspp[i].sblk)
> >      continue;
> >
> > if (cat->dspp[i].sblk->pcc.len)
> >      msm_disp_snapshot_add_block(..., base +
> > cat->dspp[i].sblk->pcc.base, ...);
>
> Regarding what we discussed in the private email, is what I had for base
> in v2
>
> (https://patchwork.freedesktop.org/patch/545690/?series=120249&rev=1)
>
> essentially what you have in mind?
>
> >
> >> +                            cat->dspp[i].name,
> >> +                            cat->dspp[i].sblk->pcc.name);
> >> +    }
> >> +
> >>       /* dump INTF sub-blocks HW regs info */
> >>       for (i = 0; i < cat->intf_count; i++)
> >>           msm_disp_snapshot_add_block(disp_state, cat->intf[i].len,
> >> dpu_kms->mmio +
> >>                           cat->intf[i].base, cat->intf[i].name);
> >>       /* dump PP sub-blocks HW regs info */
> >> -    for (i = 0; i < cat->pingpong_count; i++)
> >> +    for (i = 0; i < cat->pingpong_count; i++) {
> >>           msm_disp_snapshot_add_block(disp_state,
> >> cat->pingpong[i].len, dpu_kms->mmio +
> >>                           cat->pingpong[i].base, cat->pingpong[i].name);
> >> +        /* TE2 block has length of 0, so will not print it */
> >> +
> >> +        if (cat->pingpong[i].sblk &&
> >> cat->pingpong[i].sblk->dither.len > 0)
> >> +            msm_disp_snapshot_add_block(disp_state,
> >> cat->pingpong[i].sblk->dither.len,
> >> +                            dpu_kms->mmio + cat->pingpong[i].base +
> >> +                            cat->pingpong[i].sblk->dither.base, "%s_%s",
> >> +                            cat->pingpong[i].name,
> >> +                            cat->pingpong[i].sblk->dither.name);
> >> +    }
> >> +
> >>       /* dump SSPP sub-blocks HW regs info */
> >> -    for (i = 0; i < cat->sspp_count; i++)
> >> +    for (i = 0; i < cat->sspp_count; i++) {
> >>           msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len,
> >> dpu_kms->mmio +
> >>                           cat->sspp[i].base, cat->sspp[i].name);
> >> +        if (cat->sspp[i].sblk && cat->sspp[i].sblk->scaler_blk.len > 0)
> >> +            msm_disp_snapshot_add_block(disp_state,
> >> cat->sspp[i].sblk->scaler_blk.len,
> >> +                            dpu_kms->mmio + cat->sspp[i].base +
> >> +                            cat->sspp[i].sblk->scaler_blk.base, "%s_%s",
> >> +                            cat->sspp[i].name,
> >> +                            cat->sspp[i].sblk->scaler_blk.name);
> >> +
> >> +        if (cat->sspp[i].sblk && cat->sspp[i].sblk->csc_blk.len > 0)
> >> +            msm_disp_snapshot_add_block(disp_state,
> >> cat->sspp[i].sblk->csc_blk.len,
> >> +                            dpu_kms->mmio + cat->sspp[i].base +
> >> +                            cat->sspp[i].sblk->csc_blk.base, "%s_%s",
> >> +                            cat->sspp[i].name,
> >> +                            cat->sspp[i].sblk->csc_blk.name);
> >> +    }
> >> +
> >>       /* dump LM sub-blocks HW regs info */
> >>       for (i = 0; i < cat->mixer_count; i++)
> >>           msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len,
> >> dpu_kms->mmio +
> >> @@ -943,9 +976,30 @@ static void dpu_kms_mdp_snapshot(struct
> >> msm_disp_state *disp_state, struct msm_k
> >>       }
> >>       /* dump DSC sub-blocks HW regs info */
> >> -    for (i = 0; i < cat->dsc_count; i++)
> >> -        msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
> >> dpu_kms->mmio +
> >> -                        cat->dsc[i].base, cat->dsc[i].name);
> >> +    for (i = 0; i < cat->dsc_count; i++) {
> >> +        if (cat->dsc[i].features & BIT(DPU_DSC_HW_REV_1_2)) {
> >> +            struct dpu_dsc_blk enc = cat->dsc[i].sblk->enc;
> >> +            struct dpu_dsc_blk ctl = cat->dsc[i].sblk->ctl;
> >> +
> >> +            /* For now, pass in a length of 0 because the DSC_BLK
> >> register space
> >> +             * overlaps with the sblks' register space.
> >> +             *
> >> +             * TODO: Pass in a length of 0 to DSC_BLK_1_2 in the HW
> >> catalog where
> >> +             * applicable.
> >
> > Please assume that https://patchwork.freedesktop.org/series/119776/ and
> > rebase your code on top of it.
>
> Roger.
>
> >
> >> +             */
> >> +            msm_disp_snapshot_add_block(disp_state, 0, dpu_kms->mmio +
> >> +                            cat->dsc[i].base, cat->dsc[i].name);
> >> +            msm_disp_snapshot_add_block(disp_state, enc.len,
> >> dpu_kms->mmio +
> >> +                            cat->dsc[i].base + enc.base, "%s_%s",
> >> +                            cat->dsc[i].name, enc.name);
> >> +            msm_disp_snapshot_add_block(disp_state, ctl.len,
> >> dpu_kms->mmio +
> >> +                            cat->dsc[i].base + ctl.base, "%s_%s",
> >> +                            cat->dsc[i].name, ctl.name);
> >> +        } else {
> >> +            msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
> >> dpu_kms->mmio +
> >> +                            cat->dsc[i].base, cat->dsc[i].name);
> >> +        }
> >> +    }
> >>       pm_runtime_put_sync(&dpu_kms->pdev->dev);
> >>   }
> >>
> >



-- 
With best wishes
Dmitry
