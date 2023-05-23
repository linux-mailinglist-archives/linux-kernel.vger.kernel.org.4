Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB5870D3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjEWGWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEWGW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:22:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F3109;
        Mon, 22 May 2023 23:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teff0VJJDOWAVaBPVNaTICNP+JakxPS0eJ4PRt0J89fWC2zToBoOufVTZM0CvAGXnUArDQ6GiiKQlL5kzYCfrsSgTrbQbt8uDMQok47VR8Q2CeTCZbQhLlby/eaVo25NxQ+GX8o2Q9epiIhiE1jGYp0XrbDmxrpOkXY6pmhOiayfd0AW0jQKwFrdY+zJmryGZ7SE5Bdq9ylfUA6JSvaEalJYbLjoWXy2oUDVRRAx9+2YCBPB7VeWzMI27fwEA42rT98VQ9A+Sv46mNnCpWE7Uo2LfIUnjEC8zgkstrYVDWTd90lktcIE+INWMHBKisGVzbxNcnooJFS2LBOqXGB5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na0kferQpv0abbXPH3KFI/VjN34Uhtuvaxb9nHp/+Po=;
 b=CE3aa51CR/CJxOi6LkP0D9CCzt3x/Szx2znkJp3VkY37DZoNMiE+zizAXXRFgmzANduhxSxwnKeSTELMDX+mN0J8hvHhimEVmAb3zmWSPPag69p3kKHvrBpmdIa7hbhfQ8YvN2U6tvmeBQht530jtA00z9CFdWXT0UPx9vnGA/kBRrPAETW9ua3RUd4pELcjBuzqksPgP3aw7MXvKc1nY4ln6lbHI/d/yitO6Gfgd/+PWd9xamUb83+uSmepkKCjFrKws8y3NbU38WBLjBXKs1tsss9WQQZ6QG0BgrAYMNd78awD/RViMs5S1LvyrqFGBIYSjTlcpWFhL3Je8WL2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na0kferQpv0abbXPH3KFI/VjN34Uhtuvaxb9nHp/+Po=;
 b=MKbP3f2WEkr3TkIG7ajyit4aPXPS9XfSZTXO4aneq9qTQKV0n7hVd338wDvNT+333dcCEjAv2T8gSocoxwQgqPdAWFOy85f46K+SSu3BLqfEB+U8qVAEBXqGZNhGkjTn25v+nyI1AhzYEVgeyzQf7CglPaKxq7wi4iynUBQ6bhYv+tu8YRqXzaQeYova8IXnXzZx50ThUNdzonY9lRpx/rW5eio5tYGy5n7H622QyrbH92lFCtOQ0LyCeqXnXlA+Tq4h2A3ykikvuHndl9yTH1HB+i8KAdG9Ncrlvo+EpxGjFv4ZQSGRcd26u50y14AJadOT7wzIdKl4U3kBkkOiwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 06:22:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 06:22:24 +0000
Message-ID: <1de5b7fb-a39e-183a-1407-7d6489f706b4@nvidia.com>
Date:   Tue, 23 May 2023 07:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] gpio: tegra186: Check GPIO pin permission before
 access.
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Prathamesh Shete <pshete@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     thierry.reding@gmail.com, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, smangipudi@nvidia.com,
        kyarlagadda@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
References: <Yz62XmiH8YG3Dtsf@orome> <20221007055936.5446-1-pshete@nvidia.com>
 <CACRpkdYkJdZ67kyTnDg3xFzO8MJhC0nHK98O+KJwCLBqV_5f-Q@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CACRpkdYkJdZ67kyTnDg3xFzO8MJhC0nHK98O+KJwCLBqV_5f-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: f097d385-0985-4b67-c25c-08db5b5612bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xzw8zcPpWWXERXk2nltC5C2+Npx8t9Q6Dr0ETNcnQNsOGNOTrpvpuVxHftHyJSkex4Rq7iiSL6JoQ3tF6seETwDF2KHv73i0JOMPPvUivasUnjmcelVxkm53bM+Xb26jt7jOUTKItcUdU+Y/8iQecTmyWLqzKoEoWbUQYX89HrPLQWanGYAPrqnO1fBR503dmTs+4BrvC+U0hHUc8Wmme12cxedV8eYTVCkd0mkGqs47iYKxnrvZ8WM2m6MZScd1vj1+OWjW5m4LlHBBIzHPa69gipmPptHDMJOdQPuYA1aBNKWn7kV9HlZA6u2MgdWdIF0KXW3yuzYRXiqdVcaTcqX3+P3nIWjfHYIvgZSaOkvz2LHhY6kSKHj1WM2c4mB5r1Z5CoCEMRhwJ2RIBwCOm0CRux3649BA0hPkOJeJTCNG1qFjJI94ZAChUTTdkQuV+aCMGOHLgeZDnzcU7jIw4DiXgG2R0I3kjYCwAb491zgWrplPasoZ3hk9QvZZ7DiHQV+P7+Z44x6sAMtoHKSLZrRX7G8dOJgpxsBLzkaMOn3rrXlGpQFiOrNpTHek8Rcu/pdPng0ATGEdRjVA+U+ULOgQHPgR7F6dc8kAjCzlnlWbJiW7RG+hMS70WRFDsrif629FvYD34gnNF9TSKsu52g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(5660300002)(8676002)(8936002)(86362001)(6506007)(6512007)(53546011)(83380400001)(2616005)(2906002)(4744005)(36756003)(186003)(107886003)(66476007)(66556008)(4326008)(66946007)(316002)(31686004)(110136005)(478600001)(38100700002)(31696002)(6486002)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFrKzd4TGZ4R3ZkM2lkeG1lbWdlU2FSa3FwSnk5N296VFltbHRaTHl2dXpz?=
 =?utf-8?B?QnM0WERQQmVsVEYxVW1lTUQwanNoYlNiMlQyQXdJQ0dQY0M2YWVTQVpQcENj?=
 =?utf-8?B?cER4SUxqRGFGejdJR25ZK1hhdWlhR0IxL2JDS1Jqazk5TDBhOVY5YXY3Ni9E?=
 =?utf-8?B?NFFPR2NpZEdMT3BFK2RLVkJod1IzYlpaNDF0VDVoNHdVM2FmSDhtYWM1L1ZB?=
 =?utf-8?B?ZjM2T05rTWlPSXdpcU1uV3lzaUI4b2Frd00vYUNJbENwZVl0VzBKSEFXdmFw?=
 =?utf-8?B?cHhqTWtYZHc1dkhGekJZSlpEcmNhL0prdWpWVzJNM1BidGV3WHNZSEljM0M1?=
 =?utf-8?B?dTVUWVczRFRPOGNYbUhFVEpIdXhQa0VkRENhQk1rQ2dWejhhSXp4U2RYTkJ1?=
 =?utf-8?B?dlNEamlUUzRBOVF0NHBibVFpOVFydVFBYjdQb0JOTkJFUVlBNTcrK0FOSGRq?=
 =?utf-8?B?YjlmQTZKblFMSThWMnFyVDVHQ2xIdnNYVEN5M2tXZ0tWeUpXOWxhaEloaWZV?=
 =?utf-8?B?NVBnTjRkUCsrRy84bFE5WEtUUjNwRzlmK05JbXBrNGlVMTcwdkZzYUcwbjF6?=
 =?utf-8?B?TUs2UEdCTHhDN1NJTnNHYjlmcnREYjVlcTgxNUNVNHA4YWhONmRNVHdNYUph?=
 =?utf-8?B?RTBKTzhqdVRwRStGK1V3NUJSZUxUaWVxN3RwN0ZvVHgzazA5eHRCSGJobVI5?=
 =?utf-8?B?a3JyTHpHeW8zRFpGRU1IN0tQTXk2QXVXeENsbzBWYVBUaGFpMlFkMnlzTVNz?=
 =?utf-8?B?VkxkNkdCSmE2UCs3SjVpYWViMk1Gb1BYTXdtUUt0TVBpYmxkOWZIdjVwZWVp?=
 =?utf-8?B?UlpUbXNjRGpqYnJDdEF3TzB4RTY3RVc3S2prV2FPeUtyZktrWUVINEpiMy8z?=
 =?utf-8?B?OU55dEN4R1BlMGZZeWEyN1o5azF0c1pabG9nbjg0NnlaWVhuOWVhNS9ZSVhX?=
 =?utf-8?B?Q0xpdW1Jd2RrMDBoaXJWeUdHa1hnVFZhMDlPdUwrQS9OazBaSC9JczMvdGxi?=
 =?utf-8?B?aEc2Ri9ieEoxSXRwSkRJcUxidGxCZ213Q0trMVo4TGtvVXVSSkkrQzkvL2ZJ?=
 =?utf-8?B?QjJZS2NuZGtyNmZPZFVwN2VJanhlckplRDhteGxVQnFlQ2lTaHBFZjN1WFNG?=
 =?utf-8?B?NWNZcnpxYXRjSk5CVzZUeG1xeFN1a2ZPc1VjMWdwUXJDZTNtTVdpY3BndUlQ?=
 =?utf-8?B?TUVVMFZpVXpFMExMRFhBdzZDSlEzWFlibFNMOVExK2Z0N0RUOFBHRUZSUFYz?=
 =?utf-8?B?QzZGRXcraUlTTE4vYlFuUXlCV0VvdFgvc3ZpRElKZGtadGdqandEUFhFWG9v?=
 =?utf-8?B?bHRoNUFybWFyYkVHbWs5YjAxS1pQWlVOTStuZjQ5K1p0RHhTaUU5djlLMEYy?=
 =?utf-8?B?SXlzZklxaHJDWlB3aWUzSW9BamJ3bmVxNEtpaXF3MmRkQlQyRytKUCtVZGU0?=
 =?utf-8?B?MnNCak5SMlp1ZGs1OW9wTW1jTk13VFR4MmV6b2UrNGoraVVPZGZuZXVVMm5M?=
 =?utf-8?B?ZGxQZllBaGo3WUxBT0lyVmp3SGtMZFdhZHRpaUgvOEdHZ1dQdkpRMFhVMFlI?=
 =?utf-8?B?azU0VVpHY2MwY2Iza210MDNheE1QTjRhQnAxaUN5cnFIenRIWGtxaU03cDFF?=
 =?utf-8?B?ZFFKSUtUd1RnSGtOa09ZRm9Ld3NIUG5hMXJ1QytDNkNOUHFjeHk0ZVVPZWVk?=
 =?utf-8?B?SlRrK1ROTHkwYnh5ZkNZam45cUE5cnVHa2xCdmlBNlFhRDUrbWFLN01yblh0?=
 =?utf-8?B?UTJGK25XNWU5LzV4T0hpSi92Y21meDJYQXVrRjJhL3pkdUo0MUZOQTBPTWty?=
 =?utf-8?B?cWZVTmtJOWlBa2V1Skd3TkhDQTVjUVJwK082YWJVL25Ld3pJYXduK3ZGZzVH?=
 =?utf-8?B?eWtERGhpcXlvVWRDTEVzUFdjMTdiMzk2N2o5YzNYcmJoRjkrd3Y2U2did3Z1?=
 =?utf-8?B?SU9SRm44MVY5M29saldXaS9Lbko4OW9uYndvaWg1bUozdUR3SHhyc1JCVWhy?=
 =?utf-8?B?WEszODNZY1BGbDZHYWhyQXJrL0JEQkVCVmt2eXFoeWFNSXIrZ0NCaGV2Z1pH?=
 =?utf-8?B?YStiWkxlUVRReUVNUC96Wmh1Z2dBYzV3UmZlb0QzV2VvU1Q0T29RK2ZGOVc5?=
 =?utf-8?B?VWVxV1VpYjg4eUN5a0lQL1diQ1lucTlVc253Rm5xRjRYNDFCdGtrUTdqeVhP?=
 =?utf-8?B?KzY3b0NJekU4YXkyYU1HelZQbXNXdEt3bWl3dmozMGRMOU5BODdUbCtjMXdv?=
 =?utf-8?B?UXRhUXk2RmJaT2F0dlBuTGtxM3hRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f097d385-0985-4b67-c25c-08db5b5612bb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:22:24.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZPyShZN32rCiSxCUnw46HR8e4NerUVFL8uJ8AnXMJSYgw8WH/zVGO7QWCeypFaqaRzdMiU+LQGGhgGJ4w4KKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2022 10:31, Linus Walleij wrote:
> On Fri, Oct 7, 2022 at 7:59 AM Prathamesh Shete <pshete@nvidia.com> wrote:
> 
>> This change checks if we have the necessary permission to
>> access the GPIO. For devices that have support for virtualisation
>> we need to check both the TEGRA186_GPIO_VM_REG and the
>> TEGRA186_GPIO_SCR_REG registers. For device that do not have
>> virtualisation support for GPIOs we only need to check the
>> TEGRA186_GPIO_SCR_REG register.
>>
>> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
>> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> 
> Very nice patch!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>


I did not see this anywhere in the mainline/next. However, I also 
noticed that we don't have the correct email address for Bartosz (again).

Bartosz, let me know if you can pick this up? Thierry also ack'ed 
previously for Tegra too.

FWIW ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
