Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213F9708A37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjERVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:12:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E519B;
        Thu, 18 May 2023 14:12:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f40c19477so163510566b.1;
        Thu, 18 May 2023 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684444364; x=1687036364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwCXb3fk3q19qGCTHKa24w6U9eKfPUvrvysf9WTJ4BU=;
        b=iwkF6VPKMkga/+WEV8fG/yVkrzrrI+VNiyuUAHg1JGOWKez9AL4FsMdsQv8W+qefES
         Q3Lc7NLEEb9zpijcwsgsRo/F5rEqvbxjBfpNE9/8v5Ub8+bPQsMl5YfdndaAB69MdPsN
         nbiJ/OCwM4A71ViOzrySkJd0xMMzrQKX8Bugq663eNqGxSObuX+0qm2AhUSbBBilXQ9W
         /dKc4iRsjZW8830rZQiK2uRqXc7035OoPNWDu1K5pLpausyharqRV3F928xQuLqeY/6i
         vXWZtQb5oASWlZX35my5AMele3zyXIenZOCCAnF2s7pfT6OLs4u0k3eqOD3Pv9uWnKjY
         t9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684444364; x=1687036364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwCXb3fk3q19qGCTHKa24w6U9eKfPUvrvysf9WTJ4BU=;
        b=in95AxYxdQJfongXFfuk6P+SqRM3bwTT+tBhdeh9b7xv1PiA/7CSxnzL3ooMGJkgC6
         vpvUXPtVHBs9Q6o3uRdhFRZ7mTdd04iA0pMxUcj3W0rqowQyKg9uR4rgxstR30qDQg7a
         089TTjlcirz0oEZFN7MLeYWzyKwWLmCzHrQtz2YXT1CHx37vAA8YWfrNnQmAbFswOLtC
         tzMMjbCJBR57lXmsB/eYmCdFcb7+SMjSyckoppdy4cUh+2IFTRpTyfHnCYrvEAAnsI5H
         bj2YDZ1w7pPWRGOoMYJ+FUzGdk2ozZ3WPALRSUho9q5iXMt7v6xpmZCl01RSiAbpp2LF
         9tAg==
X-Gm-Message-State: AC+VfDxo1mL2o+8jIcxIrr+bgW+vpzUk077uAo/TtrzMpHFnMtUOK1lZ
        /brmZBa+vy2+CLDwXv82ZYY=
X-Google-Smtp-Source: ACHHUZ53JeCer2PKB+m25oEFcv9u0KNWbXEekVWG+UOqzYDpisBpzOo5K/OJG+slZjH748oVe/36bg==
X-Received: by 2002:a05:6402:396:b0:50c:cde7:285b with SMTP id o22-20020a056402039600b0050ccde7285bmr6192872edv.29.1684444364501;
        Thu, 18 May 2023 14:12:44 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id dy1-20020a05640231e100b0050bc4600d38sm962189edb.79.2023.05.18.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:12:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 5/5] riscv: dts: allwinner: d1: Add SPI controllers node
Date:   Thu, 18 May 2023 23:12:42 +0200
Message-ID: <13265211.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20230510081121.3463710-6-bigunclemax@gmail.com>
References: <20230510081121.3463710-1-bigunclemax@gmail.com>
 <20230510081121.3463710-6-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 10. maj 2023 ob 10:11:12 CEST je Maksim Kiselev napisal(a):
> Some boards form the MangoPi family (MQ\MQ-Dual\MQ-R) may have
> an optional SPI flash that connects to the SPI0 controller.
> 
> This controller is the same for R329/D1/R528/T113s SoCs and
> should be supported by the sun50i-r329-spi driver.
> 
> So let's add its DT nodes.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Applied, thanks!

Best regards,
Jernej


