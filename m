Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687C368AE3C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 05:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBEEQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 23:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBEEQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 23:16:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B06E93;
        Sat,  4 Feb 2023 20:16:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id dr8so25587516ejc.12;
        Sat, 04 Feb 2023 20:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pGmjAtSpm7T3NYEfTdl7rNgWicn+a5Oe3VNo+Eoz3Lw=;
        b=MU+TGrCw1MEvbZ+QAC6jqR6MOQaR8PyyMr0RhYg3EKTVT8b2coqtS1GyEnQ/0zDjWX
         PbrT9j7vMPNrPHiUnKwZB7gGyYHbrQvlI1DkF4ss4b8nKYLt4PubrWJj2aujM4gC26Yy
         zX72cXs5xCD9rf9JKL6D3/hxzvoGV5Q2s4OGLXdasOb3wfv7u6ljXWnB3iPbljQerT0B
         JH59fZyXEgO62k2RByu2DnWh0IpzckNI9UxswsE3YyUL1xAeh2LNnLpnjztnfZYHd0ft
         R9fj0VL0N0bGNRxoH61Iz2OJ3YJF+Ad2NrufSAML4Sw/A1iMJIUwxSuMCy8HZSOwovkn
         2cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGmjAtSpm7T3NYEfTdl7rNgWicn+a5Oe3VNo+Eoz3Lw=;
        b=AFUok83iXGxqXYXk/0Cq5+hjG8aZxUBppWZiimypC0AnOFYRkwYH+aMmbwbsEekEwh
         0wlea9U9PxGrtK8ilZqPwfv7651NNy6iqkoHi1ZHy6P2G2blxGbjNO+YikEUOmFy+Qzb
         tuGTB6cA1wMpczSbtAp+0eKHVLXXf0u0c8sLV+rEpzfBi2P2SCNXKLP3sdkqwLI5mvf6
         3Jrmxjyrv74WqsbMpmCcSEKSp8gu/sTNnM7R8PQjGpyfFBsJbReFOmFXcyaW7zFy6d7f
         AvbcxvII1hw1E3pTQEbznK9+7oDS65go/BpOoQjj7JGZBWUQ2TBlwANM3d2ZysvFukjo
         i0jA==
X-Gm-Message-State: AO0yUKWhPNogVdD0vVyyIDtRvmlmjfY9ik4y5DaB01VvXnraQoZhCNjw
        j900RF/NH2xVURT2mU+52hG/jut8YSZY/K4A3Bw=
X-Google-Smtp-Source: AK7set/Phq0+sMz3EXPsbZ2Dwtggp95sagZP3NNxuR0p3KAlHS0KLI+JnJOts17T5uTN0oi6OC8KCse3Bq8AdieGaL4=
X-Received: by 2002:a17:906:1781:b0:878:7d2c:6ba4 with SMTP id
 t1-20020a170906178100b008787d2c6ba4mr4606698eje.42.1675570568186; Sat, 04 Feb
 2023 20:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org> <92240215-b336-48c8-d9f0-a33890f44907@linaro.org>
In-Reply-To: <92240215-b336-48c8-d9f0-a33890f44907@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 4 Feb 2023 22:15:56 -0600
Message-ID: <CABb+yY3WXt0NBoh+spgYXj3L_72s_L-W+hqz+sbKNyD0HgU_vw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] clk: qcom: msm8996: add APCS clock driver
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jan 27, 2023 at 12:15 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 27/01/2023 01:03, Dmitry Baryshkov wrote:
> > The sys_apcs_aux clock can be used by CPU and CBF clock drivers to drive
> > those clocks from GPLL0 while doing initial setup. Add simple driver to
> > setup and export this clock.
>
> Jassi, please excuse me for this ping. Since the only questions are
> related to the clock driver (and hopefully they all are resolved), do
> you plan to merge the patches 1-6 for 6.3?
>
They have the required acks, so yes I will pick 1-6 (not 7).

thanks
