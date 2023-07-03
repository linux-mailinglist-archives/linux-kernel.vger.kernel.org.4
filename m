Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD49745897
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGCJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:41:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2EFCD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aufWO2Dm7VpgzKV+xj7F4gT+Qs+Yr7J9XvARFielatHe3FuIKFDVtBJ5QUjoj9Qcs75nN6NzzrggOfxCqvPDWF8q2fjNOaAZX1+0gesqIk7hDdPTNqGW4wkhT9cJyU++CCQN5eTGCnLEh/sAGqy08cJbtBSWmTBVWmi2l8WLfaDL6jrHBnllPFNp2JURtxwxxEgNMdYvyGP2jexlzx5Sx4gjwGtfgbVhUMUvFQOs5TdD5FkUcN+SZ7MaozQ1PIKxkaCYbc+vP8cHHN26pu40qqARpGbGnUzDbvRwi0NVi64jPYH/VmDfLlL97qN4jhwz4jg/qlTJFtOVubAYFDRqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOW0RM6sxg+lbfEMWq9dRI9PgbeVTLuhOVQ4wWCReEM=;
 b=X3vMYfvDiJoI1miHSkK9F8RKp7K6sjtmciiS5hs46eVE4kYF0jY8OHI0hJJg/0ahbsSbT9f6ns2S2Qw6R8yba0qg6dkK1lxrYi6pdFQp2irmWFluUUaHJIC78FH0VUJU1ZlAmGBIq2UfqmY94qJwwUEs5YTEYshvimhSjnk2BSyfXctcGQsdMBfKjOZ9kl58f4F4324ClBZw5Xjmo23cYOxbu4PfjXUen5QCmWV8x9ti+b0fw/4qnyDzcDPrIkuWMsCk2Ip/kTCIcbarSgUKQBHWVkTJl6a6U1jPhNerGayJEZVvlVFQki315sAyJ29NgNVq+DZAC4yJ2XJTi/58+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOW0RM6sxg+lbfEMWq9dRI9PgbeVTLuhOVQ4wWCReEM=;
 b=O2dqP8QDqaueuREEwvtOelH0ZjWHRiiSvLH5qIj3oaoTTyxqzi6jdIQBg8XP3mfAE2NN0nqMdjBggzMRqSJAb+f97aO34t+WdzJmymNsINiD+Ti+cxWb7VI5QC9GckdfGVsPhsX6nqGo0xJsRTfH3Updpdta/jpn+VIS0tfExNjugebIotEF6WxLGp+S4S/uidwFfdBSdnYgic9DHbGlM/uCa85hjDb/v7EmfDwek2QnQcG2+2SI9a3cYDB9Am2+edB0qrXYrtCvZsdu+18I1yWtYIOxUQ28NZATeOxh07BWjbU0aNmGrYkf2VTW7ttUPrINqu62Zerr21mf3eXN+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB5480.apcprd06.prod.outlook.com (2603:1096:101:a3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 09:41:47 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:41:47 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, sfr@canb.auug.org.au,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        machel@vivo.com
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: use free_netdev before return
Date:   Mon,  3 Jul 2023 17:41:35 +0800
Message-Id: <20230703094135.6443-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::19) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: 8830768c-43f4-4a4e-cd9d-08db7ba9b7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8i9gDTL+xOf9PBk8WNpvD9N4rGX7gZTc31jYLuEJbTHoIz5eGiBV4Qe+kF8BrRJa6kaS10j6nl5lBUXjQS1oSNWepvLZffu4gqPqVB+t5oqebR1lYhYXDVzYHo58mnJRjyYopYl/n449PTwUj5j/zneuqRFw9szhOteLAnL0axzliyky6KWn+eZR8gnOoEtjdMXD+pgF+2ygy4lhZuVA2MWQSDekbCz400C2DNt5B/0DZrT+OyuB7aTdPfayHxFwub3tJ/81N+XJ30aYheZUPVJXYj5bPCsBTQIkIcGqvUMdHsqfnL7+I7fTIy6/kXrVZb+kbSUhxwEYh62IVFGc9mcJtx1Zgmj/c1WDCz9JhTG6vrn9NW85fn7AOSrzfQWxMCEs5+kEo6XwJwrapxT62gqVYh9ugskbdHvXM9PJdMNVrxafx4/0lNlv/mvMup8Fsb42A50SfuYhf5O0xiLAfABbkNxMsQ6kUGSAsQvKfsYuQdyYZrqt2cCIiyluSzNWYcrNAhubnFjTwRAkvAwYgL7U1BmcbUQfpHlTk5Jen9NYgfT+zNhBDfresUOzNRNtsJ809AdFgIkNTbJ3XhKM/vxRpFPgL3KArFki717DA2fi0eZWkDYi0cytSsqHOjt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(4744005)(2906002)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(52116002)(8936002)(8676002)(5660300002)(36756003)(316002)(6512007)(66946007)(66476007)(66556008)(38100700002)(38350700002)(6636002)(4326008)(6506007)(1076003)(2616005)(186003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hV5maB3VKegc8cGjFIxZh+CxDH8f+x1xITCunNNQnlgOoEbhEPqRgiIcTD1I?=
 =?us-ascii?Q?63p0YKW0I89tivi2fnsm+F5/VVEZHLwpZj0rABs1VsX9cu0AQM8Ke5Jr5Wj1?=
 =?us-ascii?Q?m5M8a1MV+zJAe5gVI7u1IgS3H0OA9kiupqSGYRAldeOk20SEAKSDe8hdvWk8?=
 =?us-ascii?Q?nBzhR7Q7XG7Q04K4WuYx+ngRe3YWisKCwWU+kBP36IF6c9eLb9TQcEZ1lx/S?=
 =?us-ascii?Q?JeQpp+h5lZr+Sphl5zDK61jLMtSdzL7zEPoYxsyKSRmMZajraSMar1/Gma4Q?=
 =?us-ascii?Q?8y3O+cApyMg+iJ5LURLnSQLlZrJtHDAVywHSkQuE9my7iqGSuhLMRVNSVRPz?=
 =?us-ascii?Q?yhRz6y0hpPES65u1LDFKRK5w0QaBMfDJxyijuUWCIWazgnqLz+o6cIi3SYm4?=
 =?us-ascii?Q?HV137Txa8Rp+/8TW2hVWLVNh2E0Ta5hE5lQxt06IfZuqtJpg11MlRrAvmsS7?=
 =?us-ascii?Q?W79nNACQBIYZBq72GdcYrROlkN0QiWLA+LopyA3VSY4kEg3m/jAVqLof9yrw?=
 =?us-ascii?Q?KWavZkstdFO2liosJOvTag1VLB36C7eMTHL5tl0ZK9b3hXhVGB3dZQxNMKNx?=
 =?us-ascii?Q?w/Yb7YZViKT8Pjoe/VRsYLVi4bgMz2tZyA8b4MveeuKPgxNbdHwJ0EPVSmsD?=
 =?us-ascii?Q?6mrysUXWx9wpahz1yNJoJdnNIFFbfYJY0EUO9YMOLkAAFKoNUbWQOazvJtuQ?=
 =?us-ascii?Q?3yQ8YxZ1tgaEAeNWCfuVnkHa9dSqPCxCodHWMy6EJdA+yaJ7tdONx4FqtGaw?=
 =?us-ascii?Q?iz0luM90Ddd4UYCjPzakcaMecA+z+Jn6fLh40HLYS/FrZrLURiA/S8Z1RBez?=
 =?us-ascii?Q?kcTy7+rjpyH/pr67cGwRGl66RKryGcKb3UVtWb4jNJ1OEXQRXRhKqclnemNg?=
 =?us-ascii?Q?OcfTs3vgqcK5Z2vQgS++d0vmP1bYNXIiQSEFeNoa/QvSpYVckdxPFa2bzRnI?=
 =?us-ascii?Q?YuWQH216RdITa7oiVTpBtj63h61jwaQrPYd/AbnstAcDKla3l1EUaK+5NEAG?=
 =?us-ascii?Q?3tUlgfwT5ONDh6RM5XL0DVExKH4pt00qLjtIilO9XHOoE3AAnx4KivCmZDVE?=
 =?us-ascii?Q?Gk4XnJqxJtzd/GQQ+Rc/yDbnw4MVZfngT6OMHY65jBEdRQ9Fg1Pq1oCMeFz9?=
 =?us-ascii?Q?78bGOmj/gKMMxzea/Jg4PYh7EOyi3JQS4zwkmieYglyoGN2BRYNfKHSV3t4c?=
 =?us-ascii?Q?TlvB4A2mZ3SRHkYA4qK0WKTIyr1RSgUhu3aQZ2gj4rQbEFVDNECfTxkrTRVI?=
 =?us-ascii?Q?tUdWgLZ/KzrF3aQKQy/cMVTC5Yh9WX/qynI0715pRZUaX8T4kRR9Ija/d8H0?=
 =?us-ascii?Q?FOI9yYl3uxdK9MUsPmvn97GuyC4DvWvlNua/HLhc46FswRzLvbfwbdUp3zzE?=
 =?us-ascii?Q?Hoo5fpZYt5UVzFXcGLPtDcpooaLc6mZ95hnPEZ4799EhHqQsAZ1MWLPsJI7j?=
 =?us-ascii?Q?Wsv46pue0qtoQfhJCtXGe3FONsOxjobeeYhvrfuxRbdXA8wHjZ71vhCM8J7M?=
 =?us-ascii?Q?3PSQAWfwkzf7FcKrTehxyiy21GWzHQ9LlweB/yr7jCNLTDvort7DqvDRIFPE?=
 =?us-ascii?Q?tuT6rTDihKB8C/XQuAENV7La/lag/EhJgBGdhIfY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8830768c-43f4-4a4e-cd9d-08db7ba9b7a7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:41:46.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP/J2QA53wTVntGRbU35ySHFh76WrKT68paWjG6vz1rpxO9ruXefPYQO0sYsd76Bl4anOjEj4g8I/OdCJoTv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5480
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We fixed a bug where the variable dev
was not freed before return.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/um/drivers/vector_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29..af7f6fd4c 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1655,6 +1655,7 @@ static void vector_eth_configure(
 	return;
 
 out_undo_user_init:
+	free_netdev(dev);
 	return;
 out_free_netdev:
 	free_netdev(dev);
-- 
2.39.0

