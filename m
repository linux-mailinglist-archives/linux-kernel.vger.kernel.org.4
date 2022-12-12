Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3564A878
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiLLUMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiLLUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:11:58 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CE178B6;
        Mon, 12 Dec 2022 12:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTtEbSaZZDslhoJPaaY61vj05pdYgJ+/iHCfD9mahHshsXIJpA4p8tPMz0Uy50fYkytFqiCAw1h4JlcwzSlo2eHQY8RHnwVTDc56VwcSUsE4TnB/nZrRKiVdkAkh8d70qyhVklebqU8SuVa1rbh75K7eovhc9FzZX7bk+nzj2SAzgjBJuT3OBHkj5w+NynTxuLdE4zNhVT/IydRPHMOor+Se88CtJED+RDx/vi0jV1UrodvtazTVvofGBjjcvilSVVNcAFohLwDCJP2KPBT4Ml4Zii/0jQ7cgKZgEI0GnFVjqcKy3aBUUAi2PJINNsla1YfCvk9cNiO9UKsBDlXFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn9qpvul2wvZ/Nc65svFN+xeMO54sGppvDw61LWt5oo=;
 b=Fv1kMWGIB/iYqP8tM3CB4ucpzxxRdTKEFDrb4LIl7PxIo/DxVM6bavqi3rA4bo6o7VAO6QKgnpOmMQNpY3afrL1kpfswVoqPduMtkqhYMU5cTljTb1roeP17M9lLXTH63yhWlVbyiDAIgFcmvf7McRi1QuBxc6LZ8ewB+xW8ZWtKN5TH+VKcZN+AXFEGWYKlrxHs+Fmn1K5tQqnwvvQ/J9QusVNr58XlceNgiIuDu++/8hSk0T/0oLKAFhdlpcnsIXWJ1cEKehb7iw/3sebYGK/aI1CdZZdyGigjx70npWhH5JhpFhMHSn482b+LPk0upLEDNvXXTh2AH+dByaLSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn9qpvul2wvZ/Nc65svFN+xeMO54sGppvDw61LWt5oo=;
 b=ZvszgPo9iHvLe/nWR/EWV/xhLxWVZfD4bQlizT0S0KyvQPj66DaezkpcBMoQTeRDcaZfKZa6Sb73Em79/bSfVV+cBH73QgtVrIbO7vTPN4SqFgws8IopJqU2Vd0BYoa2aUoMPFXHG3sz9vdY3Pa/r8eY35FoOzMA82crre3C6szB+O6jwT8B0O1rRXa4UO4sqefIPTcsm/CvriYoZF6OUdcay1q9f3AVY+rGTncPs/uNpoAEBYFbwPs+URsdO5AZQpEhVDO/9E1aOYTZubWwwgHHk6vpPYxkMGucrIbeI6KqLIzo8sIUo2/bvZSmMs2caj6a+/lHWZe+lNcWWANQjw==
Received: from BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:11:54 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::1d) by BN9PR03CA0768.outlook.office365.com
 (2603:10b6:408:13a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 20:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 20:11:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 12:11:42 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 12 Dec 2022 12:11:42 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.4 00/67] 5.4.227-rc1 review
In-Reply-To: <20221212130917.599345531@linuxfoundation.org>
References: <20221212130917.599345531@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <baaad74a-b971-4085-9033-c0ccaa9f80a1@rnnvmail204.nvidia.com>
Date:   Mon, 12 Dec 2022 12:11:42 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 689473fd-9b71-4daf-4706-08dadc7d1cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjVSYQPmDN+mP5PPVC1HRDzN2vHCmul/Iv8+TLvogsmSKBbnEDuPtiefCmuw2vFjQQwhMQoirtw1B7QYqPM3tiabsE/PQngn/kSEn/9j+hkZpsJVq1ITiXd3ZV3n0FUsArF78JgkSI00zFqHD2IUAj7BK4XPDGR3rLuxIzgSSZeX9LYPzF2Ly+uXUHrNgVE1Iz8CUvYn4o5rPccfJiSseNws9hY0ifgG4Y7cf6JjzAUMkUZNLQgnvIG+U8atp0sdx+se4xLsRA2SaqSdh2Km4accl4GaSC1brkAYx4E67pp3ESvrMKlA8f06WtC2nCW1ehdJUV0vIVpEWLsxeHa1pQpQGFN+fvfvUwTgYOBUq8ajkp2GyZqG0SM2Bhbfy3djsP08G8OReTNw2J+p+B5f46/QUpOEIzSGwB7ltzCY0OiiKuMuhwtId/5oXvLtWJ9DK7jtvm612G396UCAvjC/yH7VJEVpww4epcLmO6XBr290zppncQSDpM2uw4ovpvf+AwYbyRRKpi5gMxJHeWodYiEmrhhnTj1DHAyopBgxAIPd+FABfES/lAuiTlq4jdg5FAD6i1/M2axMlbxLTytAal3qmczhdufs5t8OB62kwebluTuByBnfmu615SsMqVP/dAGRlzdbf8Q5GXy9u76xCorkjrX0p9wyng952u9D7j/vMjGpim1d9tjXRJPYImBMRKJixxEDcvYhHs6P0s3PCBtdXhT7+IV29NVz2TD4BWJvKSCtoiAMvJNbzbXcRrqKNfwUpon6GgARt1TbOp5ZjgqllLL8chEheemcbL1QUfQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(478600001)(336012)(40480700001)(47076005)(426003)(966005)(26005)(82310400005)(31696002)(86362001)(36860700001)(40460700003)(82740400003)(356005)(7636003)(5660300002)(186003)(31686004)(2906002)(7416002)(316002)(54906003)(6916009)(4326008)(8936002)(70206006)(70586007)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:11:53.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689473fd-9b71-4daf-4706-08dadc7d1cd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 14:16:35 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.227 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.227-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.227-rc1-g8c05f5e0777d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
