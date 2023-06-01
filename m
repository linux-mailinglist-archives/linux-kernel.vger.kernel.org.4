Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A57719413
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjFAHXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAHXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:23:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AA59F;
        Thu,  1 Jun 2023 00:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1VTqbyvL36F6qLpx11UfMww/PJA0a52oF8T4CuSm6r4WQ4Jd8oNJ/zkfg8IbcmxRm1lh3FMNOUtJY4Kdwxaupaq5RZotduAV994PTfXtDH6mRnoG48jMev462M7YIcO5Pgnqug0Mu0Cc+Ndj6JzaDDZujLVpiIK2t5gvpoLnmSGdyjS4MI8V5zupS9k+/oZFPNz5FX7cYPCMomgQKd7D3QYjvkw68CiuSrjkbA2xoa66q8WKjt7VVzy/oZAw947b+gvNl27TGlO2mqIYBVAyRXns/vRk+TCOUihwXH++IgbXXrNgnjYcq6HKM0oqMBb2kY47w223aJWEyiy7QnblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l88uN5ZWvRDy9NX14dWCrtkPNdYCMJoWJ8b15qx0zmM=;
 b=f6Nk7CUlHyeJ7LXH32YOqUMqsi0sN97l99TdKQjaz5R5Of5zu4QvStDbGfjxndWen7nkwN2RISCqyGzxJ2ZJCQ3R+1KoNigkcpTVyDFdvwtfdHQ5gIVKPtqOYmuoqd/rIr6tN7ZOEAt9YbRy/Q0cxE+cgyu3mRrHm7Kx5+0Cb0x237f11lrSCR1Gj//Lh2yEI+S9CMY/NbnTvHfFzuf2DEQoGGzcw5+jzqbjIGkB/AuuZeyXYI1HTYbf93kxGjVP04Vq1RDgZqnfUT7uO83LgGsnNSl4Yi3Z+W3gav9o3Q9nItEFA3U94jeXMAaJ7kEukNVvKwuoyaHE0BfBBhQK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l88uN5ZWvRDy9NX14dWCrtkPNdYCMJoWJ8b15qx0zmM=;
 b=Ad4deVhIzpPLjxObwwIpJg6lCqur2oMQosPsoeOho0NdqM67uMvQKgsCPR8vN/DqPVRAUsWbgvLXIE1NcXCoPQr7PQK6p/KQxxt3pGMdLenw//dO8coKAsG7bO0dIi3+PF7lPWaMUVbjGO+XpmCGGl+BMWjjGcU+f1EYtTh6690jftlVr5TKOkqhbzFteQzVKyvo+EqtX+6+66zmQJFX0O71/MyjcjQywrwhQfFo+uixMW9AFj7SNg0PzM4k6iEPQFWr1DNlfehWL9lAR4cjv8soF+T9ZnPXpVv2RAvU//rgSI+7nF38fy369odphbGLDm3yrbGQ5HO2I6/4QuBQaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4111.apcprd06.prod.outlook.com (2603:1096:400:4::10)
 by JH0PR06MB6344.apcprd06.prod.outlook.com (2603:1096:990:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 07:23:34 +0000
Received: from TYZPR06MB4111.apcprd06.prod.outlook.com
 ([fe80::77d5:71a6:5a61:f1ed]) by TYZPR06MB4111.apcprd06.prod.outlook.com
 ([fe80::77d5:71a6:5a61:f1ed%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 07:23:33 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: fix the parameter bin reference preceded by free
Date:   Thu,  1 Jun 2023 15:23:22 +0800
Message-Id: <20230601072322.486-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To TYZPR06MB4111.apcprd06.prod.outlook.com (2603:1096:400:4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4111:EE_|JH0PR06MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6f9d59-5144-4eeb-1b16-08db62711b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6L5LQ59ZunK0yA+HWWXevNsPOO4+7oQTRgYYCkH0m2u3GVLSED9EOnYbvNMnaH1JFY/kZoSgsXA15LtaGOza/QYItao0IinN6PjsblcF0F4getOdGm2J3y5Ziry+u2BCS86o8+6hCUH+9tds7rMtzpVV+YFclDP1/RUbj5kL9r9qEN5u8fByHTUhBjpDTU4+9FCVpam9IM2YCeMw3banejjj2FWjszHXjQ3MJ27O8Hf5vwLi8NOVyiP5WQWiaidHgLJy+QtDNNFCxuneGf1rzi/4Mbp56klnhmqFNlgYtQ7Mtwx2Oc0a0qi9sY3fibz5BgtVxGi/j0aqga8D0X9mKDmgteQ9ENL3mfytsZyFUADLA33773lo0hnrCci03PcMENnMln+aBldLrRfjb4EOfTjEdfpXOo7tAGmLMmP2hYfnDt+hb/9CG030rKPqua4YjnLTqVuqOdHYVqQzCIs3pV+v/E1wip4U0G6YDJIdZ8x7vD7puQmmDZvctJc1dqzkDqsN+JxHGmSs1yWaQVbXcmIclpfWlu5pKhe/kmWzJjg/jc1tjdSzgNuyLUpQmE4GjQUgbLeq/9LdwFyaBXtZMRO20/P5lUWQBSRK/aNvyXt/9NMaTVYgCC3Svce9KE0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4111.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(8936002)(83380400001)(186003)(2616005)(6666004)(66556008)(66946007)(316002)(66476007)(478600001)(6486002)(2906002)(5660300002)(52116002)(26005)(8676002)(1076003)(6512007)(6506007)(107886003)(41300700001)(4326008)(38350700002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xuXRfkNGl0rRz5fegu+S03z4YFyxxloAXuuC4Xh8RPtD795BH98Fj20rR+T4?=
 =?us-ascii?Q?+MaL1ASYgfhQ2wFeYG2iHXsB3C4A/d4btYyVkPA8k2JpZgrFApJNbzTW/jTA?=
 =?us-ascii?Q?eicMJUIca9M5rJl69LTEN/h0ZwgTwGT9tl1hlwQNdKCvOoCkqzNri2TZyJ5k?=
 =?us-ascii?Q?v0/N+ASu46s4h+6CmW+M1u6F3nqgiSAVXqWSArZk8zKg0LxejmLn8227WEEI?=
 =?us-ascii?Q?mMihpBqxLx5RykPYe3uXhNLV1KrR3VXw6zgyvSB6DzdLW9cOFOOpISufYEFn?=
 =?us-ascii?Q?/eRq5GE7G37BcevVQYgwYxJcfZ0TKcugRzOlKNjsmgUJtlFj9d76fR2RQIBS?=
 =?us-ascii?Q?nQk50RGHaVhfqBZlyW1Puj+mq9ONkUso2fXZSTD7y4U0EmsNtxzt48T63NDj?=
 =?us-ascii?Q?lltaiaQSWewwb4YWVRvxEvZHya933+dRskVpYic18LbVWcMfDrazyXjiQEOj?=
 =?us-ascii?Q?8B2WMPBTPZzl+y7U8l9+a7jmI3nVQoFPfdGwyL/0NSlRpB0FYATPqMgi8EAp?=
 =?us-ascii?Q?tzlXhssKIDlqzTTZOQrZf6QqR2Uvqc27qtdzuqkNplUscQI6AW6AARLLpsZT?=
 =?us-ascii?Q?amhonDvT0v6byLkg6Pp6piwpaeWZbI2+YI8K/CyForVUAiBPysBpebKPd3EQ?=
 =?us-ascii?Q?JB06CFRHkJohrVjEDPwwGf9lcMOVqey63Z82azalX1OGFBziQOGujfjDgusZ?=
 =?us-ascii?Q?bdqQ9bXa4uHCBm3ZqECWiAULrKJjhYz4kyQg7ffc2g9u3nrnir8B6g5itxdE?=
 =?us-ascii?Q?QN639nYcnW18WqKsvUkQeOqPR6nb+CUehVma2tYLXcv4u3f8EocrLRzuurbX?=
 =?us-ascii?Q?OjjvrEGCZWb0FFvQbdXWMP94O396frYy96sjKRhihjeFzh2Xr4mqGASWgpn5?=
 =?us-ascii?Q?vJ8eFZuLcI3U1f77PiQXDwtSTcL+CpU5vZVS1yU9vMp/xRWghBFYPUabNQgr?=
 =?us-ascii?Q?PiZ3x74Gjt8nE+6DjcBevLneHJf9S2Kk0k+sywyJNoV797uutkhwUBBYRf4C?=
 =?us-ascii?Q?Ned/jJY3iC75nlc9iIMs+zUDFfWIvJie8Dg1NZDkjChSQJcYC9dBy1sLqbVq?=
 =?us-ascii?Q?veyzybrE6AN/Cdwaof1971CX2XziabwBHMzlbi2HL1jTn+qWMl+QPQWPl3Xw?=
 =?us-ascii?Q?64cYmlWqT/BOXUXaRHoSRPkPiP07KN2QqedfmdRigRglkMf/yM4ynB78i7EZ?=
 =?us-ascii?Q?zBe0gACH8FaYHS/CYgDW/p/k9i7mx5QbAV26t6u6v3hiX3B5hWAZhgCbSb+x?=
 =?us-ascii?Q?VaU5gcU2R1KEsl1oyKV3fflOa99IytKrAmU3zk9TxuKGivh+BUZ6E3CEimdY?=
 =?us-ascii?Q?d6QioVLWaCvw2DdnZ6MI/83ajQK9Skrs2l0+jbTo+WI61pKgUDTzzn6+cmfk?=
 =?us-ascii?Q?Cna2tLAzvc4iOEdaaIV12cmveiJfkwt2m7bEqGFDLRWkKU1u2k8cZXOeSwXC?=
 =?us-ascii?Q?ca5/WCCEX8ByqMpxJgzGKZBzA9myJCF6bst30NmBr9rbJy3qaGHsPvVO6do0?=
 =?us-ascii?Q?GCyWgWb8CKgyHegMiskvUay9PUuiGzVZDXzJZvBNNXYoJ3vP8SA0Njfv1VZ+?=
 =?us-ascii?Q?nOMqDPQOoDYFqndtFP+PE6I30t6xRFUx+TtbOSXi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6f9d59-5144-4eeb-1b16-08db62711b98
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4111.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:23:33.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8V7WKDa2tmdEyQrSeVMnnoU0WtJaYlgrjtHBSmsuEogi+CX4QV4qcLxbBm2SPSOtCdViCAV6XSqUG9Cl+qfr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We assign the variable bin to NULL,
fix variable bin reference preceded by free.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wirel=
ess/realtek/rtw89/debug.c
index 6f418f14ec3f..4541b4d48e69 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2982,6 +2982,7 @@ static u8 *rtw89_hex2bin_user(struct rtw89_dev *rtwde=
v,
        if (hex2bin(bin, buf, num)) {
                rtw89_info(rtwdev, "valid format: H1H2H3...\n");
                kfree(bin);
+               bin =3D NULL;
                err =3D -EINVAL;
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
