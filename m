Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3126731D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjFOQFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFOQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:05:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007FF2D40
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcY/ZBz20rdmdKqKURHtbgDhVxOBTzPy+Zjrwml5xZl29gX+B7sefdEMs8YAebLLoj018v6HYeddjPuEjVGw6bgLGtBoaKf/3OXXHHU/0IsjSEUmyyiReaEuOCkb+g9safrhSmunpZBSTXjfJ6JCyYTBiwfidj54fW+xCZCcOtyXbMOGOys5n7dw5aZ11BfXfRrRbi5zi41nUL2vZmy+DKCmg89T6pUFujdONFCzAOnVvISdPxVVkEBSVALUK5uarzg4mlJDI2PpwDbRFNlrGojPfAKwuhh0OaWTupru2SYiz6uxwYWkSLujYY/ekxLaeSotrqkglXjLgdW803N8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jujABUvwGy1I+/dcIYPq2VfhMnh1mDPNK3I1fj5GGxs=;
 b=SB9MjU4iejFIC4FVckhIycpNtUDjh+xg3Gk9rkxy3VpakqyDHloEwaqLBU3znu4elaWc/VhyJEIQanSBnxwx5fxcElcTasehWfhhXQqmaRb+VqflTZIIXgnOdq0pWExLqpTAFNVT0omYru2EkPAAiLvN02Kdnnvjx1mCKkv63vzlHzPyA55jmXP4AZBfJk49P61Ya8I0P55JoROzS6mz60FuHuu5CYijI/Zd1Jsmwwdm9froVlkCWEglzIYqlIoiMHsDR5bLqC1cL0FOkJt7iXw0AaIw3Tpx01lobYjq0bsFwVpGADlcza0vb8OMPVX00S/0cjnLXDliZWBVY3omIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jujABUvwGy1I+/dcIYPq2VfhMnh1mDPNK3I1fj5GGxs=;
 b=KDfg/kRQaxWKLcuXLnsB8IOvRkTmYn69eUkS0hDbmPlYQ8wXBq/P8P3G0Z9c6Rs+cHMjR241W82jiFFl4BkYvQqYYOykxGCHJuKNkacw028j8LHSOIXXJFeRkabg4qABukK5j64v1uqKpSxkwv54KcSLMZk+08z6Mo7Gcy61zJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 16:05:25 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 16:05:24 +0000
Message-ID: <e58e85b1-b52f-7a0d-733e-df1729ac737e@amd.com>
Date:   Thu, 15 Jun 2023 21:39:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 4/9] ASoC: amd: ps: add SoundWire dma driver dma ops
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-5-Vijendar.Mukunda@amd.com>
 <0dbd1c24-0006-7956-9b82-780c7f005927@linux.intel.com>
 <36242cca-b20f-03dc-2d3b-62a797291af7@amd.com>
 <2c4fb68a-70f7-6d75-951b-ee7fd209fa8b@amd.com>
 <bf711135-8959-4ea6-b1e7-4adcb11dab67@sirena.org.uk>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <bf711135-8959-4ea6-b1e7-4adcb11dab67@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0dfa6a-3a6f-441c-8f8b-08db6dba53d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvpTrWgxxlD7LlRjOzPZiQ3HdH9bWLeiIMtJsNDMMou5iJxqPI1Hgw3gprr0Yy/3g1ZIpVg76jp4pIfPqhNAtz9VkxqWu0ns7qRU+AqTit93GzuQMW+saJqMQLWUFLKPiuLpFllYB/PHLElyW3Lm3xYwYfuGwFBnxJDqPtydl+TXBuZWWUk5NtyzVYJlAN3jrqW35tmPNSojMbOE/lWMz75KgWT0G8oyS1bB/QXcE2ddkO62rFvqFbneiWJlaZRv/4Dtwhk9NigAMvI9MhuZdDXdxU2X0bYaKCMQyIIqw6v2NJgbInTszmf99rlMdtpDXslAkOsTBd5vOYMiPH+Pk8sZYpOo1AjFgvqOLXmam9fU55js7zk8RUODyfxoUp/utQjX5IoptngQuM9JuswPZsdkSiudgrrK1uhKmwESFjyf86HoP10fmR3ZxTlUnY3UHqwFNFIEDORLhG46P+dtPQhKrEwldE6BUJkT8XR9Cf8mffagi6zoWIbvB8lb66vT7ZVaoaxnVnZz4jqUfXra8DYRCOujoiYWW//L0dFc245j33e/EZ3Fdg4ifk8PhN6B08JXc6WHzH6TxszCr+1jbbeSBl/vwFXeAVOq/lm5kxZtJ0PWNoTA8OEBXS/IV43s9Nd6KARaDvjPq7wyDExv4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(478600001)(6486002)(6666004)(38100700002)(2616005)(186003)(6512007)(26005)(6506007)(53546011)(36756003)(316002)(41300700001)(66476007)(66556008)(66946007)(6916009)(4326008)(31696002)(86362001)(2906002)(4744005)(31686004)(5660300002)(8936002)(8676002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFkdUdxcGNjRXc0blNDU2lsR3h2dGV2MGNPQ0dGQjh1dEJiNy9sVlJxc1Rk?=
 =?utf-8?B?RE5oRS84L0JXZVlkbGcvMFdGUUNvL0hLOXhRZHJic0FHS3QwL2hjYnFUcEtI?=
 =?utf-8?B?enlrN1RjVjA2NTdNYzB1MSs1RythU0lHVlpkc3NERWptZWlxU1NZOHFvS2Jt?=
 =?utf-8?B?VktGU3N3aERCd3hMYnVJWjFLQjZUcUpKRVVDRkpqL2pyS0tkaEphUW9oRlVa?=
 =?utf-8?B?Y0Z4S1N2Z0dYUmZFcWtYdDBzamZxbVovcnpuL1l3V1hCOCtwbzhIeW1YdXVF?=
 =?utf-8?B?dmQ4MUYyTWhKVFNIejdRTU9xdDNWcERoKzRCTGx1NkhOK3dXWnBjTG5Ld0VX?=
 =?utf-8?B?SjVYSVJKOFNwVmlhTGt2OGZ3M1BuRGxwQmZ5U2wxeS82a2cyZjJjWFFDS01U?=
 =?utf-8?B?RXlLbW1BSEFHVnJ2OEFJMnZ3Y3lnMVg3UThtaUNCSzM2T2JHSDBXbVZsaWZk?=
 =?utf-8?B?L3ZHaXBtczVaQWRENkdZcnZDK1MzVUwyM3A4UEdNa0h6NkNqdzQ3R21ZZ012?=
 =?utf-8?B?VEdyOEpYa3dibjBHRFR1Q1RRMVZuRzRGQStpem1JRUh0MWdTaTlSNWZEeGtB?=
 =?utf-8?B?Myt4dGZwV1hNT2NJVWRKZTV3cFRMd3Q5TWNkSTJSa0k5VTNQdDNRaDM3TGlP?=
 =?utf-8?B?RzJEVXFHK1NHTkRpUHNQYjhVUG9KcnNEMTdSRk9BRkw1WEQ0QzYzQndnSEtp?=
 =?utf-8?B?Z3FHWkRpNVVYZE9jNmdpTXN3eG9RNlMwSlRTYmFwbnlzaGxnbmt1aTI4QWVp?=
 =?utf-8?B?Y1drbHdqY1ZOMjJsd1Y4bkdVR0d1OE1TMHcrU2VYZzdVNmh1NlhLTHVXODdt?=
 =?utf-8?B?dWdhamttdFRXREZPREVURGlkcEh4WUZZb0hxOGhJVHV2U2ZFZ3FxVXdsWkly?=
 =?utf-8?B?R0NENkkrUjlDYVJHNTJGeWFId3dseGIxUzBjbEhOd0lmNzlaN3dhZCtESWpo?=
 =?utf-8?B?NFB4VlBUZGhPUHFFNTU4NHB3S0hsZjlHSUlQdk82K3ZZTm1VcCswN2dJSkc2?=
 =?utf-8?B?Zmw4TUVIQXBsUDlTVTFDQzFYK3R6MkQ4TStsY1B1VkYrK3F0MGtMUlZXdmxZ?=
 =?utf-8?B?WGtCOEtBenZMVGRFNDhGbjdNeFpvQmZQNEFkZmtXR2xxbWhMYXY0MUpMQTZk?=
 =?utf-8?B?L011NkJpN1BqYXBOSnVtaUNhUmhaMnV2czBaZXNhNmQ1NXEwamxaWVc5a3Bj?=
 =?utf-8?B?c2pDSHRTam9vMmdLcko4K3h1K2oycUVHVUhZSmk1MEk1MnBFRE9yNk1IaTVv?=
 =?utf-8?B?VHgxcWZIQyt5ZHFjbk4xOVk2eDFCOUR1ZHRab2hLVjdJa3ljRkQ0TlpXZXZX?=
 =?utf-8?B?WFNWUG1pYm1YYmY4dU9ZaURXdXQ3U1RqRFpzTXhLZWpWclBzbnQxZC9ubEZT?=
 =?utf-8?B?eTdWOTN5ZFVldzNUbGJoWEowckNudjc4cXpUMVg5K1pIdDh6Mi9SSWhsZnEv?=
 =?utf-8?B?U0QrVDU2MURuYnZNMXJsYnBXUFVsWmlFcVoxMW10Ykg1Ri9PZXd1aUpsOTA2?=
 =?utf-8?B?MFZGUTRuNkdjb3hvZ3p0ckZqWElTbGVvRHBqQUZHN0trNEloVEFDbmlUaEhx?=
 =?utf-8?B?QXhPK0Nwc21HL1dralZjdUF6RWp0M3JRcHo3d0Zid0ExTzBoR295elhYeW1H?=
 =?utf-8?B?dGN3RmRMTTl5MllST1RvNU4xcDhBWndlWm5NZHVyMEtVa1YvcXZnSEdOK0V3?=
 =?utf-8?B?Q3dhMFB5R2xuclh0eEdQSFI4RWhBQmUweDJJOEpjUW1HNjZ3YjR5VlJQNVpr?=
 =?utf-8?B?RHhER21WRmtnTnRXZmE3ZWlRKzJGei9Nc1FkZk9mejZ2M095M3F0Q1o1Qm1M?=
 =?utf-8?B?eE96NWVScko1akRUQ29ybmJ6QTd0V05FOGVpdk1rQ2pNOXpJY1doRmZiTXhi?=
 =?utf-8?B?ZWFNMjI1eDFHTXRHN1JpUkt6WHhzTFFsNXQwZFZ0NTJFbDk0S1d2K2MzYmRi?=
 =?utf-8?B?d0NwZEJzWlVlc1dNLzRmRTB3OEhORUhVMlVOQmJ6eTB6MXRncjNKbVNNQWlH?=
 =?utf-8?B?anhaQzlqQ0FCVVlPa3BUZEJkSEprSnNMTUhuTnU3c3BMRitady9PL29vVkNT?=
 =?utf-8?B?T1VtNWEwdTliV2tKZ1JUN21Pak1PUE9nbGxYZTRPMm9YV3FQS041MmRnUnZ4?=
 =?utf-8?Q?y6u1JZKl6mvT2QQVpgnhij11/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0dfa6a-3a6f-441c-8f8b-08db6dba53d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:05:24.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 767+b199o1Zw8xU0o03zFT4OYTIzkbgzQmDlb6CgA1kmI00GfEg78iWRmdIx1Mxg5FqcOES7TauxujuA/ozAxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/23 21:26, Mark Brown wrote:
> On Thu, Jun 15, 2023 at 09:20:08PM +0530, Mukunda,Vijendar wrote:
>> On 13/06/23 12:30, Mukunda,Vijendar wrote:
>>> On 12/06/23 23:36, Pierre-Louis Bossart wrote:
>>>>> +#define SDW_PLAYBACK_MIN_NUM_PERIODS    2
>>>>> +#define SDW_PLAYBACK_MAX_NUM_PERIODS    8
> Not seeing any new text in this mail?
Sorry it's my bad.
My reply got mixed with previous thread comments.

