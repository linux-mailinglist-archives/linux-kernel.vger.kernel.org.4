Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2037103A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjEYEEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbjEYED7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:03:59 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AAB1BD;
        Wed, 24 May 2023 21:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=hTAnpCAT2Q/2ABE+7VrADwqsnFx55RsF+ONOo7NqGT0=; b=c
        qSqnmxSidxLnq8IDBCTwt1xAjrW57C8Jk1VEXaaHYPUL24vPC9Kj/irZFLAh5WiUISOOd1q6EYVl1
        uzy7Y5TLOgWXf+JEbUeFVi9SFi8Z7RWR4/EhzpuoK9T9dmYnh8C33hmemuKUVfTgar0QJypXL4J20
        tQONA6/F9JJNhUEg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52970 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22CK-0001dB-Ms; Thu, 25 May 2023 00:03:38 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 25 May 2023 00:03:13 -0400
Message-Id: <20230525040324.3773741-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v3 00/11] serial: sc16is7xx: fix GPIO regression and rs485 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series mainly fixes a GPIO regression and improve RS485 flags and properties
detection from DT.

It now also includes various small fixes and improvements that were previously
sent as separate patches, but that made testing everything difficult.

Patches 1 and 2 are simple comments fix/improvements.

Patch 3 fixes an issue when debugging IOcontrol register. After testing the GPIO
regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
this patch is also necessary for having the correct IOcontrol register values.

Patch 4 introduces a delay after a reset operation to respect datasheet
timing recommandations.

Patch 5 fixes an issue with init of first port during probing. This commit
brings some questions and I appreciate if people from the serial subsystem could
comment on my proposed solution.

Patch 6 fixes a bug with the output value when first setting the GPIO direction.

Patch 7, 8 and 9 fix a GPIO regression by (re)allowing to choose GPIO function for
GPIO pins shared with modem status lines.

Patch 10 allows to read common rs485 device-tree flags and properties.

Patch 11 add a custom dump function as relying on regmal debugfs is not really
practical for this driver.

I have tested the changes on a custom board with two SC16IS752 DUART using a
Variscite IMX8MN NANO SOM.

Thank you.

Link: [v1] https://lkml.org/lkml/2023/5/17/967
      [v1] https://lkml.org/lkml/2023/5/17/777
      [v1] https://lkml.org/lkml/2023/5/17/780
      [v1] https://lkml.org/lkml/2023/5/17/785
      [v1] https://lkml.org/lkml/2023/5/17/1311
      [v2] https://lkml.org/lkml/2023/5/18/516

Changes for V3:
- Integrated all patches into single serie to facilitate debugging and tests.
- Reduce number of exported GPIOs depending on new property nxp,modem-control-line-ports
- Added additional example in DT bindings

Hugo Villeneuve (11):
  serial: sc16is7xx: fix syntax error in comments
  serial: sc16is7xx: improve comments about variants
  serial: sc16is7xx: mark IOCONTROL register as volatile
  serial: sc16is7xx: add post reset delay
  serial: sc16is7xx: fix broken port 0 uart init
  serial: sc16is7xx: fix bug when first setting GPIO direction
  dt-bindings: sc16is7xx: Add property to change GPIO function
  serial: sc16is7xx: fix regression with GPIO configuration
  serial: sc16is7xx: add I/O register translation offset
  serial: sc16is7xx: add call to get rs485 DT flags and properties
  serial: sc16is7xx: add dump registers function

 .../bindings/serial/nxp,sc16is7xx.txt         |  46 +++++
 drivers/tty/serial/sc16is7xx.c                | 180 +++++++++++++++---
 2 files changed, 199 insertions(+), 27 deletions(-)


base-commit: 933174ae28ba72ab8de5b35cb7c98fc211235096
-- 
2.30.2

