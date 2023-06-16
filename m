Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF1732561
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjFPCtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFPCtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:49:14 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA8294A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 19:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNL9LJnNcc5uPfnMBQ2zJz0xexNUPqzjB8x5O406+AYACLTBSGV3zd4QC0T4ALQnuoDA6lKeo/2acn8qEKkS3Hq+X8weEf9hVhVm9BCE5oBsF35Jh749aLB+LCWKHJvqgiVCyfi+XZaapn6YxoVCuvw9NkPIeF9AK18kb0cA0zsJ+WyjjwhcjBNKY8p51jjjUtbUVOH5nZ/aloBQYysiK9pyHta7Bm1GTnlV3CH/OAT8RPjZCUUR/2rVcbLa/rHIeQDZG7B5OUVCn5rq0mqJIDl81hcuEke7sSQCArqelBEe9h1PmzzyxCqGECBWKU7QwzqWDAz3i0CM93dH4WVdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSBWgVjUhOeerx3olbAot02ShMo1FJtdO0LIqH+yGVE=;
 b=glmKHtoHr1PatI2SLc662LYbhzQ89ep18OiAn6snJwpgNHU5XvzlnfrL5LoW7srzeyU+VSKqfrrGkNy0lDspG1TN+dJrW7jm1zHVSz/e+0wwrfIgnFp+SZLnvIjEiJnKknseXI5Hm3cA01PpviezOX1z1lIQTOl9CVfRRVR7WlCx3AhM06wERx6xMPsTI9YO0T0s8m4alXwpXioOl/Z0+x8RbSZuvcVeBK7JpCjXWdH1UdH40lkFW3ooOk6oeBqMSpVb1R+RT/2nnSuGmcCY1m6P6yehVQ6ffTMcVCfGGt/JIEGWpUULxOaDnfazYeismW9S3SpTzywJG/FGKoqH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSBWgVjUhOeerx3olbAot02ShMo1FJtdO0LIqH+yGVE=;
 b=p8wkJ/200jRRN4iJXiA5iM7O+TPtcCtnsVwy5MiFunX9FO+M4Xi8TbJXg3VnQpUh+5RMureWpqJMVkt0ra87WZ2HwYFuCDodmXBseSsgmbWYMlSvA2lda/9gWHylg8YFn8BOu93c6K8l3ME1uoyoLLOU71vnwKvfyGxjlTWmIIU130kTijZKjG1RZ/aIowQOhG6ipcoJzxu20ecIr2FdxPffvZMhWM/oRAMLhCQDutjFYuHmzFtAspxYK8usTc5F7G5TIu+09xta27l2Njp7ew+IBXXwbB1oQvMImFHuMTMIdaebQlZaHOykJPxTzvbk0gbwzCEolkLtRO/udbvX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by SEZPR06MB6040.apcprd06.prod.outlook.com
 (2603:1096:101:ec::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 02:49:05 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 02:49:05 +0000
From:   Wang Ming <machel@vivo.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, gregkh@linuxfoundation.org,
        Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs:dlm:Fix potential null pointer dereference on pointer
Date:   Fri, 16 Jun 2023 10:48:24 +0800
Message-Id: <20230616024836.577-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYAPR01CA0232.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::28) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|SEZPR06MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: a73c0201-14a4-4d3c-a1e0-08db6e143f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 020LSNA+hZ8TjVVwzNutrO+mTsEXDAdPeaP3jymGIFWfpaSMctdKOi3ZX0gKllSj5JlQ0Vbdz02Z+phTSeKEpB3aI0BsI/lELdXp1JZAQOt2pfFtGz4b/pvvK+sLST6lcOctyfJwvlJ5C8O75F386wf9MD7bYtoed1let2w6QE0vg2/CWV28kJbQNzFxxzu0PWMrGf3F5nH2C2vnKdN7349m8o4AA+WNIPJgZRU2Ed7YUFiMiVXj3DjfG5uWCo40eQP8ECp7q178qwNsZS0a78kiis8IzkDj+4KKLIFvKS4TqI40QMy9TX6o6aoQQicnkzYxMJloWIoK63BCgRevq9+w6PnpCb6YV5gWU3LpFiBRxvOWLMDPPOGsbUVmwjsi9eQ5uF/U/28uQoSUwux7gt7xjmqUMJtzz5a/1EVml+toq/t7SWnM4XeYHUhnmB/2sJ35Oetn/aLOKEpJqDvl5Qs3St2s1S6fW14ivqXTnT2ehenC9Or1XcgJ5iFQiwNwFmxU0ah2HbX39wnA5GywL3lFLrTJgvD35gmOY1neISMPiKwLR0/L2ZRgq0aUf6FawoNMZoIOWxgCp0yzqe4QRyck6MQj7kQJkpvQYMMw+bXcx7sneSJxRtidn24KHDt4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(110136005)(478600001)(6666004)(52116002)(6486002)(5660300002)(8936002)(41300700001)(2906002)(36756003)(86362001)(8676002)(38100700002)(38350700002)(66476007)(66556008)(316002)(66946007)(4326008)(107886003)(26005)(186003)(6512007)(6506007)(1076003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwnfegnS5uyDKGzXwVAusFxThPNEkmcXN9eqYsCLdu/B4ZbNUB62yY5x90B/?=
 =?us-ascii?Q?5Mh3T1OVmzjA8MUibdg0IH34qzXklsmA4y4LCybe+T/cFcvrxQlNn2hQieP8?=
 =?us-ascii?Q?O2hMuqsZ7VqOTkFk4RCu07NFVXM1stFkRy3PVA9Y+wMsdkuxqh2M7mFL+pGt?=
 =?us-ascii?Q?7qxG7d+WcY+tyNypzkjG/urMGVdU9EEOZL831SmO04w/xJ6cMhGPKuPW00E3?=
 =?us-ascii?Q?NO98JYVLVKuVpTwpGrjseKZLvhVwptZI35S6MeMKdaxfV51NaZ9YwzuBCz1F?=
 =?us-ascii?Q?HfW1lgVlLjORDiaxRNCSAM8KQXjHVa7Dp4pvnsRbyFcGuxlq5HzpV8YilYWC?=
 =?us-ascii?Q?P9Pf85S+bA5oSEnZGC6VLuJ52KwnnnofBiUsrhc6SCvgxndDhzJzEBZlZ5em?=
 =?us-ascii?Q?9UUTRKb6WFKk9UZ1rIwJgfv3YLJlb0ZIb3T1CbJ+01Uzv+igkTDfnw2XisDN?=
 =?us-ascii?Q?V+8EhYJA1IHno1Yws9kAATMQ2RJiSp9A+QB78k8N6biSLMpJpc8AVQpKP6O6?=
 =?us-ascii?Q?ONkIJ5JIF2+R8MdcV6fR4kYyZ/wAKl1mXdxzlzflo9TwSJO54ehujQeZz7lg?=
 =?us-ascii?Q?DBji+gQeZhMtSsmsq4OTJgZVSIzOHLk2LaBV/oQyom+9bFaXceMsgBKgFtae?=
 =?us-ascii?Q?IxPDa2yxQK4tpQwgq/SemhZwGLeYMkuRCONu2EGsPJx4oFvXimbI5XMXvbOW?=
 =?us-ascii?Q?JbePjS3ngzYady0qL+1YjXJmkvxMvPjnsWGYH3NOe+hYpAy9zuL75eKChDEx?=
 =?us-ascii?Q?/gA4BTIRRd8MNvfPaTY6Dr7SaW6aYnuGPlCrf24PhzfiCtvsWPCorRYqCdLU?=
 =?us-ascii?Q?HX5tRv/7M35ihbbSesJLWmQy8v1cu7M6ZsXS69kVdNDKVZsUowl8/X3h9a5v?=
 =?us-ascii?Q?izotr+v/zJ/jk8+GcZUzWDls4N3paCEEzA0XKDr6sOqb8xNo2WUxZDOKNc3S?=
 =?us-ascii?Q?0ziquyUXWsMr9m5fIimF2tpCvKW9oag5QIFmBgF4DAwGkEDzgDz5YdVStO59?=
 =?us-ascii?Q?NUM7lLca4g6PIwCHJgojbmsBkJMEqAiR0yw+lxROkMvEuhufXNf2mh3zn8Ob?=
 =?us-ascii?Q?e9AK1JaFZPodZY8ieNY3hhYShoPlQBttWc+Y0tlRjNFtLKv9697D+PplgOvQ?=
 =?us-ascii?Q?fpJQwLnxLieeNbcK0tXGT6nK1P/e74rv6Js3sJyRj+d2ibqCTT5loFpWEuW6?=
 =?us-ascii?Q?WdOCIeonUwqzdSo/lRl9hiSiYXU/wz9m7AC49mdfgjO5udHRWQlIIcxNPc8y?=
 =?us-ascii?Q?BI9CgjfUtNI70ORsd63r5Xl68VOung8bgzOkpVwH9Ot1abz1Bz8RwMTm1TSg?=
 =?us-ascii?Q?7AFhYKPdRXX6w2ESjAwLhZ+JYS1b0ve2Nco268F2JLqhp/Xa9rNmNsvtlZS3?=
 =?us-ascii?Q?ec3D81Dfo4X3S5YWsrH5GJ/47QKSrfCWGc097Zg11Aei42YBakf2omX+jNI7?=
 =?us-ascii?Q?zKEBOyru0AyQH1v8vkgCsNe+iXDIaWbhLAxNk9ENqBYt5VoQQrQ7BNwdwmaS?=
 =?us-ascii?Q?1ZsPNPunVo6Kztsb4chFKKfSeeMWUSzCcRFwCw5AYiGDcOOms5fyrncS/M7J?=
 =?us-ascii?Q?50cjB7ja8c9SyKLjOYQagCUAq1c768UGcc/B6+sQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c0201-14a4-4d3c-a1e0-08db6e143f7e
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 02:49:04.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niWkx9UrcUSBVQ4+IMudovidaRQK3Sxi/utNtmqpw5f/OB5D+lYQTPbo+EJjpfhlKcSyC3dZGHrsZmW/4evOHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before dereferencing the pointer, first judge whether
it is NULL, if it is NULL, there is no need to dereference.
Fix the following coccicheck ERROR:

fs/dlm/lowcomms.c:1082:26-28: ERROR: newcon -> sock is NULL
but dereferenced.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/dlm/lowcomms.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 3d3802c47..0a2d1b5ab 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1079,7 +1079,18 @@ static int accept_from_sock(void)
        sock_set_mark(newsock->sk, mark);

        down_write(&newcon->sock_lock);
-       if (newcon->sock) {
+       if (newcon->sock =3D=3D NULL) {
+               /*  accept copies the sk after we've saved the callbacks, s=
o we
+                *  don't want to save them a second time or comm errors wi=
ll
+                *  result in calling sk_error_report recursively.
+                */
+               add_sock(newsock, newcon);
+
+               /* check if we receved something while adding */
+               lock_sock(newcon->sock->sk);
+               lowcomms_queue_rwork(newcon);
+               release_sock(newcon->sock->sk);
+       } else {
                struct connection *othercon =3D newcon->othercon;

                if (!othercon) {
@@ -1110,17 +1121,7 @@ static int accept_from_sock(void)
                release_sock(othercon->sock->sk);
                up_write(&othercon->sock_lock);
        }
-       else {
-               /* accept copies the sk after we've saved the callbacks, so=
 we
-                  don't want to save them a second time or comm errors wil=
l
-                  result in calling sk_error_report recursively. */
-               add_sock(newsock, newcon);

-               /* check if we receved something while adding */
-               lock_sock(newcon->sock->sk);
-               lowcomms_queue_rwork(newcon);
-               release_sock(newcon->sock->sk);
-       }
        up_write(&newcon->sock_lock);
        srcu_read_unlock(&connections_srcu, idx);

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
