Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA43628A66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiKNU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiKNU1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:27:44 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8AA124
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:27:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t25so31136671ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCfG+hOC32UcE1+jvceujSzl/rFR67fnp9HdOcb9XXo=;
        b=YZbBARaiZIN5w5hmUzF7Yt5HUb8Fu8ZcAoW26h5RlMwSHRIVsAdn1PNguLoBw9ki+I
         avs6Bhr7b7wxAMHDI3giIi54k5CDbe4SATViP+LZnOobPbn85eYeB7PNCat8brXZqZ/T
         AhbN07fijNjTdg2kBJYXr5RMz1Nf5+naQTzsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCfG+hOC32UcE1+jvceujSzl/rFR67fnp9HdOcb9XXo=;
        b=QVy2FsuReem6a+mxKmNSw9kgvP0trY74ctWGnjH0bKyCX7nxJCK69kx6eyv9vM/YrA
         bEWe5DxVfwv/ILc0DxeKG8z07RA53cVh40P1kt8ObRYxL8EDW+4wYLgtuZDDcjx3OOhV
         r9Bwyd+/4EbE4obZV29q66+j/0QPTRY0DDjx6Mx8+OnhViw1ll6T1QwmhiUpuLNqPsnJ
         inqC0R104djsEugNR8PXlKJ50pPYbsxw8KaNUfd9cvA562v3RWAC8+jlMZL4m80ybqYB
         tN71gopZIK5ekJIuZQYdOe6w22Ivs9Cp/Skoc0icJSB1MXLdZBsjslZMaojD4MCTwilH
         vzzA==
X-Gm-Message-State: ANoB5pkrMOrSfmTKvKyc98qdOVMK8KszICifOHBV6iCR778Sdfgn07mz
        kjC2AQXP13Mr8xRbLzAhm8Kd3DLSchwF1vZV
X-Google-Smtp-Source: AA0mqf52EeVf4rNe3SeEpyeDfSI3HMeghThvaUXPYeFYd1jHQqgOh6rAE1+FBnrn+LeJXYOBqJPHHA==
X-Received: by 2002:a17:906:1416:b0:78d:e869:f328 with SMTP id p22-20020a170906141600b0078de869f328mr10881275ejc.696.1668457661834;
        Mon, 14 Nov 2022 12:27:41 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id et19-20020a170907295300b0078175601630sm4561963ejc.79.2022.11.14.12.27.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:27:35 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so1731436wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:27:35 -0800 (PST)
X-Received: by 2002:a1c:f611:0:b0:3cf:9ad3:a20e with SMTP id
 w17-20020a1cf611000000b003cf9ad3a20emr9535222wmc.151.1668457654755; Mon, 14
 Nov 2022 12:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20221114194133.1535178-1-robdclark@gmail.com>
In-Reply-To: <20221114194133.1535178-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Nov 2022 12:27:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WB__v5TPFOqnQMajR6MvLGjLYrKrV+qosJYQFTCpROzQ@mail.gmail.com>
Message-ID: <CAD=FV=WB__v5TPFOqnQMajR6MvLGjLYrKrV+qosJYQFTCpROzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 14, 2022 at 11:41 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> If we get an error (other than -ENOENT) we need to propagate that up the
> stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up with
> whatever OPP(s) are represented by bit zero.

Can you explain the "whatever OPP(s) are represented by bit zero"
part? This doesn't seem to be true because `supp_hw` is initiated to
UINT_MAX. If I'm remembering how this all works, doesn't that mean
that if we get an error we'll assume all OPPs are OK?

I'm not saying that I'm against your change, but I think maybe you're
misdescribing the old behavior.

Speaking of the initialization of supp_hw, if we want to change the
behavior like your patch does then we should be able to remove that
initialization, right?

I would also suspect that your patch will result in a compiler
warning, at least on some compilers. The goto label `done` is no
longer needed, right?

-Doug
