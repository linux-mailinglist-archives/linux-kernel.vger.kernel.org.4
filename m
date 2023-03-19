Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2636C0527
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCSVDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCSVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:03:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DAD1E5CC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:02:48 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n125so10839753ybg.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679259762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbV6Bh/cNsY2Io1y10SkZjIuZK4TmLVqW2b5h9GtPaE=;
        b=VXyRZOPszvrTh2/++fTwBNasGeYcc1YN2g1XQGu+wGihL5XAh1HWL6miXKYetReFlt
         e+mgaizYtW5gS157vS8n93LRFEj2Ah3ZbZoohAjU3TNPEaCLDcYiFuN05UhBOzXV30mJ
         XRHuBT4ATsajKjivNpLh5PNHcBKcChZ2qjDjwijKtZpHIKVSMiQFjwD7zqt8phrj6qgu
         gcv6ijOUMWWHFH+Mh93Ozd0dBP2TLL25g2uZuPkfck9I5o9Cdwg5JbKZ2SJx0zzV9QUY
         qjnebF/7bIKXS3COEBYQSb2JOaexBEQb1wVDPDNNUoZ1Y5vtm5wVUKNai6hCRWcruo1I
         uxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679259762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbV6Bh/cNsY2Io1y10SkZjIuZK4TmLVqW2b5h9GtPaE=;
        b=d/qx907lwDPLoT4DJdLxcrJFSfs/4wIN3SpJcUWQC405MyhdX5iRzuKWbVKUIs0bkE
         kx5AR09pMSZhOI3Z1sdDYrQb8LSNN9tEpDXYOezvaIgDIuV/tJwYUAUFfYDoXRw4gLBd
         NKn6EnfK88uCDv9xD0IRB1rkUdmZHimQmcSvL01fIf5jlnufT/VwtTW6U7OIKoS1837a
         Cc7mUxOT0qusPtmCjIVI4i6Dxh+y0JpeLDbhXiGk1inCSxpu1nXXvAjcZ+kCiLXX2tmW
         9KjEnE421aRZu9E7hQhTCwnPuPfWWl/b1f+W5VPOSPHdyqrmYP34cwCs1Gpdl2RkWza9
         cejQ==
X-Gm-Message-State: AO0yUKWre2pvIu1Gimor+xX1DZD6lHhS4cv+r3lQEgG6s6XnileG7hbK
        O1TaUUEigjBzORF3VH2MpXGEluLeIUhA2Aww+Eh9Jw==
X-Google-Smtp-Source: AK7set9mxeFO57SGruCJH6C1TZj973V2SQLNunHNOaC44Y5XLUJPP+RqdyW12BliuWYUYiE6coMhTxlkWHzd16pXggk=
X-Received: by 2002:a05:6902:110e:b0:b26:47f3:6cb with SMTP id
 o14-20020a056902110e00b00b2647f306cbmr3231733ybu.4.1679259762548; Sun, 19 Mar
 2023 14:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230316072940.29137-1-quic_devipriy@quicinc.com> <20230316072940.29137-5-quic_devipriy@quicinc.com>
In-Reply-To: <20230316072940.29137-5-quic_devipriy@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Mar 2023 22:02:31 +0100
Message-ID: <CACRpkdZYOQ6JvQvg5gcUb1x+FOeTn-H5rOnK=8EgDBmZh9DYig@mail.gmail.com>
Subject: Re: [PATCH V9 4/6] pinctrl: qcom: Add IPQ9574 pinctrl driver
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 8:31=E2=80=AFAM Devi Priya <quic_devipriy@quicinc.c=
om> wrote:

> Add pinctrl definitions for the TLMM of IPQ9574
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V9:
>         - Added COMPILE_TEST for non-OF configurations in config PINCTRL_=
IPQ9574
>         - Unwrapped the lines for PINGROUP 34 & 62 in ipq9574_groups
>         - Removed the comma from terminator line in ipq9574_pinctrl_of_ma=
tch[] array
>         - Moved the MODULE_DEVICE_TABLE entry just below the array
>           ipq9574_pinctrl_of_match[]

Looks good to me but I would like Bjorns ACK on this patch before I merge i=
t
if possible.

Yours,
Linus Walleij
