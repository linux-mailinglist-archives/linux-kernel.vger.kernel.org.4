Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5072DDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjFMJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbjFMJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:27:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2618E;
        Tue, 13 Jun 2023 02:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOZuDBSIE6q4A65r134QWYEHv699s2CeRDieIv80pLO7fEp46IRG3nZlUcWjeibOEsWZOlMRIRPPFB24LCayyu9jQSALZkEDwOBaupBazjBQ4j/3FMj8+4C0GYkxD7SHqwzX5cjYtHstzQrmsSILNsFneIRasBFQiX61IR8ecLMMSuB6yQ70FjekZ6sN9t1bx/GmmR7bIN7ZOY67iE2XB4JGlua/hEdRgxEam3n6HVMYywMbzb41v5bYj2MINYHVQYKQfe+y/7rx6If8Rhef6yTFmEGt9/wulfXRPrUXtAmeQDJ19bTNf8pr4HtJUwMO/yhCvZUryozqy3OUY8nUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Drhumk5NG0tHEkQj/BK9TJ5wxaeKWnHGmtUFArwvzE=;
 b=Y9wVekjg9/XxRgxa3bHNxsh8msbRPpwKVkqGCkSOBHw3ZoeJHIey4HkkB0oDfxv/Azfxt63N3/sec9G5t7nOZGVf/aqv60TqGsL954A/74Vtj2d9Hn+7ADEE8za76HuHaTpe/4xhWpYhPLkcnAkrV5+gK/SLEWS4rf9s9rWiMO4xn5zy/Gb1nck9iomnX5gAPnVmR6XdrebY9NJIfPX4pTVZCIOWNS07KgqoTgAgeGMRQZFZvXvWaj0LHKRgxjrP4BvKTTiHVwN6f6l5P/z/5h1gw1wFze4aVRbjm+r8bSdmAOW1Vzezt4IsEvlSwtGhnlMW1mjeCwAeQQA1ADhcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Drhumk5NG0tHEkQj/BK9TJ5wxaeKWnHGmtUFArwvzE=;
 b=XXreqbllldyKXRGb2kgIegEsQZzQdVZJNdfJ1TO7um5W1RWsPz5VTGVrJqy2Ca5N0Z/PqA4HZH+BgW+/FOVxm5S5Em1IMZGnROi6MrEjaoOEMx6v+TDE+f38bZDaw2Xv+d0X/vrOwqXHPrbg6R0GSmF4r6QvCB38JJ/DQUPR3oKNBSyf8UWkK5C4agOROAFToBAo85TAfK7G5I6zyo5xiXLR3BtEZ+LAOkXxtnQCTmgmj24hlKjbxpKN539Vhh9EvlNcTi2LWKLZXU4cdhK1eGLuGeCx7w/Io0OX84uHLclHZhv1l4BfRey0r9CZhWadQnZ7x8pa7Ud1N57b0dIx5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 09:27:50 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::7840:68b7:3d49:6bf7]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::7840:68b7:3d49:6bf7%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 09:27:50 +0000
Date:   Tue, 13 Jun 2023 17:27:43 +0800
From:   Chester Lin <clin@suse.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, s32@nxp.com,
        linux-gpio@vger.kernel.org, opensource.kernel@vivo.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Lu Hongfei <luhongfei@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] pinctrl: nxp: Adjust error predicates for improved
 exception handling in s32_dt_node_to_map()?
Message-ID: <ZIg2j025xV7E6yI8@linux-8mug>
References: <20230606070201.14249-1-luhongfei@vivo.com>
 <fca44dcf-e632-fed6-aee9-03a5b0c6b1d9@web.de>
 <ZIgPl0UShltd0VEe@linux-8mug>
 <b6c1500b-c901-00c7-e1be-1fa0088972a3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6c1500b-c901-00c7-e1be-1fa0088972a3@web.de>
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 63184f15-e080-4cb5-9c78-08db6bf074d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkwmEIwAI76f5r6dsbUluuZQeG1JLtqe+FDwEgO+AqOOoj0e8zUvgzfXsOGJHiy0g8W2JQMR2G+pb6tUvP79NR0RJUojIKHE8uApy27jB7Qwvmhb48qwrgVw4JK6WLomugb6d2OSc7aI7Rc2tS7/Nw3C4osYnKabOVFla1/u014zyvIvhnvEr5qbLCdbaQEk7CppYo25WM4T5XFRSvX79FDfzQsm5pNP/OE17EAZDxXYnevRkzBn6Sy86taJvfIMFUb1E2nQhoRS0i9GXCXpN+/1jQqVzdn4xvY/CWd7xmT6C41gC3wd38JORWzfWgCOE3zll7gv8dOSEU0CMyrDKpZ2DyXdupBHUGSvdBjzdD2X3rVrZaHm9L2S+J+QxuZuNgUkdSgE8TlT2oO5xsiirnubj9vYWTdQfzCZn3e/ZaBiZHNdpqSsC/MUy6JVu+mrkc/le6K0ao/JxhhwOeVhRHczLUpJVv4XSbvKrS9Kw4fWFgI92UOqQpfL3Y8rpt5BIzu8kvmciSFogQsCs4wr/q/HKKJKzyy8la2PVr9+Cetyek4PUtNnEug8rIfUiNi3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(86362001)(66556008)(4326008)(6916009)(478600001)(54906003)(6666004)(66476007)(66946007)(316002)(6486002)(8936002)(41300700001)(5660300002)(2906002)(4744005)(33716001)(8676002)(38100700002)(9686003)(6512007)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNGeTh2RDRWY1phRm5BaVc3UHV4bTh6RC9Cc0Y2M29RaDVRelBJUlFxZnQz?=
 =?utf-8?B?NXFYWXFGanE1VmJkYzRudVpWM0JxVE1WRXBLRmxhWWZlVUc4TnlDWU5FVmEy?=
 =?utf-8?B?UlhjTFBHU3RTQnNSVXZqYTVxRVVUZGV4U1k3TU1HZE11d0lpSTU4TGFnckhD?=
 =?utf-8?B?V3MwZmREVjkwUHBqbytJSWtWUUtOcW5lR1ZFdVZxS1lKUk9jaERnUGpoQlFN?=
 =?utf-8?B?NGZxMnN3YUoyTklCYXR0TUFCT0ZPandNSXdzSkVQeldaeTYwUU9FcVc1VFVL?=
 =?utf-8?B?bm1ETTV4MlpLYTlESm1xMVlXQXljSW8zekNmNnZMbnIzK0EzeVpVOEFLc2pk?=
 =?utf-8?B?Y1FiblFIM2s3YUcyK1NHZFJyY2RWK3BselJNTEV2K3lGdWozQzlMRzJlYkJL?=
 =?utf-8?B?YWZ1RUhzNzRaQWVzU2ExU3J1WmlpZ3VIREhuczhCdWJJUk1TVXk4RThBcy9o?=
 =?utf-8?B?YzZrem03S1FTZHVlTkpSZHNxOXEwWHU1YVg1cFFXTEZlTUtWaUd2YVpzUW9s?=
 =?utf-8?B?MXduZUtnRVNkZHpvWENNWFFFOENLckZsWkdsNVVjejNsRFhneTdDSlJzOTZs?=
 =?utf-8?B?VmJQb0tOM1NRUWZZaDhaYjR4T0IyTWpaWkFib3pRT3BXMlVvOXpMOVl3R2JJ?=
 =?utf-8?B?dSs5R0xIR25BSCtOVHlSM3VkYlErNnZBUVhxMVZmekZXN0dqK2V2ZnZ4NUU4?=
 =?utf-8?B?TStCNm9Qd3Riang5b0xkcEhDL1VTUDRXVDR2VjNWSmZ6Y3V1Qm9UVEhyR2xh?=
 =?utf-8?B?eDhHN1FaQzlWWU1zRjFpZ0ttSXBwcnJiRENFVmw3WCtPUVlGNTJQYzV3WWpO?=
 =?utf-8?B?Ymg5eElVM3Y5UW8rSW1rZ2xlTzZMcGE5OGJQY0wwa0RQQzMzV0tBNEdoeHh4?=
 =?utf-8?B?U3dNSmJDOWxvK3RPbWEyaktsK1JqTWNaWGFmSVFaRUUyMlphbnlFQkJBeWhW?=
 =?utf-8?B?VlY3ME9uendIcWFkaTUzWUhPeTlMTWpNSTNlZFZPaUFRSU8zZXI4TDdLTTg0?=
 =?utf-8?B?aXpyakdpSGY4dTRhREl0WW41VlBuYnRJTzFkUUxZVElTbHVhak1rRm0zN0dY?=
 =?utf-8?B?UWVPQWRheEFvUnh3M2d1ZzEzQU1Va2FnWGlXcjJwcW9ISWRaak5DTjZ6dHpp?=
 =?utf-8?B?b2lvZ3UycFUxb0FzV3FLd1hCd3NYL1h1VE5oUm5obzlrc3VNcnZHdFpXNkNw?=
 =?utf-8?B?UTk0dm5ab0FMSzlscmhsR04zRnAwN2drNXU2YjVZbEJZK3J4SUxNWGpLV2hT?=
 =?utf-8?B?aWsvQ21rN3YwQnhKOGxad0M1bFhOeWxjMlVvUk1PcVJPSStReGxrenBFcnpM?=
 =?utf-8?B?L0VOcXZpQVVwNmo0b0RUY1hVZDZ2cnB6RHRoWDJycGFDb0xjbEdqNzUzTU9m?=
 =?utf-8?B?UlZad1J3NmVsemlCSXRVYnMvZ3VaRk9PajNUcmNaVGZMSk1iL0VMNGtaaFJR?=
 =?utf-8?B?RjMyZ0xnNFc5Z2VCYUdHVXJQVFo0eW8yMXJFY2hqd29XVjROakFYckdLeGdW?=
 =?utf-8?B?VFNOUUVlT2pwc2xpV1R6ejZDMjVLb3hwSnVTMFVKSDdxaXpaT0VVQy9aaGNB?=
 =?utf-8?B?WjQ0N0MzVWxScUd4SW9KSXB4VU5GblIxZmtqRzVIQnRaWXl0bUlyWHdLaTRG?=
 =?utf-8?B?K1NxTVU3VmE2YWNqQ0Jlei8ySUlPbDNic3NuaWE1aktNSlVWcVY5SmpNU0hD?=
 =?utf-8?B?SXkzcU91aHoxc0s2T3gzcDlzZTJGS2k0a1hubUtuOVgraW50Nk15NjBqZGJX?=
 =?utf-8?B?enZzblg1QmlOTHlFc3I0aUEzcCs5QkRSZVZUcHlOYUlaVHNBOStkMnVkTXV1?=
 =?utf-8?B?TU92dXFkL2tMV01jeFR1d1FwQ1F4VDlsaFliRlAvVVByRU1hT01lOVJBK015?=
 =?utf-8?B?ckJUcVdVdEI2RVE3em1OdFFjOXhJSFFMeVN1by9BOXh2Z3dSaHVDYTFEeU5x?=
 =?utf-8?B?bk9McVlrMDh2Mlo3SVpuVHdhQ1piOXdWOEtwdklhRzQ0dmtpOWs5MnRTcTRy?=
 =?utf-8?B?NDFQU0N6dlEzbWlvUzRIbVdCcVRVejVmZDd6eFB3OHVJRHlvOW5ZcGlzenBN?=
 =?utf-8?B?RE1hcUU5K3c1SE5HRGJjblRrSS9IN0RTbFZNZ3Y3Y2g3V3l5QWNKMHhGWXM2?=
 =?utf-8?Q?6NBs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63184f15-e080-4cb5-9c78-08db6bf074d5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:27:50.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2xrPE277iKMAq+Ts+S86BJn/+xy3mZHGjeeIU1icgAbM0MdBkT20PTrRm11CePd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:15:22AM +0200, Markus Elfring wrote:
> >>> Ensure child node references are decremented properly in the error path.
> >> …
> >>> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> >>> @@ -279,8 +279,10 @@ static int s32_dt_node_to_map(struct pinctrl_dev *pctldev,
> >>>  		ret = s32_dt_group_node_to_map(pctldev, np, map,
> >>>  					       &reserved_maps, num_maps,
> >>>  					       np_config->name);
> >>> -		if (ret < 0)
> >>> +		if (ret < 0) {
> >>> +			of_node_put(np);
> >>>  			break;
> >>> +		}
> >>>  	}
> >>>
> >>>  	if (ret)
> >>
> >> May the same error predicate be applied at two places here?
> >>
> >
> > I think these two error predicates can be combined together in another patch.
> 
> Are you going to reduce such error predicates so that exception handling
> can be improved another bit?
> 
Yes, I am. There will be a patch to improve these error predicates. Thanks for
your suggestion.

Regards,
Chester

> Regards,
> Markus
