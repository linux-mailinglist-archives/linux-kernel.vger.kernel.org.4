Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58C68909A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBCHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjBCHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:17:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4275C918B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:17:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so3812115wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSkASq83cJg2WOe2/nzv5anWuC/vJ2xsJwMGh8943ZI=;
        b=qQXuLP7dIGRSpmr5eLEf94xOWMsnU6dk0lGiLtuEa88Q9ZY4c9NbgFBpdihUief7Up
         8pLFPaTI+0muOhnPf+hlEGlvnAR+QCuaiq2U3uz3pcdnLoU2yLKnKLUt8kYihUXu4kcM
         YqprYsaaL9Wz1nc8rKPUZ66geW3Wwheftm1tX37PA0r4VZXoiCaAjEC0j0rBVr/1S545
         lBFSQBEdIQqs/HtcZZ/xYhsCQeb+2oDGy9bbVmrF5jq9hx4wwb8N4kSYaaX9vYFVwO1q
         WRC99+Va84/xpY9nXtixYoqYmygJNMeVOz2EKH1PXKAQJi56hWerZ9ZHBJLs+wZJ2rap
         Km0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSkASq83cJg2WOe2/nzv5anWuC/vJ2xsJwMGh8943ZI=;
        b=bqehtqvE3S8wZTtprdXs+lLGF7xdQCYI8zzSRXfBMSNeNOepnzU+Z4crEo0e2hgd2z
         p/iFRXyEvhcJQLxWEa0RawFnsVGxiyGudV9Vg6DNnmb4vrtcX4du1G5bJaYylSglYVtM
         xxdBjUSksCO7Ed7n9oDSK3S9DjViw+Euc8StIdaKGKl3lCgX8PNr5j9/dxB/dgRRbPJH
         m12M+ERoyqWOFC9qe0rJmJrJX3guNgBGLZHklDaKh7IsvGj1HlWqNOa0bIJ8ia5pvYfK
         2lGzV0sfAneX9L64FTkigzm9kWLzHVwTVxcWt5Gmbp99HGUEUlJuwCcd1ND+jbEA3u/F
         w9Gw==
X-Gm-Message-State: AO0yUKWpcV5eyHhL4rkfE2effpGnqD3YqQeF1TcO78rh3PH0eDrb7hy3
        v5JR5wxx8yYTzrrjMSFdKq4H5kNIkN6CZhCg
X-Google-Smtp-Source: AK7set+3DwO3EzLOyttbMzw58HIbpgMQrSBHpW38EamYD5uQa3Hjgvlx5oaK92gjI5qg6MbymWOFuA==
X-Received: by 2002:adf:fb4b:0:b0:2bf:c4be:e987 with SMTP id c11-20020adffb4b000000b002bfc4bee987mr6829170wrs.26.1675408650389;
        Thu, 02 Feb 2023 23:17:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bff574a250sm1291828wrr.2.2023.02.02.23.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:17:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: (subset) [PATCH 3/3] dt-bindings: pinctrl: qcom,sm8350: add input-disable
Date:   Fri,  3 Feb 2023 08:17:20 +0100
Message-Id: <167540864401.6835.8158822534844887891.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201154321.276419-3-krzysztof.kozlowski@linaro.org>
References: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org> <20230201154321.276419-3-krzysztof.kozlowski@linaro.org>
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

On Wed, 1 Feb 2023 16:43:21 +0100, Krzysztof Kozlowski wrote:
> The SM8350 HDK8350 board uses input-disable property, so allow it:
> 
>   sm8350-hdk.dtb: pinctrl@f100000: lt9611-state: 'oneOf' conditional failed, one must be fixed:
>     ...
>     'input-disable' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[3/3] dt-bindings: pinctrl: qcom,sm8350: add input-disable
      https://git.kernel.org/krzk/linux-dt/c/91d04c759c85f1fc2d3ed7d1b5bc1a7dbab87f92

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
