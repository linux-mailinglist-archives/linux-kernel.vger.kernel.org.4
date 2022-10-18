Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3B602D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJRNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJRNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:39:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DE2BE24
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:39:52 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a5so8595705qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+sLgrbsGMQHlemgqQ7Mq0DFwn5lvuXfVQkqzsmbPPc=;
        b=Z8Yp8a8zbodfJ+0cy6HZrLXd7Wj9v77Qx8shoJarMrcirS/pY3TTcl+uzS+HqtjkVK
         6SIJFTRTymA+j74uqIA+VCx6ufHwulAgozSQG9U+Loubt4n1kDhJFQt9hPsHOCqppjnI
         BZo0TLOvoXy+Rjc9q9oGEhDrUq/JOwd8a8CO7BkdE/45WKP1AdyKKUa9K/Cin/t7SqRn
         sid/jFqbBqHfaoofCViIqQ1SvdLmH/7tBfaKaq/aoBc2vzff96n/HAUPEZtpJIMK6tRA
         EpjG3sFT+ApgAbBrgwLmdFX8Q8T2+apOr89qgQDt8c6GaJw1AOpiNi0Jb58cSr2w/MQT
         nC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+sLgrbsGMQHlemgqQ7Mq0DFwn5lvuXfVQkqzsmbPPc=;
        b=cwV1vj/aN3StqT7uHaQGWQ9nrsw2f4B4K/Khw52n3n6suiq95qRPJp6zJKlWm9ma+j
         kQ5xGT8ZONyRSPbjg1jl4T2wC5h8pW6tIwBKduBg6K4pA+QWkZ8BXLs8JZuMko2JXSbN
         uZXtNT0B+5/Hy666Wx6RPQwJnTu6d04kDGHFz6uwmfZmnYzvNQHZ5wfuNv1XUWq4dQ9f
         78lrE7T+63OVCR1K7c+3LIQ3n7WCpn7b3iKoPBfmbEbE9A+iFf1w+aSQabwtp4Vcn6tH
         vVMpJwpqRXQ4YsH5+48E4JqjktM8faz+tkwKzOeuj8eVdCbFKPeMFHtrZD2HVYnP11o9
         AInQ==
X-Gm-Message-State: ACrzQf0KeKNNnumSb2yvSb+5TGLK5XyIUVQU/WQKSpHemej6qDKa6irV
        1EG8/svn7eyE13gITc/4vIUWNQ==
X-Google-Smtp-Source: AMsMyM77QVLHqie0IxFfekeRYS2BibCfcZ0ghwPBj4VV4wG0myvynk87fYbUHdKPYmPTDjePFO+BGw==
X-Received: by 2002:a05:620a:40a:b0:6ed:2700:e080 with SMTP id 10-20020a05620a040a00b006ed2700e080mr1767424qkp.649.1666100391578;
        Tue, 18 Oct 2022 06:39:51 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id t24-20020a37ea18000000b006c73c3d288esm2368713qkj.131.2022.10.18.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:39:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ARM: dts: aspeed: align SPI node name with dtschema
Date:   Tue, 18 Oct 2022 09:39:46 -0400
Message-Id: <166610038083.12522.14381298437428190883.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830180344.15657-1-krzysztof.kozlowski@linaro.org>
References: <20220830180344.15657-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 30 Aug 2022 21:03:44 +0300, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern.
> 
> 

Applied, thanks!

[1/1] ARM: dts: aspeed: align SPI node name with dtschema
      https://git.kernel.org/krzk/linux-dt/c/50c7e281f44726249b5ab7f148c02bbba751fea1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
