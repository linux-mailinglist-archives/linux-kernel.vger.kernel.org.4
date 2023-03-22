Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E36C4FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCVPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCVPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:45:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2104.outbound.protection.outlook.com [40.107.94.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969B6485D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFbQWNijAEfUWBz6wXhHCTQ/FRl+ZsbxJFZxbhGIZv/r6O4peC8sNDt4/DRMqPO4bbJcxwphgNT0tAyp8eK8hsSF3Z45E6iOICmEtBOiceGS3wVux4lZ3EuH8Pu0+15wkC+WqDsf19iV0xXqTirafVtlUM0SO+MrMt1JJrOjORJl0ZmsWPyf9LguM68IHuWejt+h4i/31M4pEP4fPC7LYPWCWhlm9VELs4b3pSVFtrXkP/lZlWoj2lmVjERa4bboP/Z67+7ijJXeXP+UGi0qqUn2DMt+iLwt4x89NEYgGm6dMwBSRFNI7CWOwjefnHZL79U5/ybmGFe1zYbvaq5LKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufGILRfVpavblQzqVV9Lk/6gzITVwlJfktyG22KPQFo=;
 b=D4AK2eEBC8Pkp/UdZscTShgLYLQHd0vqQZVgYPBGqWj69keuShD0gbCRhf/6UZZYlH+t0NhERPIVtuW4jfEEic49FN0OvRYcbCdjszm3LEB88mvybQdrlNgjZEeKP5dtF+1G+0Dv7erPgLhBXy8XG0K6oUMsrUVzinIXwyocHhfMmrmkELIllYy7pD1WR5JuvJ9bCbqp4DhVz+FoSm/yqr9hEmgEcUCu/4gnlUg4N7/BfwdyYJzDlrlBxQnKSZC7deQgk5cv5T7D19qTLF/vk8c375LakikiTmLyn+9ql64QbKGIIiRs86fHZh7y2qz/JGhEbMm9SrsKKNXEBYk0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufGILRfVpavblQzqVV9Lk/6gzITVwlJfktyG22KPQFo=;
 b=Lsd8iRhfGk1gPz3Vp+LCgyk1TAOqPfCpQsRVM/PHOYsIvgdR+ogghoTPKGtQZmNMcl1k3aXxsSgEL9aV9+AMFz8i1lCCej7vppjwulhOvCnvYDgwGe4nIkHEdrvXUaC2IKfZxZYLocoEfy+cLqAMmOKyIvKSpCGqARLhWnCdI1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH8PR10MB6621.namprd10.prod.outlook.com
 (2603:10b6:510:223::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:45:36 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:45:36 +0000
Date:   Wed, 22 Mar 2023 08:45:32 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 mfd] mfd: ocelot-spi: fix bulk read
Message-ID: <ZBsinMmfbglf2w8W@colin-ia-desktop>
References: <20230322141130.2531256-1-colin.foster@in-advantage.com>
 <20230322141130.2531256-1-colin.foster@in-advantage.com>
 <20230322152551.q5sjc62yu3ijp4wj@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322152551.q5sjc62yu3ijp4wj@skbuf>
X-ClientProxiedBy: MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38)
 To MWHPR1001MB2351.namprd10.prod.outlook.com (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH8PR10MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 400a9113-249d-4426-bb89-08db2aec7aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AwRfO2uqiEJVd7kvPS7biMnP0V8bCmVr3gzdWkvHCcN3nbydjyDjVDMjFmhvUioxovh+RNAupkZGebGCqcWQbnYfMq3lD+6d7Rh4ppJyh4JyrR8tl9CHCYvAVAJdIwnQyFQ7V/GH63Yg7nTI/MK/UuPmmQoneWxyV+3YxtwY80yKMCaJ8RsVlqD4ZmCiFoX7cI9anuOjwicDWQgYlh2VTTowkHJ6ethJkhMJwjiFDThR1z1O7DibHHg63ci69kpWBUt0KZTRE71Iiplm3kTG+BBtVu7q4xik1+NN7112AbQxJgeLstAUHgVfGefMcVcMr1yWgAEyR6G5IR6APuh6WDXZgK38ea3t7T4oOLkBT1xmr45m0515P0Gw7d2WyjX3aUfU7gXijYmf19/OUkMKoEB2kltkAQookCEAwqwrjRZDCZuCBcP1VUjAIPB+53DkJ1ilvWXdZaFi9nEM+SNDy7sEWlWUrZA3V/Ej3NX46UNzhgP0K5/T+2DvpUaUPGhnJbeNWECrzuZqcb9vAll04tuHLDKc3z+JYPPAlYUkmzMPv268l5w2K/5hVqS0Q3a3Dd9RUQO2S9Y/X0UuGhWaMBFYPoFD7yAguCzHmjB9IpGwBK9LieyQbxnaZoIataP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(136003)(396003)(366004)(376002)(39840400004)(451199018)(6512007)(41300700001)(186003)(6486002)(966005)(4326008)(83380400001)(478600001)(6666004)(316002)(8676002)(66946007)(66556008)(66476007)(6916009)(9686003)(6506007)(26005)(44832011)(8936002)(5660300002)(38100700002)(2906002)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxtqfELaKBKfvjHFf87/ApHDjHDLWhxdHgx4sSyyzuQcJ2k2O4kQycuPnsAJ?=
 =?us-ascii?Q?3soLs9+x8j+oLsFEVKxrW/jMdww/Ufa3MjQ0dnzaF9tZoeanEsF2Aj00CMKv?=
 =?us-ascii?Q?UREI9fncBxbKzEdAmolA4T6t3kl4+pidjfMGQwoi2XCwbhVKEYrQ533r9GY0?=
 =?us-ascii?Q?2PDyPekduIq2gn5zKn2vhAcetqogL/y5HJfXeLhbRzeIGi1WxMPVW4VI0W5E?=
 =?us-ascii?Q?U0OuowjpRqzD1yMk1BfZeAJUBa8fOzEBQW5MbSFHCURNwuph/OyGZATRcnPL?=
 =?us-ascii?Q?7LKABD4cwi9UqwRcP7NiKw/tTL9dZ3674ytLt8ri4orXg1/9abNm+IYcov65?=
 =?us-ascii?Q?0UeRu96CqIp8kPQTblEP1khOnxgMeLr+YESN905pNJy9SZFXJ6jLJFyjRau4?=
 =?us-ascii?Q?EVpm7ZsSoVMsBOa/g8p5b6EvNt1BFw2SzpAvBvlXy8JRnn6dUGNodYrF8TE/?=
 =?us-ascii?Q?pPxzf4FWR8R7n2cuwTmSTCksSF2mgsCqde9/oUHAuGwigX66suHEM//f3wZP?=
 =?us-ascii?Q?P6FiWGcxPSJarqeSbztiyJTdPuyQEwESl6yYvGWI7mp1Y86xFqcz3Uvx5tje?=
 =?us-ascii?Q?B9JPiN9Q1G6uGUMJe05u60cXvzk2J/j/N8UiX5dGrF3SLZKYJoEn0skQSVQk?=
 =?us-ascii?Q?MbwEj0IxVY2kJPpQc3GAJ1enlEhSB+S+EDwGohZxRkud6ACBxBFnVrW0N0HS?=
 =?us-ascii?Q?Wfe3OhktT5eNfFHRkotFjkatUM4JCAtmpb+vIILW3wDh+/2PdYb9cKNNZ2vF?=
 =?us-ascii?Q?rq1L2VxmSCDhUeF2Kxd5jcEI7cJ6uLKgGeSg6vA7opfHnWfZdF0KkZzfHjnJ?=
 =?us-ascii?Q?bNz0yxfK5DScu7UQ02ICWPl8fCgXdJZ9/JRAAJ575MpcHvldJPngHQcytUdd?=
 =?us-ascii?Q?V8hac9kcLKPSIY7XVKErdjI/dWMaXRgP2evG2H4vqSkkdcRPGBJQdrxFdqXQ?=
 =?us-ascii?Q?Zu2gOJGWvJefFZK1l22Epu2HBB8eTB5O0SB3vAZAbrDFroYrUPqlsI2Jvtbc?=
 =?us-ascii?Q?do6v91OJ2DKw8jbxu7AJF3ezF1agWWCCMhUMyvcsUpo0BcaSCpVuRq1aieJx?=
 =?us-ascii?Q?oFafP5pWx/gTvQ7WxtqtVWESXVljtdt6Rm3tm0sDSiTakIfgnH/VrJDe06Un?=
 =?us-ascii?Q?+AaGHlRmPQEIyKyPxsnm+f63fcBkTtrnmp3u2YmBqXd/muFnkwkUFjRsPieM?=
 =?us-ascii?Q?qMOTthlvkEEvsNPMVaDPs+tVXJlMtIH19eQqfYgu4HcYGCXg12DVxTLgUbjd?=
 =?us-ascii?Q?iqQmZ6ObBg/Law/gmMSWWDRIbTKCiDqD9Lv9oIo0T69ICHhtuW+LlsYFBhRg?=
 =?us-ascii?Q?pK54U7ljo1gUgBiO0sBNnuEJBmdKvGryrCWVNAAoPTr7HGQPfbTsON94QZqL?=
 =?us-ascii?Q?mN64rr5MlaI4/qX5x9/8TSk+7DZn/LRB7tBelGnV1X+MTohLxvdJpFJ1e8vA?=
 =?us-ascii?Q?/Kln/M09uD7HE5FKuTEzP7SHglKv1o/OA/vTr1Fr7U7q+uj2gadki9q13VVv?=
 =?us-ascii?Q?7vE/l/W8etTPQ4OHUd1lkiXC7xyfbKLlC4JNCyViXsSTj7DGAJL5zR978uyi?=
 =?us-ascii?Q?BRm9SF88vQZp5kqqydEe5OLeWX0TzxzbGLPP/luEu8X2azwF2nrJwLqqYEvA?=
 =?us-ascii?Q?0PJDtNnSKUly5Z2hRBjxBV0=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400a9113-249d-4426-bb89-08db2aec7aec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:45:36.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE/mxzhiGzKD9xCwDjHWOfuS1BlvRFrzv7XH6KCPWt42duyrjFBJ27lCF2yEuQ1c0ukEuKylSbdmPaMaNRqVl5dMWd3p7GOAwD39jcJ4ztY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6621
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:25:51PM +0200, Vladimir Oltean wrote:
> On Wed, Mar 22, 2023 at 07:11:30AM -0700, Colin Foster wrote:
> > Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) don't support bulk read
> > operations over SPI.
> > 
> > Many SPI buses have hardware that can optimize consecutive reads.
> > Essentially an address is written to the chip, and if the SPI controller
> > continues to toggle the clock, subsequent register values are reported.
> > This can lead to significant optimizations, because the time between
> > "address is written to the chip" and "chip starts to report data" can often
> > take a fixed amount of time.
> > 
> > When support for Ocelot chips were added in commit f3e893626abe ("mfd:
> > ocelot: Add support for the vsc7512 chip via spi") it was believed that
> > this optimization was supported. However it is not.
> 
> Details? What about bulk reads is "not supported", and not supported by whom?

The chip itself doesn't support bulk reads. Every register read must be
"Chip Select \" > "Read+Address Command" > "Padding" > "One Register Value" >
"Chip Select /"

Figure 74 of [1] shows "SI Read Timing in Fast Mode", but that is when
the VSC751X is the SPI controller, not a SPI endpoint. i.e. when the
VSC751X is reading _from_ an external flash chip. It also has a blurb
about "After reading address n, the SI boot controller automatically
continues reading address n+1".

Figure 63 shows "Read Sequence for One-Byte Padding" which is actually
done when an external CPU is reading _from_ the VSC751X devices. There
is no suggestion that address n+1 will be returned in this scenario.

[1] https://ww1.microchip.com/downloads/en/DeviceDoc/VMDS-10489.pdf

I can update the commit message as needed.
