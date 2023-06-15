Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0686731164
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbjFOHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbjFOHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:52:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C76E69
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqxc+H4UB+PErtvhBurss3eO+u5KhBZzZKqStgjX+1d8e92WUJqpi9TEoFQkJRwff6LeYjfpnfSCO11wDNtBKlURwfnl1UMxxM78ajVgTC515TgT/LEfqiu7VfMbFuGRj8oJT6vphIcRzk0H4Z8gAOmA/Q6qsELUQKEvdfvRK1VXrYxk338Bgnb2dtU2DsHT/ClBwDhJU7m+NQbZWoIxtIVf+ABIIiIYTuCOLywa2PCOHniUZREIRns4NkI1JOkQ3msw0rCNVMnkL4hOi/ZLkeHzm8ax06qY7oY0Yg2wncL5f9qoixI0yAl3M8NIJ9LQwu6r42nGTmjQpsD+dko3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUnST5og6mN1Km4ZkIiuBRf0ogjAcR4ofg1d9eVPCoM=;
 b=mh8twreA8u46D71+AZ+I2ZvOHCYaBhpXMCjiibJ8AGf6WC5h8/2Du8iGnAAVPRyi3Ml6VjAlw1K+8C0Qq7EzSfS/6XcU050gwrPpPFNV2/E7EvO8POZlsjqW7s4YIM6g/UH+6FeFZJOU1C9uzyogHXUwB2c+E56EI/FQPSCEMKSv94JiFkn0WByh4wWAGI5dBkmATQ2z0kZvLUggfjzbs2hr/iqgSr6fY40PlyVreG9s/h+tQHQX0N8PPirJvfefrGO8sJ/ZFgZWDBiuWXT2G6TDyrRa2RuC4PW8vFsVOjsLZGffEmhbxmYbGl5HI6JZzl+DubeIkRh/FoEjoCaf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnST5og6mN1Km4ZkIiuBRf0ogjAcR4ofg1d9eVPCoM=;
 b=XUiP5zr+gYW15+eVMQmJLhRrQEGUym8ui6jv69bAY4m9OUvKTmhEg1ikLbEL6iGmQHVLZMeXZnzV5OuG7AsOIBMnCXvm/aAO74+H5h6FRvBShd5/2jz4d/d6cPHiqXGAgkWNhEqVNv1ohA/r2Q1zjkbP/7fbm6qGoOvDcMxQr45xPRwgJeBEbpiGSywCXicJoqU9NtUPFIPn1TglzAwLqbu+dcs1eB0UrWrWmYyICMfQTm+KjTDMQAkEUk6Gw5mjCzB7Ejj/TENXdCs+/mQ1XGtaUKtUZsaZZQwMXeZi7jDVa05lfb9MXohu8+C/lCio/OHRrQwMRwuBt6WtiH6PUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TY0PR06MB5427.apcprd06.prod.outlook.com (2603:1096:400:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 15 Jun
 2023 07:51:40 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 07:51:40 +0000
From:   Wang Ming <machel@vivo.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] mm:Using div64_ul replaces do_div() function
Date:   Thu, 15 Jun 2023 15:51:14 +0800
Message-Id: <20230615075127.6832-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:1::22) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TY0PR06MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 175032b6-e024-4043-c8de-08db6d755a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RMkiaxxKdN8yXA9IRvCqlF2EiQ4umvLeSKJpr+208lZUWOomD+P36OLilpmKUjTe5OOqCdcRtiA1Oh05EY1cRuYPWsIiwpmlw7edJHwAhhzVvLUf8uRTNxMcoSniSuIMWjLaY/LGWDKhhqLM/aE4dEH4VOupN8Nz1J9f27z817LxgxlRQHljHzV44i4PlydVxFyg3iycnZkWmGJsFt206WN53RPzRDqwSdcGDqthqFlNrtzKXcSy3ArIm99sKGkG5eJi3pFmEsSciS4EhPJdwwEEfqrO3JmV0Ns9vNmMYYAjSSDrKQ5DJUBg4pZGwElla745+MxdpNHEyUibkydDT4rjRDCHTUTdBDqcuZsNs50K7rh18npPdrPaFxWxOSTWM/f/luLkv9ebMCt8y3UPpyyhOnnJ5+At2lanMgYj0pMT5b2Pv6h43t3YC+nLzDARPcKiFCcEh61kxxgu5e3xG/HXKR7H+HoIb6hn40w8ld51u4ObfQRiEaj3yEowofG4rl9VMqEqzYJtyaBXfEmo/a8no5KZ3CwLFrGmishKoketkkvxIWuhQJwtNjOyCEcpmYPueVYgtkza6f4kDipxNMtngU/XjfMFhWR4Cxdqq5r7aGWUkH44mU/iBtv1SuB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(86362001)(478600001)(186003)(83380400001)(36756003)(2616005)(107886003)(6506007)(26005)(6512007)(1076003)(6486002)(52116002)(6666004)(66556008)(66476007)(66946007)(8936002)(8676002)(41300700001)(38350700002)(5660300002)(4326008)(38100700002)(316002)(110136005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?omoGvDHYcWZUNVBIhkIMq2/DM48IRBDQYJa7V0JoK6r3O76SAeGUZEHTedJf?=
 =?us-ascii?Q?01UVxneISCIjSEbyEpMFRW3/KiSSv9KzZkDSPu11lePD1mcwsIBwCrLOkDex?=
 =?us-ascii?Q?HJd1M6NLZbLdVAuis6AbQu5ixc9C4ZFNtvjqseDOvwlvNuQwoq4rYBjM5bFb?=
 =?us-ascii?Q?upr6yvS0Dxf00mcL5Vg0XooAK80VY2Z9xUT71W8Zb5t8RNmW8niJowiTitk4?=
 =?us-ascii?Q?KLbrUZVOMkZ9A/ZPUI0wd4NWXHcTX8JAqWrJvwyoaSSdu5Tqc8WoyLVqd/Rg?=
 =?us-ascii?Q?5ijWd/rYDp2PxiZFyR3cw8h/pH0b+yryUNRK4vcV6o/GMLPZaHEp1BSZeC/z?=
 =?us-ascii?Q?3TCzgkPjdX8pqzp0aCFHqhGsA+TCW82b/zSJ0sEhd3x0jJk2bOScWP35DLBK?=
 =?us-ascii?Q?CcxXk9flnQGV71WWn3L3Ti3YWmKJyopgjfNi29b/vPwi/wgRKFoGYZpBEskq?=
 =?us-ascii?Q?GXJE8Ry46BFfkoXZPNAoTDrk+1ZsOMew4eWZsiHjtzKGGxXUu9VOCL3Xe/OX?=
 =?us-ascii?Q?z1s9njirDjJpKM7eJHhd/dOYlKSvVrUpQ0E/iFUdxhXrlu6Wrdw5JH095cXT?=
 =?us-ascii?Q?BZfb3um/697y2p4T89mycSAaZs8QBrgvXc/UGawXnOi8FeaHxV/QUxon+XG0?=
 =?us-ascii?Q?saZQ51jc6vj8+UZ9ZYTPsH4QaNJShBUTFGENh7JxGX6ak1mlQqnG0D8hJT5s?=
 =?us-ascii?Q?CWv46h1AbkzFd0EKUgSf5rIwehjrwXLUmvGkf88tziiLAzPg8rX1Cmm3VZq3?=
 =?us-ascii?Q?wSsVE5rVkMD2YuNTX8pdH7ymSevoXoV0ai67jFX7m9/nY/dRGeyPGm97QHA7?=
 =?us-ascii?Q?Ovbk0G4bgCx2AelRDCJhcF7pPtXHvDdWHNcDacR9HkdzUMUHTPNxOrQUKo5W?=
 =?us-ascii?Q?N6FvcRGS0i6+nT+JwOXshdo5UszLwJJ5QHbz2KzheAsw9Xf2hSn0dC5w7iZY?=
 =?us-ascii?Q?VmgiQfQ1AmmYKYYyGwENde9XEVOb3V6wKJUAzAU6KNPqZo3Or5qCCpn2bhjQ?=
 =?us-ascii?Q?GrWhKRHI8q38F+DYA7ZGi7DBLjGI67vgB0iHqJXFblzL8yH+bLq6tv6RNDcl?=
 =?us-ascii?Q?dc56pna891g8reYRxPe7qYqZE80EGqoZoRbVhdoxui4BPw0fAm7QHQ4Upivr?=
 =?us-ascii?Q?PaLChDgdSoWe1OKqnF7GP1LkxVQzjb4G59V2gs7KWn+/PhF7ih6mdpPOVC+H?=
 =?us-ascii?Q?t2dU/02zpp8QQAfnoTyJk5ijzpS1B5zq9qGl92ys91KSKrCqYUR+iJ9EsJCe?=
 =?us-ascii?Q?yrHfrFjbSbKV4i8vG59IC2O3mv25IaSgpNOZSqYPO2dO5yjoXt1jQkm9VCqA?=
 =?us-ascii?Q?NETOvJ1kdcHeURkJcp356GK9NE0bdD49LocLYBQ5nyDu6MrvmpskNJMzhL9N?=
 =?us-ascii?Q?15J/Ia0wMz3pVDj3+E5HyN0JHYcFuPfTAoL9k3/IlOM0r/ZgVVxc7oLrHVgq?=
 =?us-ascii?Q?rQ5ufAcyi+WLNHhFDFgG4+uxsA63wkyyD9bC/Q0fV35coTFinwgU/4ei6oaH?=
 =?us-ascii?Q?tHzXItRUpGwO9AyTTwXnXbzsxlHHsL5p1it+jW9YZDofYssv79uUpGSgyuiU?=
 =?us-ascii?Q?HvgD9Vef/q08eWC5KYnp110P9+4PLd2BiZCEfb+0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175032b6-e024-4043-c8de-08db6d755a9a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 07:51:40.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZodNUscqSQ2s0qXKiNyIDr9Je/iMv2P+Ie/PwJ6venSCiBq6FhxbDW2WHITo7XbTQbo1ledXZNzB0Qlk1K+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

mm/mm_init.c:2492:2-8: WARNING: do_div() does a
64-by-32 division, please consider using div64_ul instead.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index d39363159..d92de78fb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2508,7 +2508,7 @@ void *__init alloc_large_system_hash(const char *tabl=
ename,
        /* limit allocation size to 1/16 total memory by default */
        if (max =3D=3D 0) {
                max =3D ((unsigned long long)nr_all_pages << PAGE_SHIFT) >>=
 4;
-               do_div(max, bucketsize);
+               div64_ul(max, bucketsize);
        }
        max =3D min(max, 0x80000000ULL);

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
