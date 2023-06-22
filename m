Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86F73988B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFVHxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVHxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:53:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2093.outbound.protection.outlook.com [40.107.223.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33581BF5;
        Thu, 22 Jun 2023 00:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCgm1A2SqpZaDEWGOFifYmbzQ8pki1vKnrCXXcXP57oGf/+nP7KjkBx1Gj+QEvgWORyz4o9UBBxy5gFxQ/kevnpYS1hK5yqC9a1uSM6wZfQjbxApyRxF1nY3baVRMkaE++7ZNOJpM45y259KVIYt4f1i7VDpIe9LCQd013NqStWCrBy2Xg0DRLBY7sYAboO2xC5o1vgfplbhN0OALQAgT66A16w0iISdwWfddpCDXbacNqn9wc43fuWemReQbuLWQy5edd7So/UEaXIyEwNqD8mnQ3KTByWYozNsYiZpKiIXRhUuOa6LO9+yTn4bAoF2Tzu07Og0tebHOy7NUwxIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL/DBYEYAc2al9q683ws/N5Mfdn1mq2wCKAUpM7uRG4=;
 b=En4sSutNXNbuy2NA8L/XXIj05R/yY9NTLnEPOt1wJJhzz+XN/tlcd1xbFAwcCAgpAuT0Y7lJ1szaTt6r/aruTgDOA/Kt3KSliDPnpRKUD2HATCG8nr8XBRs9NNhtZbHdUskGGWyiJKfpsfQUkb9Ho75IHpHa88NWjCFbVTBzDDRm53pVcBHCFW9Av3x8jS8KA3TfKpNIWIkJ1DVvS7mfW9vJhJP+DhE8TPos4U4pBIisNNxpWlzYU7x02V03nNEB8wCDgXolF6m2laxwDlO+asRa4tbA8ocrDrzmGPstKw2RF4fhQKm0vdAfDb9LoVYu/KLe3Pe66a+1W09MOuIbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL/DBYEYAc2al9q683ws/N5Mfdn1mq2wCKAUpM7uRG4=;
 b=oxXmOFwE1aLoUpUtzQ9eC+gxLilZYZy9RBIJcHzi/JL/nHbLQPiyhTQRTtn5Vrog86GK+4ABPV0MMdQ7sRPu0zVl26ascmrSjAvahom3UtJND54lEvSIVVh9ZEPN63CgHHU8kFnHmEHcih1Hu10Qt1Y+SKH19zh5Z+RO+UNkip0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB4042.namprd13.prod.outlook.com (2603:10b6:303:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 07:53:33 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:53:33 +0000
Date:   Thu, 22 Jun 2023 09:53:26 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexandra Winter <wintera@linux.ibm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] s390/net: lcs: fix build errors when FDDI is a loadable
 module
Message-ID: <ZJP99hSRt5MakBXC@corigine.com>
References: <20230621213742.8245-1-rdunlap@infradead.org>
 <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98375832-3d29-1f03-145f-8d6e763dd2d2@linux.ibm.com>
X-ClientProxiedBy: AM9P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7187d197-c102-4d82-e73c-08db72f5c729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkK2Ec4gSluXJ6WtBYGgxS7UIxjBcat2BB1gCW43Af9auCSXXzvL09DfhdBcp4MzyOvNJPeNLGEsr6JjGTGAueNQimlZujd2k8mhJA3cxKYIAt54dsPK8hWeSyevoux6D7OJEBXa7T72ZOWXWUcetXvlJ2r5uth6EnJEm+9q0gDUvaFeEtM1iNwOmXRfAYJ7/244T0zi1rkd75NVIwBn1JzfdBPEsDGuYC7vhIoQHdMBViMhP9OQsbhiGvXGlI9O2SVPybKlLvOLqniP2dZIsuazY44aucFLznGkiZcb6hmTxsSZ+NXYIDdnXq7sTFMoChqTYGsaWL1QV50yXlqGBTDBNzdRhU/c/+hZ3Cn0WkhL+9c8nBwNsQTny+/kiZwyONK4oj15Eq4mJdPQ54euM1udQdTDZ3brth9nKGfQCjSw9WJSN9Mi8HPQst0m8cPBLgE2zBI6o4otxS86ghxpobrTGTIOguU4bRzaXXGw9yaD9rqHHuvuq3v6VJ38uaLlV6k+sd2C6W/dayFQzMQ5oIQykczTeq+7H/ag1dKoFWZjn43UcFfS1RtM9eaJXHfmkUTakIG9/kSE/YB4YOHDpt6FSjzpJPouHjyiLlSSijI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39840400004)(396003)(451199021)(2906002)(8936002)(8676002)(7416002)(86362001)(44832011)(316002)(6916009)(4326008)(66476007)(66946007)(84970400001)(66556008)(478600001)(41300700001)(54906003)(5660300002)(83380400001)(6666004)(38100700002)(6486002)(2616005)(186003)(6512007)(6506007)(36756003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I9M5UUS5je4wTT7ov5gpRhsjlZkOzu2xMa20oR9gWFCuTrW1uq95R8EKD41n?=
 =?us-ascii?Q?Sy4+9/yz8P6y8PiBriS9klT9RAyY0XRUCMsrua0u45TC1uhTmlvzpdsn2a3d?=
 =?us-ascii?Q?9cjVhjtPQhOekscWMGj7P0q50pJgMKSoQqXjG4M9GvxTi3au9EtutgaxDIzy?=
 =?us-ascii?Q?kbDhu+efaEpjDq2iBR/swFVu52NBmw7PfvH0UynBxx+pr3W+wW4pjhjE8ya6?=
 =?us-ascii?Q?jXVEvKIyq0olO/DJ7zloBcl3izTjlxWtUXg8XciVuHEPhnb6gojU57aOZSzl?=
 =?us-ascii?Q?O8YGqM56OoeJD9O5G5zVmfh0WifosEKFDVlbhAIJXLzUCxHi7LKkD4UvN4vN?=
 =?us-ascii?Q?vCEZThL4KFUKx3k+QItUVBLLAnvuHSiu8RwKh3GzFJnTD4XJKJQ+etulyKr0?=
 =?us-ascii?Q?mJELVqcfZUJweSsjxX4m6FyJxA7nFCOed8ymjUolofb6UVVbEGWI24xYOi8w?=
 =?us-ascii?Q?JN/HA5Ji0+zxr4cOWMh2sQJ9jzJzpw5BYq8ExA0jYjOGeuGntdIjAwsKlQS/?=
 =?us-ascii?Q?bCEgW9I7dozWqdzYbuPToxbKlq4zTBwbLUvak5m+g02HgLxw0r30qHnZIdKE?=
 =?us-ascii?Q?j/GLQIqF8eMpa83R63gqnYOtj60OUeuw7uMz/ppaVAmcqdbWP8jWYutKwWec?=
 =?us-ascii?Q?mgz4SQ69gSbKazzfELGU3OLTxpoWpUbsWNanJ/oT+Q1vSjM2gO3Ja0nt+pt5?=
 =?us-ascii?Q?x8HaZboR3YHhtodaLUPFlDJ3cubJINhKZ2TZe7rmUfq/XU3wey+SzeLd4KHW?=
 =?us-ascii?Q?nYFkl8NLSGKAeDaKrmz4ghbJCknb8Iq6zrJVMDLG/XYOeUtQBKvk//bfc8zv?=
 =?us-ascii?Q?sqZwlGnpvmSGWvo638QIBq0zR6wn7L9szYdDEHdFEtsjoIyiNdLX2VTqdsLp?=
 =?us-ascii?Q?7h8lljN+IIvygrrRCqKJ9nH+0qE+4hmj26w8zi2C5Pxd1zLm9fd4GgQbfnoH?=
 =?us-ascii?Q?eIifyQGuwHY9Irgsfg+VJzuMjGTku4/90KTwkJ8Yzc1i3fsa5FRpa/lMHUqR?=
 =?us-ascii?Q?w3XxDzef7aLI7HyOCLOclpnvwYtFza/S5i1b/5rp28rOhSIl41jCsHuvDZgI?=
 =?us-ascii?Q?JSLomg+Xigtd36x17LIe/Zv5VWdPvg02RbYgyxwW9nD2lwHmIPzy3UE6zKMM?=
 =?us-ascii?Q?Eh5e/JGIAqebI35uePEn1ZTlHc2knOv45h3xXxYAJKvE8jiWfQqLr/OtXsf5?=
 =?us-ascii?Q?83DJzLyvEV6ZWj59MtCq4WpYzCILvNiSNQTmjsjeshTO7Cben+n1y1HUBwZs?=
 =?us-ascii?Q?fHMNbb2Nj/4ig/vbmTt0iGpyGjZTlTccCW9auwlXvmomsHBa1g9m/kOSZYRG?=
 =?us-ascii?Q?j6AS+nH23L5wiLu39FrYVwvQCuA1CoLaMc2d/zJq0qS3QjBIJ+e3OS9ipIUb?=
 =?us-ascii?Q?Hx3FU+zGi91Ia8vNv/vWs5+tibabN2HDt75lQrZaEE8kS4ZUbD/5o0m/fhuE?=
 =?us-ascii?Q?hzMgoskmOhlDAs9mK/7GEej1ojtO0phMfcCHuJq6xTunJnVfOLTwC5UBZOa1?=
 =?us-ascii?Q?naNYBCMI3QNgm7gRWjvgAld9N0OwFGVch6ODe7V2n1DsxXeMTLy0v090Gy6Z?=
 =?us-ascii?Q?a/MaRO6ZvbO4th9Du6OtLLnEmpNZM513kWfZHRM1mpa4CduxvDTkHlnfzwcb?=
 =?us-ascii?Q?8JU9oxOuNkav9I/ThjmdPO0L0zT2myPMm8/bvJCBYEk+ID0LS5Sj6A8b6KtI?=
 =?us-ascii?Q?23TbWg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7187d197-c102-4d82-e73c-08db72f5c729
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:53:33.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfvScSGposxMTonAi9E8ypSnWm4QDE9Ym4wuj8kodUB5tXMromE86pXgflDXokGvSRAB8npVtlCZOMQBgM/GvUehmrrBUMJCeYlK/ABAzco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB4042
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:15:24AM +0200, Alexandra Winter wrote:
> 
> 
> On 21.06.23 23:37, Randy Dunlap wrote:
> > Require FDDI to be built-in if it is used. LCS needs FDDI to be
> > built-in to build without errors.
> > 
> > Prevents these build errors:
> > s390-linux-ld: drivers/s390/net/lcs.o: in function `lcs_new_device':
> > drivers/s390/net/lcs.c:2150: undefined reference to `fddi_type_trans'
> > s390-linux-ld: drivers/s390/net/lcs.c:2151: undefined reference to `alloc_fddidev'
> > 
> > This FDDI requirement effectively restores the previous condition
> > before the blamed patch, when #ifdef CONFIG_FDDI was used, without
> > testing for CONFIG_FDDI_MODULE.
> > 
> > Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
> > Suggested-by: Simon Horman <simon.horman@corigine.com>
> > Cc: Alexandra Winter <wintera@linux.ibm.com>
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  drivers/s390/net/Kconfig |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff -- a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> > --- a/drivers/s390/net/Kconfig
> > +++ b/drivers/s390/net/Kconfig
> > @@ -6,11 +6,13 @@ config LCS
> >  	def_tristate m
> >  	prompt "Lan Channel Station Interface"
> >  	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
> > +	depends on FDDI=y || FDDI=n
> >  	help
> >  	  Select this option if you want to use LCS networking on IBM System z.
> >  	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
> >  	  To compile as a module, choose M. The module name is lcs.
> >  	  If you do not know what it is, it's safe to choose Y.
> > +	  If FDDI is used, it must be built-in (=y).
> >  
> >  config CTCM
> >  	def_tristate m
> > 
> 
> 
> Wow Randy and Simon, you are reacting faster than I was able to evaluate this yesterday.
> 2 thoughts:
> 
> 1) As ETHERNET cannot be a module and this patch prevents FDDI from being a module, then 
> 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> is kind of pointless and can as well be reverted instead of doing this fix.
> Or am I missing something?

I'll leave that one to Randy at this point.

> 2) I wonder whether
> 
>   	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>  +	depends on FDDI || FDDI=n
> 
> would do what we want here:
> When FDDI is a loadable module, LCS mustn't be built-in.
> 
> I will do some experiments and let you know.

It does seem to on my side.
But checking would be much appreciated.
