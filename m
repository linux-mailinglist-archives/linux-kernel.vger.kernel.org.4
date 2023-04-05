Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9775E6D7FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjDEOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbjDEOgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:36:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F3659F;
        Wed,  5 Apr 2023 07:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cuh0zJgsT+VNcA58ENttgHItX68918oAkZMrpH4iR5BlqXjzR/RHZSMWhMlP6xylh0/h02exY500926LHY/w+wBENBFyJWVMNuV8/EQCoj5aaS2SUC5oESl0BBik9sqqIsu2IuTUVfaeqgZrXWWUm3zSp01pmBf4f5pqqNQKv/HiPhcKbSWN5RG9x8YPmJiY0kfL7aHOfFqvsI8bBJCltqJVakldj5osXjlViUDbMAqT9H+Cd2Fx+NUKtAKg3l39++yz7o5yciM6pQXK89crUcGx9aXy6N6g/hjxKpwKdO0Ph+87QwxxuELkvpm+k23dj/BAcAgAbQqmPoUCGzYQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQwYr0Bliv2EPBJleDKiBJ4IpDQe+9OsmIoeADPNGCw=;
 b=Enk6SeDuu5hR/fjnGHEOlkyLWkyGbZrymJvzxLjYQbZKmrYk460KmHWXnCZbJwR7Py6wN2tHk/ybdpSpoNW6RZMp1NBVSzg6eZ9DDjkPzuPge1EOrfMbeXxT6oqJ+gM0Xw59uggxXNSI+evJpbiFd5QWP5ygQA6q0ThUn9XBdpvjN2TmP1ULENYECYEITPbDnt+lxKbnC43JPywPIENqa+7Rmzu0Taky0XqNJBTN0WKa2hrPXXOAAYZ+S9osk6Scind6f7J1hGdejcyBjD38KKSzcPvCg4v7T2opmAXCAZr/U2qXew3TDNpTf3R92K7OdGaVmAr/Al7HFYphNaMEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQwYr0Bliv2EPBJleDKiBJ4IpDQe+9OsmIoeADPNGCw=;
 b=qKDZ7UaiNNMfigpdt3eONresw1nJ/utYi/xDDKEKh/3Nf41PckjWC7agZCLud0QpyKfK1kqUoKdsMs5oHNW3hyZsZsugWu8FNSykWfMh+p/sHxld5l9A2O/W9pZxX/cYTaMFG3dnQDbKzVE4xBr5YIwPMK1s4Z0EQvIdCjkW51O5Ydt2YymOxX7C3+CQpJ7mOOTjP8cL85ovjyMHdJRC+d6SSuc+pZZVQBZCcFhDADXithzl+iMos4dtIad54rOfIealHTM+zwBLiG0Ad4EWDmIWnXQMxpbKjseDv0XkUENh028ugf000W0GIMKtZ34RLnkUtNuE+74pDKSUwDf85w==
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 14:35:57 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1c) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28 via Frontend
 Transport; Wed, 5 Apr 2023 14:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Wed, 5 Apr 2023 14:35:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 07:34:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 5 Apr 2023
 07:34:54 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 07:34:53 -0700
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
Subject: Re: [PATCH 6.1 000/177] 6.1.23-rc3 review
In-Reply-To: <20230405100302.540890806@linuxfoundation.org>
References: <20230405100302.540890806@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d114f577-ff4d-45f3-a8e9-8af62573939c@rnnvmail202.nvidia.com>
Date:   Wed, 5 Apr 2023 07:34:53 -0700
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce50bf4-0e3e-4699-f8dc-08db35e3118a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbtNBxC9p7/ugJkecFTyFC82nBMMfWp4aA6z4C5Pgn99MhwjXH5/0Dh1HreLVYP/rldLSaBH++bAS/4+hQvOFyZji4JsUR5EEiaWlP0Z5qgj6owe8+Sg0tuhDQrROjczaYcOiwUuLCt5rhtJHcXJVg7hQ0e566eX1KjRMF3FIQeZrzorMN2kHfhTAxZjnEPzVTk7A4KmRExo5HfExmfoTo4zNPwYyOwZiy1B8VidqZhojyFldT+vkZwTl6KsX4QYYRs2GrrcvCWCX2MOdHU9PAH6/BuYWdZF5jw5psgt5eD0gNWDLbTMC8T8PAK8SJtqepVdTVgH/62m1qp7vxeFbBckOdjQmTEM0fz9WPbrQ4BeUtgFTnVNcx88GNsOEKoPRyCodNlYLX/ehBmxdI5BNo2DbiiBNNxOT5VERqq5JdS+1Z8MOoGCpSMg8uGKMpVNHCshR8rQA42rBAEz68DdgOXqBcq/oUKMCnZvsyYzpbeintCri9iyQt25Xujytd0xSk6CrCmXT0EXCjaq4eESkXX8hTLctJ8CGwQ95T2g2Pjrg/xVJd5BMdFYmK+gAj8NeHByawmN1XGx1LMQtpLtePFBXnVMzHOQ1Vu+9PzBCIscMrxZCbOebKUq4uSHVznD2lpJNrLHbIlouFazWn5/nNSiB5Ms1i/ilfmHsgvA/+R7xxAbFSW/C8qi/6jHAAQIR9v59l6cN3RKPUY19ZplZp2LnGACHyV/hNF6NE9lGbcShqSR8aMweOTvoSFG2azvuRrlkaBUkryy3HOKdnmSS269FKwGVUfHfVOgAQyETjw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(31686004)(47076005)(426003)(336012)(40460700003)(86362001)(186003)(26005)(7636003)(31696002)(6916009)(2906002)(70206006)(70586007)(8676002)(82740400003)(41300700001)(40480700001)(356005)(4326008)(36860700001)(54906003)(316002)(478600001)(82310400005)(7416002)(8936002)(966005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:35:56.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce50bf4-0e3e-4699-f8dc-08db35e3118a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 12:03:38 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.23 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Apr 2023 10:02:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.23-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.23-rc3-gf8a7fa4a96bb
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
