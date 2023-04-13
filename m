Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020F66E06D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDMGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:20:54 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1085461A1;
        Wed, 12 Apr 2023 23:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDMI6+7s4NHEImzSqHZCQlJSFg2NbonyEPzOEZMODnYKb5gDTnDs79EH8V4FV2izisAxuMHrh47fJRhmfCFuKIoXXyegSqpoy7e213oeYT0JrSYXQe50fMKC/ZLUdNjhFv08jgC3lF2C18jSfLGUsKgt9weNfPamMwoUchwwMeSiEzy1IkfkbbBdEOiSVFKZYadbqbn17OoTLWdVISN7VpscRWYel8oP8ZUWyL1HN8eCWtZV/j109d8IgRfG2lgAWoHMkK3Onov0B2BIKdv3/vUtpl/zo48oKPAAXRb1R33ZFVe0yUwhOdEFgmrkVSf/ZfeVtHKlYz39c6sqkqwWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21YHanjLxM0ampZmmLBra4F/ALAss7aoP1ckwCyGPRE=;
 b=amA/MTAex3BXSHjRJfqaP4AySVefjkgpMSlvzkPhj/2p50kEIQ2YRFTt7hdOmr9F1kxOofv7eo0uFRZZJzVo4pO4bD75mGXBs2G18yrvqqEfcedALKTO8xIxGWDK+Sokiv9pnc7sJh+/2g3UBXba5BMpckcMWjTbiQMFZydKbqECAF6y3sWbw/9odYZgoHI13atocjbAWR5qsEZFMzDM2p4krAbc/gmfHJ1SuPV5iJurjd6+CGLls4/1+QZcaGa6ZU50NWMZS0g0olD8jwZSt3zDichqJ+UNiBxGOmWUu2g3Xg0xnBMeiGl4Ee3brsQZ390RhcAMlMTddzFkAkxubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21YHanjLxM0ampZmmLBra4F/ALAss7aoP1ckwCyGPRE=;
 b=qh0i64Qxs06WrBZvUd7hZ7+1IZGAmKJv74LXBWAuea5bc6s61kOBUw/RnoFEFiC2I17OLyIv7evzUM6rtnTGeBOstaInfydsg7vtKot9I8bbp9YBCzK8WOKCFyb9srfu+O8LOQX803oqqrTNl9F3NRa+L4Wvp3BtmBFXTy5jGfA=
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 06:20:49 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b::4) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Thu, 13 Apr 2023 06:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Thu, 13 Apr 2023 06:20:48 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 01:20:19 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
        <eranian@google.com>, <puwen@hygon.cn>
Subject: [RFC PATCH v3 0/2] perf stat: Add option to aggregate data based on the cache topology
Date:   Thu, 13 Apr 2023 11:50:04 +0530
Message-ID: <20230413062006.1056-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ac79a9-875f-4399-defd-08db3be7393f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6iIGkk4k2NqQTq8RBIRetYuH1iun7M1+pbl72wAzhY7TQ/fPoo4WnIr8X3tqs+On7h6ciy09zBVH3OuCvA33wUljptrfhxwdZtGED9X/YI7FdGnGor4K0ZyM20G9n9NBIH0LmtAK570wo3Qc/8ufuiAc0+HzJCvQDD5ijbv27duj1hGi8Ukwmf7tgQ56ecZi0z4qawngkR3mxgfSB0yFKVrMyIe6EcOMVZ50iVQvT2wQsd6ozlWb7Qtebrj1i5VYcVNQVvDHGk6Gxm4cE9kCdypQM7H5NgIwtHtlQb8aHdTpNTPPJPUbdsoNDE8W1lCGhLBwKALE6XcMbdUBnpuXmkp00NOVKTqDIkwH1JpiHjf9kNBcOjJFCufrqK/ZsDflzaHHP8g5B+pnhMAWIggJog5ZvqPiD/kW2Lv8DX7tVfC0FMqtp/BGitBTB1iWlzh52j34m7cslg+n1wcbqj/AxuS4cCQAEt6rqSHcfHgXUDuGxwU9yWBiFjPlv90YsABj5OvoCjJXVoLbJkjQ8PiMfthePDtWZT361eb4yLWWoDttBGg7nlr0BrODjAaceyrjaro47JeMA2xLRw3WdcPHSmBKLQ953AxbGIDv0+YX/p55eIaBhpyTZgHKK6FVkQ8Jf66pfxLm9k9ZSaDL7L5d6mtXDK1CySo3VXPTCImTBZYi468AYFmhHmDOKTtsQV9nxeSmVn6PZ9gRKesjqdOHNbZFA26eTVZqDBAetwZNEs+GvQ86m1J90hOZlEsLUUm
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(316002)(41300700001)(81166007)(16526019)(1076003)(7696005)(26005)(186003)(86362001)(6666004)(47076005)(356005)(36860700001)(107886003)(2616005)(82310400005)(426003)(336012)(83380400001)(82740400003)(4326008)(54906003)(36756003)(40480700001)(110136005)(70206006)(70586007)(8676002)(8936002)(5660300002)(2906002)(7416002)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 06:20:48.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ac79a9-875f-4399-defd-08db3be7393f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation behind this feature is to aggregate the data at the LLC level
for chiplet based processors which currently do not expose the chiplet
details in sysfs cpu topology information.

For the completeness of the feature, the series adds ability to
aggregate data at any cache level. Following is the example of the
output on a dual socket Zen3 processor with 2 x 64C/128T containing 8
chiplet per socket.

  $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_remote --\
    taskset -c 0-15,64-79,128-143,192-207\
    perf bench sched messaging -p -t -l 100000 -g 8

    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver threads per group
    # 8 groups == 320 threads run
    
    Total time: 7.648 [sec]
    
    Performance counter stats for 'system wide':
    
    S0-D0-L3-ID0             16         17,145,912      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID8             16         14,977,628      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID16            16            262,539      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID24            16              3,140      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID32            16             27,403      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID40            16             17,026      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID48            16              7,292      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID56            16              2,464      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID64            16         22,489,306      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID72            16         21,455,257      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID80            16             11,619      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID88            16             30,978      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID96            16             37,628      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID104           16             13,594      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID112           16             10,164      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID120           16             11,259      ls_dmnd_fills_from_sys.ext_cache_remote
    
          7.779171484 seconds time elapsed

The series also adds support for perf stat record and perf stat report
to aggregate data at various cache levels. Following is an example of
recording with aggregation at L2 level and reporting the same data with
aggregation at L3 level.

  $ sudo perf stat record --per-cache=L2 -a -e ls_dmnd_fills_from_sys.ext_cache_remote --\
    taskset -c 0-15,64-79,128-143,192-207\
    perf bench sched messaging -p -t -l 100000 -g 8
  
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver threads per group
    # 8 groups == 320 threads run
    
    Total time: 7.318 [sec]
    
    Performance counter stats for 'system wide':
    
    S0-D0-L2-ID0              2          2,171,980      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID1              2          2,048,494      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID2              2          2,120,293      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID3              2          2,224,725      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID4              2          2,021,618      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID5              2          1,995,331      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID6              2          2,163,029      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID7              2          2,104,623      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L2-ID8              2          1,948,776      ls_dmnd_fills_from_sys.ext_cache_remote
    ...
    S0-D0-L2-ID63             2              2,648      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID64             2          2,963,323      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID65             2          2,856,629      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID66             2          2,901,725      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID67             2          3,046,120      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID68             2          2,637,971      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID69             2          2,680,029      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID70             2          2,672,259      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID71             2          2,638,768      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID72             2          3,308,642      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID73             2          3,064,473      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID74             2          3,023,379      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID75             2          2,975,119      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID76             2          2,952,677      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID77             2          2,981,695      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID78             2          3,455,916      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID79             2          2,959,540      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L2-ID80             2              4,977      ls_dmnd_fills_from_sys.ext_cache_remote
    ...
    S1-D1-L2-ID127            2              3,359      ls_dmnd_fills_from_sys.ext_cache_remote
    
          7.451725897 seconds time elapsed

  $ sudo perf stat report --per-cache=L3

    Performance counter stats for '...':

    S0-D0-L3-ID0             16         16,850,093      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID8             16         16,001,493      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID16            16            301,011      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID24            16             26,276      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID32            16             48,958      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID40            16             43,799      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID48            16             16,771      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID56            16             12,544      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID64            16         22,396,824      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID72            16         24,721,441      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID80            16             29,426      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID88            16             54,348      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID96            16             41,557      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID104           16             10,084      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID112           16             14,361      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID120           16             24,446      ls_dmnd_fills_from_sys.ext_cache_remote
    
           7.451725897 seconds time elapsed

The aggregate at S0-D0-L3-ID0 is the sum of S0-D0-L2-ID0 to S0-D0-L3-ID7
as L3 containing CPU0 contains the L2 instance of CPU0 to CPU7.

[New in v3 - Handling IDs differently compared to v2]
Cache IDs are now derived from the shared_cpus_list file in the cache
topology. This allows for --per-cache aggregation of data on a kernel
which does not expose the cache instance ID in the sysfs. Running perf
stat will give the following output on the same system with cache
instance ID hidden:

  $ ls /sys/devices/system/cpu/cpu0/cache/index0/

    coherency_line_size  level  number_of_sets  physical_line_partition
    shared_cpu_list  shared_cpu_map  size  type  uevent
    ways_of_associativity

  $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_remote --\
    taskset -c 0-15,64-79,128-143,192-207\
    perf bench sched messaging -p -t -l 100000 -g 8

    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver threads per group
    # 8 groups == 320 threads run

         Total time: 6.949 [sec]

     Performance counter stats for 'system wide':

    S0-D0-L3-ID0             16          5,297,615      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID8             16          4,347,868      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID16            16            416,593      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID24            16              4,346      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID32            16              5,506      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID40            16             15,845      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID48            16             24,164      ls_dmnd_fills_from_sys.ext_cache_remote
    S0-D0-L3-ID56            16              4,543      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID64            16         41,610,374      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID72            16         38,393,688      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID80            16             22,188      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID88            16             22,918      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID96            16             39,230      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID104           16              6,236      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID112           16             66,846      ls_dmnd_fills_from_sys.ext_cache_remote
    S1-D1-L3-ID120           16             72,713      ls_dmnd_fills_from_sys.ext_cache_remote

           7.098471410 seconds time elapsed

This series makes breaking change when saving the aggregation details as
the cache level needs to be saved along with the aggregation method.

This RFC assumes that caches at same level will be shared by same set of
threads. The implementation will run into an issue if, say L1i is thread
local, but L1d is shared by the SMT siblings on the core. I'm seeking
clarification from the community about the same and potential solutions
if processors where such a scenario exist.

This series cleanly applies on top perf-tool branch from Arnaldo's tree
(https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools)
at:

commit e8d018dd0257 ("Linux 6.3-rc3")

--
Changelog:
o v2->v3:
  - Dropped patches 1 and 2 that saved and retrieved the cache instance
    ID when saving the cache data.
  - The above is unnecessary as the IDs are being derived from the first
    online CPU in the cache domain for a given cache instance.
  - Improvements to handling cases where a cache level is not present
    but the level is allowed by MAX_CACHE_LVL.
  - Updated details in cover letter.

o v1->v2
  - Set cache instance ID to 0 if the file cannot be read.
  - Fix cache level parsing function.
  - Updated details in cover letter.
--
K Prateek Nayak (2):
  perf: Extract building cache level for a CPU into separate function
  perf: Add option for --per-cache aggregation

 tools/lib/perf/include/perf/cpumap.h          |   5 +
 tools/lib/perf/include/perf/event.h           |   3 +-
 tools/perf/Documentation/perf-stat.txt        |  16 ++
 tools/perf/builtin-stat.c                     | 144 +++++++++++++++++-
 .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  14 ++
 tools/perf/tests/shell/stat+json_output.sh    |  13 ++
 tools/perf/util/cpumap.c                      | 118 ++++++++++++++
 tools/perf/util/cpumap.h                      |  28 ++++
 tools/perf/util/event.c                       |   7 +-
 tools/perf/util/header.c                      |  62 +++++---
 tools/perf/util/header.h                      |   4 +
 tools/perf/util/stat-display.c                |  17 +++
 tools/perf/util/stat-shadow.c                 |   1 +
 tools/perf/util/stat.h                        |   2 +
 tools/perf/util/synthetic-events.c            |   1 +
 16 files changed, 409 insertions(+), 30 deletions(-)

-- 
2.34.1

