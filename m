Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBE6C82C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjCXRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjCXRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:02:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85233B44F;
        Fri, 24 Mar 2023 10:02:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so5667751pjt.2;
        Fri, 24 Mar 2023 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679677376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+sKP3obDTWYFIT1jnmZ1GqDfFrpCwbFB+xgAFvy1zk=;
        b=JvzQHWrmzdmUqrzZGY3n89spl9v1DpyjNAzTzcecieHKrfMhskKFy/+LgiaqnwxWHz
         lByWTPIGP2k5KVrZ2jMJP1GnFzA0NSBvmosBdouIPplz2CCEheYpURGW3lf/KHMTNY0I
         75a5MfzP0MS7sXn8jbT9zYECZojPW0wm6YENyo37QIKDDSSNmNqJK2NxHT8hfXvY1P02
         sGzqAjEqlg22FUBqYbtpCOMvaVKx6oMZparCCa/jMdXS0LYBm1mzajuilBk5sZy7FtjX
         4kGXMlIBg9FC7hozyhlU0lYYOAQvrShSFPEpS21vpgrU5gmjavOfa2NG+mI0aXZA2KRW
         Hsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+sKP3obDTWYFIT1jnmZ1GqDfFrpCwbFB+xgAFvy1zk=;
        b=abgDgthrrk1zs0XmvyKwtLHG4AArKLYF42hW+gbPxy9i+V8Fb86nPN+z6rNN33nRuY
         K1HFs2lej98p3aXjc1F+011CeSV4A8e02VIUOPLvELojqfrFwN+EHDu2qTb2ZJWuRn2E
         KGisgO+9W0ZhEYneLd9rKiXMuQ1DFNQc7UXlqMekAXeSyGFzMUgjjbBjTr9B2gTSnvPR
         JSQGgZ3n2RlcbMeDsUaJOgyDQQLquYTQKb8tNiNvgC0nzJ27aShPCc8wu1RzI78ml/Hm
         lK8Fx3XGCeQlvmDe2NxlYVoZKNugFEOwms8fyzd8KA4oayvFNF+yYaX74gmbqhTfvR8t
         UW8Q==
X-Gm-Message-State: AO0yUKX7WV08CNf6IDyai2gqUUbryiXBu+ugFMuYzADorOL6VuE9c7Ud
        3tS/vXKHTmiVnjacxXaiFD1qLtAhZ+A=
X-Google-Smtp-Source: AK7set8Gqe9oG6purz55nmRT4dsXxmRMuezoiDfjte62o3iDrMA2ccrWqSfpKc70zttV5z1IDYWQpQ==
X-Received: by 2002:a05:6a20:4f25:b0:c7:8779:416d with SMTP id gi37-20020a056a204f2500b000c78779416dmr3541839pzb.58.1679677376356;
        Fri, 24 Mar 2023 10:02:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h4-20020a62b404000000b005a8bfe3b241sm14019591pfn.167.2023.03.24.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:02:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Matthew Lear <matthew.lear@broadcom.com>
Subject: [PATCH 0/2] Correct gpio-ir-recv wakeup capability
Date:   Fri, 24 Mar 2023 10:02:12 -0700
Message-Id: <20230324170214.3470675-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series fixes the gpio-ir-recv binding and driver to
first indicate that it can be a wake-up source for the system, and
second actually make that happen.

Florian Fainelli (2):
  dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
  media: rc: gpio-ir-recv: Fix support for wake-up

 Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml | 3 +++
 drivers/media/rc/gpio-ir-recv.c                               | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.34.1

