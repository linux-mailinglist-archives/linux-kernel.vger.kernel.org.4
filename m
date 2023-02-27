Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70C6A4135
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjB0LwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjB0LwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:52:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F9C14A;
        Mon, 27 Feb 2023 03:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9QNqB3oQci/hE1va9ZJC9CYO8dVlyfmSn/kuhT0u0BVIELoSshfYu7o4Mud/31LA1MUAEMbOXVdvRrT6w40DRGQ/eEpbOFi/Iv3Xn/hFn7Ug8KV7EXcz3f47G0JOnHTbBJz1AWLHe4gFXM/ZmSLugvcsXfxhoxZbI76uCf7HX7qHsUCAb1jwhhYQsy9PiHtpWBhMwrgz0rLIsKEGvdgY1SWLU8ThP+0pjnnMYW2clK0zl+14A6TgUzmOx2S6Vrw3yQCegge+5SNWYB45kl4bxwd9FZcEGT7Gki/FAztP9Se/x+5K3l9KerR1d4/snqtAwovqOrPrTjnZulkbkpu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhKUiqO2g7obFCR/YquWnecenf+HQ2KdLQjHXLQEb0E=;
 b=neo6tfQUxVHUifF8/UTWNHTpeE8yDMTv8ItnzAJ23UQ3BsBX1pEdc5xbynLWb86cSxFTo9aUTKDps7dzaEpSFi3rw93jQCJ7zQHk6r5x9REtk37rQvaO7+Ef7i6iFVxnNY1obBAhPT+blKC3hULGCliOc2Uspq/iYqEqsHEWl65yY80ZQKewa/NGg43G1NjaA2PNsK2bWyxhOGCn/dsR0dfNu+wmN9yF9xoVMzxGoFl5+husmhuJ+TpTzVzb1U2XschaljkvXbooM5m5NY9Pa5hQIV9mdGsPG9zJaVwOOvfSX+QwoLEv0zWHwapXbt2DPASodn4yrZIP2MnMptAMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhKUiqO2g7obFCR/YquWnecenf+HQ2KdLQjHXLQEb0E=;
 b=v9eMk2/rJlQ4ATqbDJb8LNvXaob18gu2fILVr+67BwIl983ePrVoPNxMXOpttUkVag2iZ7ZUBSjP//HK3HipCP5RyIqngPC1y55Dgd8ldO9bTfHuj6IGUtVoUzd4zDzoTr3DDmm+SpwihUr38YmW5Ex7e2YzfSMW78pDpSa55Q4=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 11:52:08 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::9c) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16 via Frontend
 Transport; Mon, 27 Feb 2023 11:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 11:52:08 +0000
Received: from [10.254.241.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 05:52:05 -0600
Message-ID: <5c187097-16ee-c7e1-cc1d-14665c174d82@amd.com>
Date:   Mon, 27 Feb 2023 12:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/27] mailbox: zynqmp-ipi: remove MODULE_LICENSE in
 non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, <mcgrof@kernel.org>
CC:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-13-nick.alcock@oracle.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230224150811.80316-13-nick.alcock@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 86171a9d-1ed4-4266-ef13-08db18b90db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9A4B/TeFCjqViIsypP5EgKPkMk6/zoUYs7hFpitGMGwAz0Re2KEkq+ICyAI+3Hcczj1attaKs/xeaPhztsoZr8In7Wsy67fFQDo0jmOiVRFRcC38RUCYTuuOKkGWW4pBk2EOFgS5M/k7DfpL4TgbIV2g2QxTBsBS4V8ZmFGJEjxtV77R0mVDfJZu9JBpH0VqiJXItenttc+23R7lRxcfY6CYzygHdbXDUcONDWWvE72DtKMkUap6y5UmZArxXk2tfdXW0bR/lpUFopQIhu1XiAHgJii0JAUN/iW+BaqPjAJMicEoQQsXs5NFZHpnsAxRWlZQwLTXmR6xQ3euEM26gns+MiZa4Oq1qtVJG4ln66Gz2bTj9R1Ha4GzJpWRRhblIRVSQE6KDPbT1VInQ47IpSOOTSwF35Eg1b+6ljZKjOXmk1KGxRRBIAWEtxsO8kVLyG0YFPJuGWJ1e9ppG9onjJUkDsNt2ni00/THTFSc4JA3dZefXL4RTw9xBsyK9OZOTI0329BC8R8Qp96OEwGXZm0p41FqThMlSS6os5Gry5sA9tCbmaTCCjwxVIMXZusokD+CdWtbPYHHKX8qLmG6XslZr8m0Ee1MMWD1noCAfhHJyDY/u2friQmYn0VT+cOIdzoVtx55aHpQFvawf0W66D2J0alrhDIKTBqbF0g/K0Sz/505EPsOioOszvC3RPO/RAr0+Llm+gVgS1ivaQr+Ei0YmkVLlLq26hb91g60cVulvijOpU9CdAD0/jYMke7HLy/8l21KEADf2cDMZLQn9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(26005)(186003)(16526019)(53546011)(6666004)(82310400005)(36860700001)(426003)(47076005)(40460700003)(83380400001)(356005)(86362001)(40480700001)(82740400003)(36756003)(81166007)(31696002)(2616005)(336012)(41300700001)(70206006)(70586007)(4326008)(8676002)(15650500001)(44832011)(2906002)(8936002)(31686004)(5660300002)(478600001)(16576012)(110136005)(316002)(54906003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 11:52:08.0384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86171a9d-1ed4-4266-ef13-08db18b90db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 16:07, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 12e004ff1a14..c4619d31477e 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -718,6 +718,5 @@ static void __exit zynqmp_ipi_exit(void)
>   }
>   module_exit(zynqmp_ipi_exit);
> 
> -MODULE_LICENSE("GPL v2");
>   MODULE_DESCRIPTION("Xilinx ZynqMP IPI Mailbox driver");
>   MODULE_AUTHOR("Xilinx Inc.");
> --
> 2.39.1.268.g9de2f9a303
> 

It is the same case as 24/27. Prefer to change Kconfig from bool to tristate.

Thanks,
Michal
