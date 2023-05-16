Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44300705429
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjEPQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjEPQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0143E50
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9659f452148so2629315066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255175; x=1686847175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTWTKFPQqufD1J+n6tKdsRsFigDvmtHUdmXy2csDmWU=;
        b=vQg6isPcHOpRXFrwJDtjtksISq1zeFGuZRzpR/eg6L8xEYPiD43PosxI4Z3cTfVI/p
         4RsxA7wuXhym38+EWIRr/qACpSrud7F8/QXECPkT/cUFDSS10rBsPuya4trirwz8bbYG
         hrBfcSYM+RYqx9CeIEwv0CTq6BhTWQt38YXcxyYwCkemnPjJWS3/hvCKMegd2wKQnq0a
         BwbdZiNyb2lIMjmGqy9Y5kNIT5jN5gKdldSNKwwezCKXqM/do868qUNqCiipajRLi0k9
         aRA0sVIFRd0if8kBmgyeZcGo2bAfO6el4avQn5FgNepy6LdqDVjo4qLpRnavF/uM+Jf4
         NdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255175; x=1686847175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTWTKFPQqufD1J+n6tKdsRsFigDvmtHUdmXy2csDmWU=;
        b=llY7WNpa8wFMsuhjCptuwPqEaWDy3z0tzEG0HgeyOda377rktNuuWMA72kgVBQY3e4
         sWenSmKrQMtDqPIW2zEiDyCkiAuLHf112WHeNZWN/SI7f5tSq4vh4Se3zqO5YDQSYjjs
         AyZZ4CUcQC1InECqQVberGGkztgW+OtGiCooBScN42XxhuMBuXpLd+6gVPyPiCXESF/W
         dn6fEoXHGt4aXjcC6PyVnH/EgfZdndDgEXoFMAJqeLSoMOKPktcF+v8mTJYlFPO1o60k
         R6Xivz90PJIhUExEyhB75DRoXsUe9VRwsx3CaaOc9AAayt1tIx0n8MbhK4qzbc3q34BY
         qnpg==
X-Gm-Message-State: AC+VfDwz6fBsZG59oYQWz9zovvWr/papEErEXgLJ1J3ukO0gJLWkL0y9
        RLR64N9SQAZobPfYve6hX9uYyA==
X-Google-Smtp-Source: ACHHUZ4845heaEIIyLhytXK2xejR6yiqTedvHtHDINxISFTkUPthbcJqciFZrVf1zX0HQzTz3lZcrA==
X-Received: by 2002:a17:907:7fa7:b0:94f:553:6fd6 with SMTP id qk39-20020a1709077fa700b0094f05536fd6mr40625949ejc.24.1684255175399;
        Tue, 16 May 2023 09:39:35 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm8278191edp.25.2023.05.16.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:39:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: synaptics: add missing cache properties
Date:   Tue, 16 May 2023 18:39:25 +0200
Message-Id: <168425511043.243008.7308253075007236545.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223145.115129-1-krzysztof.kozlowski@linaro.org>
References: <20230421223145.115129-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 22 Apr 2023 00:31:45 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>   berlin4ct-stb.dtb: cache: 'cache-level' is a required property
>   berlin4ct-stb.dtb: cache: 'cache-unified' is a required property
> 
> 
> [...]

Applied, thanks!

Please let me know if this should go through any other tree.

[1/1] arm64: dts: synaptics: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/3740a577eaaa224db6e4bd3b6fdaea2fb3729814

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
