Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682E473BEDB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFWTcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjFWTcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:32:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493F12701;
        Fri, 23 Jun 2023 12:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgKJUlxSj04htcHaMT1Bch8cnWg2x704tTNcVXDCQ3Fe56OputSCQEy7d0Vle8CKqjgywtup+zCe/cDyVWx1HY5ThvXU6tLft32WOcCy+gq2/S/YKU8tt/G2BncUwumZ0rjUi6J6FR92plq+FtWw1d6VibnCOkQ0eLtC85Z07T3EicMKbvqI5HYmV1s8ZdiaU9AQQ2I3wIoKEYuJYyeRXMCgHEul3K9d/ymqfMQV/w9GgLs9dj7CS/IvIYGOMV36zc0W5F0MCXAC0xvUATccdBW25gCccAi6FO05NPxMWnj1u30dGWx1N05S2Q4klQ1BmBlQ2+sNT2IV4/q19W8aBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdaJEW+xgtdgJKYg7FPGEe4VERxVz9tELb5Z4I53G0I=;
 b=icXHD4ZMTXLxL3h66ebD9bxr8EdBQTnR7XA0x7MRAgmQs4SPslPF3AyAXwB8saMIBEPWVhRNxg3VsAKPHZCOA2THRfz+ZJ42D/MDWr0yYcSR5wi9VoOUc/OHGsZ457HcGzsSJR5WulLcrny2a9qqpt8ZDm8UlKxcvbH7/bTnJxxZq0KAqoRg3P0yNlkzviQuosuhOqXZH68UuSiOnl7M8kDxxt4x890Akgq85S5aMOmRxVgzlQV65y8l42r6IQnPSopSegg7WReRreeqEmBeSh8vf8fq9Mb632FIIT/En5fE8W7y7bSeAH8rBJOLJPxLXHeqM4oTQJHbBZKu93+VLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdaJEW+xgtdgJKYg7FPGEe4VERxVz9tELb5Z4I53G0I=;
 b=YqH2meT4QDfbtelsUJ6wKnPod2xVUpENTtTp4ueDb57bhmOPmM7+dom56cAoH7BkzvDoV5YmwBFav1g3x7eog9nkN0yhoSegNwX11QakPjfnYQvKr+OKvr44DmBlybrYw9FxjlkxJPA4GjqS3s75GpHy5mOl2TQOkl20ZvJX3xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5801.namprd13.prod.outlook.com (2603:10b6:a03:3e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 23 Jun
 2023 19:32:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 19:32:31 +0000
Date:   Fri, 23 Jun 2023 21:32:23 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com
Subject: Re: [PATCH v2 03/13] net: phy: nxp-c45-tja11xx: add *_reg_field
 functions
Message-ID: <ZJXzRzJy99d3v7FY@corigine.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
 <20230623074123.152931-4-radu-nicolae.pirea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623074123.152931-4-radu-nicolae.pirea@oss.nxp.com>
X-ClientProxiedBy: AS4P190CA0069.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e79126-0013-4d0f-021a-08db7420961a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMmtjzwnjMVWPOgVbx3bEc8tuN6IqSAlURh6Z/sPjp9RbOh3+/JPeRiFDZVBq60BRPl0ZGboeG+vNXkwSo2jCtJAet95VSg76peXinDxXHrwVlzzB9dC/Yvs+ELrRaMOqZKebd/ihC7RkI6nFykutEJQz5EMDqEQbEpGkmTNXJJdl/VJ2luHLCFBkvFIGGy6LsBOf4qcRTRqwDtdQ9hsCZTKVphOix5/oQOSfYNT4+0eeN+ASM6CY/POBwT0VfbNLefK2SlGs1jOhDJWWbloEpRBtSBdT51XvZS+ys43nVJeTKXrlqrhAw6YbZWr+/kDCKgu3bAp6echzizNYAKJx52TZ2iyirSYVpmAjMSGwpURgIGmmd88wxIpa9oSFsp7pCXlU/NDdNMdCgg7lacI4yl2xhEQK9olAiOG2vx8/CAjCsl0rxp+pMV35e5cQKRzTBq0O5sgjrNl6XupeWU58/qHyKK/xcTpCCdWdYsTrFO5xoHLFC+7V/aKR8eHefGPCaqrRFlDwn4beH7dE+qBwkwMKoEbDyk2uFzlNLUMgOAsE6egHXWDJpDbvoRg7LfnkKZLW9V01VoP1Iaox8qobGsaLbrwf6in6b6+jlLmDAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(376002)(396003)(366004)(136003)(451199021)(6916009)(66946007)(66476007)(2616005)(4326008)(186003)(86362001)(66556008)(6506007)(6512007)(38100700002)(83380400001)(6486002)(36756003)(478600001)(2906002)(41300700001)(7416002)(5660300002)(44832011)(6666004)(8936002)(8676002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYhT/sRWRxcDE9vQ09ZnPqOtXFsReb5XBZUqhRJzxty1JStuXHQ5vHdVuq0g?=
 =?us-ascii?Q?0fcD/hmA7V6KIZyUnH3OyV7cbmqX5+XZtrW9sx8iG1zQPlToQaSdtwF7wx9c?=
 =?us-ascii?Q?3loZyPaJLOQ90MNCjo54HoqFyfRNcK4eAObNiv8ksnKutENeM1loeL60Rq71?=
 =?us-ascii?Q?4rDKU5gGJNbRrN+L4VnKTuCEyQWODTlJgY+KzK7hfbm2cGzSEI1s26NbWYzs?=
 =?us-ascii?Q?xYgh/OU5yluZUylqxVcP5xPjRk5hP3n8fDw1x81DSrEtcKhGXSV6NQ67lWY7?=
 =?us-ascii?Q?kgfifh1/GmEwNyxfiaclk0+yi3J4E50cnum66ztHX2lohevf8BLgP9hxqCLh?=
 =?us-ascii?Q?JrTU044YVijH/ANzOc0YGAs+6O+heuQuSbw9o0VjQez53UkpKz9vOEbd2FR9?=
 =?us-ascii?Q?RLdFPvik7ESiRRFkA3FBsF0DULbNmrN8SS1aKlPVpNHDOAMRqxQwmzTGouJh?=
 =?us-ascii?Q?Vey/cwOu66QAAY9j+rV6mVUx+HVM6vf4RKFYWn31QqTF8f47MZ5iqb87It9o?=
 =?us-ascii?Q?HSrdoJH2NUiRJ5NMhUhyjpe64DAkJlgDIkNnO9GBVjhFn6D9xCm88k+dKKGh?=
 =?us-ascii?Q?1H//D+aIVfW5nAe/dMdy5ezy91JxWduBMmW3bryDGoVQx+vrxwk8KTnFFuul?=
 =?us-ascii?Q?Vh9Jsz/kjMN4scSj312SygYOACMHCaoXoXeRXPBFlaZZnZQlJIgxP6ayaord?=
 =?us-ascii?Q?JlIArxG90Vhyr0CaC7P6T0FfRAcF6fkO2bHYOGESVtPZfxApwArrI52UMywE?=
 =?us-ascii?Q?R2DlGVcp2E1LLmIbMyzZWeVTolBcE6Hk50DqhZ64VgUfdxqPiCVIJaXYpJhG?=
 =?us-ascii?Q?usyjHv9j2W/BQdCIF/AOJ9nUzVJBQZ5iqekh4X+5ZOMcOqTQYiDxWsSzp1xH?=
 =?us-ascii?Q?5Dpo7N5umgyB/gOdzEFOEqNEoPgv6J/kufkm9SCsvh7PeXUG7U+MCLmKxwMH?=
 =?us-ascii?Q?6CA1QFg8fSDpog74eQ4uxEMfci/vevXENLQR4FU9lsOZZrZiHP6/5uTpuFx7?=
 =?us-ascii?Q?Pdas8fhhjfD3MHuK96R/+YlSKECytJrnbUf56MgQ7+RPaAkjEQ/4okVybj+9?=
 =?us-ascii?Q?IpG430KFXc3s9mpB++RFyWSOgdyIv1ATFL1s+mOJkB9cibALai5CtcXQsQlQ?=
 =?us-ascii?Q?e9Q+t1vEumVJfLXwZOaWTR+qem6hcI0eOa7P7geuyltyiLuJdz8xKPMl9Xbo?=
 =?us-ascii?Q?+J9KL9AjBEoBd5S+KnlTrXWhxElDJXWXBVy6HYNxYHQmhv0pyDjEuYykGrQq?=
 =?us-ascii?Q?o/GIFjLseyiT6licyJXyfs01LLWZe1dkyoHnF7lgL6JGEBbA1ucjO4b9+zs4?=
 =?us-ascii?Q?KF2mWi7B86lcmkZFpZBxsn3OkQ8Ld0KuMVDxSnb+g82/GD+cTPmcHaARzvJD?=
 =?us-ascii?Q?51g7yhJS9IsH4IRlUMgyoNz6bBsH1kFq4/tbwpbSrorOur0UN2nlYefm/bnb?=
 =?us-ascii?Q?1K7lp71rombIlELBN+XJZzNkcjcynso5ZFY6hJvI/dDh4fN+IKlP2U919OUw?=
 =?us-ascii?Q?ZzTYstWj/ab37eX0ZBRXezZtZIvnyM2eLwH3u10sjlvR3O1zdyeWmOf6pUMg?=
 =?us-ascii?Q?6zg50G0M6wy+uq7GLz3fY4s7rikmm4Fb19r88JiDiF1xoHX+j3stPFBMuPZe?=
 =?us-ascii?Q?E31KK+0Opz8QTVx8caCqHwXgJ/W5ie5Bu6cSmSzHSjntwGtwonS2ZIZQ1zKk?=
 =?us-ascii?Q?HAWwOA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e79126-0013-4d0f-021a-08db7420961a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:32:31.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4ESEGGr2F3syQFjBs2DjYx6HTDd4gJgU2YrjWSZSimQIf1Ur0IkVHaHlisoFzwkpkxVRXSQhe5H1wnacE6V0KKU4+tZP1hiRWSV2K3m6w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5801
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:41:13AM +0300, Radu Pirea (NXP OSS) wrote:
> Between TJA1120 and TJA1103 the hardware was improved, but some register
> addresses were changed and some bit fields were moved from one register
> to another.
> 
> To integrate more PHYs in the same driver with the same register fields,
> but these register fields located in different registers at
> different offsets, I introduced the nxp_c45_reg_field structure.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  drivers/net/phy/nxp-c45-tja11xx.c | 82 +++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index f1f15a1b6cfc..2664b3bfcb35 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -191,6 +191,21 @@ struct nxp_c45_skb_cb {
>  	unsigned int type;
>  };
>  
> +#define NXP_C45_REG_FIELD(_reg, _devad, _offset, _size)	\
> +	((struct nxp_c45_reg_field) {			\
> +		.reg = _reg,				\
> +		.devad =  _devad,			\
> +		.offset = _offset,			\
> +		.size = _size,				\
> +	})
> +
> +struct nxp_c45_reg_field {
> +	u16 reg;
> +	u8 devad;
> +	u8 offset;
> +	u8 size;
> +};
> +
>  struct nxp_c45_hwts {
>  	u32	nsec;
>  	u32	sec;
> @@ -225,6 +240,73 @@ struct nxp_c45_phy_stats {
>  	u16		mask;
>  };
>  
> +static int nxp_c45_read_reg_field(struct phy_device *phydev,
> +				  const struct nxp_c45_reg_field *reg_field)

Hi Radu,

I think this is resolved in a latter patch in this series.
But nxp_c45_read_reg_field is defined but not used.
As is nxp_c45_set_reg_field and nxp_c45_clear_reg_field.

This causes an allmodconfig build to fail on x86_64 with GCC 12.3.0.

-- 
pw-bot: changes-requested

