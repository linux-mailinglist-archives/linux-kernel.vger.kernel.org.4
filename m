Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5225B30A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiIIHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiIIHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B912952D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so768475pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kxmb/p4ktWi0LaVAY97x3wA4lwaARgi2y6i4pBXVFUs=;
        b=yjdQyDYXCkQEISvA2OJfS5zQAiKFez8uh7EkGE+bB+QXbyoZeRvpAdUhX9ECJYFXLy
         ZVydMLnMLqe+rMd14ACdgcomqshszupE3p2ZRckxL7TK3LPV/W2fjMBr4KmiparZN5d0
         FYsWwHKFUGwe8qaIqbdzkeSNVs4o5qDU3ZQDUAlgOVRUAlpFcGl6kPb0WEZZtyjTmoEO
         aIv7kEMYpim0e1B9RMIyTmvbKBsbdzMs5WtrBCfQ5RN7qeIJeU/hbhFSAUq3Uiu5CJOl
         9ElukId5p4IgxA5722sbVj841jPcpfTDItekZVuZ5yYum8hX010FjA6FEDJhc+tZtFWq
         h8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kxmb/p4ktWi0LaVAY97x3wA4lwaARgi2y6i4pBXVFUs=;
        b=oMVd2LRpVK9atPTzVenkn1WTPNyC8KHE03A6S+z9mJL1ItkE+cVfx0bbufvZRIAyO7
         eYGbDKBVr5ej+wwPlSchRGmOnZ+Z51zz4i/TpP42E40YotekukSrR3VcpbIDteW9YdQp
         XJrlZSj5OY7SIR7lNwb6P5JP3KBKC22wpuhv0Kf5sjIiIDvLlPcsG0ChP7ftT3GXn4Ui
         CG5OrMEQSwPKcD8VuPpBrBRCx6HKUuTlXsWpAQ4avuN6TageSvzVwuhfpoGScj/GuOwO
         z5aNxZSqZbK1x4HyMERXMEVA+Yg0Dq4JC4f2BZyDG5CXfV8fCOXz8LgWQmKYI84qptjk
         2frA==
X-Gm-Message-State: ACgBeo2QoR4tm67g3b1/qACC2R7KW3TkMk2nVl1ex3O5tKg2k959oOYa
        zGWr4exdZnOObf0cmPnDaVEaow==
X-Google-Smtp-Source: AA6agR5/NUEdO/80jCJktybIQDOEEQirkfdWkcIHXIMd96UzV1ogZS/nFo3o+sgb9qn99Yww1m6I9A==
X-Received: by 2002:a17:90b:4b48:b0:1fe:35dd:d92f with SMTP id mi8-20020a17090b4b4800b001fe35ddd92fmr8001528pjb.138.1662708923523;
        Fri, 09 Sep 2022 00:35:23 -0700 (PDT)
Received: from localhost.localdomain ([124.123.189.206])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001780cdade11sm456800plm.51.2022.09.09.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:35:22 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     f.fainelli@gmail.com
Cc:     andersson@kernel.org, arnd@arndb.de, biju.das.jz@bp.renesas.com,
        catalin.marinas@arm.com, dmitry.baryshkov@linaro.org,
        geert+renesas@glider.be, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, michael@walle.cc, shawnguo@kernel.org,
        soc@kernel.org, vkoul@kernel.org, will@kernel.org,
        Naresh kamboju <naresh.kamboju@linaro.org>,
        lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] arm64: defconfig: enable ARCH_BCM
Date:   Fri,  9 Sep 2022 13:05:09 +0530
Message-Id: <20220909073509.301363-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220906033957.4377-1-f.fainelli@gmail.com>
References: <20220906033957.4377-1-f.fainelli@gmail.com>
MIME-Version: 1.0
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

From: Naresh kamboju <naresh.kamboju@linaro.org>


On 2022-09-05 20:39, Florian Fainelli wrote:
> Commit 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom
> menu") introduced a new symbol ARCH_BCM and made all of the Broadcom
> SoCs Kconfig depend on it, but did not enable it in the defconfig.
> Thus, now the defconfig doesn't include support for any Broadcom
> architectures anymore. Fix it.
> 
> Fixes: 96796c914b84 ("arm64: Kconfig.platforms: Re-organized Broadcom menu")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
