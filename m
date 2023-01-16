Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF12E66D0AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjAPVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjAPVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:05:43 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5426866
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:05:42 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id o75so31695332yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi16rqRfpVxEIDPG8yaq6fMfKHFwbsCk0KPMN6hDEDQ=;
        b=PBMJZDaOQp1JclDMa/01hpziebOYPox2et3WTjTnSzGSEMZvGQT1Lbv+hPf02Z0MA4
         0YJH3/pd6X4vxKQqgqv5nogChYwIYBG5F4FgkPoydW22jCYyGZtcA3n0P2UhYdZElG+l
         r6a1c+qvdYN2mMWj/Fy9mdWXfJO5pZ5jbH4GdqPE+pXNYhKmzx3U2VUIM2XI/qftzDAH
         cFOoP+buTHBEH2OS7tk9Mitg01rfy/YYIszs6dzkiVnbByiIMeSfL/M3Nqt9o9oCA5/5
         AuIuWCxo05EF4CVHbfqRneJ5lPJqEwYcSTKKR79omXvE+St8fCQKd1ocTM8u6jbNA2wx
         STiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi16rqRfpVxEIDPG8yaq6fMfKHFwbsCk0KPMN6hDEDQ=;
        b=7S42awq4nrx1NbG8/HazRw4eD8ghZFOysCrd5/vPJfxLQGBWNUL52xUmMJyrpKdHab
         SBwU0FJEY9JHvOXrzxtn+vWX2qTUhUkf5gs5LaRuqlYYf4khRWYUCbcFqBsPFZTQ8tBF
         nrM1l1w9bURfdG8WXlQ7eXo17VH6b0I7n3L4KB1ZhYaBm8s3ODR6CGIte82PQa0j66Gp
         rdHjbFdOVYmMzfXQwXAlzSey4dVwLHLQPOeKkPWODcwRHXmdmNT3w6zUc1PT5b7Iy//1
         L5hfTUj326iqBUBNFDhLs4am8TML1lDvULRhdzslQqcJKe+Apmf8NcU+nRmHB1p1kIjY
         +6Gw==
X-Gm-Message-State: AFqh2koIexU0Y9ZE61OiEPQ/GZDsbCMYIRDERAiYgCNhCXg4zd7ifxch
        Ea/vnlzGb+7BGYFuJSspGB/fL7v6LOKvN9INgRsIag==
X-Google-Smtp-Source: AMrXdXvUFbKj/8VK1PqxF3SoqqhT54oJaVtabwef3rW+11qq+8X4WHWpCQjx3gPW4zHB70/sxyRjqRKMlHRycFgU+3s=
X-Received: by 2002:a25:9002:0:b0:7c2:d9f1:3b04 with SMTP id
 s2-20020a259002000000b007c2d9f13b04mr147791ybl.516.1673903141353; Mon, 16 Jan
 2023 13:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20230116204751.23045-1-ansuelsmth@gmail.com> <20230116204751.23045-6-ansuelsmth@gmail.com>
In-Reply-To: <20230116204751.23045-6-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Jan 2023 23:05:30 +0200
Message-ID: <CAA8EJprEOaduAd_OwpbW0m4aWwoFxNVqExTtMhTK4giPMkBGFA@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] ARM: dts: qcom: add and fix clock configuration
 for kpss-gcc nodes
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 22:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Add missing clock configuration by adding clocks, clock-names
> and #clock-cells bindings for each kpss-acc-v1 clock-controller
> node for apq8064 and msm8960 to reflect Documentation schema.
> Add missing #clock-cells binding and remove useless clock-output-names for
> ipq806x dtsi.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




-- 
With best wishes
Dmitry
