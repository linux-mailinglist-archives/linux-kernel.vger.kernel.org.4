Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3886D74DB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGJQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGJQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:49:13 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF9AE3;
        Mon, 10 Jul 2023 09:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFGr/OkyJzCeI+yoXKWVEOBjEDXmDQ/A1qPBjTom3t1GvAvwqDnRargSI4V+NAcQ/o5SzGVF5sAfO0bs5FkGjoYiMeBi8TKM57CbXv0Nuw8tbsNZKdPRf/2XL+sJDVaDCTBne/LwzJRnUos7sH4f7vY3r/zUGhQIljCshWWFivsePOxBBSqRgQWS+m3+znbOQZYff4BkQjHZJOtuGCZJe7k5TynJ2Dn/fqDp704m703qDD880YSoGNuMc3353axUs8qp+YaNveAbI9m+ehs7ij01mYHgJ88090HcgsS1idWsgP1xP72uiriL2Ti/hNhjQpFGORHW5Ee2LKEZobNK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om2foE28y4cQh0VV+Z80jREBuxTv4o2la43unlNbJHw=;
 b=hyWfOSSdxrrfLr8awvIh4JmVnYKoywmh3YZMdADCZexalzr/JMExD1Q0k8z0Y1nV/Av/8QiJm4GpHnxWYrIEr2V7i+GynDIJ/olYZPrX3QwkwdAPxPm/jldrK9EjZopW+H9p/M3iTC9pJ1gwwEXA/oL7pyk2Li5gMqtbbm65PkpD9m8/RT7rNoFH/rXws3OwJvoZxdBC6JlcSyAOlRNfAsb021Ba7S9mIJxkAxhXGN00BH7dNNEbfYFD2t2AoL0Bv4j58ZvvXKzG4mGlf9isjNMWRot1sb2U26S46Qzb3YzQvk0Luhik4SRHdvGV3Q2+N3jrSlrxPRJKH5QNa5LkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om2foE28y4cQh0VV+Z80jREBuxTv4o2la43unlNbJHw=;
 b=gwagM/xZfnDUmZHQ8iUI5SdgJSbtIy1TOKe5WkCc8L1uOarDOBBPbST+dobka0O0q2t64o0OK2hynecj0i/bYfnPhqIC01fp6qg+/W0ArsD93/LhyzIuUrWi8Va+k5lFYUMTxtJCF5JyjpK0HtINQjkzTSDvAxhi6Qmt9vN3mvhBJ0zsk8EGcJ0rWw5b7iq55f/kBTbpy6rfsTuwDNkVTF47rieZ4c5kgzy75bW670SZmBp7CA+JpxPRhk8NFCXx9ELpRE7AyFUmgT2/4BV3sRjLxZQ4f50xeJBVuroWNGsfBXBYzbQmUrVXA2BbWA1xtLglSg0Myxm6f/ZMiEdp/A==
Received: from DM6PR04CA0006.namprd04.prod.outlook.com (2603:10b6:5:334::11)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:49:10 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::cd) by DM6PR04CA0006.outlook.office365.com
 (2603:10b6:5:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 16:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 16:49:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 09:49:00 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 09:48:56 -0700
Message-ID: <ac9e9e2a-00b8-c9e7-00c7-215cba139a39@nvidia.com>
Date:   Mon, 10 Jul 2023 22:18:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch RESEND 1/4] memory: tegra: sort tegra234_mc_clients table
 as per register offsets
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-2-sumitg@nvidia.com>
 <abdff39a-5306-b431-ae28-1e1a03c0a555@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <abdff39a-5306-b431-ae28-1e1a03c0a555@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a3560f-15a9-4a63-3736-08db816595a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTE4zEOqzIuqcJORsUyQiy+XQzmRvDjEwkSflmaa+SYjQooetBKb1in+yLk4R1Ct+jtt15zPnY+h07uNBay5gkcx46H0tOdQvZoosOR1WX/Nv59YgCB8WzjBbFT65v5o4JmEWIKkSVVuH39sFC9FRqPTDorHc/lsMfv4oifnLIwd1go9uBLXiFBkCegfJ2YFBOcbLE7vK+xdYVLI22e0pYfsT39/MxHbbz78W2j6M3yN0j7+JxBPV7oq1mhznFXumsxw4du4dvMEGSGVgUXvvpbxzPlrAAVkCfOdMl+rXRc+D6Eskd6/bw+KSCn4VSraTLBy6A/o0Cwp+l65WYTvt5xtzgSJQ+hSKJ2WBkFCYaRH8ytSd1RqOoCAbm2B8nF64nQ+oVsTchnaXXTx6NhXYjNFCl/K7bbYa+nzsdm4QkKI/b0C49z/g4JOUTo0nH9ce/N8T8tam2nSQgr1xvGddhybt75aOfvOMVEdpeMvpUlUhBm1hchv2FTjSSAjpQEMCO0lZqu72ejXa2EndW67k+69uHhytj5Qc+umOyJOKKtNDJWveJj2CGH8hR9l17s32KvjCja3sjnDBbE8LB2tLbvn1A/ClB/UiH9fwyjLe5t1GVaI9G8xAn5rIOVIuGSY2jp8y0aSKKCwQzxjEafsZgf6scMI2+0jY7St238T2qtyqNABeC+ChysJ8vB1GJUVGBXDP69YPjAclW/+lmHEI10QM1YbiiuPJVlbvfxfiRyHnjB+hXiPDu0ctYt6iSnlK+1EG5odSLh65UVjxe7DKQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(186003)(53546011)(16526019)(26005)(2616005)(36860700001)(107886003)(426003)(83380400001)(336012)(47076005)(4744005)(41300700001)(4326008)(2906002)(316002)(5660300002)(8936002)(8676002)(478600001)(70586007)(70206006)(110136005)(54906003)(16576012)(40480700001)(36756003)(356005)(7636003)(82310400005)(86362001)(31696002)(82740400003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:49:10.3938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a3560f-15a9-4a63-3736-08db816595a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/23 15:38, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 21/06/2023 15:43, Sumit Gupta wrote:
>> Sort the MC client entries in "tegra234_mc_clients" table as per the
>> override and security register offsets. This will help to avoid
>> creating duplicate entries.
> 
> If person cannot search for existing symbol before adding new entry, I
> doubt that sorting would solve it. OTOH, this patch makes backporting
> changes trickier, so I don't think this is good approach. Are all other
> Tegra files ordered in this matter?
> 
> 
> Best regards,
> Krzysztof
> 

They are in order for previous T194 SoC.
For T234 also, initially the entries were in order.

Thank you,
Sumit Gupta
