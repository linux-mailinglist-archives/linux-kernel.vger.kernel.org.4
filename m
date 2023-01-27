Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07367E09D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjA0JrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjA0JrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:47:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7F77529
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so5013182wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1gKbVgcIqydPba3eQlYW6Ymr+cSYzBXrGzq4BW6VKI=;
        b=mm3eSNuK4KI9yWmRHiIYpXdsU6S0CgKDNsw+L8HvfBPOmBMX/cgfUIjOHWejVrI2ly
         8sDGXyB3mIVDUbiXFcenXhtBvGDuLutnN8ZcjtlNuTfVRikJpOlJeWkJQ3WzqZ1xpKg1
         /hD98o8IvWg/YAK3kDEpjaUAp1NGcHHC+y7t4IZVbTesBcUfwlcfJPAJs2AhV5T/DO1v
         64JcgJjbcAn7qMfTY8XoT4OirfVoCH4sIyBSQl4E80NyPRdCjJnI+jpXNa1cUgFN+P7g
         erNzqXgvTvTfUH8Gdxu3RR3nSaYLXA/mYxg9AypJYpFAeh9UrZF4p5sBRhNmUEY+whkR
         tUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1gKbVgcIqydPba3eQlYW6Ymr+cSYzBXrGzq4BW6VKI=;
        b=VQukzAtisP7HyyywESL0tA4PY4Wv9Fn97076gIk+Ad3seVaFKJ9pbwxxdxJqbNBQzH
         KmJWFFh0MLboNWcGUIwl2eNPLzrJCk7FCgikoZflNHOjK1Y/2B4v7zf+Zt0YmBdeLkwR
         Zcx5g3W9ibE4exCzZdfeuF89k22goTvBBrjskEWyH8rYdbfRMYYeWG34Sg7DhxzV/yMM
         iyxyaACEZLQ95lDMuwj1/8VZdPKpx/8QDuEy4Q7PDrlh7zMko8aZfTrj2IGhVttTXjAY
         /snLDTYvz27Oc77m/aLnA8ZtL0L7hqz+k7vm5IbK6U6qwfACELg/VZlfQRyTEBl7MLlT
         VcvQ==
X-Gm-Message-State: AFqh2kqSQrOIdn/t/Tl2+kqrc1Xmf8H9vgLMT5UudM9du6EHEF0OiiGG
        KQy3z7Q/9bwmKCNTi4M1BuC9hGwXDS7qyA/R
X-Google-Smtp-Source: AMrXdXsnLoRY6AVVl1gxjVvFDye4SfVQJky5hijXGYFthi0IoE3zbsJtaM60ai3O5vXAQxQJcfnYNQ==
X-Received: by 2002:a05:600c:1609:b0:3db:12a:5e65 with SMTP id m9-20020a05600c160900b003db012a5e65mr38124869wmn.4.1674812824093;
        Fri, 27 Jan 2023 01:47:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm8042087wmq.33.2023.01.27.01.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 01:47:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: synaptics: align UART node name with bindings
Date:   Fri, 27 Jan 2023 10:46:57 +0100
Message-Id: <167481277324.62929.17565623262865894621.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151540.369690-1-krzysztof.kozlowski@linaro.org>
References: <20230123151540.369690-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:15:40 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
>   berlin4ct-dmp.dtb: uart@d000: $nodename:0: 'uart@d000' does not match '^serial(@.*)?$'
> 
> 

Applied, thanks!

Let me know if anyone preferred to take it via sub-arch/SoC maintainer tree.
I'll drop it then.

[1/1] arm64: dts: synaptics: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/0a9b7bee0056dd686da688f530ebd7f00ec4652d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
