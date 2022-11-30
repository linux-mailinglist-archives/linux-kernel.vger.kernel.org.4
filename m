Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490963DB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiK3RJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiK3RJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:09:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0B91C3C;
        Wed, 30 Nov 2022 09:04:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFKoiJFPBSgQ2y+tMQXCNyjnjbf0vYK+AhkweABct47IVsGHmfwLGw4Vb4FVQBYcz/bos0tUBdXP4h+XiehQUjyOKlnH93ZvB5q4wbUuiQMzfldNj8zbG14wYzuz+Yo9XBoyMzwo09s8TJkn5pk6ix4uWwQqmw5uKyuMXhLiZ1ltRluZ3kmkUZ3INB60K+XLyOStQG56BxKZiNLhghxMBLy+vCNwZ9Vv/lZUhDDJWieRmmavItkels50+7e/PwwT6Juj+bPNoMmsGRyjPhfsCX8zbmlKKMSyJv5RoZlaN+6iabK+2AxMV+o93EeLXpr0Hdg5r/A/Nm34AAG1N3YMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfKEPPrC9RCLpmJboXWBhFiiU82Q1RUlCJm5oQQT/yk=;
 b=btzE2OieRbciItOKizNgsMKa93467DcdJ1UL0aCyNn/WVFCVw9YZBA4NSqgwnZO1a4Vx0jEJOHFPx5LEQGHyhhNTcbhdSB1bECJpGzOPFt8sbqvQelVRoG8XIq9xzZl/ghE/iCUkvvp2yewUaHBWobWcuPfUAaWV+FGfr5J8ZCmSIZ4nX6j70x2DMQ6RR5QT1b5Nolz71XG06zWwAct5qaMt3BlYg2BQ4AgMF2mON2JplPU5dc1/eCgiToTCutMFeeAvOWP8By53YCJjSySwnUvvL977aGqp97IFkNmgsx4N1B8E1ubhS4lBgWh1dXXwDyECCNKYZP8iCFIRcZY06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfKEPPrC9RCLpmJboXWBhFiiU82Q1RUlCJm5oQQT/yk=;
 b=gv8f7YqnwSdBTMuM+Wsg5FSIqptxzOV9JrfVd0VpsqWAgFOjP8JjGRlEag3OzjK0Ud2hk5eq4WE5sR43GxDTTDsM1dgMU//YjLD0NryPDVC+EwCZnSiUdCKhA3ktavHf0Kq9qx5HQSHimOj6hplsT/qzWszkh4b5j/OzpATZ56g=
Received: from BN0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:e4::28)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 17:04:35 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::32) by BN0PR02CA0023.outlook.office365.com
 (2603:10b6:408:e4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 17:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 17:04:34 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 11:04:29 -0600
Message-ID: <7127c7f4-89b3-31f8-cabc-43f955eded64@amd.com>
Date:   Wed, 30 Nov 2022 18:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] iio: adc: xilinx-ams: fix devm_krealloc() return value
 check
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Manish Narani <manish.narani@xilinx.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20221125113112.219290-1-marpagan@redhat.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221125113112.219290-1-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: e97eecab-8258-4d42-0f03-08dad2f4f4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAl2/XiZX6VE9fbtmSBgVpLe/aZ6G25uLiASXiseEPw4BXdwofe/IC7UhSHUaXQDOAdm1UZr72dm+NvcOJfjYVVnf44bXc8SRFQqiPDh4KMSFPIP1ipaw9l9sRFokoDxFHyUo2H9vz8RINoQ3Zk271Lv3Y2ABB5YVIJi+yPPsJJlPV1Tx5y22/lc1R208Lh9e0WhrzPbsBCZXYUNyY/zOVM+Zc6CWLxcqQ+qUlw9DAooFx4z5QwEE3M99VOQyXjR8Nr0L8B+fNzy75IU+qoZ7QqcYOG+J6/QcQ7zcyJdnzw4PqMBnSPzUttyilPszcPJVLBOsdVhN9Xvtp5ifG+uJQicRJ5zilq5V0oE69kOMOl93X1O5wQeGTEp/KYCgWChZk35zunJCqkVaPK5kIK/cH9++foDopQqYZZv4rVXpVBOrc5e7XMghGxV/Hr2YuMiqfsV0fXfapikoca1zNQfnRYI6vGbJTTlo7XlNoY83fahwVwVbCmFyk3b4Qe4BlKHMDvE5fTEQHo87WJFRVcyVnSbEULDaNGSnvoJaBvsfZBMadSz7UFvZd3ZI4IwOJuDDZTqzKGwRzb58N8dLaQaMVFIYoj3gu+iOatdMdcXQIWDNDEe48T4RifgxSN4z1TpY4X9unmJgbUBc+I6otqIcg90a03+2kB0iaaf+I8FQxc0TXl4DfgHnwDmXY3elMjvgZufTZXm8UYmzyGMF3SsjYwgZ3PNkHVevcRxMh3H7SmP8eoieFeX+jCFfTeIQKrurV//cwCnLMDyXIldd5NUZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(41300700001)(8936002)(70206006)(53546011)(336012)(2616005)(16526019)(6666004)(478600001)(4326008)(316002)(8676002)(26005)(40460700003)(70586007)(31696002)(356005)(81166007)(86362001)(40480700001)(31686004)(7416002)(2906002)(186003)(5660300002)(426003)(47076005)(44832011)(16576012)(36860700001)(110136005)(54906003)(83380400001)(82740400003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 17:04:34.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97eecab-8258-4d42-0f03-08dad2f4f4ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/22 12:31, Marco Pagani wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> The clang-analyzer reported a warning: "Value stored to 'ret'
> is never read".
> 
> Fix the return value check if devm_krealloc() fails to resize
> ams_channels.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>   drivers/iio/adc/xilinx-ams.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 5b4bdf3a26bb..a507d2e17079 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1329,7 +1329,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
> 
>          dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
>          if (!dev_channels)
> -               ret = -ENOMEM;
> +               return -ENOMEM;
> 
>          indio_dev->channels = dev_channels;
>          indio_dev->num_channels = num_channels;
> --
> 2.38.1
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
