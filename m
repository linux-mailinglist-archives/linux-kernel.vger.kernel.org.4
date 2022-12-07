Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333B6452E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLGEKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGEKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:10:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940AC56D5F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 20:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKLvtRvVb1DnQJYMqyVz6uVEmQU2Nkz8nASbZT5lVxhRGipGSaTtiDz06pZoqOAATZNXLUhGAPk52MQ3wT8pG4jxKWx6l4sVWT7yXMZUkM47DVoBa6eoOuUFl/Palg/xJc/CbJ0+2GW3E7Nu/8OWSpK+MPNx0Gr4KIiqvmUF2VOjt51i3/etE/kPfQCvWOeHIVamI4CArTKPFyM6i85pzd0ijzuQYLyJvJDB4pBGA2/DBEQN3f8FHnIUxHkz9WyRDMTvACY+TPIAzD3702Cojj5kC4cre1yVWvgRkitViU+eNxs6hKLnokt3rxTVuL0a4qL3ZcN5ep/778Yj/FdcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPGp2T0g6a2jpubK6gLHNKj+BhDCDtxsf3p61ILXqJU=;
 b=aHW2mqGQ2w0yukPOicuuXBdgXVkhv8kODQAdDopcqtTHOKRfdhi3k6DB+o4d9Eo1vEMPX/zpF6QuFelM+77VZccLyGbAhnx+A0+RuSDgFRTvgBGd0gMEvYzDNoQXngUU2WnU/jcPkrrCrcsJayRHmVzgZxq4peY5xQDAb1nsK+12HgK7M3PlJEmNzdavtZtiD6+yzFChZlC3Kg7H6YvCF6n053MUJCNwUaM0FywICwlMOSImW4kkl3/GG3nV7+uOoUAGovxN6ucb3Trywjdoc+2DathIEJSPgxvTMAA0t7ONFcFgkHeGolx7m1YfNeNSHh+GmsUg2Fqp96TIcltsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPGp2T0g6a2jpubK6gLHNKj+BhDCDtxsf3p61ILXqJU=;
 b=s+Dg7M/LFCnUYfC6UuOCybzu23jU0ypLWWrQT9CW6uRb1sbU0V02X+uRrS2EwmD5YLQbdcRDieIHHIYl9SUBAu0XCp3E6GXkfk/VuMeMNFxBfXZq6OUcbWqNYTcJwo8EHlz5TO7gLEzxbaE9SoMg0TyWzO+GvFNmIOKNhuJN2UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 04:09:58 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 04:09:58 +0000
Message-ID: <3f7821a0-7139-7a97-ab24-dfca02811fc0@amd.com>
Date:   Wed, 7 Dec 2022 05:09:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] virtio_pmem: populate numa information
Content-Language: en-US
To:     Michael Sammler <sammler@google.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mina Almasry <almasrymina@google.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Sammler <mich.sammler@gmail.com>,
        virtualization@lists.linux-foundation.org
References: <20221115214036.1571015-1-sammler@google.com>
 <CAFPP518x6cg97tK_Gm-qqj9htoydsBtYm5jbG_KivK5rfLcHtA@mail.gmail.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <CAFPP518x6cg97tK_Gm-qqj9htoydsBtYm5jbG_KivK5rfLcHtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::35) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f2a312-83a8-43e2-ee22-08dad808e751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpGJHtRdGaY5KySmWFmDllC0uvFAcUtcdQ4d33ycSOSug9FwA+79dyUo/OmvFGR6v850J+2rl7NG5octHFy7RDOkVZ3gJENnbnX1+Xy7BXakZalF2PyxhDir0QYxtRIItINAn4nX89LRhzHesaTmPvbs/yjas+46+AWdjWzk3obmB9/0/igLhjDjsjPgVCaQ+WyCBO6Kb/0nbRjZmDALAiRDkcWZRk1H9CIMURISnrHutWEIl2LLZoqg/KHqhBUAq17ehhzd5tyV53hhWnbEf96vTbAYhTfZtN7h2xIuWbIw4+DAJd/zu/F6pwPdIgrL4jrkQEfhfx1IMpfm1EaA6xIPog34epBg2Jz+Vs8BcGkW40+AoyqP6ObfkoihJhu5EEhCTWE7CqJajhaLqYrydTXrEUEHLtXju7BcWSvXajxQBQHm2fL2EWCRwjAdKGWbDRSb/cb1lJK5ybtISHU34TGBap1Rt9BDvHguim8WpbFirJSAyLx6DQhuNfRT3Y+SkoS1CE7KBB8mgDbMY4Z1JcMGta8/d7u5eIE4WJeJP5k8omJ8FMZ0HShLcyFn6nI2qIrUeTdNMN8Ok1BinsV+RUWlqCM4arj3Afy6y0BjUbU2Q3ojRo1+b+j5Yf5rGP5Kp61dHgRASHBndWavA8JSgYGHSE5XL2BOBj6VtuR8V8PUIOBrdjGnWs65H/fxHcZ7o8ASskDYYZ6+5GlY4xar0umE62HCHLpELBCC2vV/InULmI3MUXHrdbN0fWCUdT50KdcWsAVOpRA96awkGiIxhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(83380400001)(7416002)(921005)(38100700002)(86362001)(31696002)(4744005)(2906002)(5660300002)(8936002)(4326008)(41300700001)(8676002)(6666004)(26005)(6512007)(6506007)(186003)(316002)(2616005)(110136005)(54906003)(6486002)(66476007)(66556008)(66946007)(478600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNsSWZudGdteUp5anV4d29WUjFGTFpWeUN6bmZVbTVWaXNxUXBFVXZRT0gr?=
 =?utf-8?B?bG9XN3NxaUozUWk4RGZHOURxN2oxZVk2SVZEcUtHL01XNXBhYkVWc3ZUTFl6?=
 =?utf-8?B?ZENJaStSNzRUeWFhaVhzKy9jZm0zQThWQTB0YXo5OVp3RVZZQlcxRWplb0tR?=
 =?utf-8?B?THhaRERObjRnOVNCRzZUNnFPYWdyS0daOWJPdVJwSy9McGJyT3ZjaHdGcU1y?=
 =?utf-8?B?VTk4NSs2cFpJOXE3a0o3bUFLRktYR0MvdDRES3BQeGJtaHZUcUNScFBmSzg5?=
 =?utf-8?B?aWZzcjRjTjJyeEF6WTBXMlcreTdpUk1jN0lwREg0a25May9OSUVwVUpGangz?=
 =?utf-8?B?eE4wZk1oS3BYMEVkaXEvNWliTkZLREtZSlY2Y3h4UVhSdFU1OWRnREo1NWFU?=
 =?utf-8?B?VmtDMDNGRjVqVGlib1lJV1lta3pibHVnZFN6aXoyUG1EZXhicUpYOXR3MUh4?=
 =?utf-8?B?eG1YMW8zZGZxWjI1NXJsREJrbENXV2dUSmloN2VvcVNacjhoZlVYM3N3T05R?=
 =?utf-8?B?Y1JVRTVTSmh4UWtCM2tSVkNxR3RTek91RnVlL3RJQytERFIrMmloSk9rZkly?=
 =?utf-8?B?b2wzbUVGU09zVlAraElNdXhwcmVJWExFL0RkTUlqK2tQNEJURFhEenl3cStZ?=
 =?utf-8?B?NlBiK2t4ZEtLemJvYkFtajZNSEc4a2w5K25BK0pJakpsMTB0Nkxoc0tBYkds?=
 =?utf-8?B?dkoyNTg0YjRYRzhxdVMxNjczTHp5ckFCWkYxbDBrdUorRlgxdFF5SFFDWm55?=
 =?utf-8?B?VVZjTkhxQXgrVDA2RlhGZ20rUGk2RVhqQ0MybEFFQWx2cGozQ0VHSHBFK04y?=
 =?utf-8?B?TGNaVVgxVUZTejQ2TWJ5alBobFdjcFlPU2ZSaTdRaFRvS0NONUlNc3lVbklL?=
 =?utf-8?B?cXlYOGIwMHFMRVVBNW9iSFUzRElHc2VwTFN0QUovZHRXQXV1eUJDMG0xN0pi?=
 =?utf-8?B?aTRrV3FoczRtbFFxd3lqeWhoazdHTjdGNDRmRmNOWjNqWlpIMTBYdUdleDZk?=
 =?utf-8?B?VW9oL1Jmei9IQldXckxFSmErZXFheU9ReHYyM1E4NDA3QjVTam93QkFSQTh6?=
 =?utf-8?B?STlLajZyaGpNQlBSOWw3NlZkaDkzSDI5d093bzRqbzh2ZjBwZnZGZHJaeFMy?=
 =?utf-8?B?bnVoUCtmZ2p5QnN2dkkvQ1ZNS3FNVDZpYTM5N1JQZStQTXdpeitxbndZakhw?=
 =?utf-8?B?RnVKTm1pSmlHcHp2eC8ycEhYalVleUo4VkQxMDZmV1lFczEvNVdOdGpORUQy?=
 =?utf-8?B?aU5QRE1FUDhiWmZUY3dDaG1MZFhkQ2t4eVV3UXQweWhvNTIzb2VLSFlzYVZD?=
 =?utf-8?B?MHBJUnB1Vk95VmpKclZaeXcyeitlTTZSVG9zeDFQQnN2ZnNlQlk0blQrSWc2?=
 =?utf-8?B?Vkt0ckVQVWh4eGRuWWpyYUlUc2RXMXI0enpVdlJpblRGTVJ5ZHJDYWVKMlpt?=
 =?utf-8?B?YjQvSUlQLy85U0pXOHQ0T3QrVTRRTHp4UENIL2Ywb3ZkUUZQckx5ZHpGTzk2?=
 =?utf-8?B?TXJUTDZNN1Y3a0ZYbXhoR1dZZG5MQUhndG5TUU9XKzg5S2haNHBGYkNML2hZ?=
 =?utf-8?B?M2ptNUM5bHI2a3RsdGtNZHNEQ1ZTc2VZUkMranB2bVVOTlJCZ1ZVd2EvUFBB?=
 =?utf-8?B?YlgwMmhVNERSTmUwd2tZUXovVmJ0UXo0R3dJVGg3YXUwVk02VSt1dkU3ZWRi?=
 =?utf-8?B?OG5SNkFkdm1wUy9yT0dTMWdiRU1IM3loSFFWU1pjWE9vVGdNMVhQdUJ0OFQw?=
 =?utf-8?B?Z3lXRHNhYW5HZ0VHdXd2UzJrbURrY3ZKK1g5SlJjdzJwbWVEZlRwcUUvdmhX?=
 =?utf-8?B?YUY2TFRJMGVYRXRQTDZ4TVJEblYzSWxyYU5vQk1MZDZqaUlOb1FhbFVjb2ly?=
 =?utf-8?B?b0p6aWpQeGtDaHBHa3hmZEVVNC9OeFlpQ1BJS3JZWXVNblp2VURrUEpROHJY?=
 =?utf-8?B?SkFxQzVweXRHcHVQZmxVZVVrSlh6YTZIZFB6dndmWEJCTmlOWFN3UDVIMzc3?=
 =?utf-8?B?Mm1xMDZZRXlJbmd3SC90NENnL3U5UTJ5bDl2cFBVV1dzbCtPWE9lWFJZYWpG?=
 =?utf-8?B?T0NCbkJXQ2FHeE02eGs3SlM3eHZ1SHdtb243YndTcVdNc1N3ajdGUTkvRHRi?=
 =?utf-8?Q?JdwKHwA85EDWaokh93ElSmcev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f2a312-83a8-43e2-ee22-08dad808e751
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 04:09:58.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVxZRZobqny1qz2GAziXqn6IcjIHjJkAX7eiqArvEGXqjshjwOC5hh+xqNt7stNjbAmeeerkRCyF+1Fvwb/g+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc [MST, virtualization-list]

Hi Dan, MST,

> This patch is reviewed and tested. Is there anything that needs to be
> done from my side (e.g. sync with mainline)?

If there are no further comments, Can we please merge this patch?

Thank You,
Pankaj

> 
> (Adding my alternative email address to this thread as I will soon
> lose access to the address I am sending this email from.)

