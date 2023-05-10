Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43796FE55C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjEJUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjEJUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:45:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502296E94
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBgi5dgh61BYWao59idmoh9NvRkYV1SIxpu4pUQigee1mEk+Akiz/STpiD2H4RrhpEir/ucnFFxjGhFmkOQ5uIDKoCTtL1yv2gbFlJc7CkTk+ju53lqEj8t7gmJTqn+k348t6vFSpLccqtOXaJFlLhYZpAJZVZymkgIPmTDmxeynCew571E/OPLH1SGjVpM7NEZvLgHEUpUaWVvHIeVgs0OkYAVJcEugAj2tEKAHRBkLSw+wlO8vLba+vTaMAdhj5ezdLjFPKEqK1ST6N2qrrrCWZcFvmY3lID0Cw5NgwkpujS021MqMGeFRlMyxkJTf1TampR7KcvJjiMhXmcKvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdLD4Z6z2FcSk74HTnELQZV0/WwhQvWhrLUC5NR44vY=;
 b=UFOYN5mhWsqPrTSAKng+/l1eUq7LdRScHc3IMFiw8WBQvmpB0hUObzYQp+Dlheq20xnK/ncd9RyrhdCmfDzoa+r+nb7CCb5byXR2P4kV335gUgnDqe8UK0zWI+FnG7JSj51oOe1p0hdyW7P8FZQuITBuLuqIRd45zo4uczVjh601jwNcQOTtLSMiEpRxXBv2fjSEc3fYmEder91BNLdeO4VUxzVHOR+zRUV2fpsV8uz4Fnm84k708INmzCeMXFZqhG5peV2GI2PMOyt7sb6p1ZQltPxb6PqfYk8cFCy6Tlq7oI9cUMl2Kl7eWrEvDRaHv3l1GXjhjOpXuBVUzFE3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdLD4Z6z2FcSk74HTnELQZV0/WwhQvWhrLUC5NR44vY=;
 b=kVlYTlIwNS1YoC64tFwY11j+CFsu3orTn3dcSyEl4R/Ip/lKB9M0sIcyb4dwCiNb89vV6hXivOSx2XO09p8LbyYSfTrzpn4G+29lQleR/vkrqF3vqqBObqP3RmyJwrMjFfASqKyrtfp3T3ZwEt4nTDOHjgvY+Vu9Zzb85pXfrOaQRTYWwnylPTqg2Utt/IK5oJ99XlNpTGIcoylfVn2qIpUKf5bH22flhEi5p/Q80UQvUKPsSXYA31lCYmtYaSGuYESGtxZASlqBngZe5knDoQONpHjOYC23yhYTJYaX29FR4lsJrnPKKMsQpu11a6YE4qYjVIxzZXvIFbfCISnJ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6468.apcprd06.prod.outlook.com (2603:1096:400:459::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:45:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 20:45:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        Wei Fu <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 5/5] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Date:   Thu, 11 May 2023 04:44:56 +0800
Message-Id: <20230510204456.57202-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230510204456.57202-1-frank.li@vivo.com>
References: <20230510204456.57202-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1bf2eb-7ac6-4bbb-d704-08db519777de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ix2P1V1E4gz1XNoU2Ft3YQdBRh82+rFc4lKrW+sqfvSuQZ3dXMY6aU9kbCb1yjlAMqtEYJQDxH/0etCg8hHLASzfN3YU6xlsUuqStF8ikpH6OnWMZm/1b8M31oeWw6xeFD24JAfhQU4GeVVb+xADmjWaQbf7+btFXyk7lTp+EawmBN0YBHCgIr6PPs2SX+fe6bbKviWcH4QW2H2+d19s0J7BdyONCVpJG4gty+96IveBOfViFA4tXQfjrOMhMVn6guqlS40wdnrHPIzGkvaQQOG3aROCOLERNA1OBqoXHQCV12WQAkKmJNvM5kdvdk7IdTFyyHbxPPz6ReFvLy2JUmSUj+hpTPe3QXOUZxLGIT88eP2k10NSx2KYscJeiYA9YTTLL84+eMwbwROafUcSfNv0UbE861Px9vakEBU8fuEDQVQSyMuB6XSKB+vytKCbuhXqiR36xowyj+enrw0mU2P/pWijclF46OCm0Sxs54XsWIjMavPgFix8vvHgl2NVJHnDrwzqZeDiuPBJC01jKPkpYASk9OWHfFSmEdCpQp85B4W0mnwWeF/f4sw3mgBX8+CKiH4HGOUgXMn3zDkHidBCCUN1XMpOkOdDCLCgG1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(6486002)(6666004)(316002)(83380400001)(66556008)(66946007)(478600001)(966005)(52116002)(4326008)(26005)(66476007)(6506007)(6512007)(54906003)(110136005)(1076003)(186003)(2906002)(38350700002)(41300700001)(36756003)(86362001)(8936002)(8676002)(5660300002)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iw/9E2GoYyY8gRHexmRvnMURTKdkBajjyGtLdau3NwbvTJ9EYF5tg67DW2FY?=
 =?us-ascii?Q?V7jmlUbi5yUpb6EFdnOkneEkW2FHDHeVrM9AjwUwkt99Pw5hXVyrFU0fD5tM?=
 =?us-ascii?Q?jQLWhPme/hXQuAb0ROEUhUe3HVv9eDENFANzvYQJXiGmVrWIzYPaGncmozky?=
 =?us-ascii?Q?1x52on45IIIRjXGuFQdSQqkO1g4vy+Y1YsqmJ+QUs12G5N5dLQOGXw+LfRww?=
 =?us-ascii?Q?71oRX+Y3TpE5Q2hSwVOe3DrsEZW623A3QEtydGolQ47gYd/jF7wHrOJneq1J?=
 =?us-ascii?Q?ap7fZH8/uAr+/Hn8IgW3Pvc+BbOw6cIyvlSED0ysx2F489hZGjni2NfxWmGi?=
 =?us-ascii?Q?iU50aflqGUctan4VJSfteOV9NpPHzmHBkhkTfjXQxQW8CV/Xr7VmrPdLPq7K?=
 =?us-ascii?Q?DVdFi+dt8zbiTx4nysBeDk7EGNfBwrLdSD43gloOINW0zZXBwTciYCOvNf1v?=
 =?us-ascii?Q?l5+8u1ufr9kP+CCOuPa5r5nidZD1vofIvhl20uDp+WDKO3+Kn57xYS2rcy7Y?=
 =?us-ascii?Q?WDh/uE1b3iAOb9xjmPZatl07QdvxxcrJ1Q4ZFPB4j6ykChmn303MkvGVs2q+?=
 =?us-ascii?Q?+le4CB9mCBPDglaBU865siolxit8U4hEtyh/4mFxkosFW4rXGvdlgzPoF2Fh?=
 =?us-ascii?Q?tyzT812adJtDSaXTvpIBUtGyRQdyvUTdXAiM8C4xuo7/6ViUe+5K0cIS2+q9?=
 =?us-ascii?Q?enZ/BsUyqatPj8KZab9mYvwRfBhBIZcfIAAH3VBYQntnoGU2mpXik7o1MPTX?=
 =?us-ascii?Q?8HQDpRUE9MmRQSmh5dJj7/6zU0ztsNskCBQHHyurNL0ZEx38Xz/7fduya/5i?=
 =?us-ascii?Q?oxG84w3qUnjrSV3JQD5Scl/jMjMBDfGnnOymj0o6vdp4Vc6k5s2R4ANneCQq?=
 =?us-ascii?Q?HVzmLEE+qQVkk6ebuHLnDYeqXmdRK3oAN2JkE7zrHcdI2xpG6Zj3tA2gjhWC?=
 =?us-ascii?Q?PqqzVWArFD1qww8uuU/lTzS0h+6XXZILvcWWyxnu1qLuXGVT7dlS7/+eT7Rk?=
 =?us-ascii?Q?b9x/doYdyJ1t4cHNNy9KwQEvjbAWtcb8mPmTuiriJsP5JKkJbTLAa9l38dWH?=
 =?us-ascii?Q?GRL6BsttDCOHl38icuAjK4Qz2aDkJeNB3nMgWugziXdMicZX0m8usv+RszlK?=
 =?us-ascii?Q?Xv70Inl7hBGlsmoz6Qx/Bo0mk0+ESpc5iKFjZzzxKR+Cfl0pILUttl3Wrpqh?=
 =?us-ascii?Q?zcmko5F3bY4k1Hq55uZG6+nhuUHwyJ2t0PgaP6DZ2bFl0GHgAiPHFOakuC2s?=
 =?us-ascii?Q?xeMCOkZX295hjVbdJXwHCNG+sAh1dmrv+X+Odyo47TAQcy9GyAiPhw0WGlJz?=
 =?us-ascii?Q?269zv4Xm13dhXmYFh/izYYZlFbAcViX85SGYGaDJlPZBowLcjCtCWzs+LzPy?=
 =?us-ascii?Q?aWVzQpLWF5OoORpSVB6ocweWdnTNKRXDvg77Ws3aGeEfR4nikYNMDuZ1wCO/?=
 =?us-ascii?Q?5doEEyz+NvnI8G9qk+N+ZO6TCYAWT1Htgu5cMwrRwSUZ5MB+ByV6tVvGFEg9?=
 =?us-ascii?Q?4i8Dxy83YCqfXox6qv8PNsh5o79xrozrUjOZYq3AybIEGN7DZ5w/cpvqHkdo?=
 =?us-ascii?Q?iAl5/AQYoYuJNhXyW8Kp4UgukB2UGRuozpHp8/7L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1bf2eb-7ac6-4bbb-d704-08db519777de
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:45:19.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU+KjJ+ijk+BRsvHq+nqRNMb4mYl/0YO4pBp5I0YpENfXxKLoGgBLWwZltm4nw8YBZ3LpxX18lsp7vKv8lJpfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Jisheng:
I would like to temporarily maintain the T-HEAD RISC-V SoC support.

Yangtao:
Wei and me would like to help support and maintain too.

Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Wei Fu <wefu@redhat.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-add Yangtao and Wei
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..592769efd1d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18155,6 +18155,14 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/riscv/
 F:	arch/riscv/boot/dts/
 
+RISC-V T-HEAD SoC SUPPORT
+M:	Jisheng Zhang <jszhang@kernel.org>
+M:	Wei Fu <wefu@redhat.com>
+M:	Yangtao Li <frank.li@vivo.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/boot/dts/thead/
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.34.1

