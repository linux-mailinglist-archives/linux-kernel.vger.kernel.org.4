Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C36FF144
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjEKMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbjEKMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:12:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E6DC40;
        Thu, 11 May 2023 05:12:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6434e65d808so9053963b3a.3;
        Thu, 11 May 2023 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683807127; x=1686399127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM8V43HV5eUK2A17FVMfm5fRlCo6gx8Wknm93Db1fsw=;
        b=S70vcyPN3W9y23gNP/AtXu7WgMNuOe3+8OvWOrtIZNWMkzu+LXhAvgZtv/mPKQtwwa
         yivtXJknrj81vK9Ys8nNQ7ioau4gkLxtPjIcmcqh64kombIdDox3TMt4ixQQxZxgchen
         MQ05IVoHh4nkiZ8AGILgH1vWm5yj8mZQsfbZ6XXcqYo1k74G0xwN4fsgUdRWIyhOF8od
         abrMYyHyK1hHpgj7qJB/GI283vI4n/2nX7By1mMF10V0uNEkFgXSPKJGZ9yqJoU7wTjR
         TM4NbzH17cPDaRfjFzSou3eMagBPQdQNOcE+HCxch7suuug2D4MVPoX2/7pT1+pyTVym
         CfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683807127; x=1686399127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM8V43HV5eUK2A17FVMfm5fRlCo6gx8Wknm93Db1fsw=;
        b=jAmKs+O5GT1RoD0Oeldu7DOOe+uduAQq/OzO2HP8F9Oim1ftrXLa5NHIcv17oeoYl5
         QxIt0VyaNxnwPNHJHsSVC9EF7d8bHVSzDYnYz0t8YdmjR69dFQj1SogOFwW/5Yct+yI/
         1A30O5fJ9vNlv1UoG792A11OKMOS3aZhHEdgNvZPkEfNBEWLRieCXUeC5dIth5vGSIP/
         C58W6ULkdZkTe20lJciIfLWI3jWyVoJbob/qfXUwMPjY1FErAoXT6XNcYCcKfeGJFpki
         03B3jFKpQ1bB1dKkBsYR9+bX28st/rsdwxM6V4uWz91W4P9qCRRZA4cVkjSyJEyPq9uB
         oY3g==
X-Gm-Message-State: AC+VfDwBoMc0/KYv72Vbo5kVr0OqWq0bSqLfRPTPR3cpzXHlAElPknVK
        DwS4IXrpejfCKPR+TceET+1i89We3WH6zcOU
X-Google-Smtp-Source: ACHHUZ5jBhjPz1AsQiUmS4x6m4cK5KFI6jpsJV9mfUM45xVEOHy6uTpBh2pddEGpWZ3i5ES55ckFJw==
X-Received: by 2002:a05:6a00:17a3:b0:636:f5f4:5308 with SMTP id s35-20020a056a0017a300b00636f5f45308mr30641169pfg.7.1683807126675;
        Thu, 11 May 2023 05:12:06 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id j10-20020a62e90a000000b0063f16daf7dbsm5134562pfh.55.2023.05.11.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:12:06 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 0/2] Devicetree support for Loongson-1 watchdog
Date:   Thu, 11 May 2023 20:11:57 +0800
Message-Id: <20230511121159.463645-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT support and dt-binding document for Loongson-1 watchdog.

Changelog
V1 -> V2: Replaced the wildcard compatible string with specific ones
          Use unevaluatedProperties instead of additionalProperties
          (suggested by Krzysztof Kozlowski)
          Use of_match_ptr() to aviod the build error when CONFIG_OF=n

Keguang Zhang (2):
  dt-bindings: watchdog: Add Loongson-1 watchdog
  watchdog: loongson1_wdt: Add DT support

 .../bindings/watchdog/loongson,ls1x-wdt.yaml  | 42 +++++++++++++++++++
 drivers/watchdog/loongson1_wdt.c              | 13 +++++-
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml


base-commit: 10f67d1fd275528e62109de2ece26371833638e5
-- 
2.39.2

