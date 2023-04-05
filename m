Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092DF6D73B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjDEF3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbjDEF3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:29:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F840D9;
        Tue,  4 Apr 2023 22:29:38 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cu4so25525226qvb.3;
        Tue, 04 Apr 2023 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680672577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrEFfBgPkHs4+wQNyjy49qgOcULrJ/GwlKe55w6yLFY=;
        b=l+JAVHEH3PqYb2Z7mPeN4/PYPKgMOnmXbWkpbBEWuFk3AJSIFWvArLURa/c2HSj64z
         SuDXdPoMqfGmQienM42zHkpQjCG8hkHEWUC3Py2Ge6+L2wFLpedEz8+l2DyiwZ1nhORi
         Ri2EBaJoiIJN2lZX66JTycR0yQBBn3+fvLIkF6MrfiWuno06zvAhwwfbJD+Eu24rwStM
         I731j2yN381Mes9KJgaIbvmmI7rHh1vNdDvdBWwiwcbKabOc5l6N+Ao39Mx2vzxcJCCn
         DBVRY7LAlA7pul03Sxj29ioYoWLB0YVCip7WaMF3kdCIIlAzr3TFscBVspe7XrnCjx47
         0b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrEFfBgPkHs4+wQNyjy49qgOcULrJ/GwlKe55w6yLFY=;
        b=cLWPj7G5h+VCnEbPtraMUM0KWKkxjP8NoPzwvnywaV4neIUZ9HoUSijB7BwjRgQs2X
         UOtKXjZnoq6S4UGlJ5P2bpnh1UMC7JAg4O7J/ZOib96wKBJBnCMzGbW1jKAMG6CHvgy9
         +7hvnv21ldrdI5QJToJtnmCMo/8W165Y6PuPAFd5kh1vfwJSGSelZ/a7nTvgTPTWDbX/
         44m/lMcraFZ1rI57ZOpSRn9WPbAJhyWztMvJSeJ96YrGKS/+2/sUor9yj8RRbhNY2apE
         PKhgaBwij+mREXFW8EGo1WadTv0pqS7Kbz87LnQ8VM+UQtUeGFs6WstdOtFwRxOsC1VB
         n++w==
X-Gm-Message-State: AAQBX9e5KgbwHyUzSfUkZW7e1iMGI/h2jTFMI2z6u7VQR8wqDyYXAo+D
        cElRS8YlbWglLgXFsR8+uvE=
X-Google-Smtp-Source: AKy350Y5UeZlI9AHDXAW48fO7UR457CeiAbhHzHf222t8O5nD1WKlwD9scbjbd8a36C2up7QCY3NCQ==
X-Received: by 2002:a05:6214:2588:b0:579:5dbc:ab8c with SMTP id fq8-20020a056214258800b005795dbcab8cmr7385618qvb.30.1680672577445;
        Tue, 04 Apr 2023 22:29:37 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f12-20020ad4558c000000b005e16003edc9sm3881454qvx.104.2023.04.04.22.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 22:29:37 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v2 0/3] regulator: da9063: disable unused voltage monitors
Date:   Wed, 05 Apr 2023 07:29:06 +0200
Message-Id: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIHLWQC/zWNywqDMBBFf0WybiRPa7rqf5QuJjpqwMQy0VIQ/
 72x0NXlcDmcnWWkgJndqp0RvkMOSyqgLhXrJkgj8tAXZkooLYzQvAcnmjIhg5+Rb2nL2HNpW92
 gGozVjhXXQ0buCVI3nXaEvCKdx4twCJ9f8PEsPNAS+ToRwj+jxFVqqYyzba2FM1ZYLrn3QOD0f
 YwQ5rpbIjuOL48Tyhq9AAAA
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
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

Follow-up for my last patch regarding the disabling of unrequired
voltage monitors. We use the PWR_OK functionality, which asserts GP_FB2
if every monitored voltage is in range. This patch should provide the
possibility to deactivate a voltage monitor from the DT if the regulator
might be disabled during run time. For this purpose, the regulator
notification support is used:
https://lore.kernel.org/all/cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com/

v1: https://lore.kernel.org/all/20220713124958.3094505-1-bbara93@gmail.com/

v2:
- reworked solution, based on Adam Thomson's feedback

---
Benjamin Bara (3):
      regulator: da9063: add voltage monitoring registers
      regulator: da9063: implement basic XVP setter
      dt-bindings: mfd: dlg,da9063: document XVP

 .../devicetree/bindings/mfd/dlg,da9063.yaml        |  16 ++-
 drivers/regulator/da9063-regulator.c               | 129 ++++++++++++++++-----
 include/linux/mfd/da9063/registers.h               |  23 ++++
 3 files changed, 138 insertions(+), 30 deletions(-)
---
base-commit: 7e364e56293bb98cae1b55fd835f5991c4e96e7d
change-id: 20230403-da9063-disable-unused-15836e2f4539

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

