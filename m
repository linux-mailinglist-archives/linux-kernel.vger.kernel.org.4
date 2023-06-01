Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8D171F06A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjFAROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjFAROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:14:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D29194;
        Thu,  1 Jun 2023 10:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2w/ktNlyQskzSQPM7OxdB/69KuRyfvuCD4oRr65tEgL/CejS6HYpAInKePGfPDDcYr4LfzdByJO4bYKAtgbA8cZcEgDEkLYSDvIehdklMCXt3MccXUT8+dLBQ4BW4TJkw2suD6TnENOVpGKSg9FfrEq73hJBrE9SFzUd759OJbR1oehMjNTajlPoGBKN+bbi9TR45n1GMHJXOaqLofkPM45J2QyVoFsAbie/eUVVhKgw7pYo3TOthvfA1PwHbK+9HmPiKlGf9xMTpw1wHFAYgOhIJ/CS341QOkcl71dl3wKT4EvTdaOBF2hWrtXl2Utd0vx55TIGOFdbf2ukUxkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MDh1J/AW/Cuj/CbEQImo5iP0KddAXWrwpFdM0xdpgI=;
 b=XKPjCSEPL0Nh2bPPlcjrM8FfaehuegJ//+w6dM2VOvYtEOQSYigA6r9V+IhNWr1+a0syHqFnOYdKsmPc3v6/fsIc5hjddrcAJeISH0gJVa6r1OyzmlNk25OmTJ3SCLZxj5pTPJnptlOmTfhqj04AxhoGFGz8l1auLHW88uNMrb9NweJl12iqAz8LTXA+hiAgvC6H+ujYwsWnvCBCOspRa1fSEocXeJd5rl+U5ioA2AAo0hzT0URjEVrJbugPnva+ukjg1QMZPT407jziZLOFNfnno7idNenl+hFwMHy7wWlKlQgeVvK8doghoIag+/Bztbzk6Yh1Njc1EyXI4KeptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MDh1J/AW/Cuj/CbEQImo5iP0KddAXWrwpFdM0xdpgI=;
 b=nAroHT646BEL81nadV9pfNWCD7ATAXfTtR2oJ36edHJ4m5HqDy8mm2mpHyuXi61wex9JB7AYGtA9+WLW8Bf9upzDimR9V/ZhxCoIdFOCkrhAJIhECOL+0m/2GKp6iwKtRhGbe1sZtVTxS2XzGuJziQXFfE6znxPPURDRdMMydeS+6lxyqb2zIFSNQp1KIWQCG6WlUxJC1AnaBjDE6v/j9NxBFCDhWH1ZkcThmjCTt7eSaOAl4VbohACCz79WFrNc3bXr2oyAXp5B/KTR/m/73okz+Y/TrcWbvLtkQzGz116etrsCnsAfNUlhDlByN7bN/IkQjZ4q693Dn3AbnJa/7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 17:14:29 +0000
Received: from PH0PR12MB5452.namprd12.prod.outlook.com
 ([fe80::eec5:2994:7e58:1d70]) by PH0PR12MB5452.namprd12.prod.outlook.com
 ([fe80::eec5:2994:7e58:1d70%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 17:14:28 +0000
Message-ID: <3e2b38f7-95a3-3d7a-9ac5-3d7712d181ab@nvidia.com>
Date:   Thu, 1 Jun 2023 18:14:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH rcu 11/20] srcu: Move grace-period fields from srcu_struct
 to srcu_usage
Content-Language: en-US
To:     paulmck@kernel.org, Z qiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-11-paulmck@kernel.org>
 <6549da46-dddc-67ac-73c4-966965addad7@nvidia.com>
 <CALm+0cVXGdLNQpfJxnAnq2j2Ybs_rVAEqNzxgLSq7bDJp1KnfA@mail.gmail.com>
 <0a35ce9d-8eec-4e10-a607-a2e84c8fc5a0@paulmck-laptop>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <0a35ce9d-8eec-4e10-a607-a2e84c8fc5a0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::26) To PH0PR12MB5452.namprd12.prod.outlook.com
 (2603:10b6:510:d7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5452:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1d19ec-b501-45a6-e6b8-08db62c3a85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkQGEw68CZ/E6/4iUBD1C/w3kZp8UFWjIPxezWrZ5uvPX4EqM0nXX9WCwJL3XSuxCJC97rDmDKI/O3b17bTzSRJU+/Mm5poHiqhovfmbKKSQxGxj+X+xrFw2FAIrVWLTS0s3Kj+M4yTNe/jq6SWB8j/o6DCfhttFlPPP+AtmMDv9j+f5GeWvmlmgPSdzKEiZtQ6S57dwhDY5lD04tge8MYy2XlG3Sj//NuoWh731GFYdCIUsgK2cGwkgI/wYZME+X6Koo7BS+zy/CO9HNmJIknfpQ2e8l0I0Ka/TilvK5/tB0YuToDoB6K3DBAC2tinkRa90ojtaLZgKblAAYzZ9u52Y/fgwUFTOtnsemD5o3S2m2vROWBUwXj3eZsWJ/u6WdlJOzPx58E9yN/eI0MpsVmZdGS2D1uZxxf+/SiyFHklSp4Z77aG1iuLH8eA65LEjbDGm2rTprnuKpsWQsC6kTrCoY1c/ERvBkOuN5kbcaoym/Lyd96uxdrJpP0yUjzcu15PFVXACELFL/NyL0yipFdXRJa4WQ4L5c6v/UN62vxPEtOzNjSRaX65XvIEzykZBj0uWeKyz+8jS29rwz4Vqtwu78V0FzzHEc6xub102S0qu9i7KPZhtRbSCRBvPu4Mghmmh2S0FbA0FvQ26/yMdjmT87FTJNmeA/wZpYa3wICfrKAkPE3c2exwj6ViRqI8Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5452.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(8676002)(2616005)(186003)(2906002)(4744005)(4326008)(6916009)(66946007)(66476007)(6486002)(6666004)(316002)(66556008)(54906003)(478600001)(7416002)(6512007)(55236004)(53546011)(6506007)(26005)(5660300002)(966005)(8936002)(41300700001)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmM5ck54RXY3UFhMcG1NeGN4WHArYjh0KzI3SVlhaERwaEQzb0xnbm85K05s?=
 =?utf-8?B?c0Zid0g3L2FBa3B3aEVKNFpPQ2NSRWcxTFI2aDdldXJsYVM5SitOUFlOWG5Q?=
 =?utf-8?B?M04zZEMxLzFLV3hhbCtzMVZsZVhDQ3JtY25EZ1RnUUJXNC9LSUFnWmxjRVBa?=
 =?utf-8?B?bHRGTmxzcVlnR0lGbmxLb2FHWW80ODlSd1NYU2cwcENzSkg5TXczaHloWlRW?=
 =?utf-8?B?OWMrcC9hWE0xRDRnNzhvYk9ZOTJOUlBWNW1Kak5sM2t2RnRaZENnb1dpTzM5?=
 =?utf-8?B?SExiM3RiWmJQbzJPT3hSMkNzOWJMMnpyUUtySnBKc0xtS2lOVW9IMlljR0Q5?=
 =?utf-8?B?Sy9uYmZObHRhMlpoa21YNkpId3c2U2NqUEt2cEFpZHlSazlmdDljL2l2SmRP?=
 =?utf-8?B?cEpVbklMTm1MYVVveitoWlpKNFNQVG52cjlYdzk1THlKeWxYTmZpTXZGMFJN?=
 =?utf-8?B?QVNvZmlCZkxESTRZa2Z4eXR3Z2FpVDdIWGtrMldaSkQ5WFpCaHlta1N1K3NE?=
 =?utf-8?B?QXBWb3lqeGt0SzFXck5neENGZW1tRnBwKzZQS0tJdDlGaDhZcGZOdDZJWWdn?=
 =?utf-8?B?U2tOaUNKN1grNnN6eUJYektwZFF6TVFHTTBINXVRbFdtdi9IbUx5ak5yRkx1?=
 =?utf-8?B?VElMNnc2SlRxZnc2SFpOdEdGTjdFL1pTa3FRVjNSaVJ4WnJ2d1lTQURpSVhm?=
 =?utf-8?B?T1BJZmF2WDA3TFdSMTBiVTcxRFdNZ1Z4cG5JUHhseXE0cmppWFpmRjg4R2tu?=
 =?utf-8?B?R05nbDdLN1BKcUhxMk0rR2dNRjhLZGkvTS85U1JxcUZKMkUvNzRaaDZ3cVVS?=
 =?utf-8?B?NmlQOWFiSFJpUU40eVpWSFZldnJOTWFpYjNlUHI4WGdRUDV1aXpyeERjUnNp?=
 =?utf-8?B?Z2g0NXZxZ3FmWVMrYWxGRzdxei8wNnlXYlJDV1ZvRW5DaVdmdFM2OC9sdi9F?=
 =?utf-8?B?MlRpNlZTVnB2L050VVpJellHSFVZd21MTkQzazlyU0Q4emp5TWtLejNBOVdw?=
 =?utf-8?B?aE1wZDZqU2VHRFhCQ01kSlF3VkpGRkhyaXBqeHFIZjgyRHJHT1lEUkp1dVU0?=
 =?utf-8?B?eHFabTNVOFlBdEdTUGZ4eDdSbEREUEdEZm9qR0dWWGw5cEtSeXlpamdKVlEr?=
 =?utf-8?B?Sk1mVGg0Q3ZWSDJHY2hVeC9hbU1kZUdvaGViQ2V6bGpHNU90eEk4NWRNNjFF?=
 =?utf-8?B?NjNwZ3NhaGRZdzhoWEhJZlRJM0tlWVhZMHlwSExzZTZ4K0FMK0FqTzFzU0NI?=
 =?utf-8?B?Wjh6RHFpT3ozQStzb3d6NzdzU015K2pXQi9pK1UzRG95TXhiOTJmYy9iWUpV?=
 =?utf-8?B?OVhXS3Y3SEtFaEhWMGg4MmRvWDMzckdIcjBjMStvK0RrWVhGTlpuWGZlVERH?=
 =?utf-8?B?VE4wbVNYSGtTWDROL0FLNldmaUhnOUt4YlN1NHZjRWxwUFpYOFhlQnNURzY2?=
 =?utf-8?B?R1FWaUFrK2EydEZCdnE2NWpqeTNsQnBYYlYvM1JhT3h6V3dpb1pQb0diVzEw?=
 =?utf-8?B?VGszS3lTOFRKTS95SXN4cks2UFBORGRZZndwSTJLQWZ3WWFBWHZOaTJkTWFP?=
 =?utf-8?B?Nnd4d1B1VzNxRU9MZzFzOWRMd3FtY0hBNnpSME0yY1RhYWRLNzh2TUY1OFd1?=
 =?utf-8?B?NFduMHZBcnQ2ZTUyVSs0U2FsVmlrZmdyOHRUYlYrdTFxcndKZE9hY0paVTFC?=
 =?utf-8?B?RWc5VmpzWU9IaisxVFBOU2IwQkZnMVpyWm01UjMrUndxSm9IM0JzNzR3bVp5?=
 =?utf-8?B?RlBPRHhlUnhMcjdpRFNBNHpZeEJGQURnaEp6VnFKbjZNamNVb2wxOEUyNmQ2?=
 =?utf-8?B?djQ4U3lOZVVadGQ4YzR1dldwSmRtWitydXZ0M3dhYmQxdzVvbjdsM2tZcThJ?=
 =?utf-8?B?aWRBN0RtTlBYcEtKK3VRb2dQdXlWM3pMQTRVMDlVMkxiRi9sSU1sb1Y3c3ow?=
 =?utf-8?B?RlhUU3g3QTFJcURxdWtQZlh4UHNxeU9kWGZ5YTIrdDJrU0Z3S0FQZmdNdHlY?=
 =?utf-8?B?dVlaUEwzbUdtbktWMlRjakhxVDRVemNHN1JMbEk3REhxS0Z3UythelplTTh3?=
 =?utf-8?B?SDdZM2ZkS0k0NUtEVjFUQVBnWi9uZkMvWGRyYnJ6MHU1eWJaMTVYZWx0Unha?=
 =?utf-8?B?T3JSQjRLOGk5cFNWWUo0U3lGYlZwSlZkTGhXT3A0cHJBNWJadFJuMGVOdkQz?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1d19ec-b501-45a6-e6b8-08db62c3a85a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:14:28.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHtXsjSbZbT8YPqPW+3b9DiOIDbTj5xkplP1O6a+aZNYvuyU8j/eeO3slVVaMkaHNF9dDP+CPdMDxPyLwg8uqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Zqiang,

On 01/06/2023 14:46, Paul E. McKenney wrote:

...

> Thank you both!
> 
> Huh.  It looks like Chen-Yu Tsai sent a patch to this effect and
> AngeloGioacchino Del Regno tested it.  No one has picked it up yet.
> 
> https://lore.kernel.org/all/20230526073539.339203-1-wenst@chromium.org/
> 
> This is clearly a regression, and I don't see it in -next.  I will pick
> it up and send it along in a few days if Matthias or Rafael don't beat
> me to it.
> 
> In the meantime, I would be happy to add Jon's Reported-by and Tested-by,
> along with Qiang's Acked-by or Reviewed-by.


Thanks for the rapid response. Yes that does fix the problem for me so ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
