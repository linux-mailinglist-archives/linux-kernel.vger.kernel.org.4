Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA46A7CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCBIdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:33:30 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2DE1B2ED;
        Thu,  2 Mar 2023 00:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUlhGDq8+Tur46a6iZWmgoepuCMhqp4R+uKXGjSv/bxeHokcfKu/pbOpVNZzyJ864+YwmK8YWd0hzz/DDAxu/tzisyjXhBvstqQ7Rc2+G9C2Hrd35AY9taJfxS096n0+yZkq4ug3bumpkkvk6ugPGvFG6LrHxsf7z4IHLso4DMjE5ZInTF3+AY9rnwgmgxW/OaCMGMlhHCbLmx7Ru23lvaFvC2+2ijcK8be2lZTbce8cNxmC6CKSJqciA1RVKvSj/MMqNLrZL2gxLtLDyeThm2QlZFqvqRRXl5DGGY1SlUzhHoWzA0f4BwQ53mbimAUi6huz2PqGkOsgCKwd/DIiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tciBa2kZkx2lVC0GbgDODK5vmqKrP1gUxwf15NGVXk=;
 b=a/2Jem6ZQVhO5FAnpdbAOPjUMEq01uvjSDz1OAeQ5YGBth6GHQ4vSB99hzLYFk7bRRZd/+LAWfjpml0UQvFeDQByNkcv20pT4ji5aijVY0pzxp3R22fJzBXBpFOqIXmMGyIqiauJIZEol65niwvUl6PFVAPVKldKW5Ed9UJeqpv92zrEIZGHKxai0aVMm1gM9nYT0YKmILQ7VEdCh+0KTo3aFY/QXkISwzhEBMdHjC39t3WMnGdULcYhDH9tWxU7qA34j8hX7epK0EkQVEwnq0Z8545waYd9WeehJPguGzeIjZJdlB243JlM8n2kwmw+6P4fzs4ma3RvJ7AfsDhyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tciBa2kZkx2lVC0GbgDODK5vmqKrP1gUxwf15NGVXk=;
 b=kruVTQ6DGCorwIGguMNayB8Sgwvd3a6cyWyWKu73Ig600wMmOEFgWUajpuIkenf4ajZatTDwanAYqerDbkNtvCZd9Wq2PnMzLobMLlcpzrcfFaG+80iCGIdJnTWX0rht/Rtb05a/QvR+fjn3+cHoxT8gz3hjJGqR46Gwaf9dUd8t48vcV4HJGRp392g1X5c4Tgs9lCk08AvlO3yoKDkzx8y6vsZwMugaNPv/rfl1B8CCQ7MtpN66EgDOXplaUg1i+YhaGFuesw2gTW78kCT58wSCZc6PRCQUgBjqttxy7OvBV9yPd7ALEcGAUh70H53W7e3vc38+H1AVMsL+IPPRrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 08:33:26 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 08:33:26 +0000
Date:   Thu, 2 Mar 2023 09:33:17 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] leds: simatic-ipc-leds-gpio: move two extra gpio
 pins into another table
Message-ID: <20230302093317.574c87a1@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y/+JsTpONdhk/nwG@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-2-henning.schild@siemens.com>
        <Y/+JsTpONdhk/nwG@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:610:b0::34) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1daf10-1f23-46fd-1120-08db1af8cac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67HgxLsauapy9tJzzA8N4C9wJVw/ZT8nMtVcVhxQt+CcVuI6azJ6dOwvFp0HmjGyCsDhMDvlAew1EMXvxJSPHqCni9BKF+Bm+pOpqR2bmEZdGDXvajQxNoDhyLh+0fAncZQxpLtiFsmZYoCvsGK7CTPZ/XUahsnzhLgoeUQnhgmaX4ZnvCz2CQJ/Cu41xOA6LIzc9AgxT7g2tBN5ewRb/afkHVKKTsLXLWv4xMw6myOkdOUVKCgrc4x8mEMuqZYAH98LQcJR/e9aNQCa4cDT7sJ5sMHWszxY4HzK5KzqkUV9/yHyZjOamgfB9EIyFz5W8fMGt6f1wDRK1aQcKgIcYqZN611+Z0HaTgT6f3MBqEZyZNEftSLbPz/7E+KVBtInJTVQh57VqELVpCUqF7tUdblxfQNLo2kkXrd6vzG4GfausdBpSLtYk1YZWx0RccVNIqxp7SKDLk6igPo3u/bTMOcOFZqDeIFnB+HR7hlv1q5bFnhpj3Mr48xJQeXyCFHdmv7LVsN/hcVOI6VyhvdzKQwKGJMg6B7GYfFJ9e9OZb30qi0usDf9tjMY2luidwCbESWPVg9BlVMAxJCuwz1UKVGJOibVva/IjqpQUzXjvAcgwYttyr5S05ll5jSZaBniupOkg2tuz9uGjkJ/O6TQvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199018)(6666004)(1076003)(6486002)(6506007)(186003)(9686003)(6512007)(26005)(316002)(6916009)(41300700001)(54906003)(4326008)(66476007)(66556008)(66946007)(44832011)(8676002)(2906002)(4744005)(5660300002)(8936002)(478600001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i90AdNELIiBjcSxeV+iFUsXACCDRFMXAnZVBKK4tLYi871j9hF3+IpoVBb4/?=
 =?us-ascii?Q?rwh3YtCzR6JP+Dnpg0dkBuzcptnc6dcNeSm5sGsPqg4Nt3+QH4hfcCwzySzL?=
 =?us-ascii?Q?HAqCl5FzHjh8iiK5xuJG5YzJJ3GLrVzkq6QlGPOdt2hUJc8m8DvbEAxM59f1?=
 =?us-ascii?Q?5o7V5yHjYRikJL+6GVjuUNlRJ5pQqPYzJJ3Mm6twgi2XnWIiSAQEV87zyr7k?=
 =?us-ascii?Q?PDdBF8XQ5Yy1JiHtPw0dd++bG5nUmRkK8ac+PveZdb6MmJ0FPjwbqf1OenBy?=
 =?us-ascii?Q?7xsgGyPkAYPeiE5UYl+0gXXGfCL1+PjvBi9M1IF1ZtIfWa48Cvzft8Go8zkd?=
 =?us-ascii?Q?OGP1G3Z6Iro4nt6cdMrt+wDziz/dKX+uSOwrTsn2v6azvkyM/goqTh/L+/OI?=
 =?us-ascii?Q?zx6Y8uxYMU57kBb3SZRTUCqUuKiGhekrTnWPUJHwbE9IUVgY4Rptarudzo/I?=
 =?us-ascii?Q?bZQROT2SolGBFUNddsbtFZ7RoZH+EIZfYu6OgFHqFHrvX5UPksyvXG26sW//?=
 =?us-ascii?Q?p+kulM7+4p8Fvo2U80J2M5PKvwZx91plWL1FvYoxgUoBfHIseHDhahuL0/zq?=
 =?us-ascii?Q?QdEJAE7+oV+2l94K404hSEXPdLp4BXRERNr6htUjt4VkIrZqVMjhxndebRQ7?=
 =?us-ascii?Q?Mk4500cK0xtb5c76ivxkplkLNVVex/c/jRydxWlQtlTYywqjFChtdTa7OGp4?=
 =?us-ascii?Q?zLAwozhU5IhG+Kj6fhsQLvMhOyOXkKLhHvpIR9X44OvoYmkuoO5dUPgQGm2/?=
 =?us-ascii?Q?s1ccFV/lgQzZVsQD3Ka6CQCQX+RyZbOMiF3GxILTxbU7UnqZauQhpxFitf1G?=
 =?us-ascii?Q?4zWFjojOUYRQRDvp2LWRy5R5OUqaN/M6SY0baxuTQQ/fWzDgoMCL61L/mpuG?=
 =?us-ascii?Q?O9ahaY5kFbJnKJlSkawmNvWFZf0Wk0g9E1eU9HCCob9qmkBGOdIUWhckmjay?=
 =?us-ascii?Q?/Y/TcEepgBnGUQDlI+IGDSHa8O0q8zO15uL+AUSRc34RskL8+Ye7A/njEkUB?=
 =?us-ascii?Q?Yv8pnmxmIRuZJmSOltJCXlVX/yH9+iiJL2yUwtcCPV7ceuWrShp+KPaBHDOi?=
 =?us-ascii?Q?CqcNBZQeQykJb3QQle32x8VrzDCITgidt4t6vGdR8ow7MhDvUeox/32qTgNU?=
 =?us-ascii?Q?Jm8jc1+c7McEgQHSdvqbJwOiGy1TGDYXCQKQxWO6bELoMS/PCN923FwuB2OK?=
 =?us-ascii?Q?t5tfa6JYgbThBu162KO8Dzl49U2Uj2BBhjHujITvN0uqPfN+TPoZ5MKflzmW?=
 =?us-ascii?Q?Dx5Rl82vBiA1mIkcv+F3qWrlgGCTcqSxzfCtD+MCVD/wiAlI8cC8Mjw4tvY/?=
 =?us-ascii?Q?cKFBGGvNdBKegxEsmb6q7No0HssxWHhwGItn8FK5GfeyX1/Pn/9DvZNKY4U9?=
 =?us-ascii?Q?M8pczOJphL/TrQcVfy2PJCSG5sMWpQ1ikij6OnrUmBsWOr81L4XlmUGg+WWE?=
 =?us-ascii?Q?75uyuihTtyZQN9RAxCDPxerftzNFJlzSMrq/BmH/CmsrnHsxGLnKU+NHKj2F?=
 =?us-ascii?Q?T3oNDHe3O5gbG2z9AtN1CGN9oh4PKeDfyd53ICQdVjvXAtDNaQMdg/dHDce7?=
 =?us-ascii?Q?TeiKX1K7w9cFOzOJD8Adfeak9uKrtas0RW21K1wFDvgZJ8g3olIxdUbuLn+g?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1daf10-1f23-46fd-1120-08db1af8cac1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:33:26.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KqhmAkVn7zoCjm+crkK0fZchxMAFP6uAl7NlPjXA2AkCbOYo8X5kz7A1d4idcWDLM0vvV7llcV+/w2pBoKnVIuIAS2zWCuI+nVezeScCjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 1 Mar 2023 19:21:53 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Mar 01, 2023 at 06:02:13PM +0100, Henning Schild wrote:
> > There are two special pins needed to init the LEDs. We used to have
> > them at the end of the gpiod_lookup table to give to "leds-gpio". A
> > cleaner way is to have a dedicated table for the special pins.  
> 
> ...
> 
> > +	.dev_id = NULL,  
> 
> Technically speaking this is redundant. Maybe you wanted to be more
> explicit with a comment like
> 
> 	.dev_id = NULL,		/* Filled during
> initialization */
> 
> ...
> 
> > +	.dev_id = NULL,  
> 
> Ditto.

Sorry you already pointed that out earlier, it slipped back in with
the rewrite.

Henning

