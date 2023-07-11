Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70DC74E709
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGKGQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGKGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:16:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE7E5;
        Mon, 10 Jul 2023 23:16:26 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36B6G6Ln054514;
        Tue, 11 Jul 2023 01:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689056166;
        bh=sRk4a0Olo7w6uKJ2VgPRT1BGt4wDfKLVnOht3tbdLjQ=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ZuvfgS9pWGXUjxFwgGk7y6qW6PJGEjN+6ThWM0H5gdAu5Y1rbEbtAwM+kADerPPN1
         AGSCpnwiAs/LJ16DcCvIJhoAe2rmczETbIhV1LrT0x0P0R+cFqouC0elcMH8pIFWJm
         qScRq+MYz3lnMDyczV8tBHt6PqhhiDdWliQFhfMU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36B6G6ob027188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jul 2023 01:16:06 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jul 2023 01:16:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jul 2023 01:16:05 -0500
Received: from [172.24.19.15] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36B6G2DQ008888;
        Tue, 11 Jul 2023 01:16:02 -0500
Message-ID: <ac95ffd2-50c6-f715-5c37-f658bacf4ca4@ti.com>
Date:   Tue, 11 Jul 2023 11:46:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] PCI: j721e: Allow async probe
To:     Li Chen <me@linux.beauty>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1892e291fa4.1219137911620526.2248312811348305435@linux.beauty>
Content-Language: en-US
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <1892e291fa4.1219137911620526.2248312811348305435@linux.beauty>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2023 7:53 AM, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> I observed that on Ambarella SoC, which also utilizes
> the Cadence controller, the boot time increases by 1
> second when no endpoints (including switch) are connected
> to PCIe. This increase is caused by cdns_pcie_host_wait_for_link.
> 
> Enabling async probe can eliminate this boot time increase.
> 
> I guess j721e also has this issue.
I have tested this along with:
https://lore.kernel.org 
/all/1892e2ae15f.f7e5dc061620757.4339091752690983066@linux.beauty/

But I couldn't find second patch in this series.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
Tested-by: Achal Verma <a-verma1@ti.com>
> ---
>   drivers/pci/controller/cadence/pci-j721e.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index e70213c9060a..660c13bdb606 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -561,6 +561,7 @@ static struct platform_driver j721e_pcie_driver = {
>   		.name	= "j721e-pcie",
>   		.of_match_table = of_j721e_pcie_match,
>   		.suppress_bind_attrs = true,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
>   };
>   builtin_platform_driver(j721e_pcie_driver);
