Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878A974CF56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjGJIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGJIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:00:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104292
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:00:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e292cf214so5441872a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688976026; x=1691568026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAeFrhACdp94XF1ndhJ9bb02rOnx4NRHqy8PSIYqL0w=;
        b=iYm6GWl72rhldQ2eA4H4LRwz0borU8OQxILMgVT47VnVlqR2KW1aOAHS4Y2iGWm63I
         XfSYkjqmLC7ipXOLtEBl1v6Xe0OjSUT+3rE5eCt0uitBCAR/i+xB+wLVEXo5XN6xVrzr
         wtVjidYt7dvYVU7P1ub669OnfrHb+yQ8Thg+rtlDKP68z7yYWe3ZRhQlo5l+TLZH0akC
         NTFR9isRZosJ+McKI4RlZsKZc/bX0hHuTdlpzWWQ9O/BI/GoEu7A57+LlgTc+r1uFTYZ
         dIwQUf45J/ztD5PuyZ06E44RMQgQZWt5tvX2HSkY/qUbV9CT847n3F1khYfOiv6sIpDl
         xgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688976026; x=1691568026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAeFrhACdp94XF1ndhJ9bb02rOnx4NRHqy8PSIYqL0w=;
        b=lHmXkiPvRguNe68DuQ+iP0NglXyuQeI0j0zIufkFfT8VdtE6OpcULyFEexC3rI401K
         4P+uszth7bKHq8gmP6oIoWHQe1lhAeemLy8TIglznBpSFvKDxoCRznhW9If42lTES7VM
         PAvxQ/fLbx+uClD9fjQaHMCKbIfklEg2UhMbN8JxW7KXbZ3i/NNCcpZq+b76UvBtteZK
         QFN4BEfgBneidkefDQOrJ5eYxW2WKX3m7scFYIbGne+vLyCFxH9o0yk3FGpkIM54Lk4t
         cdAUa4hacmpZWU1pSst1uZLiCsXRDmQkZQywxe8zdNbUnPcdHI3oviSTPWdmot4KWfgD
         aeBg==
X-Gm-Message-State: ABy/qLaYJAt8qfVpdrd3um0ZZvhECo9QqDuXGhl0983lQJzgUDbO1RxF
        9PYe4jCfOKltKluIgCm6luPHmo4LFoFpGqF61Z0fEPFS
X-Google-Smtp-Source: APBJJlHlSjojvo4WY0Ux9AFb4qe0jBfXaNqbowxtGcF5eo38DOV47g8KLzeFSFY9hywJX/jUpJ+/zA==
X-Received: by 2002:a17:906:72c7:b0:993:ea6b:edf1 with SMTP id m7-20020a17090672c700b00993ea6bedf1mr7430361ejl.0.1688976025721;
        Mon, 10 Jul 2023 01:00:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id br17-20020a170906d15100b009930c61dc0esm5819123ejb.92.2023.07.10.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:00:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: add missing space before {
Date:   Mon, 10 Jul 2023 10:00:19 +0200
Message-Id: <168897600949.19079.4403147383403836109.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705145942.293527-1-krzysztof.kozlowski@linaro.org>
References: <20230705145942.293527-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 16:59:42 +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> 

Applied, thanks!

[1/1] arm64: dts: exynos: add missing space before {
      https://git.kernel.org/krzk/linux/c/476ec6416f0df058c8a20b2f3b8bc9ebc3746c9e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
