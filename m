Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B646FA2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjEHJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEHJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFD22F7E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso8300002a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536409; x=1686128409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/H1upgtCnHxzYSl1fYJ5Hrcg82PV/hD+4RG2T5Tx/w=;
        b=ga1H6kuCSUMPNPsnReAPq1IRKBwHxhimLQqfDZ8m0VbslqMYFHv0Et08HvVCaziidR
         NeKaIp1yrLKZrVk3mRNwOoxuX0gtd7QQYKloBMkGIEy/VV1gLsPnVMZd79oAZ75aglVI
         FtW9AwxK2HhVjSPrp5CrIV6c7i0B0VXHjJqKD7z1ublzlNGmYKq7g4cKzk++JZ/JVejg
         CTjDcRThxud5rkz7kXbZ6y20exW1Myh8k9utj6OhNuTBnBlco56VKVHV/CjnR2+6yM6T
         eDFzfap+PdUZbPOAb4aJV5ZKWr+vVycglndWv+vnfV4cKAqP8pfP2sKsP3GQkOhxF/8P
         Tcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536409; x=1686128409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/H1upgtCnHxzYSl1fYJ5Hrcg82PV/hD+4RG2T5Tx/w=;
        b=VseFvvlM9aOniokSqtvq6akvJrhpXfqlmRwKyVteytpsEWaSFOA11aO2A7K1D0Hf/o
         bkoEuyqkajH1OnaRX9vKL4iHx12B+oRKmk3ek8yW7hny4xaGvjqNpRJHPk28MtXuH/7Z
         N3d0eVxx1IkZaHR6U3PhYSNFarcub3AjQz3Mqo0BlFJ+pL5WekmVBGPziB/gONPGrKNc
         +KbXyxw9u3atbDbllChvtSDDzqUoD+pjwoF0TtZ7QYzvAt/aiJBjm4O/tvpkY4Ag2CkD
         ccQVycc06gqqDYLD3xQYtp9bTIhV7RiTil2Vr/4e49IM29Qh/9MSNO4NBFmdyYsBY0iA
         j/6Q==
X-Gm-Message-State: AC+VfDwLx62bHnejrjkxAufTBfQtOfP/wrWDuPaxzw6QBWPbC7h3eqgT
        yacAEmJayg8moNj6+7Alaok/Lw==
X-Google-Smtp-Source: ACHHUZ5bR0r6/D+EbmZ9e8NdsDz+4DsY5Ca1EO0SkffalMfYbwaO/MadLDP88tpBNiR8Qkl/9LfGrQ==
X-Received: by 2002:a17:907:9705:b0:953:1f45:3ced with SMTP id jg5-20020a170907970500b009531f453cedmr8751279ejc.8.1683536409402;
        Mon, 08 May 2023 02:00:09 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: w1_therm: fix typo in comment
Date:   Mon,  8 May 2023 10:59:42 +0200
Message-Id: <168353638586.78189.1389224210896468946.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220521111145.81697-6-Julia.Lawall@inria.fr>
References: <20220521111145.81697-6-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 May 2022 13:10:16 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] w1: w1_therm: fix typo in comment
      https://git.kernel.org/krzk/linux-w1/c/7f25058c96a0631f4a1ccb4c70831c52e71decf2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
