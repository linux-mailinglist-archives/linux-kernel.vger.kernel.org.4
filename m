Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D172FEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbjFNMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjFNMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:30:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20703.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::703])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E772680;
        Wed, 14 Jun 2023 05:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDeoHLPUq+gACUyfhOK7YpOcBqQEhQvI0vKknldgLh0qt3JKcq+BQR0Nrqe/fOTrjKsmBd4ztsmcSMhbIlcqEGLI8cxM3etEhqSUGCYX3jmrpD3utvwReqafURH6nyoMZzYmrRLY1kmQ7AStDmK0IJ9OEcuEb1FdFqNqs7Th26xjIdkuAJ21GV6kqtmJZoU6Qk8vL1neVEeiWCBsCYvP1/831zE/Z5N1j4a8xR1Xaj6rIGgz9CCyFF1cXWsayxKEHE++s/ezqWCDIRWy7ZsV6jfz1oe3KAvSI4x8zFqKETZ8hEkl/OuZPyYpOT811FZUE/C5tQuTrNyqOctMhVTo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf0GbTXvMdgj5kqMqes5fyhHy9P9Q++NswyhnYonv/0=;
 b=gJqrsb2jKaQbahEffpKI67HtdR05UO2tWgzzNL4EFEMG6wf2VhN3Gh5VjMQEEJfP3Se3yGbRckv8Tq2VqHamp9pLU9sxe0Yc/5pYO/w04WWPWG61dnmlCC463+ECmuMAoBpkGf5WbVGdCzl1uPAGicfWiFNoPhWjeE+nC6FDLDzV8zgAAYwE2QwhnhGHXGInnB1F7cpQOhuYnKRo1jSUC0A9E3KzICGBWwYhip+MvW+7RaWlRNwSRD8hGr6fd8oNNbcV832SBzPxLTOaSB0wIqPsilSta4/YwXs+ioVfBU7f+lOEzA7Zopr3bSvIwSDTDKpHPnVvEv4Xp0rEyWEoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf0GbTXvMdgj5kqMqes5fyhHy9P9Q++NswyhnYonv/0=;
 b=qqcKN9mwh02OiOgheinuu53JcMZBSZLqOmI7pcbD511ODxKB7gT5t2yrsC+TgIFb8oE4l4AzPqk5TJFaitFj+p23OWpSjL0Nlw0cf67bB1dzwc/6wyw9tOZZq9+CsDyGlWpZgwK+TR7WHW17TFh3wOIL/kdg7XuBzooyHmk7KUXEm+HJO7hBkGk7tjP8q5Xic1z9jhiN9357Bka6n/++WL/Sf+Exv2z1gVoj1qwXu8CKeWwOkkxNJYs710fBYhh7Yoxtx5ef6+u6T3YTL4m+f/r77WzoBSlJBkG1HdIN7M5IcCYmC162U0R0pAPYyylQDtPCpCLdp6RKLN6oWLJWcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PUZPR06MB5849.apcprd06.prod.outlook.com (2603:1096:301:fb::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Wed, 14 Jun 2023 12:29:22 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 12:29:22 +0000
From:   Wang Ming <machel@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs:smb:server:Fix unsigned compared with less than zero
Date:   Wed, 14 Jun 2023 20:27:57 +0800
Message-Id: <20230614122808.1350-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PUZPR06MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b218ec6-9b19-40f0-f2fa-08db6cd2fba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01OBd+oQY7pB0z0vgJWYcTjvEq7bQER+k3jvqUbEAJEAG1CpqHaBhFiiFQqsmRnRgU0EQWE/aKRUFHP7JnMjFl5R6Ep9qgM7ayvpkQrdXI5oUraIPHwG0XqhEr3JrmUB03PxkAI5yuImFZcn7YS/QU2KBgsCYlpnueoTG1ydiJ9ybraeHiKbqTud/xZo0PCcFyiNZQ2GZkJmQv3gytR84ZchTKiSNdb6nKvfZJ/MJnQ9pVNoBCSf/CsNorMQbInIVnrgII2EH8p2dky6bu8FxVqCuTEjc2TJl2Mx+Pet2YsrnrbIZgoQ4E9zeskM/s5VWR5rX0xvWp+96BMBx6TOv634PG2WELUaucrU3OIuYt6LdDtPS5ay3J9aHuFcddaeZ6zuMnFO5Ds4UvBBeZzYwktGS60xDR+lQYlMwQEiKf9iMcXmobwfWuO94HbKFy83ge/qYNpMUviUd3WBD8DcsJOnyV94q95O7i1TVm4lTeqIuPyQZCQQdzY677YffjzrCzZzvbWynRYRhhBEd5y/DE0Bd02A/Ze7d2dWkSP2BI8SkQ//0KEWBNrE1aCUl2q20vtSYeDGZh/CE1XJOAcOVtVSgKAfhybsL+/79+pqrrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(66476007)(66556008)(6486002)(110136005)(8676002)(478600001)(316002)(38100700002)(4326008)(41300700001)(8936002)(38350700002)(66946007)(186003)(83380400001)(6666004)(52116002)(26005)(6506007)(1076003)(6512007)(107886003)(5660300002)(86362001)(36756003)(2906002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efwBlQSlhJ5krHXPNJA0dSee+s5jKVofkqu5Wx6nv0VrXTNGkVfeftt7wjtm?=
 =?us-ascii?Q?5le6K79sxL8wHbZ8f5L1SoldM0EeeA56uielyl8w2ziBnJfvyTOi4ow0mai6?=
 =?us-ascii?Q?0fUqzx24J3IujICcmylPdEJ1u7VOQuDzYtAL7LT67+GscnCPLEkum9TpriXH?=
 =?us-ascii?Q?F4cM3pz70kOFSNTEKlDm2PIuYV2l7XaLuOO88J0+yUNrfOPecEy2UFa5+qIP?=
 =?us-ascii?Q?WP2Bjfq69FQgtV63zYI9Ll49HAJ95Eo0/aE9zU28COZ85UjzhkAH9Dl4E3p/?=
 =?us-ascii?Q?RHLQW1qmxGCdkmCqK0264OyhfJWQgui8C58ruO+FIRoA+g6IdTC5bsMu6mx7?=
 =?us-ascii?Q?zIma9hMcccER6DOruRBKoob+y4UCSx8ISrjzvjAFy1pPPDRNQP1mel/j7jAG?=
 =?us-ascii?Q?fZ8CsemCEHUzAMklwOQDvDzYtaDDcP4X/OSfm5ApVqdWL1R2XBEGdERsv25P?=
 =?us-ascii?Q?53r5Bg24E6coYFKifnBUhhftfbx3X0HTfGDdo1Pjvtyd/pa9TMUzTGD0o3Sh?=
 =?us-ascii?Q?Q56x2YKtMLB35Qh+aD+Rd0CMNvLAuzqTwBOQceoXV+k9oEr4jqlduQgMazaV?=
 =?us-ascii?Q?GkzPx0XtwSQKF886ri9EnBRF561TG6pCvtiou99YnDGTB6j8k6lmYvz5R/Wf?=
 =?us-ascii?Q?IcqqGB/kq5CvEuFAO2baEy2c6RzPgt2WonbYTPwpYpAyiVSKwGOOHUKwDtxN?=
 =?us-ascii?Q?OxLiCO90IwZE0XNp3h1wG0EDNQTjWQOCZ00jBYXJHNL1YHomJ9gixDLVi+fQ?=
 =?us-ascii?Q?9Ftc56Rm2BoI7zlfsaWr18S98iqVXFXDQNQrkoSXC4mVFw2bpO7Is+K/VWn7?=
 =?us-ascii?Q?cvVspd5LC+RhR26a+EMq/R1RuIHYgjwyxNXLy0ohnqUc66PnEY8bUya18ULw?=
 =?us-ascii?Q?WhvMqXgf5gUZcoFKf4r4NK/HzF49nbdfC9mxo4Y334RSs5SLhwuey6IQNgP9?=
 =?us-ascii?Q?q0VYKgRKon5BySK9yiq8PA/PrKdT5BoqukLHvYDG03RSHWyBwmJKhxVXxta5?=
 =?us-ascii?Q?UBwU97GuNVdcA9MCShptYDz2MMFX6i5c2cBItS4HERAs00IxR80WtO8wDsjg?=
 =?us-ascii?Q?x+1j9ZBqtpXYT3XDOGpCfqr8+JIshVexqsWVC529Bb1JDubHCEkESosM+2le?=
 =?us-ascii?Q?YL6pVpX/8q7/d7kBwAKn7veGwJJPXVJeaPNsFO41v/UWA1I//BaYnPXtma54?=
 =?us-ascii?Q?um6jOsmsO7pnrpbCd3PxDzDOCdBNIFuIAznHYxs5PiDe7Tlg6hCv6ieV19x6?=
 =?us-ascii?Q?PB+1Z8LH5nZRyamiBGL3atMz6TZSWvwW2fNEpAZ+FNK6hjtj5BleFOymOCms?=
 =?us-ascii?Q?X4tM7YR+HceYaICdfCCI+10J8j4eK9KCj4+AVliKTbqydUWxhomzuezwmBz+?=
 =?us-ascii?Q?SY3qAvM8sJrM42a/ArX7tiu5XeS89zYsfEM+yW53aS743yX+tZVmv4tJFE0q?=
 =?us-ascii?Q?KzfmYOC4t4OzgfwA9EK7VopYICn5WqHoLUjjE71nbpJiNXwqF9MPDaknQBOn?=
 =?us-ascii?Q?zYsXfER++FGAbOO88/kEcSJ/uX8PoXRlwNlkb1IObAhfVt0wAzyuGOimp9UG?=
 =?us-ascii?Q?3EaOAos6hafarIn4gUdZsXQD9AtSzVsaNL0cduj0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b218ec6-9b19-40f0-f2fa-08db6cd2fba0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 12:29:22.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCXCQj1AvZ53KpAH3KsGugUt2fTI+tcfwT1N2I/ZlB1OIPSB/nlYDsGJ+XA2DPufAI1nBV+/6kjw5Bc7keFr6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the ksmbd_vfs_getcasexattr() is long.
However, the return value is being assigned to an unsignef
long variable 'v_len',so making 'v_len' to long.

silence the warning:
./fs/smb/server/vfs.c:433:6-11:WARNING: Unsigned expression compared
with zero: v_len > 0

Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/smb/server/vfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 23eb1da4b..77909b298 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -400,7 +400,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp=
, char *buf, loff_t *pos,
 {
        char *stream_buf =3D NULL, *wbuf;
        struct mnt_idmap *idmap =3D file_mnt_idmap(fp->filp);
-       size_t size, v_len;
+       size_t size;
+       ssize_t v_len;
        int err =3D 0;

        ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -417,7 +418,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp=
, char *buf, loff_t *pos,
                                       fp->stream.name,
                                       fp->stream.size,
                                       &stream_buf);
-       if ((int)v_len < 0) {
+       if (v_len < 0) {
                pr_err("not found stream in xattr : %zd\n", v_len);
                err =3D (int)v_len;
                goto out;
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
