Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76FF70438F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjEPCpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEPCpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:45:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2052.outbound.protection.outlook.com [40.92.41.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27D4682;
        Mon, 15 May 2023 19:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJSqI72pK/Ifa05GoFlXWoJioo3gNHA3A1PYkErGMzSIzpt/xe+8TtkYAFHbvXePrbLOqDMfaqkVWR89+vF/bexX67Rd5lP+439sZz5AEZo7bXd2KDtKyB6XUtuc+Ebd+HpyvHr77tEGqQWR5Rt52QETV+RtsOJgWHn3quyqb9lLPMSoZ8Jlo/J0y/VQteqsUcygtLUybtDt4wRnt7pOyQzw2woym6SxLQl9G/w9slWvm6kArJP1hxAHPDfiYwpNa/BjM6nTGPHyWjfgB2Xq+lt4xRUUHKO4BnJcYaI+mOoKFyXYW5LRAO/znUXl1aUFYf+DnaBcamllJIf7i9RA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPtDhu2ar+vR3t0fDyH88n6nD/SsY+FFSxhJp/ZgWPY=;
 b=QjjyT3FuugsljnjW5WQZEMZmVs/GpTs3RxGdpYSyeRio/+DVIDntBvKdI7WCbD8afaiXbi2uYOpvSZxSWu1FhbuYg+HJjaH4UkHh7uEVW2uwexo2Xe7YYFPAZGWXq/quKtG96S5VDFIUVorYRCbLCmKBWGTb9witT5BJqjThX9wiAcaC0KkPxfywgMB0K71odyocyKIVIjrdvV3ckjUeVBJ7hnvCxuANJmuPN/6LeoP0+qWGxl6culGGjfYwM0YMEHXsxE+EEo8/S0qkt1z6EBZxVP3q7yg/Ckww2jHkAR9zwOEivwpM/OQIQvcoq/IfJ5aUXSI4oKrlJJtVUNt+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPtDhu2ar+vR3t0fDyH88n6nD/SsY+FFSxhJp/ZgWPY=;
 b=LOEukIaBzaq/l1ZCiAu1L6auDToYSppOLYcs3w3gyb1kBKNWPlA3YX/1Yd9ZWoTScvO4qnlDZtN0g8VSOgqOal7rLbIzDx9jzw5MkSbFE88hjmhU5OxcV1ZgOg+eVGNxwnD2Lj2LVHw236WC/miZdkIRDIzEriBl8JyTRI0HRc4SXk2oPaKwqUzMJVm6lHzB99Q5F7dC0yuhe4YVjZaZuJKRzo8VjvhNfL15cETjdNx6WtWuzjh5zfeby9l2DtvEWOF5UGymOGlIP+rhF/ubEVWz2Q/dFP6j4D4HeCIgk+gIHC0DbW8930sSc2Hx6pfTaz8uNjhAmp398NJ6Z0tv1w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4457.namprd20.prod.outlook.com (2603:10b6:510:13d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 02:45:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Tue, 16 May 2023
 02:45:30 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH 2/2] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Tue, 16 May 2023 10:37:14 +0800
Message-ID: <IA1PR20MB4953DF5B158C820D61D48CD6BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516023714.306240-1-inochiama@outlook.com>
References: <20230516023714.306240-1-inochiama@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [T7sDNuKx8UdW7Q6dIlzUjkvNga96UzILPDeaGBU5bnw=]
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230516023714.306240-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: e535d8f1-e53d-4ce6-6595-08db55b79cab
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nBJnOPH7CaP3sGjdDm6sgkhlmKtkRoFjduMTDi/LON24H5VvH+IWKaQUtth4UAZMWIR3Jfy3LnoDsIGYU/UvdTWygNn3DrCZ/0RaY5yiSrt+WfBOGHs0tfCfrpxqVFhqLs6JrY/62QohM2q73bZu5oBtcLZy3ZVYVna5AusSQ+po0QZyokGI76wgAV2yVgmfVXM5XHkwhmmzbZnVT1w0J/EHjaFKgcf2QqOO73OMu/nCNU/BOmTQ/dXCdWQuK/ORIWwiXrLTpOJ8NH4xYT+wLvxW2j54RmVxYfxM2W3mu4XbKMFf9rCA6DJ8mQQ2i+bszgbtp0P/peCoAz2zc8sapuDsbUJjS2yJe64E4TqBly+wZ0DQv1e1I62tgOmidTTr32i/Img6SfhoK8DJKSn4MToQbJE0gWlQQipBFA4GVkbSYThH7kiaV88TOC+bUcb8vda6KXM4+u2s9pfXvEbuFK1rr7lOEBIWiS+3FHRBk/bUG7+z5QvD4v25MsIKIB9+zv96H9ltOLQeOWXr9z8vN0NuDetJJXBIFo1AJVkYi6RJty8XnzB76aUQmdg6sLlhowcY+bozkzxt/ro9yRmPHv5DaYbSdEDFccu/ihSrZJ+TlwflHzf7K1kupWHHmYpI1WfiMPBxxBCBMRxfqZEUsUORuYJIFmtJaowNnPoirZamogJVD96PHAs4Cq2h/bB2gCvu6H246bKZdVnH2KdeKV0SOGNmj7ormHRAOMEcC7r4QmK/Ih4yRNvACfqHfOzd2CQ7HRJvm4BYadMvHvJfO3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIt+Dqu7L0DAz7zNW4vRlP2/U609PEIG4rFSkbxwoKMs12EDTQlCi2tcFphdHGWchXF84H2+SabFnxgeXTFvQeZyNlk5Iy922o+wXN67VMGvXfeP1iHJXn8zxGjw7qRwt9GZFyrn6kiqHFlq4G8uzp9oLNKRCR7Zz2N6k1WAUbhORNUxXAfAhVwIjHeJJmJOYoWtIywvfoFDLpiEVjT2FumY1lmHGyPGEdknqXlBAOE0Sf3+XSPSWNeC80wWy25EJXdOYGY0xAr0Zqq8G+vshY5e9EPwDgRi3f2w4IvOsPVLFfMMomO+w7p20V5WK9KclCA6LfVt8zkBafrND0hwPel8vdpEWKsrXLvGEhFUj5Svw/Zt9wYbTVfu9ehxrCqGLev8YYmgxBD/lf/JNWuYBBy9dTjoR/EozkXIPqc+VKU5snZfL1/dddV1/pTN6pxawxC7MT3h4Z+btZGGzHY7V7qtycU7BNjh+dJqmvRPpSmzlbhwAwMHud3oDwkGYLqJDTRPPFilmWCCoIXCm00vcRhc5OjhDFEbRSlbCgZltKesMS69XsUxph1IRLq3U5Hkn9HyjsWPL1gCvr9tHtZoie/sULI3gpfAepr4pEj+RG9EBGsA9+CxftFlfl9H4uCy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RvmpsfgqmKtQkTxb/8qFhIOso9j3+lS8hXXj9+1qD8rKY6A4jtRzACpCdaDj?=
 =?us-ascii?Q?Gr8aKRI/t4Bhdjiv2nhHx+79rn/6I+UVltdXZMoHCqpP/29i7vb2SO5qEiLO?=
 =?us-ascii?Q?PDTDmQh7Y1ajDSQsy293SeXMhdYuJOVis9HypsEJagXiX7S7XGePWlU1uGhR?=
 =?us-ascii?Q?wiTq0sbIu/uJVqWtGjauu6wpGQ9HpnwhycsuUdfYqGRBLq+lg5Y4oJdHxK8s?=
 =?us-ascii?Q?K1hMZOhlJLV4Qnah+P8wY5N90eRnL4nvDu4TJyS/uBg002OU5aKD7BuCe43w?=
 =?us-ascii?Q?sEhYdKCTLGM0DWCEQUgCfMzrMT6AR3jZ05qwBbN8HlTkTQsJeJvyKvPgcZJp?=
 =?us-ascii?Q?svXcK6DMtUAptPw+6sCYD02coGFeBwsXs3AQhX4q3x70KsNTxdl+XWSaAEr+?=
 =?us-ascii?Q?tavCDzNud1VU/exVlOtUFr3wK1oP3SP7dboO0JxjyUNduH4Op9nZWULX2Eg3?=
 =?us-ascii?Q?aM/R4+r+sP4VMjHFbXq02OYqaqHpWaWyGXEElqOFwhmPLPkzTmz8zP+gfE9j?=
 =?us-ascii?Q?WoIWIcv79SJu3nK0QoS1OrjlyQlxjT2LK1dDYR1Fpcc0JJAIGK86fdZWEug3?=
 =?us-ascii?Q?VokYbqtQzi+6ycm9jgSwae/sXXU/k0DhaHhbmMFVUtFxV6NCVqpszT9jxo+E?=
 =?us-ascii?Q?ojZD7RgRY54IGBOesnEQpBzhlCDFiWVEc3liKSv0S5t/X25Se3INOsw+w2tn?=
 =?us-ascii?Q?v5gQ/jCYZrdk2TXj0MZqaS+oJ7u5zec5iHz7Lc8GSYcVgeRjEkhYnvEddrA5?=
 =?us-ascii?Q?g8v6JzsG0vwic4l3A8dU4dpqWD0VqI4+tst7bf36q5SfeTwXXaolSai2nVx6?=
 =?us-ascii?Q?lNzHMkE/l66Z/M8GkT32vkmqwUYJNf60D8JrEk1adv+aKkzgrUlQwHLXmp24?=
 =?us-ascii?Q?l5X3TImnCF4YOorEQ1oG//7h0bGlPL28fvunC4nqeQi6tAMWVmG3Z3F/iOp1?=
 =?us-ascii?Q?AgCLPeqXmhhLiZzXLj04ebRD/43O6Wg2yYTbnO9VVAFEpvfx4d0EIsXvbUPl?=
 =?us-ascii?Q?NYBw6/i8jv5dOqVU+vntylag4JKgg9dayq4f/hYOceU4wKphY9adcOJqD/Dd?=
 =?us-ascii?Q?fjZogBfBQlFzJpL7sra673nJ98/615QZhAXI9tRaklIe/+dNrwimWpSd9NR6?=
 =?us-ascii?Q?CorHn5o5O3vhReLOhuSew5HLDSZSii0vacs5jN0Jyg3REkn1ueHImfErk2Ol?=
 =?us-ascii?Q?+vk4uaZtH90OQdy0Fp3aAl8fqPQlXGxBpL2eyjJ84keIo6Qx2Sy1yvn52T0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e535d8f1-e53d-4ce6-6595-08db55b79cab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 02:45:30.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add json file of T-HEAD C9xx events.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/t-head/c9xx/cache.json         | 67 ++++++++++++++++++
 .../arch/riscv/t-head/c9xx/firmware.json      | 68 +++++++++++++++++++
 .../arch/riscv/t-head/c9xx/instruction.json   | 22 ++++++
 .../arch/riscv/t-head/c9xx/microarch.json     | 42 ++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index c61b3d6ef616..9fbdfcdc17ad 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -15,3 +15,4 @@
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x5b7-0x0000000000000000-0x[[:xdigit:]]+,v1,t-head/c9xx,core
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
new file mode 100644
index 000000000000..2c6e9a904a11
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
@@ -0,0 +1,67 @@
+[
+  {
+    "EventName": "L1_ICACHE_ACCESS",
+    "EventCode": "0x000001",
+    "BriefDescription": "L1 instruction cache access"
+  },
+  {
+    "EventName": "L1_ICACHE_MISS",
+    "EventCode": "0x000002",
+    "BriefDescription": "L1 instruction cache miss"
+  },
+  {
+    "EventName": "INST_TLB_MISS",
+    "EventCode": "0x000003",
+    "BriefDescription": "Instruction TLB (I-UTLB) miss"
+  },
+  {
+    "EventName": "DATA_TLB_MISS",
+    "EventCode": "0x000004",
+    "BriefDescription": "Data TLB (D-UTLB) miss"
+  },
+  {
+    "EventName": "JTLB_MISS",
+    "EventCode": "0x000005",
+    "BriefDescription": "JTLB access miss"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_ACCESS",
+    "EventCode": "0x00000c",
+    "BriefDescription": "L1 data cache read access"
+  },
+  {
+    "EventName": "L1_DCACHE_READ_MISS",
+    "EventCode": "0x00000d",
+    "BriefDescription": "L1 data cache read miss"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_ACCESS",
+    "EventCode": "0x00000e",
+    "BriefDescription": "L1 data cache write access"
+  },
+  {
+    "EventName": "L1_DCACHE_WRITE_MISS",
+    "EventCode": "0x00000f",
+    "BriefDescription": "L1 data cache write miss"
+  },
+  {
+    "EventName": "L2_CACHE_READ_ACCESS",
+    "EventCode": "0x000010",
+    "BriefDescription": "L2 cache read access"
+  },
+  {
+    "EventName": "L2_CACHE_READ_MISS",
+    "EventCode": "0x000011",
+    "BriefDescription": "L2 cache read miss"
+  },
+  {
+    "EventName": "L2_CACHE_WRITE_ACCESS",
+    "EventCode": "0x000012",
+    "BriefDescription": "L2 cache write access"
+  },
+  {
+    "EventName": "L2_CACHE_WRITE_MISS",
+    "EventCode": "0x000013",
+    "BriefDescription": "L2 cache write miss"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
new file mode 100644
index 000000000000..9b4a032186a7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
@@ -0,0 +1,68 @@
+[
+  {
+    "ArchStdEvent": "FW_MISALIGNED_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_MISALIGNED_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_LOAD"
+  },
+  {
+    "ArchStdEvent": "FW_ACCESS_STORE"
+  },
+  {
+    "ArchStdEvent": "FW_ILLEGAL_INSN"
+  },
+  {
+    "ArchStdEvent": "FW_SET_TIMER"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_IPI_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
+  },
+  {
+    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
new file mode 100644
index 000000000000..53c5a9838400
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
@@ -0,0 +1,22 @@
+[
+  {
+    "EventName": "BR_COND_MIS_PRED",
+    "EventCode": "0x000006",
+    "BriefDescription": "Conditional branch mispredict"
+  },
+  {
+    "EventName": "BR_INDIRECT_MIS_PRED",
+    "EventCode": "0x000008",
+    "BriefDescription": "Indirect branch mispredict"
+  },
+  {
+    "EventName": "BR_INDIRECT_INST",
+    "EventCode": "0x000009",
+    "BriefDescription": "Indirect branch instruction"
+  },
+  {
+    "EventName": "INST_STORE",
+    "EventCode": "0x00000b",
+    "BriefDescription": "Store instruction retired"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
new file mode 100644
index 000000000000..47f94890d20f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
@@ -0,0 +1,42 @@
+[
+  {
+    "EventName": "LSU_SPEC_FAIL",
+    "EventCode": "0x00000a",
+    "BriefDescription": "LSU Spec Fail"
+  },
+  {
+    "EventName": "RF_LAUNCH_FAIL",
+    "EventCode": "0x000014",
+    "BriefDescription": "Register file launch fail"
+  },
+  {
+    "EventName": "RF_REG_LAUNCH",
+    "EventCode": "0x000015",
+    "BriefDescription": "Register file reg launch"
+  },
+  {
+    "EventName": "RF_INSTRUCTION",
+    "EventCode": "0x000016",
+    "BriefDescription": "Register file instruction"
+  },
+  {
+    "EventName": "LSU_STALL_CROSS_4K",
+    "EventCode": "0x000017",
+    "BriefDescription": "LSU stall with cross 4K access"
+  },
+  {
+    "EventName": "LSU_STALL_OTHER",
+    "EventCode": "0x000018",
+    "BriefDescription": "LSU stall with other events"
+  },
+  {
+    "EventName": "LSU_SQ_DISCARD",
+    "EventCode": "0x000019",
+    "BriefDescription": "LSU SQ discard"
+  },
+  {
+    "EventName": "LSU_SQ_DISCARD_DATA",
+    "EventCode": "0x00001a",
+    "BriefDescription": "LSU SQ data discard"
+  }
+]
-- 
2.40.1

