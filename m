Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345CC6994D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBPMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBPMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B463C7A2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so1742363wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xezfJbuh45gj2JjckjB6XpRuXqlI1L0Zk27ygbHi2sM=;
        b=RsKln7AsMorwkH0gJU5OyxYkvD7xpdbVrOXvSnQ+O3lOsKzg01F4eEfoPoTP9nDfda
         x/G0TM2xa2QorP1CJtxSXjdKONHzb7sCtGQgHeRyp4Oy4M7pQG4SgxBXcy+kgZmHVdY9
         /jLpfjxp7ZOSubVg73McCDBXV8jKx01//BOn5aZeDdhkeJ93Fkr19sv5gmHfUHnjXMVL
         72vu1sp+yr5dF7Chsxr1/FbOt6stY59vrlelop6QHBpx+5+RrizttWpwXALe3Iscksl2
         rX3MFmpEJCJIuEprwXqmJfE3lJWjfcpupeOdee5fvT5QeMIrih/NlhsYyfgMp71SsTYX
         3wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xezfJbuh45gj2JjckjB6XpRuXqlI1L0Zk27ygbHi2sM=;
        b=iUpjicy0QmMK/IH++LPUfCZrT9pkTRfzgbS9wskaePzSwPw8fElbqo+25dOtSu1+jL
         QYXlfYs6YUY/CVMyjCvwBWEFscFjAxJEtIjySM0+aB3XiQX429IZ1VYntsrY080WG8fL
         O9TaSvPC+CHC7HAzu9CciXkfpjrWYpc5oQzPd/MGYPpA/YzkSKt8EbG59OFM0RBVnomq
         QYTtaUbJG0PDdFcGBDJFoutBOfhxC8aZcZNL5nhRrfuCgk0R3BwFGpBo9Z8fkNzoqcX0
         KCRUbMzn6NKbPWLneiponCLM/S/RzMwHJKA18FehT569oIMaEHAWxMAW5zH9X+cFjMkV
         XfoA==
X-Gm-Message-State: AO0yUKVzxDehcPFaxfMxa+iSUUzIX0kk4905UB4TkDDTugaa3t2kf2gk
        kZzMJR8DBTSfXm3FWHh+sKVN/w==
X-Google-Smtp-Source: AK7set8+SE5hruj4LixBR3rciJmVVEiwg886Sj8o4flmK5eiTC3sED9nIXtrzH7qrgBPh2zYIzA8Gg==
X-Received: by 2002:a5d:68c1:0:b0:2c5:58f5:3c40 with SMTP id p1-20020a5d68c1000000b002c558f53c40mr4200012wrw.47.1676551980417;
        Thu, 16 Feb 2023 04:53:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/9] arm64: dts: qcom: sa8775p-ride: enable relevant QUPv3 IPs
Date:   Thu, 16 Feb 2023 13:52:48 +0100
Message-Id: <20230216125257.112300-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This enables the QUPv3 interfaces that are exposed on the sa8775p-ride
board: I2C, SPI and the Bluetooth and GNSS UART ports.

v2 -> v3:
- fix the interrupt number for uart12
- replace underscores with hyphens in DT node names (although make dtbs_check
  does not raise warnings about this)
- rearrange the commits so that they're more fine-grained with separate
  patches for adding nodes to dtsi and enabling them for the board

v1 -> v2:
- uart17 is the Bluetooth port, not GNSS
- add uart12 for GNSS too in that case

Bartosz Golaszewski (9):
  arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
  arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
  arm64: dts: qcom: sa8775p: add the i2c18 node
  arm64: dts: qcom: sa8775p-ride: enable i2c18
  arm64: dts: qcom: sa8775p: add the spi16 node
  arm64: dts: qcom: sa8775p-ride: enable the SPI node
  arm64: dts: qcom: sa8775p: add high-speed UART nodes
  arm64: dts: qcom: sa8775p-ride: enable the GNSS UART port
  arm64: dts: qcom: sa8775p-ride: enable the BT UART port

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 100 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  86 +++++++++++++++++++
 2 files changed, 186 insertions(+)

-- 
2.37.2

