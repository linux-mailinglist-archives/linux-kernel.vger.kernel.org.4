Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BC602F34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJRPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJRPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:10:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654C844EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:10:17 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o2so8789682qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMAxnAZ0lY3BYBp2PAMVfD2+NC6qxURrY1HP1VJlTBM=;
        b=Eg1r37/ZWSnnaNCASUgc5HoJwpg9gqs2kXqsKwbv6JHgzTLlBn1j1HDTyi0bfm6U93
         2gz68Dtd0TIAL4zVp1J2ax7P25rX8WQRbSBntVcKm+MPEji/9IedIft05m3nLOKEqsCh
         /CWfmfWHSq42fEcoMZ+UIrqU0fVfJg1dxvp6iwKh5t6Gh5zunGMBcm4OupdEzwCTk1Pt
         enToLaaUOgHR5W/4pbSAxExfuzO4/XYH/VO0Xp3e18JIjCodDWk7PzINuITC5n5r0Dwd
         jJFc/K9al22EAbVQA6c+LdOoPFDlQdO+5cGCflgrspcuMOtIPHzaIe+7/GwwIJf8rpOA
         MDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMAxnAZ0lY3BYBp2PAMVfD2+NC6qxURrY1HP1VJlTBM=;
        b=SwLC9jhR8s3ZyoOuk7BqDFm7xe1z13loqnB4bc8h5LjP/VlAegk70ZusgY3f0amCMd
         lGqCF48W6GzR/eSLCN4ST3KPwhRxf5GkQBFkhouiObDgpiUMNP2IvxL8qWUpc25P+vCb
         kYicI0IHqZmfgT9kqxYSFIiUK3kXOPBb/X0qkTY2Wnt+gzM5DEWU+Mx1qgXiFdNMRyD8
         Y5kSf61OhSDO1Ymmxeo6ksnyhsGEFQfoRFmuewdhJwrL5dbUKVYLFy5BaGJ6O8+mJUMr
         rkr7efBFCrePOIfsPnoyPIEcM9uWIlof8SKNoW0er1t6n532UWTqfFd3pgbuHXpgVEkl
         HPPg==
X-Gm-Message-State: ACrzQf1RJI34aXrLN5ofdY59qcn5Ry8AhCAusJhlVYHY5tWMKXc9JtX+
        9yO6h/7yLZIN985vlHQWF4xSBg==
X-Google-Smtp-Source: AMsMyM66c0rtaFXS/z2v7DITRQUeHDeKtsXVjE5wDaDRu4Z10cBs9CeP4To54SHyKw+4aOlKHt+c1w==
X-Received: by 2002:a05:620a:1981:b0:6ee:c81d:d146 with SMTP id bm1-20020a05620a198100b006eec81dd146mr2135860qkb.201.1666105816280;
        Tue, 18 Oct 2022 08:10:16 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fx12-20020a05622a4acc00b0039cc7ebf46bsm2035297qtb.93.2022.10.18.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:10:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, Jian-Jia Su <jjsu@google.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4 v5] dt-bindings: memory: Factor out common properties of LPDDR bindings
Date:   Tue, 18 Oct 2022 11:10:10 -0400
Message-Id: <166610580692.30968.11562735981650899285.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930220606.303395-1-jwerner@chromium.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
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

On Fri, 30 Sep 2022 15:06:03 -0700, Julius Werner wrote:
> The bindings for different LPDDR versions mostly use the same kinds of
> properties, so in order to reduce duplication when we're adding support
> for more versions, this patch creates a new lpddr-props subschema that
> can be referenced by the others to define these common parts. (This will
> consider a few smaller I/O width and density numbers "legal" for LPDDR3
> that are usually not used there, but this should be harmless.)
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: memory: Factor out common properties of LPDDR bindings
      https://git.kernel.org/krzk/linux-mem-ctrl/c/087cf0c5a19c638dd3b26fe7034274b38bc8db6b
[2/4] dt-bindings: memory: Add numeric LPDDR compatible string variant
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f4deb90635ec8a7dd5d5e4e931ab539edc9a9c90
[3/4] dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f4f2f33f148b159a7a6ad74d77e715ed1328904b
[4/4] dt-bindings: memory: Add jedec,lpddrX-channel binding
      https://git.kernel.org/krzk/linux-mem-ctrl/c/9067db882716ed5650f9342da5406795955e6f39

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
