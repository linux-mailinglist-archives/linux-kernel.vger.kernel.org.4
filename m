Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E76FA27E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjEHImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjEHIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:42:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9520749F3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW2dD+fkzDawYaHsvB8vTHJeLUWfBoRsd+QO9g2xOlG4xZGzzGauSX4ZLSqXNyXiGSxpBOpVPic9DKJMQFfSng5uabaIK09tIN1EUfOOuteGZdLyuBfmXGvcMPewyyWg28SU6ESW0Q8CEP8VvJyJm6xz8Io1YdBXra14xlUfiWn11oIiN/PyB7bATo9VqybZQ4AiYnnQvCkO6xkjpSo4ql1dq0C/W6ILc8YA+HQ3JiGfXeeBWHUUPFqLwfGri0TNSjPFM9QRPOl3sVnp5XKbQSsmn+CiONA4McOGYeGvCjpOkLtHASrqLJ7L0nXx0xkrXOFL2w4gsUbBrrEgCqg5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/4/depAAu7SHzKRfHzuG0A9ZYnJRjQ9+v3bBVZCieM=;
 b=GXkcu0Fmq2QQCBQ6xVj7aWVhybEhkRC7dKbsh+M8I/f61eP6CNacevU9KIGwuTVhkt0HaSm72nNQC71kuzadp4b6SmLYrA1VRHYFXqhsTyk635Zy5ShWtmTAxFO4uC5glIKty6XBKBCQY/t+/+3OlMCjfasIQyBET7+xeRiUY5DtQP4AZdwN449Zp8aCUf5mvW1DLSAKGCSeUIf8Q11+KWb/FxIjZOMjI4cjlyaF3uo6owWmg3kVJI6DiEHfcbzKBxEKq2jOJNWaD5C/8wyjm4NKS12wCIcywcXioCjY9lqMa1CE5dpDbuCgwoQCLh8mo8un8OSNBgRgNaZC82Pt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/4/depAAu7SHzKRfHzuG0A9ZYnJRjQ9+v3bBVZCieM=;
 b=IAxcWldF1nF3l6OuADxJYzoWaaq6BOFABg0y1EYuXFIChC2WkkF8YD6wNWgrlVA7RPcGM3Xo2PPZZAn3S6w1OgCugiW+ZQutXAaAnl194EOPp3ngZpyMkoG3clMxUC8hYf0RAKTltHsu3zH5eHeso+zMnUOWGT2GITk4R4nD0U4=
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:42:31 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::79) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 08:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Mon, 8 May 2023 08:42:30 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 03:42:26 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <yongxuan.wang@sifive.com>,
        <pierre.gondois@arm.com>, <vincent.chen@sifive.com>,
        <greentime.hu@sifive.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <palmer@rivosinc.com>, <puwen@hygon.cn>
Subject: [PATCH 2/2] drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug
Date:   Mon, 8 May 2023 14:11:15 +0530
Message-ID: <20230508084115.1157-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508084115.1157-1-kprateek.nayak@amd.com>
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|BL1PR12MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a553d2-90cd-4baf-dab5-08db4fa02956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /m5CTdQz0ALcca30zbbDUMn3kiMxSwk9S4YJA68Trl6o1Nz7zhGRwcf68TZ7wjNbkFnRL0BzS+MlEr66t4Xa5k1/Q3vEPeTan9QFagsoBmybvj9TlBtecsWK3Vy7QXXyp+w3FJxCJRvS5ZQba8hjyg9gwZteDJvazAcFJ+X6+eVll+dEHBiXs3QmzOujBnIgtE3ieyBS4sDLFvJYNG8hFGxYShshZzDqSeq44+LZdgwbAcMt5MQhm3kt2Q9ddq8woE2RY+L2/wjwr6nPIYykUcx6+HPSDdteMD18JuWG9bSoVngOrlJAtEtx8NS8d5oujGajqwNGsrk8bxBj9nvYl4KWvH5h+S3TZM248CXOabTEj2OjDnWlLssx9LT4d/qHsXMTZHNDeFX1iguYA4amGfXtndjncofoVFP85F4F3a+9k5VTUHYXIo+L870o31nPN8i6qXB3oisJIMZBF+xy9BrYiTASABNmkDBF4KgsmfY3F8ciZk4J9JcGyaVvWstg0K8QAbjgY+nPpe1bu8pp9LMVLJ123+WrWbZww/laLyZgPujJVRvbjbdYrNiBL3f53JOs3i4qkyG0ALLGQAUcBS6xAr0+mKBtVp7eIQ9LuiHtgSllR/T/x+Ki0YZgVolNVrEDSpM/9fC45bOOndRLzfp259OtSTd+WJYPelm4gD6ArJLcXsHZc/T3PYHIxRFKsuBC3DMTNYH2QNrAmRORp7ozBuEC+jjfVvdd2upmR94=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(6666004)(54906003)(316002)(70206006)(6916009)(4326008)(70586007)(7696005)(478600001)(82310400005)(40480700001)(8936002)(5660300002)(8676002)(2906002)(7416002)(41300700001)(356005)(82740400003)(81166007)(16526019)(186003)(107886003)(1076003)(26005)(36860700001)(47076005)(336012)(83380400001)(426003)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 08:42:30.9039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a553d2-90cd-4baf-dab5-08db4fa02956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
sysfs"), cacheinfo called populate_cache_leaves() for CPU coming online
which let the arch specific functions handle (at least on x86)
populating the shared_cpu_map. However, with the changes in the
aforementioned commit, populate_cache_leaves() is not called when a CPU
comes online as a result of hotplug since last_level_cache_is_valid()
returns true as the cacheinfo data is not discarded. The CPU coming
online is not present in shared_cpu_map, however, it will not be added
since the cpu_cacheinfo->cpu_map_populated flag is set (it is set in
populate_cache_leaves() when cacheinfo is first populated for x86)

This can lead to inconsistencies in the shared_cpu_map when an offlined
CPU comes online again. Example below depicts the inconsistency in the
shared_cpu_list in cacheinfo when CPU8 is offlined and onlined again on
a 3rd Generation EPYC processor:

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

Clear the flag when the CPU is removed from shared_cpu_map when
cache_shared_cpu_map_remove() is called during CPU hotplug. This will
allow cache_shared_cpu_map_setup() to add the CPU coming back online in
the shared_cpu_map. Set the flag again when the shared_cpu_map is setup.
Following are results of performing the same test as described above with
the changes:

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

Fixes: 5c2712387d48 ("cacheinfo: Fix LLC is not exported through sysfs")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/base/cacheinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index d1ae443fd7a0..cbae8be1fe52 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -410,11 +410,14 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 			coherency_max_size = this_leaf->coherency_line_size;
 	}
 
+	/* shared_cpu_map is now populated for the cpu */
+	this_cpu_ci->cpu_map_populated = true;
 	return 0;
 }
 
 static void cache_shared_cpu_map_remove(unsigned int cpu)
 {
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
 	unsigned int sibling, index, sib_index;
 
@@ -447,6 +450,9 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			}
 		}
 	}
+
+	/* cpu is no longer populated in the shared map */
+	this_cpu_ci->cpu_map_populated = false;
 }
 
 static void free_cache_attributes(unsigned int cpu)
-- 
2.34.1

