Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4200F622977
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKILCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiKILCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:02:30 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2056.outbound.protection.outlook.com [40.107.255.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42EF13CDB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:02:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTey0wEnEdgp+H97POt26+Be+KBFOev+1kQG8AQdDGItp4HgkH+GUuS4z4E7Y/yZesdbhAjDlXiTy8vXY/XwB50bOFFUP85fnCl3LHRnwduMpmfCkrAo6ksyha5PirjoFJfZyjnN1+88CTWGqXM3r3fb33YR5+xoF7GX9DQWqxrchKD+fpKREGcQGkaDk3I6F7Tmb7uyj3BRO185N9K5jRgpd7DUGdmFbytNRqVxHOxGf+x+1q4RMRvDq4oi6P2d7hirk5rUkPjnU+GIX6uM44zCxl8ooGcxRGHSrG1yvD9uvI56kJzsMI/Cwim3y0wZBpPTMGOFhmFxFUzE1eOyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC6jl/iGveb1+xic6ksBQLL3yvVSAiWEKtbln4prOc8=;
 b=NU8cq1T4w7BjxAGIcT7ld5/cmkaT+Al2BcygxJnC90GEesdxNgNFC/+yo2KMUl7k6lnNvSKiO2NROid/S0ZWf3TtLthjSKnbX81ph499EzhJ9rzFfpynJ4eHb0SSgHCGKqpimkhBCA4OLmrQFigirH87Me1Jqw2l0qY/gCRZNzQ8lEMkuIlmrwVUvrv0Y1kk98ZToZPl1Z9IgbUkMe3g5Yakc0HLoPONlDThI8EUPqQ/ybYRASn1YJb9N3whNYteYqaUVUXpD0ta9kGhZHJER2jPgPSKBJgGu6j+kCA5okW97xLIUhPfNbZ7g5KIDpX3C2l+6+kQ5XUO58/xo5DVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC6jl/iGveb1+xic6ksBQLL3yvVSAiWEKtbln4prOc8=;
 b=m0zMEAXoKmdRkzFs0zOgxANr8GB+g6Xykcq2cmSvj/oi2f6CHSmlFZy1mvZeoYcqVu/hnB6j1rNodk9tDAPUahJtgTj4GfhYv+liM33YAGw4olWEO2YjGMOUcm8lqqtzvFcZ5Rt54X8o0lpkwQCAuBrsHqkm8NKl0g4bhs973As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 TYUPR02MB6251.apcprd02.prod.outlook.com (2603:1096:400:35a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Wed, 9 Nov 2022 11:02:23 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::31b6:afe9:43b5:aaca]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::31b6:afe9:43b5:aaca%8]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 11:02:23 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>
Subject: [PATCH] f2fs: fix to enable compress for newly created file if extension matches
Date:   Wed,  9 Nov 2022 19:01:48 +0800
Message-Id: <20221109110148.3674340-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:405::23)
 To SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|TYUPR02MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f6b7c3-117e-46c5-63f9-08dac241e11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ggew26BklmF2uWEtrnRi9ICNziaADnebLZsCnvp7YfSz12Rvs40knS+uglvdaWXiHDmXu1wqdreDdbHf2B7646NEPPzccnZoGGiUd4Gm20Wc2RKfaz9P0AbCyBqMTyL0Y8OxTSFrAJMkHMm51x05C3cJXreUUQwu0ILeZ/t1956frD81o2WO4FKC1ywn0p3I1L6CtKWEocnBEKWKeb27tpcnXTsNhHnmjmrs29d7GIOZff7ctKzqU+289Td0YlBllmnRiZSOU+GJL4Liwuom9lTW34WUjGxfBIfAUVSRLzNtEaIM5U9wA8QxiIT0+d1H9I1SGtnj3XANUU7IWEpGiDlA6lq2ElmH0o+01kNd/+v5SdcR+r5YIbBM43MAHB/PT2fRyhlSvLhwE4uIJ3+wh4cyPkxg10en8xppwkjlunTPXzORZjpZx3G9EeOye9YnJKlj62cNx2DcuFG4b7VrfkiNsGfTMoaguFYgmijLtqCb9gagmy4F/NG9n3UhZ7SCaWJoBtMS5nB8QNYc/MQmDrdjlecgxcNjsRxDKzo029uij5M7JGQJmDyULZeMzUX3eURL3FM6I4+cGMJ42GndhU+LL31f+kw/X6cgXwOW7OJhGnBdq4CfxW+dIe8HAJhIZza/tRPZQgg6cexUdue2OQcbL3Qqfsg54Zy+qAy1jOMl7RX7yLwBTtIuk/LK0Wq4jIS7tbFdYPI8eHTUB/7tIuU/uHPAHKiTUga4avQ4eIqx92s9s4Xth16hnEuvGDXd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(36756003)(478600001)(26005)(6486002)(8936002)(38350700002)(38100700002)(86362001)(41300700001)(6666004)(52116002)(6512007)(107886003)(186003)(2616005)(1076003)(66946007)(6506007)(5660300002)(316002)(2906002)(66476007)(83380400001)(8676002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUU5dE1aOEpVTm1DbDRtckdzMk5Zb2xoTklpRVBuUFNNZmxRVVFWK1d3ZWN5?=
 =?utf-8?B?S01DRzJVaVpPc09ISG9xR0pFUDJxYWpweWxlblhkZnBGMldrbGU2d3RGRzNQ?=
 =?utf-8?B?NnIzR0ZjNTNUS003TmQ0dUJtMFc0dWhzY3p3UG1KLytObEQzQXpSZjZkR1lm?=
 =?utf-8?B?RW9jRGFYQytaUTNsV1V6U1JpcTVqeHNuNzc4YVRIc2lqVS9sc2pEaTRXdE5C?=
 =?utf-8?B?OFpCYWt4Y0hlSjlrUEpwckhkQUQrM01lcGwvVWhraTFZOGR5TG1nVW1CQzNS?=
 =?utf-8?B?dGpqa3dhcFByOXZtQnV3U2J2akNXaVQwV1R6Z1R4MzNTZ0JUSE5HczAxSmxk?=
 =?utf-8?B?THNBWHJ2VUxHRGZKMzhCMytpZUhaUFZqMDd3VzNEMUdOMUw4YXZyQVJQNGxZ?=
 =?utf-8?B?SXVJSnhHQVNRbFBscWZ2NENvMXhadXNzM3ZxQ0dlVHo0UXZVdmJMNzl1U2pS?=
 =?utf-8?B?ejlwYkFBZVBLSFFFWTV3R21sVHFiUGdacmxzTk1qMmRyL2RvVlEvZkI2WEM4?=
 =?utf-8?B?UXRaNTFHZ3ZRb0puRE5uR0hwQ1BVamJoeGExUWxHNnVRUnFmSlo0Yk1DenRh?=
 =?utf-8?B?WUVwbFZTS2N3ZVdHWnd6aGRnaVllR1hoTlpaK1BrUnJhU3AzQjFMRmxaeVlj?=
 =?utf-8?B?ZnYxbUtnTlBtbzBqTUJBd0IwNEwwRHFEa01NTGw5bnY3aUZMTUNDdzlCb3lm?=
 =?utf-8?B?R0JRZ28zR1VrdTgyOUx0SnZFTXl1bDZQR0RBWmlTYzVqTnJPK1lYajNEbUlO?=
 =?utf-8?B?Z3RtUlltbmRIajRvV2hyTmdsYktEc3pmOFAydWpUb0VZNjkwdk1mRnQ2TFd0?=
 =?utf-8?B?bG5wdk5NdmJLYnZDTGFwYkh2Wlc4OVV4bGJXd1FoU3BxYkZVSTNDTWZCODlH?=
 =?utf-8?B?aU1RMkw1bUhTVmFXc1B3bEE0dFV2M1AzRlhDdm1aeGdpcnpvTzZZcjg2OGVV?=
 =?utf-8?B?aHBKQXo1WkhBU0xyR3ZkSCtaenF0a3dBQ2hQVTNIR1c2cFAzR2FqSy9yeG5K?=
 =?utf-8?B?dmd2L3BvaExJRG9hNlRPZGExQ2dScUpZQkg2QjkxYWk2T0pabllzamptUzA0?=
 =?utf-8?B?OWNuWENPaXN1KzMvMzJjNG9ITWtNb2JuUmc1ek5EeGJveHAzQk1Kb0xTM3Vq?=
 =?utf-8?B?TXZZM3JibERkT1hpUnIvelFkSEJBT09uU0c5OFlGYmVkT1VGb3lWd1p6Nkxl?=
 =?utf-8?B?SjhnUjZuanhTSmtNdnlaQ2hrSS90ellBOGY2TWUwZ1laTGlkL3lzQktwWjJm?=
 =?utf-8?B?ZldSYlhpRk1zN1lKVzBHb3RORlFjcVZsZHNNaFlCN3N2RjcrdFZGQ01JNUhN?=
 =?utf-8?B?ampsc0ZXK0M4aFgya1BiQzZVNG5aWllscDV4UHZDSzh0UEgxVlJKc0puZms3?=
 =?utf-8?B?Tkt2akcydEpRS3FnU2xBUkxrTnNrU3lHdGFCQ3dlS1d5QlMrVXgyTFRBa0RZ?=
 =?utf-8?B?QjB5Q0djMWpuUDZpZGdjcUhLRFBaVW1wdmhnVS9OSWQwU2MyTSt5dDFzTE1R?=
 =?utf-8?B?akRFVjJsQVNMcXdKelREbWZmcVlmNklSMWM3LzVXTE1pdS9hRmVidkNFZVlI?=
 =?utf-8?B?dUtCRElZaXN2MDI5UjI4RU1acnd0anh6YjBvQkhVZWlGeTVaSmFVZks2WVZv?=
 =?utf-8?B?SEVOZVhIaEtXMXBHRFRMNFJqMVhnS3pPem5mL0t4TXRlVHhxOGVsb25FOFNL?=
 =?utf-8?B?SHZDZFZET1czUUhZc1FHSFE4dis5b04yeHBHK2haVEtpT0svM2lEaUJHS0ps?=
 =?utf-8?B?M0lVcGtYUGRqZ2dVRnM2c1FZb2VsSUJhdmx2dTNRZzFtZlpqUVAxZTJwVVpL?=
 =?utf-8?B?YVcxakQ0UXlveHNIRWx4U3Jrdm5JY3FxbjNwbUVmUmlRZEUyRjhWZXZXejRO?=
 =?utf-8?B?RUFCZ00zZ1doQTVra1BDQzd3ZFNHa0NQTTNsaFJTM25DbEsxc294Y1BHY2pq?=
 =?utf-8?B?RHVYdGJoZHE1QkNXZTFTMW15b2REblFIZ1Y5elBuMGszLytvZmFkM1VEOGNK?=
 =?utf-8?B?S2NQNkd2eFd0dWxXTXRwNGsvNk0zYjdlVEN2QUNKMjR4WXFFVk41NXNXOVIr?=
 =?utf-8?B?ZGRjSG9PUnJESkVtdG9xaDBRbXJpMnJySi8yVnBNSjRScnYxeExFWHBVMjJT?=
 =?utf-8?Q?J5mptrDIoITFto85oJKC3cg/8?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f6b7c3-117e-46c5-63f9-08dac241e11d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 11:02:23.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnL/fAXWh+0yv7+lqJ6qVt4BwLGiAOJrMyPuLxdfB8XHfCT2PedXOw/HXqiDCnLu+VtuR/qlmfO6EGaC8Qehhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR02MB6251
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compress_extension is set, and a newly created file matches the
extension, the file could be marked as compression file. However,
if inline_data is also enabled, there is no chance to check its
extension since f2fs_should_compress() always returns false.

So if a new file is created (its inode has I_NEW flag and must have
no pin/atomic/swap flag), instead of calling f2fs_should_compress(),
checking its file type is enough here.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e104409c3a0e5..99dbd051ae0ba 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -295,9 +295,14 @@ static void set_compress_inode(struct f2fs_sb_info *sb=
i, struct inode *inode,

        if (!f2fs_sb_has_compression(sbi) ||
                        F2FS_I(inode)->i_flags & F2FS_NOCOMP_FL ||
-                       !f2fs_may_compress(inode) ||
                        (!ext_cnt && !noext_cnt))
                return;
+       if (inode->i_state & I_NEW) {
+               if (!S_ISREG(inode->i_mode))
+                       return;
+       } else if (!f2fs_may_compress(inode)) {
+               return;
+       }

        f2fs_down_read(&sbi->sb_lock);

--
2.25.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=EF=BC=89=E4=B8=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=
=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=
=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=
=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=
=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=
=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=
=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E4=
=B8=AD=E5=A4=96=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure=EF=BC=9ADue to cultural differences between=
 China and foreign countries, any reply with only YES\OK or other simple wo=
rds does not constitute any confirmation or acceptance of any transaction o=
r contract, please confirm with the sender again to ensure clear opinion in=
 written form. The sender shall not be responsible for any direct or indire=
ct damages resulting from the intentional or misuse of such information.
