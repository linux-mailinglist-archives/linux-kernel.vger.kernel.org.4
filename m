Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE57705F27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEQFTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEQFTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:19:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2048.outbound.protection.outlook.com [40.92.40.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C393A8D;
        Tue, 16 May 2023 22:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntTJkNRLIbBDkPYeg7DGrDLm3iTAp8H6pSb/SMgobDdv56OirYeIyT158GBs1fc3/9va6xW8vrCxrneI1HeGy/OxpMZX3kfx6mTPf2TgRqyhJklPs8jSyS6clwMIySvnDfBK7xmWp8oMgbQIQ+nhq26BNBaNFA7ubtG7OFASN0LHCDgMyaD0Xq0Y3bkFcQRHDAPv4fWAy0ikNKw2wuBs0UpjpvwvWFSjHjsg6vGM+hHsobCm//wI4hbpM0f4c4WtZggo9xGdorFb1LnkglxLSHUAwnxQK+ojF+8P5bh8o6j5EZIpEHT9SQRhaIjU1t2WD0bVNHu+kZTwDKNtCU86qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TqADhO9oYkwOmAY1q5jHyD6Ty9w7rXgXwNmpKuxtDQ=;
 b=AfhfWherjw+GRX6Tajs/dIbumHTGEx1VfFvX9NJ2J5RUvAQUT76lAEVCHDP/S80rJ8Go9lPEohgjSQ1wXXW0gI68+VZfBxE+fg8WwHg8bmqQVI/1JdP0d7iDQbEcGzn6vOlptfY3jOqYmI8cfGmSMA/V1e80Tqaf8vaJ2BRrXeCvDA3gEsmhZush7zcZ3a29hrKPccpocMZ+xPUOwelgnyw0MSbPl/J0LGVoe8wj4hlAk6+a4NPR0b5FTGFfqEe8XFjIlqWpmZbtWbYHlUBFadIO8+drGyUpG+KhgYpYvqlbqPf3+nUu1QBqS7h0cmmc555b/HQX10AmQfC6BcfI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TqADhO9oYkwOmAY1q5jHyD6Ty9w7rXgXwNmpKuxtDQ=;
 b=iuCBGv7CAA5DgQ+b1r3r3z7pnVz37jMMHGxAzflcWd0+S2RL/6vog1vTlS1rddLfCsGfkT4Fx5ERk5l5/RmzjSMow0swab5hU6OfzA+TGKLl9nBbfTzoTYsAUQNXy4AGlJaC8x6ih14DT79WfUMj7uIoT3TgT4SPVf4JbHF23PfTzhzOiFTuJgGH2LqUfkJEbnmEkw7gMACeEpVDl/G5YZKi/wPE4WReS3q69sm4CiwEXGusTBycRUcDpFxQ0Q7UyHK24GIDIrlkX4fOD2ExKvq7eKr8sHR5ZiBN7nkWZofzCgiixL9KM/t/2sVnJrX3MC7snAQdDjwIH9XINVVi9w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5877.namprd20.prod.outlook.com (2603:10b6:806:34e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 05:19:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Wed, 17 May 2023
 05:19:27 +0000
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
        Nikita Shubin <n.shubin@yadro.com>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH V2] perf vendor events riscv: add T-HEAD C9xx JSON file
Date:   Wed, 17 May 2023 13:17:48 +0800
Message-ID: <IA1PR20MB49539A0A6FEB114B82A2187DBB7E9@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZcJT3OAcfHfXDl+ggfl6GRSFV//K7/kl5NyrSt7MruQ=]
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230517051748.935159-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eede85f-dcd0-4945-ba35-08db56964894
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3mlyp2+JOGVZPNsiRYtPAhIRoyZVQE0LdnNrwLLcJ687fnHpjvr7RB/i28ozUNRZFzNPFY5J4YcSM/3lqsr1k+1REfzsARU7+/zpU8tfPKHQfeKP/B4qmHTVT+DFLt3saKA52A0hDflW3Q/B+YmLqfjC5cHYBGzDgvFrLI1MPUcmyUzilGQaUVN7mLUm6wWjBh01x1vhnW2BKMPeI1eBj+HTqZSB6x8mbi8IScOg/6w5kJaShPcMuhNlmPlN5s918yxJIyuHAxbV1tcXWwTIoO9S+tmWQHUL7RpXdPXDo7jDU2VhQ+KwgEHJmTMjDKgtK9kshVnPpRWwat/gOkuBiSMx/aGb5IILdY26sU+i+wBIJ5hGHHIi/yZOVvsLs6/T0CZStK8jq7nmpPaLq36R7R3x6sKGJGfoMBZR9iwaQp5GcTf28nf6UdfimWTx9WSbJ6SU0mGSJRaJqIhraTPDzUARUnZFlgyil04j4YAeYEf6FMRFGFAcUO1P5ZroqwUUVBWeS2BIarbYg13WVv7cP8Sp6ZhQAYYPDabqKSQXVRbI+5jY/o0XZ9ipMdGJ68qH64YAIZ2JLs8Ssnqg8DWpfWEocAwTyt10QtGAAT1fdvKkWVc204MZF2xOWRePUwc53rUuKfSw0wYw0XIdF/RfnuCWObWv/iomKS7NqSSyvbE1Eg+ktr8VIK5FMhcpCzTtUun7ej7YR6/RaBIpo1ghD6Khe8/lc6TtAmAshcccuCzmpbkJQN+FW2W0Xn27F4luTdsSwZjz6j7HrJFBVB87clR
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtB3rwQOChB55MsTfXD/HCFDmOPzHtwHnnknHByapvAvwei0xFQqb34zHRROyGLHTtw3hoh3FGRbp5vew6i1YaTg4PbW7NnqGBtKDJBTrK4tsbZwP8Iv2/hYq1nZqv23kIoUZ7aFDU50nBsWPowAoW5dvfaqNK4Sba5fjrEZ/z7XP9srVXrfo5KF6zj/DPcVML7mfQySwXN+8MNYqgZfSulEq6zMyUKlAtdwimtQyOOyVkgZWb5erX14Se+i5RM+udJSkaQqy9nQyxvE5KCht7uGyB7uXzh87JJC+bzV4TKVOxzPvRL6XKNHfIDBM25XH5fSTDdYDsQZmn+KbZ5Aw5xaGAmyvShbNPnXOJj+ExjmMtwYad5/0S8DAW7ks2WuYSFIbgghiH/1RPdJ0A1VxcF5mWvQjSAgjxgeYlHGLjJIWNCYcBqMtWUtl684iVOlcCS5IXYzd5/Esy9pn2mHbJGKBy/5WqR/upfvifsbugRMiZev/4oJuqWIEoJ3ndh5PeWMzlfm4CcmD9s/rQaVNmSvIvCkHX5Qc1oAo0juDx8aLTsCyff/t/790MkUcesx4E/QCuTdLj6lO3vFcnf1Pzj62g2lU9JKce+0VMAHxsw7oxSsQ6HYTQAc9Ka2e3G4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeppHa25eLTYe568tizMddKgHOWVq+99yUYGMZ1mehHcWgTXgaiNeemk69gW?=
 =?us-ascii?Q?/0Eg4hV56nwTKe29tkTvKzogS7dlJDT5ALNNTOJT27trqLmYejPqsQb6bFl3?=
 =?us-ascii?Q?kUcuGDq1mfKKpYZdwc54UGokfW67nn0kK1WngD7A9U/AntLTazZMP4jALPAS?=
 =?us-ascii?Q?hlnOtQ+BE+vLnktkya/SsHRS4khYUOY2wfCjIaW0Se8ymUgLf5LNHBtyxvE8?=
 =?us-ascii?Q?jcMbiZndc2jlHjqFqOPBnl2Y3mLAylw/lpOy02GCbgAVhqgVXrKqiz2rGxgy?=
 =?us-ascii?Q?0klcAUNbQxB1tLE7wR9KkPfTUYOls4EUv4TeQIwCz21yV4dgl3oBYqhPDDzk?=
 =?us-ascii?Q?HBjXIxyloNK2Cqye6llXDz2BbdpqDVE+xXjLRTFdz6v+8j3GT+OH78Db4j2R?=
 =?us-ascii?Q?t+eOdtIgYgVw109OMFNRoSv9TE62hsdRyHaylaCOfMLUPE+0l1DH6GN8gJxx?=
 =?us-ascii?Q?YrnC2qmgXpihVZRUkWR5c5R6B6MdX6l195KJ/wUYDB0Sh1IsvuxyY70f7vJ0?=
 =?us-ascii?Q?WHt1Jc5fE37/wksn/zwTQ+TM+1Mcprisihy8rHuLQQiC71TypCEqUs+kD1/j?=
 =?us-ascii?Q?KoZ0eO7GSrJlSXArGCrsaVgvTWC2EaozBqv1uvITElwNIWgyTZQfd1T6ykZs?=
 =?us-ascii?Q?5aAal1MudlcKqwn/3iKDAy/sLXYW0TZkKqT4lsh4IIobCFYj8tq7/kBTJd05?=
 =?us-ascii?Q?FCnwxV5yF4ETdNuCJk0V22Ecb0Qfj0bGa3B4I37d7nZKglsVaI2BF7HMd9an?=
 =?us-ascii?Q?4lwB235N79lO8i42KRn8tmjAtxOooVWDEEOlsgldnTTGaR1mEJS/FcZzpKQW?=
 =?us-ascii?Q?FJ0HHwgXpGLo/bwLKTKtjwhogh5moyROeW/qu13n95O62jaVslDulN9pV7x0?=
 =?us-ascii?Q?gLr9S9iBuFmDjp9X6v02rRxnn8shB1OrLVlPbC24BLWowjktXUz1EmkDkdr1?=
 =?us-ascii?Q?loygRY+9RrFNtNfBvqrXJuBJI9xYrjjWticLYFyiKLtoPNUNfqtGdlK4aiiT?=
 =?us-ascii?Q?H5SBPoVs/yyRJqWV0TFPhiyqoNEbsjt606cEKpP5kvgi++MDtRLBNAQv1W1h?=
 =?us-ascii?Q?8/fVqqZkNnxzbSh9X/L8Ue9b/t8hvRX/wAM30F8xp8Alzh4noiQAV1NfOqui?=
 =?us-ascii?Q?T1umrPmPEkxerdq2xVJP5CEZmg/uNbXvWvE5W1T1PNVhHyUAcCAsN1ThR82U?=
 =?us-ascii?Q?OIfIgYruyu3UuTMhVM6OVoeaRgu3FAQ+jbW8CeCfhUaEFgAwND0SR/WG2HM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eede85f-dcd0-4945-ba35-08db56964894
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 05:19:27.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add json file of T-HEAD C9xx events.

A minimal hpm dtb node example for C910 is as follows,

pmu {
	compatible = "riscv,pmu";
	riscv,event-to-mhpmcounters =
		// event-start event-end a bitmap of all the MHPMCOUNTERx
		<0x00006 0x00006 0x00000400>,
		<0x00005 0x00005 0x00000800>,
		<0x10000 0x10000 0x00004000>,
		<0x10001 0x10001 0x00008000>,
		<0x10002 0x10002 0x00010000>,
		<0x10003 0x10003 0x00020000>,
		<0x10008 0x10008 0x00000008>,
		<0x10009 0x10009 0x00000010>,
		<0x10010 0x10010 0x00040000>,
		<0x10011 0x10011 0x00080000>,
		<0x10012 0x10012 0x00100000>,
		<0x10013 0x10013 0x00200000>,
		<0x10019 0x10019 0x00000040>,
		<0x10021 0x10021 0x00000020>;
	riscv,event-to-mhpmevent =
		// event-id event-selector
		/* mhpmevent3: L1I_READ_ACCESS */
		<0x10008 0x00000000 0x00000001>,
		/* mhpmevent4: L1I_READ_MISS */
		<0x10009 0x00000000 0x00000002>,
		/* mhpmevent5: ITLB_READ_MISS */
		<0x10021 0x00000000 0x00000003>,
		/* mhpmevent6: DTLB_READ_MISS */
		<0x10019 0x00000000 0x00000004>,
		/* mhpmevent10: PMU_HW_BRANCH_MISSES */
		<0x00006 0x00000000 0x00000008>,
		/* mhpmevent11: PMU_HW_BRANCH_INSTRUCTIONS */
		<0x00005 0x00000000 0x00000009>,
		/* mhpmevent14: L1D_READ_ACCESS */
		<0x10000 0x00000000 0x0000000c>,
		/* mhpmevent15: L1D_READ_MISS */
		<0x10001 0x00000000 0x0000000d>,
		/* mhpmevent16: L1D_WRITE_ACCESS */
		<0x10002 0x00000000 0x0000000e>,
		/* mhpmevent17: L1D_WRITE_MISS */
		<0x10003 0x00000000 0x0000000f>,
		/* mhpmevent18: LL_READ_ACCESS */
		<0x10010 0x00000000 0x00000010>,
		/* mhpmevent19: LL_READ_MISS */
		<0x10011 0x00000000 0x00000011>,
		/* mhpmevent20: LL_WRITE_ACCESS */
		<0x10012 0x00000000 0x00000012>,
		/* mhpmevent21: LL_WRITE_MISS */
		<0x10013 0x00000000 0x00000013>;
	riscv,raw-event-to-mhpmcounters =
		/* mhpmevent3: L1 ICache Access Counter */
		<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
		/* mhpmevent4: L1 ICache Miss Counter */
		<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
		/* mhpmevent5: I-UTLB Miss Counter */
		<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
		/* mhpmevent6: D-UTLB Miss Counter */
		<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
		/* mhpmevent7: JTLB Miss */
		<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
		/* mhpmevent8: Conditional Branch Mispredict */
		<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
		/* mhpmevent9: Conditional Branch Instruction Counter (reserved for c910)*/
		/* <0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>, */
		/* mhpmevent10: Indirect Branch Mispredict Counter */
		<0x00000000 0x00000008 0xffffffff 0xffffffff 0x00000400>,
		/* mhpmevent11: Indirect Branch Instruction Counter */
		<0x00000000 0x00000009 0xffffffff 0xffffffff 0x00000800>,
		/* mhpmevent12: LSU Spec Fail */
		<0x00000000 0x0000000a 0xffffffff 0xffffffff 0x00001000>,
		/* mhpmevent13: Store Instruction */
		<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
		/* mhpmevent14: L1 DCache read access Counter */
		<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
		/* mhpmevent15: L1 DCache read miss Counter */
		<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
		/* mhpmevent16: L1 DCache write access Counter */
		<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
		/* mhpmevent17: L1 DCache write access Counter */
		<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>,
		/* mhpmevent18: L2 Cache read access Counter */
		<0x00000000 0x00000010 0xffffffff 0xffffffff 0x00040000>,
		/* mhpmevent19: L2 Cache read miss Counter */
		<0x00000000 0x00000011 0xffffffff 0xffffffff 0x00080000>,
		/* mhpmevent20: L2 Cache write access Counter */
		<0x00000000 0x00000012 0xffffffff 0xffffffff 0x00100000>,
		/* mhpmevent21: L2 Cache write miss Counter */
		<0x00000000 0x00000013 0xffffffff 0xffffffff 0x00200000>,
		/* mhpmevent22: RF Launch Fail */
		<0x00000000 0x00000014 0xffffffff 0xffffffff 0x00400000>,
		/* mhpmevent23: RF Reg Launch Fail */
		<0x00000000 0x00000015 0xffffffff 0xffffffff 0x00800000>,
		/* mhpmevent24: RF Instruction */
		<0x00000000 0x00000016 0xffffffff 0xffffffff 0x01000000>,
		/* mhpmevent25: LSU Cross 4K Stall */
		<0x00000000 0x00000017 0xffffffff 0xffffffff 0x02000000>,
		/* mhpmevent26: LSU Other Stall */
		<0x00000000 0x00000018 0xffffffff 0xffffffff 0x04000000>,
		/* mhpmevent27: LSU SQ Discard */
		<0x00000000 0x00000019 0xffffffff 0xffffffff 0x08000000>,
		/* mhpmevent28: LSU SQ Data Discard */
		<0x00000000 0x0000001a 0xffffffff 0xffffffff 0x10000000>;
};

Change from v1:
1. drop patch for checking MARCH and MIMP CSR.
2. add C906 events to the total json file

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
 .../arch/riscv/t-head/c9xx/cache.json         | 67 ++++++++++++++++++
 .../arch/riscv/t-head/c9xx/firmware.json      | 68 +++++++++++++++++++
 .../arch/riscv/t-head/c9xx/instruction.json   | 67 ++++++++++++++++++
 .../arch/riscv/t-head/c9xx/microarch.json     | 67 ++++++++++++++++++
 5 files changed, 270 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index c61b3d6ef616..dd1d998a7ad6 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -15,3 +15,4 @@
 #
 #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
+0x5b7-0x0-0x0,v1,t-head/c9xx,core
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
index 000000000000..7cd064e70c82
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/instruction.json
@@ -0,0 +1,67 @@
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
+  },
+  {
+    "EventName": "INST_ALU",
+    "EventCode": "0x00001d",
+    "BriefDescription": "ALU instruction retired"
+  },
+  {
+    "EventName": "INST_LOAD_SAVE",
+    "EventCode": "0x00001e",
+    "BriefDescription": "LOAD/Store instruction retired"
+  },
+  {
+    "EventName": "INST_VECTOR",
+    "EventCode": "0x00001f",
+    "BriefDescription": "Vector instruction retired"
+  },
+  {
+    "EventName": "INST_CSR_ACCESS",
+    "EventCode": "0x000020",
+    "BriefDescription": "CSR access instruction retired"
+  },
+  {
+    "EventName": "INST_SYNC",
+    "EventCode": "0x000021",
+    "BriefDescription": "Sync instruction retired"
+  },
+  {
+    "EventName": "INST_LOAD_SAVE_UNALIGNED",
+    "EventCode": "0x000022",
+    "BriefDescription": "Load/Store unaligned access instruction retired"
+  },
+  {
+    "EventName": "INST_ENV_CALL",
+    "EventCode": "0x000025",
+    "BriefDescription": "Environment call instruction retired"
+  },
+  {
+    "EventName": "INST_LONGJUMP",
+    "EventCode": "0x000026",
+    "BriefDescription": "Long jump instruction retired (jump dist over 8MB)"
+  },
+  {
+    "EventName": "INST_FP",
+    "EventCode": "0x00002a",
+    "BriefDescription": "Float point instruction retired"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
new file mode 100644
index 000000000000..073c1d085021
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/t-head/c9xx/microarch.json
@@ -0,0 +1,67 @@
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
+  },
+  {
+    "EventName": "INT_NUMBER",
+    "EventCode": "0x000023",
+    "BriefDescription": "Interrupt number respond"
+  },
+  {
+    "EventName": "INT_OFF_CYCLE",
+    "EventCode": "0x000024",
+    "BriefDescription": "Off cycle before interrupt arbitrating"
+  },
+  {
+    "EventName": "STALLED_CYCLE_IFU",
+    "EventCode": "0x000027",
+    "BriefDescription": "Stall cycles of the instruction fetch unit"
+  },
+  {
+    "EventName": "STALLED_CYCLE_IDU",
+    "EventCode": "0x000028",
+    "BriefDescription": "Stall cycles of the instruction decoding unit and next-level pipeline unit"
+  },
+  {
+    "EventName": "STALLED_CYCLE_SYNC",
+    "EventCode": "0x000029",
+    "BriefDescription": "Stalled cycle for sync instructions (FENCE/FENCE.i/SFENCE/SYNC...)"
+  }
+]
-- 
2.40.1

