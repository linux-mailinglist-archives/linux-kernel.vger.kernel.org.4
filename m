Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9550C73903B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFUThk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjFUTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:37:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2123.outbound.protection.outlook.com [40.107.95.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2119AE;
        Wed, 21 Jun 2023 12:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moujL0AYeUHkqmcWL4qC7q8qmPBIiw6fF4XlfoT4NsC+BFHJzzOpIMU2FriemFEHOJG3Cirxw22/liGbct7RO4g/eNrMcet47je2mQroXuyHpUvn4jukKYLWQ7IoOJl0D1kJmoBcTmtPsJXQNIqobgG7XSuqhbhmVyDtnmwX9gXgw/k3WlUFcxNur1DVbswPgk182xJlCTJ76YKM9rcmApkxkHmZUoj2Qxx0Oop7Vq51C/gM4IXpPI/osWGneOggbsjri5H4PMn5Y6NS2ZITBN2bL5QtdXNsiiNn60acbyU+Yi2k6DOg1u07AxBFIgTQwQjyV54YHQRekT3VfiDijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb7a2yAITuVZFpdgg1h2iGprPd5hySPQ1VtBuy6PAAQ=;
 b=kCcgnVc5vGN3kOitGOGsZH8o4WDoIHYc83YJjw8dzBeYo0PyRCO+9N1bumaEhgrQ/JY68X4rFpqaQQ0xwpSMm4K4IkHbAHGFoSu9PFoWeLBxpeNm1L7ezhNw8tbxjHa5Al2kNWcYknhnpEEKakQ5jsHy8muoumk1jK7FUaJBh4d2C7I6RlgEiO+kNxzfmsKHCXaAP7lunJAsRb79RNgmDCZZi+WfR7wkP2MU9T75SUelGOfnJp1jSR2ewtPA71aV1jOud9q6GkPg6aqgoPJLsrR8aVEGXqFI+jgeJwMROhRsaLoVUaQQxhsExL8MeN/NESAdgd2uFaIW8mC8mm30ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb7a2yAITuVZFpdgg1h2iGprPd5hySPQ1VtBuy6PAAQ=;
 b=o3sZNVgBAEx91E1tZPhZ8aIHLjnKSG27nU2V+i2WYK61uNNph/lzbJmUEHDdP0OfYfWB9TzQHAhwpiiq6daWD57BstPIUuoCs9JBbuG1+miOSQYKyeMG+UbAEcwZbJIgaNBlmVQYnqFoCIo0naDbaAcckfSOzX5ajiKQOY+r97M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4152.namprd13.prod.outlook.com (2603:10b6:208:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 19:37:16 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 19:37:15 +0000
Date:   Wed, 21 Jun 2023 21:37:09 +0200
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
Message-ID: <ZJNRZZCkGdvp+k34@corigine.com>
References: <20230615222152.13250-1-rdunlap@infradead.org>
 <ea55623d-d469-ddaf-92ce-3daf1d2d726f@infradead.org>
 <ZJMc3oS2nxORPASN@corigine.com>
 <66fd6106-16a5-d61a-4202-02ff99b84f76@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fd6106-16a5-d61a-4202-02ff99b84f76@infradead.org>
X-ClientProxiedBy: AS4P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 572a355e-2021-42db-1707-08db728eeae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egk0miir/CxnsW4TVvNfmCc0GUPwfR5NuVPY/FnK9Zec57BcFHipbL6xvIR1iXskR77+AvRU/EzBhHFl/DWc3cMIiduVaB7pO8FELCv66mUSaH3ISCWnUSq6glxoSPx1Jf0/5cZUQRbyv6X5pEMGmdnXxPYTY6H7MWOZOGVgaw0Ebe+6pIMeVvlDHq7sB8l0B1gJG3UGKljEBrFIj5i6Xm5quWOy3qL0jBFycLSk1k/PnWapCGQvhwjo8tImoGFOHVMyy8iR540W6rSvheJUcNb+6tb2JXtUIEMJ2jbMnUqd4C8iCW5ArSOcttGDgAaxChLYOWRecb6MrYNRh33jrBGBNQu9/RVmFCmdDpkfZgXfVuzO/81Ofto5hkRjC3vn5W7nWRAYswtgb3weJl85/zHvMBpkV7Lz5e2Z2en5w4lNfqgOsVwJmoDOE3HPDC4a0Bz/UDaaxYZUfeK1Lh1QufzYHmQiUcZVjpEWw9GstudCaHHvAX825X7BkIrpqvspwStJj09PvUSOXkoBRfiLfIYHJn5zNY0BZ3zxXNI7+/C7lJt6CFCGx+yz4RkqgXBPawV56VOtkz4nRY5oaf9QFN7aPHJ1+PR+DfpjBWgQkD24F4GL/dM9RLsOZoAbdaDqb3wH2O7d24lanrW4CnwZyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39840400004)(396003)(451199021)(38100700002)(6486002)(2906002)(26005)(8676002)(53546011)(6506007)(2616005)(6512007)(186003)(83380400001)(7416002)(44832011)(966005)(41300700001)(5660300002)(8936002)(6666004)(36756003)(478600001)(66946007)(66556008)(4326008)(6916009)(316002)(86362001)(54906003)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BCCctOtXnUK6NZqtLiXEOuM3inF0J6MbvM3OgX5uMwAORqhVJhqLTKefOkra?=
 =?us-ascii?Q?e4iEOVEM3rwNTq5NOLQdzOVkO2fZ/RMLe59cQ44GlwPRW3yvLqn0xS/Rfb0M?=
 =?us-ascii?Q?ePjO9j9rC/QO2vuvaW7SxoMMFN0Vsx3pWcZj4RH/mr0NvRYL85IVjhAx9Xeb?=
 =?us-ascii?Q?KtA1x9OrYyTfdA8potFpPFdMitp+UEuVi6JKNzsfXNEX06Gg1/y5gV8gYBJ8?=
 =?us-ascii?Q?Vkqy9NnxQAufNNr9JNppwmarlUrG2rLTZKaqAo9OGbKS8NycoYyTZpT9JRWX?=
 =?us-ascii?Q?PiEwra/96SM9VN3QPTCKIJPeWukHjpssjWi9eGovSBuz94LL2bEPMHvcrqf2?=
 =?us-ascii?Q?IycIAUm/VsH6VyReTHoTFtHJFP4UzvkAyuIc36BnNFY49ibFwGvPQkzOicOE?=
 =?us-ascii?Q?gJmwUiwUhgO79+ZtEAZ2Y+REXUH/8yUSPsX9JfVv5Uv0SldkiF/sRacn8Aro?=
 =?us-ascii?Q?Fq6W5KjRZ+fT5dAK69nFpO4t8Xu9zL72f8Lk2SgZjmop0jzvjhsAdb+zDBfG?=
 =?us-ascii?Q?EAqoxiB41AD3QHjFSC2l1U7QIL5Lkn0eW5ld+HYGFJoYkeYtI5n5S+4wXRN8?=
 =?us-ascii?Q?myqGc0sfNYucFiXO+M7QA4FbEblchHSRehVPRgxioEuEmVcu3FwfWJJC7Cqx?=
 =?us-ascii?Q?3o0M/nN8V7fdnJqJlUQAlLUPsOfIFx+YK0sXXZKZ1sG/gGDkA9I+ceGV7ESv?=
 =?us-ascii?Q?UvURE/zEVVW8padWZbwfmVr1K7eeId1PbxthsWB5+ZS+Cix84zXEeN5DUljL?=
 =?us-ascii?Q?nGn9iV0GNqgUx5isDzXaMEzVBFKioa8iVgsipPgvaWXlujX9yXJ4rdFx9Ddg?=
 =?us-ascii?Q?LAM5LNpaF7iXViWnMgd0cbmdaFhxknny+f2QvcBGP9mSumLRt6H+uBHgrwX/?=
 =?us-ascii?Q?ZBfik3HEhutDodRrXQ3Z4k8FoDOqQi8Hg1f//Jv3DYtPV2YKnVJka32iZG64?=
 =?us-ascii?Q?jpfDcgsACgSl0Jtmf30XiO8VgNaH5k8o9c4oSEvK+vLcS5Ck2ch4EST9zmIY?=
 =?us-ascii?Q?awSY55Pj05V9KLj7H1iEJM/GAs2dj5INQCxiwV4bpoKbTKDCnJeIJZ5pE9zO?=
 =?us-ascii?Q?g3/7G2ZsBfxxain75Lgusrhdy/vD1beS3rQNRo0vfNHSZFMOsCrOCotn4ruO?=
 =?us-ascii?Q?bFRHhjLE7GedLYq14694KiLIHFMr8r11nZsBUNDjbDYNHgXQIxQS/NyfKaZ2?=
 =?us-ascii?Q?V25y/pm+rv4crPvLOovu9Bw7vC3ewFHOyU9MSnwBIMNGEyajCqjZELgitwEu?=
 =?us-ascii?Q?vKRlzcsSxz6SH4KUIB0aYg3Sn0JpOQOD17ql9vL5HPbE0Ur0duvuJ6OxJpxT?=
 =?us-ascii?Q?30hxGuxSMSZ5FOsqoMPv8iVittW2zP5PlfOieQVRq0e+mngVtrAWwbHq/wwd?=
 =?us-ascii?Q?giTOPW0NmRCn1KWLuETLpihpRxdYcGYQm01bW3YK2rYScj1AGT9qrBDcST+C?=
 =?us-ascii?Q?9i2/O/Z+wxZMkaGDFQ3SEOshOjcVG3Y1wv0gthYLdQ9yLHOhU/E/D5uRZ4dE?=
 =?us-ascii?Q?XNwN6xecfEGc0u80UQkVf6K8a0TwTH4v0M9lIpE7kluoZydA19IXseqyiSPi?=
 =?us-ascii?Q?zQQxdGtL5GlJzrtgVsyu6lAippLag1S6feVJY3K/w6qorkViCdiSumh2OZbK?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572a355e-2021-42db-1707-08db728eeae5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:37:15.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gFH2VsMVQF6E0yfiPCdI7rp+WCgPF3pR4/derRmvKmlJw2E1fb0qptyGJnlp7S73flakEXKAvNPLI2J17vjO/y+2i8f3L1C8laAafjhFKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4152
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:08:05AM -0700, Randy Dunlap wrote:
> Hi Simon,
> 
> 
> On 6/21/23 08:53, Simon Horman wrote:
> > On Tue, Jun 20, 2023 at 07:35:17PM -0700, Randy Dunlap wrote:
> >> Hi,
> >>
> >> On 6/15/23 15:21, Randy Dunlap wrote:
> >>> When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
> >>> warnings:
> >>>
> >>> ../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
> >>>    40 | #error Cannot compile lcs.c without some net devices switched on.
> >>> ../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
> >>> ../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
> >>>  1601 |         int rc;
> >>>
> >>> Solve this by using IS_ENABLED(CONFIG_symbol) instead of ifdef
> >>> CONFIG_symbol. The latter only works for builtin (=y) values
> >>> while IS_ENABLED() works for builtin or modular values.
> >>>
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: Alexandra Winter <wintera@linux.ibm.com>
> >>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> >>> Cc: linux-s390@vger.kernel.org
> >>> Cc: netdev@vger.kernel.org
> >>> Cc: Heiko Carstens <hca@linux.ibm.com>
> >>> Cc: Vasily Gorbik <gor@linux.ibm.com>
> >>> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> >>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> >>> Cc: Sven Schnelle <svens@linux.ibm.com>
> >>> ---
> >>>  drivers/s390/net/lcs.c |   10 +++++-----
> >>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
> >>> --- a/drivers/s390/net/lcs.c
> >>> +++ b/drivers/s390/net/lcs.c
> >>> @@ -36,7 +36,7 @@
> >>>  #include "lcs.h"
> >>>  
> >>>  
> >>> -#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
> >>> +#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
> >>>  #error Cannot compile lcs.c without some net devices switched on.
> >>>  #endif
> >>>  
> >>> @@ -1601,14 +1601,14 @@ lcs_startlan_auto(struct lcs_card *card)
> >>>  	int rc;
> >>>  
> >>>  	LCS_DBF_TEXT(2, trace, "strtauto");
> >>> -#ifdef CONFIG_ETHERNET
> >>> +#if IS_ENABLED(CONFIG_ETHERNET)
> >>>  	card->lan_type = LCS_FRAME_TYPE_ENET;
> >>>  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
> >>>  	if (rc == 0)
> >>>  		return 0;
> >>>  
> >>>  #endif
> >>> -#ifdef CONFIG_FDDI
> >>> +#if IS_ENABLED(CONFIG_FDDI)
> >>>  	card->lan_type = LCS_FRAME_TYPE_FDDI;
> >>>  	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
> >>>  	if (rc == 0)
> >>> @@ -2139,13 +2139,13 @@ lcs_new_device(struct ccwgroup_device *c
> >>>  		goto netdev_out;
> >>>  	}
> >>>  	switch (card->lan_type) {
> >>> -#ifdef CONFIG_ETHERNET
> >>> +#if IS_ENABLED(CONFIG_ETHERNET)
> >>>  	case LCS_FRAME_TYPE_ENET:
> >>>  		card->lan_type_trans = eth_type_trans;
> >>>  		dev = alloc_etherdev(0);
> >>>  		break;
> >>>  #endif
> >>> -#ifdef CONFIG_FDDI
> >>> +#if IS_ENABLED(CONFIG_FDDI)
> >>>  	case LCS_FRAME_TYPE_FDDI:
> >>>  		card->lan_type_trans = fddi_type_trans;
> >>>  		dev = alloc_fddidev(0);
> >>
> >>
> >> kernel test robot reports build errors from this patch when
> >> ETHERNET=y, FDDI=m, LCS=y:
> >>
> >>   https://lore.kernel.org/all/202306202129.pl0AqK8G-lkp@intel.com/
> >>
> >> Since the code before my patch expected (supported) FDDI=y only
> >> (by checking for CONFIG_FDDI only and not checking for CONFIG_FDDI_MODULE),
> >> the best solution that I can see is to enforce that expectation in
> >> drivers/s390/net/Kconfig:
> >>
> >> diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> >> --- a/drivers/s390/net/Kconfig
> >> +++ b/drivers/s390/net/Kconfig
> >> @@ -5,7 +5,7 @@ menu "S/390 network device drivers"
> >>  config LCS
> >>  	def_tristate m
> >>  	prompt "Lan Channel Station Interface"
> >> -	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> >> +	depends on CCW && NETDEVICES && (ETHERNET || FDDI = y)
> > 
> > Hi Randy,
> > 
> > Unfortunately I don't think this helps.
> > In the config given at the link above, ETHERNET is y.
> > And the error regarding fddi_type_trans and alloc_fddidev being undefined
> > seems to occur regardless of your change.
> 
> Hmph, somehow I missed that. :(
> 
> > I did have better luck with this.
> > 
> > diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> > index 9c67b97faba2..303220251495 100644
> > --- a/drivers/s390/net/Kconfig
> > +++ b/drivers/s390/net/Kconfig
> > @@ -6,6 +6,7 @@ config LCS
> >         def_tristate m
> >         prompt "Lan Channel Station Interface"
> >         depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> > +       depends on FDDI=y || FDDI=n
> >         help
> >           Select this option if you want to use LCS networking on IBM System z.
> >           This device driver supports FDDI (IEEE 802.7) and Ethernet.
> > 
> > I am assuming that LCS=m and FDDI=m can't work at runtime
> > because there is no guarantee that FDDI is loaded before LCS.
> > But I could well be wrong here.
> 
> There's probably some way to make that work, but I don't know.
> 
> I think that your patch is acceptable.
> I would prefer to also add to the help text that if FDDI is used,
> it must be builtin (=y).

Thanks Randy,

Feel free to take the snippet above and work it into a proper patch.
Else I can take a shot at it.

> >>  	help
> >>  	  Select this option if you want to use LCS networking on IBM System z.
> >>  	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
> >>
> >> What do people think of that change?
> >> Any other ideas/suggestions?
> >>
> >> thanks.
> >> -- 
> >> ~Randy
> >>
> 
> Thanks for your help.
> -- 
> ~Randy
