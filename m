Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817460E5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiJZQ6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiJZQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:57:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E53AA3F9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id u7so12011771qvn.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibt+O2tRTC+XLIJvsYeu+FwATyn84kd6eVFxBJYzFqM=;
        b=BTzNOwChQMX8aKTW8AI8KKHYOGvdjHDW8bs74afSFW+xfiuTfWaa7zu8WTbINDkaD4
         sacwNqHHcvHGRwFKZzkSEnZhaRF9XyB7XoPlvukfhFwOQtzQJlDqO2G2FaWeJpwLV3VL
         MHvXp54waZ77Jh6Jp1VIEc51r1zlNiWNr6RghPY//tCIZ09YBYBq+DNeVCcw2wwJbHKx
         r8jaE+q5U9Q+9JNVRlCmRD+ryXZ7KUeyRpSR5BV1/oGBnZZtbtWF7MtWWhx7IKcZo+Pv
         nyfwXH1bTbiHDmXg/sRacdyxDlOIT/Dnp/xkDZSKk50e0tjh1tNkJ4Qm1ZSEZ2HWHKLP
         SroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibt+O2tRTC+XLIJvsYeu+FwATyn84kd6eVFxBJYzFqM=;
        b=vKUisOQkjTWHuUUDSJ8mq6mOLi8MN/qVeJVvR1oMLF5W09/LqlWU21ojrHQY/nbjw7
         uhbNI6/PFfxuEa0jFbJ4zzUqn3Q3a6c41/tdTwGd4pAk78+N86BsX9AmQB5w4e4SRvCN
         ndFIAW+DktggGH/aIfyEQLjvgSmtb7DLxE4xYx6wolerrewzEG5kkWXW/ZW9BS6qjAs9
         XxKZmsz70BUIPwSRaj2GWIbQyubt7QfSqyp3PdAd4aiODKDW7qNIqt0We6OZGD8hSgSO
         rCN7dlPKQPyd/KhOE35c23L6/z6pghguWKm5E3F3KcF5q2I85RCMqQaL+qYMiT7gHNBv
         FPXw==
X-Gm-Message-State: ACrzQf2oghvd9HVAbyRdTJoQahtZ9HLp80zFhOgRUra97Xnbi9G/XYnt
        +aGVgZhhRGSAQiPMH9x4bZXkmA==
X-Google-Smtp-Source: AMsMyM4ACU6ItJBe0wOukiBoP1PRtSubMbeaD1Eftx7piknoX9MXlQ6HV64ZJCRcvGJWxMvUX3E9VA==
X-Received: by 2002:ad4:4ea7:0:b0:4b9:365b:2a86 with SMTP id ed7-20020ad44ea7000000b004b9365b2a86mr27663607qvb.58.1666803475559;
        Wed, 26 Oct 2022 09:57:55 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm4360759qko.53.2022.10.26.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:57:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] ARM: dts: sunxi: correct indentation
Date:   Wed, 26 Oct 2022 12:57:44 -0400
Message-Id: <166680346262.49767.5734726885417469609.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002091959.68815-1-krzysztof.kozlowski@linaro.org>
References: <20221002091959.68815-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 11:19:59 +0200, Krzysztof Kozlowski wrote:
> Do not use spaces for indentation.
> 
> 

Applied, thanks!

[1/1] ARM: dts: sunxi: correct indentation
      https://git.kernel.org/krzk/linux-dt/c/2970b5ee2e7d642da306827fd8257fa18ea9c09f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
