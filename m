Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486496509BF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiLSKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiLSKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:02:06 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8AFDFF0;
        Mon, 19 Dec 2022 02:01:59 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id a66so8154520vsa.6;
        Mon, 19 Dec 2022 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCDOO4VPZC6I/ow/QnYvYYMpSXdiSjKaJtZIVyZxvEE=;
        b=mOtdqjcN2Q+lYcbuQkk+7XmEkdgmncgKTiCt6qcnIl9LxKIyrA9C9+kYAYYGX3Iq3b
         6JKV2CH5JjzySELSxzFzDkXA0/qzGraNPEjqOCNTaqSteogolPKnnmO1NBOZoHwGzQgs
         ptI9YgvzV13kcdXChGr0YKpidltW4SSG67y2STPnCLdbED+CJy4hT6R3657k6ji6DYPb
         JTjtNbBcBH5D09ZfJc0LkL/jd/kbtj40S9T7fJfvGAQAInlBHLr6+7fbhUcJ0M7zzgXF
         a91M0M24p25GDDYDRbm+qU4Vp3ikeprcRgzhGfokpCInUx58z3HNWedmoqXF5PKpgpdB
         1dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCDOO4VPZC6I/ow/QnYvYYMpSXdiSjKaJtZIVyZxvEE=;
        b=1QThDt38Cnv2k5r+Xd0Mz8VQ5IRWPJ2o+gJ+tHk+Q29mY+d4BJEvg5agWBQY2QvFfG
         Kcc/6U5TSQTACWY1v1gPKTwwy6N8pWD4dE0FkeSH16lxsijv3PM26Z3nj2OwgZ6/q7WL
         ZlHLbOMX0SIHMYJVomrn8IAwuWc/AHa6eddjmFw8mX+GeCXoHRsvdNRrSntMqc5A+1Iv
         msiUN4VUeYUeS9qyLPqwaQrEK5+6WLMP1LATaWeXHQ87iFhoSUpUiNjXmIVNl5xRaMto
         7Nb+BYuk/6siumXdabdjS8IRHhubRKCctj2HMu+MElB+/icevEKscoQEdsQ2spf0DVeE
         KRuQ==
X-Gm-Message-State: ANoB5plk4ZJb77ir5G16oUKVwnhj43RdkYXSyyt/n4WtZENVAkkSo5sV
        1g3fw7u/oM4m4cPqADEtjgkUv0SKCl52h3CBJ88=
X-Google-Smtp-Source: AA0mqf4ROgAqL66e4a/+lmlVndnHpc5y+QPZsBm8wwkxvClIFBYSMaQfW5JScMW2tffHoRiJQd70LauX0BVgg7SXON4=
X-Received: by 2002:a67:fa8f:0:b0:3a9:5a1e:ffa with SMTP id
 f15-20020a67fa8f000000b003a95a1e0ffamr41970859vsq.39.1671444118071; Mon, 19
 Dec 2022 02:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-6-iskren.chernev@gmail.com> <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
 <3134ba66-27bb-7015-8988-6c8dec046b0f@linaro.org>
In-Reply-To: <3134ba66-27bb-7015-8988-6c8dec046b0f@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Date:   Mon, 19 Dec 2022 12:01:46 +0200
Message-ID: <CAL7jhid=inAk85h9tHOD6rjFc-aNufvZPQw3ALfsrqTm6oHCag@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, hopefully you can skip this patch completely by depending on the
> generic "qcom,smmu-500" compatible.

To be clear -- I still need the qcom,SOC-smmu-500 compatible in DT and
bindings, but not in the driver (i.e driver will pick generic)?

Then this can indeed be dropped (but it is merged in linux-next ATM,
6.2-rc1 based next won't have it, I guess?).
