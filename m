Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88C738A29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjFUPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjFUPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:53:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2106.outbound.protection.outlook.com [40.107.223.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49B1BC;
        Wed, 21 Jun 2023 08:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmnz7/2GwKVrm2V1vbFMgkmQnPfP0kYeZSsnoJxW01AgFubLVcWMS6b3gjoitR6/qjUUdMg2vQG+06yy1YghB0Zqd3/XMftXLqJ+nbee1/8iXl35PV91/GfE7JXknk4JjLVsyjzHcRn+auSat53PtAZJrJKJLNcgPJn9//p8Eif/2/8BTqElZqDfjll2hfOidGQ3W2M7jzQhiFErJeuE1/lYNCvIPzZMA96GaLU6+rbKcu+o/mEqEdJ6o57sxXhKF9TMUUh32cmWVW6s4y60Srz1Tq3NY25UQ/dGMexAZrgG4xP4vIsBqyqRbRCPcJM+QoIzVo/Kvwb1Ai0UyljKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm9xfioeGlwueCnr+ZMAhfo1VcCcRfPA75BOmUevJwo=;
 b=MHFc1EMfSQsh5SrLFzEJ+eheXvynD/yKEjUctNuBY7TOIt1lHabw8fYsPPZ4cBk4wm6oGWL40hMf3tOGhAJd+WPIuRD+lPW43j3MZJu7rz8KNIUh2+sDp0N5n+HZymHioOl0uONY+0ANcPW4ObaZWm+hDX7X3Ulv21FiKPDgNRik5MICGTPKmbEADB8gtHyP1KkLRKCURb7r+fdbu0CLR7Y3MJM1woIJcozV4nR7N1P/t+LJ54VjxbEOmHOU3s/CnGaHqAu97bV3b/lwIH7jpRBhZED0Nu68XW4HRKV/eDsunyM+HDTEzBCeBWWEutp9Giskk+GAypqNWFyCgG6hbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm9xfioeGlwueCnr+ZMAhfo1VcCcRfPA75BOmUevJwo=;
 b=m5lJiPyB8V4pGkk+qaNNNp0RQc895uosDUz7K4KcEo1z8cTKWdVtWeyyJ0E9NunHAzoToo0JREwCB2H/Y1trsNj0ft9S2Hy8d/f/IB1lQEN6fx+5VCNgF9SygsLSmB53hwrAQesxhz3AjUPpxcWVq2WQeJpCVFSEhRaark/B+DQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5126.namprd13.prod.outlook.com (2603:10b6:8:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 15:53:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 15:53:11 +0000
Date:   Wed, 21 Jun 2023 17:53:02 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
Message-ID: <ZJMc3oS2nxORPASN@corigine.com>
References: <20230615222152.13250-1-rdunlap@infradead.org>
 <ea55623d-d469-ddaf-92ce-3daf1d2d726f@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea55623d-d469-ddaf-92ce-3daf1d2d726f@infradead.org>
X-ClientProxiedBy: AS4P195CA0042.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::16) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 85230c69-293a-47fe-dc14-08db726f9ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA1MBK+ZQXzMiTCimHw7JNQUCSL+c6cHLf3mnl9OkIJsCIbwHhMtjp+r7nrtgfYpEdoZVLg/EzifvkaG1PSTcQF7fBoV0RoPzbUgMBYCPwN+rgw4pmXkWzudQMCoVfRYMVSdnhDTjW4AB6mw0E4C++i2o2WSwgrOur8fIwrmo/rg9bgYG6VjjIGxGnCX2HLble16fh2qp2a1mhObXylYq+C961Vu88QH6n7g8GC9eMySF+uHvx646iOVcYFmtdFXhM62+pNhkJIHn57hNLDFaR1lbZDNiZYtcTM76wSThxWmEG3eQrRQnMkUhtZ0+GLAyeuzE8Oi4W+QdbZf4Kd+zRb7vxDN8jciARTZlksuqVTw1MBu1QKbScM5wNScAmSWn5+pKrxSogz0t7c/kshwZXZIhqyV08qMJ14FUj5K3mbyeWwIdMU9Dvxk1J0IWhBvbVnhXuNOtmSM7zrvHBqS4XPMIxnoO5fIf7osm5QmVOzU1K/ECE9EgUocSmhGCOOx2ELaz8s3l4gsgR1dv0OI/le17bM6puidFQYBgPBo5kYi2JLB+VVG9T5twtsy2m1NP68SnRfW73/ddXse337d2wzroCSK7jQSX8E60ecVAOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(366004)(136003)(396003)(451199021)(6666004)(478600001)(54906003)(4326008)(83380400001)(2616005)(86362001)(36756003)(38100700002)(2906002)(186003)(53546011)(6506007)(966005)(6512007)(6486002)(316002)(66946007)(6916009)(66556008)(66476007)(8676002)(8936002)(41300700001)(7416002)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRV0SVfG2aRGaf2AEFFFPG/xzENec/jlhEqUav+hmqYq4ETeceTtkW1f/XS4?=
 =?us-ascii?Q?DBYmubUcdvIMCiV+aLrLKAeZGiVT/OuYEBikRJi6Kg6Zq/idO7NwizkMh/t2?=
 =?us-ascii?Q?5jy0kHidyF7CwMRLXOf4s4ami4grmNdBsfCtPSrz9jHf78wSRDVZtpp03e+k?=
 =?us-ascii?Q?/aMDteupZDIEndBYSA6MdEiLvNfvcZFWe0cX7Zb4VJKh0+v159hV0ZIomzxt?=
 =?us-ascii?Q?oW2mPEEfIpg95UjtUh441ljb/L5xm3pVoVzMI/Wb5MLMt1OESTJp6JfHIMHu?=
 =?us-ascii?Q?HIc0S2LemnG9uqkbtyODPrAg9UfitkSz5NASZuuLrzYf74085QY4EMFULmQC?=
 =?us-ascii?Q?9eQ8lCdDfDkkLxc4O5FdyR5gzr6iMdNxIRqp3aDz5wo6hNVVUn9ib1+Vm3oq?=
 =?us-ascii?Q?Qs6fHqhm/V6Bs+fzh5o5steBBWZxoZuIHnEYVai/1VSTOsUg3Aa0NU8NdMVy?=
 =?us-ascii?Q?W6/1lqEcAKfPO4BrUwazS5apPPro9CUZm598ZROLhQQdjMzOzso8j8IPFX6T?=
 =?us-ascii?Q?+5fs9OxIlm6ObO8H0SA1hEJRXPBWSM4Bb45VJ/a4bFDncmVLf3T5PJeF8kiJ?=
 =?us-ascii?Q?mrIbdI41tdHyDOMdvwKUX2dlXJ8DzKVY4mEDT9mq1ufMIN6MU12xNlf7S064?=
 =?us-ascii?Q?v+49iA23uEcbhew+CWBAppYjFwwkIZm5aJcrAYBWWYfMkHqOLPbKg5aEGGwi?=
 =?us-ascii?Q?2r3NcCWElPIlEO4DHfKDm4C1z94ZQAMxhqX0LUJE0OWufM/urxYSoT4mTMHt?=
 =?us-ascii?Q?QZLUzFgKf5c38j8KvOjiyNaLjnKumHVWZ4p3XXV36g3xAsQSnz5uBpzgjzv6?=
 =?us-ascii?Q?WvBoiwFKjBq5K2AQn/hmwDZhH8pF7uazrsGd0I58nY+/DwbgPmneU0NzSHXw?=
 =?us-ascii?Q?brrWRu/GuMS+qZiYMLBSQGS2npNyWcYSPW2Vk5V04Lyt6N0L7RG2aje1r1z8?=
 =?us-ascii?Q?CkvSZ9fjzHAN8t1ml2/THfrGvBdFzsuocbEqf4AZqw3coZuaDKcodMmF8yux?=
 =?us-ascii?Q?eQALBC7n0wGNEJGqqvy7U/yW7TI9Gi8nMmyQ+8rvLT3tZ0ONPBJC5ZUavzzk?=
 =?us-ascii?Q?FWx6kV2QokdTp8Y+637FDTxuDbSBEbyXyDJK0j9hbl3LYLzD8vVijbE2+ToN?=
 =?us-ascii?Q?i8REk/Jb0T1FiB9v8K2kHbQ7abFxjZGuAClQvQS8a6Oz82cBpfWVg+ESpG8l?=
 =?us-ascii?Q?1BIooQceG+f4zITbQ/ltzqXE07VfoE4WweTUc8daV4WV1/SuFQ5pXm+94FhM?=
 =?us-ascii?Q?4c9P7wh0kYrn8LcsMlcHqLlt8yN7wnCseu5jlQx4R3/RjL1dtMzU7EJO7xQZ?=
 =?us-ascii?Q?llBA56MIbybKSNThOELOKYmqaU0trWU59yuRqcjqSp6534O1oMRJLVKKg8Ur?=
 =?us-ascii?Q?NdA5k1Wb64NrS5hE7IwCjKGetwY851EshHXonkeuVtRzU2hXoahO13cZiGPQ?=
 =?us-ascii?Q?VPQGuwVSb8ATI/QqHewX6hJ310XVMY6tuT6MwaYeaNrRTSNOH4Z3pCMaR8Yw?=
 =?us-ascii?Q?YcXMlxbLUSMOaWlVMCh+/v2x2+lAUhtQY0FS3uBqheCemy6XqT4pL8ZdU3Ev?=
 =?us-ascii?Q?fx1/xQIvcblIW6dwWI8hHyQj5ML6qhu/EOTHpQp0iWM7s7ovZK+M0LPV6uTG?=
 =?us-ascii?Q?ICs678U5IXZ7WjwT9WBTP1iQQ1lMLSVjJplv9SRXEutL5A+8dpLFtjD9EfAg?=
 =?us-ascii?Q?5fYCcg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85230c69-293a-47fe-dc14-08db726f9ca0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:53:10.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHX7BUCZqpZf++DJ+QgdAi0eP/gXcweQGz/L0TtW6tGgNe/4aNnjidHyMD3/6gNHGoQl3oy0GRHfriJlHTwNj3S+2e0LsRplyQs4wANS71Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5126
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:35:17PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 6/15/23 15:21, Randy Dunlap wrote:
> > When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
> > warnings:
> > 
> > ../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
> >    40 | #error Cannot compile lcs.c without some net devices switched on.
> > ../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
> > ../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
> >  1601 |         int rc;
> > 
> > Solve this by using IS_ENABLED(CONFIG_symbol) instead of ifdef
> > CONFIG_symbol. The latter only works for builtin (=y) values
> > while IS_ENABLED() works for builtin or modular values.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Alexandra Winter <wintera@linux.ibm.com>
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > ---
> >  drivers/s390/net/lcs.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> > --- a/drivers/s390/net/lcs.c
> > +++ b/drivers/s390/net/lcs.c
> > @@ -36,7 +36,7 @@
> >  #include "lcs.h"
> >  
> >  
> > -#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
> > +#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
> >  #error Cannot compile lcs.c without some net devices switched on.
> >  #endif
> >  
> > @@ -1601,14 +1601,14 @@ lcs_startlan_auto(struct lcs_card *card)
> >  	int rc;
> >  
> >  	LCS_DBF_TEXT(2, trace, "strtauto");
> > -#ifdef CONFIG_ETHERNET
> > +#if IS_ENABLED(CONFIG_ETHERNET)
> >  	card->lan_type = LCS_FRAME_TYPE_ENET;
> >  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
> >  	if (rc == 0)
> >  		return 0;
> >  
> >  #endif
> > -#ifdef CONFIG_FDDI
> > +#if IS_ENABLED(CONFIG_FDDI)
> >  	card->lan_type = LCS_FRAME_TYPE_FDDI;
> >  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
> >  	if (rc == 0)
> > @@ -2139,13 +2139,13 @@ lcs_new_device(struct ccwgroup_device *c
> >  		goto netdev_out;
> >  	}
> >  	switch (card->lan_type) {
> > -#ifdef CONFIG_ETHERNET
> > +#if IS_ENABLED(CONFIG_ETHERNET)
> >  	case LCS_FRAME_TYPE_ENET:
> >  		card->lan_type_trans = eth_type_trans;
> >  		dev = alloc_etherdev(0);
> >  		break;
> >  #endif
> > -#ifdef CONFIG_FDDI
> > +#if IS_ENABLED(CONFIG_FDDI)
> >  	case LCS_FRAME_TYPE_FDDI:
> >  		card->lan_type_trans = fddi_type_trans;
> >  		dev = alloc_fddidev(0);
> 
> 
> kernel test robot reports build errors from this patch when
> ETHERNET=y, FDDI=m, LCS=y:
> 
>   https://lore.kernel.org/all/202306202129.pl0AqK8G-lkp@intel.com/
> 
> Since the code before my patch expected (supported) FDDI=y only
> (by checking for CONFIG_FDDI only and not checking for CONFIG_FDDI_MODULE),
> the best solution that I can see is to enforce that expectation in
> drivers/s390/net/Kconfig:
> 
> diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -5,7 +5,7 @@ menu "S/390 network device drivers"
>  config LCS
>  	def_tristate m
>  	prompt "Lan Channel Station Interface"
> -	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> +	depends on CCW && NETDEVICES && (ETHERNET || FDDI = y)

Hi Randy,

Unfortunately I don't think this helps.
In the config given at the link above, ETHERNET is y.
And the error regarding fddi_type_trans and alloc_fddidev being undefined
seems to occur regardless of your change.

I did have better luck with this.

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 9c67b97faba2..303220251495 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -6,6 +6,7 @@ config LCS
        def_tristate m
        prompt "Lan Channel Station Interface"
        depends on CCW && NETDEVICES && (ETHERNET || FDDI)
+       depends on FDDI=y || FDDI=n
        help
          Select this option if you want to use LCS networking on IBM System z.
          This device driver supports FDDI (IEEE 802.7) and Ethernet.

I am assuming that LCS=m and FDDI=m can't work at runtime
because there is no guarantee that FDDI is loaded before LCS.
But I could well be wrong here.

>  	help
>  	  Select this option if you want to use LCS networking on IBM System z.
>  	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
> 
> What do people think of that change?
> Any other ideas/suggestions?
> 
> thanks.
> -- 
> ~Randy
> 
