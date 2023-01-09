Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589D662846
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjAIOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAIOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:18:47 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3AB15721
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:18:46 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4bf16baa865so113827027b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 06:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq/zsLtOxvUpilNzkZm53DLhGTnecoKgp9xef0ifk6A=;
        b=f9g2fxJH+nlBKifMDoOpaEo7JhFa/zmFsblORNMzG4fLvnfWT3f7UxnpMetzjcZyLC
         BgcA0Ls+UbYBs22fjAlMfiRFO1uPXD2A9mKDT0LJSCFZUschkEcSMBgLS/HwHLWUaJ3b
         pWqHIFreVg1K/e4HKk7/uIdHLyyCTiLBhf4ppbqD99jOKMyIvhJsqBGixFVsRWQS5kbn
         6apuvNj2k3gFa8VZnoMY68HHJ8gfBnToJ9uvGmbNv2yLEMJWUmlijOAC4jJ8U6qV621t
         TWoJMWFec6Q4C0ewIVHu5hVlnT1xq9Y4YCpOV3HOIKKvccRCyxX/hyTXct2vIhlFQCD/
         Ol7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cq/zsLtOxvUpilNzkZm53DLhGTnecoKgp9xef0ifk6A=;
        b=khXEn9+7rO8VH2E0rhLW76Cl5pO2BFppZN8yAJF2ahvb7dC71D1d9c03aTyG4WA5Jn
         x+3LajDITi0XLwJvrLR8jL1K+27kDz4UepoQIFPjwfuKkk6Fq0VMeljezNNXELG7fpeO
         YIaqj/lGOHZVvDghJk8Xogz9ZE5r5UL7P+MrScc6ioVaA56k4IqXiHUf3eX+PcxZwxRP
         MS2g01SyN3PgYZoppRFacabT7txzpmFjESx7rWvLFpZn0hqm+us0ziJwoYwfYz7M2mxt
         khgmTmLN/1mIGg1R40SvVjkSk7TiCyZSwZBFVPpESBanDbVttakNvGrLh8qgwfaOv5qI
         WmoA==
X-Gm-Message-State: AFqh2kpd/9hdWkUdB/xP4W1QBgDnNrHIh0R6XRPurDDpLu4HfMNueV3B
        aAnqOowZtTeoIitS2gS+qqBbB4oOutg2ckSXCveq+A==
X-Google-Smtp-Source: AMrXdXvZALTukqFMVUU9iMepmp1dDXQlhGDNQL65hRRRgn4hLCn5jfD+jwcXYqtGNKvKuKxbo6DIiBsmemMNl/Ctxx4=
X-Received: by 2002:a81:484c:0:b0:36a:de9d:825e with SMTP id
 v73-20020a81484c000000b0036ade9d825emr1509416ywa.477.1673273925453; Mon, 09
 Jan 2023 06:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jan 2023 15:18:34 +0100
Message-ID: <CACRpkdby3KTakQXnmkSYsu3HreSYx9zhP0nWKQU3KOtmunA3Ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] qcom: add support for SPMI PMICs found on SM8550 platforms
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 9:24 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

>       dt-bindings: pinctrl: qcom,pmic-gpio: document pm8550, pm8550b, pm8550ve, pm8550vs, pmk8550 & pmr735d
>       pinctrl: qcom: spmi-gpio: add support for pm8550 & pmr735d gpio control

These two patches applied to the pinctrl tree!

Yours,
Linus Walleij
