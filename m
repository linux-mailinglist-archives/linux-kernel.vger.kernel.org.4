Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9AA6EEF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbjDZHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:39:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2130FE;
        Wed, 26 Apr 2023 00:39:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33Q7daHT055981;
        Wed, 26 Apr 2023 02:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682494776;
        bh=7LqVdOnzZtTQ3wyb6XvMcLktKP+1tC9WdQjlamBaQlU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qUJhUH9S+HHrl9WS64aXRQcfwCj3end0mvK/GI1XKZTb8t0/EmV2prek6M1kqbTUp
         AWJTHFTiZAxzvDy9tt0+da/GP0TvjoGflG87BCChXTlz6hMG3iwQpjj3r0NThIvazh
         n743DtDnN/q4kiNml3V3kKhSnQa4ktMjDNowvV5I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33Q7daPm107381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 02:39:36 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 02:39:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Apr 2023 02:39:35 -0500
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33Q7dWNI022730;
        Wed, 26 Apr 2023 02:39:33 -0500
Message-ID: <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
Date:   Wed, 26 Apr 2023 13:09:32 +0530
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
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshitaka,

On 26/04/23 08:04, Yoshitaka Ikeda wrote:
> Hi Dhruva,
> 
> An error occurred in the following environments where this patch was applied, and the flash could not be accessed.
> However, after reverting to this patch, it is possible to access it.
> 
> - Environment
>    - OS : Linux 6.3
>    - SoC : Cyclone V

Please can you send me the register fields information for the
CQSPI controller used in this device?
I wanted to verify if atall there were any mismatch between the
controller I have tested with vs your SOC's controller.

>    - Flash : MT25QL512A
> 
> - Error at startup
>    - Kernel log
> [ 0.980290] spi-nor spi0.0: found mt25ql512a, expected n25q512a
> [ 1.485140] cadence-qspi ff705000.flash: Flash command execution timed out.
> [ 1.490792] spi-nor spi0.0: operation failed with -110
> [ 1.494654] spi-nor spi0.0: mt25ql512a (65536 Kbytes)
> 
> - Error at access
>    - Access command and log
> # hexdump -Cv /dev/mtdblock0
> hexdump: /dev/mtdblock0: Input/output error
> 
>    - Kernel log
> [ 2124.201193] cadence-qspi ff705000.flash: QSPI is still busy after 500ms timeout.
> [ 2124.201229] spi-nor spi0.0: operation failed with -110
> [ 2124.201256] I/O error, dev mtdblock0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 2
> [ 2124.711241] cadence-qspi ff705000.flash: QSPI is still busy after 500ms timeout.
> [ 2124.711276] spi-nor spi0.0: operation failed with -110
> [ 2124.711302] I/O error, dev mtdblock0, sector 8 op 0x0:(READ) flags 0x80700 phys_seg 3 prio class 2
> [ 2125.221193] cadence-qspi ff705000.flash: QSPI is still busy after 500ms timeout.
> [ 2125.221230] spi-nor spi0.0: operation failed with -110
> [ 2125.221256] I/O error, dev mtdblock0, sector 16 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 2
> [ 2125.731237] cadence-qspi ff705000.flash:. QSPI is still busy after 500ms timeout.
> [ 2125.731270] spi-nor spi0.0: operation failed with -110
> [ 2125.731296] I/O error, dev mtdblock0, sector 24 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2
> [ 2126.241190] cadence-qspi ff705000.flash:. QSPI is still busy after 500ms timeout.
> [ 2126.241224] spi-nor spi0.0: operation failed with -110
> [ 2126.241251] I/O error, dev mtdblock0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [ 2126.241274] Buffer I/O error on dev mtdblock0, logical block 0, async page read
> 
> 
> regards,
> Yoshitaka Ikeda
> 
> 
> [..snip..]

It maybe that STIG mode may have some different way of configuring/using
on your SoC.

However at this point it's only a guess and I will wait till I have the
exact information on the controller specs being used in this device
along with the register descriptions.

-- 
Thanks and Regards,
Dhruva Gole
