Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12856B0366
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCHJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHJwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:52:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796798873;
        Wed,  8 Mar 2023 01:52:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o12so63235114edb.9;
        Wed, 08 Mar 2023 01:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678269138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fGQKKxWePBgtAu1PyWT3YZ6ScQV2tPn02GMb8I55bc=;
        b=mBhAw6oLvvleh6eJgbOS6wHeKDdLZdyAyaIphVeItu53m331p/9u9np3us4+q1HvrA
         3ipQ1Bv3HIGGTjjWoN2POzNKtcrKUK8XmPVIruybWhttScgPW4GZoeqHrozLVtc5bV5G
         MYWBvrZj2uzXreinHQ2J3qV7oitrvSRWRBPb4u/rHLg6ojJ214ilyP4NFKQPZY7blQQI
         4m1PuNfFTXGZ/o+m/u60/foen1VScuWLcFNxQ1P5NUjGhrK4mhH5ASL2wUzNC96pMGiC
         1BCXzOddrMSr2RWHVfoGQN59FWXzsqEWrNrcDUKw3CJXW3bdMZRuu1p4Pe2CPWSOKpB/
         EB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fGQKKxWePBgtAu1PyWT3YZ6ScQV2tPn02GMb8I55bc=;
        b=5HY8dObuENKnUZa+gO6jzQUSWfvuMaspMi/NES6hMBHfcFRkcRsm0z3mp12a99f1QO
         7P//GCd/at7tKPkNLJsGxMbz9xxfN9sElJKOXDAg2EM8zEn6vmJW50+wbjrgn5FCXaco
         4P7ScEU86LD2PVCyXkQdZn6FAVgvuSeUIDNQ1u1mN0qvSszxRMVhWcylIRG4Ab2OJf4a
         hfWxw6Jkr3Ratwv+fecuCS2tdkVIAjgS4XtLT1EbVqEPfEJhiMYRzBmbHhvevhvk6Y5l
         VOMgnu3TgFLNzECK8nKtEV/GCL0yNhWGQbTRUiA+L/sHwQmxcOdzgUN8OlB+biruldvC
         AZtQ==
X-Gm-Message-State: AO0yUKXOsTta7auan9bgFbd6BCQrNvqqqlNdrwycDfhfRhAKxaj8OlDE
        y87KmkRCYKp+QhsnZXSbM7A=
X-Google-Smtp-Source: AK7set8SDLMd/irQQE0sU6gZhxP+XSR5vgSRWJe5+J0sEnyryADK8bGZn0AdNfvMNW/Y0Y5UWr5w4Q==
X-Received: by 2002:a17:907:70e:b0:8f5:8da0:a482 with SMTP id xb14-20020a170907070e00b008f58da0a482mr18683260ejb.25.1678269137928;
        Wed, 08 Mar 2023 01:52:17 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b008d8f1b238fdsm7369177ejq.149.2023.03.08.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:52:17 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Jean Delvare <jdelvare@suse.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Ldd-Mlp <ldd-mlp@list.ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add OF support for LM3560
Date:   Wed,  8 Mar 2023 11:52:07 +0200
Message-Id: <20230308095209.14700-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement device tree support to lm3560 and make some 
minor style adjustmets.

Svyatoslav Ryhel (2):
  dt-bindings: media: i2c: add lm3560 binding
  media: lm3560: convent to OF

 .../bindings/media/i2c/ti,lm3560.yaml         | 130 ++++++++++++++++++
 drivers/media/i2c/lm3560.c                    | 128 ++++++++++++-----
 2 files changed, 223 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,lm3560.yaml

-- 
2.37.2

