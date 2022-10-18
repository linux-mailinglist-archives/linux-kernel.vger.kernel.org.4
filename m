Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636DA6030A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiJRQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJRQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:18:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7DBA240
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a18so8992437qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfXQOph32UX9IYZF7VUKwsVbx3Bfrh0LaQCPntJl1q8=;
        b=PQ/WUES/0qJkwlPa9kA6G7KxZUIrrXJ850sxea+Rhhz9CMj3m+Qhj80SvntgBcGYvf
         CdvoFlo6h95P6HPxP+/QfGdvVcRS6YzNt+ZKeanBn37qZl8sUXLAJYUohUiVktqvJsm8
         ys6eQmNzcujMad4QjP8ncKtLo5fK58O4PrrovqhqEzJ29wsA/knGmdi4qH3NSoT94nwR
         VBN9eLKZ7G/uT+Jd2vnymmJRUbycnDuWOOOrfkYvwGnQTKjemX6ZqaDAA3CcK6dASZsx
         7lNBM4t9jp7xp8it/IeGgjwcOmFRIw/znpKsTarOxQQaRkZ7Viwuw/qDlox/5LpfqaTn
         s8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfXQOph32UX9IYZF7VUKwsVbx3Bfrh0LaQCPntJl1q8=;
        b=RhQu7OZDJe0LZH+D9Yhml9Jwj5dRIxPATMFFPt/oUmUKcdoG0HbwKWvMifZLo1LhBi
         6oiE6BuqgozJB8gtQRqId6qpeEj7JfIQIqQCfM1sAxXigL/w4sNnF36/YdJ9vr1+s+g5
         8RHjp5u1FH5A4tbmb1WEAxYNShaA3/s79DARQJZtPETgfT9St2bGomNv2MgM8ct3A1Fj
         fMqiSPwoDvlOZoOP7CfXqH2blHtglMIJWeQXwt9uCBVDlEE4Ia1OJCBukFoS/KC9qqHc
         nkj+oqhm5mFkYcIsB3xSN1Wnmw7f1BYCMw/xCzF7uPgKPFdMAHU2AuweXQEgLBIOKWJp
         tNBA==
X-Gm-Message-State: ACrzQf15YxZmG+MDn5DHr5nzQTUXq0eXtf7fXla4cHbBZ6i3tX/5Gu8i
        z4bmurgvVh5wuLMaU3SEOj1pUg==
X-Google-Smtp-Source: AMsMyM7QNK67QeiljMHnNlAwUfZ4UtA5jEqr8N9AOLenSRGBYFqVbOuMTVQLDPfwXw4ujTUydRm9ew==
X-Received: by 2002:a37:5f05:0:b0:6ec:59fe:1ab4 with SMTP id t5-20020a375f05000000b006ec59fe1ab4mr2418722qkb.111.1666109886975;
        Tue, 18 Oct 2022 09:18:06 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id r28-20020ae9d61c000000b006ed30a8fb21sm2636342qkk.76.2022.10.18.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:18:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>, linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
Date:   Tue, 18 Oct 2022 12:18:02 -0400
Message-Id: <166610987888.55974.11426485803039631163.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
References: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 24 Sep 2022 10:13:12 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> 

Applied, thanks!

[1/1] dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
      https://git.kernel.org/krzk/linux-dt/c/6ec92173475be614cd20f997f9d24135b7ba01e4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
