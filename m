Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B273ECC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFZVRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFZVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:17:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7CA0;
        Mon, 26 Jun 2023 14:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWCmEqkLySVp6OgYEQwpepbd1ah/jQZttrTDoCMlDEW+KBPmXYQ4n1K/HH4yWfHistup1yivGUOGMHQbJDFI30rYaQs6PurBY9wUZwNKA0/AbGKRWAEDuBuUrC1PHriwe73PixYcrUCjLG4jopFVfFVMrcLCslx5DfsSFMP3N31aUQZsJZqFPjgGXOQqrhyCOlduU32w9QNiRiGAfEdkL97Z7OnnTrU5bDnYASfkuuXRidqp9r5f389PopqOUB36y1pWnuEU1F0m7oNcgTJjJEZH1D3B2kuXIhgxI7kt4CfPh8obBsob9Ic8Jzz9QF84wWOwMv4iROQ/tPwNJVOlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0JZCt41Q31bNOEwMoxjG3zo6wpEHess263s+hM3YAE=;
 b=YQMtTaM++n7nfu4EtHy4LS0Bvn0MOpSvCMQ3pZicmfRe5d1P+3EoADRLNVGNuPCbLAwepbkzjB4ugg0bW3IxnnP0rkPp760a6MP3Cp3//fiZEZhNXLVOeO4CjxR5Tp0vGlavVBf0mwSnw2aRUgqKxHNjpOeecCjIg7j3IATJSgXtlYodHyoSmXC8Me4Rd9k2CCEHfIgyo/g3fsU5nmRN+bFTVPaEjNn4uceIVpJvzJXBE14GSJ2qAijo40C/hE+zok+OB2YkYlL//Mc5ReSl7CKqJ5myvur8bMnXue7lQJUy6kpIcCJcF7tlMg0TrZeYkOulv9D39pFcTf/YTmXM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0JZCt41Q31bNOEwMoxjG3zo6wpEHess263s+hM3YAE=;
 b=bL1hX7Jzr0Kj4saP+bHTipIcG75N+BekzDgS6JmXwoPORPKsXfRTq56m82iCXLU9h7d4tzx8bYpB2I1HvCvYD6PVqHYQaHATUR8jL7SWpRqMs7E8VpNw8IKcExnKLsDZ22SYHZdu5u/950j9S7ScHRNJJBod0MRNJyKlmpaM16g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB6546.namprd08.prod.outlook.com
 (2603:10b6:303:9f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 21:17:30 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 21:17:30 +0000
Date:   Mon, 26 Jun 2023 16:17:26 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZJoAZgn2b7RcofzY@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-4-f0577cead709@linaro.org>
 <ZJiXopmFr4dPbqll@nixie71>
 <e36a697f-a54d-7bdf-1e18-38f72ec2966c@linaro.org>
 <ZJmMJxXxLrC9Xevi@nixie71>
 <94e80a49-11ae-e5b0-7eea-6ed4ec6d2ac8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e80a49-11ae-e5b0-7eea-6ed4ec6d2ac8@linaro.org>
X-ClientProxiedBy: DM6PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:5:bc::16) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f6b462-3ca6-4342-0722-08db768abfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZTcPmGdx8uZib4aZ1Y6uHjDM/tY5Qnqn262KaBqh3p2jkVRYU34DJcUj1B0NtzSkKx78L8ymvoZGIsr6dG+g82aAoXFoyjqAt5o4GOCbi2HT8B6eEDnZZ0UyjKmmdQOK6PjfxRDOyff1ibGdiMitH0BM59WbrhPR27v8gV9dEIiggJDzzQO+C04AuD9qseTRsJzwGsUvwAClkh4D5++seEl2dpG718PFyOu3MmQDUqtzIVaoRoT6jG0aiemKPykRuW0EDFwZkiEXqn2xjRcaXegTLHP0a8Nmfby6azdpJL1ypzHmDUZsEoA92sxXSR9ktvORf+ty8CsYhRehYKLQODFCtjDmVWKVmR+GAY3iOsh1mi6o7y/aedr4kz8471d2OKfzKWa0tlKZ52Swe2pcwERbFT2alrfqu/UTlWG+AUCP2aZkSTWL0EEKik7fZJ63++/aUGaoDj9OpMDmpnUcg/dHjQ5++LuBFBC11jw2uXn+Y+ef78eIgUyyXzgNKnyc4SqJgcNOtQSy0DJ/Tkxon4nESr+5NkrJJYkH/77b1fq/DhISXM7yHgRgVVxHYUl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(396003)(346002)(136003)(366004)(376002)(451199021)(53546011)(6486002)(6666004)(54906003)(26005)(9686003)(6506007)(6512007)(478600001)(2906002)(186003)(5660300002)(33716001)(7416002)(6916009)(4326008)(316002)(38100700002)(66946007)(8676002)(41300700001)(66556008)(86362001)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMKPqyr5t4JRuCfJctqsrwELDJ5TO5yd7j/UtSZ6APfdkGJctTHjhzFECPgC?=
 =?us-ascii?Q?5GKykYHy0T5aQzYgQsCpSo7iECGj5C5YrWQG4zNcWwtyJW7PyuzJrugBTspv?=
 =?us-ascii?Q?100PI5XQWl8rK0SurPQtvyRp1CQP+AciX8vigXmvwqga927ILk25rv49N+hj?=
 =?us-ascii?Q?/eOZuRHGorVt0X4MD6FTPtyuimxICuwsSHZDSMhOhMCamSxZ9RbHChCR81Lh?=
 =?us-ascii?Q?+8Epjf++Pz0QM4b3VJYfd2+qjilD/Ne4JUdagrJokoCHflSThjpoKsNNueto?=
 =?us-ascii?Q?u96mPkKmidnnBIexAYXFVjkAWL7f4AqOu7u4YgDXRiz9f2uGM7doW6cHO1kS?=
 =?us-ascii?Q?3ikDeLt0Te8DfFyxLXrdqovsLNpyn6vjXwUwkvyiUOa+L2+cw0YGIpkomlrP?=
 =?us-ascii?Q?oYUz379SVKFUtzJ6SKOaaDQrnLy/evoelGbgZCTdgyLhJea4hkt92SuRG/QX?=
 =?us-ascii?Q?m/ab+rNWwxj6EAihmw6lzdtAgSflWkuykPvTl2j+QnLSSCV54Vl7L86q6kGu?=
 =?us-ascii?Q?QcVEqsQkkdltvp7mzwCPBiKWJuLP59PT2fT7x37OxY16AqprAwaR9FgHkACU?=
 =?us-ascii?Q?KrJxyhKOssxiTFwI33QLFnzQbAD2YrG0qS5dSch/oWgETufUBfB2AMLfkdc0?=
 =?us-ascii?Q?I5SBneRHAkKz88I9kqgXDsoAkDgHQEZZfKs2ftEgdBDLuit8FYPmL6BvFvtR?=
 =?us-ascii?Q?O5JoWxCkLnsV677iBkVdvNpzI9XbOnnTW/TJowy3qb1nDrMXPEIjPKYsPeWV?=
 =?us-ascii?Q?m10b0A2gsG3tCnGjvHxkTCqRzu7ZgaA7xZCqveI/SW/UPugNd9bjfTLZnmF6?=
 =?us-ascii?Q?/t3QccZXNzazOJ3YZur0WKMXa0YXo+5yy1P24CnMkpUonF4CIn/HuTE+K9Ce?=
 =?us-ascii?Q?ZZA4BOXJY9oyR98/WSyq2mPoVId57OP7MNvIvYLjo+ND6Xib+KWcHekSMYCA?=
 =?us-ascii?Q?6EipH+UEKzKzDruDT+f/gXvN6n0GfuW6TSwcEIuUl3W5w9iqXqZccwq2D9c8?=
 =?us-ascii?Q?oJhaJ0/b6fmjlJocbIddEGksyeFzRspbkssIaD8hOoWyXeNaAyANxd57RPXM?=
 =?us-ascii?Q?Qhs0OvMlvHiE+9JXWX94mqh9tD9r1GPsFcOkYjNiCvVJshT2ERlcl4TMAt1E?=
 =?us-ascii?Q?Wx4efZav0atz7y3JZtMGAtRQMdrafvTgb5rz1cR0Axfy5gK8ZJk+NXxlbint?=
 =?us-ascii?Q?bIPZBkzV2+M2i/dMNtc6mZP1l4/Vyy68QMV9qmAoDvuAGvpAmCNJqgM0f5MP?=
 =?us-ascii?Q?63YxQ7TuShsulK9izdIPT9tz4rkjJXVHz832mieKPr7zf9INk6+x91ziGqxk?=
 =?us-ascii?Q?ti81YesfJmYOkxINvUhSoVMrT6gwzgfaYeAqRes4+zwHNuNnKShWDOPRvk9Q?=
 =?us-ascii?Q?EnRPCUraTAP8hhOcd6mf3g6HmI4cuekdiYje2NVCEBmCuno0Hp2Jacx6Te/I?=
 =?us-ascii?Q?XQr13u5asZA84V8hkpEf/LaODv/AX2C+KpYt8fmwzoH9+hXoneYpH9dMFNaQ?=
 =?us-ascii?Q?ttPhzHjrFdvqdk769EHF+Z0YTX+9iHX88tcgRJYQhOW+FZvJLEgsaQqDWktt?=
 =?us-ascii?Q?VCeY5sGgl179yfy1h7acUtgmJmJ9AiJFoShfvMOi?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f6b462-3ca6-4342-0722-08db768abfc5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 21:17:30.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq6NLQJViiPL4Mo6y/qaEVjCRHLzJnnnCHHCXdueIlUAX3Y9urwlUDXlfBalScSsX6h9aGdocCZB98/Ko1XXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jun 26, 2023 at 03:20:35PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 26/06/2023 15:01, Jeff LaBundy wrote:
> > Hi Neil,
> > 
> > On Mon, Jun 26, 2023 at 09:02:16AM +0200, Neil Armstrong wrote:
> > 
> > [...]
> > 
> > > > > +static int goodix_berlin_spi_probe(struct spi_device *spi)
> > > > > +{
> > > > > +	struct regmap_config *regmap_config;
> > > > > +	struct regmap *regmap;
> > > > > +	size_t max_size;
> > > > > +	int error = 0;
> > > > > +
> > > > > +	regmap_config = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
> > > > > +				     sizeof(*regmap_config), GFP_KERNEL);
> > > > > +	if (!regmap_config)
> > > > > +		return -ENOMEM;
> > > > 
> > > > Is there any reason we cannot simply pass goodix_berlin_spi_regmap_conf to
> > > > devm_regmap_init() below? Why to duplicate and pass the copy?
> > > > 
> > > > For reference, BMP280 in IIO is a similar example of a device with regmap
> > > > sitting atop a bespoke SPI protocol; it does not seem to take this extra
> > > > step.
> > > 
> > > The goodix_berlin_spi_regmap_conf copy is modified after with the correct
> > > max raw read/write size, and I'm not a fan of modifying a global structure
> > > that could be use for multiple probes, I can make a copy in a stack variable
> > > if it feels simpler.
> > 
> > Ah, that makes sense; in that case, the existing implementation seems fine
> > to me. No changes necessary.
> > 
> > Correct me if I'm wrong, but the stack variable method wouldn't work since
> > that memory is gone after goodix_berlin_spi_probe() returns.
> 
> The config is only needed for the devm_regmap_init() duration, so keeping
> the memory allocated for the whole lifetime of the device seems useless.

I revisted the regmap code, and you are indeed correct. I agree with your
suggestion.

> 
> Neil
> 
> > 
> > Kind regards,
> > Jeff LaBundy
> 

Kind regards,
Jeff LaBundy
