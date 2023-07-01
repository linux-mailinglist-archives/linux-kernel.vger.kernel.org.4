Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926A17446DB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 07:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjGAF46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 01:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGAF44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 01:56:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7272118;
        Fri, 30 Jun 2023 22:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNu/gZ5hvIbjBFlci3FpwavLNAl2C8z/L+K8E/Zb3Tk7EUsEYGiYRPmYik+t2OjoD/tHFnhx3vR2RDA8MimGjJYLSvfOgYr1w5zHaNQ4p4YHJGA+HjriKZ2lQkSW+kKF9He/B9IuDQz0Mg4RYGqubCv9dXLx1wQUFohmXZHUTATFJvb0eLO7nhi3fD9J2X5oGD1zIZ9Tx62nGLgb3bx2vk8sqSMOqoRh4APuPoYmTiqNUPfmC5E0DE+aUwNyh3+8g5QV/XYMtGXi1ylfM0BKABaZeQkRNQTZEAu5O+1MfmwTiJPXr6696nP1e22gIjQrmZnaExwY5IbG0LlNHB7fYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8xEEespGlpEHl+lvaqbI/NYigMOE2yrhOQstQMZ23g=;
 b=SRVA8/z6rLAh76TpIEM+oUXPuSbMBPAY9MoyqUcbUSMAXYOwWBSvzXjxjKzByJMTvKM6dL5U63YgYKug710WR1iKI/WEkmjqI0SCbT+t6rz08UOGQ3GO8WKPhV39zAY+PoWQyO2RiGdiHBu7QaA22fO5GvLJH7To5ArEElMzJ4vs8wtBBwtPAm7xRh50tj11zjN/s5ISUioCZkv+aT2yS40L0xQZK4vjrapDmzp4EccEbtuwD1l8grouGca5KIgsJR11fL5WQtN/PCulimFY92VDnSAwFIsX7cOP1EK3q8gR0gLSCUtSvWfy/UI4zhoRm3trABO5IK68TeIEpTMMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8xEEespGlpEHl+lvaqbI/NYigMOE2yrhOQstQMZ23g=;
 b=L3ZcNbF9HJyn3HMAaS4DJ/Vyuh1cWeKeE5X2CUxFYxLreyJOTaVDrwOvQnUs8VIXEjPoPbE0uIQXeIa+1nouWV/3bDP8q+pcPW/X/2svCcQIGIvFxGeHZtxgXF/pQyBFTcwM9qnMA21r8ASMT53izrJtMHAdy8A6KUbB97S8X4FU6a4eCl0iodBnxbxcGRbDYbyCmb/71gKRBa49ZZAuXDJo08lja/7bsJQK/2q5iejKi1Iy8T80aqOpc0Je090dgdTa+49UtIvUNV4iH9671GzTj1D95D7EJZ7FPbsNYh6vkPZyTXVWc5wpQToNNBN8kxoP+H3RUtixb8kwUuoDdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TY0PR06MB5659.apcprd06.prod.outlook.com (2603:1096:400:275::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 05:56:49 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 05:56:49 +0000
From:   Wang Ming <machel@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
Date:   Sat,  1 Jul 2023 13:55:45 +0800
Message-Id: <20230701055556.23632-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:405:1::31) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TY0PR06MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8d48ed-ff7b-4b72-9906-08db79f7f4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGFy6VoiiCh7QUOmCaHyGliWsOkxk8W74sav0KE45cX9rUc9OUQCrMGfj2wCEUVHZOwX8+BbrP1t9ahlplE8ocS8cBx32/dAs0XWuQzT27LC5tHFA98lbQIU+pSJLytQrT88V6M3WPZyuEtKyAM29rwRYFPAW91Q2G4Wc6nWZze2T/nF07hd7cPdBoAZnPrbyFeQhD3hwdcjSljC3hPHF4t7PHlIiaSbRv7HL5Y+L3pbjSsE5ldmum3ZoAjQ7x7XngVFh0Aae/mb+xtRsPBYA0k70++02u7/n8QsYAJ/c/9YtZIxckTJQwqNuqzmzb+4hlOYdMWdbv6aSANwbaPoiorBKjhVopyaYZSa+2IYoBugzD82e/9AzSHA5t2puljhBXm3XA8ubE5aJSfzhXlkICgMssYqvMLc0aZZzA/RJxpXTxwHUj3jQx4bgYOdgc1kCvn+uH6n1ReGsYTdsROcTUxNuu+DMQj5pEulgPkIyAKKLAahOMQo+qeAriCcCjYAteE8FPhkxeSiIXOvBm54V5RkAhQzKPu5vs5n3y5lxoYlmDRfZ1CsikZSY+sPdqpZUMtLY50RD8bKmqJFCdOmV7zIypmVwWdhi4o4ccVs5Ha7qKLTtERx58YQnJSXMP1D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(86362001)(186003)(2616005)(478600001)(107886003)(26005)(6512007)(6506007)(1076003)(6666004)(52116002)(6486002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fV4QI7sbpkCa6JId/FCQ+63u8FYfMEPZy4AiSoq8XfxZV4qPI7i64yUKtSbd?=
 =?us-ascii?Q?ELREwhC5sqBXKpYuB8yH0f7Ef46YnIWwz1D/uG1p9aaCbcV5WnakmDItVUKz?=
 =?us-ascii?Q?trLRkrFpn5eLlISlLesYmfhv1iMH0wDRv+PYP8id68GJY4hCLs+h/ymmcAD+?=
 =?us-ascii?Q?5PN1Z5YmLiHhoIr1bd4j8gpNx7eKaUwCQsycCti+4A5ebTlGLl8j72j6RzjY?=
 =?us-ascii?Q?qA0h+0FyPDMUquhdQAsl5+rCpNU/54z29BWFnn78fKWBbDQmGFxsAu/GHP1u?=
 =?us-ascii?Q?AzLWNyStEO/gvI8D8Lb1b1AZK+3bsWNrAL/wIZrtBlvaumU8w1MkJxoX7VPb?=
 =?us-ascii?Q?bYkSgzzgNOseokW14QtYxAVVCoNkjqT/qu3vImZxerYTOq8ftiC2bzNpPWqa?=
 =?us-ascii?Q?P3ZSdR3k9KI3RLPKqfvLzNvrZdb5B4YazbIfy67PfE2zi4Xu3kC5o0EHJsqK?=
 =?us-ascii?Q?6wRt+2onIJbgel0zL30bpR87Iw2l1Y1nKEs7XhxDf2lO1dpcCLqOQfNQW0dD?=
 =?us-ascii?Q?b2Nv0kJSD0wM7OeBI69Hqb8SvQFmID0ftEyEh+2+HOstnvGtDyLpo9YBxqs/?=
 =?us-ascii?Q?9j6UumSyiaUwz3shOom3WAmT4ULRI4r0M51Ikb8/ta37k7GCwoA7OFVT7yRZ?=
 =?us-ascii?Q?huNQa3WYBVKklE/BotmjPniY1Stb03+cs/FYeHnQoRXut98SEMEkdMt1f9y/?=
 =?us-ascii?Q?lq4R/HxvwUKqpuuzsex4bIw+U2V6h9UZYvK6+FBIKZ5Ht8wzGbiqxu4zUCxs?=
 =?us-ascii?Q?a/HJfZQEjjPr0GJme5QFYrVerKMKY0LT7tROnb79WJNCKwWs9/lvxkWqC4Uo?=
 =?us-ascii?Q?NODsm4+kBfwcYR26GfMEH+8jtuithwmv3GL6mHi4uaSmDyxzeMFHEqFYcrtE?=
 =?us-ascii?Q?ulyqbJeFWL/6bUAIm4QXl1IP1bX05GduYMfq+MAbzIrgjMMPtjyIuh2egtqI?=
 =?us-ascii?Q?E0VGMjPK+f/s+XesFWcbfk1Ud/fZ/55h1jP4LTgpHvwb4YKBZdKE4B7p2Yn6?=
 =?us-ascii?Q?MBQDh5vQ84DqHVdsFs0a1CKfUyfexdS3LmHDt4WpbM/YraxiKo+P9z9Q6zxf?=
 =?us-ascii?Q?k3aO4ZENeM83I/XoxPxLywE7yDMieYKGSSMvgZLYiWapd0c+K+LHO0t2vZdq?=
 =?us-ascii?Q?uMyYeI8/dXRpnFXvlo/DP3L41M5jwm7IN0IJd4NJIiGjdxA7j5zR8hahLrID?=
 =?us-ascii?Q?JJuK785QKHMBntAqdfKJvSTc541wUPsqiyk2jLRKYzaiKjd+IQi8pvHXG4us?=
 =?us-ascii?Q?VRMmPkZ2xxlWM3SiONHBPnobgXySFHjSFiL3SVWk2o5kqM8qm2YkHeTVXdsY?=
 =?us-ascii?Q?AZEnCorCWSY7db8lmhfIhdebG5du3RzxyUMQErrvPLvlnhtvWAfXbYQubr+9?=
 =?us-ascii?Q?yTEMprod30YI7VjWjzL5bVlmXXWYC7bXFSmRWQxcm/D9Q+bbcm10As9BSWqe?=
 =?us-ascii?Q?58FUiduVi0sr+ZMySOW1iFpBUJ9eyKvi0vqUCH4spcMmGJvehMZZILdaOMa+?=
 =?us-ascii?Q?D+4/iS1ZIeZ/ckDvIVJkTTc8ubkFE0c9jsNtwJ2lYUPFRJr692tkI+jKp8by?=
 =?us-ascii?Q?lm74Z0yEUxsKXko6J36Pmp8TLBEjKLb0jkjz1NUf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8d48ed-ff7b-4b72-9906-08db79f7f4d9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 05:56:48.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptWG/zcS82W/UejG36sUqNokgP7T1xtxQ6EwHaFEFUlC6LEsb4iC2szrOlxBf0Njx7EWcGMgVMHoU9ZFGAVWWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the ksmbd_vfs_getcasexattr() is long.
However, the return value is being assigned to an unsignef
long variable 'v_len',so making 'v_len' to long. Also, when
comparing to zero in the following code, no type conversion
is required.

silence the warning:
./fs/smb/server/vfs.c:WARNING: Unsigned expression compared
with zero: v_len > 0

Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/smb/server/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index e35914457..e605ee96b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -412,7 +412,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp=
, char *buf, loff_t *pos,
 {
        char *stream_buf =3D NULL, *wbuf;
        struct mnt_idmap *idmap =3D file_mnt_idmap(fp->filp);
-       size_t size, v_len;
+       size_t size;
+       ssize_t v_len;
        int err =3D 0;

        ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -429,9 +430,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp=
, char *buf, loff_t *pos,
                                       fp->stream.name,
                                       fp->stream.size,
                                       &stream_buf);
-       if ((int)v_len < 0) {
+       if (v_len < 0) {
                pr_err("not found stream in xattr : %zd\n", v_len);
-               err =3D (int)v_len;
+               err =3D v_len;
                goto out;
        }

--
2.25.1


________________________________
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=86=85=E5=
=AE=B9=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=E5=92=8C/=E6=
=88=96=E9=9A=90=E7=A7=81=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E4=BE=9B=E6=8C=
=87=E5=AE=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=E4=BD=BF=E7=94=A8=
=E3=80=82=E8=8B=A5=E6=82=A8=E9=9D=9E=E5=8F=91=E4=BB=B6=E4=BA=BA=E6=8C=87=E5=
=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E6=88=96=E5=85=B6=E4=BB=A3=E7=90=86=E4=BA=
=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E4=BD=BF=E7=94=A8=E3=80=81=E4=BC=A0=E6=92=AD=
=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E5=AD=98=E5=82=A8=E6=AD=A4=E9=82=AE=E4=
=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E6=88=96=E5=85=B6=E9=99=
=84=E4=BB=B6=E3=80=82=E5=A6=82=E6=82=A8=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=EF=BC=8C=E8=AF=B7=E5=8D=B3=E4=BB=A5=E5=9B=9E=E5=A4=8D=E6=88=96=E7=
=94=B5=E8=AF=9D=E6=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=
=BA=EF=BC=8C=E5=B9=B6=E5=B0=86=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E3=80=81=
=E9=99=84=E4=BB=B6=E5=8F=8A=E5=85=B6=E6=89=80=E6=9C=89=E5=A4=8D=E6=9C=AC=E5=
=88=A0=E9=99=A4=E3=80=82=E8=B0=A2=E8=B0=A2=E3=80=82
The contents of this message and any attachments may contain confidential a=
nd/or privileged information and are intended exclusively for the addressee=
(s). If you are not the intended recipient of this message or their agent, =
please note that any use, dissemination, copying, or storage of this messag=
e or its attachments is not allowed. If you receive this message in error, =
please notify the sender by reply the message or phone and delete this mess=
age, any attachments and any copies immediately.
Thank you
