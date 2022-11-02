Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F1C61642B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKBN7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKBN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:59:35 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B82BFD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:59:34 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id n18so12477408qvt.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJetwfvjxdIvW4nB9rlQ19J4HqAikiDjl+rr3LFuEmM=;
        b=aOtOzlnQIGHFhEufTKaooGBt7MAhROj6VHRjy2Ye/b/0cuLg/b/Wc48xBVUSIBxAyI
         YGNpNyC6v69ZYTA6xQ6mSu3WU0aR3JbuLOGUUiwZQEyQHOYTn0R23uyL25I3Ro7mXgXl
         IpAYkeRNQaTBRydfFK00pZoqyQJZDDx9u4tc1gAoY9DmQCPl8SdXU7DpygDgY5yuF6w2
         UNqJwR/R41tiVbii+KNoiN2jp19gwQUbAXu7fv/zk+Ti5h3r+9cd3ygLVtg/XvxPNbh3
         NmsrGWbv5xH3Gq3YzQlhrCIIrDINXPxJpegBQBOtHD+sDNPIPosjlwnihW1bUHthtthh
         BOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJetwfvjxdIvW4nB9rlQ19J4HqAikiDjl+rr3LFuEmM=;
        b=yrh4QQaFhV51fhtMC0PyFux9ps7+cMNvWtZ82lgSCScHuWPzbxoI825Rjp0QFZOPf5
         5ficKe1Tv0Llyo6WV0G4mlpqoZePH/wQciwpEEjoe771vsmKZVcQ7P6+F/E/2uPqnJgG
         k4qT/AoQexaIGiYEtYRbkoerD5T1OgH7sANSCHxYvA2yqyRoKyfZtc8gXataiZTbOeSf
         7NbnyHiwOpWw7SyEBGFq54eDRymfNlKO7SceSyMAmi3m60GXU61JLLWEvoYByqCcTmPb
         ULzt+gtrzadiA9TglP1Yr0awch6NXy3EoW5UQahLv136jhlzmFI8wmO/xtgUkuojGzkN
         gITg==
X-Gm-Message-State: ACrzQf1eXat6eKJ0kQPKa/kwvG7LWHqxua1yThsYZWiuOaYbak/PvSOP
        d99lu0JNUSD2xoa9kUcDDeD9CA==
X-Google-Smtp-Source: AMsMyM72GAbGWe0Tdc1dmRgk2Dt4EiaIN1W2Ehtlt3gZ8JhcjPyq8e68X7xpg2f5M1FlJMPS//ze/g==
X-Received: by 2002:a05:6214:cac:b0:4bb:5477:c24d with SMTP id s12-20020a0562140cac00b004bb5477c24dmr21014882qvs.116.1667397573259;
        Wed, 02 Nov 2022 06:59:33 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id p7-20020ac87407000000b0039c72bb51f3sm6601960qtq.86.2022.11.02.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:59:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel-janitors@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust ARM PRIMECELL PL35X SMC DRIVER after dt-binding renaming
Date:   Wed,  2 Nov 2022 09:59:30 -0400
Message-Id: <166739756718.5285.12762879609460217696.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031110223.30203-1-lukas.bulwahn@gmail.com>
References: <20221031110223.30203-1-lukas.bulwahn@gmail.com>
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

On Mon, 31 Oct 2022 12:02:23 +0100, Lukas Bulwahn wrote:
> Commit de67fa80c669 ("dt-bindings: memory-controllers: arm,pl353-smc:
> Extend to support 'arm,pl354' SMC") renames the arm,pl353-smc.yaml
> memory-controller dt-binding, but misses to adjust its reference in
> MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken file pattern.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust ARM PRIMECELL PL35X SMC DRIVER after dt-binding renaming
      https://git.kernel.org/krzk/linux-mem-ctrl/c/3821e96a01d658e770074331b56cec88c169a418

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
