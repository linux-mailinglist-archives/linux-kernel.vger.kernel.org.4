Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351676FA27B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjEHIlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjEHIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:41:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6210811613
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD5JtV4eTdX1BuUndWlk8JK2SoK7rxkmi9Hd9cUsOI+zT7RtLWHmPWEylvfAbNqRdHTCRdVN5XON2GuFlJODbcdTa9El9nKIf/ML5aRFZ3eUloyU9JMIv285AHG96rD3ahDiWMNUTnxo8M5FTlhieFmee9BTiTP0OvU8xm/Sqxk0gfXx4MmQn75mqW2PErtJu6H50wNZi7o+Te94mdcVegKd+MmY4AEp+Qqdj1zrYCTIVFCjqa96bssENmTw9NW2HVnbzGC/PHEAYp94moBCJCwQHZ5tM2KXU5LDOQ2T3dQ4OBsL7Kg5WyYweiOMb9u2I3ZjnkB/jOfnRHxwKfBu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bofzAY0Wgs+wJU9918YscrwPu5BK6XKZDfetSnIY6U=;
 b=nni2lnoOW2LGkYtdAzzVYL+OnmKMq76jXinzesw4X7OCecE/mFxylaGuTJw4jIwkWxA/pCUOy517YOKoAkyqde7m5ihRHFc+00jvcEaQLfObj4KCGfsDGfPNrG2tuP2TLz+BdqlKVw6kWiCCD9k2XvYM57ltoR+/5otTZQrqFAKgmWM/mFmE3uns7Y9Nm9/jw6gcUKVn/gsED0/ALMqnYP2+h0nU9aF/quarQoRMxnW/iHEsGLchusGxpBdqh+GI4zTMY1qL9DBVTGMTL1NlxRgWrr6SzaLmWaWDjBdxpKlrx2MS9rCXF03O8Mzr+e/grv2fNXESgY9Ri7u68nX7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bofzAY0Wgs+wJU9918YscrwPu5BK6XKZDfetSnIY6U=;
 b=ovVq3YxI0MNVUDteQ50pAX+Sy63ngOXjCyvVtt1G0eX8OfSSxvdWdmB03W2lxAfKn2H6XhXt1v0MkDdJDke4WTrBIgZM/AExd2rrh8wt5RekO5yA0ehFjoKCxVvodt1AZdsi4dyxs3CI9d9gMIzZCm0NDMpZXwN/nTFoJ2cuV7o=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:41:32 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::63) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.17 via Frontend
 Transport; Mon, 8 May 2023 08:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 08:41:32 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 03:41:27 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <yongxuan.wang@sifive.com>,
        <pierre.gondois@arm.com>, <vincent.chen@sifive.com>,
        <greentime.hu@sifive.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <palmer@rivosinc.com>, <puwen@hygon.cn>
Subject: [PATCH 0/2] drivers: base: cacheinfo: Fix shared_cpu_list inconsistency in event of CPU hotplug
Date:   Mon, 8 May 2023 14:11:13 +0530
Message-ID: <20230508084115.1157-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: da851c72-35c3-49ae-e0db-08db4fa006b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnJZQN9igO9xuAg4xt8czrqqfUYKOdxZ8OgdpoF3Wh3McTYy/a4g1zywAhuX0fxziao9dssJfNoi6FSrgcsPBm9a4SVbjXWQRD5dfqioDhWDgz6FcYbAnK8/6Y7eSN5+PrCWxcuVOGURPn9tdGfpnckykktgzs05F+8PouPt9FBcekhr1j3/D8Emx6mKIpdBuolnWbsqeyyjS4BCv+8UGDs5adtHoRI3d3iVgXrMFkdWQJXoZrrZ52b7eBEMdW9NshAZ/lIseWtgB+ZWLLDb9JDP3jt/Cx4+Q0lM+Tj2ba3mvEbqEf6Xara39UnK5Vu3E/aNuc7tILlmLmuSbzZPhyWT9QmYsFSuKfPChWWDsphDRYzvGSUA3Gz//f1kuop0HKmZOlRBguBGQ9t+6zh4LByEaQT7k371PwREnoBr2MYdR9a7QSfNqDCgIgtDToeaN+gWXW5lzF7knYFu63fyX550gJFws6EAsDNPHiHE0t1+qNkixfsQ/iCPIUQsV3gkB9K07ZO8ycqtOTDsRywDVHwdIuIG8vvtRKDWDRTzwEn+qgt3twIYsXibtiWlnmd7L6/5fzFh3lsG503QYaXBhyMuC2bHyfQsFyeDmLIG+moH9vTzuj5lPDTxXQbhzUJG8ruXZDDewR10FuCh1Bk9z5nn5Ebe1GBuqz3t63VZOMWFfnZGFo5mCMo8uaAYv9VI7SJk12Za+gwbtQOlZIsktrQ+ZA43ynUJnv3LBZC/S5U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(426003)(336012)(83380400001)(47076005)(7696005)(478600001)(6666004)(54906003)(2616005)(1076003)(26005)(16526019)(186003)(107886003)(2906002)(7416002)(36756003)(40460700003)(356005)(70206006)(70586007)(6916009)(82740400003)(4326008)(41300700001)(82310400005)(81166007)(8676002)(8936002)(40480700001)(86362001)(5660300002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 08:41:32.8023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da851c72-35c3-49ae-e0db-08db4fa006b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v6.3-rc1, the shared_cpu_list in per-cpu cacheinfo breaks in case
of hotplug activity on x86. This can be tracked back to two commits:

o commit 198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared
  caches at different levels") that matches cache instance IDs without
  considering if the instance IDs belong to same cache level or not.

o commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
  sysfs") which skips calling populate_cache_leaves() if
  last_level_cache_is_valid(cpu) returns true. populate_cache_leaves()
  on x86 would have populated the shared_cpu_map when CPU comes online,
  which is now skipped, and the alternate path has an early bailout
  before setting the CPU in the shared_cpu_map is even attempted.

  On x86, populate_cache_leaves() also sets the
  cpu_cacheinfo->cpu_map_populated flag when the cacheinfo is first
  populated, the cache_shared_cpu_map_setup() in the driver is bypassed
  when a thread comes back online during the hotplug activity. This leads
  to the shared_cpu_list displaying abnormal values for the CPU that was
  offlined and then onlined since the shared_cpu_maps are never
  revaluated.

Following is the output from a dual socket 3rd Generation AMD EPYC
processor (2 x 64C/128T) for cachinfo when offlining and then onlining
CPU8:

o v6.3-rc5 with no changes:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8

  # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
    136

  # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
    9-15,136-143

o v6.3-rc5 with commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
  through sysfs") reverted (Behavior consistent with v6.2):

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
    8,136

  # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
    8-15,136-143

This is not only limited to AMD processors but affects Intel processors
too. Following is the output from same experiment on a dual socket Intel
Ice Lake server (2 x 32C/64T) running kernel v6.3-rc5:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,
    26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,
    88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126

  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8

  # cat /sys/devices/system/cpu/cpu72/cache/index0/shared_cpu_list
    72

  # cat /sys/devices/system/cpu/cpu72/cache/index3/shared_cpu_list
    0,2,4,6,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,
    66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,
    120,122,124,126

This patch addresses two issues associated with building
shared_cpu_list:

o Patch 1 fixes an ID matching issue that can lead to cacheinfo
  associating CPUs from different cache levels in case IDs are not
  unique across all the different cache levels. 

o Patch 2 clears the cpu_cacheinfo->cpu_map_populated flag when CPU goes
  offline and is removed from the shared_cpu_map.

Following are the results after applying the series on v6.3-rc5 on
respective x86 platforms:

o 3rd Generation AMD EPYC Processor (2 x 64C/128T)

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
  
  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online
  
  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
  
  # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
    8,136
  
  # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
    8-15,136-143

o Intel Ice Lake Xeon (2 x 32C/128T)

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,26,
    28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,
    92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
  
  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online
  
  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,26,
    28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,
    92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
  
  # cat /sys/devices/system/cpu/cpu72/cache/index0/shared_cpu_list
    8,72
  
  # cat /sys/devices/system/cpu/cpu72/cache/index3/shared_cpu_list
    0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,
    68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,
    124,126

Running "grep -r 'cpu_map_populated' arch/" shows MIPS and loongarch too
set the cpu_cacheinfo->cpu_map_populated who might also be affected by
the changes in commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
through sysfs") and this series. Changes from Patch 1 might also affect
RISC-V since Yong-Xuan Wang <yongxuan.wang@sifive.com> from SiFive last
made changes to cache_shared_cpu_map_setup() and
cache_shared_cpu_map_remove() in commit 198102c9103f ("cacheinfo: Fix
shared_cpu_map to handle shared caches at different levels").
---
K Prateek Nayak (2):
  drivers: base: cacheinfo: Fix shared_cpu_map changes in event of CPU
    hotplug
  drivers: base: cacheinfo: Clear cpu_map_populated when CPU goes
    offline

 drivers/base/cacheinfo.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.34.1

