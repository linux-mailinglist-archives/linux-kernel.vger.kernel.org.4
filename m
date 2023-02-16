Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D7698F59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBPJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBPJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:09:15 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B438651;
        Thu, 16 Feb 2023 01:09:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OatCrkFY4IV3dIdlxGlGfK46e6dXRkVXrB3N9CQ6EUf8RlnosV4OkkP8qJdlRBxZRdJPQgUxPaFcAqHKu65WRniDtdKSIXHBxVZFH9RUqQkdOG2Q8T7xIwI3pMHnTxxc9iNCUBccwRJTIgkhg/ae4pPM73e/TrBV4QdUlJy2KUTbU1/PXHWlgFZYktH+hNSUyj4kS0K2s6tLlLkov1yBdN1kgwX6k/4zug7OvJJXHL0O4Iqx952H/+cOCtoc9P0vjSxtbZkKZ+6kjdWAl+dNaaoEpbYTFyBAIqcgcDyU7kzIctbZF/2kdKAX7HXLQAvizikC/T01ncPdea/Cf06gWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+mymzOLEjdQ/VU1ZVF4PDCLdk5m0fenRLBsYEMUmAw=;
 b=lRJP7WUbTVR2NEJ7vUr8WQ8h82VsuukbAonJAJYqKb6FRrYgEkN8TMXTWagk2o+Rl58jcAXJUQyJeMQ6yjLm5Uxa9VUsWSt0kUnCz+sWLRsqy/9RuIuOkh3MarJreNuoJ4ZWIM+K8Ijo/5NVmMCT+yL/8B5AIWtKZ+b/LjDeEqwkIE1wqB3hvaBmusoT/wKtaoscINiIUfwei1xTLGfVhMUAu4xLQlOeZ5e/sgd+1+Hkdbb5EOiQFnx0mfsdm+fzqNkocAiRKgICpuL2lceC4OqSR4gWua1RinKItZtIP0e3B7TDQVWwoet4gBW6kBV4v3auA9F+fPB3TUOujcAHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+mymzOLEjdQ/VU1ZVF4PDCLdk5m0fenRLBsYEMUmAw=;
 b=Eg4EqNozpXWXOAVN3Bi0Op0yxW29YJvsRzKxFTxueIMpUnmIlj1fHAzXmcD117cqMGh2IKirTXG2ZBs3zmOzOCWzU3xohMyjc3123JVGkdqHMIN1QlOpdntxv07JDLwB5ijnx59FqET0B3Qj6UnqXWJUdhvbKWcMD0+cLmtmch0=
Received: from MW4PR04CA0217.namprd04.prod.outlook.com (2603:10b6:303:87::12)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 09:09:12 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b7) by MW4PR04CA0217.outlook.office365.com
 (2603:10b6:303:87::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 09:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Thu, 16 Feb 2023 09:09:11 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 03:09:08 -0600
Message-ID: <ae336a89-4e2a-f20b-7723-fbeed2a30bde@amd.com>
Date:   Thu, 16 Feb 2023 10:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 1/1] usb: dwc3: xilinx: Remove unused of_gpio,h
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20230215165239.83806-1-andriy.shevchenko@linux.intel.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230215165239.83806-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb588ed-b08e-4731-d0d3-08db0ffd7835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2c3/zpkTidkvOR9VuHb/wne9ys1cDqmXAAOzmd/Pcw1Ocqsn1wPRyXPV6uJp6f7t7Ca8kbk+nB0/z50NSLwk5LconpSm+73K+jkx4IUeRUWtFvZoOY7kXf+/biJULgHJgVCrvYKA/VXp9++vpQAmy9rBxzY7lMMUc5PvLEVlbaoKjp71brTnNuzL2TsnnFgQE7tICK1GOwxsAOnSLfY0ysFcNfGk4vmXg5aP9xnDJfwZk9aVCPPutPZvx54B1s1I/X7WAsCx4GNpwIlH6/CJi83NS3G6kl2cMPG4UEeNHS07sPlGMzA8tqZmQoB+t+2ecJF3pXcA3aOvYdvB3m9Oz/myqwLmzc3Val/GYmKlniOBLK5VYGD4uT8AC+0/WCNQ2ELgTN+gz8cgK3T6LrRF+sfpJL+2BD6X/CQCY6484nfoqE2AcKWu818i4+7syUnlpeOboj2++sqI7s6eA3i1OymRiIJFzaAheqwoKMRRWO4emPEFhbs+rNcxMACik+oi0kLyCv7qdjHXn3/HL+e+o9RSbgvRQvPN6/kWMyybXUWRkqv3WcMmXtqwRFj3E1ZXZGLnessxiIcKTc1AMM9kvf4S8FYfk0nynVtInUaDz9onPRzSWGy8nuPnMeW7fp6Fn64hnA7HVEm9GWUxqh3X1v2bjCOtMtVBETR0nB9cxTeyMvk9oI2CqRfC9DV4DhGXSpzHYXUCI1tzDPyOLOg1GCNbhfPYmGBPkwadQOYMa0XeIip/xuYVJY0wnHCbN6hhVZIEqNwT7J7K5beuuksuM/HDs6CgfUEtZfX+YijbXBA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(44832011)(4744005)(8936002)(31696002)(40480700001)(86362001)(4326008)(41300700001)(356005)(5660300002)(8676002)(40460700003)(36860700001)(54906003)(16576012)(316002)(110136005)(36756003)(70206006)(70586007)(81166007)(82740400003)(6666004)(31686004)(16526019)(186003)(26005)(53546011)(478600001)(82310400005)(47076005)(426003)(336012)(2906002)(2616005)(36900700001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:09:11.8648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb588ed-b08e-4731-d0d3-08db0ffd7835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/23 17:52, Andy Shevchenko wrote:
> 
> 
> of_gpio.h provides a single function, which is not used in this driver.
> Remove unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/usb/dwc3/dwc3-xilinx.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index 0745e9f11b2e..2c36f97652ca 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -14,7 +14,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/gpio/consumer.h>
> -#include <linux/of_gpio.h>
>   #include <linux/of_platform.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/reset.h>
> --
> 2.39.1
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
