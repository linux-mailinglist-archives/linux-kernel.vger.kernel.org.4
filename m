Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527F699FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBPWWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBPWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:22:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8CD4BE9F;
        Thu, 16 Feb 2023 14:22:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p5so2664925wmg.4;
        Thu, 16 Feb 2023 14:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djRJcRnLz3UuMeAMlpIwsfFMBrpOvHwci8jrszcMSY8=;
        b=fyHOewIQvLHx4+njac7ZkzJh0/fSovezrBM9rXs5qpIA4BvNRlvPUJ7FTRQmr5d2nZ
         5jLTJBZ3dhtBkNbs0PouT1rc0evpJd/t+tyVd0N+ehqMprwaUE/I0MvjPR0IXd+ibcXe
         y54lUSpYnfV2ah6hUrNMXY9bz8XKZnLw4fqs563OInOqt/jfwS6xw9ZrxUi3nIrd79ds
         33K5eINfZ/grEoDqU6iqwMkFALIW8hLRvZGVWIRiJf2fF1zYBeILi4RLlRxezOAxjxp4
         Dkb7Y43VIKUPZ/QtoCJQbsDJktRww6JwARbBUc3C5ChP2m2ERDd9nIaIYbsQ3hxMJtkE
         EeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djRJcRnLz3UuMeAMlpIwsfFMBrpOvHwci8jrszcMSY8=;
        b=ajXEpmoc/f/AdvNpKmLV2gSEhYANWkcu6B7xOYcNJdWEfLoOWepvnFOsVgPQLDxZeK
         xMnCWiLNzQXOAooPw7HYVgYRsQh/g64mVkQ1sM+Yb3Y8fWjLPpYcrR9p3W1VEYOFV2Pu
         Dqz+YRMkhF1J72xIDJN+PzBZoun10br6T9T9MUDWiVVDFm0MnhcKwGdUR5XijIFiihrI
         3fJKyETU+0JKElft2OpWYDqoXIDATd0ONVdVmHBPkUtOH7kSo4wigwTW/wH8yun6xCsn
         dcera8O7EnbwfMZNbr+eyDvOl0mOvaJsAHHZFEF68rRF2mZN/g6a/eI6R5DnqoDSsEyi
         pwtg==
X-Gm-Message-State: AO0yUKWQEGj8IPRAYMYoqQLOw1+AkIrqYetVy1vTHMcf7TiDgEaeg+GX
        w3QE3DF7FbaeR/XL4hb7Tk4QGXs3tFE=
X-Google-Smtp-Source: AK7set83tB465CK6rJgc6xdek950Rl89agO+ZAkochDkCTDkIH0ggFUao8WDm1O/dc6fzieiy0NskA==
X-Received: by 2002:a05:600c:1c11:b0:3dc:576c:ab07 with SMTP id j17-20020a05600c1c1100b003dc576cab07mr5884435wms.14.1676586159269;
        Thu, 16 Feb 2023 14:22:39 -0800 (PST)
Received: from localhost (94.197.187.145.threembb.co.uk. [94.197.187.145])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003db0ee277b2sm6875402wmq.5.2023.02.16.14.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:22:38 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, lee@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] regmap-irq fixes for qcom-pm8008
Date:   Thu, 16 Feb 2023 22:22:10 +0000
Message-Id: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
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

The PM8008 driver is the last one using a bunch of deprecated features
in regmap-irq. Replace these with more generally useful equivalents so
the deprecated stuff can finally be removed.

Note, I have not tested any of these patches.

Aidan MacDonald (4):
  mfd: qcom-pm8008: Fix swapped mask/unmask in irq chip
  mfd: qcom-pm8008: Convert irq chip to config regs
  mfd: qcom-pm8008: Use .get_irq_reg() for irq chip
  mfd: qcom-pm8008: Remove workaround for a regmap-irq quirk

 drivers/mfd/qcom-pm8008.c | 131 ++++++++++++++------------------------
 1 file changed, 48 insertions(+), 83 deletions(-)

-- 
2.39.2

