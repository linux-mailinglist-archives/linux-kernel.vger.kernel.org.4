Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD1733559
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFPQCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbjFPQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:01:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2035.outbound.protection.outlook.com [40.92.91.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027E35A6;
        Fri, 16 Jun 2023 09:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOpZAPShBW3w5SckE2p9wLlA3a+hpnc4/aHV3wPjnQxQXTiG0Wp4vygjOIZq12LehyRKbcp7X/dOJzlNzIx3LNIYw6hVPgSQ8RdhzI8t5DYj9WrFxnhTOg1JKnfAwmICv8sxoORSc1OwVhpJ5ieyXKZe3hKQEMzHrvnB2brAZJk27Jnjy0nuugwnu1NyCceNe0PjLIFtdff8j/pGPoabhprXRY5AMgRyanURGSkRjNyA5lNkUcQmK7JkYNr/6uTObMOZ3oTmMMaF0Y2O0hIUUOPvGvSGdA+0Bi4mrgv1KqqCcg305LfPU4qlcG6Plq/fWiI4sjRF6CcdPcmTAvFJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZSjapdVjZVj0bWCTKjxCgRkFqSFvPX9XHSxOUu5Awk=;
 b=W9lU2scaT2pALF8LPw2fLoIu45/ZgzssaAUudnRSn4Wfcjv9eKWvKLbk3j5+XCu8NNftpdSGNs0UavGqkay/K3Go9sXWNowv1rSQIfrl6AsZ353LAMUqyEDlC0crA4u8KLbII0kVLZuPI2A3g4RsZZvZoFCYFi9K2f3ryZMfXKwrMRebflI7ut969o7chTUa+fbV4rR4SKUtQhdKADg7IJqNGBTLS6+sN/AV6LalfSJ1h8Bj7ma20BtDB66Jt4eMeWONGyGFZwwzQ/LgYCrEpWN4X9dBMhxYMMosR7ic1sZAzVwzxUEmcVlI/ZlB3oIUSRBaf4uMJnZtCQRfRT5Jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZSjapdVjZVj0bWCTKjxCgRkFqSFvPX9XHSxOUu5Awk=;
 b=YamZZQZR4IMZWAu9gtp/xfjwwhD8C+10fqCinuQW8LzXG5TFEIhqgNX9D5Y6dMYAFzlGr4rQvMM+wYa0F2Em0QCtdpGIlpzEGrX2UDqbx6S+vmnUNEzbv3i2TN97VnHeOPyXdOE8G1on7pcWJBxKA7Nb31XiXGHc12bs04XO8myBBsd9OS8f0jJ8MQNSsob4mEykXxVJhAGJLcC4cz7k2upJO0AZWrDl58xYkyS53vPkReiwa085ojzRitHdhevvSQJ2IG5mXAg1KFRlrA4mfwGhzO0YyEPESzJ6Ghy3VmI3CnNlAaZ2UbXoV8qvV2+cE07SbZDGW0jF7HTPZwzsNA==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 16:01:17 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 16:01:17 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v2 6/6] hwmon: (sht3x) complement sysfs interface for sts3x
Date:   Sat, 17 Jun 2023 00:00:17 +0800
Message-ID: <DB4PR10MB6261B912ADFA6BB78240596F9258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [AT3G0djnuRdrcONJf57lmpxNJkYiKOCB]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230616160017.21228-6-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: d20ff2f7-e032-4962-0df6-08db6e82eae8
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrST/aUJU0/QQB6BlKfxJxwnjHkkJa2LdIc0PMZ2Gs687d1ToFcU0kKJrNBjb/s13yKQi+5kFeu1eGgKSVaysLsseebnHZvEVKvnrusjPFT2qGbMZnSpZ0Ayx5I/7sT6iTp43y/Hn/rGDjNUUue5PPQ48Qq0CFqoDaFo8oSNiXxQeE6XcbPjyamNg6dG7Fb192n/dAiwVZ1xG9x+apLuP8z56drISaJTl0ILqXW0s6qVA3gL9ziCYAFzNY2S53Pk5sbzKpi9Z9eP7dxdexSeIg0Rvaux2QtSLlo+uQ7OrubUtnBaP6vn0qOtraek0lxP/oF34BCIeS4Nv2aMqCyqs23ZUoywO93D6bfEQgEz0CqfPyUlC9I7lCAYl0s52635Jxos8ZolAq74N5bSeTQDgyUDrdawR4RCVooO//qiSRsCXQdgcJLXHg0lixgwWQ80ZaGLAy43C3Mj/HczpJGf0cm6gyMfBjPeNGGWyNoUFhpJOrta8AqLHt8gE0MhMjdFhveeUlO5ctK/S5kJ2aNlF5/uqSS6jClPDIB2JN3/TiMdZylsGTthxe2EomEi2kVRwvzBAlWXLwmrYup2803cjOubnpFjevs7aRkLo2rSovkxLg6Y9Np9L1gs6F9PtXZWu6lGpO6e436rXR47kaF/f0gBtRrMzhg7RhMO6Pyr0Ly/V1q0haGILyMx0msP4v+mQ5DHzv2hF3jsKRaiEWZAOcOTmeWZ0a7f8QdG2iURB9NaS3fM5JgGRL9tMFyvNjv69g=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq/Fi2QVyZNw2jzy67JwWYJY+vROm980jJlpgrXJNIFQXDvbThIYUgZYffG5FD6YVyo7XxmcobU7VL1SmrvutyyTqh++9lty/ZLxiLV/RlaBcOeMrw2dBsxq1KFVV+m5FZN/ozGF7KtE2JDIaH2Yz9EpIp/Lv1CgcyBknt3hIPrtSrBSLr6NmbMhvyqbPfx6zOUTg32lI5Rdk1yqZNpoxjveOW/FmohlzqeJfMZFFLHaB+VbKoouImWALUERECcO+0qwCf4hC1GUF8SXy9QeypQj3uBYDriJYGpHU4Jdf5MG5Z2Zeo+tzLFjFIecIHpCk+k1RscXIOPTTO3NFKMAqqiQtmnqI1FnuWHFURgz0+TFMD9zd/yC6S0DecvJcS1igyPIyaY23wwgjYJbfvvEbAGSm0SFosokOaHssN2B3yezCIXhWkDFtAi/TGd5Q++zSlbGC6kOJ3aikaSu9s988EkyVgiCXMr7SCu1p63l3Xo0vTK03AlT08Z4oybQL1TtRrIDVQGEzdcRuYNah4k0Al8c6n5sCUSjxr3RsOaiuEgVTJsjJuh0OSK89oxDWtuUgeQwt1F7LdBVrze+CH3FLfkbVndBiJ7z1fYKQqpvpYAfwIR1yUzf/qW6vYv7HlcO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgC7qTdKiNOGF3+sqLkrLC7HC4Iw/Dj789GaWsBnlzHz8eOpylkb/I3mrMMg?=
 =?us-ascii?Q?aJL8M3Z/VaKi1eUcKhgiDHTfEBqsqC4QLmWiPHPV6POY/eaa/M14xk5Y/m5F?=
 =?us-ascii?Q?kbPES1p67QCn/OYvXZOVjfLzxnkqYPVRYkMviqDp0V1CKMRN0J0sKpByHhKI?=
 =?us-ascii?Q?JddbvbnN0QJKHbjjAPbvsFZ6j/A9jVdlFWc6fy6hGA3lOmIEyBPAlbZr4z+5?=
 =?us-ascii?Q?bXQ8fjME6/tDeS4shvQQ2UK3soCDN74VF71UFgkY+N+I+QBQ8wKs7kOKGhVi?=
 =?us-ascii?Q?jsBDqhL63YI1PdQy67s6T+IOOGr9AkRYcvRQ+pQTGuRSm9IX66+8Y+wQdjAR?=
 =?us-ascii?Q?fr41YV8vmBHrPn2BfEPBFOo+9QUbCjvAd98FMhhGRjPrpV6hpxUcbUuTmM1F?=
 =?us-ascii?Q?IUH/FWevBg9ggj2NU7uwguuIjdbhTW8PZ3cFooTRAuGN9iFzV4+ubQjO17zl?=
 =?us-ascii?Q?aF6VEzEEQQipAxFzaXZyPHikDUeEzK5is+yXDORJRACKfg3dvluIDT13SgpQ?=
 =?us-ascii?Q?S0kU2WC80/kHN5MVyNJDf0aFvT13JHuSw1ifbifPW5V62lQ0gzKk/N3ZWmDK?=
 =?us-ascii?Q?1JGQdAB7qqok1w3wPK+957JbVGnY/RNPXw4NT9hotGEM6Oe2fG1hZ+AyLgW4?=
 =?us-ascii?Q?U/pUfCJDNs8RQyLYPj5prh+CYMdwZZmSf82kfx6AwHX/3CDB4IpTztexUjkV?=
 =?us-ascii?Q?r2U5l+Q6Mxe3eLmtpwTKt39zR+rzEFSJq3lHTBa9TcaamrPUjF5EsIralyJ4?=
 =?us-ascii?Q?vAAAx4m//hjshUr3KucZo2v+GZRmR+1NW29KQStT4V0Tb/lWXRYNvYpJiNh5?=
 =?us-ascii?Q?hngViv+eZyysBSy6+bOGrJXrvLJMwlreSjqWxVxgFFGd/QNhz1605SZ4fWz/?=
 =?us-ascii?Q?d9/QkcB8U1732/sTJlvq5ZPh3naU953zNmt+jlLwMXUbAa33JxJxMnerFjkW?=
 =?us-ascii?Q?bwmEcZVjUo5t/0u7mcTO3peIFLtuyNAwFgfhmYziTaGD8+jwgbAg/YOPMlt5?=
 =?us-ascii?Q?hTu8kb8ZV5+QAIFrDYIRvGVBKqipdD+u+Br/CH6GP7nrjqCq4KLTsy6CmPv2?=
 =?us-ascii?Q?Y0OPAFWyPYaHSIHjLQt1cPJQg4gyhXylTwBp6Zxz6FOaBRkAJYZ5JLcxdERm?=
 =?us-ascii?Q?VF0FbCpZx52Ogw+zycUbVSOwaayK+2isBpo2KReEzhZ/kPhfYhcU8ucaTTC/?=
 =?us-ascii?Q?OKlSje7yl1PJWSKLGn1zTBB/pGJrk3xLxoKFbgao71RpHZw3zqoUSQbIvH0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d20ff2f7-e032-4962-0df6-08db6e82eae8
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:01:17.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to sht3x, sts3x has the similiar functions and operations
but it has no humidity sensor.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/hwmon/sht3x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index adfc11c12..ae384ced7 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -707,6 +707,14 @@ static struct attribute *sht3x_attrs[] = {
 
 static struct attribute *sts3x_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_heater_enable.dev_attr.attr,
+	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_repeatability.dev_attr.attr,
 	NULL
 };
 
-- 
2.30.2

