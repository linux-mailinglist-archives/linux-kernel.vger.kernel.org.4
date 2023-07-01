Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDCC744797
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGAHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGAHMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:12:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468A9E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 00:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S52qOgQYnYHsQNCjp5hALpMism/5VI9WsFp3gNaJi/Ezjj8Vkg9lrsQiL3QuyLNSZjDNP09BTK1pHP+9Xuci/IC6/nxI9kRrz3rwv2/t47scKVRNV3h0IUJMfXDw8bpGXcUjAdu9wUZelPj3QMtac7DLsZcjxXk74JEC5CJJsVdNyFAzZtGOr1BpM3NVLEtfkHEeotyG9Sc19WGhYeFwCxWdTIpBAATfGt4vD2yHbnRqZd0Byq97IwLQHC8ycOHNYU+Irl512NPT4PVAyr6AZtIjHm08vL9ApiDlgN0HbDUbV/05k3yCp2+oU/pL3mrMBgMYYBFQimvdUfSIGUZJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAwCn+i+/XnD/xM+RpsB5J3OljbjSSqH+Oy9nGmy15w=;
 b=lQWP3iaukZKOocav28QpON9HS+/2lIA5hBPHfm0sO5cd1/Q2yi33e8looA8qGnCXSY0YCFi3HNL1vKhqaws0QsbJRb4CSe9DW2EJfGoRi+mIko76WPkEsXdwdGEylyrgWMynlbHVZncolPjq0x/sKybaY0Fv7hNmqiwyAWC1GR3v2fGmgQxMHWPfG7cApOO78hZhZhBiKe99aa1r9QnFArycDu8jJhRC4EeBy064hrQQnDhuMaUaMgWpOpx7Jxidvs3sFCc/JU6H7QO2IjKE0lVRHevVKoAX6/R2aKa1xyiKtCqqmr7p3I3ruk8KD1XTqNG/vJay3iYyc9F1aMXbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAwCn+i+/XnD/xM+RpsB5J3OljbjSSqH+Oy9nGmy15w=;
 b=UBZjafF9DDp/Afl31pl3opLat5u204l9FQgRhles4MfqAO4HGFhGbs2O1KJCvRwHlnr1mu7qOAXDfgPck7wQdzi/2IQdfj0oxH3Gd4T2tEoqIqnCSQqkUM4fhStfR0hZdZJqPCt5CbRUkfFHZGc1wEn9h7AzSfjZT66pVnob2Oi+F1raH8YKHIKu9AGbXSv9hltrgVCUZnwF6ayyQQyCZkCVF3WRsVvPlvd7bkmxmrwmibFshCmkh7WNXMzDSxBSHC31KHZ+i6qhXzHqxK5T6vIcYNCKBkl+M20EsVJ7PH0fzL449SHlUszclqQKJ2CkqtIsQciptJ+nYT4HVHnHTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PSAPR06MB3927.apcprd06.prod.outlook.com (2603:1096:301:35::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Sat, 1 Jul 2023 07:11:36 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 07:11:36 +0000
From:   Wang Ming <machel@vivo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] firmware:Fix an NULL vs IS_ERR() bug in probe
Date:   Sat,  1 Jul 2023 15:11:08 +0800
Message-Id: <20230701071122.24541-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY2PR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:f6::32) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PSAPR06MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc10984-a138-42d2-7e01-08db7a026789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFYHNcWefFpfleaaPvfUPjnB4A9VoqcVWaVmiZmnR/H4KnSRgwIdTQAnTL+DzQVINIyY296fkE6A7/uXIIwcow2xMQ4qwYoeK/FncPo+6ZXJFxvAE7eIPWnxouDLn1PMI0i7NAqnPxgjwmUBYhtYMcw6hibScoX0Zqpi60xJ8x1X/dSVoxqtOiA3KmutZG9nnlsFwtCrZj8QBlhoFCvt2j6v87Bis9idLtOr8kDIWUAuyRMwN9KavqNwSk2CJUBly3THeoyKC7XhxxefJNXzyNGM/6H7zOb+k8PuOW5MKRIfeV45k2M/m4SKP+OV1XOWWdb4fBbtRLH8SSbU65TBTd0xUJFgwUGqGKE4rDFgrN9kLtK4wddPYbFUosQSVWfyPPXt3wdi00touVitmM2CZqEmcirnFHgOWcYz1+ZF5eQE7yGNNHdkACQv8Q4QdjMMxT2Lv0CCcNDHvDQHI1traIZtgbMOJtihitsZ9uqAcWEaTmVl7o6sAOqLN7fPI0Z1fmBdQzdDeG2Pe9ayFqB5Uqf59Rx6BTvohyY2WZd0VzDB4HUW/6rfY+zu/RiJ//3SrGg8DqGruHoVfgyYa9dVG8Be1jbhN967IkNPhaPusCzTh9FeMD1gU9fqfrBctdmY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(451199021)(52116002)(6512007)(8676002)(8936002)(5660300002)(2616005)(26005)(107886003)(6666004)(41300700001)(478600001)(86362001)(83380400001)(4326008)(1076003)(6506007)(66946007)(66476007)(66556008)(186003)(38100700002)(38350700002)(6486002)(2906002)(36756003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vjhPux3uTLHrQ878PzjR+tI646SZnjwV6+zQUiccBaoCTIfnFlsXU+tx0nbI?=
 =?us-ascii?Q?Zoul+hsEHNWhV2YpM5rcdpqkmNs46fz2ouG759e3MmW3AKzN0RKKe9e7W8lg?=
 =?us-ascii?Q?RGa+QlYx5sKvN8OR/YNxj2r0LCfUGSUXXdFx2bG7ejaA/zi0F4p5ur3HBIrF?=
 =?us-ascii?Q?0V/DheyqYkgE9NzS339tr9bL7Hqwm0niSxH6Z9kZFhpe+Ih90cKBpSGUZfuf?=
 =?us-ascii?Q?RNVW464OYe5rpmtuqFnVQiYPs07Ru8ebL1qQ4IvAZRCyH1cWlxNO/fv3dLli?=
 =?us-ascii?Q?82UQz/a4KvJuQE30NPWOXPbS+RACvZ4tVTr1KIF1e3b8Z9lmtj8kFZKgHjkZ?=
 =?us-ascii?Q?DcxNikq8GbX1aYbXcyO5TrVLWBejb6bV9Gfuxu0pNV5+0WlzsjTkKlwx0lze?=
 =?us-ascii?Q?DiqSBDn8+4W9NaNZ7FeS7gfQHg7+8oNK2UWVNytyTy3Fe54pApvQe65F40qp?=
 =?us-ascii?Q?iW17ZBpHypsI7+9egSl6uTXDjgURzmDODaMIQ+KlWyPfYB2MKSMn+9D7zSPI?=
 =?us-ascii?Q?2NZp0mpAI07w7/DCO2CVE0pHRkfEZc1TOPVoPlKBehZhB+YCqalcUzN2cjAS?=
 =?us-ascii?Q?FHFhZz7sjrZm87b70mYioKbY/tZJ8VEnk5pgcECImQ5M8iq005gI+uB8mSCZ?=
 =?us-ascii?Q?rHbj2kAogDeOqHkrlsDb0koEW+04iE0XAFYJvCSCYKVQUBo+w/G4P8amSfQt?=
 =?us-ascii?Q?9zaT+99EsxVCz8lmO4mwO43HCU2I1VAfb13z8CTHN48zpKlqOkYl9O8740Oo?=
 =?us-ascii?Q?tmiHsM3UqTt8OsuOahoN2fjl79M6AyLVGSecHYLYVPELkZEOU4MW/CPYGXwn?=
 =?us-ascii?Q?1nen+P6NfRSYsgDh5Ce+sV1cn8+uQw+zrJ0xl1ImK0a6SkIzoTE4x2Fn4hWn?=
 =?us-ascii?Q?BIJqnSHDomA1CQI0tUhd6WkqUzQmqEuAyQRmYklA3SukLRVsR9KiyA72aRYF?=
 =?us-ascii?Q?Tc6Zlv261TdDpxmO3jDbL7ynU7VvkFStVmxdKaWuGmVfhVuj+8Kkz+K8KEAW?=
 =?us-ascii?Q?lMF4jBlVZoTcFgFRSm24WCSfJx3106EuuxKh748nqWYJZum8RBkdqkEq8oyC?=
 =?us-ascii?Q?L+GCdE49JBgnDpmp/IEG5JYdot+aW54Oy3v6HmCrSCUNNrBqav5lLlMw2uIl?=
 =?us-ascii?Q?7Y/vGM0kCK4ksAzF0dm/zAK1CtIy7yMo30waP2hfvDG+7PLZpM3aWKKJ+r11?=
 =?us-ascii?Q?lQoS5LLs4oNfrWNZ1H0ToxVPltXrLB7AjYNZ+qDoZL62Fjh/tK8U0i09vubx?=
 =?us-ascii?Q?2MX6ki3rFt7PFioVlfnjpKGAJvPBCYhwixJ8lAEcTCipz30vW64TRcazaPnn?=
 =?us-ascii?Q?FezPOHQ+umLUIGwe9j76KkQkxGtnVfdr9tSmHokkRri9IYcVnnUbIPILz7bV?=
 =?us-ascii?Q?aRdGmzDrSlWqXOrE3qmB5N+wv/gnUOXhfpcm0s14TCi7vbld5Q61FO0KogQf?=
 =?us-ascii?Q?5DijwtlJrNWSDKNvGp9nKJZkSTOVMP52AnRafVBU2PifHxZuPGP0xgAgLoGQ?=
 =?us-ascii?Q?/AXNjgU1EvfMLJQD1/9/oaDBvSZAxgBZDvlYuaKP1pQDpx7gtXCTzqUhX0uE?=
 =?us-ascii?Q?UV4Y0Z3TBS5wcFvqgBzWAs1fXY5dF4rOkLEhrvhA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc10984-a138-42d2-7e01-08db7a026789
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 07:11:35.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elGRbOGu9vItjNQHiLycDf3VMsCwAWvYTCEfLAN5ONZsBugZALb5juobTchCFwAGcT10GEkgUczBO4G277WiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_memremap() function returns error pointers. It
never returns NULL. Fix the check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-=
svc.c
index 2d6741261..cab11af28 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -756,7 +756,7 @@ svc_create_memory_pool(struct platform_device *pdev,
        paddr =3D begin;
        size =3D end - begin;
        va =3D devm_memremap(dev, paddr, size, MEMREMAP_WC);
-       if (!va) {
+       if (IS_ERR(va)) {
                dev_err(dev, "fail to remap shared memory\n");
                return ERR_PTR(-EINVAL);
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
