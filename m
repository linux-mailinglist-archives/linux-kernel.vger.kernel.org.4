Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2573944D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFVBMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:12:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2108.outbound.protection.outlook.com [40.107.95.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0E1BD0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf1/fbVJZlGUNBTm7bFpSZwWOI2vaOWYZZSa68lZz635y3tBCPKXrZVGHDhjJEIHoQ6yo1q2DHQxEh0P8CnOOyaoGkINdNzPu8A4LHC7MFPGqC6oTBRfc+bAirOTH+9Utb8qpS2IGiD7Lly1P2KayRVYlW24osVjJiYLjcKF6e3h3SCjclFhiPFGy9vpdbHPGVuB9rHJjf0RqCZlO3qY+G12bVl9QayNL/7KstBHxxgPbs9ubP/zSScj4jfOWYporEY/6/B8fDvyGiIT6FmMfX3fXGBJ5pyfqfN9HdJs2bG85Qcn/bL+NkIoXxG37A9K1ON4qEnUtJ+cKelEF6MDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3h5sgUK6AheJDyR3rgI+yyIwdGGN4S6ierfH2P7jhk8=;
 b=cm0L1WlB3g2hx7yaUAjpBKug7zCDLRObSSBguMGhKbYECbkXKzvUVOcwyjfT2IquwuWkCq5DFN7xV3IevQal/rouQxlPUeVcye6+h3EVE4KnSIQqAgVn4Z9pFK+cNzhiypVHV4gvjxvR9K/uwhGbftgwT76Bswu4vgAf1RAHWgplG/XzvXFnpvJahshrFLq51rV7bYmtKUzZ6GHHkhpbqrl/11Rub9fXlVwqIBeJ6XLXbmhQ8ah8IbpghCOZIidEIK4lYY9afbot58NDnA7BBMatynIHWPQMLmZobOgf9A+Yf2TRTh8wu+ch1SuzIOhDy4n9wd2eKkYP1jVohhQWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h5sgUK6AheJDyR3rgI+yyIwdGGN4S6ierfH2P7jhk8=;
 b=vYJvug8k/CMTDAu6apuR7hIuQTpw51OkBGiD0R4YIy9jsSUEZ1072RgY9b25usyhQtPvPZWFb5dUmWzjwMPBXbgbTDc2XvG61QEDX9UH8HMcVxIxSiaeN32+qJdtL70/Nz9kHzh6tl0XNglvHNgn6sG0zaEHSOHn486dO41bdIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7805.prod.exchangelabs.com (2603:10b6:8:7c::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 01:12:21 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:12:21 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf: ampere: Add support for Ampere SoC PMUs
Date:   Wed, 21 Jun 2023 18:11:37 -0700
Message-Id: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:610:b1::22) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS7PR01MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb5be99-733b-4f7d-b9c4-08db72bdbaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMBXVzDgJfanodD8zxxXvpJmULhwWpDps2aXn1JZo1k+ZxVCo4OofMtUdkY19+0Q7f82mqQtm+LMbBBYqU352Bv9fXlvzy1tqXUrnOeQaymfmCpiAPp/29PNzIrgsTfkH+7z/gnZA6o0nPTIwRnlOrzAy2EMsTi3CUY/GIMB+kpYi4iloXhulQ4bla4E595+ndoibtBFSpxlP8JZGq/ddSonqYqMCEop9iuLUwSRwX/BJ7TWCE0D58epDBNSnFhxifKppQxfvftV4WTSBoS6iqnZ4lSTFTk/+oL+giVxpqkMj56jT5uMlF7BInOWlVb5h9k0CsjoyHKavp37K6BjAwv0hPgUa2a/gT04Cmc7tBFlheIrjmZM6ngwMvCWizGsj3GhgtBZ/7reieMI44FAcqxU4F5bfQSMzuo7t4TFf5nv23ZtsaG+Txa0XB6eIw6WRVLXg0SxFD5DBp3vrJ0jr/GTno7slNpjCgLtnoo385ZNt3O7owomISoBV2JrTeKs4LRO0buJ00zmUiT53SQAmRfWotWeOR3fVEbQnixyJYBJYqHktIcQVANJsPvmuQ47Cm9Ndw5w9mexubXO8io3RucndU6uWNKVN1gJ3V56ueh2Wq2vtXCbRkGwP5kw78oy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199021)(8936002)(41300700001)(186003)(8676002)(26005)(1076003)(6506007)(2906002)(6512007)(86362001)(110136005)(66476007)(66556008)(4326008)(66946007)(6486002)(6666004)(316002)(38350700002)(38100700002)(478600001)(52116002)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3GHLZFsGVKJPEN8sdhAoTLi7gZ9eYI2wEl0ndMsR0IqaFuak9tB4fnZw/+g?=
 =?us-ascii?Q?xZBMpW+AMdrsjF0+6kENzR5lBXKXd7PPsb2GtKMkLlhH+A7ZI0ItSAKkA6Mb?=
 =?us-ascii?Q?Y4TFwJFLztPx+f8Hywpp3iyzQglp25dBX1HAUhayION0gkwIuLPCcEKvIK8/?=
 =?us-ascii?Q?JzZ7BZt7BHky4hnVNdzwGea7EwukgO1BC9o1wh4qcjC9YLgB749NgCPdPQzd?=
 =?us-ascii?Q?Uq3IidNq44/QUxkuVZp++g/iqoYUlOFkB0ZagIyadfy9aLfIEiedDMbyV9Qw?=
 =?us-ascii?Q?AYSmnPiFaOZv5mEOMufSgb/xCyxqyyj0zI8bGY5pRUavjoUzqkg3MBEDKFMw?=
 =?us-ascii?Q?hxF+4Hr7QlG4l6qThLkywBdcfHz5Kw/P497/3JI4e0YGdYbl0VbbyTIECvDy?=
 =?us-ascii?Q?smcBFY/OVlBFJkj/cbThRkiiXBjyKdI+dihEVMHbH6/ecEy5afho2E+u0DWV?=
 =?us-ascii?Q?/Nq3ptWT6YJsYHC2wJSc3MV/64lxFzDlTb5edxKqIJ0zSN6+OzxVLSvouIFJ?=
 =?us-ascii?Q?bafQaraVbkogCPSARmbeF/ZGff0BU90QUUi/FE3F6033t1wy3wLBzidHMkI9?=
 =?us-ascii?Q?SLMjASyAL/8K3iGffKGUq3EoNdWnm20ij9uj+J7mgAodi5p6nGZ6ihFNM9ZV?=
 =?us-ascii?Q?TgQ4dHwsZfRdh6ciNzc7Grzt+cXuwIs28GqHN/Ooa0rt6YDOrYxvIpgKFvTk?=
 =?us-ascii?Q?3HL0teqTxG2Vcm/kNRhV98oUa1VNg9HbSlt862iNhwZiMctG8q21XaW4ZBR9?=
 =?us-ascii?Q?OPfkk+V14vzyGONkD17IoYlRz7IfU0Tv8Fmfdd8vrYeC4c0myuWt2xazNkCP?=
 =?us-ascii?Q?br0GQDRRBfD/2vaX8/DmAzDgkZvgdKhCUfjnzxyoyPTUC7oWDFA3T6NrReT7?=
 =?us-ascii?Q?eTaXSn6EmhuOz+6IKUMipDNAUXEfg/QoOyVRJyZsBdzABiih1tvuL0CnYdDW?=
 =?us-ascii?Q?8GxmYbM4xV+xvKSGQm/aMhIb7+hlhjCgWHX4hGPjuOMFNLXnyvlL5cnyEygN?=
 =?us-ascii?Q?DgYPiuCxytVxu0ZuoiH75HbrQpzn0And2xhdb3iDUMnu1b8wjeOX9fXg2UZL?=
 =?us-ascii?Q?ncemosnPIJYE00+7pjKqIjnjhRzZeDTaB9RV1RVejlyhJRQz8bsxqA9H0L+G?=
 =?us-ascii?Q?hpkzaeX0thVKtOOBHQjJp7/z70IiaOyZIHIR6JhoSBEvPMtUQkoHl3D4qN6R?=
 =?us-ascii?Q?piFuxyH4HTyLDTTimEmQrdDOAwiZlwOMkwblYCRIQsCFpvss6JJOiWnbzzht?=
 =?us-ascii?Q?EW6PIeB9HDwJDjws8rhQ3BgO16TOQySdmQNg9xYHcv8o2Uh8uAoI+UzLZrJg?=
 =?us-ascii?Q?1hOqLegq25DOlO0mAAcFrYkjmEe2CLZxH8dYY5RXVkPdZiawJHEYDrf/DHuf?=
 =?us-ascii?Q?LC/p3w64HGVN6zJwZZRuKdCv4MK+dJpD7aHYYOGkaBZ0sgqF4FGS544FbI0M?=
 =?us-ascii?Q?eI7IfwKmEP4y+87VW7mL2JFfRHCGoSiLjVIyIHaFau6xv/ccJGzwr/iiXz2k?=
 =?us-ascii?Q?hTFNMzQx+Rqwf6uATcqPCoBI+5wSMwpclI6I8Q65AwGN0KfV2y7LjoyYs5eM?=
 =?us-ascii?Q?G8fcgBNHB5LtGHO6+hoCirWsaLMFu02xOTNK+WbEhalofkyR8udtGEM/8G2U?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb5be99-733b-4f7d-b9c4-08db72bdbaaf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:12:21.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoMYkk3Ahlo3dOKUQVwd5b6l8LylB7vCnOMWjEfy5v1AulE8lhLjAdZOsVg8ApYiaGDsb91xvZY5RIihvao31xc3ugDEQHT6EUfGV2Pn09hfQ22dRXomsbVRlluAzYj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7805
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
    * use_64b_counter_reg => has_atomic_dword (patch 1/4)
    * Removed the unnecessary hook for group validation (patch 3/4)
    * Added group config validation to ampere_cspmu_validate_event() (patch 4/4) 
    * Rebased the patchset

Changes since v2:
    * Changed to use supports_64bits_atomics() and replaced the split writes
      with lo_hi_writeq()
    * Added implementation specific group validation to patch 3
    * Dropped shared interrupt patch
    * Removed unnecessary filter_enable parameter from ampere module
    * Added group validation to ampere module

Changes since v1:
    * Rather than creating a completely new driver, implemented as a submodule
      of Arm CoreSight PMU driver
    * Fixed shared filter handling

Ilkka Koskinen (4):
  perf: arm_cspmu: Split 64-bit write to 32-bit writes
  perf: arm_cspmu: Support implementation specific filters
  perf: arm_cspmu: Support implementation specific validation
  perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU

 .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 232 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |  28 ++-
 drivers/perf/arm_cspmu/arm_cspmu.h            |   6 +
 6 files changed, 309 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

-- 
2.40.1

