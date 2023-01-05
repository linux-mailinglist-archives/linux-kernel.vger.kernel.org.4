Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0F65E79E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAEJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAEJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:22:13 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF45007E;
        Thu,  5 Jan 2023 01:22:11 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3059Lq07001449;
        Thu, 5 Jan 2023 03:21:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672910512;
        bh=Ug90vBwWio6H1ClsNvNr/QSfF1oQKi8Z+vFQ82U5RTE=;
        h=From:To:CC:Subject:Date;
        b=ygRo5KH/27MbqP/vNMTRr8fPL3K1BvcFtCx4obMk6oe1fNBE9V9z3NWH+UPLJB+52
         5xddxpB9Bio/TEdg7N/pVbSk88BDnIMHvHYvUtFQKuY6B/nWgt2mx00w73DrEWk6av
         NsKOjb5VIN6oS2Lz2ePo0blhRaPSBU3pt7a0KFVw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3059Lq4b049084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jan 2023 03:21:52 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 5
 Jan 2023 03:21:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 5 Jan 2023 03:21:52 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3059Lql8127355;
        Thu, 5 Jan 2023 03:21:52 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3059LoOp018121;
        Thu, 5 Jan 2023 03:21:51 -0600
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
Subject: [PATCH v13 0/6] Introduce PRU remoteproc consumer API
Date:   Thu, 5 Jan 2023 14:51:43 +0530
Message-ID: <20230105092149.686201-1-danishanwar@ti.com>
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

This is the v13 of the patch series [1]. This version of the patchset 
addresses the comments made on v12 [12] of the series. 

Two more patch series have been posted ([2] and [3]) that depends on this
series, one has been posted to the soc/ti/ tree and another  
to the networking tree. All the 3 series including this one, has been 
sent as RFC [4] to get comments and to explain the dependencies.

Changes from v12 to v13 :

*) Fixed the checkpatch warning in patch 2/6 of the series.

Changes from v11 [11] to v12 :

*) Removed extra put_device() from pru_rproc_get() API as asked by Roger.
*) Removed rproc_put() call in the API __pru_rproc_get() when 
rproc_get_by_phandle() returns null. Instead of that just return the error 
pointer.

Changes from v10 [10] to v11 :

*) Re-ordered the patches 2/6 and 3/6 of the series as asked by Roger. Now the 
2/6 patch of the series introduces the enum pruss_pru_id and the header file 
<linux/pruss.h>. The patch 3/6 of the series introduces the pru_rproc_get() 
and pru_rproc_put() APIS with their actua desired arguments.

Changes from v9 [9] to v10 :

*) There was compilation issue in v9 of the series because of dependencies 
between 2nd and 3rd patch of the series. Fixed the dependencies in this series.
*) Added enum documentation following the kernel-doc style [13] as asked by 
Roger for 3/6 patch of the series.

Changes from v8 [8] to v9 :

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
*) Removed patch "" [14] (6th Patch of the v5 of this series)
   as it has dependency on series [2], thus creating a cyclic dependency.

The patch [14] will be sent along with the next version of series [2].

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220603121520.13730-1-p-mohan@ti.com/
[2] https://lore.kernel.org/all/20220418123004.9332-1-p-mohan@ti.com/
[3] https://lore.kernel.org/all/20220531095108.21757-1-p-mohan@ti.com/
[4] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/
[5] https://lore.kernel.org/all/20220607045650.4999-1-p-mohan@ti.com/
[6] https://lore.kernel.org/all/20221012114429.2341215-1-danishanwar@ti.com/
[7] https://lore.kernel.org/all/20221031073801.130541-1-danishanwar@ti.com/
[8] https://lore.kernel.org/all/20221116121634.2901265-1-danishanwar@ti.com/
[9] https://lore.kernel.org/all/20221118111924.3277838-1-danishanwar@ti.com/
[10] https://lore.kernel.org/all/20221201110500.4017889-1-danishanwar@ti.com/
[11] https://lore.kernel.org/all/20221207110411.441692-1-danishanwar@ti.com/
[12] https://lore.kernel.org/all/20221216053313.2974826-1-danishanwar@ti.com/
[13] https://www.kernel.org/doc/html/v6.0/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation
[14] https://lore.kernel.org/all/20220607045650.4999-7-p-mohan@ti.com/

Thanks and Regards,
Md Danish Anwar


MD Danish Anwar (2):
  remoteproc: pru: Add enum for PRU Core Identifiers.
  remoteproc: pru: Add APIs to get and put the PRU cores

Roger Quadros (1):
  remoteproc: pru: Add pru_rproc_set_ctable() function

Suman Anna (2):
  dt-bindings: remoteproc: Add PRU consumer bindings
  remoteproc: pru: Make sysfs entries read-only for PRU client driven
    boots

Tero Kristo (1):
  remoteproc: pru: Configure firmware based on client setup

 .../bindings/remoteproc/ti,pru-consumer.yaml  |  60 +++++
 drivers/remoteproc/pru_rproc.c                | 230 +++++++++++++++++-
 include/linux/pruss.h                         |  83 +++++++
 3 files changed, 368 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
 create mode 100644 include/linux/pruss.h

-- 
2.25.1

