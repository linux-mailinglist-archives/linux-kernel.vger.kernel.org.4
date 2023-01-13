Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B910A669D37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjAMQIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjAMQHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:07:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8B8461F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:00:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfcXpGSOeRmbpxQgKCEU9Zp6MFFKljcybHWmU6QCCdtpJP9BCDSuTQGUuPA99dDBhMHnQr7BR4VFFAhGxMa0qdym4bcc0Z+0HnxtWsmra/aeUM8ApVCEZF7QhO0BNWPtL/bCK/C2KP3dV2Q5uqvIPeN4tuU1oUreBa/J3Bg1ndUosjtUBjGraTWFzirnhMwlo1MHJwlVR5zIvFpMUELh5hso3Im3oNMDkr4p6yhIhfOXCsiebAWpSgTqpOLshYx+e8/7xFq/uCTRfc1EKSmaikFz8LRjJl0sPTt7GVnIT9gKxPF/sDbirdawLqGhTVUyTlej/EPJq7S+EC63WXjoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l0DWfM52435KQxegB+gsxncQsURCXfcffwvDRHEotg=;
 b=NV9Hjz0VJAGjBgvtqlGR4nEIkfpc8M04QYVffPZxIUKoEJgg12Gk25I7/o7+7JyNoL2E4PtM6buYhGiR/fvl0ococyvN1FvToSgobRJPcR1pTBh5YiJ0rFiknNE35WYeTJ9vm6f3dPvkolLEoSDDdarPQKwLbnG/N+u1cMyl/tS7tx4D+gqM5kdAtidnyPsKvDsI5ztGytq8QzO3gzcEQaNKMR1uWTa2+67fnx0V1Ite97e3P9eAXNJwwlgc5AIubTRGpuCGUihWVxs/c2nlCV8D43pUCXmvvqjpKxPtKYcJSUOVbJ6nVIw44kXFqB2w1k0UHhC1u1jSzZvKaUPOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.polimi.it; dmarc=pass action=none
 header.from=mail.polimi.it; dkim=pass header.d=mail.polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l0DWfM52435KQxegB+gsxncQsURCXfcffwvDRHEotg=;
 b=NKNga3AFWdt0bAtP6etf35+UPiC7PcA64b8BijFjFg31vqSjDlomB4mE79BZYgaolkWrUn6VoKjO6Dmcolg9ttGRmFPzngy3reVcMfqdegvCuJO3E6iTXMFWwDOElh34kFt2H0qSnpzkbKmjGiCK9McKtbOWYDtrotFnycH2aVaHbJsylPkkIkTC09P6UACtkbpHY0IdDhcCylrvNLA7tdD4gEGy+24xFZrOvjSBNL5sjvhQO85tsOXYi1qv3OnO6n0fwFpDi3cr9n7ZbobUnicYDxduGEeCr/qRM3968Ad+3kLyW+0/uK/uV5bLMZHX7D2FRSSsGZPB/c6KxwRVCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.polimi.it;
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6e::22)
 by PAXP251MB0604.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:275::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 16:00:36 +0000
Received: from GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d947:d8b8:8931:e689]) by GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 ([fe80::d947:d8b8:8931:e689%7]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 16:00:36 +0000
Date:   Fri, 13 Jan 2023 17:01:43 +0100 (CET)
From:   Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
To:     Mike Rapoport <rppt@kernel.org>
cc:     Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add tests for memblock_alloc_node()
Message-ID: <0c3fdce6-3180-89c6-ba9e-77b7e98a5691@mail.polimi.it>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MR1P264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::28) To GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:150:6e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXP251MB0767:EE_|PAXP251MB0604:EE_
X-MS-Office365-Filtering-Correlation-Id: fdda8e49-43e0-47c9-c33e-08daf57f4eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtrUMalBxFFTQpy/RrXcXwygsncaneWX+FDB77J0GYC2w5Vnqh7lupZJsKz9Wbg9srjzG7lYaM1+ALJIUjQlc2SMDFfNT57M7GimUCU7Qt8a1oJoPzysu7GUCu6wIJtdh2LK1RqpYtl76RFvZ9PnUvx9xshn7snrLtgYPePKNJ4S9UhoCRgD3VX2IPCR3m0H0dA1bu2uTaQ1PmaFD3EOI2/w2LFLjhQufMjnB9HPaB2YKMhdrkyb4Q7bIECgkaWHqAZ3q/gW82R+KlrKyQ44g22WWTk/J8AGFbAZqMzdL/2QmOV3jz/rlKGyVZIAyktl7Cu+BUnwGAPIjB/HvSUEjsSCWjZtkLvgng6rYBqg8pZDzBptkX0wziCO/RpsCfceWTuekiI+is3fxoG4UsOVXzsf+/ua74EZ3hr9OBmghquHppgkSC8VLei797Xwl8/ZRbGfr26Ouq2BgjKw4gA0e30eoURhLlvqXVdCid644cWfVSGWehjKu8elqiuT3W31GepLkFpOIE5qwQcrmeBmisRGObZdfc8irT+GhMha6fuK+HhRS5XacS6mE069ALCkypjUMf3l4AFXZ23Z0omxg7PSSCvXHYhHBvuMJdey2eR4CVEU792MXtUBNc9oOhWSCv1/TTWK+1ed/RNvS6O1hY4fHP2CNdfkoki1RWDrJiINqRqxRmnAM2lKY7BkY2W+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP251MB0767.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(6506007)(26005)(186003)(6666004)(6512007)(478600001)(6486002)(38100700002)(31696002)(86362001)(83380400001)(2616005)(41320700001)(44832011)(8936002)(5660300002)(31686004)(2906002)(66946007)(66556008)(316002)(4326008)(66476007)(8676002)(786003)(6916009)(54906003)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TBdxJTkCnsWJThdco4IRob+9CW4GeNevbkIwPbzEjtXZgqlRpYlZRcxPkbpq?=
 =?us-ascii?Q?KH/OwYTDwdy/+vfELfNsJHs4dl+RAGBQnOsacY4kDv0bgNk1MeRBoYyt8AcP?=
 =?us-ascii?Q?Y34swJb+/umYrutcKR1Bv3ffUiT3kBZXaPbkvqr8XiFduAm7IaUw/qdAO6C/?=
 =?us-ascii?Q?JLN8raWCKYt6D6ETqRw0Qu/dW55XUSLeJgRHjDIynDxwAC3OSM9S55WxGkeG?=
 =?us-ascii?Q?TVEfQzU0DvFkN/a9fGOlZ8cXM0A4T+Xae57l4Qu3WW9T76pUuqk3vGSJoOcn?=
 =?us-ascii?Q?EoxE0HMASbCriROGFmVuQtrKuCIUB4RsEbCJrL1knNxJbLm8K9JbJvm0pf19?=
 =?us-ascii?Q?5/y8BMkZ3aoj0ggQrszCj9+iNtynicSvNAmDHKurfL9EOzaDTZIEz1NbELLO?=
 =?us-ascii?Q?JAFtjcsGxXs5ESuAeOT2JQVhdop3q2c1JVRKmrK2jbCBCFmTiObidYdq/bbG?=
 =?us-ascii?Q?qNGDcMOBrCyabm7rgcuf5/LQBu/iv9s7J2TcCVuAFqF4npqH7lFranDHXKNY?=
 =?us-ascii?Q?gfIDEhmc2PUg76qnveCNyGsbQRir2wYgmTUBkro3JSCgEfXB8PX4F79QaHhk?=
 =?us-ascii?Q?k1Yj91rCvtMX56huHKH91/ON14JOpDQzTmLP4dS7XwnHe+CuG0k0f3HniFhK?=
 =?us-ascii?Q?h6p8TcyotGwHCwVXmJlc2W9WGinI1ItEj4/H0uIgiXdkd5pjr0tJrDWCdWs5?=
 =?us-ascii?Q?3MZhaZ4w9xLzGY7Nj18KshTVJr0hkXDealZIxoi3a+yLipKs7mCHE9EARDbz?=
 =?us-ascii?Q?+Qg9irt4Ghm0jInnzouQ/HkPuLgbJ5rhoqnIFDjsKBCA6377Mpzv/Qhx4XrA?=
 =?us-ascii?Q?zYVYOjehFg1XlwQ2ARrBY90IM/Fne4S2jlEFGGjYJ+X6St2jxQRYJmzJpq++?=
 =?us-ascii?Q?1K11In1FPH71YxN1LiqnnImQB4oPzm3+5N7NPHZZ6Nm3qgqm0Msty5d+6734?=
 =?us-ascii?Q?Y5aASZ/VWdsYIHBLn5B4Nh0MbuK4jvmPJ8ZLwNrfTfK2s8fPk4mw4zctBolF?=
 =?us-ascii?Q?XAs0/KEKNB2lnQ/GtMTfIn3f531l+99gh3NmE7hmsg1/T/K5vDeLBpu/mw5X?=
 =?us-ascii?Q?l4uzq5vgF5LDJ89hD7DdabXODSlq2HhHqzogKSL1v4rOqAs7DvymhYWhqVTk?=
 =?us-ascii?Q?8eJmjmW6Fuy2HlKaN6D4xekDgwaFlR+nkID/1P0R5slnltB0x/30svc6Gpm1?=
 =?us-ascii?Q?DTlKFrkyFEyK3q45f4lpiDZ7eu4GFo4wW1eKaYQlFpvxEjW6gutD/1bCOppX?=
 =?us-ascii?Q?R9utphGi/eZ+mPVzdVEwNGFb4h4fvgPcEe7lHU/HYcla6IT4l5OkPKu8EMLJ?=
 =?us-ascii?Q?nWI8pLkaFpRgBiBrEmYnt+IW778p9jIAVX3RqBkoOKKxIACR0xsiWrhsxkzz?=
 =?us-ascii?Q?wZ4JlQX7lAr/qLB+sdDKqemcnnay8JF4FW8195rIvpg0ToPbECvg7RiPXa3I?=
 =?us-ascii?Q?MneiEOYsh+hSXbzfcsLkBmXRL4xgZp9QEnI9FiJICswfTjNmmVB/568DTiaK?=
 =?us-ascii?Q?QtuBbsYNXBXgwmzS3QeC0pTAg4ZQNeQK7g5ssmxBYrqFuGwygqr8MyYODBXN?=
 =?us-ascii?Q?CJcFoeISDmkLbxljV1QoG8TkEjuODz7Sc2Wpm128?=
X-OriginatorOrg: mail.polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: fdda8e49-43e0-47c9-c33e-08daf57f4eb9
X-MS-Exchange-CrossTenant-AuthSource: GVXP251MB0767.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 16:00:35.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCy+SKvvHmABu9OTloQYqG4vWck2MvYbI/Rck7HznMqqdAwzcSuAxrvdxMxZzh96hmohBkMGVuJogghxuD73QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0604
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tests are aimed at verifying the memblock_alloc_node() to work as expected, so setting the
correct NUMA node for the new allocated region. The memblock_alloc_node() is mimicked by executing
the already implemented test function run_memblock_alloc_try_nid() and by setting the flags used
internally by the memblock_alloc_node(). The core check is between the requested NUMA node and the
`nid` field inside the memblock_region structure. These two are supposed to be equal in order for
the test to succeed.

Signed-off-by: Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>
---
  tools/testing/memblock/tests/alloc_nid_api.c | 43 ++++++++++++++++++++
  1 file changed, 43 insertions(+)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 2c2d60f4e3e3..9183e2219c5c 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -2483,6 +2483,40 @@ static int alloc_try_nid_numa_split_all_reserved_generic_check(void)
  	return 0;
  }

+/*
+ * A test that tries to allocate a memory region through the
+ * memblock_alloc_node() on a NUMA node with id `nid`. The call to the
+ * memblock_alloc_node() is mimicked using the run_memblock_alloc_try_nid()
+ * with appropriate flags, the same used internally by the memblock_alloc_node().
+ * Expected to have the correct NUMA node set for the new region.
+ */
+static int alloc_node_on_correct_nid_simple_check(void)
+{
+	int nid_req = 2;
+	void *allocated_ptr = NULL;
+#ifdef CONFIG_NUMA
+	struct memblock_region *req_node = &memblock.memory.regions[nid_req];
+#endif
+	phys_addr_t size = SZ_512;
+
+	PREFIX_PUSH();
+	setup_numa_memblock(node_fractions);
+
+	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
+						   MEMBLOCK_LOW_LIMIT, MEMBLOCK_ALLOC_ACCESSIBLE,
+						   nid_req);
+
+	ASSERT_NE(allocated_ptr, NULL);
+	assert_mem_content(allocated_ptr, size, alloc_nid_test_flags);
+#ifdef CONFIG_NUMA
+	ASSERT_EQ(nid_req, req_node->nid);
+#endif
+
+	test_pass_pop();
+
+	return 0;
+}
+
  /* Test case wrappers for NUMA tests */
  static int alloc_try_nid_numa_simple_check(void)
  {
@@ -2621,6 +2655,14 @@ static int alloc_try_nid_numa_split_all_reserved_check(void)
  	return 0;
  }

+static int alloc_try_nid_numa_correct_node_simple_check(void)
+{
+	test_print("\tRunning %s...\n", __func__);
+	alloc_node_on_correct_nid_simple_check();
+
+	return 0;
+}
+
  int __memblock_alloc_nid_numa_checks(void)
  {
  	test_print("Running %s NUMA tests...\n",
@@ -2640,6 +2682,7 @@ int __memblock_alloc_nid_numa_checks(void)
  	alloc_try_nid_numa_large_region_check();
  	alloc_try_nid_numa_reserved_full_merge_check();
  	alloc_try_nid_numa_split_all_reserved_check();
+	alloc_try_nid_numa_correct_node_simple_check();

  	return 0;
  }
-- 
2.39.0

