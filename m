Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F3630AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiKSCu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiKSCuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:50:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CD10B45
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXp5Nk+R8l8votvvqtuvZhMpFpqQmoX3eSYpYU92RltVnN3M6ihb8vYjFriAr019GcaoSCJc7LuqxyZMMKyU0hM/dmP3S/Um4P40DHqTTPgPOIqoJaT2S03L0e0hqWO66pH+eqn7GW43tiw19jCF5B7qRzwaMWYTb0Uj5PX8K8OrwFT8oexaWjeMhGfUeBb13+bKbMs8nIbZetGqWxgHR4eErF1VagofTU0OW1inu24FhR0bFQ+7Dlh9cspJJY1SIizimftTs3yDpTC87Y8OMg+X7DMpLytt1xlpPontIgNnI+CAnTXP2eewz0eeCitThNtBxb5vQQnLMy2m2TB1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UEFSG0OYKlGqjZ/PRWkj0OJ+UzSo/gKsrrXE46jPo0=;
 b=SwPGtwAXm4QT8+bnj8OdhkGHCDCGuh5iakSnQyyAPHJUuW8QKxTbNIqcIih466tHjFx61ciivGI15/nHiPItKkOFOjwp+JjHOg1sedpnEqHnobp5BZuxY4invOXCfRllg0PId/w/DpGKm0ADFTlGuNVJrwM2Z7SK0D09nSOgDyMU/x7eMuJFWtvc6YS1n6bNUrCcKez25Vuq5Ayg5Kt3w2520db+XEsxTNGPEoBk/Fu/tlwpUBHcQJ0Yl/WK8f2E3XaZ48RFlqDQrvQaZe6YEfDzBLXR1HrNbnx2lmu5F5cDA3UXGRvCpxwQRo6bGYw9nwnS0A2t+lRQcWMkYShS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UEFSG0OYKlGqjZ/PRWkj0OJ+UzSo/gKsrrXE46jPo0=;
 b=kfO5J9IAQsUPBeBBNfd6klOsVYJv9b/S/7DRt7AI1w/4TsS/u4wdH4r1l3ul7+Hpieb076ngF7ZCYl+Q1ja8sBKHzLuWnZY86sQsBcCU0tSnNKk7KnwI0wNh5YFBwJdqOsIdhxkqlFze4Tmwb49o7vgWLhUVy5yZQOteAmDBwtZHrSERMBF6s+GB60bm+nyDRqPEvxQ7MDF6SUCvMYzuwy8hK95+rLxxuxdx+aK8UkylRkhmmXnn8vlV3c9PRtDYq3/FSa/d20e51qJvNwaF7ld690QHXP9V1YAU7E/fa0vtLk4qpvqEAsHo7hbKzkr1FWqU3SGrs1+EbNQdGtVfIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sat, 19 Nov
 2022 02:33:36 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52%3]) with mapi id 15.20.5813.018; Sat, 19 Nov 2022
 02:33:35 +0000
Message-ID: <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
Date:   Fri, 18 Nov 2022 18:33:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: Intel timed i/o driver in HTE
Content-Language: en-US
To:     "N, Pandith" <pandith.n@intel.com>, linus.walleij@linaro.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, timestamp@lists.linux.dev,
        dipenp@nvidia.com
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: a765d5a2-fffa-4b65-f0bc-08dac9d6756a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27L7yV+wbt/Bmn0SVnItavO9D9HxcwHyEHGjY9Zc/cshKkqU1jZwoyU2US4FSI87ArnCCQ2/K3EwkEFBABBlZgrnefzADu4z8YcGKDQsm8E20O8AGVlOZCSoD75DyX50wsVv9R6ImVLdaCDTK9xa/iUQkku1yMQuWhsuYnR1wnQfGOviDPoBZB6KAMBa9o0qwD3RzG1czzpQM4Es2O8r4fPASYXHVU3v4yC2u1+r7BV6sHRbgOZpmlg5zyGvRGxLefvG2+KaRZpg2x30Oyq8oDa0KScWMGtGZwx1PBbXeq/qYNPOpxkJzQ+Fd6pIjj7RLuP7Ltm4MuCBdAT+zN2H5DkEN5CrKSqbr82CoFwhIrrVmsKvxR3WImxu1CxBc+CAhTe/6Y3Oww/B4n1+5oM3yCH0R3+GzKNFqGWZXpH/ini/shXtL9/K3xd/Qb1ywih2DbMVA5MeHVAXcFLfQcQ/agjOqC9Y0MDzfbunNXAEPXTpWDMDIa9XPz6KF0MOwYu2I5vkrfHZmaBm2yq0Pjbktx9LkYQr1awwDYkfroBZm5NNnc6/LycP3Swo/j8OT8cduXhv+mrICCOayxMtxZXuege/Lu1bq4NLqNlTDRsZErUJPoe6lloULIApwsDuxzkUM7iVoEDucYnI0hawcdiJbTxGdJOUeeiRZ+nayrNjd1vykxWTnsu5nVg/2FfUl5bTRhunqZbPr/7PGzOFqXyPhgbGmNjR9cMP98meS3wAcnk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(6486002)(316002)(107886003)(31686004)(6666004)(478600001)(53546011)(6506007)(54906003)(7416002)(66476007)(2616005)(86362001)(4326008)(36756003)(26005)(8936002)(8676002)(41300700001)(5660300002)(6512007)(66556008)(186003)(2906002)(83380400001)(31696002)(38100700002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxxTnB1SUV1azdOckEyb3F1aTc2aUJxeVBITHpFZGxFcW4vdFB0RWNuVjJR?=
 =?utf-8?B?ZUozd2hveElhNEc5Y3B6STVzVVd0ZFdRU1NSTkZTRWhRMVBxa0xUNDdFRk1V?=
 =?utf-8?B?cGpjYjNXcmpMeXdWWUoxcGJrcWtvb3k5RnZXY2ZzRDZ2cXc5VmhJOEJxVzZR?=
 =?utf-8?B?UGJ3M2p2V0FuVjVRZDIwVkp2bFVGRS9LNEs5SmMxb2s2S3ZSMHp0Yk41bXRz?=
 =?utf-8?B?NnJRODVJaWNPaEpvV25kKzdSMld3SERNMnhCcDZGbytkS3BXRTd5RERDeTV3?=
 =?utf-8?B?bDJ5QjZmdTVpanlvQThkaFBvUmxsRjRzQkk5NHNBd3BkVFF2RlNCNEE2MVpm?=
 =?utf-8?B?eEdVbVpoYUNCenZMMHRJTWU0d0kveHJZR2JYVzZxWmNPbWdILzd4RFlmcWU2?=
 =?utf-8?B?NWROQ2EzOHN3SkM1WXdsZ3lvVVp1YTBYWklJZml0eWtoZ2dDRU4vcUJ5NEcr?=
 =?utf-8?B?T0lWM205UWRnMnhISDFsODc4bzZwWjJsZmdtUzVremdYeHBxN045MElmUFA1?=
 =?utf-8?B?RmRNa3lEeEtUUDVRRXFlTWo5T2ZmTzJlSGd1K0JZRi9GbWdVZWFOdENYM2FV?=
 =?utf-8?B?V1hTTjNLOG1oTDZ6c3F2UnlNeFNhYlRzOXFia25qS0tIaWluc1c5ZjBGTDVo?=
 =?utf-8?B?U1FDNEdXU3VWQVFtc0JzY29iOE9wWXJrc3dFeUs0Ny93UzBEaERncmpldkVT?=
 =?utf-8?B?bFk2MUxWdHBoeVM3VFN1Q0hzdTUvUWlGdjE4TkZJNW9rZmE2YTR2Y0E3RE1L?=
 =?utf-8?B?aGI0SzFpR1QzNVlpZmxhVjFLNWIzVUJpTG1OOTVicVY2c1pLWENpS1ZPR21t?=
 =?utf-8?B?MWRHK0c3bGRETzdlZVliblppbVFlZ2d1S29vZzhuWHFXT1J3a0dPekZ4WUQy?=
 =?utf-8?B?K05MNWdqQ2FsQ1I1N3dKSVQ0RzFDNHREV0xsTlRHejZJRjU2TkxBdGorRCsr?=
 =?utf-8?B?N21zb2FXU0lvK3NudFNycVZKT1ZIUHJ1SjVBQ3RqVjlEVlMvT0kyUDBFdmp4?=
 =?utf-8?B?azBXZ3pGUkdLcFF3YTloV1kvRURXUzg5ZDgrbWRsMEtxT3loaFVLeGt4Skt3?=
 =?utf-8?B?RWU1b1F4Y0lnbzNDWFJNZFdrY2creEFXRUJMMlh5TjJueWs2SkUxOWdSVUNY?=
 =?utf-8?B?Zm1vZVhmUTlucmtzaWJEYkdvUWp5bkdMK2o4OC9yanpiTmlFSjlvY2NWSGEy?=
 =?utf-8?B?eHVNRDVFTmVXMS9IM2VVMVlFdERobUtvWWt5OGNVVXIreUR3WWphOEdzME03?=
 =?utf-8?B?QURBNmpzRzA2dXNCTkN3cGdFTEc5Y0RNQ3NBTGtpVVlsUDkwUjhZcTdnRG5i?=
 =?utf-8?B?VkJyanptUFJQd1RuTkFESWtpTmJ2cFEyQS9Fdndwbk9ISGdFZjMydlF5bi9G?=
 =?utf-8?B?WDhGa2tPNlJmNzFGVksyNWpDODdRT0lMZmF3cFBoRk9hUDJyNVl1bmhoOFU3?=
 =?utf-8?B?RkRjUjVScldjTHlZdDFHRmYwYWlzVEQweWhYaml0U1FHY0NNK2lDWTBoR2RZ?=
 =?utf-8?B?cE5WZ3lwYXZxTjJSUVd0OTFZNTRUTVU4SVA4WmxYV3g3Yy95YXhXUHVoeTNH?=
 =?utf-8?B?VTZZTGlKaUxVOEQ4cldvdTVPVDNzOGVybWh5V2JRQzJQckZ0alBVM29TZktK?=
 =?utf-8?B?d3Bza1hNeTQydkRwRVVnZ0RtLzI2dE5kTEx3V1RpQy8wcFdjUlZRSTBSZWZD?=
 =?utf-8?B?UXZ6NEFZL2lXLzhtOVUyMWNmQ01Vc0ViajZLSGYrejdtRmNuN2tsNXY5VWZy?=
 =?utf-8?B?K0IzdHhCWTg0YlEyVkZMMlpxbG1ZZDRuaDczMXZlN2FlQmEra0Y1bGFyZ3NL?=
 =?utf-8?B?U0JhSDFxcVRXS2R1aWo4eThiMFFKdFA1NVkrQXBSN29VSG1FZGRuWUY5WWlI?=
 =?utf-8?B?d1RFTXMyaVhTUm5XZ2w1aDdXMG9LeW5SbGhyMWd3L0hRZFBSZWlNbGk4TzY5?=
 =?utf-8?B?ZTF5eWVGdjNFMzlBUUcrQ2pGQXRsWWVIVjBxbHVpdkVFZ1JHOEVlQ3daelh3?=
 =?utf-8?B?dDVrTm5oK3k4UjViZEdLU0NGbWJCVGpYQklZVDRTQWdWVGZPQ3Fid1V2alBi?=
 =?utf-8?B?ckd1OFJMZFFPMzU0UlZGdU0wSEIyeHMwUWhLRnhIUUV4MGE3WVFOeElUcmtL?=
 =?utf-8?Q?a3MciAMqBYdpf+SRa9t0Fy1+e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a765d5a2-fffa-4b65-f0bc-08dac9d6756a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 02:33:35.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6beDXYv/jT/5dO5JnVZ7hdLlAltGer6fE6Wh2pqrb7v5K27B+EUyu6YyKDCoH49ucr1l0VigPD2YwNi/GmEqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/22 10:47 AM, N, Pandith wrote:
> Hi Dipen,
> 
> To support Intel timed i/o driver, it was suggested by Linux community to enhance hte framework.
> However, we see some limitations to support complete Intel timed i/o device.
> 
> 1. The current framework supports Nvidia IP, which has two IP blocks (hw timestamping engine interfaced with GPIO)
> Intel timed i/o is a single IP block handling multiple functionalities like:
> 
> 	a. Input timestamping with event counter.
> 	b. Timed output  - single shot or periodic pulse train.
> 	Uses TSC(Timestamp counter) for timestamp or generate events, which could be translated to system time.
> 	c. Implement PPS functionality to export time.
Isn't 1c similar to 1b, where IO (mostly GPIO) is programmed to toggle/periodic pulse train at 1s.
> 
> This requires new functionality(interface) to be developed in hte framework specific to timed-io device.
I can see 1a is straight case for the HTE.

For 1b, the timestamp part can be added as hte provider. I see opportunity to enhance hte framework to provide
translation facility between the domain, system time in this case. However programming interface to facilitate
timed IO output can not fit into HTE the way it is right now. May be one possible way is to enchance HTE with API something like
hte_configure_timestamp_periodic/timed could be possible in which case HTE does something more than just timestamping the event.

I have to see how in GPIO case that proposed API works out, if it will bypass gpio framework etc...

Adding Linus W into the discussion....

> 
> 2. The current hte framework has a provider and consumer concept.
> Consumer is responsible for user space interaction.
> Currently Nvidia is using GPIO for input timestamping  (by adding hw timestamps in gpiolib-cdev.c)
> 
> For Intel timed i/o functionalities, current gpio user interfaces cannot support event counter
> or output modes.
Can you elaborate on event counter and output mode?

> Rather than jigging hte consumer into other subsystems to support timed i/o device. 
> Any possibility of developing a native consumer in hte subsystem, which could handle user space interactions for timestamping engines.
yes, feel free to send patches to me and cc timestamp@lists.linux.dev, I guess you can register your IP as one of the provider.

To explain why GPIO was treated specially, there was already a
user facing framework i,e gpio-cdev and range of userspace tools which could be leveraged for the HTE GPIO consumers. However this does
not prevent kernel space GPIO HTE consumer from using HTE core directly.
 
> 
> I cannot think of an existing subsystem that handles Intel timed i/o functionalities 1a, 1b and 1c (mentioned above).
> 
> Regards,
> Pandith
> 
> 
> 
> 
Best Regards,
Dipen Patel
