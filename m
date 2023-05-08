Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6276FA2C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjEHJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjEHJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43822F5A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so46612547a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536406; x=1686128406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6EzVNW4fQCTXBtSpkwMKxHbE3BFH6PMWEnMor5twLE=;
        b=SfvyVxQGH4Lbdph5HqGS5KZ3pG8u6JRGK3cWkMYv/OBBUd3qn0UWqTN/CdDNY/OJLf
         hDeUxDuK2ekrSaRLhfpPsLl/XXTSqcnGbTkasqrCno42ZION19NHy3EHDmb0Nu8mu1xF
         vWfygMBgyu8nPAIqlYt7nTYEM0YjaTx7KaCWiXb1hijj4R8E4qq7vzWbE4R6GKDMM3le
         /RKX2uPBFSlqN/RFJpIUAIaZ3ds04rkS+6pn2Tkqvdl6Z7bK/XNdSREAx21HOe2JvjZ+
         CTXNuUYtYThe3HZESUj5dUP8eppz1ivbkf9/NBzxW/ZBGiyA1D9A5i1FhPjXis72OsrQ
         +ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536406; x=1686128406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6EzVNW4fQCTXBtSpkwMKxHbE3BFH6PMWEnMor5twLE=;
        b=YI0q3Xr+O64APHzjLgBFbToHKeSybXpuSeFtdzxbABMDr5gxIf+LGcQFzHXvhOZiQB
         4NgOouv3JnRnqU9zIhBqa6ip8YJSLZ4GZKzDev3gwXVxyU5ZHmLYaOw7H2oDZ62XoL8M
         p3t3H5JVLzEC4nadY2yqn8LDV0z0HOKaKH/eHmVSthlToOt1h3BbiNcBIq/Y8u6V80T/
         LXWWzYBhGgq1srDB3LoUXG8Iw62a6qXDIk8wy8M5L0oWsgYjShTqj19hyv+mIGVDI5ad
         GZttEX3ZVuK4a9R9iYDaKVsioJCNOX9BI91kxiv3PSp2OCWbZmDTS+om7KzZWLAIfizz
         OrBA==
X-Gm-Message-State: AC+VfDzU1R4QxrxFqjJTv8S3Y7bj4JuiA1QYcQyACoZmeiZc4+9WnnOT
        piWe8RaX643MHO4O/T8XgMIl2w==
X-Google-Smtp-Source: ACHHUZ5Nt5reP/wn2q6YaROGCfe/lUqNih2uJatZFAE1xj1ueZq4nVu0hWnQmynarzRg459hOzotzw==
X-Received: by 2002:a17:907:988:b0:965:ccc1:5468 with SMTP id bf8-20020a170907098800b00965ccc15468mr6468069ejc.36.1683536406421;
        Mon, 08 May 2023 02:00:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds2438: remove redundant initialization of variable crc
Date:   Mon,  8 May 2023 10:59:39 +0200
Message-Id: <168353638586.78189.11302089932389518914.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220522194622.13277-1-colin.i.king@gmail.com>
References: <20220522194622.13277-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 May 2022 20:46:22 +0100, Colin Ian King wrote:
> Variable crc is being initialized with a value that is never read,
> it is being re-assigned later on. The initialization is redundant
> and can be removed.
> 
> Cleans up clang scan build warning:
> warning: Value stored to 'crc' is never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] w1: ds2438: remove redundant initialization of variable crc
      https://git.kernel.org/krzk/linux-w1/c/ee896c5bf21cbac3bed8f958507a449168e965d3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
