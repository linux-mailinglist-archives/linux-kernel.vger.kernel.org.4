Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243FD6F0693
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbjD0N0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjD0N0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:26:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35F4489;
        Thu, 27 Apr 2023 06:26:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33RDPmJJ096873;
        Thu, 27 Apr 2023 08:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682601948;
        bh=b8AExFsegoctAr6d5U8odl38q2tDeqKo1U4bNOto0LY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uGmqvtqHSTQO90OsmgzoXQGALvQ+qDggdxQ2egUKBvTHG3Sx3sU0RuC90bwf8f9WL
         jk3tzyakBz9Jmghm6g0TdOQLpZTmahcvEFvwau+eO6PtqWhAvDZF/b0gQ2m7ZJcHnw
         qCC7zmmaJDelmTrcNIlPq67JPkhUsGoXZdcBmG5Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33RDPmla062899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Apr 2023 08:25:48 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Apr 2023 08:25:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Apr 2023 08:25:48 -0500
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33RDPiPx112328;
        Thu, 27 Apr 2023 08:25:45 -0500
Message-ID: <b1d30948-ba3d-a4cc-e1ed-851a9dedba7c@ti.com>
Date:   Thu, 27 Apr 2023 18:55:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: RE: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Content-Language: en-US
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Mark Brown <broonie@kernel.org>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-5-d-gole@ti.com>
 <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
 <OSZPR01MB7004D229048A950C93B40CC88B6A9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <OSZPR01MB7004D229048A950C93B40CC88B6A9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/04/23 06:11, Yoshitaka Ikeda wrote:
> Hi Dhruva,
> 
>> Please can you send me the register fields information for the CQSPI
>> controller used in this device?
>> I wanted to verify if atall there were any mismatch between the controller I
>> have tested with vs your SOC's controller.
> 
> You can find it in the pdf that can be obtained by pressing the download button in the upper right corner of the following website.
> - https://www.intel.com/content/www/us/en/docs/programmable/683126/15-0/introduction.html

Thanks for sharing, I went through and couldn't really find any major
changes at the controller level.
So I am wondering if some specific sequence of flash operations on your 
device is exposing some issues in the driver's STIG reads.


Please can you share some logs with the following patch:
I am trying to see a pattern that may be causing issues.
I am unable to reproduce this on my end at the moment.

...
diff --git a/drivers/spi/spi-cadence-quadspi.c 
b/drivers/spi/spi-cadence-quadspi.c
index 6ddb2dfc0f00..5fa71dbd37ef 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1390,6 +1390,14 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, 
const struct spi_mem_op *op)
         int ret;

         ret = cqspi_mem_process(mem, op);
+       /* debug */
+       printk("**********spi_mem_op dump**************");
+       printk("addr: nbytes:0x%X , buswidth 0x%X, dtr 0x%X, val 
0x%llX", op->addr.nbytes, op->addr.buswidth, op->addr.dtr, op->addr.val);
+       printk("cmd: nbytes:0x%X , buswidth 0x%X, dtr 0x%X, opcode 
0x%X", op->cmd.nbytes, op->cmd.buswidth, op->cmd.dtr, op->cmd.opcode);
+       printk("data: nbytes:0x%X , buswidth 0x%X, dtr 0x%X, data dir 
0x%X", op->data.nbytes, op->data.buswidth, op->data.dtr, op->data.dir);
+
+       printk("***************************************");
+       /* ---------------------------- */
         if (ret)
                 dev_err(&mem->spi->dev, "operation failed with %d\n", ret);


...

-- 
Thanks and Regards,
Dhruva Gole
