Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AD601900
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJQULn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJQUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:10:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ED97B2AD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id bb5so8443379qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkfY19Z8rIrVFTu1TtNfrJ52Tlop9Rl4OnJC/RUurMQ=;
        b=TnLFN3iPa4UaiXE2wsMScCERV/nk8oZNSgyuRyAC6xessJRvYyE65jFZAcwa255jFq
         JHBfVSpM2y3s9pFSK+/k8xXupwXC2LzAjrNMb4sEkc05r3K9tFNEcDfQzuCC3FojCj9J
         gjK7w9LGZmOVYkLYhbP6waYT4yDACKl24+sqVC0QaXwDsqQP12zCcwnh/r+V1tnVeGT2
         0Tnigil60WpzSyP9AFLmgdoupl4NoKZ7WWZjsIFQcE91vvkyG/arbZDMa9Y/kWsrXQdS
         ghVZqLcmSkDE+sEOLqTbDQ2PmTRdZQ63ZGSiDuiMyzAcxcQM+GZa61hqPnvCKDoPQPeK
         YUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkfY19Z8rIrVFTu1TtNfrJ52Tlop9Rl4OnJC/RUurMQ=;
        b=mem8QQepaZmkaFSPmxKacO+W6lOli/NKYonoj+vUZq7z6mkULvAzQUt5p0wGQVCRAq
         IjlrNq86x0e1sJYU2ZIg0T2O58phWDoNFlaZ5IW3MC3vS3KnxMa8YoVsCMq5ofEkg2H5
         9FtEQq+hpxCHjLLqZocOELvpmuunYcGQ68KEXG/DOX0y6i/WJWFgK0siz+nrA5VYHpc7
         MikqH39+wAbqE1WX/swEI6jngQQYl2hyNBynijZPQLqK/M5W99JYuRDCAwqWubehPE+j
         cXUuPo9YdFvVeaYdbr4DVTB4YP7oEiaB+YaV9rfGTa6LGHBycca8CtX044kFY6SQU1u9
         DIVA==
X-Gm-Message-State: ACrzQf1hqWQ7ikSAxNAfYzWITNJqkuw0kVjWaeapMRPPljTE7A8D4x8q
        txVu6hhZA40kKqKTQnyyKVioCw==
X-Google-Smtp-Source: AMsMyM7YKK7r65732mFBCXddEPMQRqg/w9h2rNf6WGsGCmawqtokvokp/Yg9qeK3S0oDmyeQCPVuJQ==
X-Received: by 2002:a05:622a:64a:b0:39c:e12f:7c84 with SMTP id a10-20020a05622a064a00b0039ce12f7c84mr9764822qtb.530.1666037360678;
        Mon, 17 Oct 2022 13:09:20 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006ce76811a07sm536793qkn.75.2022.10.17.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:09:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>
Subject: Re: (subset) [PATCH v5 26/34] dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
Date:   Mon, 17 Oct 2022 16:08:07 -0400
Message-Id: <166603728602.4991.8167754247616925634.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-27-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org> <20221016170035.35014-27-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 13:00:27 -0400, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> 

Applied, thanks!

[26/34] dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
        https://git.kernel.org/krzk/linux-dt/c/7d3da666f2c0f9416f6d1a2c436b87a6d9f61e79

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
