Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21DE6FE515
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjEJUaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjEJUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:30:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9734EC5;
        Wed, 10 May 2023 13:30:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34AKTsU2106837;
        Wed, 10 May 2023 15:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683750594;
        bh=2cJZIs81lmPryiqiEfHY5tjqz/GEf9161fy47W1PJgw=;
        h=From:To:CC:Subject:Date;
        b=MtbBHDmyGxI2eKyuv4dWWvnRdLZLxE2H0gcUao0kjDpP8FptkPsSwvgUG7vhixeDd
         7tAXCe0qh/TavDTtpo5hi1HEa5FCHcCgrTPCjFO1ZOjF1uQfYoazeEEmdDA4bDIPhM
         q1kjFa5pw20a9yir9XgyacK9FlJl0vBVZeqsDO10=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34AKTsu2026223
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 May 2023 15:29:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 May 2023 15:29:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 May 2023 15:29:53 -0500
Received: from a0498204.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34AKTqDG003872;
        Wed, 10 May 2023 15:29:52 -0500
From:   Judith Mendez <jm@ti.com>
To:     <linux-can@vger.kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Schuyler Patton <spatton@ti.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/2] Enable multiple MCAN on AM62x
Date:   Wed, 10 May 2023 15:29:50 -0500
Message-ID: <20230510202952.27111-1-jm@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AM62x there are two MCANs in MCU domain. The MCANs in MCU domain
were not enabled since there is no hardware interrupt routed to A53
GIC interrupt controller. Therefore A53 Linux cannot be interrupted
by MCU MCANs.

This solution instantiates a hrtimer with 1 ms polling interval
for MCAN device when there is no hardware interrupt property in
DTB MCAN node. The hrtimer generates a recurring software interrupt
which allows to call the isr. The isr will check if there is pending
transaction by reading a register and proceed normally if there is.
MCANs with hardware interrupt routed to A53 Linux will continue to
use the hardware interrupt as expected.

Timer polling method was tested on both classic CAN and CAN-FD
at 125 KBPS, 250 KBPS, 1 MBPS and 2.5 MBPS with 4 MBPS bitrate
switching.

Letency and CPU load benchmarks were tested on 3x MCAN on AM62x.
1 MBPS timer polling interval is the better timer polling interval
since it has comparable latency to hardware interrupt with the worse
case being 1ms + CAN frame propagation time and CPU load is not
substantial. Latency can be improved further with less than 1 ms
polling intervals, howerver it is at the cost of CPU usage since CPU
load increases at 0.5 ms.

Note that in terms of power, enabling MCU MCANs with timer-polling
implementation might have negative impact since we will have to wake
up every 1 ms whether there are CAN packets pending in the RX FIFO or
not. This might prevent the CPU from entering into deeper idle states
for extended periods of time.

v4:
Link: https://lore.kernel.org/linux-can/c3395692-7dbf-19b2-bd3f-31ba86fa4ac9@linaro.org/T/#t

v2:
Link: https://lore.kernel.org/linux-can/20230424195402.516-1-jm@ti.com/T/#t

V1:
Link: https://lore.kernel.org/linux-can/19d8ae7f-7b74-a869-a818-93b74d106709@ti.com/T/#t

RFC:
Link: https://lore.kernel.org/linux-can/52a37e51-4143-9017-42ee-8d17c67028e3@ti.com/T/#t

Changes since v4:
- Remove poll-interval in bindings
- Change dev_dbg to dev_info for case where hardware int exists and polling
is enabled

Changes since v3:
- Wrong patches sent

Changes since v2:
- Change binding patch first
- Update binding poll-interval description
- Add oneOf to select either interrupts/interrupt-names or poll-interval
- Sort list of includes
- Create a define for 1 ms polling interval
- Change plarform_get_irq to optional to not print error msg
- Fix indentations, lengths of code lines, and added other style changes

Changes since v1:
- Add poll-interval property to bindings and MCAN DTB node
- Add functionality to check for 'poll-interval' property in MCAN node 
- Bindings: add an example using poll-interval
- Add 'polling' flag in driver to check if device is using polling method
- Check for both timer polling and hardware interrupt case, default to
hardware interrupt method
- Change ns_to_ktime() to ms_to_ktime()

Judith Mendez (2):
  dt-bindings: net: can: Add poll-interval for MCAN
  can: m_can: Add hrtimer to generate software interrupt

 .../bindings/net/can/bosch,m_can.yaml         | 20 +++++++++--
 drivers/net/can/m_can/m_can.c                 | 28 ++++++++++++++-
 drivers/net/can/m_can/m_can.h                 |  4 +++
 drivers/net/can/m_can/m_can_platform.c        | 35 +++++++++++++++++--
 4 files changed, 81 insertions(+), 6 deletions(-)


base-commit: 578215f3e21c472c08d70b8796edf1ac58f88578
-- 
2.17.1

