Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494456CA8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjC0P2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC0P2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:28:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905C611D;
        Mon, 27 Mar 2023 08:28:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSYpu073981;
        Mon, 27 Mar 2023 10:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679930914;
        bh=vembBHKzfCYf5PMfL3tKWXrfTUY6YKgAJ8delViusVU=;
        h=From:To:CC:Subject:Date;
        b=bJOA5qTs/3x/wplvJgGmZCpNKIiLMEZKN4E8hgn65RYf4uh7eoZXxIEAE6B3fStWR
         nLz4Utdhdcd2+dwOFX1sTjqlDNDSWipgPjb1aJ104Ff/XLrCDudkQhXTtinsyQ7XIm
         ODLi20/iORN/jo4XLlyMKzczwNruwcPX9sdRXblg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RFSYbO008967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:28:34 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:28:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:28:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RFSXNu044467;
        Mon, 27 Mar 2023 10:28:33 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v8 0/3] Add single core R5F IPC for AM62 SoC family             
Date:   Mon, 27 Mar 2023 20:58:29 +0530
Message-ID: <20230327152832.923480-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 SoC family don't have a multicore R5F cluster,                             
instead they have a single core R5F.                                            
This enables IPC support with single core R5F for AM62                          
family of SoCs.

While at it, also simplify the cluster mode setting usage
by using soc_data specific checks only at probe.

Devarsh Thakkar (3):
  remoteproc: k3-r5: Simplify cluster mode setting usage
  dt-bindings: remoteproc: ti: Add new compatible for AM62 SoC family
  remoteproc: k3-r5: Use separate compatible string for TI AM62x SoC
    family

 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  76 ++++++++---
 drivers/remoteproc/ti_k3_r5_remoteproc.c      | 127 ++++++++++++------
 2 files changed, 138 insertions(+), 65 deletions(-)
---
V2:                                                                             
  - dt-bindings: Avoid acronyms, use "Device Manager" instead of "DM"           
V3:                                                                             
  - dt-bindings: Use separate if block for each compatible for                  
    ti,cluster-mode property                                                    
  - dt-bindings: Rearrange compatibles as per alphabatical order                
V4:                                                                             
  - dt-bindings: Place each enum in separate line in allOf                      
V5:                                                                             
  - No change (fixing typo in email address)                                    
V6:                                                                             
  - dt-bindings: Remove reviewed-by due to new modifications to use             
    cluster-mode=3                                                              
    Introduce Simplify cluster-mode setting preamble patch per review           
comments                                                                        
  - Use CLUSTER_MODE_SINGLECORE for AM62x                                       
  - Set PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE for single core.                      
V7:                                                                             
  - Override to appropriate cluster-mode per firmware status flag               
    without checking soc_data                                                   
  - Set appropriate mode as default if not provided in DT                       
  - Check mode validity against SoC data during probe                           
  - Rebase on top of 6.3 linux-next                                             
V8:                                                                             
  - Avoid using soc_data while overriding cluster mode for IPC-only mode  
-- 
2.34.1

