Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3735E9892
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIZFA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiIZFAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:00:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9236F27CFE;
        Sun, 25 Sep 2022 22:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwUr+K31d76oNcXuzNaeFOBBUIlcYKdF4B6JMIQRbyjMPx/tLJKofR6LgogRvg1bCyyFO+QzBES6en6e+cXhPAtxraozbR5To1L+/ps7yI8M8cZkUPi6/zvitcitgVDAn8jSVd1PoY7ZY2BELf9caxDC7w1QIJDSYACBPrRw3Mi2YvKKsNJFzd9aYsRF+xvWQsJ3P/SmFAnRMX7Kw5x3kzWYX3QJI2Ji3+S+a9tFaaFO5lkhPJkTimJvhRC/9i0Uwo4lukEngIhZCyMJM+WMjd31UovhNDG159Pz21+Re7a2bO2GmcPHGIT1zGyaEwUAWdsda9riQ2F5BxkyfsEekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z7OR6DtFc9ztZdIkZayBm2ASf7AoPXv0ifL0EpUt1M=;
 b=Zu2OUZXaS70C7a/sYWV6meQb5u0r9c9V14OyiXhI/u4wxIXv24KA0z5qGIrm5hMPAs/NasPrF0POwlrSQmSNeMtlasti2hXvzEevHzSOAvax0Tpe2B7Gev/bKIxPI7r6fQzQ70c/A23qkhHGS6XI2K7s5mSssdaGOjjNEVwIAtNwocPiHJRulRFnjzPfUbOtmGyqfCO0XPImIxbg6l++mqL0yaWwlH3S3w1/NhSakYK1SmdMXnbOe2mTtGdvbHYxbgdMnCHHP1EhKj2b3cUIUqw7RWL9Mibpex9B9QjyYM3TPcLExFCsO9uJz6GB5Vlf3VKQAKsvCZdEYbJhvQjhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z7OR6DtFc9ztZdIkZayBm2ASf7AoPXv0ifL0EpUt1M=;
 b=BrXPiGrKnpBDrTUYjVEjXIkTZaJ7nirFdPK6B3wu84Zd8/9o9AW48/7k3XVr4u92ksKEE6oLci5iQ5g8falBfMhEvFpP398iuYI28xysa5Dy/BbARwCIazmReAW2jcHuAms/1is4t/NllNl0Bmi8LC3QUrB6wSQEABsRizwDMzthdEdhHTDV3gdEcsod3LycjxC3yUab9iw1QWQBM983dPslToC+z9JVY6KoCuyRNtcas5gRMpbqDMj463/4AbQ+7xYRSYD/8zuyepGsB3sWRIMUMwcMw4O+/NhQHaaG4MkgU24+SG12CnbJ5Ifn6z98JJZYUf42LZTU0vhA5dRrYA==
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 05:00:21 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::99) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 05:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 05:00:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 25 Sep
 2022 22:00:08 -0700
Received: from [10.19.101.103] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 25 Sep
 2022 22:00:06 -0700
Message-ID: <be78f14b-3b76-84be-c374-d5b7b7794402@nvidia.com>
Date:   Mon, 26 Sep 2022 13:00:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] phy: tegra: xusb: Enable usb role switch attribute
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <p.zabel@pengutronix.de>, <jckuo@nvidia.com>, <kishon@ti.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wayne Chang <waynec@nvidia.com>
References: <20220921112500.798282-1-haotienh@nvidia.com>
 <Yy6u+9x/oDo4Gd+F@matsya>
From:   Haotien Hsu <haotienh@nvidia.com>
In-Reply-To: <Yy6u+9x/oDo4Gd+F@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4f5250-8386-42bc-2f97-08da9f7c03bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xSz8ybzzZazGIOBi/jf+DdD8ctzVWjVsYJMfZ9qdcw3NYOfRH8/h4WIZ4+LCL9PnoCCDnTMS/IejTust2O8r8uMUi3m2v6QpMd21QXTYbLQ1xCoFmL77FrMH8KFGQ0YwV23PC3ZKMOwCHNmfcsz10Za0f8nEzqXVaWFn8EvE2oqPaVL8hzqS8nmZWMF4LjTIzsfEUyRRGpN4QnDPXiTN3m15wrZ8gZb2oeqhJC4V7fd+a/8GXUATfQkShor1177vd/hWR4shQ47UVfoxWkhYcrN91Te1c1DbMY+LS5IU8apgrDAWPL8gWOrzJaE0sbblNVsPeDp7NkrxV0U6MS0Tmj85f15K1GXriG5oUNyzzNhJPMHPelPlP3pcNXr36uHzegvUVLgoJM84Z2PqP/Kmsd/QtS5aHQBuCrZFRmNIl45Ky/BVsyxu67+c7sKajdq9LefXJnxzvulk6IG+o1dZyyi0N76/qnyQEgmhPl8l2Nd4jLIovfEHeWIAGmdYYXrXZzOc9rUzmPd1DIL8cN16aOuPfRqVFZyN5n06TxB0vhaOkGKP2/DevfTbeI2YsEZhBldCNjCrS8XlVcGIyJptjKBUADmksN4lOJjMmvB2K2E/5ft6z7HdrJgDtOkai9dRSBkP1F983lbAyOkAi8gebw3RxgcO4j6s3EfjdlddO+b6Y/Ju4VqtfFBOB1DY8/eK2bTA2h9qnygWFZVSP2m4WiFnsr8T69iOTKUXJp0jDALLKEAPDh87zNLQG1CLBzzPx0wKIbz3+h/qKmGNVtZU+z7kekq9Cg9ZRvjqEjF+xAAcuK6dIUa65zhk5UAaajAfT2zDp0iTlzb7J35tHlb6GeL7cfXh/ELpLQXeSP68vg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(31686004)(316002)(31696002)(53546011)(26005)(70586007)(70206006)(16576012)(86362001)(6916009)(54906003)(8936002)(4326008)(107886003)(2906002)(16526019)(186003)(336012)(426003)(2616005)(47076005)(83380400001)(478600001)(82310400005)(36860700001)(7636003)(82740400003)(40480700001)(5660300002)(8676002)(41300700001)(356005)(40460700003)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 05:00:21.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4f5250-8386-42bc-2f97-08da9f7c03bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/22 15:17, Vinod Koul wrote:
> On 21-09-22, 19:25, Haotien Hsu wrote:
>> From: Wayne Chang <waynec@nvidia.com>
>>
>> This patch enables the usb-role-switch atrribute
>> to have the user-space check current device role
>> of otg cability ports
> 
> typo cability
> 
> 
> You can use 72 chars for changelog rather than limiting at 50chars :-(
>
Sorry for the typo and bad format.
I will resend this patch.
>>
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>
>> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
>> ---
>>   drivers/phy/tegra/xusb.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index aa5237eacd29..220ab7719ade 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -656,6 +656,7 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>>   	struct usb_role_switch_desc role_sx_desc = {
>>   		.fwnode = dev_fwnode(&port->dev),
>>   		.set = tegra_xusb_role_sw_set,
>> +		.allow_userspace_control = true,
>>   	};
>>   	int err = 0;
>>   
>> -- 
>> 2.25.1
> 
