Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC211635A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiKWKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiKWKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:32:54 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE22911E73B;
        Wed, 23 Nov 2022 02:18:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2OfHdMXlOluaakNISgzrgMeysvcmWC9IG2GkF8an5VnlsqhyhEnOvOJUaxTkp83nS6FpGsWkfRezNthyZnWsaUDLbvy34i/6Od2DLS6mDhOdqqErRQO9F/JwJmpUOtAEe+6ivgHH7VBwE+TDOazWFhN9i4PkF0X7qYO2hBTEKtIUCmnxTH1J1eggd4Bl3GRa5xHGEDg8BH6fCKFVt2cLw1SwIMnGtiB/g6sgYDezIZjs09AApRFv3dBvRnjP3E3+mt5xZkAfoE5z+P6LEt9tr3BkU5m99yAHL6xaIhheDEtNk1LqGozWHwY4KT4RukXujPUzNbFaGj5LYJBpw5uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X95XEb9t0r3waZtyzYMPr4A5TWFVo3IycR/SSeqhlA=;
 b=fVHLVZGGwtdx6yoaweb6tLiinDFhf4mazX7KT7GuM64zji/JWAO4Mic4Tl23F7wGIZHx8ZvlTphMdpBxdog7fFDbW8w5Yvjzc4o8W3LpkzBEL1P1d2oyayYnmPFYa5yQb7Hrdc2ajLHxsgFQb+QlWKlqGIHDcKPpZv2HJaBJIybmLdtNuxV4Bve0ifbhyuYaXC+IAukh6bS+y4jN6QSF7ttlNXqMNCsq9hkFgavwxqluDTk6pfxYC5SQbnZLMdvbK6aXSrAU474K5ii599/wruz0Coi+c68lKsBOzFTUh1OXMoAnbTXuGf/on0DRsx+23ty4D3rBM9XOz/GuK2GM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X95XEb9t0r3waZtyzYMPr4A5TWFVo3IycR/SSeqhlA=;
 b=lGtLE8Lns7NO6VR0vJs0AgB8/OaV0eOJqDd0W1w1gD9PjrTZLZ6+U7enULarJSNWhxUh4M3tI7zBB9zNodppvIfHGYNav8MUBiidayA2Y9/kD/zWsw490Q7OytvAaxRkXbPFDD2bUZ5m2ack7mHKpAA6L3aib3UQMtpc2elKT1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DM6PR05MB4091.namprd05.prod.outlook.com (2603:10b6:5:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.17; Wed, 23 Nov
 2022 10:18:36 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b8fd:e1ff:e5ac:e70c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b8fd:e1ff:e5ac:e70c%8]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 10:18:36 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, rostedt@goodmis.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        srivatsab@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, akaher@vmware.com
Subject: [PATCH] perf symbol: correction while adjusting symbol
Date:   Wed, 23 Nov 2022 15:48:16 +0530
Message-Id: <1669198696-50547-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|DM6PR05MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe21969-6928-43f8-c1f9-08dacd3c14e9
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmFSzOq5jlaMrLNbJl6OvC2IetnyWGrgJkhcmytRJbGfOMA/yUraJyuvylm8sdM6T2DtVlaOoZpO5ftU328tv1KoJ2HP5LI66vaVsaIuJ2ZPTYm8wEfWLKkNfG2rRvUidbVbp9MH6gKhSxXJ1fqafNul49fypFaYQ38jWnOsA/9xivqgF1jZdqAqMQU3nxvanNdPmZzMw9w7mc2Bow2DvUEhdzk9SJjKuOdvx7h81B65mJGAjgHdyU9cZR6hYfn+wQkpsologB7R6ry3eFrBG9+8Dk29tvvOl99rNIKQAtGRCTUdq4PnAyJWuNLo/XQi8ZK9TWWMxzSwUxeK1kA1g0g5foIe6VfO29HFF0u7Dsw+6Mb+1stEL162vEQDb5ba4P1mbq8plnNW4XEIM13Q4sAxvFCuiOz98Q7PDAQ6sOrYn0FZjca17jvwgbyIXgXoGhSbS5/Gpy3KlcVo8KSBHFykX4Ke4I7ttmch5s9Ad13L3vruCf227ONi5WT1u+OZrmz/Agd/qB7O1naeWhTbb9zoe6CED8zia+6zlNGQv/44VwYOQeZSxXYvjnyRYCKXUg7O3yYT8Fl5OHu9XIPsp71WlaiarRq0YyN4TT0izCetl7Jnw0b+AQr8V/+vxo9xJ+XsJoXk1BmDBDadEYeICpyhZNdXiMxEMWLXWqep0CMTbrv/SiScn9Fdn8b71OWUXraCLB11Ge3IsN+BHYMGZd3TpwgTeKpptcu9XjgTdS1No8ANHnasgPlObyGwqKlJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(478600001)(52116002)(6506007)(6512007)(26005)(107886003)(38100700002)(38350700002)(36756003)(6666004)(86362001)(83380400001)(186003)(2616005)(6486002)(7416002)(5660300002)(2906002)(66476007)(8676002)(4326008)(66946007)(66556008)(316002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkL5qxrqKOdF9sserjAp4B1YToepH6KzxxnYdhQa9F9oA0fIYWLLtZonU7Vo?=
 =?us-ascii?Q?tnfFTARJflhGXMKoGeW/e5bUm6ihMFSYU7Rz9Xd3gxYVU6C1ch/hO3KH2mRr?=
 =?us-ascii?Q?TUXtDTgCtD/2WieizwCCWfIG4GWL/C1OZ/522dTR3ZCJgK44GZkOtV9cW/dJ?=
 =?us-ascii?Q?59ikWBOHo438pObcNtpgYwTjZ75ZZhXUqT40t13pLPSLMFjK1mh+2cQoE99y?=
 =?us-ascii?Q?5lS6UwUcCwejLzfAAg8meWJEBQY8ZA3tbSR3rLcsW3aYTG1vkCx0q9y2CvJ+?=
 =?us-ascii?Q?yaENqOts7DOQwNKYik5/MHHEtnS1TwBoxGkqVPHFzWqZ+Y5uFVlpA+Xhx3Ks?=
 =?us-ascii?Q?d6yuzuSBzuXmPWf4hKWdIg0t7KG7xm6v2V4Ie6Lkn7kceJuZ2W+LSSqpCQIp?=
 =?us-ascii?Q?R639GszlBXnd0CMoXhdOgAu53uHD7PTjRw/s2KLdlDChawhpTnGtVi47vPFQ?=
 =?us-ascii?Q?FqoH8MefzCQ+sSEurLKKkHKtt3nA6XunCbmeH6IcrdwvjkO9M2iuYkwRtw8/?=
 =?us-ascii?Q?2bMshaN7W/5xNlmMemnkNZmOisV7Yclb/x8s3LwWqXvCVMZ1+itcgFTZFHHk?=
 =?us-ascii?Q?eQqKK5pITdJ9XZYfA7pGiu1Ndf1f1HrrYqj/X4S1WOlprEcLVAGQgrsHhbvp?=
 =?us-ascii?Q?1isosoYss3tZKFe5KUjfv5YpmI1T3GRPst68rof2aze1oJq6vv8oc9IrUybz?=
 =?us-ascii?Q?spIdrA6dugtZjqhGZkVgNaMQeShHzSmzeQMnIKK6RaVTfpn/CMjaQw6rlHdU?=
 =?us-ascii?Q?Ulzs6VjemCloE1khmAsRGCSvUDp849acDg8jLIRDgyheGe5garpmDuJmejZH?=
 =?us-ascii?Q?hFKWzcNgooB2cBaWOcYZQzzXxC7kvkw0KEtpXag4CC7MBlRIaN6Wq204cgxH?=
 =?us-ascii?Q?rv/wAN7qnz9dVhFZRfUymMYVxV5Q6D+rz1e8qLDGmWiH0OcNVCJE7OAu2tPr?=
 =?us-ascii?Q?XqN4mXhbAklM1KkYyfw5+KNqMCkh4x2mTgG1acmKaHWb4y75YvOS5Y7uIQFD?=
 =?us-ascii?Q?ic8p48kSNJ5gefP3iWno5SCPiY1KMbyOMkOCro9D0MVvNtGD4D4RLFxDtEnf?=
 =?us-ascii?Q?N2WGFaRw0BK4TnsYtfUWPF+FiwuWQq6qIzxuHzTwC5CQqgyc5wYLYcsihpeM?=
 =?us-ascii?Q?M5wwSk1QO/IeooFCvr2PKV1DJf9oC0joxmeqSG/bAYY3AlQjeQYiBJCBTeEw?=
 =?us-ascii?Q?vLO5FbOn48P1Ds1ESssHdbtiodfmNYPXXlllqq+sY2keSgknBYot/OfBZ96t?=
 =?us-ascii?Q?Jaip9aEXSmnui1g0nkb1iFCy9qfd/HUFoOR7dGEs/lTLIq7n50EOFrYTIwH8?=
 =?us-ascii?Q?T9ccHyAZW5kD8PoyMpwwFuxxh+S2jyUpq/ZH7tRZ++ibjFdZRHZbA4Sg7POf?=
 =?us-ascii?Q?8gP+d2bqSoO56QsjwLwcEDG0DnaoZc547FDSDa22HcF7XourdyF1jygViKC7?=
 =?us-ascii?Q?gmEG/qw/8K6rekQhuDXLQa9rwtg1CwzYJlAWzAXjwdBsZBPpFVqZxzgiZEhs?=
 =?us-ascii?Q?nJFlvQ9fbDNTRHaU6be5YCENgShyL8rF8UYg5Mdm4FcV+ciACA4SK/WWMhGg?=
 =?us-ascii?Q?8WR9uquPymUVVSHGNJ+/OQ26CtPY1r8QRIKcbCzq?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe21969-6928-43f8-c1f9-08dacd3c14e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 10:18:36.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EhuY92NDlA+BYF1y9wxI7xsv3GaKHBH7o2wtAZZbGAtEi5RU3BPIppWygzQMrLABd8mb2vJ3tmH+rJnK333tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf doesn't provide proper symbol information for specially crafted
.debug files.

Sometimes .debug file may not have similar program header as runtime
ELF file. For example if we generate .debug file using objcopy
--only-keep-debug resulting file will not contain .text, .data and
other runtime sections. That means corresponding program headers will
have zero FileSiz and modified Offset.

Example: program header of text section of libxxx.so:

Type           Offset             VirtAddr           PhysAddr
               FileSiz            MemSiz              Flags  Align
LOAD        0x00000000003d3000 0x00000000003d3000 0x00000000003d3000
            0x000000000055ae80 0x000000000055ae80  R E    0x1000

Same program header after executing:
objcopy --only-keep-debug libxxx.so libxxx.so.debug

LOAD        0x0000000000001000 0x00000000003d3000 0x00000000003d3000
            0x0000000000000000 0x000000000055ae80  R E    0x1000

Offset and FileSiz have been changed. 

Following formula will not provide correct value, if program header
taken from .debug file (syms_ss):

    sym.st_value -= phdr.p_vaddr - phdr.p_offset;

Correct program header information is located inside runtime ELF
file (runtime_ss).

Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
Signed-off-by: Ajay Kaher <akaher@vmware.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5fba57c..8dde436 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1129,7 +1129,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			   (!used_opd && syms_ss->adjust_symbols)) {
 			GElf_Phdr phdr;
 
-			if (elf_read_program_header(syms_ss->elf,
+			if (elf_read_program_header(runtime_ss->elf,
 						    (u64)sym.st_value, &phdr)) {
 				pr_warning("%s: failed to find program header for "
 					   "symbol: %s st_value: %#" PRIx64 "\n",
-- 
2.7.4

