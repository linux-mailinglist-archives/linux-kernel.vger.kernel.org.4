Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CB5B9753
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIOJWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIOJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:22:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177989CD3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dchwFAOIW3Tsa6nyMPTldRgcyVd6qQlxanUFxn8Hp/VWiB8VjqYX7zBky+KVGkPBcn4Gfic/wa5DjRvN2o/Pl1VTr4FV1RPC5y5hwX+yd9ABFajeGQkICI6+fDj2j3nBV6THUy9N0FqiTf+m7Zx4fBkbYchjBrhS2Y1x/xnQHyB5eryA3jQ5HmJjzbO5kaPLJjcECYd6qRckRB5zhEwtzAOmBQ8MzKDzgOoQpmwqpJmSKNf+1sU+seeEaJofmJgrcmsjVXkgSrjocHzO0uQNzf+zMJz+8MiMOIK6G9Fgwo0bIjcAgDiH3zUUJQXsU1sDr7OEH5eNXpJNF9rB+S0lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGZQsoTgC6vwfqinHlQmjQcwKRg1nT+pZ37SyH6wAWA=;
 b=MgEzwDDGCahOcoDUTqm8j6Lwedy5SD3XPze4CHPEQcA+JDVkXcPQ8Q4AyQnEYd4BNJcl8EbWjk3sMwb+GVB/5kmVmr0hXZIKXy0BWsjmx+7fGRoYASy5UZygp/gs6Vs9ttMGLFN/BNVA7xqf8TA/YTZZKzSZL4Nq3CoFt2yNpJD30PL0Ph/N6xXwgBTRn4podd2oNAz2JoEsGYJ9rEIeaIJP9TyUg6a9z+UVhNaiEh1do0v0eRpdDSNFWIfnbocu3gheb3EuccFgK6ywiLTxaqBTe30H2hsztCf7kD0k/w03x/2O6oAGk0Xi04KofKcc3Narr8d3xJPZ8Ft29lVCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ise.de; dmarc=pass action=none header.from=ise.de; dkim=pass
 header.d=ise.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iseol.onmicrosoft.com;
 s=selector1-iseol-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGZQsoTgC6vwfqinHlQmjQcwKRg1nT+pZ37SyH6wAWA=;
 b=q92Wf6zJ/qKzGijY998O6wHUOi3c7aLa1r3IWD9fmLuUUhlfmkhCSDIPeJs5x8ayBAjXH8z5+aV1kS0CO9lG0sZV5ixjKujFmv6+u19VDOjKdzHzKSNplecTmfC09HvxwzRaLHPYwZH2w6Gz9iDM/YjEM6f6+saPTE0DzqRcj18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ise.de;
Received: from AM0P189MB0706.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:1a2::9)
 by AS4P189MB1871.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 09:22:24 +0000
Received: from AM0P189MB0706.EURP189.PROD.OUTLOOK.COM
 ([fe80::3c70:6644:bea:47ed]) by AM0P189MB0706.EURP189.PROD.OUTLOOK.COM
 ([fe80::3c70:6644:bea:47ed%6]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 09:22:24 +0000
From:   Jens Hillenstedt <jens.hillenstedt@ise.de>
To:     support.opensource@diasemi.com, lee@kernel.org
Cc:     Jens Hillenstedt <jens.hillenstedt@ise.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
Date:   Thu, 15 Sep 2022 11:20:04 +0200
Message-Id: <20220915092004.168744-1-jens.hillenstedt@ise.de>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::10) To AM0P189MB0706.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:208:1a2::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0P189MB0706:EE_|AS4P189MB1871:EE_
X-MS-Office365-Filtering-Correlation-Id: c59c04b9-ca0c-40e4-c7ac-08da96fbcc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15JZYMU6bGCAmNgJiqYPu9hhgiIs6/R8KCA+tCBNH5fLK9suibuvu+VMRKMO364oX5gApkeo4YO92Uz/7B3/BWEywmfJfTjt3JrH+nDTGUYWo0PuMl6fmzOs70IUeXsYe0rNvmDXoNILU6vtNOXgKQSFn3H+ck1TYeYjhgulXKXPD2KyXy+C6A3ZJOQY1fiKtBgedcm4rdBsgn6VZCnaprtMZ/gIY0bEAdeD38OghZ4jWj9B3OvzS647it+JPDp+iK8uo51n6Ier5sXgZGlBam2IffXnQFf7HoqQTC8rd3ChSBCArMihAYT3tX5cFUy3z+oQRFzWlnAG/W6O0iXq1GQcRhq9bYntGbksJS1ZndFBHzsQ5UOSWz9zgR7KXoH7hKHUoWB9PyaV2zXHzDc6si42N2fTA39Sn5KWEN9rYvl5iSTqW86BGaa+GvuVRA7yMsF+SzDbhh9pCmVrgZ5GMf7iliS9zRPhWWadsLf0BhCuIU/GEXPBweuI2Xg72B4mr2/86EbjREBN2KiYmjNZMVzOSxo87sfY55DmZjD12/kryWI0xfQfzZ3ib/CtmseWPrPXLRcpCXmoRawioMVP2nIAu3AI5h3pTuESWyDIGhqURQKcFUzamt3aqwfMKlm9fwPEmAq6indJK3YQTC7KzOv01th7FZkW+R6C0sTJXONG9py2qb3jH2cRxSl7wiNQyZNJf6HkUFgVMjNHqEGx3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P189MB0706.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39840400004)(346002)(396003)(136003)(451199015)(36756003)(86362001)(38100700002)(83380400001)(186003)(1076003)(5660300002)(8936002)(2906002)(44832011)(52116002)(6512007)(2616005)(6506007)(6666004)(8676002)(4326008)(66476007)(66556008)(41300700001)(66946007)(316002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRqHJiV8tuBhnDDUmDy+tTqk1df+21tSuL/rAz5/pp5aNlhO6fZS1+H7AqEp?=
 =?us-ascii?Q?Hg2ijmuu+hctFfeROqc/TClZOvjXyUhKYY4/L64jk5ecJ3R3dhZzxxBgnFdw?=
 =?us-ascii?Q?kJ/r0Yjwr4T7gf8tuL8RPlf4RjfSnLnJoynujj/G2A0q/XleGBoa809RPKs0?=
 =?us-ascii?Q?QXNybx180SSXnKzhLFoHp5AeKMhRbqwqNN1rUr2yNIz9PNRC1e0uuq7Q+bcX?=
 =?us-ascii?Q?lK62B9wZbl/iKbVHp67W4sGdXhPV2CdjIzwtADVchzXkauqXXkLS8u6opcLD?=
 =?us-ascii?Q?T6Ftqv8Uk4nx7q/Nh9ydAfgPOxSb/sZYTu8no80sjE+XroLoas64IzTDyJCa?=
 =?us-ascii?Q?8GzosANZd1n7PDZm+/ENKZA2xA2ESk3TxL8BpMgwFzFPh0I1BfR8lXKW8ZTU?=
 =?us-ascii?Q?7JbMWHsVS3t8VaZBHGcYfCGh4DDI9dfik+zzHC33as/ADAi3zM62rGXvhQLS?=
 =?us-ascii?Q?nWAhhmtowt4ZuXFVZgQyW5qOJIbgLfqD4oyWWAMnY5dhOvhn8V+ztnKCpff3?=
 =?us-ascii?Q?LZpQ+Y9Qun2C1kdNtQdG4txjygszgpvf+bFvoQSkMTWByXa55nCm8KpMQVi3?=
 =?us-ascii?Q?5K379+E3HMAutaEHumIiSenlNe58yvOL1MRm21jdd7wPiKWAQTAfIXf/9kcw?=
 =?us-ascii?Q?CY9YPSBkGqv4UwZOv7olLLHpciGV3jLZWvjihuxnUd7BjdJWjrBvK1iJRe+n?=
 =?us-ascii?Q?zntluyBKnG3XMnJ/ifCGpy1dOLJS4SOMu0teT+wKpMyQhH1XlIcysmv/meL0?=
 =?us-ascii?Q?8tsnTl9hAInHg2tuaricI5svkcNYuzCuCYjada9eg0I0eC9/XyCwUHmzTn9Q?=
 =?us-ascii?Q?M8pkzFMi7v56uU/FL6XRuPTL1cpJNS6UsV6Bcp95sQsAEeiER9n+jTGgHLaU?=
 =?us-ascii?Q?3tVnp9rCuBkV2N6hdlIRthkFeDG5yeBy8Q48z0kOYQkEKzIG0VsWiAnw6hrl?=
 =?us-ascii?Q?iclXwCjCvdkCxqVonZgF9WajPO5f0o5ZtcdXNnr1VZYiatKVwXiGYvbKeKDJ?=
 =?us-ascii?Q?6OJndEI02kX9HMP2oIrIeNKtJnWA+Wu4FQc1RbqzhaUbJ/K+AbWm9dOMA7ws?=
 =?us-ascii?Q?n2amXtMZ6pQrlIOo6QFfFRXfM5dtakzVQDRqBrD1GdtU8KHDPVACf1nspkpT?=
 =?us-ascii?Q?ox29LvB2XFsOrmFazJCcCQgvRykZcyQVJXcROi7X5+RUBpfXlDULVgkTrPs8?=
 =?us-ascii?Q?0phQjoFECXk3pHuoSWW15pVLKwm4p/eP16q4vqe0V+mTy04jaTu0Pg6JJoBJ?=
 =?us-ascii?Q?O5NSLZAF4rqC1QlPHlEdNl4zaMXR2WfY6uSq8EBzRcUdtwkHjdeCl2ATIBHP?=
 =?us-ascii?Q?CNKCHYPByN/UJMjPYMa2O7O4YF129SoJPMrFBCSFwaMCXUpYHamU26nZQRWU?=
 =?us-ascii?Q?+CziInyyRJrfRNC0R4K0aR0I7vp+WlQZmdYomuJ6No/XFH+bRH3ahnRYnuU/?=
 =?us-ascii?Q?jiprFAHZQrvSJkRzUN8JxRRy9DYGcygFkdyOO4XLRYZMRp85rgNd9QB27Fc8?=
 =?us-ascii?Q?FAzdPkGSHpetBWwkmvUc2vLZI6YKgM0I3DfUV76xgqjpTb3lolp/ZkCbKFCF?=
 =?us-ascii?Q?O0sNCPxBZHL1xAwx8Ih6dHIzKhcuQsOLuDyooyKGNP/R0WIHotU8HtX8C7yW?=
 =?us-ascii?Q?AxgyI7BYHEQoyJYqY1WsNmUdjOLGZbDBmgmGbN9fiwN/D+RIyqkdh7ZVrjEw?=
 =?us-ascii?Q?pywIbA=3D=3D?=
X-OriginatorOrg: ise.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c59c04b9-ca0c-40e4-c7ac-08da96fbcc65
X-MS-Exchange-CrossTenant-AuthSource: AM0P189MB0706.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:22:24.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a67537c9-62f0-4085-8a06-fa510a7e7104
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kNJsl41w0WYXOm2slk8eg8wLTMh+Sq+ivQQ8iCk7TVIv+zQka87IRj2wbXwQqfv6ns2plYBDewsN09oQdIrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1871
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In da9062_i2c_probe() regmap_clear_bits() tries to access CONFIG_J
register. As CONFIG_J is not present in da9061_aa_writeable_ranges[] probe
of da9061 fails:

  da9062 2-0058: Entering I2C mode!
  da9062 2-0058: Failed to set Two-Wire Bus Mode.
  da9062: probe of 2-0058 failed with error -5

Add CONFIG_J register to da9061_aa_writeable_ranges[].

Fixes: 5c6f0f456351 ("mfd: da9062: Support SMBus and I2C mode")
Signed-off-by: Jens Hillenstedt <jens.hillenstedt@ise.de>
---
 drivers/mfd/da9062-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 2774b2cbaea6..c2acdbcd5d6b 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -453,6 +453,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_CONFIG_J, DA9062AA_CONFIG_J),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
-- 
2.30.2

