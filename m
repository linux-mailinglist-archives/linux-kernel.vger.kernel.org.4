Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18559746ADC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGDHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGDHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:41:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F10BB;
        Tue,  4 Jul 2023 00:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPuahvjUuR6gKMc2q/t+QjtwQ9KfNImPimh2W7/unIPfqnBUTxCIjKzOBC9xpjLOA4eEEtu2gDrcJO+10LU0OZ82isWDfTXChgK4zvu/TAncxyvH/4PovZj6h0vemVvDW+NyeUmYmueBkf9qrfCiGRsfBbUjeDPfB2ZUiKkegawcll0SyKMQTIiHEMYywK1hRVhT9XDXzt8bfYtMR2q6DpauC3Z/bh+jjzp2yp8cJI0nGruJ7cVMmbsAla+tzEDe1mwkO5B+al2B5xKCoSZ4bv3R4Ko2BDLGSHeYrvvmfivmYBS2N1p7CV74NbNUABJNTRdvbLHHIzoVmSk9xNfKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmwAn81Fi2V/5BSOKwBsKaM6gkV9mnrEsUDf7Vnot+k=;
 b=Z7x6SSlA4iOrrBy9iRq/Me/2Z5zcQOOH9GMpeAAZzbU/JplCvUKpJkvg89csFrdsp1ajkWn1tLz88nFvO3p49vR8Bs+dJ63CKemdqxlinlpBPQRvCLOVoz9RaG6U4vV7HSn4vokGkXGbk1KDjrCLh3I1O0s81UOYIa0EIDodzboKlhj5hV47hj3/vAo4hv+7KUNpLUT/EC+2qW3Il1/lxFg8Di862XZ9hop4EPA++WNvrJeugoilZFg0fd0h8zlQ+LYQOkUhgCS89R7jnZ11PCHQDJAXI7JnY5TZnbRL3T18sIGbt6qfcXnSWrI17A0wuj+wJXqT0ti3wZisSxB5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmwAn81Fi2V/5BSOKwBsKaM6gkV9mnrEsUDf7Vnot+k=;
 b=KpjpnmwUJ6E68aMGBiytNy+0/iafAOwnNz+or/FRWc2gQnCSKAjjrTxoleIB2eMLt4kMW41cKZPkWn5V7O6o8KyQeTDyWz1ZT6QqwJCHWCpC/X8nqdjnvOHWCGo4psYl0c9rJuw8CLnpxAQ92A9PU999BYBSeIPx74bZhumxwq/661xM9iy1ROcDAv9uU89U3AxlWx9eioAr3jlcf3qFLuA7pYp8SDYYwBUFmkx+gRM0DHnbEUU3Uj2fHcCWJ2S3Q2hgei0uBbXLK9HduWEVT9Zl0Yy25Ha5WWp5iKMIcHVbfDLuC2C31hvGNhjd0fEPi2hcSUvtw1rp26kGY02U3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PSAPR06MB4198.apcprd06.prod.outlook.com (2603:1096:301:3e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 07:41:48 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:41:48 +0000
From:   Wang Ming <machel@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
Date:   Tue,  4 Jul 2023 15:40:47 +0800
Message-Id: <20230704074057.1162-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0098.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::14) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PSAPR06MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdb4c53-b972-4834-85bf-08db7c621f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Zop6I6QgOxnr7xEYYMPFW2NSDJUFjVl3b6MdtozPr/kg274gY+9L39nV2pd23f7gFxBZR1aKYYa93J6iCsrcJ7r1l76sh8RAleo2p56kQr+MYfZ5eJaUOhuTHiqVF+Ffg+VcB08UkwX2cDdrCFogddlec8NlDSsPjlkoZd9NO27qPY0sDIgzt/OH3JbvcIMlFLViceX/iaYlUnPDYkSwkpUHMtPwl3kYOF0s+SodxALaXXVEf4Hprrf4kOQU+/KE2T3oKJdfu4f8L/MURP0dg5NRpy4gwcuhpsNKB3AOqsWIab6qW7J0LroVgJfG9A6Fkm2LuvFYJjfp9gHiqNyhzkKf7C5S1tUeZlC8OrwHyMNV/8USAg2FkarR5A0YaB5MJWstRoy6B677jU5PPitr8R2VhhGs6tIyAN3qQB71SELWnkXcaIGhQPBwlpguReQrV0dwSGhYLrC4Hf1APf8cfQj3zAOUyZsPn/HB2NYqWyM7v6vdK7XVOlMzbG4F8/r5qo4GgTMf87u67sos6OJlv2hPsexcfNLMtThTaCx/djVhlbSU8VeaiJsYb+9ctRsdXb1wDwZip04kQerw2If9sszP7BYoHtL+oSPHVEU/9gTIOpx7mTpNkkJnwoJKa8V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(396003)(366004)(376002)(451199021)(1076003)(6506007)(6512007)(38100700002)(316002)(4326008)(38350700002)(66946007)(66476007)(66556008)(107886003)(2616005)(83380400001)(186003)(26005)(478600001)(110136005)(2906002)(8936002)(8676002)(52116002)(36756003)(5660300002)(86362001)(6486002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXvQa1A9O9iBkD0DO76lytUwAlD6+LmSLkDSjjTV6x50IQLzyi5LKJiyt/KU?=
 =?us-ascii?Q?aobrXPgi3NPOcPF9rsNWwF3afW+B4vVs9Zyh4oUX3m0yJ1zCQ3NT62bvAuZY?=
 =?us-ascii?Q?fl17K6rS9Ef6Jhg7r5euDHhR7V0exQLwgXTC/jKevYNOlzQgUfsbv0gvGzN9?=
 =?us-ascii?Q?4frNSiT1sRkztnL39/cFmye6jIqPKqYTC3HAH08pCuf+n9hb+l9D+n9+I6F0?=
 =?us-ascii?Q?C5PbmP/zyMwDiArSjJBIBR5PP7HOTJ6RgLgZD14QdtN36A3slX+uq0maIUm6?=
 =?us-ascii?Q?MyK5sGlIQC0A3Ouyot2bM7o0KM946p4jcMhw8R6JA1lYqbYtzDAoNXv79GsA?=
 =?us-ascii?Q?+RoolkfKcopWLp6xkqbP/cS9awI6piQpSTuiBm++iOYGf8VVGtaoGELWz4qo?=
 =?us-ascii?Q?1BCZE3sq2qEmXnnOr8awfxFewROliSjnTn/XnfgHF4SODUGJNqoX8C7dUP9A?=
 =?us-ascii?Q?z3Ofa6sTaUNI23SLOjN2D6OxrbY1bK9J4T48aD6SC9UIV5RV2A7hlh22gvwg?=
 =?us-ascii?Q?rKvOG+5wnHEDpSZ5BkUOu3WfJ+fEsaQxWHT8gDZLQav4Uqrxa/IRGoLsKpia?=
 =?us-ascii?Q?dpUfHzISjd0CbboTlSk7bEGFw/7PKpbXGGhBGX1yA7K+3DwG8iukh+7sNzuL?=
 =?us-ascii?Q?gERtOUKyiNjrBbpBBjWRwxjPju3+awYeYpVldGaI33OMyCJr2CCOYBFml+Yc?=
 =?us-ascii?Q?zx5hcfQ7TRYmLYoUXis31VWFUFm/pkWZEEvnojPD/zqlnwYm8VRtEbA2eMUb?=
 =?us-ascii?Q?CHUPF3AOfiVW4LF65uUFSNhaWIJFlKinH5bXbs+0O0Fn0JuVaY6pd2hZNqrf?=
 =?us-ascii?Q?ApwNfBBp/CYARe+R5qGMUzHw8GgLXYrOc7bKwkMgHQt5WhLpsdqN1vQLDJP5?=
 =?us-ascii?Q?ks0nz34H39eZUYREsIG41UQo7Mha7Uwu4hph9ZNf7HflPbbkMt+aHtTmHCgR?=
 =?us-ascii?Q?Wv2dl6HHdta41CPx5Ido+tmcCkcFFtk9YR7FDntDxZrZD1OYEHKuoqVoY51y?=
 =?us-ascii?Q?Y/NVIIWHd2yUHEjC/AwDZcFJp0zux9bcV/1djHbeLQhiEkkmXWMtQLqTQMd8?=
 =?us-ascii?Q?VycmGCUy/sL8fJEjjdvG6TaWrX9Q+ujqeFfiX2R4JazRJwmnNOPfD9p2s0/J?=
 =?us-ascii?Q?vokV5ODkT3Itw6VL+QamwZh2s7s0LRelpqvH3RZoICi+DmDUzMGH3fOl9liw?=
 =?us-ascii?Q?2VQMgdI6xlj91l60JfVf+iYyORu9cSU3IokhRnWHQ0xPkGIBoWFvTvtX0ebN?=
 =?us-ascii?Q?Fc7lYk+Ifg7OH2owKRK5mvQbmpSHbixGEM85ab7A7zfVDoddICK9w1mQihI8?=
 =?us-ascii?Q?joz5yQNuHwbrsYThHI1wTmLgYPhVw28EOxg3VXxD4FvXKDxz3WcfA0UlX3Cd?=
 =?us-ascii?Q?Gc4KikrbYo5UEknatp7Pf4UeJSH0r60bUdQjSJc+88MyXzwX9EcIsisBIZKU?=
 =?us-ascii?Q?YW2D3Vzc+lL18H6KOgT9D9oNBxhL0gNhV+ywaw3gOtw+AunpWMUWEGtJ5k63?=
 =?us-ascii?Q?h4q5vKcPqEaQUnH4PXXNHvTMrmSNwRhoE06bAuDMDA7+KdKgDizKIm+9+GEs?=
 =?us-ascii?Q?W35bI3fZ6iPmISruikGMRl6v/NrcX1CTinZFXCNb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb4c53-b972-4834-85bf-08db7c621f12
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 07:41:47.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy7b4MTUgGLvXFTBs64WJtW+HHS2i8ehIhD7uk+h4uk4zZWMeJpYNwNlYnwDDbsGTuOQAUQuO2E09xfiyamteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the ksmbd_vfs_getcasexattr() is signed.
However, the return value is being assigned to an unsigned
variable and subsequently recasted, causing warnings. Use
a signed type.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/smb/server/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index e35914457..e605ee96b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -412,7 +412,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	char *stream_buf = NULL, *wbuf;
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
-	size_t size, v_len;
+	size_t size;
+	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -429,9 +430,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
-	if ((int)v_len < 0) {
+	if (v_len < 0) {
 		pr_err("not found stream in xattr : %zd\n", v_len);
-		err = (int)v_len;
+		err = v_len;
 		goto out;
 	}
 
-- 
2.25.1

