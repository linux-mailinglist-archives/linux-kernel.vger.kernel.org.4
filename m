Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FD8666584
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjAKVWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjAKVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:22:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100CBB1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:22:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e13so17421061ljn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SpkJwobKqiU8nRFVkZb61TqjLeUFLzQFi5sevtGMDks=;
        b=RXhl8Ldw2vRfpC+jkbVadTGg5irX4Ld2rQFjwPM5/DBN6AUXUNsgo7WMBw8u9jozdw
         BY9YZNf4Uj8GCHhaFjFLk5Ry3m+ISerezk7P8aOAmA+iihm8GX6Ei2y6FWIwH+6HEf6y
         dxfHjuIGyNMGqmPqRr+ScVRagKo4V4M9Y+SpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpkJwobKqiU8nRFVkZb61TqjLeUFLzQFi5sevtGMDks=;
        b=LXLWiaCSvhnrvqMzqyacLQhWgH2Evnt9AvRGDpyAdMqcqHUT7oq3zoKEN9BcP7fvHp
         OoFlMpii32u9ABq0C0Z0dcmm/X+kia6Le2mrvWWxNf8LekLxicc4olPrmgikdQxbeM6b
         MydkSJh+86FbT7aJVA0RpdPUBMXUZGYkKLkUjui1UaWmOU5MSG0kMCl88aVzeTl8IvFs
         eaCUgUdqw18lx6wzPj3Efu0h84qMsc2t41J+nE1ftIPCQr+iCIXMG9cpWPAqobEa/zpl
         6wvKBOBI1wv3MgXwUcRe7FRFT/7BU7/3CmAYDqMCdNiAXJCncGo8oNGFaF/oIHDp7tak
         YMZw==
X-Gm-Message-State: AFqh2koZXILHrjmg3HThhr5wMOV6auYTheTnFp67g5eWSldXcDdw/otA
        LQhNnoxT2Kw05aT1pT3Yqb4kYd6P3o9qzNdugAdDFA==
X-Google-Smtp-Source: AMrXdXsm6J64WrN7IaY8xb8w+IAY7QTQY+mwkhaNgAeX7Fe/qfFEa6pRbLSCSiNPEVhxwTepH259F9DaiY/EV4/qtZ0=
X-Received: by 2002:a2e:7e12:0:b0:27f:b665:df51 with SMTP id
 z18-20020a2e7e12000000b0027fb665df51mr3900070ljc.277.1673472127618; Wed, 11
 Jan 2023 13:22:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jan 2023 13:22:07 -0800
MIME-Version: 1.0
In-Reply-To: <1672849297-3116-4-git-send-email-quic_srivasam@quicinc.com>
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com> <1672849297-3116-4-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 11 Jan 2023 13:22:07 -0800
Message-ID: <CAE-0n530eE5Mwcy0nZxAKW99BEpRts83eChDCrerjgYQopJ9EA@mail.gmail.com>
Subject: Re: [RESEND v3 3/4] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2023-01-04 08:21:36)
> The qdsp6ss memory region is being shared by ADSP remoteproc device and
> lpasscc clock device, hence causing memory conflict.
> As the qdsp6ss clocks are being enabled in remoteproc driver, skip qdsp6ss
> clock registration if "qcom,adsp-pil-mode" is enabled.
>
> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
>

No newline here.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
