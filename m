Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D76735781
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjFSNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjFSNAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:00:08 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52882119
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:00:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bd729434fa0so3792011276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179606; x=1689771606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BrFNh+rb4LdBzypQ3oE3U7czB9G2st4YddEl5A8gEaY=;
        b=AcLO1dlzV/QVWRg/8clGarbCG079gBcurJW/W6CcT2EYBNX1Mdi6XhpPcfKjlWRNJs
         150f2yxY+ezdT19RgBcJcTPYkNLvvHhtz5K7xu3dCl5w/RzoK/qzz+Vxwo4+Q2jPtcrZ
         HS8kB3KaXUzdl/vWhP0mMQR5Lukh4YZm9WtHLmBkCrjhqCmpl/NgF3AAm9VvZYgfXURP
         yh2fKtc0/IZUxfH9U9c/R4Dx7ivShYziW8os7ti3T8vF+gy7gu9OPc17VlfB3AEeRZXz
         CCxcBZ4gmcIaEH3TRl7pLWjN90R6KnskwtLXoIylzOvA95O+DCPZXtCvyB3YaZO5z1Io
         zVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179606; x=1689771606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrFNh+rb4LdBzypQ3oE3U7czB9G2st4YddEl5A8gEaY=;
        b=Wj1ULGapU0tA/iWFpgUrIFX6UEttZd+0JchB3v/2jYdAtn18/0ES2VfZ0FhuzFYBih
         SfSirrMcncxpW5PmQEtwHeyFf92UfPkU/A5sCDCcShftVDAqacAxQDf7+XSgDDwuXV/2
         prYyDBo6tis48dpOzxUp/uVx5Rafpdlc7tQ3p7X7Z4oQflbgWChMZQUuIjlXkP9fVkH6
         PKrXozjXj3VCEre6FJqaJhW8siEDNyxZSAWitFDLZpcVyUxinwC17xQHS4y3fA2DmxgE
         qLztRwlJwPF466aZjNh2Xw8kwxzjw0PTkP5OwUMhFDBK/MLa8X9A/EzqwRwIkT+bKvZ1
         /q5Q==
X-Gm-Message-State: AC+VfDyMS2H4ibMd227jHeLHAylrgQMzD0CHEB9lNixikgJPudM99T/A
        LTQRhU9snrYA0M033ROvnhds7GtFmdr+4b+LCAey2w==
X-Google-Smtp-Source: ACHHUZ7NX/vqgH3ffxXPw663ikrTwhwKINh+/6Hmi0nIZlGdFPtC6e7u2O1Jmi6XRQgudeLbnadfLd7uXozIb05IinQ=
X-Received: by 2002:a25:ac92:0:b0:bca:2ef0:9db with SMTP id
 x18-20020a25ac92000000b00bca2ef009dbmr6836918ybi.5.1687179606141; Mon, 19 Jun
 2023 06:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-1-66663c0aa592@linaro.org>
 <9e890ca0-396d-fb97-a7d5-db13b8fdbb92@linaro.org> <a3a7f840-eb74-dc32-dd8b-5f74a484b765@linaro.org>
In-Reply-To: <a3a7f840-eb74-dc32-dd8b-5f74a484b765@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 19 Jun 2023 15:59:55 +0300
Message-ID: <CAA8EJpoUo+8==4bOfv-V8fD6Wmng8GON4XMVWR4DkNtekMbtLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] interconnect: qcom: rpmh: add optional mask to send
 as vote
To:     neil.armstrong@linaro.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 at 12:47, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 19/06/2023 11:45, Konrad Dybcio wrote:
> > On 19.06.2023 10:24, Neil Armstrong wrote:
> >> On the SM8550 SoC, some nodes requires a specific bit mark
> >> instead of a bandwidth when voting.
> >>
> >> Add an enable_mask variable to be used to vote when a node
> >> is enabled in an aggregate loop.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> > Would be nice to mention that it's literally this commit:
> >
> > https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/2d1573e0206998151b342e6b52a4c0f7234d7e36
>
> Good catch, I just copied the bits but yeah in fine it's the same...

And probably it also requires copying SoB (and Author?) from the
original commit.

>
> I'll refer to it in a v2.
>
> >
> > For the code:
> >
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Thanks,
> Neil
>
> >
> > Konrad
> >>   drivers/interconnect/qcom/bcm-voter.c | 5 +++++
> >>   drivers/interconnect/qcom/icc-rpmh.h  | 2 ++
> >>   2 files changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> >> index 8f385f9c2dd3..d5f2a6b5376b 100644
> >> --- a/drivers/interconnect/qcom/bcm-voter.c
> >> +++ b/drivers/interconnect/qcom/bcm-voter.c
> >> @@ -83,6 +83,11 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
> >>
> >>              temp = agg_peak[bucket] * bcm->vote_scale;
> >>              bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
> >> +
> >> +            if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
> >> +                    bcm->vote_x[bucket] = 0;
> >> +                    bcm->vote_y[bucket] = bcm->enable_mask;
> >> +            }
> >>      }
> >>
> >>      if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
> >> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> >> index 04391c1ba465..7843d8864d6b 100644
> >> --- a/drivers/interconnect/qcom/icc-rpmh.h
> >> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> >> @@ -81,6 +81,7 @@ struct qcom_icc_node {
> >>    * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
> >>    * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
> >>    * @vote_scale: scaling factor for vote_x and vote_y
> >> + * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
> >>    * @dirty: flag used to indicate whether the bcm needs to be committed
> >>    * @keepalive: flag used to indicate whether a keepalive is required
> >>    * @aux_data: auxiliary data used when calculating threshold values and
> >> @@ -97,6 +98,7 @@ struct qcom_icc_bcm {
> >>      u64 vote_x[QCOM_ICC_NUM_BUCKETS];
> >>      u64 vote_y[QCOM_ICC_NUM_BUCKETS];
> >>      u64 vote_scale;
> >> +    u32 enable_mask;
> >>      bool dirty;
> >>      bool keepalive;
> >>      struct bcm_db aux_data;
> >>
>


-- 
With best wishes
Dmitry
