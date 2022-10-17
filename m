Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001CB600F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJQM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJQM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:26:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7092098F;
        Mon, 17 Oct 2022 05:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d17zNReKFSEC0DR02/Caf3VeLq8dwKgkAmwUpyK1VbXhjr5X5IGLSD3sYxgPNdtoE6hjUE7V93uszgQc+g3WCDUAiYgjJ6P5wb+6pRDq8v4XIXqBVxvxpplYXFhetuJ3YBQkmIUBK0Vr1NPMFa1CYDGN6ENqirbH6BOnEBPBUDzK56SF5lyRLJ4sCZblh4ipVUtrEczWhiGRty6/tk4q5Jzru2SMUFhwgrxXn4PlR8japbHA4gIjMd4ZLjVLhX5fSNEZlhpZ0oBAuDknCftzNBRGXF+pIFFRR2zw2B/lJ+/X0EM45gTdG8NvJEJ+giuGR1kIHsbYJ0qLkLQq6qWFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWDOr67QRC6pLz/lQMMJVLDg67CjlVLohWNTWtaNBCs=;
 b=GE3zqjAQatQ0pfjqy2Dk8SsTkeVWGCkBIMaSvc6ZZUJhBdY2DXXf/NgtG4wBCe/hBB6KsJ+gnwm8tZeyDakgOoaHajeg1iYAKSylcQE3GaoBd6e9qboqDRYOFM9zNp3i2rSyv7YxhtruDSrtL0lAWxA0s1EEv8VesRau1R2RcQJalXsXFPbQU0ALsdhnaGDlRDJig2HDqPMyVpktGUNmZzVTBXrolmy1Y+HKFiEcjaWnmXpaXoC/LWUQJ/SNY/1AYHQ47qLwq2tDtVj6ajX2RAPatRS+5iuB1+ifbY5fUbHV7HRPmZZQgonRXaZlnonSIsqEYop1dBa6OGhAEWIP5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWDOr67QRC6pLz/lQMMJVLDg67CjlVLohWNTWtaNBCs=;
 b=l7MRxfhO0pcsTnws21wlHB46Gmccb/QOx7aEpRXQtDo4UurLcWmANGS5T31G8qx4yI8tm/CcUuZvFKhFyR6+I0v30ckyK3yZZSGTsOntDoKeaPepfGDWPbD53uA3fcG9/3kb2dxtgom8MtO85ux3t/XNBl44KaA8ErOjeRJ66vw=
Received: from MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::14)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 12:26:40 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::2d) by MW4P223CA0009.outlook.office365.com
 (2603:10b6:303:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 12:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 12:26:40 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 07:26:32 -0500
Message-ID: <1f4770bb-ed99-230d-1f4f-44210bd36280@amd.com>
Date:   Mon, 17 Oct 2022 14:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] pinctrl: pinctrl-zynqmp: Revert output-enable and
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
References: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221017120100.21549-1-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|BL1PR12MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d9808e-12de-4d11-5648-08dab03ad7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psk/gt8pNXrbF/XZn/SeezKBGVVCc55bpfN7t6Uj1MF9nKzNNh5CMAx/uueC8KH67BXa/I60G30cfVjBk8RRm+jUbiIo9wvcxH5IxwfYy1k0mXwxCX7+7VlCRbed5zrXSUDV66F4mwKyZl2FzYqIyy7NqYjs/Y7jAtD4sGl3er6uEWeQDtkPGeOuG2tvpHZPuHf0/FLblydqB9JfRNMMvOfoNtl/MVc1A2cSzEqnKkmdfW740sOpM2j6UOQexJVwToOLjA60LBL4Jx9AIgRI3CMGnMV1DR+GZanAab7zouXoHwCAMiHhG4hCAET1p+jX/SUtVkIVczXlJYfWiOAIAaA2FoGpYTk/O/cZlSd1HSCN3dNstxkVpF3w78P9BGnKeMcsQscVHt6+GqeQ/QcGrO7d83cali4Yywrh4PUT3cO2Aeq6X9NAZijPVNGlhbOXIrehwN02rSuV7NFIjXFKsKpynJyT0ZCcUdKgiUHfenazhpr+PPqjXFuokc3i2BwGvOMuBJcmGU8zzDuiKGMgCXHA+G00WT21X0nIEHlBs2PYvuB0NBVjqP99z99IwGeQd4UKzH57wKVeNqNnyAe2wWCQILO+2N4kzfwX3q9tzg8XLTx0/kp8YC/1oWJbx/GcbhDti5tV7G4gcc7rfVMSvHfPJSGry88tCgmL2bRBoSJ2SSPPWeY8kOD5lFx86n2GK4MGRiKqQfTlihnEgNFizQsw3d6NbaSDtxnhulyNVY78Fsm/QHqm470ckUoP/aX5auQK+ZcWu7cf8C6VqQkF7Up+upuW061+uCKMN0uocZ9lHqqimHeyd6XeRPKLDAUcsDxqJi1+LgNf7fHgSrdyrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2616005)(336012)(426003)(16526019)(47076005)(186003)(83380400001)(356005)(81166007)(31696002)(86362001)(36860700001)(82740400003)(5660300002)(4744005)(2906002)(44832011)(41300700001)(4326008)(82310400005)(8936002)(40480700001)(8676002)(40460700003)(6666004)(478600001)(53546011)(26005)(316002)(16576012)(70206006)(70586007)(54906003)(110136005)(36756003)(31686004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 12:26:40.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d9808e-12de-4d11-5648-08dab03ad7eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/22 14:00, Sai Krishna Potthuri wrote:
> Having support for output-enable and bias-high-impedance properties
> causing system hang with older Xilinx ZynqMP Platform Management Firmware
> because there is missing autodetection feature.
> When this feature is implemented, support for these two properties should
> bring back.
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

You should CC stable to get it to stable kernels too.

Thanks,
Michal
