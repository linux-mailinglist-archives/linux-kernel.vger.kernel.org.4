Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9D69E229
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjBUOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjBUOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:20:20 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2218.outbound.protection.outlook.com [52.100.173.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181891E5C4;
        Tue, 21 Feb 2023 06:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+ClPzZco5sOJTn79bIQEYY+FhQeE/6+e+KgnaibthwUANGXMl7irwy4WQQ2Jdy550sD/QpLN0pLeQ/F+KavRkx9DIkphrussptGVrqEt/xAGUk0Nyqv/1Ud41/xR3nPpV10SqzmrGFkYT/e7e8VgZMuTxxL+5+8PR47DurEdOCtZzzILQQmuBkBNz3FOz9KpHyYoK8RetEMeur4icYUo1nnRujm9urEJ8CFU4umcBsCSMA3+hWEvOBon2go6DOOfXnM8X8mHsex2YobbZf+rqynGmqCrBYny6MUSMxaYT8YHArnjO8bUiI9xK5OZT54ApjV9sxaly4ZNB1NY7tIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99Hdf3qpUCf07tU+iMDuIgN7/BrsU1D5fxpR5sgtvW8=;
 b=RiMbHEAzaB0gY43PWSS2yS9udR4Kv66xRYhSkRAX7L0ixsVh1DtisubHBeUdw9fNQItM8ylgVruxO/PsSFLhzWdQfTm9IKSB9kAT6LUeq4DeFLDBl3nW/rMj2poPdhUOEkrh3GnefeOLYRmfCPoAIdRxzQYiTbLEkdyO+JWJQ8B5M5sKG2EWc4tXAXJthVb4Ecldciegj0Sgh2/nK0qJx4yfvsQdF4mQ9fXPkO2ibnZKNv9aSAQrhBWp9z2NPZAOhmDjUpNX93N4/u8X5YWW6htjpUDPVcz6pU7tcrgfhEpwJfYb5JpDp28xBTe+h4KbyCqpZdCdBSymul0S0nX9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99Hdf3qpUCf07tU+iMDuIgN7/BrsU1D5fxpR5sgtvW8=;
 b=Rjl8lXhhNP5kFITTFRaMqH7486fhBHfUldEWigcWfZ0/tiQKTdJCHu64Q7R06CKEVPJpAVsL1QZtQY3j/nlLa/jc0lRZ8AywhAsuTSaNfXNtHLi5d0a7VpJZVIKZgBJ6mzucrAXKh2zyDd8hFAtQeIgJKXUcOPwJVKOx63nBumCPzkrdXKam1MsDKSTyYn2iM4KX7I/QGbyeBal9i/tabi4uoLTkld/9aM2w1W0prNTBwyusHWQCrgvdJGfDqOm0DGb2b7MYAl7A5/Kun42jGW88X06OB5Q/FemLmY1BcXTsFnVPIqJwEd9/A4c1DTAgNIScWlrEy2SmyS2Q3nZWXg==
Received: from BN9PR03CA0628.namprd03.prod.outlook.com (2603:10b6:408:106::33)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Tue, 21 Feb 2023 14:20:17 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::b8) by BN9PR03CA0628.outlook.office365.com
 (2603:10b6:408:106::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Tue, 21 Feb 2023 14:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.20 via Frontend Transport; Tue, 21 Feb 2023 14:20:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 21 Feb
 2023 06:20:04 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 21 Feb 2023 06:20:03 -0800
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
Subject: Re: [PATCH 5.4 000/156] 5.4.232-rc1 review
In-Reply-To: <20230220133602.515342638@linuxfoundation.org>
References: <20230220133602.515342638@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <116c468a-5b1f-4596-bc1c-83abb3e16a61@rnnvmail205.nvidia.com>
Date:   Tue, 21 Feb 2023 06:20:03 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d97f0a-8176-4a7f-56db-08db1416c143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vP0LQY3W8wtzu/vqvpnHMQhyfhTjUYi2cllHX4Tz9L58JukF2wJ2xHiErr8usKA0NXFYVkGSibG3fcJe2rPotDXZemq29HyB06A680ga4Jynu6n59fwgxHIlKII6TLdSWCtvtEA9qNo2NVLdiHIVW2vOHkke0qYMmBUE5EhNj7cAdkEV6DqV0AXrkQM65cRS21FEAVYTY7TFGXa97268U1vGRhYDdMCb1kKaGPrOnnUtzqKJZ2ja4+nwuxG5LbkFV4zhZbEi8AM2SRj1Pf8ZVRztJNdysalOZDLxYWyfVEZun+0SuRsA+zSTqk0Bx3ayQVJT0kBJUpUhZ4uQCIlMYIgrw47esOcwW1vevyUgB6+l5YZvtLpbH6Blb2/9I5EWkXvborOKfDch+REUNe4OqoL/E4vXJ9h1ukBNBIiYzuLCiXcX6FLyWWMJBp9IwyuqHBpT5QDKxOrpSYkFtaMLJR01VbRFagLgoAllLf1n3FyZktpjaRst/UIvw5bIJ7QrE0yQVaSc8nmIp4wHR52WR9pUn2mE+ta7nBGVRvbuxLFB6ejPS8Bag+UBruv/QqTPhTskLt4994BFeeK2JyyLE6G3ucDIPpA9K0PHR6q+lVXGZJvZLw8+6pKpQ2wI53YLh0pXgUW02KYSRs+wGrSIjHp5uW1yXpypmGIGm3HH6olxpNCqeIPUdj8kynUoTvO/x1MKjre8dD/qfiO+JBAES/V1uXlmzPAmd8QBkH2CWn4w77Vza77xOeqwE525lSyEmrFL0I5/b25KYs6uiBMD7jG/47eNUD9ZlnK/6HukR9N5cvfrxAlEvSpfLClZR4UJ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(5400799012)(451199018)(36840700001)(46966006)(40470700004)(316002)(40480700001)(186003)(966005)(31686004)(26005)(356005)(47076005)(478600001)(426003)(336012)(54906003)(86362001)(7416002)(31696002)(40460700003)(6916009)(4326008)(70206006)(70586007)(8676002)(8936002)(41300700001)(82310400005)(82740400003)(5660300002)(34070700002)(36860700001)(2906002)(7636003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:20:16.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d97f0a-8176-4a7f-56db-08db1416c143
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 14:34:04 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.232 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.232-rc1.gz
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

Linux version:	5.4.232-rc1-g01caaff11184
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
