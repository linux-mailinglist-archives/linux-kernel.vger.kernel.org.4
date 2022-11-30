Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE663CDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiK3DY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiK3DYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:24:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95371F05
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:24:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxgwl88gbuDDLA73KdUYVPxPuwcPrLuYlQxSXfl8cSp4vVM5FY5+0IkzVksxAU9EhvNiXXG4ZFG1WUvqDjZdGvh9+rvCnWDcgmIU0S3IJWZksICOC4Zcfa6C4AtUA9ICCX6BNnSGDO0pixTbxk6r2hdDp3O4noof6RjyDQJzHIvs56m1tblfI/XGZdAvECFbvEVKektFXUizVeAcr43myezIng0OmiZrWKLER8JeJJJfdjoySBjpzz7xay2avDNgo5qnW+uat7yUyzSR5/KgK4v/5ehS1Bk9vqahk9YQkOEQbOP59Zq/eps+Ym8dKnvWSPtX/DByxInWfn9MdXuUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+Kb6AVSSeOXrMO2JmrC05GzN9GQ0F9gucSEQqt2NnA=;
 b=hrymfhzKYAJJj0akSrb6q0/LKrDn+8wZNpwPVi9Mah1nzy67lrJTzB530APZdaLUsfkpSTkanNDoVb+NS+XYWPl1IfADhTxfhdFDcJwjLSZElxBDNlYOX3YZz8DFQuWv5Y1FC9cMNVCXI1XNrRPm31UqEgNlwYJoHF+xRWw/02v8lpsP71LaoBaaCQMdtduSH2lnrCrQ29i9M0XHKvRV8qklHLr9RXiD0FRsAanNZCwjeMYBmRmDjZfysF62vw/ZNnwaYfGdUHScdRvXEf1CacvqKBo5K90QQkAdenrffl9FSP56L61TiHNXochrMcdYnAQT+lSNCqq80QS7R/4Zvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+Kb6AVSSeOXrMO2JmrC05GzN9GQ0F9gucSEQqt2NnA=;
 b=EqoHlItRSW952G/IYS6gEDWAsO+9w9uh4T0reu03xy3IHueJAO+NYVfIhL9wSxJhHPwRR4DkDT5ve5gUwjyDAKcI4JdS+e2otoc14aB3PGg8Yb9HrZLcu2rppiQ5zFsWHOMj/YouzCknzHMvaIhgjlKBYG9iXObUnIzKbQ4SF3FXdqpr68IV8tVgL/7pC66RfogFJ9qVFMNa+mQmxQpd3GwEwwyBndPX4gHtPUkulw6zGUkTKKxZXQcJP/tUJs7lVn+K5vSJd7cDmx5WsKLZfaogeuSj9QUES3G+0h9uefMQDpGxRgA45/sLpguEccZACfvcgQmTj/cy7GLFTrVvcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Wed, 30 Nov
 2022 03:24:18 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 03:24:18 +0000
Message-ID: <34baa0b1-72c3-e4b3-3eaf-9b07fe86c3df@nvidia.com>
Date:   Tue, 29 Nov 2022 19:24:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: Intel timed i/o driver in HTE
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        "N, Pandith" <pandith.n@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
 <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdd3e9b-245e-4dbe-91e4-08dad2825da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xxuBIZ+bUuscCYYOh0mDzsAMV8F6XOcwpqMaxq5MMbaFwYTG0gyYNIpQQKUI4Rh7RE/wXLtia+aEbn2Y+fHprHKuA1QfbNBG4/AgNdw/+HUMYAoXxvlaxwTA2N/dHM3lrbvVPs4xqSegfpTlc2CGOe/0Jmb7jgv9IDokIU81daSPeJOUE+6xqlRinSJndGPPNZxmACUcMfCdy4Ub22+YDi7UsGcBdP3SL5s0/wbzEUsTnViFyoQ9o68/1MUXcjqw/vMxqJU9izvODJJEwysBeEkyh2edHBxo6c+jKXnyIwTMtkx0dSPAqdz3pnM1tjFDjUGvv1g4hpxO6Hp3IFDo0Z1mkhV9CGHzc0uzvxCB+vEtflVunCcVK2No6cA9OCngN+/BwpneQNkxrldsZq/RAIiC5AQ59HHoq0hQFcSjjm/ooaLIHrZUTWU6LiU3qLYGaO+HxN7bUZNXDdtAjxcLFTeFlbMUEvCvDe+JjetQM9KbZgdKS6lm/azuVhXv621fXyL4poFonzYx1DRxgHLzN+HZhIw22spBTZGoRd4/LzUdJPFNgFAcm5D0sh75wOBXqZy41OQs9l2CDE8NernwRE3JmfMxuUjuQgeqrZu4lvuTeYCvhq7sDoezVopEw+/5VMTTBEacQTCdVRlFJHQa6hc3QqppLNE6557jEeZm2e9MQ+F8gJlkZPZN67pTxAEviE/Wk/pDESoyvSg/xlMCJoY/2wlpp+QfdkmDnarqJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(66476007)(36756003)(31686004)(2906002)(41300700001)(7416002)(38100700002)(86362001)(31696002)(83380400001)(6486002)(54906003)(66556008)(110136005)(316002)(66946007)(8676002)(2616005)(478600001)(4326008)(8936002)(5660300002)(6506007)(53546011)(26005)(186003)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRyMU5UUHJXSldDdXpNUEo4L2haNmlKeE9YbVJLeEdBRDQ2Zy91TDB6WndT?=
 =?utf-8?B?Q0JGLzR6REZtdUlSbHpLbm5WTk1Ga2tNY1BicGtTbzhRSk96bHFwVjNPNVVo?=
 =?utf-8?B?V3Z4YWpweVVNVERaZEJMSjBXWWtwZXI0ZnBlQmp4OTBwWG1uck93WitqT1N6?=
 =?utf-8?B?T1FOQm41dTFHeDJLOVVIci9qV05LeUxvMGF6dVRGeGhMSGRqcllBa2ZSZTlw?=
 =?utf-8?B?UUoyYk9RYUlLbHExWmQ4NFRmdUg0MTdxSTVGeHNkZGtTQmhOQ2kzUzRNaVdB?=
 =?utf-8?B?MDF3MFJqT1VrUy81SWlXK1pGVlVidlBGL21Zb2VuYmp0WVZIS2txbFBBK29q?=
 =?utf-8?B?RHRNOStUUmJ0RDVDYU5oeXdINkZvU2RqYTg0RFFkSTBhMVNPQTdnL0l0WkNW?=
 =?utf-8?B?VzM4NCtBN2U0UFlvQkNzR2ZHR3Nscm1lbGtVQVI4clBqQlkzT1g2Z3VIcXJ3?=
 =?utf-8?B?c1NoMUcyYzlNTnZsR3J1VCs1UGNwNkxWY2pERmlFSGVNVjVSaFpueFFCd3pY?=
 =?utf-8?B?VWVGL3dRUm1KY24rN1EwaC9xcnhTZ0kwRFpkbEhZaEZJdDNvSEdHMytoVDcy?=
 =?utf-8?B?cWtsTjlCVkhnTE9yOTBjcHdYdTJ5ZWdkMm1xTHc4cHhGcHFTMVZvVEJER25r?=
 =?utf-8?B?OGtvRHp4VXczbTBEMnRQYmVReDZpSTlzcFc5RFVkbEdtRjRFa2l1M0R5UWFy?=
 =?utf-8?B?UmF3RVhyVW12aHhoWCtNMkZTNUgrcUZmZ1AxNmpiV1czNUlrN2xMMU02TTVL?=
 =?utf-8?B?TGVWZkxoUGVscnl6NS9EZ1RuUmh6ME1nSCt2QXJkUXNURmtYaHRwVzlZZkhr?=
 =?utf-8?B?T1V6aFo3dDFteURJaWQwMUFtZ1V4K2owblhMejFwRUJGNEx6RGJFcVFFcXFl?=
 =?utf-8?B?KzcyM3lPRkNmWDFLYVA1b3RnWEF2enk0djc1UUhPNVZ2NW4va2F3cjZNTVdo?=
 =?utf-8?B?bnJseVM3bmdGTklOSUg0TGJXcEFSMXFlODVHNnZBYkVBWlJiTXppMVo5ZkFS?=
 =?utf-8?B?a1QvbzdGL1pzZDExdmU2ZkZrUzEvRFZzUDdKbytOeGRCYVBkbnUvZUVNelVU?=
 =?utf-8?B?cUpySjJEUmw1RldQMmlBUDBDTGFQYm5sbHlJK0dEYUNjcmJXZEZOU0E2MUVG?=
 =?utf-8?B?dUNMMWpMRFZEUUVTMFR6cXpNTXc2ZU9LR2R5R0lOSzZWNnhuQzAzMkNkOWx0?=
 =?utf-8?B?MUFQdTcyQ0pyZC94cGxrWnRLMzFIeHIraXZzN1BUQldhSUZDaXhTSlhQQUF4?=
 =?utf-8?B?UWUwbVE0dUlhdmNGdzRiQWdqLy9TUXlhKzBjRWtGNzEvV1d5a0hJNnpPbHJD?=
 =?utf-8?B?NjVOVS9pelJLcWt2RURJTEQybFFEd0NHNXBGbFp0UzBtUHkvUjNBbkRDMGxa?=
 =?utf-8?B?c0h3Q2lONWpWZFFiNlpjbFVhNlZycDJ4aG1OVUwvejJVcXhBRm5IOFdYRGhh?=
 =?utf-8?B?OCtuK3JGejBPUkdUS2Z1NkxwbXVuSVZIYTVaNWtFajFUZ2NIRFhOZ0ZEVS9K?=
 =?utf-8?B?MEpJU1VSZWF2RU9BUTRFVWhCbkJOY00xS1o2dGZLVGd6N21MV1lNRHR2bmdk?=
 =?utf-8?B?NFZ5UjRoR20wT3FJSEx0bzc5MW1iVFplNVQxejJCSVFoK3lNTlhqM0pVdzZC?=
 =?utf-8?B?WnRJSndkc0ZmZ0VUaVB0RHNaS0JBdDRBUndNUzk3UmNvRXdtb3kxb01wNU4r?=
 =?utf-8?B?a0Z0QjB3dkJxVHZKTW4yMmxXaE90Q1NiaHFCTWhsTUh3TUFmd0VWbVkxUVox?=
 =?utf-8?B?bXFXOVNoc1F5dFAvSWoxSXVPRDhyUUo5bmhjRnc0dDdiRVZ0TGJPcU13ODgv?=
 =?utf-8?B?emtscFV4c3FETUxSd0lhZXlpdjV6RjZsenhPemw4SHRQVXBuUTNTRDVVSGVQ?=
 =?utf-8?B?LzltNm1XaEZkcmMyUHFBZXpVb3JTNWF0Z0M1WEpsWFRwTHp4R1laVVdBYVdy?=
 =?utf-8?B?MW1tOFRWV0Irb2tUV2tNUDAvczdxQ1dQdENZU3hFandsckNmOGxIOEZ6K29E?=
 =?utf-8?B?TWw0NlNxUjA2UnZOQ3BxUTJrTVk0Q1YyVGFUNGwxTDFCeFFnaEN4SWJmVk9Q?=
 =?utf-8?B?UTJWaWh0M0FGTXBHQXlMMlNVVzh5OG5UdkZTSXBUY1RqMGY2aW9IZlpvS1k2?=
 =?utf-8?Q?l5wR0f6n13c1vLqau5XAKxQ2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdd3e9b-245e-4dbe-91e4-08dad2825da4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 03:24:18.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f65kM8WoZ+pwgZfMOBBgyS+A5LGUz7h+2xDbQkUxi4PG39D6/raIRE2vGXPOA9yGG21vSXCHOSmvrL084EN4Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 1:22 PM, Linus Walleij wrote:
> On Wed, Nov 23, 2022 at 3:38 PM N, Pandith <pandith.n@intel.com> wrote:
> 
>> Since the current gpio framework is inadequate to periodic output modes.
>> I thought to disentangle from gpio and develop a new hte consumer. Something like hte-libcdev.c
> 
> Maybe, if Dipen wants it.
> Or maybe it needs its own subsystem.
> Or maybe it should be with whatever is using these pulse trains.
> 
Few things I want to know from Pandith as below:
1. Does timed io only meant for GPIO or other signals? if other signals, what type
of signals?
2. In the output mode case where for example, timed io IP outputs 1ms GPIO pulse,
does it also timestamp it for consumers to retrieve later?
3. Can you share rough idea you have in mind for the hte-libcdev?

> Again: what is it used for? If we have no idea what it is supposed to
> be used for, we cannot place it right, even less test it.
I think it can possibly act as time sync server as one of the use case. 
> 
> Yours,
> Linus Walleij

