Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EB62F38D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiKRLVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbiKRLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:19:53 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FC2FFEE;
        Fri, 18 Nov 2022 03:19:37 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AIBJQBI000521;
        Fri, 18 Nov 2022 05:19:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668770366;
        bh=LM8ezV6TecVQu25z5Lbydgt5yexPr7glIAePeC3iCRU=;
        h=From:To:CC:Subject:Date;
        b=bCURE0Bgev0m/AQY0y9G2Q13Oi8B98BaCpe0hujhG5A0EorP/X0UWNPgWSzRBjmy9
         5Undlpwz4KU0zv4g2utTEWP0HGHosTePnqanMuainsxA/pzv3mq6MFO8hqpDG3D/l+
         Ywsi8VbU+cONNlRrDNHpEpezDExMevqRPzLgUJJw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AIBJQHE100331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 05:19:26 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 18
 Nov 2022 05:19:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 18 Nov 2022 05:19:26 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AIBJQtA051645;
        Fri, 18 Nov 2022 05:19:26 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2AIBJPD3029459;
        Fri, 18 Nov 2022 05:19:26 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v9 0/6] Introduce PRU remoteproc consumer API
Date:   Fri, 18 Nov 2022 16:49:18 +0530
Message-ID: <20221118111924.3277838-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Programmable Real-Time Unit and Industrial Communication Subsystem
(PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
RISC cores (Programmable Real-Time Units, or PRUs) for program execution.

There are 3 foundation components for PRUSS subsystem: the PRUSS platform
driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
already merged and can be found under:

1) drivers/soc/ti/pruss.c
   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
2) drivers/irqchip/irq-pruss-intc.c
   Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
3) drivers/remoteproc/pru_rproc.c
   Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml

The programmable nature of the PRUs provide flexibility to implement custom
peripheral interfaces, fast real-time responses, or specialized data handling.
Example of a PRU consumer drivers will be:
  - Software UART over PRUSS
  - PRU-ICSS Ethernet EMAC

In order to make usage of common PRU resources and allow the consumer drivers to
configure the PRU hardware for specific usage the PRU API is introduced.

This is the v9 of the patch series [1]. This version of the patchset 
addresses the comments made on v8 [8] of the series. 

Two more patch series have been posted ([2] and [3]) that depends on this
series, one has been posted to the soc/ti/ tree and another  
to the networking tree. All the 3 series including this one, has been 
sent as RFC [4] to get comments and to explain the dependencies.

Changes from v8 to v9 :

*) Fixed the warnings generated by running checkpatch.pl script.
*) Added Review/Ack tags.
*) Listed just the SoBs tags for all the patches as suggested by Mathieu.
*) Removed a comment for an already documented field in patch 5/6 of this series.

Changes from v7 [7] to v8 :

*) Removed get_device(&rproc->dev) from API __pru_rproc_get() in patch 2/5 of 
this series as asked by Roger. 
*) Replaced all the SoBs (other than mine) to Co-developed-by tags for all 
the patches in this series as asked by Mathieu.
*) Added a new patch (3/6) in this series for Introduction of pruss_pru_id enum.
Previously this enum was part of patch 2/6. As asked by Roger removed this enum 
(and the APIs that are using the enum) from patch 2/6 and added it in new patch.
*) Removed a comment for an already documented field in patch 2/6 of this series.
*) Changed 'pru' to 'PRU' in comment of API pru_rproc_set_firmware() as asked by 
Roger.

Changes from v6 [6] to v7 :

*) Removed example section from ti,pru-consumer.yaml as the full example 
included compatible property as well which is not introduced in this series 
thus creating dt check binding error. Removing the example section fixes the
dt binding check error. The example section will be included in 
"ti,icssg-prueth.yaml" in the next version of series [3]
*) Updated the commit message for patch 1/5 of this series to address Krzysztof's 
comment.

Changes from v5 [5] to v6  :

*) Added rproc_get_by_phandle() in pru_rproc_get() 
*) Provided background of Ctable in the commit messege.
*) Removed patch "" [9] (6th Patch of the previous version of this series)
   as it has dependency on series [2], thus creating a cyclic dependency.

The patch [6] will be sent along with the next version of series [2].

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220603121520.13730-1-p-mohan@ti.com/
[2] https://lore.kernel.org/all/20220418123004.9332-1-p-mohan@ti.com/
[3] https://lore.kernel.org/all/20220531095108.21757-1-p-mohan@ti.com/
[4] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
[5] https://lore.kernel.org/all/20220607045650.4999-1-p-mohan@ti.com/
[6] https://lore.kernel.org/all/20221012114429.2341215-1-danishanwar@ti.com/
[7] https://lore.kernel.org/all/20221031073801.130541-1-danishanwar@ti.com/
[8] https://lore.kernel.org/all/20221116121634.2901265-1-danishanwar@ti.com/
[9] https://lore.kernel.org/all/20220607045650.4999-7-p-mohan@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (1):
  remoteproc: pru: Add enum for PRU Core Indentifiers.

Roger Quadros (1):
  remoteproc: pru: Add pru_rproc_set_ctable() function

Suman Anna (2):
  dt-bindings: remoteproc: Add PRU consumer bindings
  remoteproc: pru: Make sysfs entries read-only for PRU client driven
    boots

Tero Kristo (2):
  remoteproc: pru: Add APIs to get and put the PRU cores
  remoteproc: pru: Configure firmware based on client setup

 .../bindings/remoteproc/ti,pru-consumer.yaml  |  60 +++++
 drivers/remoteproc/pru_rproc.c                | 235 +++++++++++++++++-
 include/linux/pruss.h                         |  78 ++++++
 3 files changed, 368 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
 create mode 100644 include/linux/pruss.h

-- 
2.25.1

