Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9E70541E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjEPQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEPQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F9DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso1492842a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255171; x=1686847171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bEIQKulVyoGacD0MGnKSqqvX67XDAgaNe2mnib6hEw=;
        b=QdTqKBavAGM14oyXYuUWl8873YGf2HuLRLJV7VosTiQ83SDsXRJcJfYOIymlHdKTds
         xXvBX0DxYxRc3JNoLJ4oNaopwP/+hzTYnJmLXQ9XeBAxmmskOkK5HRDvFNZzgnOx5J/3
         iRMYQzPMlCQguN+385V9STkDx5463qtVQuICUS6Op+DH7cYREXlZFWb94HQN76s7x6Vw
         inIwBkQ1SxhLSAxEIp8eiap1R+xyOZrYEzbWFvWrlWXG4Cn+BAvFYR90FydztaWrN0OQ
         1AtmVhBQybtbWC0vkP3iVhHRTpp9YaYt/UyHVQ8N8XTg3Ssirn+tv7EtQ57Cdx5Fv6pI
         W+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255171; x=1686847171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bEIQKulVyoGacD0MGnKSqqvX67XDAgaNe2mnib6hEw=;
        b=MCT9W56no3h/uLwPJS/vIjoQQC1L9UAN0KMeuUkcbd2OxixPSN4GWgdFZfJs7ObZ1i
         OetqczLL1hm2/1GMA43+VeDGlW1LdBkSAqVNub+og08eFqVciObtkcAJStX3a8uYyeUR
         JyRNo74tXXEFDAjc5YYCQ83A0BTvYCi7lpNwFeNKCSygIXAcW2vd72e4rlpzYIp1VkNt
         a9vldCr9Bgz/VhPhWhGq5x6twTrwEzJo558X7ndhCf8iIICSM2ZD8cYWRzFAIKoIKHzh
         S0FoBqBRNVBZMqZmO9DOAeChrMW9hgoKz0b3IyWkqdanGNEWo5sZRrqCxRTGXj9ykq9V
         uINg==
X-Gm-Message-State: AC+VfDwuA94fzwhm6o1ohS2otYLYi3uSgbTEMp2wbIHH6++9c3aGRNog
        NpkRyx/nE/JX56Ygjsy8fdBl4w==
X-Google-Smtp-Source: ACHHUZ49T+bYsW3SF/ekTX12TCde2LvEMndw3aT3uZuMLAjhuzxJclBTwPGll/xYsY6htRyzxbhixw==
X-Received: by 2002:a05:6402:4405:b0:50b:2088:3533 with SMTP id y5-20020a056402440500b0050b20883533mr36436979eda.1.1684255171031;
        Tue, 16 May 2023 09:39:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm8278191edp.25.2023.05.16.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:39:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amazon: add missing cache properties
Date:   Tue, 16 May 2023 18:39:21 +0200
Message-Id: <168425511042.243008.3170014874681490114.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223141.115072-1-krzysztof.kozlowski@linaro.org>
References: <20230421223141.115072-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 22 Apr 2023 00:31:40 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   alpine-v3-evp.dtb: cache@0: 'cache-unified' is a dependency of 'cache-size'
> 
> 

Applied, thanks!

Please let me know if this should go through any other tree.

[1/1] arm64: dts: amazon: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/9f921604a91c637eb57e57668045ca5c21f49f05

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
