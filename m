Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5038E6D84AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjDERPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDERPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:15:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74097B2;
        Wed,  5 Apr 2023 10:15:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id m16so26549902qvi.12;
        Wed, 05 Apr 2023 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680714901;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16y+eEJkId2mz59HB8zrsXfv3Ngj1u1SaDWwb8VA0Ns=;
        b=BBhLQRWKVMwdciQ/giXksgH0Y55dsegImnBWgpNXYTGYxbgRvgj9PcnWf39zIMWiy0
         RkKvM86O0PRQzQONpVIaDNVFeCKKlWYmAv8KB1lPNTC3U5caIA6xzVnvUb0FfeFIl3uY
         kaxAjTGKmKBTlLVVSTlSQqGC3PzyxknknvNcc8I7xT9mTgs8C39sh1Z64pPZvDxLeQ4A
         RgKXPRgPd48QkXdfOV5hPlrxtANllIP79nI+f2W+FNWqWxD05kSuhYyg/USMik8nEqhF
         eQNv0bx3I/C1YliccNyEiOrsrGAmy68SCXsneauWQKw1MhcJm47D0NskcH1bXle5GsVM
         4czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714901;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16y+eEJkId2mz59HB8zrsXfv3Ngj1u1SaDWwb8VA0Ns=;
        b=7q3VrViAGwdQZ01vc8TD5Y05fwrM0+DyysQPQV89ZxYO0g+Dgx0ip2JGUgZVmq8A4R
         D/5iWo9zWKOdegUYY13djS6VYOAGkkgMnh8w0i4iMomdq/xLKG7BSMmcrGRXAL11fHJB
         soEolLgdo2dEWn5g326Q5CSG+JADuNhPqF1UQNz6nGHYPSxFv0Iz/ZCg8SkH2xcm1Dnw
         PDSfk5zvQWmxx7477qWJ0/6iL/jcaE60uB6mvLl5J+crjMcrA+ucZOICGeqdamr/6ROe
         2+bKhfpgvJ30xX5jQMXDm45S6SHQgP5ldMqqCwIrHbLl9yRZqh2at1TexHa8/5fI7DIq
         dc2A==
X-Gm-Message-State: AAQBX9evWW72hjzhkSvteNbof+ezA90BBBcWUlwDe/8HD8XLeRfyW2u/
        HJ9S47EPVwWDw/Dm5Eq9JaIixe07EpnpeA==
X-Google-Smtp-Source: AKy350ZBk8wcvi8GCFHoFkg6HY0O08LMgg6x95nLwBzNqXw6YCbrBz4uyV4fszDXUP6/5DuBjtG9QQ==
X-Received: by 2002:a05:6214:509b:b0:56e:98a1:fff1 with SMTP id kk27-20020a056214509b00b0056e98a1fff1mr11374861qvb.7.1680714901438;
        Wed, 05 Apr 2023 10:15:01 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id ct9-20020a056214178900b005dd8b934571sm4403209qvb.9.2023.04.05.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:15:01 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v3 0/3] regulator: da9063: disable unused voltage monitors
Date:   Wed, 05 Apr 2023 19:14:33 +0200
Message-Id: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHmsLWQC/4WOQY7CMAxFr4KyxihxEoaw4h4jFk7j0gjajpxSz
 Qj17qSVWM/KerL++/+lCkvmos67lxKec8njUMHud6rpaLgx5FRZoUarnbaQKOhjPblQfDA8h2f
 hBMaf7JGxdd4GVbORCkMUGppuTfdUJpb18SPc5t+t8PtauZWxh6kTpk8N6i9jDbrgTwerg/Pag
 4EYSSjYy62n/Dg0Y7/KulymUf628TOuyv92zggasDUxIaGzji7lnhNNtCmvy7K8AZB2CgwSAQA
 A
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Follow-up for my initial patch regarding the disabling of unused
voltage monitors. We use the PWR_OK functionality, which asserts GP_FB2
if every monitored voltage is in range. This patch should provide the
possibility to deactivate a voltage monitor from the DT if the regulator
might be disabled during run time. For this purpose, the regulator
notification support is used:
https://lore.kernel.org/all/cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com/

v2: https://lore.kernel.org/r/20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com

---
Changelog:
v3:
2:
- add clarifications, reword XVP to voltage monitoring
- improve error messages
- ensure that only one severity is set
3:
- document that ov and uv require same severity and level

v2:
- reworked solution, based on Adam Thomson's feedback

---
Benjamin Bara (3):
      regulator: da9063: add voltage monitoring registers
      regulator: da9063: implement setter for voltage monitoring
      dt-bindings: mfd: dlg,da9063: document voltage monitoring

 .../devicetree/bindings/mfd/dlg,da9063.yaml        |  17 ++-
 drivers/regulator/da9063-regulator.c               | 147 +++++++++++++++++----
 include/linux/mfd/da9063/registers.h               |  23 ++++
 3 files changed, 157 insertions(+), 30 deletions(-)
---
base-commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
change-id: 20230403-da9063-disable-unused-15836e2f4539

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

