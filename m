Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46946B68C2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCLRVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCLRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:21:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3802E36095
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd5so5967888edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678641689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rvl2+raF1VE9ZzZN/isKLzxMu95bS20jrPGDIvTdQ8=;
        b=SkNGmn6eN4WFwp5BSyxLvHrjVKhcPG7qJ0BxzbSwC8bkjGWmC4tr9YnkcC6ibAjE+T
         3xdQ3tZX90pKpGWOy7y6M1Jq49x/28OhLfToIgfZux521kSRr6ZSa0m2gMh7iVsj53v4
         YOTy6H8ibSrd4hOA9TIYRqxQGDAiXmNdRc0QsSWcLRf6Qo5T1oNiQ+GqYM+8jG0k7+sT
         HZ4RUpaWXBKACGFmMJeFtp/TWbEz1yb97ozuGcu8zkb1MQsPIbrC5c8J9Dv28cfgsse4
         QpiS68PRPSYl5U4rduDa40NUSn9fkMBWb4FjQNJlstGHs9EpbDg/VAZmr30lC1+3gLtm
         R+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rvl2+raF1VE9ZzZN/isKLzxMu95bS20jrPGDIvTdQ8=;
        b=h2APrYgBfi2IG0sU6FLgNwtkt+9drgzYG045M3pvYbwsTf4k1EOexxrVTDQr/gcXHF
         Tj21hDA/AQmcMEjqTpm6U/1gd7SXp6tCqPNlQXM42Sis9pcMNRKpvAY5WXf6eCgSB6XL
         QHZkWOF2U1LFI5Xo7gorvt6cfdkR1ccqZKHg+XdYANCcSTgBw3oWShl1G1EI5JmqtopS
         uyG2aQe7XfAQ3sRbsM+kmhanG3oh9VABg2XImPMj111aJgWf6EQJQPRXOBfVU4BXOPTE
         J4Zt2xAHgonqDPm+PhT9Xr5uNOTGdt+a5b6sHrkc9kZlDTp1zIrIxjd1xbgJEs10VUwJ
         UM6w==
X-Gm-Message-State: AO0yUKW4DcmYa7Fwa/oK6S12Mj3SFQRWEcN+7Jwermm/iDkoZoOWX8YS
        weOJlPd+HiviNqDRrT/6XHsLlA==
X-Google-Smtp-Source: AK7set9LFVPJ2dhVlnw2yeUCkRxmvPoUNkNZGXgYlqVFeyncSypQLv4J8WsjipbWcJx60OGboFy4uw==
X-Received: by 2002:a05:6402:12ce:b0:4fc:709f:7abd with SMTP id k14-20020a05640212ce00b004fc709f7abdmr943678edx.2.1678641689636;
        Sun, 12 Mar 2023 10:21:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id y13-20020a50ce0d000000b004fa380a14e7sm2055395edi.77.2023.03.12.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:21:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ti: use "okay" for status
Date:   Sun, 12 Mar 2023 18:21:23 +0100
Message-Id: <167864162128.395859.14700084165667327132.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
References: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 27 Jan 2023 11:18:36 +0100, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred for status property.
> 
> 

Applied, thanks!
(Patch was waiting for quite a long on the lists, let me know if anyone wants
to pick it up instead)

[1/1] ARM: dts: ti: use "okay" for status
      https://git.kernel.org/krzk/linux-dt/c/1792375be092b4d9da34b43240319264363540dc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
