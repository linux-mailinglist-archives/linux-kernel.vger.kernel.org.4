Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAA746CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGDJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGDJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:11:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A2F137
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkNBElDraykqjLTRFbiugwxNWmUj9llEyhPSTSaEi/i2GxNBJn1nNAUwfA8LgZRejmsRux9F9rXmM4SZYglMgfi28uENNDhEQt8agiFjB2hjlcFeF4QTaLxVkJzQzn5vurrLsc3E2nNlibd9iwiupLFuo9jZZ4kHihMzfqbOgORv3Kirb1TAMbtY70LXV1VVN2NzIwbEECszLU/6KkNz1sZdJexemxdOS6GSzh52QLUuGEKmU2xPowgl7zDFOADl7KB7tOjWv8My9x88plBPSLRtVVSYw9CwNPDWrnNYcRvbExxa5Yr13KfyZlD5jHyAvZwoG0V5GVM7wdZUgMnUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1JblLbZYn+97rf+x0NM+vTxzOU6gRCHl0eZE0GEJ7o=;
 b=jMjqfDanU4V5OP3eDlV06givLofHJkfgPnneOnQscSiOL20AdNWo0kiLlKrmI0BrJp3YWwIqz2FjImn2hpnW+tfIfPU9RdRhqxQWL+u/HJUaElnL2s+nVBQpdXRzyDm8IwhqR5aE1vKpSFPO7g+0QnWLG+9CvyG1DQEbD3UZ2Gddq1SKphSEoK5BLdiL8BtZzYQgMpsr+xlzZ2NqWANyZ4fr75DBhK2tC6lfNVIpA62AeCh93ItEpt0+PAR2Bd0Hnt5cjDrhYr6wqW39YMASLhgByQ6nj1fxcUYpN96PkoRU7CcWL+oKNl2OFfAcIKM7dmA3kkt8YUPc4RSNcqKeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1JblLbZYn+97rf+x0NM+vTxzOU6gRCHl0eZE0GEJ7o=;
 b=Oxy+2nM59Ase/BrqPnrnVtXJffyu+7rkzAmSFdoXS2cR4GwINCr2Vxtw+eot7xi+EYbWFqi4di4sOjT/iFceNoNRNHjvn8A+89h16EB7GxqknZXPNry4pL537IlfEm2rSWtP1xf8yznkCJREHDx+uZCFkBgz1Wct7ErGCIkahY35rXLrhdwSMolGqtwHah5cjOaag1Usrui4IKBXiRCIkH3JKvntB5JiGcbz0nfX4UZQl3KqiugoAQQRrEAHIZZvBLEKhCaDgrPqt7UhYsuZk+m0Hyz4w4OzxQ2Kfft5d1+qg0xRK5YssFa9KT4ONQPzt9qo4+hfML7FA6/pDk03Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEYPR06MB5789.apcprd06.prod.outlook.com (2603:1096:101:ba::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 09:11:48 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:11:48 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] sound: riptide: Remove duplicate judgments code
Date:   Tue,  4 Jul 2023 17:11:31 +0800
Message-Id: <20230704091131.6662-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEYPR06MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: b430ebae-3cac-4ffa-9ba4-08db7c6eb255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExlJG48rxXOABxPr1GiKbQ4fMKKBh8UQqHTbJswIu1uYaYV3hRAfq2js9uS/fDrK117EHSMNRXScSzZltMHpokh/x9xxeunQEwjfmCmj3OUSbKlQH+oRvJ8bVScmHtTBSEmwqqPqSOkEYtP74n9ilNZg+VuY8MSt/aaFoRSbH4d7G8Rg0/OgR4cGUu+P/vOD5b//ArjHCCHSLU/kwbCyonoObIQlkv0yKq5k3a7CEVCea+yXB79xkcOuL2Q2BH88wXCgP8P7QHmSj/MsPZvQ1yY++UtCenKelwmoVUr/yO5pt/lEpe6zviF7l8GyUIS45XyCPzY7Xo16pbyu5Z7jJYVMwecpuOSaZDt55pj7chJD19jFW1+7JWSejkomKq3CjoZEfFOG16PLjKcpcwRkJTwR54EfbI8ZXGZqYkWqvggCyhRBntRAUSvy6ESkw0mLc+Rt2c2agZdaBTn2c4mx2jOdV3GkCpXpVdOzQtNN+uEo5z1vdRcYG6Cfh3OqqAE17mcZiHgnhuUxB9rJhm1vFwQVRH9s8D8A40Ns3CdOT78phyWKM/2xe/WkVEHNOgJVNnfxaVh/mNJe4egeDkOJEH0NiMr16ninF7xovUTpWkpN5k7thr+anIbtgaXALX8r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(8936002)(5660300002)(8676002)(41300700001)(38350700002)(38100700002)(66946007)(66556008)(316002)(4326008)(66476007)(110136005)(36756003)(86362001)(107886003)(6666004)(478600001)(6506007)(26005)(6512007)(186003)(1076003)(52116002)(6486002)(83380400001)(2616005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkxeZRT8dKKJMia6lsAYxlTM0zcNeOpgq+TKmqEmiG7yMEMdVzofWYb9R/8I?=
 =?us-ascii?Q?QfD6XKL5n08m4WykXLrrgSULnJurMsmJ4Q2Emytrf6Jsvwixjr03NRBnmZZy?=
 =?us-ascii?Q?RQUIv+dm+n/cWsZMNkokAcyauMMcdGeUh2VXOpWWCcILOvaG4a5Yz1/rM+CA?=
 =?us-ascii?Q?//OErp2ORRbdFxw6Kc4KDJ495mEADdNas7y7V16YDLK6xdE7UAvJIDOKW6i+?=
 =?us-ascii?Q?4S+jH4kJdZH/Hc14HJ1ahcuLo6J4mc+P68r23LQBG6PmGBE+vGVnKQcEQG9q?=
 =?us-ascii?Q?QinSRwHgrG1bo5+xhFWLM+MYmVKQldyn0mBYydXzYTHbJsr4QURNHMBb8tei?=
 =?us-ascii?Q?XWreho2X33cMU4rWzZ5hd0EkSGdzXobUFwjxKnSvLe8BzKxpa8fQFSdt1vH1?=
 =?us-ascii?Q?ARvRUfmEAqB50hUmCc8LvK1SFb2CqugnFpjqn1xeW+AlE6kApuudNU/nc7uF?=
 =?us-ascii?Q?FcgD5fjWyj2tm1xcEo2TULnmll0tepNcAUjzsF7dhPb8PcZ9YttxzrpXg8PD?=
 =?us-ascii?Q?m4UOoVZtBIfq4JLtU2QlwFiXt+LSAO15dwEr/mJnQb3aSoLC46csnsd2lFvr?=
 =?us-ascii?Q?WZRFAIs0Jwn9L7pAnzH3JVOYA2jybet/4wn0sEXQaycmsR37OijBxfdFnLE0?=
 =?us-ascii?Q?lIoPKQVfxlbyAZW31abXmgdOtSEwpDsNO4BMWTEZ73HeELKb02Awkj+pYJSG?=
 =?us-ascii?Q?nJR2dTzmgGyHwUIcPRSGnqw5xvtu+wZglvdhy0YhTtl26h+pYvUsGl/dwP1H?=
 =?us-ascii?Q?AL718CvzEFdw/2vDs+X165s7lsErjoJ6nEFe9NfdLBJrdDAZx/KfWsDLqxib?=
 =?us-ascii?Q?xfMQvORC+p7ojiH0M1Z6RAXBraQfcJFcuRiJipZr/XIu7ROKSRl/W7xJgQxe?=
 =?us-ascii?Q?mpge10mPoE90T8oRbf/5T0vJHXcpquQFKidD0oQ2p2BpP+M7BMhnc0Z3/KgU?=
 =?us-ascii?Q?EVpREDdkUaTNDL6oO9xl3dtd1EfZ3qUJ64V53l0PA5HzO/zBXdUqwUEuH4y6?=
 =?us-ascii?Q?0qnaQKQ68JX+FszQKKmijzJY5tdEZQxK4TsCWU/rmVmOGAx/wHNrneiwuioJ?=
 =?us-ascii?Q?7DnCVh6ZvEZm2o1K/OPebA/RerKhzhOh0b+HVmxpdZAkTOk9+LfYi9AJazcY?=
 =?us-ascii?Q?7Sxh94jjPaCOdPeYD84FIqBSKk83yhp4Y85UzH2iXgYbiDaAhdr0ncNLyIml?=
 =?us-ascii?Q?IFhnrbaxKG74FIrI8hFVqYAcBfM6vJQurC4Ch5x6v/ZwQ9pZEunQGuqGRN9c?=
 =?us-ascii?Q?NVXKEVQOh5HY7c/84poSnO/ok2o9SWKCAj4+yWngKlWizlqTL4o+d4s8Vnon?=
 =?us-ascii?Q?2X9yG/CoDkn+wlFRlvdxWvZvsWOqFdliIXrHeqr86c8hIXzWOBU3x9vAF5P2?=
 =?us-ascii?Q?59U5P3acUfNrivC12D6LmR8ITe+Dd7lyKEMHzYaA8YrzLhOFBhHxD+OY9Gyf?=
 =?us-ascii?Q?7KeXyObVaZsZNUaqldAi1NpvHdjZ7u8hfbEkBDBmgN4EtK1RfBNZhQxhnUV3?=
 =?us-ascii?Q?V0sy2rVpPHJCMx6kuA2h02Vu7ZWuW/jYxkwegUxc5DbztVYrjo+f4BV/h+Yw?=
 =?us-ascii?Q?2S7EZQWuBzA9c/+bBTyQR+qBHjVbI4a/KnJlBocz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b430ebae-3cac-4ffa-9ba4-08db7c6eb255
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:11:48.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy1lBFpvR7GV8c0Q5uP3YfiqV5vdmBY1Xv/y2X/oT4EIS7FgYiz64vne+lccnnE1/Lf9gtLTD5Iq8q304h/KiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix: delate duplicate judgments
Could you help check it out? Thank you!

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 sound/pci/riptide/riptide.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index b37c877c2..9bf4b2e86 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -958,8 +958,7 @@ getsourcesink(struct cmdif *cif, unsigned char source, unsigned char sink,
 {
 	union cmdret rptr = CMDRET_ZERO;
 
-	if (SEND_RSSV(cif, source, sink, &rptr) &&
-	    SEND_RSSV(cif, source, sink, &rptr))
+	if (SEND_RSSV(cif, source, sink, &rptr))
 		return -EIO;
 	*a = rptr.retbytes[0];
 	*b = rptr.retbytes[1];
@@ -978,8 +977,7 @@ getsamplerate(struct cmdif *cif, unsigned char *intdec, unsigned int *rate)
 	s = intdec;
 	for (i = 0; i < 2; i++) {
 		if (*s != 0xff) {
-			if (SEND_RSRC(cif, *s, &rptr) &&
-			    SEND_RSRC(cif, *s, &rptr))
+			if (SEND_RSRC(cif, *s, &rptr))
 				return -EIO;
 			p[i] += rptr.retwords[1];
 			p[i] *= rptr.retwords[2];
@@ -1013,8 +1011,7 @@ setsampleformat(struct cmdif *cif,
 	sig = snd_pcm_format_unsigned(format) != 0;
 	order = snd_pcm_format_big_endian(format) != 0;
 
-	if (SEND_SETF(cif, mixer, w, ch, order, sig, id) &&
-	    SEND_SETF(cif, mixer, w, ch, order, sig, id)) {
+	if (SEND_SETF(cif, mixer, w, ch, order, sig, id)) {
 		snd_printdd("setsampleformat failed\n");
 		return -EIO;
 	}
@@ -1060,7 +1057,7 @@ getmixer(struct cmdif *cif, short num, unsigned short *rval,
 {
 	union cmdret rptr = CMDRET_ZERO;
 
-	if (SEND_RDGV(cif, num, num, &rptr) && SEND_RDGV(cif, num, num, &rptr))
+	if (SEND_RDGV(cif, num, num, &rptr))
 		return -EIO;
 	*rval = rptr.retwords[0];
 	*lval = rptr.retwords[1];
-- 
2.39.0

