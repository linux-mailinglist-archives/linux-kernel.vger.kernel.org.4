Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8A610D10
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJ1JYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJ1JYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:24:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC71C73DC;
        Fri, 28 Oct 2022 02:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsaY7l954NRtM+bMpYKnb/r4+xvlsMf+7ol+lRHOb63sM4gDWem5bh+SztqBGrmlsuymXDkcvXBtbI0/Dh9UugYP1wkwyOQZy67AxfL9sjJyTzZeNG2aDydKPNJH7/Y3rHGaXP52xwSOVmDQ7LIJgjUyvUgXb5N6xVeZfghB8f/C3I6Slmrrfm5t3SHastslZ+tarvPuskN01pQaEvVUXDSMjClP+kTQVjLazDTC6xk+4bAXKMA99uZ4r6E303ywYYgBLtf4kFUGPOLTtHlb/fyuTb77oSMwF7+RnysRQAuAmXEU16NfZvp7R6bhuhHmgyTImOIlyhP9kjvVwFDeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qBbM1oyKB9x96ZRlxP6Pw9uZoLkKC3jBQWL+Nmbick=;
 b=oGHKIsUqfZDDdQqXMEt4ncilX32Pqj41XpmF7+AypTEFR0VI3g5zmzgWbECWk3WYRUDqJABUBCOnzEhi15WE3hoOSAHRwd1hP513cIo8xavOr3WuRjJFPlfHUHAA2d7noKsni8I8vyxNCIQHz6C44FmoNSjmmmRI07JRRElh89p+ryFg4+lT0GEcqmbLQk5CJsxi8toZ7TUfWdocrod5eKbxXfxKd4G3inQyx5YJRdhVw5Ls8P7KKAGQMGyIrhB5myRUcnyWx6gVuFUVmGcOtstGqQ8ye+fOkVUIrftTjjaey7GqYIH5Q6GFOAsKNeLFvrvRcCpTnYLn/rd400fbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qBbM1oyKB9x96ZRlxP6Pw9uZoLkKC3jBQWL+Nmbick=;
 b=rL5IaGYPNECshuGNsHSRENbqJvOsLNycQRMJ/s8eGcej5OTyMRspSnxDOsnsD2yKzbb5sp0yfJE5vVdoNWmIvH3m7OjbKVucDmqETbNS18xL98iVBwGvmj32qymczvKNC/OkBOASAlEN7+5Y14DqM0r8qB+w+/Xb+48j5tj5JVI=
Received: from DM6PR18CA0033.namprd18.prod.outlook.com (2603:10b6:5:15b::46)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 09:23:50 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::16) by DM6PR18CA0033.outlook.office365.com
 (2603:10b6:5:15b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 09:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 09:23:50 +0000
Received: from [10.143.195.215] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 04:23:09 -0500
Message-ID: <6a55f582-76ac-3260-6b8b-704f92647d0e@amd.com>
Date:   Fri, 28 Oct 2022 14:53:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [RESEND PATCH v5 0/4] drivers: misc: Add support for TMR Manager
 and Inject IPs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <appana.durga.rao@xilinx.com>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <git@amd.com>
References: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
 <Y1ucPco2aRbQWfK1@kroah.com>
From:   "Rao, Appana Durga Kedareswara" <appanad@amd.com>
In-Reply-To: <Y1ucPco2aRbQWfK1@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c44181-09bf-4f50-ff3f-08dab8c61ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoEmqGP1OGoXkoXwkvq81tc9sgINy/xWaH/e73RvhRKN6i57yrQFdbpmtlHi6F6YS5KjtZVakSC6EPvdwjFeke7GyP/1d4+lsJ1jdVaISwVH+k+2GROpSGWu+3Yt2W7ZkYLYrLrlwF4S7IPUaD9je29ETzOaprN7/y6WbEuewZESCSxCHYmhZsAFZNV7uTJCeZXnMg9mdHPWtfmjZDHGelDBRe4v3UxuZGIm9bxuSsWeDvHD3i3J7ceLnnpgRDPFdNvS8+d8gP0hZOrs+l25ftCUSqdPM8sd3S0c5UEE40yWli8ZlHyxw4CJw11Ol0MAc8GU7xjiMcfzQrwudruqMDrjPkgusNySVZvSZpIgmdWaP9H24DtwcyYF113Mu25DyWmY9GkjJ+NnZSfsHUjsab2QkAb6/mWVvNbUia99u3lPa7bF+nxhnuBAOAUPN5/mwGhGoIJEodJtLoHaHNqgQCgrWHAjPRpHJCN4Dfp4HIK6IUV7h6Mz1efnRSqKnIaoJhKCWqaTq3toR8Jfyq7pryP94zilzi6rKwAzeSED334OVdKbvxKda57egqTNgu7+geKgxDSpCNrhtKUmWv6MUorGAiY1Gr5kyRYy6k+H73U7KYJjoGGigiqvmKwyC1M0OVe1y2pc/mhC+84VY0lOglmV7dI9eObOuWjr3Wh6lSXcsE5+Ncbhcm8dqAtwrp14ET0pUqhKPy/TFocJyJK18UPSEUAYegLtc5smDI7mV/RHmkTRHWmWmPYY19qaIolSJ0hn8sMBg7W0wUm4EOub/alJ63Ft02vikwI5lhEcjeMqO+yOqjJn//3yUkuQNCaslqNpb3RMrwDe3SoauiYHKXjKITJGfdDGNQmvXYzvZS4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(53546011)(31686004)(316002)(82740400003)(36860700001)(16526019)(2906002)(5660300002)(70586007)(47076005)(81166007)(2616005)(356005)(83380400001)(40460700003)(336012)(186003)(426003)(26005)(966005)(4326008)(16576012)(110136005)(82310400005)(6636002)(70206006)(8676002)(41300700001)(31696002)(8936002)(40480700001)(478600001)(54906003)(6666004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:23:50.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c44181-09bf-4f50-ff3f-08dab8c61ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


On 28/10/22 2:39 pm, Greg KH wrote:
> On Fri, Oct 28, 2022 at 02:31:02PM +0530, Appana Durga Kedareswara rao wrote:
>> This patch series adds support for TMR Manager and TMR Inject IPs.
>> The TMR Manager is responsible for handling the TMR subsystem state,
>> including fault detection and error recovery. The core is triplicated
>> in each of the sub-blocks in the TMR subsystem, and provides majority
>> voting of its internal state.
>> The TMR Inject core provides functional fault injection by changing
>> selected MicroBlaze instructions, which provides the possibility to
>> verify that the TMR subsystem error detection and fault recovery logic
>> is working properly.
>>
>> For more details about TMR Manager and Inject IPs please refer PG268[1].
>>
>> [1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-TMR-v1.0-LogiCORE-IP-Product-Guide-PG268
>>
>> Appana Durga Kedareswara rao (4):
>>    dt-bindings: misc: tmr-manager: Add device-tree binding for TMR
>>      Manager
>>    drivers: misc: Add Support for TMR Manager
>>    dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
>>    drivers: misc: Add Support for TMR Inject IP
> 
> Why is this a RESEND?
> 
> What happened to the first v5 series? >

Haven't received any review comments for v5 and it's been month that i 
have sent v5, so rebased the patches on top of latest tree and resend.
Should i post v6 instead of RESEND?

Regards,
Kedar.
> confused,
> 
> greg k-h
