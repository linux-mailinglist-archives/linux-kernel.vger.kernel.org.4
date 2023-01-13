Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB96694D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbjAMKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbjAMKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:27 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4F77AEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:51 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id l22so21686268eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy20KsCcUl9bSSkhyBei1oVtEZe09/gfEby+z93IJGI=;
        b=lOiaHtlhvTCSXTL+rpDZ47++FitVE4HYSEDbnbKOzc2sDA7pQ0zk3rULAM0D4UCk2f
         LM6WJ0lgTZTiWLbcGXceq5rDTTsKcPjCNGI1ySLUaZmO0k2Dzjy6MOIiWh/RPgVbTMl5
         9dgKsTz1gBy//X30jUoPJp1vsXBTILwy8ZF5UhEBIgbR1yukFrblIudyWvo0Lw+zDrfj
         wZEkeyoBtdGsG+GcqL1kfidLnYDAlbAHeCFN8IkL21OnXoULVKHmPzujfRMYPwvkATRE
         sqnesO2LQnjbAbSZmXtPtH1VumMIVoEe/kaJzr20mAMjRAmD/C5MBi3a5oDzerEngXku
         726g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy20KsCcUl9bSSkhyBei1oVtEZe09/gfEby+z93IJGI=;
        b=jngWojCCLCZaitcTgNfCRu4OG60lD+YKwulUxKWpCzutVfK9XtXrAGg3HrYQCYXOs2
         JKx0VMyzghzfy6SBzTkmaKXVLj7SZ0KS9pN+xuV3GRIQB4XTsTg5yZ8eJlcca7oTWGyE
         uSkuOpxr5D3AgpB/f5Stlj4AGxK56D0bVslnHLvpqcW/4B8xJiolcaTt3wyzYooRhgb4
         N0F07aIoZpIyg6EfPR+wZsdlu+90YZc8PpANjxmSQnGWRnf66Mjq/OhQBQQbuKpjNkco
         006vZT9pH4YL42tDHlzWre7v4mCtS8wow9yPPriZFUHl6DRCsjxqIu4qFO8ZJx+IxSCG
         6R8g==
X-Gm-Message-State: AFqh2koOXMn8X7KljPTO8t/T1HHO5OMWqqc1I0FS1um00Zd/X2yMtLu3
        fXwPExXjx/L2D8dVbwD+zJTQ4g==
X-Google-Smtp-Source: AMrXdXtnNcjB+a7YjRD0Uw5tzrqEBfV6aJOa6I+iPpzcQPtuTpXPz0acJjen+w0E6FPw3SQcI9QT8Q==
X-Received: by 2002:a17:907:c388:b0:849:e96f:51f4 with SMTP id tm8-20020a170907c38800b00849e96f51f4mr60976963ejc.23.1673607109955;
        Fri, 13 Jan 2023 02:51:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm146352ejh.205.2023.01.13.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:51:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: dove: align LED node names with dtschema
Date:   Fri, 13 Jan 2023 11:51:39 +0100
Message-Id: <167360709873.32944.12518045742249154896.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144125.477032-1-krzysztof.kozlowski@linaro.org>
References: <20221125144125.477032-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 15:41:25 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   dove-cubox.dtb: leds: 'power' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] ARM: dts: dove: align LED node names with dtschema
      https://git.kernel.org/krzk/linux-dt/c/30a39ce8fb67d29d475f2bd8442039ac0d09a43c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
