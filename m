Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72265D49B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbjADNmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjADNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:36:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A863AA93;
        Wed,  4 Jan 2023 05:34:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so82397832ejc.3;
        Wed, 04 Jan 2023 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GInMGnABfjC0QlvcYrq8TrKeuaCvr1m9DUS8iTssmEQ=;
        b=XLTtOC0knfQCVZH+146a2GWv96cOBiXw4Kew86LersRiG4TBuWhYpPL8u2d3k9X/91
         MKj2y/a+eRaw/ywqHLmRN/4hGcf6UVyCjqGx8GPJqavZh38qdBZuUs87dmwAs4i7EIPv
         OjikbF0DkViJZh6W4k1IO+165SDL362Cb7hd8D0yqJBFI/8kL2RBHZRbqzo4MdnlgmUI
         ScEBrNkRyXyTG7qGxb4cP86auHWb1KTia2Rl+qYUTmDh0qQrPgubLatcNFkq2+cOsUAp
         VEodyP9+lUvEGRNb1btEjSM26lmeFmpaEhyvNo+nqdvH33i5Ve80RGR3Z3sLkhyzNhze
         I7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GInMGnABfjC0QlvcYrq8TrKeuaCvr1m9DUS8iTssmEQ=;
        b=ZNgoe6B6zx+GqsTcAPfmckt5+y4FHcVdwP8RRyt5X90e+dCC53DawJ4y/mNg0qLHZK
         YdsUeHzUap/0N1BG9qu9XivFqWcicn28Up5maWx71MlHKQXjwmbq/mxXpXK/XejW/8KO
         zEKnngVUzCwdrs9UkfWuxr9nuurPuClx2vTIZxtqgAspyhYR6r59xy51FmPPxP/s1hMb
         oqK6/a5tfYETAri5Bp3InCzJ81EPBo2NdBUXXGX10T46QZRymJLFl6f3rdPmV7VtftqR
         sntUbI1aZ+hY+MedF+WhIkCHTd3T41vtM9NssMjKY9VdD3/F7eD3JfRoiXaS509uISWa
         TkHg==
X-Gm-Message-State: AFqh2krVg8YJ715fmGueLZM9pm5myQ3LXPlKYqXzLoFd8tPbEXWhIhyd
        /JB+LUtX9Vulfsh0r6h5R2fYScT2sf+igg==
X-Google-Smtp-Source: AMrXdXvw8JsD/2YnO+7KV7y8/mphK6dpuUrcxg1DXx4WeDCBzaLHh953mT/CRdlXTM1y2mPv+GZ+gw==
X-Received: by 2002:a17:906:345a:b0:7c0:eb33:892a with SMTP id d26-20020a170906345a00b007c0eb33892amr37438113ejb.77.1672839270995;
        Wed, 04 Jan 2023 05:34:30 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id sb20-20020a170906edd400b0073dbaeb50f6sm15211659ejb.169.2023.01.04.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:34:30 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, arnd@arndb.de,
        dipenp@nvidia.com, bvanassche@acm.org, iwona.winiarska@intel.com,
        ogabbay@kernel.org, tzimmermann@suse.de, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCH 0/3] Wiegand bus driver and GPIO controller driver
Date:   Wed,  4 Jan 2023 14:34:11 +0100
Message-Id: <20230104133414.39305-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I would like to thank everyone that commented on my last RFC,
which made me realize the shortcuts in design I was making.
I think I have finally understood the concept of how bus drivers
operate and I have implemented a Wiegand bus driver. The driver
now manages controllers and devices connected to them. It attaches
drivers to Wiegand devices and provides an abstract API in
"include/linux/wiegand.h". Most of the Wiegand bus driver code is
inspired by the SPI bus driver written by David Brownell.

I have also implemented a driver for Wiegand GPIO bit-banging.
This driver gets the devicetree defined GPIO lines and sends
Wiegand formatted data through them.

I have also tested creating sample drivers for devices attached
to the bus and working with them.

CHANGELOG since RFCv3:
- implemented a proper bus driver for controller and device
allocation, devicetree probing and driver matching
- Wiegand bus is now represented as Wiegand controller node in the
devicetree
- re-wrote the old version of GPIO bit-banging driver as
a Wiegand controller
- used standard units for devicetree attributes
- removed global variables
- tested unbinding of drivers and fixed memory leaks
- created a Wiegand protocol sub-system - a folder "drivers/wiegand/"
for Wiegand controller drivers

I am not sure, whether this bus is complex enough to create a subsystem
for, however I do believe that this is the way most buses do it.

Martin Zaťovič (3):
  dt-bindings: add Wiegand controller dt-binding documentation
  bus: add Wiegand bus driver
  wiegand: add Wiegand GPIO bit-banged controller driver

 .../ABI/testing/sysfs-driver-wiegand-gpio     |  17 +
 .../bindings/wiegand/wiegand-controller.yaml  |  83 ++
 MAINTAINERS                                   |   9 +
 drivers/Kconfig                               |   2 +
 drivers/bus/Kconfig                           |   5 +
 drivers/bus/Makefile                          |   1 +
 drivers/bus/wiegand.c                         | 768 ++++++++++++++++++
 drivers/wiegand/Kconfig                       |   8 +
 drivers/wiegand/Makefile                      |   1 +
 drivers/wiegand/wiegand-gpio.c                | 471 +++++++++++
 include/linux/wiegand.h                       | 228 ++++++
 11 files changed, 1593 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 create mode 100644 drivers/bus/wiegand.c
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand-gpio.c
 create mode 100644 include/linux/wiegand.h

-- 
2.38.1

