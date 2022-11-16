Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41DF62BDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiKPMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiKPMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:30:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2762EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:30:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a14so29687812wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVAqY273akgzvATGouXznwiEQyYEMmvaAfQqpAHVy/Y=;
        b=uJ5HW9NIYILUhOvOa7UHspl5xI8tEPd2J47UeR60fXCk1Rx9ISrFuEHNHoFAMf2iKb
         sEoUkHh6hvP7JnY2GxIrK93etU3nvUi0cj21V9kV4lvctePzP9VEosOWo4aXixpdyZja
         LGYsg9WkXhuGlBgTS4I/9iZC3IvvUzwENJ6PpB1W+DPO38dTjS6qcBpmWewax/A64oiI
         McDoAWoPSUdGneNKp4DN1b9tX77ijPbK+0psSrF+7lBbmg3j0ro4U4LsK7I0hb8i2lx9
         +zK/N6/BlwWt0HzYugFCVcF+FnKerMt6qnS545b5poxJO+Cl4bKqJCvlpLAOEfaUMITs
         Rdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVAqY273akgzvATGouXznwiEQyYEMmvaAfQqpAHVy/Y=;
        b=VOIWVSzBhoBHhPj6twVjgWh2OgePba0Ch22Ah9t+wikusfaPnrPCStZibFSkMILo89
         XwBaXzYgp/SGhgHFBzpF0jYqsl7if83IO50R3uoYE9djVLVfKlAdHUWCJx+XA+5z9AGu
         nZ9UInv5LJk5o4b0mSZk7K5GxWVtJEJp482GtLCSRq/XvqVI9yTKpEfz1qYLG/2ndcxK
         GglClOGQcxki78kT1dvhbFTIB+TOhm20SLkBejVjGD4hKTXd5d4uNhjoW8wr+I6PXp65
         niukP3o8piYvSjh9Lcu14NuUmitHgeO6Jvm3nlB6GI6fwJGHU+MzBzROLUt2ouPQsQ1O
         j8kA==
X-Gm-Message-State: ANoB5pnvzT5sGFpZfTPwGEFDyl3ZsM0uwqG5bw3wFzqtZ+vHnVuP28vx
        kAC8PAuAcd8j36r4k61746VXmQ==
X-Google-Smtp-Source: AA0mqf4/kQZ3GU5WFPOsjh4bh6I5c2w6g0ycRJDFEybYfvg8GpMlaw4KZCvYa5R2li0wvjR4hm67eA==
X-Received: by 2002:adf:e2d1:0:b0:236:8638:121a with SMTP id d17-20020adfe2d1000000b002368638121amr12923647wrj.188.1668601834098;
        Wed, 16 Nov 2022 04:30:34 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cf4eac8e80sm2870991wms.23.2022.11.16.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:30:33 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 0/3] usb: Add generic repeater framework and SM8550 driver
Date:   Wed, 16 Nov 2022 14:30:16 +0200
Message-Id: <20221116123019.2753230-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a generic USB repeater framework to be used by
platforms that have eUSB2 support and want to have USB 2.0 compliance.
In such cases there is a device between the eUSB2 PHY and the actual
connector. That device is basically a repeater and the most important
thing it does is to level shift in both directions. Such a device needs
to be controlled in software usually by the PHY or by the HC.
So add a generic framework with basic ops to allow consumer drivers
to get a phandle to it and to control it.

Also add the SM8550 PMIC eUSB2 repeater which uses the generic
framework.

Abel Vesa (3):
  usb: Add USB repeater generic framework
  dt-bindings: usb: Add qcom,snps-eusb2-repeater schema
  usb: repeater: Add Qualcomm PMIC eUSB2 driver

 .../usb/qcom,snps-eusb2-repeater.yaml         |  43 +++
 drivers/usb/Kconfig                           |   2 +
 drivers/usb/Makefile                          |   2 +
 drivers/usb/repeater/Kconfig                  |  20 ++
 drivers/usb/repeater/Makefile                 |   7 +
 .../usb/repeater/repeater-qcom-pmic-eusb2.c   | 251 ++++++++++++++++++
 drivers/usb/repeater/repeater.c               | 198 ++++++++++++++
 include/linux/usb/repeater.h                  |  78 ++++++
 8 files changed, 601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,snps-eusb2-repeater.yaml
 create mode 100644 drivers/usb/repeater/Kconfig
 create mode 100644 drivers/usb/repeater/Makefile
 create mode 100644 drivers/usb/repeater/repeater-qcom-pmic-eusb2.c
 create mode 100644 drivers/usb/repeater/repeater.c
 create mode 100644 include/linux/usb/repeater.h

-- 
2.34.1

