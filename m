Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A56CA9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC0QHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjC0QHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:07:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697B2688
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:07:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so38534699eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679933230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LEsDycoDNNxiuweLLNkVCjBLy1OwMwyxbYDv9vom5U=;
        b=pPbTxNH0ymm/YMKamoshQU8TY9g5bLT38o6aex+MqUWlO56U2WBGW4kKRxU5toxzQW
         fLq9wljTRSgdD/SNk3umxElyHAtWjagWir3tguwLug8WDmM4FujxETm7B7kPz13YAONo
         EkOOmftrFozf8j9K+8AAqWP90HyOXkLQd2m+mUS3wZOnRi6H/dZtUkwaDcPHpfEQ62i+
         IwiXyp+3sH/vUdyazYe6+UIKeg8uR+t3o7NAFbp5+nMBRRthYMe0jMKjiQAKLcspHcNm
         RjSsDUjcDUgIjDIHq+FTspeyk6BDjYZ4BhEb8LWUlwgHp0qm69zsZxi0eOJq4fvMiqLE
         07jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LEsDycoDNNxiuweLLNkVCjBLy1OwMwyxbYDv9vom5U=;
        b=oXtIoAlEvbN4AoVZA9Qc0aKfL1su2z1Vzv7VMSbQFJU9QHBW/RUnK8YzDyQHZZJMIH
         Roipb4F9Ph7BFmgfOVKCHGX5BIwa3ce9/Td2NDuN6xJqM8qJw+Kk+s4zi0shEpruRY3R
         nlKMJz0wsr1zZNh6jWx2/w+muTVQxHo0egZQRDmt9/8LwGiC+0TM/9x7QUmukIXaiFPL
         jKr7WY6Y7A32kiKBCC5NjRBDgJfsXnGGwEW9QvMPFwsgnazwqzjDHUFKg6kDhZAdraX1
         l7EJ+UAJ0F9ogDJyqubKPj0NfJFNgoHbxGcUX0rKW8sPS2nQF7Vnv74jHU8lVR+0fKkU
         fbmQ==
X-Gm-Message-State: AAQBX9fSQnu1fBtjNbugNAdwo3eoJMxDJW0rpKEoE9jJhhE2nw2J8uSL
        0ysChEZI/+f72YyHEFhnMuKBGQ==
X-Google-Smtp-Source: AKy350bG1gjpcfly7fVco4g5TTDffVoqBAJyfj3y0NuqH7ZswKxBS8s8PhmNNfNfw9CvFBV4It9Dbg==
X-Received: by 2002:a17:906:a8d:b0:878:52cd:9006 with SMTP id y13-20020a1709060a8d00b0087852cd9006mr13713393ejf.69.1679933229936;
        Mon, 27 Mar 2023 09:07:09 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090607d100b0093a768b3dddsm8787820ejc.216.2023.03.27.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:07:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: (subset) [PATCH 1/2] memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of MACH_STM32MP157
Date:   Mon, 27 Mar 2023 18:07:06 +0200
Message-Id: <167993322006.178792.4595537654296937780.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324155105.826063-2-christophe.kerello@foss.st.com>
References: <20230324155105.826063-1-christophe.kerello@foss.st.com> <20230324155105.826063-2-christophe.kerello@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 16:51:04 +0100, Christophe Kerello wrote:
> To be able to compile the driver on all STM32MP SOCs, we move the
> "depends on" on ARCH_STM32.
> 
> 

Applied, thanks!

[1/2] memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of MACH_STM32MP157
      https://git.kernel.org/krzk/linux-mem-ctrl/c/20c082a2ba25374a13505b78cdad7f6a2cf8d763

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
