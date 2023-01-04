Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DAB65DF9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjADWHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjADWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:07:30 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EAE13F61;
        Wed,  4 Jan 2023 14:07:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy8so21965134ejc.13;
        Wed, 04 Jan 2023 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhoWMiObP+lGi7qDb0lfYkefrU81cw9zmlAnNgHY45E=;
        b=Pvr9GZNKmNncfbwqbIASOIHTIuaa1J+6+CplGDFGy7Wy5yOGmIKhYpa5M1nqaPHMHl
         +9wr7Ei9wTkLpzwEIwtngV4TFPUJjcV9au0r2BtTYQ6xqIfVMqdTzr6mVwvckK3zTB7G
         4Jd8jiu0bhXJDpA3aEAcmzw9P8HdS6dzM1UWWtXFJxG1Q3DhslmQIX3F21GI2Z4WXU/s
         yylSMxw16ndHA6AG/tsD9TdJKSZj+FcG1xoaewnY+54UnCtdkOVyb+1lDO8RB/YeHmUf
         ujpfFbrtgISNF72Uq48KVg7KQqO4HdkLKiEMBGb7MQ5sNZUvpL7muyLhhG13POs/Cd9L
         F49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhoWMiObP+lGi7qDb0lfYkefrU81cw9zmlAnNgHY45E=;
        b=sKOk5bANRM5X21jU21SpGlZk4AX6nMCHIqeEk0KlsczK3p9dLwilkJrgmkSEUarPXc
         REn+YazBZpG27+xOkgnIZTf/u+rTOgZZL5+aQrVbCTvoqXQrWn2aIS9xy5RPTG5L+NgC
         CzrssSlZrB9g/6Jv8NzAKVFfov4D2x+xQDzLeHDINSdZzV0q4vwpqBaZAi6lbhApov1s
         h4uBiQJW/uFzZmSvUERx8Tu/3l3NSLnA6sRAuB50c5NPIjbdmZNGdkwMbd3FB2rdz/Nj
         HpFAjlu6yhV+LzbRXQx8Qbri8XSXXdVMokPDW0ALxFMzhE84kboA0aDBNo2Q+xUxpaGS
         jS0w==
X-Gm-Message-State: AFqh2kpzKwkgGheR4lHbkWEZn0VoqIiazjr0qXtrQfV0FQSjTVw/arLB
        QSCz/F3vEr1++9JtY6wEebw=
X-Google-Smtp-Source: AMrXdXs51RVJi2p23UPs8+iGyH2XmtJRRIrud1/3hjnvoCBObJGAnahuCFZj3MqB7w6cSO+O9+Xj9w==
X-Received: by 2002:a17:907:2061:b0:7c0:dfbd:5a1a with SMTP id qp1-20020a170907206100b007c0dfbd5a1amr43992128ejb.33.1672870047733;
        Wed, 04 Jan 2023 14:07:27 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709065a9600b00780982d77d1sm15713189ejq.154.2023.01.04.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:07:27 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Date:   Wed, 04 Jan 2023 23:07:25 +0100
Message-ID: <22917211.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230103010903.11181-7-samuel@sholland.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 03. januar 2023 ob 02:09:03 CET je Samuel Holland napisal(a):
> D1 contains an IOMMU for its video-related hardware. Add the node, and
> hook it up to the masters which are already described in the devicetree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


