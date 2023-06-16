Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48326733378
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbjFPOYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFPOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:24:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B01530D3;
        Fri, 16 Jun 2023 07:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1j5z4CUx9+RQ1TZiAva9Skc2Z1cHMUXIs7Xi2xcCNUbF3wsOdO1oD0qR8oUtkFq43xWRBsKu5KoVAf/7XvTax5SzodSbuL6JU3PYfKuv/RcLpiAZkd6vrSn3DSiGVDcYUChc6a/P7UT/mIV6G8ufeX+D1AWSiFD3C66eIjhC//IE5CyzoU7MAJkPr+Tkba4/T05zJ+3FyeobhcQ5KuCAt0PjZ7Yw8HBK74OiPh0p3H1VZDjMJ30bLJabsV3j4MJGEhgBs0DwOF5SYkV05OxCjoUFTJ1isdcZ8iRMExOHImfnC8TK760xEa/MEbzVHd7TMBtuVhidV2WD8PUaAFCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAjZHGH33o0T/Bxn4xjPISH0ZtWZfkGNYF55lq2QVLY=;
 b=RgP1rhp3WIMHPnr9K9TsuXTcPJayAznfsOqs/SQuKFn5vPJfwhMD/QTWqhUNJs/71kMgdsBJ7WBR7HXS69LS/d4gsQsp4UJSUKyIz/pxOTvm31bQYdFliYxN4gEMOAsq08YPGlmnZgM0pHbAOgG1EQbYR/DoiwWhcg3heSl8AanhiThwpXQoX+KSyNrz69cseRFPoT0DsdsYus6R5XriZ7wbaJYrEtoWbZpZAH8uNy5KS933Vo0D3c+aBFLw9cwSCK/+ytVEc5+o37+FyKrtEf96u0PoRVuldVLvUHfJwel6RIR7BfCMfaqpitK0xTAps6rlEKPqBietcrSydzaasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAjZHGH33o0T/Bxn4xjPISH0ZtWZfkGNYF55lq2QVLY=;
 b=A0295nrjZsotrepa4iECmDmsaF+9nerUy0XwCUjraI2H4l0Iaqklv3Omj6UE6ziGrImhNxl2fbUXubR3MYYvwpvou1ngQE9znI4q0SruqELNu1PIehKzAU7GEeqL3jpwszsmG4P1w6bwsemOif1BBRN/a8vgPdluE+aUMexqqReRwhv1mYQN2XfUZllImvti2pEXdmRMwBgglrrj2usCkHc9Dn/8/OwvlBOvi+JB0tRBale+tJ2iIeFnZUuCfcQFEVVCasSEDf29+2eQ0Rpl9lKH4Lg4T/0YGjnWhzgEKIMzdj+jyKPW/2dbnuTKfPVEaKBb6uL2AS6xh+SC5QrJRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYUPR06MB6098.apcprd06.prod.outlook.com (2603:1096:400:358::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Fri, 16 Jun
 2023 14:24:03 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 14:24:03 +0000
From:   Wang Ming <machel@vivo.com>
To:     linkinjeon@kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs:smb:server:Fix unsigned compared with less than zero
Date:   Fri, 16 Jun 2023 22:23:04 +0800
Message-Id: <20230616142337.4656-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYUPR06MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 2195d473-fd7e-47fa-e0be-08db6e755571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZZCcjmRf9icI3MaihI1sWYxYft1LS7VgeeEOJfQea7LdwaPxB8GK29hKNC0i4T4B6EQ5eT8EYyjGtRNURp023apqd6gA3Vci9tRFAeKNNS1+HkAoqVRPyGghxb35oC1QnH9XviLlQFk91diqcje4p636qLu45BbaegcSYPJImey7f6Yti+Kp2d2lawGiQTJJdMTWbkQnxGt/kKCjFRwIDozkJ2mPnvA3pkflidqNRhQMyF/ADF9xh1O9ZkiVEuxnmIMd95jKUyP9wdHoL7eZoT2g9NjKW33LHzqRVmV4MknWY57bPV3ezE6HbkBJ+JL8FhPdDuY5f8lmQMZx680ayxjFd1H8cIC5Epb4MuwURlCfRe1fjYfw2tn8WLJ7pHYwzDl8KyJh9dHAsFhTZhe1zJkdA1EmwODO45Hb8Sdr2NlnaFte6JxAGiXx5eJRPVYVhDe5ZWntLZ5QCq0sSTEISi+q/tvW/CcVux3+VJQCHSMDdP/zOLJPvZApSaqH7y+/p8oDWKiGUDmu/P1x4p9hwmC2UcJI9olUo5YvlaeJjjzQavOm9PVCIOPrr1OGJiaV8l9ssiiQ73P6GP+dbgqYzf6Lt204M1ln1MFY5di7rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(5660300002)(52116002)(66556008)(2906002)(8936002)(8676002)(66946007)(6916009)(66476007)(54906003)(41300700001)(6486002)(4326008)(1076003)(26005)(6506007)(6512007)(186003)(316002)(83380400001)(38100700002)(2616005)(478600001)(86362001)(36756003)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kMbLFbefwAna/+pfMMbROVUSozyN0T7qCIYyPj12gy2WzF3xoirSotZtn2QJ?=
 =?us-ascii?Q?iQca4Ien6g3pY3SYHc+s6lQF7tU80NXcy2X+tL7cctCqZAAcLPwf0VhVh/hs?=
 =?us-ascii?Q?F3dACvr2zbrHvebq2xgsPGn0Zn6rONbphATt91+i8g+RLVAqYqrhaa0ObFDS?=
 =?us-ascii?Q?QRDwm/f5XQyNu//kuU1dNdj5WaKY68XfMapVbLENPsJ+P2nTxuIqy2vDNi5N?=
 =?us-ascii?Q?aZj2MK2wPft1GlZ+u6gu9WGj1oC6RVCGnD4GOlieN8QJPm8hXEGphA0AwlaN?=
 =?us-ascii?Q?ivwiEHxK8Om+OSXahqmyX5hMFpKq9ilw2qXuZJeLiCKGXmDZLLZ6+q7lTvGK?=
 =?us-ascii?Q?OXT9XN478tfY3d7LotHBL0dz9Xnx9BWQl2WCyAfcVGDC9JHo9p6voAWcofIQ?=
 =?us-ascii?Q?kfaRnxd+hLZ4QXK0YNh+9/Oqyeb+V3WD6r0m5OqQI/Yko2OFK+74pjn/1xPq?=
 =?us-ascii?Q?YF3dGWZIOLZfkdg8XVzH+EiffJRsCXWok9TSqjpbQvxMnfk67jI6DnD+LkUv?=
 =?us-ascii?Q?PxfJCePH6VIMuWC4P+DZ0DUf5TsGKjpn5FsFVMiPH40G0E2KILaFOidD/dfc?=
 =?us-ascii?Q?SJtoqsJIgyE2MuCodg6A0fvbiK+yDeUy35QrXfeYfudPp4ezX+KpKb2sP1gP?=
 =?us-ascii?Q?tMe1yIgLMfn7uZbb6aX2KDwDNSk1oku91rtzMJvor+J0lV8n/yv2ma8g9t/y?=
 =?us-ascii?Q?1Jy9HRZufcq6u4AGczV8hPAXksRj4ko1Kv4fTpjh74DiwkZZGGb/x2E4UokU?=
 =?us-ascii?Q?0x8dfnjSSm2i7ADjtkvK7YGJxru3p/YScNLKb5cx25ZgeWrKMGeJM9a1oj2K?=
 =?us-ascii?Q?QO9CFq5jFVS7VjJ1gUrfaZHO2m2gFOAnA8UCbWu2lGV6h4cfslxaCJkusbAu?=
 =?us-ascii?Q?SPRH1T1hMQoOnQZLQ09mfkSsN3Rr1Ijii9Q4kqHVsEbzabHZqn9buruSdRLX?=
 =?us-ascii?Q?zHy4osKs2oYS0Wkxs+N0jbSrD5Ls1bQTMHW4v99coMSL36eAnTjsSOSXxrs1?=
 =?us-ascii?Q?3Hz6q1t40fnV+NXJrb5TfbIa4GOmuxBa84rcBGcbHABKOW3zj2+aTqwgZuX2?=
 =?us-ascii?Q?eCsHB1yOWlwfuVABEI7BuzDrYqOF6AqKtqBQLdVkJbC3GzmVVnDom0pOhSlY?=
 =?us-ascii?Q?92qrupbO9m7LYaCmuIj6vdNnm9iq3fbeV4Uk0UPq02+adI/H2pD2lT1nNQ2H?=
 =?us-ascii?Q?QHWP8iphQKqzAFgVY8xmMgLD/+k19j4Q2PB3xXVXMXDE77bmD5bKPBWjiINT?=
 =?us-ascii?Q?FOKyKo3h176J5EYcXZYoJ67KqDngucnpnBdTCFXP9ZuG6hEMh5VPasLlYndV?=
 =?us-ascii?Q?DlDLpE1Bwjep7THHk62eGzqw241AOqS8VzXeCJbi+dLDMkZfw5VMY4PwXBr1?=
 =?us-ascii?Q?Z4UkuvpzRhJV5SZ3fxxPUc91c/LPs2+/v6D9nNYKt2uaGfXvnBH/Xu2IDR39?=
 =?us-ascii?Q?vgPFKUVIbc8iwkFav3uKn38zwbSki6GFSaywGuyIUm2oOfv4vKlyx2vqpq2o?=
 =?us-ascii?Q?+6jnjeFTfko4Lo9UDfX8KQS7Cdpn+nh4gcxQtmLbyHLDnt4mCxVfQezQHvm4?=
 =?us-ascii?Q?CWCnHvW8h9lNFTCCvIfhte410o6CDSL1g3r2h6vl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2195d473-fd7e-47fa-e0be-08db6e755571
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:24:03.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glHAzKNgNt4vsgTCtWgrTcvaq7BQp13OmpTdBH9nUHY51a1gJ/0JCyqGZse3KT1RRq04IFx1/wNFKJqSJNpeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6098
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
long variable 'v_len',so making 'v_len' to long.

silence the warning:
./fs/smb/server/vfs.c:WARNING: Unsigned expression compared
with zero: v_len > 0

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: 53ab6975c12d ("Add linux-next specific files for 20230609")
---
This version adds 'Fixes:tag' compared to previous versions.

 fs/smb/server/vfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 23eb1da4b..272bcab1f 100644
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
@@ -417,9 +418,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp=
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
