Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F570541A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEPQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjEPQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293001FC3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso1492685a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255169; x=1686847169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdE6rQVwO6h2KNb8VdfjQ0+WIgss0cnwggom+xyvQHQ=;
        b=dlRjaEnRnTVyeKmp0c/GNeCa4MdfzFN1mjULVO616k/lvjA31glSVPawlSLTUWOczA
         JSMRrNXroYDKKV4YL3h3Feg6nuWiPFdsmEuD+LQ/YkVva0+8mYQO/ci6tbZpJwmSMUbH
         Cbe8REmBTiNOkw+v0ybQFUiUSIoFLorx0hKj/mk8XN9LWdMHFWxYW+OlQdPpWC8a47jA
         QZBSaqSdSpPyalDbzc5gEvPgo0C1Rc7tOWnbysc9Kh9kXF0KH9VgPZbHsGHD9bcJ4Afv
         s1E0eosdT0jL7IYChzCfnC5tM2b/rpR3NAfPzm5+obaLTowN5jomdRc2OpaCBBJ4YN2K
         E45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255169; x=1686847169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdE6rQVwO6h2KNb8VdfjQ0+WIgss0cnwggom+xyvQHQ=;
        b=PlpM3wVZc54AwfA1Pj90Yir3VouASU0waOO9W51+LwFvNQ2Qv7brD4RPWI4ElD63Xx
         28P9PAiBHWh7AnSC43qjaHT8WLB4iVJouTCfY+YcsuOAmeyzA1m7tmA+qlLb20TJwRAZ
         qo4TfJFm9YwWQJ/axLUX5l4LKj16XaxzkUJODOUOkoaipoKKbUAiHHkXfW5PkarnFAoE
         cpMoTJzg3vFk6rbsgX1XK39dP8FI1QrSlt1Noj/9bpsSh1SiAvW023pOV8qLhW+zvtcn
         GmW8mrtviGeh1Khig+1GXNuCDeWZxTZg/a31wEucW9KAai/c+WUhb18KQlhUbONk2SlY
         CVBA==
X-Gm-Message-State: AC+VfDxN2FtM5mr4xaH764yxV1XIx6RAly+imQmJgGPyoLixHT+nc94a
        5V2imNNBclyk3xMiK6R8PhOW75FI0MJGHnf3f1k=
X-Google-Smtp-Source: ACHHUZ5D/x8CQ1hyl5DzYWBTCdtlxBikcktVZkXe1wItsnn1SfqN/mK77HbHn+5BOxNE+lrYHRMmrA==
X-Received: by 2002:a05:6402:2036:b0:50b:ca1b:addc with SMTP id ay22-20020a056402203600b0050bca1baddcmr38244775edb.13.1684255169639;
        Tue, 16 May 2023 09:39:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm8278191edp.25.2023.05.16.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:39:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: add missing cache properties
Date:   Tue, 16 May 2023 18:39:20 +0200
Message-Id: <168425511043.243008.7280065132171806679.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223137.115015-1-krzysztof.kozlowski@linaro.org>
References: <20230421223137.115015-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Apr 2023 00:31:37 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified property to fix warnings like:
> 
>   sun50i-a64-pine64-lts.dtb: l2-cache: 'cache-unified' is a required property
> 
> 

Applied, thanks!

Please let me know if this should go through any other tree.

[1/1] arm64: dts: allwinner: a64: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/4c84cced9304303ed1c73e35277891249e3cc2cd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
