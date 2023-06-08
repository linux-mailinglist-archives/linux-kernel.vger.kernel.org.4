Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF27285FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjFHRJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjFHRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:09:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2302695
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:09:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so6319095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686244166; x=1688836166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTPmOQp+qFA828Yk2a/Gg/HuOyPG12vS163GsUtONY8=;
        b=SwC3MqxK5lbgVQHewPe0fy+769Qpx2swm+D2sDUT50gbalQRtHHVeHmsdnd3fmXwBH
         RBobvnn+WZbFDfF09K9E9jr9Z4cDAzGttYNlCPeY20AIe69c7Fl06sQHgs6haqfnyThH
         1VW2OxqB3fowI4hCAKvcwmAiP5djjEHRmslYui+NMxRR6uiI6VvzMl6oZuwpOMXWQy2u
         PWA3RH18mI0kWWZ+odsJ9D4IjIzxJhmePHh1++Sgweb5ReQdqat/eduRx77y6HHSuA/B
         kBpHcmFjsc8xVQPuwmY+6j4zz51VpEF2lIkxsC1Welfsdu0tSvhMT+e4z4O1hXHTB68L
         0J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244166; x=1688836166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTPmOQp+qFA828Yk2a/Gg/HuOyPG12vS163GsUtONY8=;
        b=Y/WitwmaoeKu4Yes/5HBYAljiTn4hiW2kD0IWUWw4i0y3WkOgyEIdqzeerUlHQK58E
         +GEgdWU2JZKRfbGytSINyntQMzHwfSg15wHyzgwckS87wqsMiJZVK8vVneuptBYngPep
         QiYr1rfAxFLlmMXFUN/CXzL/sx3u9zZ+29gbhkR8zLC+AkTN19x96hyndNxoCBb7KXT2
         VREaVpC7QJ/mZA5leqWBQJ+qZpx1HXdUi/mep03ZZtiHQ3NO7BHgXxLitBa+gSYQSeeK
         h/N14gcpynMwzrl/3GS9doXWqqSaUvVH8jN1726+vYJaWgt3TlycO1aLN3KGrAsc5i99
         z0HQ==
X-Gm-Message-State: AC+VfDyjoTtkLkceLoMzROetuz0KRtDb/zRcm0zBzH+BFvyOhLQg0kkh
        qtqClQfdDVnav3qgYergH+CUOA==
X-Google-Smtp-Source: ACHHUZ66Z2HtOrV/blaotwHoVVTQMW2zz/mtlvyuY7NxfVvT3A+tVsXMfZX3OSiBsqdNHm69vhRorQ==
X-Received: by 2002:a7b:c455:0:b0:3f6:5cbf:a3a1 with SMTP id l21-20020a7bc455000000b003f65cbfa3a1mr2069259wmi.14.1686244166163;
        Thu, 08 Jun 2023 10:09:26 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b003f427687ba7sm148251wmg.41.2023.06.08.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:09:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
References: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: nvmem: imx-ocotp: drop unneeded
 address/size-cells and children
Message-Id: <168624416510.17727.4833007391825860716.b4-ty@linaro.org>
Date:   Thu, 08 Jun 2023 18:09:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 06 May 2023 08:41:28 +0200, Krzysztof Kozlowski wrote:
> Referenced nvmem.yaml schema already defines address/size-cells and its
> children, so remove redundant entries.
> 
> 

Applied, thanks!

[1/1] dt-bindings: nvmem: imx-ocotp: drop unneeded address/size-cells and children
      commit: 4a43546dbd0b15fc21994a95ab565721f24c59d0

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

