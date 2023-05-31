Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F07718E90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjEaWcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEaWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:32:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C769D;
        Wed, 31 May 2023 15:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUPTKhZ7RcHhXgkiJ1ktNgVr3NTacvzeC/2ovH3iEmWxVZ0B0ZbAcbQkS/ixpv9QPQPw+F9yw5xKZtLWWLUOeu6BkfXYo/s/f1G/TXqNBxhYDbXTIvvrvDJTtTB7ZreiNXGXZJk62LLUQaiLAhHuMXYa8nu8L+OPADoscSK5bMQ3Y4K4FjeEFUg9oN+ZmwBLgTb3KNC65fPi8JAT4m1uLkGZi0fG865yTw+i4dA24PmhbiAS5QRQqHLxklk01LPvch4m+ihjuYnSLz2Cjstq/hdXxXCUW3Op2JZiHFVcOXs7m38MOE3h1bK1xjHK2DFOmUIW1LoBvXs51aTiZ3dDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPQ7o1MxU00O3hYxKDVh88QYR+ja5Q2EH/JAIjzuxrQ=;
 b=YAq17avmx5mWEHKsr7s6017nLHL3+xVifW4sPIYiRvUgjv38pTWMSJ7SnlkXT2dt8E96MGs8rZfWNjYIPiiHb81AwdqRQdKVOZf/meoQlCFO4Tyr+/xlPC1nUzisipsIIEsbchoYFZaKrk/im7VArZjswCanpn/+JCtesFSuGjueP2xdzLf4keplR/cgqIkwKtwcmeHRq3a6dcjybafnynucZYN1eyHeMZifhSSm+PQAyNGt9Lshxxwlc27Zzfr2BO02arbFaVmgwXLT2Aam930eME9AdL1mjk3/LhnmRFQed9tgi9CjbTiiSiR7rO7ZDAuEVJFl3xfR+Aofsd9NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPQ7o1MxU00O3hYxKDVh88QYR+ja5Q2EH/JAIjzuxrQ=;
 b=hluevz/eRJkCmeLlCCMTapoPj+GeDFA4lEByobvesvT5SyKjJrQvpXlmsemfrMQd7OywFGK5R1nyoQCl8xUxCBlSG1MYglU6RwjqVk6xHJEgmxhbNooU5Ro5LQzHgWAJII8ffVjSWaD4cdZsauVoa2gUiPb2+6d8kzcOfzO79o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 22:32:28 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::803:a64e:c632:4452]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::803:a64e:c632:4452%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:32:28 +0000
Date:   Wed, 31 May 2023 17:32:22 -0500
From:   John Allen <john.allen@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 3/3] crypto: ccp - Add support for PCI device 0x156E
Message-ID: <ZHfK9hsCyrAeRyYz@johallen-workstation>
References: <20230519032414.94247-1-mario.limonciello@amd.com>
 <20230519032414.94247-4-mario.limonciello@amd.com>
 <ZGfLrtmVOcCYiWFW@johallen-workstation>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGfLrtmVOcCYiWFW@johallen-workstation>
X-ClientProxiedBy: YQBPR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::28) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: b94e8f70-611b-47a7-4683-08db6226e9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8OTz7wJ7L2431P9Gyye8CwBOzOACknJshD+nGaNwnCFjRyBGVUNd741alfHy5zikG69dQsJbdtTZ34/xEu4Sg6DGDbmfh/4XR/6qXrymekEK3nbZ6i29PC6D+Ql2qBgTNFC8FYB1hl0d04xXv6J07DNEyAyeN5xq6fqyglziZ/K/RD1sWxqfwCxHEHgLnr8TzO5j4nPkM2ulaEa1uh/ZtY0MUBnjQAaq0b5v70inoK4R2V23OZIjj3UZUuXtRbh/OU3spzEOhBQHUdyfhQRPyZ28xf0NmeCphCZud4lyGkqocxsOTd0HBkRFcy1nz7JD1ISZGlI1wYH2WTitvwOYTmcqT2ABKWASoAVko24ak13GB5WsQ/G7WSZuMnuIb+Xy9US4w2nmqUot7O9h+R3crs123kOXshcQ338oecCh7xH8YnOaZIIxxYt9YxOXNKMy4HRoDDNwN2KMcOeH+xr+dSgHXTZB2ID5PYwElLyCWZyIs9iFfpkznGU4NrAtio8ZmjI00QABvjvnVWWxV+n1nTHkK75NaNadrTKgAHLM4upMCS+jvDv/2l/XX1GKcdH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(33716001)(4326008)(38100700002)(41300700001)(316002)(6486002)(9686003)(6666004)(26005)(6916009)(66556008)(66476007)(6512007)(66946007)(6506007)(44832011)(8936002)(2906002)(5660300002)(8676002)(54906003)(478600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I06rgvuOnF4ainxqLVKn8wrHixEgXBAaM6f2z+CKgsh7IuGz3/KLjDvfLoI4?=
 =?us-ascii?Q?25TF1KeFDwA9B90K8lhkEOByzfvD72C8iPGkKITkTM/z+M3XFBwzEH5x8FWE?=
 =?us-ascii?Q?HtFR+6gcdt+g3TnxQpIhtG8vUnEW2h4pqpNZU19AYQOwc5SIBgzhtfUMcoTC?=
 =?us-ascii?Q?jZQD9K7OuU1m+JD8ff/bc5zwlMnv00LPEmce+txfWOcL9eiFCsl3oEstb1/d?=
 =?us-ascii?Q?YwMH4JOQVZe0Ej2qPI8fGJVHFJAV+segL842C8X5/NrP0xRmotAVFLTOLByW?=
 =?us-ascii?Q?MBtwiSFaPHezTwnqZYgSwtgbujNfmon6TyTI/8fyaJyj625NEmq+n5aYa5f+?=
 =?us-ascii?Q?p59DiNpRsc4bVukzGGPy9xbSmtk0ZVEfiL+QNIY12z+mIKk21hqotu09mWwt?=
 =?us-ascii?Q?j4Ca7SwguSFwPoNsEJrl6Wug4Q/nXMA2oHv3VlhnUQqEtNQBThKQ77ioZxiV?=
 =?us-ascii?Q?jG1T2Ud0p+SZ+9TRFOvvdi6p3tWOZ5sWcnAoyNpGgjFl7BVI1thyTtbkfH0R?=
 =?us-ascii?Q?AT4wclo/+eeMTebPYfUctZeMwcG6H6T8sPu1xJHeT94WxrFhquFMnnBGW4Ol?=
 =?us-ascii?Q?SFBQ3LG+ieIQxmHMdB9GoB3eWt+dyyCEyTALz699PZz5kuW9UMr9s8+Ec8j5?=
 =?us-ascii?Q?yXxaR1dWdgbNGgpxJvEzJFgftco5BAYlIT3E4zKdXkkQbRgK2199cVC3+Jz4?=
 =?us-ascii?Q?q+sJxiU+NJ9W/lglt0adBaQNjZwJy2ngVaCr8zVG+QjuOsAGA+HqlzKkU4dO?=
 =?us-ascii?Q?kr7jGe5RK0ORYIJ5z+hZD7PDaHK9De2Rq1x4r0tOtGnn0mLrPXVWxK12AUED?=
 =?us-ascii?Q?0br93D/MFrlMhYVlLbYDzaV0DvtY/XGA/bhiqzJwTKQShdjdWWokc5wFQuBe?=
 =?us-ascii?Q?7/stA19nu0oUBCbdqSa3+xCB/n1tDFDC8Myr4pTPG2iH3UtEcO4dp631Tlna?=
 =?us-ascii?Q?nG7vuh47Juir1pamvPCwPmD2Mr493rZSACIKfvz3W/zH0msJC23kjmS/Yoqg?=
 =?us-ascii?Q?eOIKAJEH/cUHQ49P4Ys6olEM6yolh5ELXoybFxK4lFKk+afdscHdCGlpbt//?=
 =?us-ascii?Q?6rR+uKvrrbmvQRmzFIlJlk8vCkrXMVCdeat2CBP0Etut1/K3JmnAJi/hobFS?=
 =?us-ascii?Q?aO8U7XPLfIEHY8U8JGsWHN/uZRlkQ5RoBwIIEuGxcKKUwT04Peon/sVDy55X?=
 =?us-ascii?Q?lGyP+T7B9FGRMQNJQ4I2F5Pio5fFSVoZENQSLdm6FaBFmaGJItMHc8SQji/r?=
 =?us-ascii?Q?iezkcb6BDDW5Qfyv4ZFnWY5/c3aaq8xpTSul644ohz3Qw20PHoBU6/uFdcY/?=
 =?us-ascii?Q?cjNiN5plEyt08Xod0tCQjEx//jQyg/Zn5V9q4RQTUHaf87TYr9yFc6tOvOL8?=
 =?us-ascii?Q?sPqgy0qfLkXBmbviW5j+nT0EL+AVgLOkcfmuxJXHUwmYjwDL/Y/r0wLjHmz9?=
 =?us-ascii?Q?nogryvVChE2Wkvy7v/nh5AUY8Z7XAUZZsKXhfmP6muX0tYP0WD5Eqg7Qd9a4?=
 =?us-ascii?Q?YJxN5hEoXXAl2iizSELVzs10Pjn//FjmdA5hTPSWGxucuHhqcorZstlY1EDs?=
 =?us-ascii?Q?iFKAgC40R6sMzf16woxu31ZEXdhBxxepZQrPGHrZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94e8f70-611b-47a7-4683-08db6226e9ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:32:27.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JTqMqY1BqUJP5whdXFaGgkDHINDBGeirqoo7o31XHB03Ljlew9ZkCSLlDTNBuEBudOGFPXzLP6Mm+Jk3DbM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 02:19:10PM -0500, John Allen wrote:
> On Thu, May 18, 2023 at 10:24:14PM -0500, Mario Limonciello wrote:
> > From: John Allen <john.allen@amd.com>
> > 
> > Add a new CCP/PSP PCI device ID and new PSP register offsets.
> > 
> > Signed-off-by: John Allen <john.allen@amd.com>
> 
> Hi Herbert,
> 
> Please hold off on applying this patch for now. I need to do a little
> bit more testing.
> 
> Thanks,
> John

Hi Herbert,

I completed the aforementioned testing. This patch can be applied if
everything else in the series looks good.

Thanks,
John

> 
> > ---
> >  drivers/crypto/ccp/sp-pci.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
> > index d0d70af0c4c0..b603ad9b8341 100644
> > --- a/drivers/crypto/ccp/sp-pci.c
> > +++ b/drivers/crypto/ccp/sp-pci.c
> > @@ -420,6 +420,14 @@ static const struct psp_vdata pspv5 = {
> >  	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
> >  };
> >  
> > +static const struct psp_vdata pspv6 = {
> > +	.sev                    = &sevv2,
> > +	.tee                    = &teev2,
> > +	.feature_reg            = 0x109fc,	/* C2PMSG_63 */
> > +	.inten_reg              = 0x10510,	/* P2CMSG_INTEN */
> > +	.intsts_reg             = 0x10514,	/* P2CMSG_INTSTS */
> > +};
> > +
> >  #endif
> >  
> >  static const struct sp_dev_vdata dev_vdata[] = {
> > @@ -478,6 +486,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
> >  		.bar = 2,
> >  #ifdef CONFIG_CRYPTO_DEV_SP_PSP
> >  		.psp_vdata = &pspv5,
> > +#endif
> > +	},
> > +	{	/* 8 */
> > +		.bar = 2,
> > +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
> > +		.psp_vdata = &pspv6,
> >  #endif
> >  	},
> >  };
> > @@ -491,6 +505,7 @@ static const struct pci_device_id sp_pci_table[] = {
> >  	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
> >  	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
> >  	{ PCI_VDEVICE(AMD, 0x17E0), (kernel_ulong_t)&dev_vdata[7] },
> > +	{ PCI_VDEVICE(AMD, 0x156E), (kernel_ulong_t)&dev_vdata[8] },
> >  	/* Last entry must be zero */
> >  	{ 0, }
> >  };
> > -- 
> > 2.34.1
> > 
