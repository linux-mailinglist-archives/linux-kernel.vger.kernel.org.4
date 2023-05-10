Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE466FDE43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjEJNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEJNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:11:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2101.outbound.protection.outlook.com [40.107.220.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFC43AA5;
        Wed, 10 May 2023 06:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwmw5SNYpYpLIjCq+6P1L+2LHyenwr0oUhVPXvFIO4vbTi1vLgbAJex/K6EBenuuf7YbLZF/4p9tZVi/kU+4env8qDLuBPkefVdheJbQi4lBLTuomL8PmdGwll0oxqB/gH2/Tq0DgaGb9ODXVuy/BOSf3PnBoxrKtxJFXz+afo+JghKMG5bQOFaRyjThCx1/CwrUy8F0uLp6b9lCGMGA+whVVRceSfP5aM29VFwx2YbaAon40jLemRC5H9tOu4WdUcV8/wIV6Qhtg8WMLZ/PEjng1JXCenRJ/4/gWrbzjB9FXLFvRf/acYFhz6KdTfFVSluebc+sJwvbvc8uhLpMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUG6uYbIa4gxCyCZbkTs1Dge3Mji++vnAVs6gQvvqhk=;
 b=VWSeSNTC8dwzUkdD8iZASPgVnJqBEIkwBMWPRaN82G1F7fzkwTZ7n4oqWDrTxWI9FmpESQLRRrO5onDqQh6wMLytbx7FHxbm7yQVaYsMmlS58HSkW2pqcL9oNQMK/Vd6sRdK/wMNCa6DnfNd099pa7tERSEfMW0m9JOhidSCfJquQXSxM5PSD59tIPCpbVH7T27T1WMlai3CCXyIuhCIC1t5Nq3Om7smX9+fBzRqRqxloQKCdGuJQPLkceXx3xup18ZT3VFwcCGI1fxp2xUf0TVf+8X1kkS13prmyx939z/o/wddoQX6gBJbt8NzpMQ0+yilmCwb8GAnG27A6A2eUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUG6uYbIa4gxCyCZbkTs1Dge3Mji++vnAVs6gQvvqhk=;
 b=GewaBpnocOTeCL9QD4IVNRA3vCHTFn9MQg4yNGwU58AwiM8DaI9/9uUrYBynqJ/aX4GaKQCfwtT8EvxMEp0zP6cs+FM5Gf4i0ApXwxQtu4dWq88iaHFlAd7S89/lmf0+DofRyi34WvZCowVlKMiaSAr3syKKLyNbeXx582m1h3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5576.namprd13.prod.outlook.com (2603:10b6:510:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 13:11:32 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 13:11:32 +0000
Date:   Wed, 10 May 2023 15:11:26 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btqca: make sure to handle byte order for
 soc_id
Message-ID: <ZFuX/l7kNrxHtDlD@corigine.com>
References: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
X-ClientProxiedBy: AM4PR0501CA0062.eurprd05.prod.outlook.com
 (2603:10a6:200:68::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5576:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a525d37-7020-4eda-cf76-08db51581315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ovE9NskwWQxR6O3tmjft09rFwbfpf2PD8chQZl7xn3Ns72PMvCi9jUF32wZKp0Va5z/HfWLpfnPPcDE3R0YBIvamG2YhMlB6iwXPpz18eahpJnG8Jrnyube0JYY1Sv45bcQXTFb+X07zInCU7jk/xStoNJnAgBXWnUG2Uf1dxhjghPzm7JZ6Kuz99Rl2mkngn7ZLxxbjjqIo5A+FNfF0LCHKb9xXs80HIpA7xukQ6Lb6+gcYvgk75L587aHMCf9QekyVB95bnxlBfTULdPqiIJ3JObTA+3yqyMXqoVjVza3gOq2aifrUaO6lrtM+yPeqqmzsNNoq5iuOhnDlftDws83+s2cgqWAk1gKMQCqKyUtS1VAHBArcoHqCZEVeFAhGxQET240B1ksZWGOWHwcZvhaGZmmhhKEIzvsMmGd3bMgksu9uSmW2/4xmoxCbilsTK6zC11tXEaZtVrG2BL4u4jNSuI81afw0FJY+DzI/Pa5KEZ/745JMaiBhiYZIn8Cij6Y0G6K0HNWHUYx/ddd7XslHRzIWSTHoJDPNaX9xo+cTa17cdeF4dEDFf990vII
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39840400004)(366004)(376002)(451199021)(83380400001)(2616005)(186003)(2906002)(4744005)(36756003)(38100700002)(86362001)(6486002)(8936002)(8676002)(316002)(6666004)(41300700001)(44832011)(7416002)(5660300002)(478600001)(54906003)(66476007)(66556008)(66946007)(4326008)(6916009)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXrhMNV3J01uX7ASluiBXsgdanYECSQLYB7GmU1Y0b2bOhMvXCAYPJs3WGd6?=
 =?us-ascii?Q?XUHQkXxya/KVOBfQEMGgi08+wZL/jobRyAVcQovqUxFPUnFRJz9qmXF1hCgR?=
 =?us-ascii?Q?/B8sFoBBG9e0y3l8/0tdeyeZkCLAVxh9Euh6D6bU23N6mIEC7HT1FA7TCN5/?=
 =?us-ascii?Q?SnhPelHTtwFKIeuv+DW/9lz39iBzj3KWsdcNqex6onLE1tnijSpZePYALAti?=
 =?us-ascii?Q?I8k2BZEnmbnyEeAYrQidSe3Y2WTDgXlohd5uewcSsTlVvFfq7vkq3tZNAE0u?=
 =?us-ascii?Q?YPaiQq2sU+utPMlVSY2NpHKaxL0cX1kzRS3Xzn6qHgX1MYea0ahhOwszz3eg?=
 =?us-ascii?Q?7b8AFZz7SsrzGR9a+PaulA5pPX6Ycm/0lAm1kEyO8SKDmMWp2UmJTYHdTfL+?=
 =?us-ascii?Q?MmbxFGVMdcfO6C9fhW1gaXDJ+9k71Z/y3RCgZ3JBFaA0fyuqAtvDf50ZpSVG?=
 =?us-ascii?Q?VoXL63d+QT4A2EhqIV1i+0Fhxjy0qqU03ly4n7o1C9uKeeojzEmdwNqpoIed?=
 =?us-ascii?Q?4wEWclWdQlqvvfT7sKYom2xHp5OwoBjYEG5Z5qlcRraEDN6iiqSXazEn1e1e?=
 =?us-ascii?Q?S04bt6SvU6HExANe6b9Bexj3Y1hUyxmUjEvuoMoWTlRSNgT/4JcR8feWJmnC?=
 =?us-ascii?Q?cPBygTo6YW1Fc3Wd9I6TXUtC5odkLKRuJjyudnlEKaiuInC/tZCNtLc6E3yQ?=
 =?us-ascii?Q?1Ax5gv3OkIWy9MAQ9H6ZpQ58w6L7HF8gHPj7jTfAo2cAz8jDxZhDu3CjYuJH?=
 =?us-ascii?Q?sEjtz2qMbAo8tDO8/79r9vCScAEqaSYhXPl92hZ3OeduruV6B4fTXANDXhBF?=
 =?us-ascii?Q?jx+rsFnaSPlLcdqo2M0ye5DOTuTDv76hiHiWVwpBV7brSkltDgZO+PUug/gC?=
 =?us-ascii?Q?S8sG3exVPxVDK3HHmB9KT/OJtMxqJ80HDo5NCJM71g7lipegKvRnHkXsj3zi?=
 =?us-ascii?Q?wfVudyNYCpOH3q0a1Lun6mAnbBeHgE2sHgnuV5s5fAQvi+ZTx74ADU4f1iM1?=
 =?us-ascii?Q?i4k55Tn3Xen61dpKKNJlgwrNh/dSBZqzMduVPTPSFFGwGo/9XiZbdjwLAQUm?=
 =?us-ascii?Q?XPs8ufEbXtseajHTcLTKKgVtgtlhHo/RhX+dLwoPCfW/SdVixCjwcD/g7Ufc?=
 =?us-ascii?Q?YxlNOvVPhfupaqCZSqtRhj0xsstDWwpmqWL5VjzTlprE3CwHQ9iGMBOtSTI5?=
 =?us-ascii?Q?VILEbIPGZepLiLg09LTnCSCRCo4vN0ecFg/gc3FlDcmb3r3zxGQeubX/905W?=
 =?us-ascii?Q?rku0EuZqzypnuUfD5ss4mV5txWIak4sz+2NyjmI2dwQ8UQ3xSKgDhecc6peH?=
 =?us-ascii?Q?1SoDBA4oLIzWeuarq0r3Kk/0ZpqNkcPAp0kF5fALIFqMVUuXBitdodnuEk6j?=
 =?us-ascii?Q?fCMFf3IrlmEj7BXVW1mV5omQeXee8/OhYUt9U8m2iWvpc3DkPaGKJjFNliKT?=
 =?us-ascii?Q?p8i8ud/jpT9+ILTyiBruL8PbaE+FWOqDGeDBYkgw7UApqDf7XsiYoGDf8OMx?=
 =?us-ascii?Q?KqNhgoPD+mma5e+7insY4W+6bAdfLxPPI/Fjzfv1K3ZW2Cs5S9OTejC5Y6qq?=
 =?us-ascii?Q?GuifAKt1RCviDoLS2L3kua56YbcKrHXzXk1pxGh6NG3E0pLqwMzgk7sDermV?=
 =?us-ascii?Q?kYLoyTZYvlMSJ5D0pPkiDNU1oAT8T3R0yNrNxan/4IXk/J4+G1NmCGBLI53m?=
 =?us-ascii?Q?1x9BuQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a525d37-7020-4eda-cf76-08db51581315
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:11:32.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJ2wdTd14BeHmvLi/n5raPs6/CD0lgo16vXZyYrSJsm9B6ZHx0/KIxrAzrYBFZM+oo4Z962tUyqEi8oh2OCLq8/xGnr9Mtw0gknJAtAF3fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5576
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:27:21AM +0200, Luca Weiss wrote:
> The field soc_id in struct qca_btsoc_version is __le32 so we need to
> convert it to host byteorder before using.
> 
> Reported-by: Simon Horman <simon.horman@corigine.com>
> Fixes: 059924fdf6c1 ("Bluetooth: btqca: Use NVM files based on SoC ID for WCN3991")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
