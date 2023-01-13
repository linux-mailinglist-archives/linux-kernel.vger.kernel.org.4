Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B566697C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbjAMMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbjAMMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:54:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD95D681;
        Fri, 13 Jan 2023 04:41:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkRu+MAIPyanbo+GQ7JXW4BAKGisoqbXC4B8J7VcnR/HJXHbye2RE56L9wlE5l7unpwe538gtTQo4a2uWayEPKoMCHg7Za+3dyl0QLO6vcuzthtNwXEM/dsJvcwgSg4eDFwycRBydMFR3bM6dwSXago+IS8GLGa727rkbeJL+8z0dRMmHoEi8/Ko2ix0Ih2omCh+LAUq9DRe3jfzHmBPdnoeAtf1edSq2dJ6Q72ygntPaASOe5lqL9SBasFnUKXyiozEd80n0wES5oQ/nNB/HGZyQx442qOU61umD2Opj4Q++TesyqOpIcJN889B0wfOWsdMeNL2IU0cEzZaLuPeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIOHMlDg5rOT1XkRpWcUVw1Fd1qdz+zYNC5GDeREbXQ=;
 b=Nd58Xlu22oGiZgD0wO2gpUss+lKo+sBHd+qnt9rPT8L2h3UbXBJ6KVtARj6iY/adL54ZNOO7O2sr80idC0wtwlmBuIzXANqsdf25UMZ4uexkxjSgOAN9xyuCZ044tvpaVWVDI9NwSLbhMRxWJ4zhZO80ICqhe1MLhezwG2l7gTdZ82CplOyN6A0BDcgntpZilfBavNgf3KVdB17oXOO21E1FWzt1rU3Qr6gMFvPK7p+ZD5zUqKqMQaF3BVb2QrMidyOx/MFVmtc4dg+zKBvnLT/CItSpNxnJJqEgfgq254RXOEOqZggaRE0oN5e8NdXi3mGtpAa9RBbtz/5WzAxBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIOHMlDg5rOT1XkRpWcUVw1Fd1qdz+zYNC5GDeREbXQ=;
 b=FDLPjSdVDxHP6hqfKlfJSHcazslmwLdG22aWRyYe1b0Oe1Gtrl7oQl7DcfVf2qcBBJXOkFdmIT1Gr0XoFmGg2C2xaF3W2aX9mdjQAgWFwjydnQ58n3ncnunsHYYv5HOagthVujGN8MdAiVKeOzFBJjdY6A3HAwk2toWdYZOe/ZwvYMLnrc15ZkkkCg3NUe065kAwIVCdFTWDe5FiZ44+TK1MTe/TRxegILqKyf4Gkdvlt/YW6vSsgN9xjB+3plxzp4zpaAB+XbN41hXaC6tAPAqF5pqKO2FlVtyTOAypnzQqUEks1C4K//bTBlYEa9uqaJrVmmbctNYYASIx+klM5w==
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 12:41:07 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::cd) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 12:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 12:41:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:40:59 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 04:40:54 -0800
Message-ID: <649872f1-c92d-1046-1087-d553244a3572@nvidia.com>
Date:   Fri, 13 Jan 2023 18:10:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>, <treding@nvidia.com>,
        <krzysztof.kozlowski@linaro.org>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <62fc4a96-bab8-4d43-5278-3375e34431e7@gmail.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <62fc4a96-bab8-4d43-5278-3375e34431e7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 85706aea-2b3d-45dd-ec2c-08daf5637116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy2YZKkGsQZmJfoo+qeN97YQpAtLsNesuNEWOtOJCg49Eb5Rk4KOsT+BL3q4hmNcAEa47EYeLVEXw1+spJeBr/962Bxl73LnU7EWWWOarXRuA5Jlk7ku0Ugwdoi1V65Jf1qFPn4SrVFK+xcxkYRSlFLws1ddjqtk9/JVqIj+ZJjUHzniMDujUVSsHM9yqVXXLCqY6sWC0yg2wMPT9PZTD/XdAID0MkE6ze8JPmr685myHw9e+UJagUSqcxarMKM9ss7uNWQPk0cPif2UyxlyPCvemWhnHcnkA5DXi8zNowxnjD7Zo6LTaVu9YjwfYCB50exutdus3yxGYwhRzdp4SUJz8mL8kVj2LrUnbgexj9IxWpc/zBlM1B0BZUSVd8O3XU1qmBMbeme55bs0TBWLKDGt5wsBAQe9VMjjmgT3248H/+aJRqXsmBegjbcTQZcbpZnaKJhsit2fW2a8YgAecZrPUiXR39HwM8X/l10yO9sA/L6UI69UqVC943XBk9AcQaLWHGxWWtS6gJjUsYjYf909UuQtLMk+uAT4uAXwwNpZAoEWcKNRtIawU+RcTqJSbJL0rSnnjvAaOhnY2g0rBzrq/LkYUuJOaK2Tz2qrrTllfBWMjqClTmvY1v0duad43IxebHD5xDtf7rNYb/RjtskPrWA0351anDa84N/zAldhQbPFRwCmH965wqc1X/JsT2rFqgWjxnQqhc1L901hv/4CCU4RdtXBQZRa5kSA5/EPYpQpnm8zAJ6KW5TxGlxg
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(7416002)(36860700001)(6666004)(107886003)(36756003)(2906002)(70206006)(5660300002)(53546011)(31686004)(8936002)(4326008)(83380400001)(8676002)(82740400003)(478600001)(47076005)(41300700001)(921005)(426003)(7636003)(356005)(16526019)(26005)(336012)(70586007)(82310400005)(186003)(40480700001)(31696002)(54906003)(16576012)(40460700003)(2616005)(86362001)(316002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 12:41:07.2679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85706aea-2b3d-45dd-ec2c-08daf5637116
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/22 00:50, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 20.12.2022 19:02, Sumit Gupta пишет:
>> +static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
>> +{
>> +     struct tegra186_emc *emc = to_tegra186_emc(dst->provider);
>> +     struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>> +     struct mrq_bwmgr_int_request bwmgr_req = { 0 };
>> +     struct mrq_bwmgr_int_response bwmgr_resp = { 0 };
>> +     struct tegra_icc_node *tnode = mc->curr_tnode;
>> +     struct tegra_bpmp_message msg;
>> +     int ret = 0;
>> +
>> +     /*
>> +      * Same Src and Dst node will happen during boot from icc_node_add().
>> +      * This can be used to pre-initialize and set bandwidth for all clients
>> +      * before their drivers are loaded. We are skipping this case as for us,
>> +      * the pre-initialization already happened in Bootloader(MB2) and BPMP-FW.
>> +      */
>> +     if (src->id == dst->id)
>> +             return 0;
>> +
>> +     if (mc->curr_tnode->type == TEGRA_ICC_NISO)
> 
> The mc->curr_tnode usage looks suspicious, why you can't use src node?
> 

Now, we can get rid of "curr_tnode" after moving the code from the EMC 
to MC driver for transferring MC client's request info to the BPMP.
