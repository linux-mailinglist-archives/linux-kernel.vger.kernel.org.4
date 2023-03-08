Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3066B0319
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCHJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:40:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FEB1B15;
        Wed,  8 Mar 2023 01:40:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x3so63092211edb.10;
        Wed, 08 Mar 2023 01:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678268437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQFy8moETWaGWRs6VMCXrP047rwgR8C0UzBrVmV4s5c=;
        b=Np6f56ZB51bzHklHHvqyZ5rOrtgivYFKXUPd2+W414UIoa38DmZsbA5R4/UtDamPfc
         va/fdWwq/MH+e55+0bf6X6rXNZpvfHozMbbk5D7m+0hmkG6LObquTKAdm7thbP/DyVb2
         sqI3ecVaIknJWVVezjTcY5wyGVQ2x6YU5y+1zrxDW1bcZ/OCpnzhhQtj+gUpYgPyYPou
         PXFe/CwJ7uOkHTUzB0FTXO74XG9O8xlzwmaYyFgKxJDuviEUXFWi4erLVHzal1gFwwKU
         HVxbEykcV1Y2lFV9LXQZA9sMZRPIfSuUpgTRPGUFpYMCHGAmKNCnOf2wv6gtohDMRxE3
         +7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQFy8moETWaGWRs6VMCXrP047rwgR8C0UzBrVmV4s5c=;
        b=1ztXZ6MIQKXYfp50qQN0F5ZG2RrWg1EGLlq9g+XOGfNjl3g4FSr2JKrOfy3hp9ggq+
         s+UGzxkjvYCR2zl24C3u2RxBHTEPkFdF1grSEEozHgFhfZ7WA1JEcj8xnneFXFPdG7Qf
         focfEaj5b+yiTOf9trkEbWgpZkdCVRBbv8mNMnt+AeLADNm4xUgZI5XmtJugoiSaH4CO
         yAIkiVcmHd2ecM8oHou09dizMTFiX7+nnrNuUb2El9rNmGRPBTxFuFBMQ8fjnJ3mFiMs
         7IEPdlRoE6+ykIJ/K5nDo+XGWdikX8Vrrvyx96g3oDtPaFNk8FbBswtXLti03RXkWlqz
         HhQw==
X-Gm-Message-State: AO0yUKV72JRdxjU4SFtRAGXgBGHNAcScp8Wy9RkDENF+3iKTiECdcd16
        hxAVVfGZFXREFpDMhNiBN5U=
X-Google-Smtp-Source: AK7set9kc6kvqVavdx3aKJpG4dnxoIzPrX/ZPIxe/gQv+Ds0+KLAHLyizuhg3o+l/pb386dw77lMbw==
X-Received: by 2002:a17:907:9702:b0:82e:a57b:cc9b with SMTP id jg2-20020a170907970200b0082ea57bcc9bmr18094701ejc.24.1678268436813;
        Wed, 08 Mar 2023 01:40:36 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm7240014ejb.187.2023.03.08.01.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:40:36 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Add optional power supply for INA2XX
Date:   Wed,  8 Mar 2023 11:40:22 +0200
Message-Id: <20230308094024.14115-1-clamor95@gmail.com>
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

On some devices (like LG Optimus Vu) ina2xx hwmon may require
power supply for correct work, hance add one.

Svyatoslav Ryhel (2):
  dt-bindings: hwmon: ina2xx: add supply property
  hwmon: ina2xx: add optional regulator support

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml         |  4 ++++
 drivers/hwmon/ina2xx.c                               | 12 ++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.37.2

