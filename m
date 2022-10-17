Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1C7601000
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJQNNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJQNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:13:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B606327;
        Mon, 17 Oct 2022 06:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmXuP+Bk8rUzW1ultyI2QW/Rk555xYMWGUdDboZCJO+X7sQBI0ZaTzBSyNYPG2RfruJSpKfUScUeiY5cwdZUpVtRuuXiLfR3EcjRIN1SkLi7suPKe5PB27r0vfQA1hLLrhYnC8fmCggNn1yD/AB8lMkv5GJXPunXlccRspLx7sW5Qg/BN0i1318iH3SOOt2PVZbYfWrcFz/7yhj/ui0HiHyytwU0xfhnlEJeAjKjDkwEgGvTjXazhSd1uOYz4mo/xQVy3wZnCea5brza3W1CzU3nTpLTWGYTxDSWuZ8EP0OAAh+F/bSWOoyUYrLph0YdOzkdXYZ45dMnRHMDr9M0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL2zTFeT5JHDr7GeBn7nB5+SrrsZlB1pSS2egfjo2Qg=;
 b=NFK/nbvrt3ZSWUMbUL/RtnICgrFM02ddw/agRSMFpn+QzRaU5ljVOlQtRjtiG3ya2Tvx4Q8EdLxbJVLvR70QGoAPO9fMz6IxM69cGh2SGNy/OB1t10Nl60xhgjim0AV8ZQzt8xMrfnB8InPRiRr6YPqE1R7dWZZA7JIu8F+Wceyint3DHTTgkoGmWQQXUDWN3VdsllZR+NSyoQXab2BH/agnksi+BFUwjgzXafSyalV7hSYFgxRTJUsfJgBqssN9ur4yWH6BlqOubkuevTrLOF3+Dp/KtgX9SxK6ErJEN52tvFevi5rPWFHiZPjQYVd11KmUhBEYDWz21Z5dMK4U9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL2zTFeT5JHDr7GeBn7nB5+SrrsZlB1pSS2egfjo2Qg=;
 b=c9uJB4a1R0dEuW8IGqsxKqGWoFUVjD4v2rhcEzWTwqnY8A5NBwCI4S6x5VjRr+afe8uMKXHZGJEgWdbc8CnQLvaKUSVPHLyqfNZWcSagKXKHQti4HM53xtixNTBZgWheLvEd1eZ43vZCVowT0WRkDK9CAW9AfP0ar/BdR/w1bUE=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 13:13:26 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::7) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 13:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 13:13:26 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 08:13:13 -0500
Message-ID: <47d78f57-c4ac-0d34-a605-a522a3d7c17f@amd.com>
Date:   Mon, 17 Oct 2022 15:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/2] pinctrl: pinctrl-zynqmp: Revert output-enable and
 bias-high-impedance support
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>
References: <20221017130303.21746-1-sai.krishna.potthuri@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221017130303.21746-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bc03ab-d5bd-4312-7ec2-08dab0416055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1HjESe7H+QtC6YOypjXYK+o6ut2n6zOb1S0AaoQXC7HwyzvMstIOa/BoIj13Q5L3/HGz6GLEhyTQDB3+yNrTuvNAVFGBza3d1Flti1P9GSG5ek66fSEAPYb2IuucoOatyqbRnKuMY2s+m74amU/sjwvkUlD2unf/nH6OEariwOF2ZfLWTDOI5U8M1OnrF4mp+FYSV3+fVQAmFUJAf32SL+W9lkiVvnkdUxYc6e8j2M3i+m2ia2bECloEaXteN/7GVb+2pCAJ+Hfs2xjtGUEqB3pzQ+wgc6J9+Kd1EGy8Ew6HVBYOF2cr+SnmNGVcD1x+RLLibJwjl0JoKiHWivPgj4BdiNO7DnX4TSCV2IJhpfD6q3mHtx2+zMdpm2lF3MrKsRaJ5FA+oon1NJ4LvlC7/6bNDDiy3G2TP6EaUP37Vvn5VVNF/dwUhueKCCwuLsyJag9jB1SNCiwyls21vPRIxWVfJD3BekRBHRaoZ7s22L7h55tPW68weXaawBJKb7JfavoCjpPrGJCSmvP3dknCTNCWQF7oNmRNSowDyeFpMQEnamL2bPAMXU8TOCuxboe4QKHOKBOvzJ0SCPdozHq7pCKC66v4ddyKTBhW/Fda5SKkizznTcsDNEmPbp/TzTM4BE1cMydMNSkEXy4JYDku5w/V+9eKteIjwaDs+1V3cDRajJG24wkFy0a6RmeTBcI3hKfeWAmgv7MB+CEw+t69jkJHFV8ag0cD4FPsgUVprx4hLEA1d0ozv3tdJHFWEWiS3eyBB2UzF2BfWczaoLZ4zwTRJRH2Fc0tmgq2D0/D5k+GGx1lOhul6WH0MuMX3vnW93z2QQSHiklIsjv0+PJyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(31686004)(83380400001)(16526019)(186003)(336012)(2616005)(2906002)(6666004)(40460700003)(26005)(8676002)(41300700001)(53546011)(4326008)(82740400003)(47076005)(426003)(40480700001)(86362001)(31696002)(81166007)(82310400005)(356005)(16576012)(316002)(54906003)(44832011)(36756003)(8936002)(5660300002)(36860700001)(4744005)(110136005)(70586007)(70206006)(478600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 13:13:26.0206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bc03ab-d5bd-4312-7ec2-08dab0416055
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/22 15:03, Sai Krishna Potthuri wrote:
> Having support for output-enable and bias-high-impedance properties
> causing system hang with older Xilinx ZynqMP Platform Management Firmware
> because there is missing autodetection feature.
> When this feature is implemented, support for these two properties should
> bring back.
> 
> changes in v2:
> -> Added stable tree tag in 1/2 and 2/2 patches.
> 
> Sai Krishna Potthuri (2):
>    Revert "pinctrl: pinctrl-zynqmp: Add support for output-enable and
>      bias-high-impedance"
>    Revert "dt-bindings: pinctrl-zynqmp: Add output-enable configuration"
> 
>   .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml | 4 ----
>   drivers/pinctrl/pinctrl-zynqmp.c                         | 9 ---------
>   2 files changed, 13 deletions(-)
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
