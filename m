Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85137743B45
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3L5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjF3L45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:56:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2126.outbound.protection.outlook.com [40.107.92.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4DFE5C;
        Fri, 30 Jun 2023 04:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBxE9uayERZ9eGJemfaDOvM6m2SRiJZHzOUx12FP5FbUIYirwq2KhD/t761+a32DML+Kstosc7rQDzCy0gKGCwyYKbBbfgf4MLjhX5CRV4BGJvYtI4izLmMuBoR2Tbjv6iph1UsBrXZnQMjACpMg4w/W9z0N+qXPiKuzM2I5+bNhP0KcuTulqeYD1YA82WEpLgGzYnXa1Tcp9su33Elu7csldeGWD4038//yGzjZQV1RjO2WOTxtIufCA1DFOk4H2t4ZNof/ab32sF8EoZnWUTplLu8K9NFFXnyC7CMXyWVg4BNh0O67I24JBnbEXMox9aUR1w6sAEn6rm4CUVDs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTvqE/g/bWOqNtxsLZcDUCIGL2Z6ZgdEM3YAyUtp98w=;
 b=HpiTAPI+aTmhr86F+2k1g+Tpe4C/REA1Uzt48x7YyDkDveLXhAjhhCG/c3EV+nXEaMOax5T0qtQ0jPHYeu2rZhU40LUDh60g4NjUYc451JqnuLrRpjub1vvIE1IZuKeJ96x9kNVecvWDGX0hHCbpJxkf9JxAZ7OxdJ8YZFCROTZsO7i6d+Rqfn+gg0n+4l6NMdis+Bn1DDYIwoTodewp1BxCZoj5DDyiXShoBmaPpUaAVuKWIiOGzJfFISNBRCi5ZHb71Ux7FPUkWS55MoAXqHe4AJLDhDpECeRmoXlIgbaWgDgyy1jCRrlvp5s983uLu3LWmgE/t2r/Ba2kLxBezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTvqE/g/bWOqNtxsLZcDUCIGL2Z6ZgdEM3YAyUtp98w=;
 b=d6IMfBPlPw2m1vivlSeIC+SDMpDw56WjMHzYTyLWzir/XTR6iwycIThO7MGBOuYfd5k58JcnKbE26uvgaUGQ8jvWCx71ywavL/5kOp68aarhF0TDkN1AhCExsAy0wI9LxxQnkL/Plw6+yCGG1KvKtuuBGmAGOldYH0Xp4Tm6Tig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4474.namprd13.prod.outlook.com (2603:10b6:610:6d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 11:56:52 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 11:56:51 +0000
Date:   Fri, 30 Jun 2023 13:56:44 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sbhatta@marvell.com,
        linux@armlinux.org.uk, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anirudha.sarangi@amd.com,
        harini.katakam@amd.com, git@amd.com
Subject: Re: [PATCH net-next V4 0/3] net: axienet: Introduce dmaengine
Message-ID: <ZJ7C/Ck02QN7+X2/@corigine.com>
References: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630053844.1366171-1-sarath.babu.naidu.gaddam@amd.com>
X-ClientProxiedBy: AM0PR02CA0194.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::31) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: a1167666-6bb3-47e4-a52b-08db79611761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou48ZJmix47rzfZadQoFWAWQWZhZNCfn5e/xQpGv2kRK9ZunS4s93Iut1ILggM+de+d8kXCTcu0Bkxih965SuYHSaPrvfnmRX1mNNyO4jpY50ASZJ0IDC6PAkt1Kb5esrMza0Vem8qdkscknjuyVo1yAvmsnDEkMoZQ8NbzOJ7T6Jjy7u2F/6tOwbxzkgeyR31vSTOxmFyIkMUH+LA7Q/Z+FfWYpe+hyjnqLUUscnxhPoY2SYTwpcJ1uQZyiy7ddJ7AYTeYyPnD/vff5qL8qR8QNf2wZKHaZjWmXur8YVnyZ06qHRKSe6/bHMiCJwOLlZOgt/fRtJKrHK3tGn6Za/vP9eNkot/gAMkCEIRc4pZQ2ttIyb9vyAIsOEDcvEpEHW3Kn2e/3OcpzHloLkJy9PpJ0G3wjPQe1Vx6+FgMDNwXEyAqfqC8NwCEymgrWAk6F1RaqKawNCv7I7j6kvEjpBHEo8QYljQ5M4PaUSTIgfUNOFkXEu4XrcMxXOXNuWitrNcCKlE9D2q5yEkIK489QBCwQPSiT3ZHt6J35KS4L/V0dSilMw8/ck65I3tQfI5UMz8skljsW7/9AMYM8gPzPhzb53cvcztqnMPPaJsK7bMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(396003)(376002)(346002)(366004)(136003)(451199021)(86362001)(8936002)(8676002)(5660300002)(7416002)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(966005)(6512007)(41300700001)(316002)(6666004)(66899021)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FcHfUmVLqG4mUy9ylXMLX8/YVE/mk/Dh0s8ZS+8gRAuInuOu+eEgRjqNfJRG?=
 =?us-ascii?Q?1pBm4GyVgosr2eK1VCA98HTRJ9F20c9SnwE4XZa0CAlZaVBQmika59Du+Gb4?=
 =?us-ascii?Q?mnmmvl0Fl3/2ryJsIDutc6fBRYad85pAv/fhzbNwni7uF7HlMeVV853FjlNz?=
 =?us-ascii?Q?3B9vZTwX7REBdF3V4MJ7s0xZRXaCZ9UVGSGbCvRZYDTtL12R2LJP5pqXOK63?=
 =?us-ascii?Q?2sgyORNki33fsC0tfG9xnLEfD9QfsV4DXE5mJbglijrjBNLghW+f3GLcIgem?=
 =?us-ascii?Q?E7fUXPjVYb7F8UaGdQdt9qPbWQC5y7T4ML5VbPEtW0eSEoATJwlRLvLvYvxz?=
 =?us-ascii?Q?Vn3ECkLCLZwjSBGZqaVu94bXbXCiMj/GipR5NSp//tyHzDDBba/l7cGETCHT?=
 =?us-ascii?Q?KPP4fEMRvj6mWi27oibGAaREGXGvmJspfQQdZCXoKp/hRHspDaPxmmfohlRp?=
 =?us-ascii?Q?e+mO4eQpTZ9Xd/Jsjsao5pn7os/G8pdXT5JxIRr1llzWtGX+QKl+idJJWnrK?=
 =?us-ascii?Q?tDVj7edYamgo+AjHMNjWbNLba+mUM4Whpz0oapQ0UcVuj3ksYR5y67gJqDnK?=
 =?us-ascii?Q?pqTnKcYBdcS3eTBPB1E6cj6C1EEZnApZdeFQmbDIlBRZykF6Kv8wAJd3/l+/?=
 =?us-ascii?Q?uzRA4L/ox5xlP284el3/7fjnUIedgtISKnSqB2Eav+XgVoRuA330m+1MV6/C?=
 =?us-ascii?Q?mMvAQJVxpCeVP9bK3hgUWp5ykTnheuj9G3QwRFYnxtGTh5lPa1AYgiwF/FiR?=
 =?us-ascii?Q?1BzXiLTCxMqAw0VDBa5vPDAzHq+WOpPHfI4uKj3Y8V+OawmvyTETRl4sqEkG?=
 =?us-ascii?Q?1iNrsN5XeWW+EOjPm0QYJf3D0l0pLfiDFjHRwNyNVzCHgBhKfjAknO23jnet?=
 =?us-ascii?Q?fMEUcMHanulBBfCsGttyeCtfw3O1lXSlNHG6S6tOzn8+zf+mmX6u26+4T56G?=
 =?us-ascii?Q?RKwraEB5jR2Y3yiIyMyJRkCnMUr4mRxlhplYeoDFHUNWDGNDHpJV3Srox/nE?=
 =?us-ascii?Q?ZakAdxkEQ1obaI2Irf4xWTADtFRnpHZSqgP/CbZo2J9FAS4NnuVqY51rqbM8?=
 =?us-ascii?Q?BEqw21wn8nWW+JwcWzhkFzHqU3dn03etZ+tB/12VbEI13w2bNXB5HHbjmQfR?=
 =?us-ascii?Q?dEhQRFubmcDs+b3O2zE+LGhW0UKcL+QawLAIgQYGXKsH7x6HrED0VFGXS31J?=
 =?us-ascii?Q?2WdEDPR38hwjDX4qB754Of91/LR12zo4qV4xkSXK8hYkLEms1BuRfL+h+g/m?=
 =?us-ascii?Q?SuxIOHS2WQCS6qJ91ZfFTM2RIB90AOvGaAGXEYEKe0O92IoR79Mki0cUm1Kn?=
 =?us-ascii?Q?+g7xy+yJQ/xQ1GPJ2TcjTiD57EPMzuMbqLbKYnzTZ3ijc0OHeuHNkvHgxZWj?=
 =?us-ascii?Q?4/DPty2l3WXD1JtDQIV5Y2bPKXrEAdLl+ZCpSnoajWfhwR0dlIdbHzy/GGOM?=
 =?us-ascii?Q?wF72vPvgqRtIUqbg1OTt5MxlNOB/2A/SVTPuYCAUHYsHyypRNrLKGvbYG1Y1?=
 =?us-ascii?Q?0Ovi1toAhWUk9jk/oIQJcoDVAvNZHsK4GKF0cjDUY/Fe854snFo989Agtmqb?=
 =?us-ascii?Q?stRCeheYA9GQ+U5Dk4/qkhtixwDnceM1uZzMF5AHWvAcy0ZfXfaBDgvvA9ni?=
 =?us-ascii?Q?oWxbn7PMhoxWw3Q8btv8IZN/k7pNnTrzRzAORAKj6WnL7/ybyg9bIw519Uva?=
 =?us-ascii?Q?TCMhbQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1167666-6bb3-47e4-a52b-08db79611761
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:51.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKfYv6VOi3jdS7cAJjfccLuVq4LFv4d/YLs4i3emy52sAWAMax0N/BkNBTmgXb0ND8KaTA7Bv7LFUkteQoFfw67EBxIa7JOm4w3zcWwsj2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4474
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:08:41AM +0530, Sarath Babu Naidu Gaddam wrote:
> The axiethernet driver can use the dmaengine framework to communicate
> with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> driver[1] and remove redundant dma programming sequence[2] from the
> ethernet driver. This simplifies the ethernet driver and also makes
> it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> without any modification.
> 
> The dmaengine framework was extended for metadata API support during
> the axidma RFC[3] discussion. However, it still needs further
> enhancements to make it well suited for ethernet usecases.
> 
> Backward compatibility support:
> To support backward compatibility, we are planning to use below approach,
> 1) Use "dmas" property as an optional for now to differentiate
>    dmaengine based ethernet Driver or built-in dma ethernet driver.
>    Will move this property to required property some time later.
> 2) after some time, will introduce a new compatible string to support
>    the dmaengine method, This new compatible name will use different
>    APIs for init and data transfer.
> 
> Comments, suggestions, thoughts to implement remaining functional
> features are very welcome!

Hi Sarath,

unfortunately this series doesn't apply on net-next.

net-next is currently closed.
So please provide a v5 once it reposts, after 10th July.

On the other hand, RFCs are welcome any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development

--
pw-bot: changes-requested
