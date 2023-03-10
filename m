Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099CE6B5073
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCJS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjCJS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:58:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5A73B65B;
        Fri, 10 Mar 2023 10:58:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaeduXIXC5Iq2bgRi+BBS/f0BAJGzS+KHcKUQohKWGB+iBcj1G9BtByihq1rqB0/9Oj0zwZ9DVKPWnSDTwzVMaFjYqB8Skp+QmC/5LjahUthJvtEn33474g7WbvpPs65pKRcUXEfP15Le7LuDNq4FN4mSykU8gtIczUqrm4g2YTcBBRZ/GuOttnJx+QaVq4W3uyZ2EqqNNEPoay9VxXUmmwatkfZcd7CflbkYWm426pkLijHiNCn1/C4rhrAl84l6lpZxqHiasI+UCTvX2U6XJoRgJZLSkmEREOpjbZuxtOFGAYIrwl7tEyTPLyi4K2BEbfnYXOAYsKoLwDrP5n/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L56FnD8n7jt2++6pPRbOmpDqbkkoJPMmsjc3q1Tzd7I=;
 b=NVBLmBS5V4WOdN9djzKESEZaSYyHVaHzttv0oITy970gXJWhG7AKfO0Q23GfeuEYyvc16AKPQ/pEszHJf/e4EOaD5wB3KmmDZtSJFWIW/uF3CQXpbZss7LgaIqsNBJW3FtFENbsTzuFyx+OQJwNCgRrmR8PdMzbP19YNtfa0GfhvzaCEmwNcsmYnjzqWu4mcyjZfnmxgEWKRCtNiy/vnGi93ztyhYWjPsLKXxuxNLMTTCFMlhv5gAVmD/SgUYDOqEQ3v49L6DIol0s49/STEXqzxqJVjW461M2b5yNH8TGgJNIjiJLgUm6xgKs2Xi7wfOJHa9SFgdVNz0MIPTluzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L56FnD8n7jt2++6pPRbOmpDqbkkoJPMmsjc3q1Tzd7I=;
 b=Uc6lRF9K/53hY5knmzQmRsAO5cCK2VsDsuUNlk3KKYHJ66zYkfLbl8jGYtWWwbP/mLZ7rgs570nhZjERBpipFz9gJe3EEUsXA3AkXQWQZRROyUNSjbaqaPO5XcyIfDbDnfGRie7dXL4TG0wV6saRmEbCUoh2/EpAJugeoLd1peb4MgXsqJWnpBkJGNsZB+/kwFdoOaLHeNvfegvDecoJ2utv1R2hbt35B7eQCN82qz7/829aNG7hmIGdR6o2p1mJXKOrwL2NjzIC13TIzf4LdNTygvE3ubScJcIWJIX8CI459cmDj4zsC/H/qjyc2pycZLgS6zJXcS3l0iXRENDvHQ==
Received: from BN9P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::15)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 18:58:00 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::96) by BN9P220CA0010.outlook.office365.com
 (2603:10b6:408:13e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 18:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 18:58:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 10 Mar 2023
 10:57:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 10 Mar
 2023 10:57:48 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 10 Mar 2023 10:57:47 -0800
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
Subject: Re: [PATCH 5.10 000/529] 5.10.173-rc1 review
In-Reply-To: <20230310133804.978589368@linuxfoundation.org>
References: <20230310133804.978589368@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <3924ad22-e0de-46b6-b638-5797692640ed@rnnvmail205.nvidia.com>
Date:   Fri, 10 Mar 2023 10:57:47 -0800
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a83829-06fd-4f56-4e24-08db21995eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybHrXbT3q6DIhgPQ+y03REbq5ku9eLBYWRsP0teiiwtamOWV3IQwRf+ew9q/2ZyosDLwHW1JC409/rutbWeOjQlNZRmeYnj+aLxJlp9qCcSVmCq+Dw2DmktIotshXkq/qSDDJo3Zx2LLt+wENiSi/ezl9zN6qRfBW97t5bHrGZotyFdvSzHY510G9+9vHnxlhE8W4L6wLsSZnZC4czfniTQnarBG/PvMOlIkRDXXodELxGIkvYnxjoZaKk+Be0PM7RV24286USFNtkkMHwCDtwq/Vu818Dsz/23YtEpphiZl4eo0OeqJ4SY3Gl5jVOsiml8zqwkB/CzepKLIBnC9ellEhLa8dHPUUBDrXlj+DfmHCr/HF2YLoRX+UXcWoI6y5TX28p63X2+zVkH6G3ValZ1no9pGArZlOXAVnaGoYdaRiNN7ud13JQgXk5ejnt7uaUUBRKFxFRCHrk7Ggh8IoBD6WUONa19L+kkU4e+XZFlS0gOrKn6CVRrjP5cHvuHTSWtPFL4m+onndhtmGEs7G1sTIkogc0xdRpeBx11zruVhqpEwSbGev5iNUpp31K77YrkiSDYphxkbEISqyG5iiZqruLpjV0x5KjS6Cq8kYzG/2MvjlzdH4wMxgumQJl5jdPcXHoISakb+xk5XYeqm6W+HT+Wh7Rm2k+n1Vz7K7gPwAURvmxflvKCDYnqqqBxIqts1+3VUdzmvoC9rB0hXCL6jyMkjm671KScyxvhb3bHdcPpjtqYn3W10v/skkTE7w2BhXfbtPKwOmU6XAnf0jk0/JYsKna6PMshNc6j53uk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40480700001)(47076005)(426003)(336012)(36860700001)(82310400005)(31696002)(356005)(86362001)(40460700003)(82740400003)(7636003)(8936002)(478600001)(5660300002)(966005)(2906002)(7416002)(4326008)(6916009)(8676002)(70206006)(70586007)(316002)(54906003)(31686004)(41300700001)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:58:00.5055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a83829-06fd-4f56-4e24-08db21995eca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 14:32:23 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.173 release.
> There are 529 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.173-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.173-rc1-g420427e5b0dd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
