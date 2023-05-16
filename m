Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0D70498C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjEPJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjEPJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:41:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2049.outbound.protection.outlook.com [40.92.40.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE8A269F;
        Tue, 16 May 2023 02:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbwsrc/6XDPvnqSi+sLC/q5d77K3SaZrL0AbFOc8qE30ZBMfuaP8k0QEjc7OUkD6Jry/CJgzGGXxk8Am3mH3ArJbF9hGAwwKXnSli0yL94hTlU+004MBroNkdUJdllduanx5uG58UZuY3ZGuhLlhCzxmoZTZuUVMnBZ+/IVnLYuu/fSVtgDt1N4PnYS/l5ALd0Ls3zQ/t/ctm6faIiK6TcGw/3MVRVS2RZHhY871PNwnIKL8xc8BUJrleoNbZJFvyKwZVnGolv3AeIV+/P9AEKbH59cN9xby012nuKKq3FQByTkntGXS3R4ujEG42/HTe8egsltzLq1aNRd4+eAv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4HZ2MjMokj3AFs2fMHt7XQF2uQ6RX1AW/3Q0vl2xyo=;
 b=GinIJF53NzLb0l2ITcJK6b/EQZQ/ETd6rRcaHxAi6oISz5nzHSvpD83EyGW68LF5gucZwjms62XP6MpAyQdtKCR82g3dJDUaNcxTrzqvkdXkpusGRI5H2HEvznNsIlN9SvT/E8ikutDbNfChl9Eu8XJqp17LPsmuSo2m3YVyh5Nt6DdzZ6k6hOlkKGVR2hcT7BfgUMOCrQZ+stWh3kKSaZZhSLwfEvs8h46c7gglVe0t0FNMJJjdtaBnvIwiM9Cda2MqYgs/qDHGjHtdL52a+4cgt6KVcH96D+tnDLLNzKBgdsKzQuE7qglQafijwcX75e7ReOzyq4WlBChp4C9+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4HZ2MjMokj3AFs2fMHt7XQF2uQ6RX1AW/3Q0vl2xyo=;
 b=mw7quqMEeMzdewClrSiLwgesLbjq1pGaRRSKVwoEOVUV0r/ox/HmnSOd9rrQ1bPpnyg6BsUQ7ARworI7YLAJ8xndOuGfI9pYCG4Jb3n6acxo2KXnqTG8OBuUfrvHuQMnBTReBBMktlGdQkZvHsvxwmVrUd6yGmX4k0wwJG4s1SucLegV9tIZqim2eOEYO02H1r/bddoMiTjZQ4AiGVScvmiTWQM5UEOJyKklc/Mbmg4drgR+yXK3uNH56LTKWvHOSFJhg67jIsazgwj64x1+lDmyiyhV4k0b+apT09jqbGntN2PiGdPLZcPQL2Au4UOh9nAIYPlgorqITYq2rUdAuA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5331.namprd20.prod.outlook.com (2603:10b6:510:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:41:39 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::4770:9e0f:7f59:1989%6]) with mapi id 15.20.6387.021; Tue, 16 May 2023
 09:41:39 +0000
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
Subject: Re: [PATCH 0/2] perf: add T-HEAD C9xx series cpu support
Date:   Tue, 16 May 2023 17:42:41 +0800
Message-ID: <IA1PR20MB4953ABF862B937CC98E300B4BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df1ffa574ca014cf5e23b3482efc5a7f432948af.camel@maquefel.me>
References: <df1ffa574ca014cf5e23b3482efc5a7f432948af.camel@maquefel.me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cVJDXY5CP+dOiB4tMunGNqJXnT0AX1/SO3hI5nljpqw=]
X-ClientProxiedBy: TYCPR01CA0169.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230516094241.479673-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1e97de-3557-4f08-e48b-08db55f1bf90
X-MS-Exchange-SLBlob-MailProps: V85gaVfRD48pZMVLM19SXxGmTzdWqu7HTyHI52ikUKBkr0JYQYx9y6r62xF/YJw/aNWUn5mGKOKAT+4ieqJVNVJAK7beI7OhuTjKrmXoZfQJkSX7Fqz7o2pnwwEt+QbuEcvfHDWL9phk5R0iWIjaVKgHE/JoJp+OTVr8GOCZz44gOc1kudjH3SOe0c255cLyMeNWya5SWqAFrsGzDsz8Vn7K/nZftkdtoNE6oDnUA1+CFCpwKnEXQHqf5oolw7mcqCgvTNHJePKXI7vvEWGotlpDLy/bZXyvEGNBTGeIWpnyd1ehH9xKMElYG8FAierx+HIlgVjt/SU150Sho6TBBVeWTcsxbX22B6B2SKGhSwUOCw9eKRaLX9gOwiMppa4ycQ5rkMa0bKtHWpQs3hxzjiWi4EKkDK7xkd//y0joZonjwn4NpCMghfN/PmtihttuNy46XksyacGBYyvhgKgRpqq0PRx7KxVj0H8T54IP91nBWpHplPoCY5lDkrLpNYpY2bx/FAvFqfYfaB7UEEUmug0tbAruApfYOQDkEiMA/gNzjvrwHH+114hBJYv75BDYgbfKvKEcxNp62OVhAfDI2tsD7YzmEyIU0wb7XIvcj4KlQr8XI91qz1AojEAze04f7B/XSbYIGuEvFDwuQymF/wN/6Tiroc0UPhcjGYOcNEmDNuFD0yzZ06kBlFA+W5pKk7gcCua+5k+rOcBuyTV/edcFzqOyXHI1rAMS3msRm1F8HjppVYP6cimt05daRSNzhBPGdjD285J1WzgeZZ20vopi+ZDm0lDENHyFfIGvJ0ErSJQdNHkakBbnd0mPC8LEPEaJj+25zYg4oRc9J5QS5g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmI06LfpNlBC2aExdoEY0y6aQjLNnKFJJ7qXFln6AM2D3H5/AEqy73DCKDDTAbT0oZwMXTW0qM8B7JvRKtS5LEuMTVy+6W08V/ctcjOYQGtUhcbxhWx+ifMQLhNpoZeq3ryRtNoXk4aHE3TTznZoShcNP7iNPE1dv/LPEL2PBwMyq2GIyoHo5p+oJdVdtPvrRCQjP6SilYullrlEXeQ72MPQTOFkSOKtq+hBUPMCtV/P1kf/CvijecUCvGoZzzG1+A6VyVOzGazkp1Q1j2gej+E2kYl7eLFBZUmp4ofJDw7siK8k0f9aY2EbdoqNNFZqJpl6jiNMC36/OmnaUf7LBWEiTtsJ0/duAczvVG+l0lKnV3jC3KQvmryu70Lg1xuzam1/QJd9t19y+0RWcUedlnEku2J3tHyx9qa3Mw7NT0AeHqE69S/m9UkRzHvC9ak4sDrQ+bTude+bYMeGg+X3Cgz1YIpnF8sQjQj4T4FrzpBKOTT5kONl7Q/qvfEFgrlYI4fJTj547wNiDmXonECFYpOTk75YXm5oxmXaD31lViMjf0roHIxlsfR3TSRcOzadityLGh/8wzrPa2O0Qsjxf9dZCw/WhX6ymFRH3YnhsTx+YF+T2svQpkhcSoMNdAJHjXldA0q0T8IX8vCzADzncw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDLMh5tQS//lI0k9AsmlWUsACw9stZDFQ9HYwGR2NbbyXjAaHT2GUE96uNGQ?=
 =?us-ascii?Q?27zbAKCjZ+rb/NmNMrrSxfg5zZkDE+O51fx0OfELzQENMPdpu5Rf9PG8pFAI?=
 =?us-ascii?Q?nsUijLYPi1GbKoHvLkgxlcsa0NKRlwS+IFMEqjOPBTbFm37zogLs4NmNSuAN?=
 =?us-ascii?Q?DNbnhcjOR+xlXdyOx6FCeOkFlUqgeR9dhzGZOI0q4ECixvU7xK1wp2Q0cHMO?=
 =?us-ascii?Q?/aZiarKuZDH00uQuKXI+1XIPZWKSRKbZkm8+l5hQb/fY63Wnfp0OqBsAgz8r?=
 =?us-ascii?Q?KzEE0COi4Pqhc69r5taDrkhpqXkR116nmwCTDhFSfdUviMmHqRkGJZ6cpT9l?=
 =?us-ascii?Q?65ATqLz7RM7Hok0Rl/aEnb9OehTheGtLGLULnJpo/EAWH6UAtgy44IM9QE4C?=
 =?us-ascii?Q?DjVQaCd1syK0uej+P3HNezM256yx85eZ8k98i0LHWa3On3m82UPox+CuaI53?=
 =?us-ascii?Q?Rpb+EIMXs+Z72T2vvs+Nb7ZEGJNV3NwCYRP6go3aF+dyE82DftO6iW/PcSSI?=
 =?us-ascii?Q?rt5uH5YctPDWW96u6XovAKHkEJ6mA6bMq4malgCuDreQNDXuKPkgMklFyEdX?=
 =?us-ascii?Q?riBNeIcWzvPmO7pTiqb065a6TEOsJLz26SdbI6y0jwdRgFMdzqpZd429ZVfs?=
 =?us-ascii?Q?zFXNh6iSAI4nq2rFGzG5nzM6AEGfamkI3MJY2hz21CUoO5AE4zbICApGceJi?=
 =?us-ascii?Q?pYRiWPpg3fJVLigSFBsmnB/gRWVhQjLgIw/y7QbUJExKF60bHWJmmncqJZUH?=
 =?us-ascii?Q?Pie4wU5JwTgqhdxMSR6GGMTMRh4FHYyOTDvlhjCyntiWXIeCCBS3eZCJ9QLS?=
 =?us-ascii?Q?DmSOLOLAclzSKoLu7Ig93MIhCpKtb556nnsgVc5K5iJQuuNZPkG4qv9XTjOl?=
 =?us-ascii?Q?nUGwTkhDO8Depf10Tqh66mHAVSrzIb/ab8pL7teavcLUjCcxaLWmhMeJJl8+?=
 =?us-ascii?Q?hZbdlk6AiX/COLVAWhVyRHlHjcKJIy5KpG0a3DL9e3qdxeyRV+PauVTcHDFd?=
 =?us-ascii?Q?P8Oh/C0I/MN3efIklvnM6oBpJmZDU5/uweV3Pgj1ze9YAnXdGtBTr1YO/Hg0?=
 =?us-ascii?Q?8G/zRi1Y0Z5fGlSe6GrEooSN5r5aBM8s5d94d2tVW8G9YAIDk4KpS1HKCsP8?=
 =?us-ascii?Q?M5nePePuWfkQp3ifDc/zx7YUTLR41UafhXIvt+tv9LYMZfLzXw2j4ngTlWTz?=
 =?us-ascii?Q?HIKl/9AqLVXXIGuV84wSlij87nZMtrJkghQ6B2nbiUoJaJnIbRx0wy+V3KA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1e97de-3557-4f08-e48b-08db55f1bf90
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:41:39.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A minimal example for C910 is as follows, I have test this on a C920 chip.

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
		/* mhpmevent9: Conditional Branch Instruction Counter */
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


> Hello Inochi Amaoto!
>
> Thank you for your series!
>
> Could you also provide HPM device tree bindings which were used in
> OpenSBI for testing in cover letter ?
>
> On Tue, 2023-05-16 at 10:37 +0800, Inochi Amaoto wrote:
> > The T-HEAD C9xx series cpu is a series of riscv CPU IP. As this IP
> > was
> > proposed before the current riscv event standard. It has a non-
> > standard
> > events encoding for perf events and unimplemented MARCH and MIMP CSR.
> > This patch add these events to support C9xx cpus.
> >
> > AFAIK, at least the following chips used C9xx cpu.
> >
> > * Allwinner D1 (C906)
> > * T-HEAD th1520 (C910)
> > * Sophgo mango (C920)
> >
> > Inochi Amaoto (2):
> >   perf tools riscv: Allow get_cpuid return empty MARCH and MIMP
> >   perf vendor events riscv: add T-HEAD C9xx JSON file
> >
> >  tools/perf/arch/riscv/util/header.c           |  7 +-
> >  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
> >  .../arch/riscv/t-head/c9xx/cache.json         | 67
> > ++++++++++++++++++
> >  .../arch/riscv/t-head/c9xx/firmware.json      | 68
> > +++++++++++++++++++
> >  .../arch/riscv/t-head/c9xx/instruction.json   | 22 ++++++
> >  .../arch/riscv/t-head/c9xx/microarch.json     | 42 ++++++++++++
> >  6 files changed, 201 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> > head/c9xx/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> > head/c9xx/firmware.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> > head/c9xx/instruction.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> > head/c9xx/microarch.json
> >
> > --
> > 2.40.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
