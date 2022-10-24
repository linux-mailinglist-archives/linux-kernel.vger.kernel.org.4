Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A640260AC03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiJXOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiJXN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:59:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D429240A6;
        Mon, 24 Oct 2022 05:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5OGgm7rABHipgnmJGlhOoTjo1jj6HA3rJ8YDXIwms3a4dXNr4SpcA+gpNWo0jtqsCBSfKItBmNtHkvwABJh8eWnPKOvyKqKGKn1N1NTlJaMAmn/Npmt9Z+KvQZ3Cnwd/01btjxykVfERbM7rtRI12C/uYUk5IsYpP4So3E+eTsavn8YM0MMjGTo/1olzlUW0XHsrHpFeKPlxUPLOpsgbzGkeWxp+G/TA+Q57zJLHGfupMs1Z39YcrukCTXsKJ3DzWv7M9vb57uXDMvkrXUtZn2Cd/MM9WTu2cViPC1x5OW/6W0eteTe3wZMhQO1xBOb8osbso9MISx8AZKypCv7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlUqAbn1TK1GybaPbxdUl2WSBmBLNJigGTp6pCgQVEs=;
 b=IaJXwn+k8G+uLS8ZMNcIF+p/YPFfWl+wLLYzbeMprJp+qG2UjucaTdYehjTLbG4ZZfWSxCJwG/x4fbtw+ud5fWRBPoCBl/qBmHEIEipdWiTg3pB7kl+GqEbH1KotB/TYPTKjIcazOY46F8oLAaxUC4RJSKYeDnkAsBb2a08f+trAsCBPWddxA7sPpda7unj23QJoDnoL/FycUNLdC0+KsgHM+YWf3XWt7ri0EtOsWJdFQJFn69iLYgniif1ydKq0wGVtTHXl8oGDM05diJJfvt1xOS5RaRKOgc43sKqV2cROH2NEdh/+UOlY12NfhY1aK1cBC3TleAzYDu4RgPa23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlUqAbn1TK1GybaPbxdUl2WSBmBLNJigGTp6pCgQVEs=;
 b=2iG3nY2DPXNh573L+DgDL3xMU4YiBQI3nreTTrkwPczHdXBZAoEdtPObP5R8xuFI/HrSZ9dx2ysPp8UfyEnG6PSMGOZKXErU+hs4bER8lBcp4utgOd+Fm/BxQVfQrLlnVB7BTCwrAEQRSjPNIUP/EJpM7PSRDO20IOAWnyBPnTrJPTTVv3/p+jdEKAcX635EPM23h3I+tuEsSfMnoWeFiSm+IbVkZYDurb54+1bWGoPavPJFmlxSTJGOAPMZZ1xl41PRcylFyr0DxF3g0s6FHLW232NZb3/52C0+wiqcrZs/dvT23DIM///yEL8BO/3cruFTna3RTwMwH/jcgjJ4Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VI1PR04MB6926.eurprd04.prod.outlook.com
 (2603:10a6:803:133::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 12:37:45 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5723.036; Mon, 24 Oct 2022
 12:37:45 +0000
Message-ID: <1b747e11-d358-52aa-0dfc-e795a8949106@suse.com>
Date:   Mon, 24 Oct 2022 14:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Prarit Bhargava <prarit@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2342ef17-f8f9-501f-0f7b-5a69e85c2cf4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|VI1PR04MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2dbf83-b4e6-43b3-2767-08dab5bc8d32
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRZFnM8MEuPugIZtFy33IlHgd+ImMfmr9bU90tOzG/sQ45Vv5FFGH/IHrw60qAsGzn8saF+b1fMzDEaDpyawEsQeglIZvwi8HYc1jiAnBvOmBFL0B3YO1ittG0hfYsofeJIBgep1rrCNRiYhm/KR6WGeO8wWOgm34JkNdmk5PXRHH6Y9yG3bwg5d7cSi342m33C1JLetab/hJD91PX3TgT8FZjRvpghDkAZo891libDDzqdknw0PL9w/jD/rObRcVP/IfsSL928hmvesLNU5H7+zs0YEMKSKfWhsBHlzDoS4+k+oLOMdDMyR+oZ+Y2q0v92+w/nVzdJWHWVyTpNrgLRwKixL5ayt9F2EY0n2vn0KOQBLScEL7vit5qk4fr8gsLQskioeT1CDXF3p4GgKWPgIxZbtp5wnFFItOZY60U1qU0WKXHaQ2H/GAT5hz5wRrkw+AnS1QkQjg7YzZfefYTQbTOPW2mKFHXNbiLTV6rSOEJLTjcuTv7xv+441Aah5EiNX7YjaKE4FhKW2RMoVX33/vOSgIuHNSz8lN+pRiXY5IpEXOEVuQ+TlRBIC5jX2kujVLP5zW6iXsgPKmeQ6hNJHTA7TnLyxHnG1KCCKWizXPM6wql5Kg3rsrwiZg0t6aJzlsGvEsbg8lDAy4H6gxlwJh6NpXa7a2lzA/TytvKqoG3ZPxz9MV8cPgKAp0lWUKZ3mc/XSpmJfk+1qyusyMWTgmVQPY2xFdYQeJF87+092DvYl7jgOCekIBCwkKRACEeWEUS8BvgXhiY5Cbx7Z+FckPqLt4oGlhA/+GPDymPNuEoGhXU/Hvv7kPZToPFWr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(136003)(396003)(366004)(451199015)(86362001)(31696002)(6506007)(36756003)(41300700001)(6512007)(26005)(4326008)(8676002)(55236004)(53546011)(44832011)(2616005)(66476007)(5660300002)(66556008)(8936002)(6486002)(966005)(478600001)(66946007)(316002)(110136005)(38100700002)(186003)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTkwNTNhOUpBSEtBWXdseXJ6YjdTK2QzbktPd1hlaUd1dGMrMmc1TVNqSjhp?=
 =?utf-8?B?YTRUaWs1VUc0S3FLa3M0VzNKdFBJRTlIUU03M1grc20ySjZGbEVETnYzbVVa?=
 =?utf-8?B?UDVZUkdwN1o1V1F6V3RHWWZJWnlML24rVTNzaTdRTTg2Ty9XdE85OWFnSFhr?=
 =?utf-8?B?OGZBMmc2S0R5bXJ2WDZaYXBnMEZQZUlVdGovNEpFbXk2M3hxY1FSNUNKUit6?=
 =?utf-8?B?ZTcxbHZUTnRqZGErVmE3OXFoS3p5MTBmRlJlbG5XWXVpM0I0L2VXU1MveWp1?=
 =?utf-8?B?R3QzcGZmU3JScmVCQ0lGcUhWQzQ0YXhKYUZLOWRqZEtqS21ZaEpGSXBGNm5N?=
 =?utf-8?B?SkFmZXRlc1cxVWVnTjg0NklzdVFGdjJLM3Z5eXRDem9QMHp6V1ducDdlTjBZ?=
 =?utf-8?B?aDZISTZYcmV3aTZxMTBxQ0JUK3hWVnVFRnpTS0JWN2VoeXJoTkJaVVk1Tm5s?=
 =?utf-8?B?QitKM2lTd3dVU1UyMjgxYnIxdDFhMHh1VW01UHczSFo3cW5CU3RFOC9xYUVU?=
 =?utf-8?B?anN5RmVVMUNXZ2FiMjhBVDArWFUxRlovekhUNnNxLzlxaWFEZ1paYjArYjFw?=
 =?utf-8?B?Z3NWTW05Zk9Lb1VOTlhxcHFySlFmb3BGWTdCMk04YXpzV1JKaXg1WnkwQmRz?=
 =?utf-8?B?MzUyejgya1NNbnpMMkVhZTl6MXllbThvSVV1RFJzcG5wdDFXTldxVlJDa0lL?=
 =?utf-8?B?NXdKRnNrSVVySVlsSVgrZWRXRS92MDBFeHpITkVlcHltVUhiMnRsN3pWdGkr?=
 =?utf-8?B?UDNDK3U2cjVTWmtxd0l0SGRZb2xHUzE4MlFydlFOeG9reFc4SkdjZkZldnJl?=
 =?utf-8?B?emlJVjBVRXo1bjJLUlpDRjVQdHlBVURSRU52aUZYVEp1Z2Q5aEc0eTUxamhh?=
 =?utf-8?B?dDFmVFJ4bEdvNTFWTGlRTWVmaUtVT1N6RXhzQ1FITkJ5cnBtK05PaEJ5Wlhr?=
 =?utf-8?B?MzNLOGhSSGE1OXUvVkQzeTZXYUJuS0dxaGJQMy9NbGNoRk9xMjJ6VDdzTmdl?=
 =?utf-8?B?dEh5VDdvdUVNYm9mQVoyZ0lnajNsMHBEMXNYWDBNcnpKYmNpdk1lTnpCWGpj?=
 =?utf-8?B?M0duN0JuR1BSM0pXN3J1RTVibW1wRzViU0xlaVd1NGlVUWpZZFhnRmg1VmZE?=
 =?utf-8?B?VzkyNkpwNVlvNG9vR0MrRlV2KzgwWUFWcWZtOVcyQngrbHZYNTVjWUVQOEwv?=
 =?utf-8?B?K2tnTVNlYnBCbnRqdlNsNm5BcDRIY3NYR1pDSXpzNFFxZ0l3VFlyQjRWeTBn?=
 =?utf-8?B?MGl0czcvc2VPNDFFRURDU3dUMTh0QVYxMGZUanFwMHEvOVRveTkrQWowNG1h?=
 =?utf-8?B?bWwxdnQxWEdYOUVzb2lYcnJXQXEvR0RXZ3g0R0RpaW1tR1NxUS9LU2pHdzd2?=
 =?utf-8?B?RXBZUXR4aW9TZTNkWmtYOE5kV3JVRnR6bTBkeGhha2Rrb25ocmRYRkQ5TTlO?=
 =?utf-8?B?UDJ0Y215bDJhTnlKcHNaNk1mSXFMOUxTSWFyQjFzemRpdERieVFEVk0zVjJl?=
 =?utf-8?B?OUE3b1BTN1plSjdiMGxobDVxVGJEZjRKSDM1VHlvZkpTSnZEY25xTkxJU3Zv?=
 =?utf-8?B?d2NuTXJxb2Zvby9aNHlNcU1ZemJ3T1FEU3hObXJ6dGpqRjZxakhza2NNdEFp?=
 =?utf-8?B?bXJzMTBZTWFocmV5bVdUR3dOQm9TSWZYelU0SDkzWjl1WEZJQmF0djZ0eC8r?=
 =?utf-8?B?cEk4WlFFUnJzVzRrM3FIR21NWXJxdGxhbkRFN0xFcXRUZTVNYlZNb0ZpbG5R?=
 =?utf-8?B?Vlo0UXJhRzRzOUR6VVlnUytTd1IxYnE2L3Y4eXR2b0dDLzczaVVBS3lrTFJp?=
 =?utf-8?B?THJ4b2dPM0JBR1JMTnFvd0x6MXBjMjZXeFhRVGh6QjYzbWRDWmVrNi8vTlM1?=
 =?utf-8?B?Yml0dUJ3aUgwV05tUkZwTnlvVmZ3NVMydVFyL1lNYmNhVmZlUmVONGNLVFhS?=
 =?utf-8?B?NWlTYTlrL3NVR3hBNU95eko5aDZKVWxLNjk2WGJsMVEzWEVXODlucVRPb0dZ?=
 =?utf-8?B?dGp1eG90dzM2WnBpSEozSTdiSTBQbWpVMEdmWTVKN29BVWpZOER3SEdNbXht?=
 =?utf-8?B?M081Q0Z0dm84Z2JQSXNpejg1V0dyQ1d1R2dHN1JPWVc2Z3RCTkxXK1hkbFM5?=
 =?utf-8?Q?CqLA5MbEwiLdxmbexak643/1D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2dbf83-b4e6-43b3-2767-08dab5bc8d32
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:37:45.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W/Wa3M8MuvqSc36kEI7P+Ukyov+PMklzMKwwiEcjHYViegEYoZ2PDX8VtiTXLQDmJq6J9tu52w+d3xw8GcOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 21:53, Prarit Bhargava wrote:
> Quoting from the original thread,
> 
>>
>> Motivation for this patch is to fix an issue observed on larger machines with
>> many CPUs where it can take a significant amount of time during boot to run
>> systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
>> active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
>> attempt to load these modules too. The operation will eventually fail in the
>> init function of a respective module where it gets recognized that another
>> cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
>> is triggered for each CPU and so multiple loads of these modules will be
>> present. The current code then processes all such loads individually and
>> serializes them with the barrier in add_unformed_module().
>>
> 
> The way to solve this is not in the module loading code, but in the udev 
> code by adding a new event or in the userspace which handles the loading 
> events.
> 
> Option 1)
> 
> Write/modify a udev rule to to use a flock userspace file lock to 
> prevent repeated loading.  The problem with this is that it is still 
> racy and still consumes CPU time repeated load the ELF header and, 
> depending on the system (ie a large number of cpus) would still cause a 
> boot delay.  This would be better than what we have and is worth looking 
> at as a simple solution.  I'd like to see boot times with this change, 
> and I'll try to come up with a measurement on a large CPU system.

It is not immediately clear to me how this can be done as a udev rule. You
mention that you'll try to test this on a large CPU system. Does it mean that
you have a prototype implemented already? If yes, could you please share it?

My reading is that one would need to update the "MODALIAS" rule in
80-drivers.rules [1] to do this locking. However, that just collects
'kmod load' (builtin) for udev to execute after all rules are processed. It
would then be required to synchronize udev workers to prevent repeated
loading?

> Option 2)
> 
> Create a new udev action, "add_once" to indicate to userspace that the 
> module only needs to be loaded one time, and to ignore further load 
> requests.  This is a bit tricky as both kernel space and userspace would 
> have be modified.  The udev rule would end up looking very similar to 
> what we now.
> 
> The benefit of option 2 is that driver writers themselves can choose 
> which drivers should issue "add_once" instead of add.  Drivers that are 
> known to run on all devices at once would call "add_once" to only issue 
> a single load.

On the device event side, I more wonder if it would be possible to avoid tying
up cpufreq and edac modules to individual CPU devices. Maybe their loading
could be attached to some platform device, even if it means introducing an
auxiliary device for this purpose? I need to look a bit more into this idea.

[1] https://github.com/systemd/systemd/blob/4856f63846fc794711e1b8ec970e4c56494cd320/rules.d/80-drivers.rules

Thanks,
Petr

