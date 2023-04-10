Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7C6DC8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDJQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjDJQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:02:06 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33DA10A;
        Mon, 10 Apr 2023 09:02:04 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3261b76b17aso1799115ab.0;
        Mon, 10 Apr 2023 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142524; x=1683734524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YHlyCEEJEtWKucnlrijjk2nbetLGWAzpZkLzz8yXRw=;
        b=epKmCkNmCehnwWv9Nsk6zchNP/0m9/SDPd+cB+OWBGa4RFIBDl/4tDdujtL95fqtwa
         V5JIa/CvRZWJt3H8BR+biDkLamnz/YCtH6lJvXJ2vo+NMe3U1rz4xT96r/o9u7uqS4+s
         7g/TxBsnpeAcYcUmAA1/udv7CcK6/5gfFzUJIetKFtskSpgYeqaFxpkmcnSjA9e/ECQ8
         hdy1a1s5dSicQuK1QhuovuPd35Et77RbaMNbci1QQZaOJ+T1W+Ip+keAujkGcVQmR4Qo
         Awhtax41zsH5lHGGnRCa8ZdbEVD4j4qkdwp0HnZWDtQXNBYAFoOhqyybHQhJcNU6TeMx
         8NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142524; x=1683734524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YHlyCEEJEtWKucnlrijjk2nbetLGWAzpZkLzz8yXRw=;
        b=7ZgAWvXQNHES/+SXgAN/1VsfUlOWirRwqSuHLlUeYEhJ9ufGr97ZmekTaVdwpK76m2
         sndJ+yXflw3AHdTzydVnqy37dr/Llbn+qFvol2Jten2pfdoLKg3rplA7Q9NYP3Fuw9a6
         2cOBg/rsMS+QZn85GoM3PG8rsuc+/rGWP73rmr/JrMVa8iL+3IfoVGTOo5rNslJ53wqc
         SD+fHg5qYJ1CgjTLxyN9KV8H5aX+BlOmt041NLGYeBnI02HbZPL4nBNSrRBnTSFMMVx5
         Q/6Fyo0ut/BjJSowPpzUWftcCzre7xyurrtXuLDTia4WcPKoYOr0OatxMC55/SWfV0yW
         iSPQ==
X-Gm-Message-State: AAQBX9fqJ23ebtVQV520lCd4rNc4wCrGKbsQUUSHTxHeUflASWWTf18C
        bbMfHsgvwdAPtYVcztzwo8M=
X-Google-Smtp-Source: AKy350Z0P68Xv90CfVLoFoIwWeV7OhYacXeW6/NQvz9Dr5K/wT1cuW0VHU+NxVtWuYgexcEmTu51IQ==
X-Received: by 2002:a6b:8d84:0:b0:740:7d21:d96f with SMTP id p126-20020a6b8d84000000b007407d21d96fmr3473314iod.1.1681142524259;
        Mon, 10 Apr 2023 09:02:04 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d9a87000000b00746041ecbf9sm3184435iom.39.2023.04.10.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:02:03 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v2 0/5] Add support for Focaltech FTS Touchscreen
Date:   Mon, 10 Apr 2023 11:01:55 -0500
Message-Id: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
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

Changes in v2:
--------------
1. dt-bindings changes (Suggested by Krzysztof Kozlowski)
	- changed file name from focaltech,fts.yaml to focaltech,fts5452.yaml
	- removed focaltech,max-touch-number property, handled in driver now
	- removed touchscreen-* properties and used unevaluatedProperties: false
	instead of additionalProperties: false
	- fixed the example dts node name to be generic
	
2. FTS Touchscreen driver changes (Suggested by Markuss Broks and Jeff LaBundy)
	- removed repeated license terms since SPDX tag is used
	- includes are now sorted
	- added the missing input_mt_sync_frame when reporting touch
	- focaltech,max-touch-number is no longer read from dts and instead
	specified in the driver as compatible data.
	- removed redundant __set_bits
	- input_mt_init_slots is now called after the axes are defined
	- irq handler now returns IRQ_NONE when there is an i2c error
	- other minor fixes and refactoring as suggested
	- renamed driver filename from focaltech_fts.c to focaltech_fts5452.c
	(Suggested by Krzysztof Kozlowski)
	
3. dts changes (Suggested by Krzysztof Kozlowski)
	- use generic touchscreen nodes
	- removed focaltech,max-touch-number property
	- irq type was specified wrongly for Poco F1 in v1. Changed the irq
	type to IRQ_TYPE_EDGE_FALLING as that is correct.

Some Clarifications:
--------------------
1. Jeff LaBundy suggested I could read chip id with the following:
	__be16 val;
	regmap_raw_read(data->regmap, FTS_REG_CHIP_ID_H, &val, sizeof(val));
But this is not possible because FTS_REG_CHIP_ID_H and FTS_REG_CHIP_ID_L
are not continous register, therefore reading it together as 16-bit values
will not work. So I went with what Markuss Broks suggested:
	regmap_read(data->regmap, FTS_REG_CHIP_ID_L, &id);
        regmap_read(data->regmap, FTS_REG_CHIP_ID_H, &val);
        id |= val << 8;

2. As Markuss Broks suggested, I tried to cast the buffer to struct, but 
unfortunately was not able to successfully do it. The buffer layout is 
weirdly split into 4 bits and 12 bits at someplaces which makes it hard 
to cast into a struct. For example, we can note
	type = buf[base + 3] >> 6
	x = ((buf[base + 3] & 0x0F) << 8) + (buf[base + 4] & 0xFF);
Here at buffer index 3, the first two bits (>>6) are used for denoting
event type. The next two bits are not used. But the last 4 bits (&0x0F)
of buffer[3] are added with buffer index 4 to get the x position. 
I don't know how to handle these when casting to a struct. I tried
experimenting with bitfields in struct, but to no avail. So I am sticking
with my initial implementation for now.

Kindly let me know if any further improvements are needed. Thanks.

The Focaltech FTS driver supports several variants of focaltech
touchscreens found in ~2018 era smartphones including variants found on
the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
This driver is loosely based on the original driver from Focaltech and
the patches submitted by Caleb Connolly previously[1] but has been
simplified and largely reworked.

[1] https://patchwork.kernel.org/project/linux-input/patch/20220123173650.290349-3-caleb@connolly.tech/

Joel Selvaraj (5):
  dt-bindings: input: touchscreen: add bindings for focaltech,fts5452
  Input: add driver for Focaltech FTS touchscreen
  arm64: dts: qcom: sdm845-xiaomi-beryllium-common: add touchscreen
    related nodes
  arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce support for
    fts touchscreen
  arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen
    properties

 .../input/touchscreen/focaltech,fts5452.yaml  |  71 +++
 MAINTAINERS                                   |   8 +
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  15 +-
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  39 ++
 .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts |  26 ++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
 8 files changed, 596 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
 create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c

-- 
2.40.0

