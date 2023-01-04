Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935F365CD11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjADG15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjADG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:27:35 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D91A224;
        Tue,  3 Jan 2023 22:26:45 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3046QM1J054819;
        Wed, 4 Jan 2023 00:26:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672813582;
        bh=50kwzeglqLbLMm3hsB8pVB3cbz/k2cqY2lSOghSdHi0=;
        h=From:To:CC:Subject:Date;
        b=XshEnZoIwSAV2ogPAWiDkr4AE/Cew8HetGElgh2WroqgFcrcGtN+ZohAFswf7HVIJ
         c31wNmb2oswu4tOTtzZLPCxJPD8RHwiPAukAYmA8GaoNpIic+Qu2ZtsFkrrOthuxOx
         /Ky/NsW0uL+pqngVdd3whvTtLofp6yTHZUYYTegA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3046QMkI104557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jan 2023 00:26:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 4
 Jan 2023 00:26:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 4 Jan 2023 00:26:22 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3046QLJt047826;
        Wed, 4 Jan 2023 00:26:21 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh <vigneshr@ti.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH 0/2] spi: cqspi: Fix register reads in STIG Mode
Date:   Wed, 4 Jan 2023 11:56:02 +0530
Message-ID: <20230104062604.1556763-1-d-gole@ti.com>
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

Intent of these patches is to fix register reads in STIG mode and also
use STIG mode while reading flash registers.
Currently if you try to read a register while in STIG mode there is no
support for ADDR and thus naturally a register never gets read from the
flash.

Logs demonstrating the usage and working of QSPI-NOR Flash (Cypress
s25hs512t) on a modified AM625 SK EVM can be found on the link below:
https://gist.github.com/DhruvaG2000/a9b90d3d9c60edd3b2d8a360d869a00b

A series very similar to this was also sent to u-boot and the latest
revision can be viewed here:
[PATCH V4 0/2] spi: cqspi: Fix register reads in STIG Mode
https://lore.kernel.org/u-boot/20230103063112.1165898-1-d-gole@ti.com/


Dhruva Gole (2):
  spi: cadence-quadspi: setup ADDR Bits in cmd reads
  spi: cadence-quadspi: use STIG mode for small reads

 drivers/spi/spi-cadence-quadspi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
2.25.1

