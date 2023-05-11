Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95276FF630
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjEKPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbjEKPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:41:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72094C3F;
        Thu, 11 May 2023 08:41:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965f7bdab6bso1439159966b.3;
        Thu, 11 May 2023 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683819674; x=1686411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQvmwXze/gAqnIrgLBTRF6o+N3iet63b3mZHiWkHo1M=;
        b=R+mM0kDvSAW9/bcQxchnx8KMaoBJkzUgdxFshMn3eziIIGnQj4hUwIRJ5QJmvD9PsE
         rsvJ2qdw8grzDjiCNhyrsVxtqUBqUTeZfhyym/KI0oS7K8nQom6jjwU6t6a9t/SUJCgs
         drI/3UKkfV0Fjr+sSUjQcyYEI5nfjxrevWeodqgra9gNfYy1uh2+yAxyjqd7sx50PztG
         IKPMaC4MBwS30zHmOgHPdIORETB72ERmSnrFnfEhM2EoiZSXdFrIBfsfWbc+xMfpcMxX
         2EYTLQWrBSQvOqP2fz6Jz0dNEoNu6gBilktSfirZ7kD6Th+alKOwND418ifu2LjrVQRb
         maXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683819674; x=1686411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQvmwXze/gAqnIrgLBTRF6o+N3iet63b3mZHiWkHo1M=;
        b=bM9tsJq7nYuWHBQElOz7BDHc9USKeM7Qm/cZAqimI5ru1MM6OxXbkY63+/1mcZIQLW
         SotZYt9RCHe2iuMTmkSPYtD2s+OCi93g80XGlBs4AWQtRIZ5rtC5P8hJX83sLxvdSX4G
         vfLbqZGhiYvnb5HHdee+hugoABsKDTVeSlWAEk7j+OxtPvnJs8qdfjcxI0N5dGZREv90
         o6Vtkz117rvim8LZDzyBDSBA31ugn4Z2mHyeNtzWpR8X54hzuM2VIe4hXiL1nzxbRayL
         LzNT1aIh66wmMeyWMMToGTGDcyt9bn6pa3WDmf2TVoyyuk8gIFVoPFottG2eg+qpyQPK
         POSg==
X-Gm-Message-State: AC+VfDybHCfg2vfnE3XJ1Rm2/iDqIIYMQSdUK1n/YAXKSiRN5bnU/+4E
        TbHrHPDgIriBfpXxvDwlnrI=
X-Google-Smtp-Source: ACHHUZ41ANw5B2GkPpvpGC9WwEa6jWcyO6TJtFU3f5cKq/IkQ3D9s43WRsjgI6WPzHoEL79KPbR8IA==
X-Received: by 2002:a17:907:2d09:b0:966:4d75:4a44 with SMTP id gs9-20020a1709072d0900b009664d754a44mr15271821ejc.24.1683819674270;
        Thu, 11 May 2023 08:41:14 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id p1-20020a170906838100b009662b4230cesm4257581ejx.148.2023.05.11.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:41:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan McDowell <noodles@earth.li>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: gpio: Add GPIO3 for AXP209 GPIO binding
 schema
Date:   Thu, 11 May 2023 17:41:11 +0200
Message-ID: <9107543.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <e22cd891ea966bc18411d01d5e3b0d94e7ba6869.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <e22cd891ea966bc18411d01d5e3b0d94e7ba6869.1683719613.git.noodles@earth.li>
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

Dne sreda, 10. maj 2023 ob 14:01:12 CEST je Jonathan McDowell napisal(a):
> The AXP209 has a 4th GPIO, so add it in preparation for support in the
> driver.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


