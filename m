Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5B664E38
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjAJVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjAJVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:43:31 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BDA10C9;
        Tue, 10 Jan 2023 13:43:30 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id o17so9418044qvn.4;
        Tue, 10 Jan 2023 13:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/miYmsKl1wbs3ZV+fNSe/W+Bse5by10Na33oXSlTsc=;
        b=P4wN8iNI2XuWaJhJTLNQIjda2Rt87NSa6r+mKovgU6G2YgjKEPP+X5FXlPa8JIjQBX
         pQIzmiO1fKAY5+PZjG9G0MEssO2qnmV2jJiJ9rWeoNslCO5ojO6CWcybcY3lulnLGc0U
         c9dzMgfhOpMBkEBsUHfB+iJ7082Y7cQ2F8PxPRX0Kmcc3tkFNOR1paYC0h2ONK38y+v7
         vIDpTDT9kqNdHjiOU3sCrpq8QmvB/q19XP4RvfO0JUBKCUagbOSyb1QGVh+LpfwTfWYH
         wzVAQJkxfX04wcDvPrO71Ip5vctw5jWfzFqoCeQox5SYfb1Infcx6y8NkB5otFIqBUNL
         yEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/miYmsKl1wbs3ZV+fNSe/W+Bse5by10Na33oXSlTsc=;
        b=OIRXohGAmdKpTRMguBNVjTt7Gfs+4JWmNXVDXrBSoJrETX61A6bds9qMrSFM+iG8Ey
         GgLDRuwjIi1QVZvRt7uFBYt5Jp2wCrKQHTRh1LPn+fAXI+PxDnikRl/g+c5q0AAeCkIQ
         AvDx4YpgSd3G0KMwrLRC2c2QQvxpuTOUdwEi+xCV8ogKezjZddzAI/7riEDXxAqtXaBN
         t47wSdSloId679oFl3vFi3fSR8fCjgH3ldHRcbcvwCThMN6thqW3Nzm8Hsx3o/cLqPc/
         EKJKLWBviIYPfKekymJh2igLgJcuu/Nla/QbIh/vkKm4ChunbDb8CCYlgwyeiw+EutFW
         DV8Q==
X-Gm-Message-State: AFqh2kpK87d4+RnRHOYyiCRFhg7TDhLOsaZVHCtjFeZvxZxTYUBcWVMu
        CObHXIsg7OD8Vhpyduwy5n8=
X-Google-Smtp-Source: AMrXdXuBwC4MqmRqF1lDmUuSaQ7zyxcfOUYzg+rcURTZuAZEUcH9w00aHKR4QMJuY3a3LROIWP4Xfg==
X-Received: by 2002:a0c:b41e:0:b0:532:3b1b:12f5 with SMTP id u30-20020a0cb41e000000b005323b1b12f5mr7129425qve.38.1673387009379;
        Tue, 10 Jan 2023 13:43:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bs15-20020a05620a470f00b006b61b2cb1d2sm7962926qkb.46.2023.01.10.13.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:43:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: align SMMU node names with DT schema
Date:   Tue, 10 Jan 2023 13:43:26 -0800
Message-Id: <20230110214326.1006022-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222092456.79203-1-krzysztof.kozlowski@linaro.org>
References: <20221222092456.79203-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 10:24:56 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> DT schema expects certain pattern for IOMMU/SMMU nodes:
> 
>   northstar2/ns2-svk.dtb: mmu@64000000: $nodename:0: 'mmu@64000000' does not match '^iommu@[0-9a-f]*'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
