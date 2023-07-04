Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECA746733
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjGDCPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:15:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA13136;
        Mon,  3 Jul 2023 19:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrEL6AKdOeZiPbvvcRfPVvkZWYk/60JbJxLDPI/y9F8C+lsbFiTzu88jfsGgiQgDW09PewqLijZip5PtlDESLzKcuQopQtd2ws/gH32AvhOGVhKP9g50lJ7t8/QSWpIclR5DhU7ZBO9RylBd85Y5NZFheR4EIjnlTtc6mGaeFvFF8UeEmZjrZTOTy5ou6D2D3YnjIGUi6J5DSVvbT5EULT85lpo8ndANLFNo9WTauctFyeeH/CApUbiRIc5WjdSLdS9VChgptgu+lLTFtt/y9qGoq+8K3nMUuM4otyNMmaOcjCml8WzQ1fmC+O7DheBfdcWzJwOTgzTNmMinndq0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td5tkeVrd+dF4QVMU5Cz+ehwGRi7qAOdqB55xP1Vayk=;
 b=OCeu2hqfpJrO7KWY5GUqAPEshqn+2gtfjMhDjq12sqGq33S6Ju7SKW14ZkfxaSsQ5CaSKi5M1sHVbMg/m/BmJDy5V1K4jfKW6Nyw/J8gYDEonRtHYq8Ir6NxyBdZZlnRQKPo3wf0PqyPVJWcTyLVhd1mAfY/D2OvyRQsgYa/3diiRUVniyZhXqN58LIsbIpnmV4CQIin53tnZSAtQJIlx1vkOvkN6qrPbJSqYfJyPHzpFTbPMUs8vLibToc6XhfoQoXS/i1QKA2l7TlEXJDf6djmJLg5LSRufbzIkLrjb1vxMussvL1Wti3HDCQTYkfUjFn8CHkdLbyhVGgjnNDLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td5tkeVrd+dF4QVMU5Cz+ehwGRi7qAOdqB55xP1Vayk=;
 b=KwCPv2kJO7QGk7Q44R90n7W+XL21wx4lu2wpUkkH+0tdHhW4GICWlGAg93nJ2Y/oUf7GnmqHzsoKcmqgzGr3g6KmBuFTXrFPWaVNb4PPu69DoFQmQr8kPrAaGamhhCt5pQL2WQKAgZU7xmIQLTUEk2EH/T0+kAULjkbiIbc7gbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:15:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:15:42 +0000
Message-ID: <313d5ffa-2c00-202a-3e0f-8e82d9d0410c@amd.com>
Date:   Mon, 3 Jul 2023 21:15:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] pinctrl: amd: Use amd_pinconf_set() for all config
 options
Content-Language: en-US
To:     andy.shevchenko@gmail.com
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230630194716.6497-1-mario.limonciello@amd.com>
 <20230630194716.6497-5-mario.limonciello@amd.com>
 <ZKM_Ltif-L59Jo34@surfacebook>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZKM_Ltif-L59Jo34@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 3602a8ed-71d0-46b9-fdbc-08db7c349195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+0sWtycpt7QZPgZWeUnxYl6IXbkqlCj1G0rd80rv5gQA29DewlHxW9gqC+5emQEmG1cq2FL7ps0KJIS3UqQtUI2QAsdyR3VhYvBf0oeUkF8CdyDRDehnn9IMC52jTx6t8QFflkTIcT3dQZebGuMpCo8C3SFtRkjP64JTo1MXdGMzWxKYn0gGteEhqCdkh57CACvTX0+9XG9CI2kunoAJtmQo6ceUcdQRc/9T6Kf2Bhb/TBI3b0OiyDxDAZJkbUqMB7lOdjOJ8k219zrbIWox3tsrv1m1ZZYWpS70Rqi2gYdETQQ0988cd0OEX6V8JDm/qYHZl0N5FqRnnAYmHWGVmVCTBynixZBo0fb5mhDcFYqKYP4NKzbxGf/i1HoFdyT/Ccx3aqnbHs/e6h3BPq8Wf9YstTWJRZXnmF/zy4VJ5cGZHoQFSuKP8tK0XJvCoUQgSxg2rUPOM48gzKNCT8ewHHN/ej8QS6mL8tv2gYDuPz9qgOz0lerpt3X1OH7QOvrn2MDUxFfNcD2OzoHjAqhzUE7Ph4QG4URoSDaetcQNH2VcBTIKVNR/jqSaRN03HWwbIe/+nlFhPTATtSkkvZDmvlg7jmulQyzoN26mjj8evfvqEUWe48TcEzZVVG5OjxfHSe/gM8zCld2AR5DA8wLLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(44832011)(31686004)(4326008)(66476007)(66946007)(66556008)(316002)(2906002)(6916009)(478600001)(36756003)(8936002)(8676002)(5660300002)(41300700001)(31696002)(6512007)(86362001)(6486002)(38100700002)(53546011)(6506007)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmtmM01UelRWNy91TCsxNUdLaWdlNGVrQi9SQ1VHWE9sUjk1NGlaNXJ4cGFw?=
 =?utf-8?B?cWlQbzNndHd6bHBRYUhYR2sxK05aay8zdG13M2ZFNTJVOS83SWZXTTcvRmxt?=
 =?utf-8?B?TkIzL1E3U0p1WUViK2xjWWZUb2doUUd6WGNvdHRlY0tzYkFVTlltYkpsbWdk?=
 =?utf-8?B?VTRCV29yZzBMUFZwaCtFVFBKeW9ycmpOUUdvOVA4WTFVL2hKNXc1U2NHWUZq?=
 =?utf-8?B?UVBnNW1NZlZ1UEtJYWt5SHhRaE8wOHVOb3psMk1Sd0N5bXJLZzgybUk4dlBJ?=
 =?utf-8?B?K0Yyc0xYMFZVOWpqTGxTeVlEc1VsNjBYb1NHMjJ0SGtRdWRRdUdab1V0d0ZY?=
 =?utf-8?B?RXhFbHZQYjhBbG0zYXhTMVU0UW14eVB4K3l3eFpuNXhtalNDRWQ4TUdYTk1a?=
 =?utf-8?B?dlJoL3ZPbWdRVmRXVXM5bWtIVXlneE12OUIrcVdQSUwwbnNzbkRCWnJ6aVpj?=
 =?utf-8?B?azhYL0QzczhrUlYvT0cxWVVIYkU2K0JGclU1Rm80U3J2OFlkVTVtdE1jemY0?=
 =?utf-8?B?SUtpMXROZ0lvMCtZYW9LeEVTR053TlFHZXdRZlB6MEIrb2lBdFFveVU4QitP?=
 =?utf-8?B?MVpOZXRaV0RteEpIV3BtTktHU3dpK0FUb0NIWFZrTnRMZ2F3TG43U0NmM1Vm?=
 =?utf-8?B?bFFZemprazBZYnd5WTczc1ZYTGVCRVh6TDREVGNhMlQ2TXJYaHhQYnFSN1g3?=
 =?utf-8?B?YS9GdTBqZ0gxbGZmZTBnQWJKTFFOWjdIc2FrSjVhNUF0WUFib3p5MXhqU2Mz?=
 =?utf-8?B?bkM2ZHRpMEQ2VWh3ZzBlc3k3ZnZrVFM1aHp1dVdEUGdNUklsQ1plMWJXQnVD?=
 =?utf-8?B?L2swWFMrUldBZ1JyZDlSTjMvK01DbGFwT3FnYW1EN0FDNVh6aXpXMjJXYUVH?=
 =?utf-8?B?ZkJ2WFhEalJaQ0xBTnQ1WG5lWEVLTFkycEYxR2hXaU05VzV3SFFZUm5aR1lG?=
 =?utf-8?B?K09POTJnS2hqOU9sNDdWU0g2emFIek9FMmV4SFArbzFYblYxSENEbEZEWGp4?=
 =?utf-8?B?RmRHM3dlWklSVnhnYWpxR2o2aVdBd1ltVUcyTGpUR2NPamFXT0Vhc2poMzRu?=
 =?utf-8?B?eC83VE92Z2o1eCtTdnA4WGNsTVFGcHlseTRZVjB0MXVXSVJqZk8rK2FDSll3?=
 =?utf-8?B?dDVSY29ZUUIweXZ0bkJsYlpNOXRodHJJWU5iSDFvbXlZelFxSmtmeldhbGo0?=
 =?utf-8?B?c29kb1pNVG0zN2RlQ0VvS21SaDZZUFY4dzRZWjVOVmpxVC80UEZnVVZWUDBU?=
 =?utf-8?B?UXpoakpMbS9VQTlVYXdFTXhlV2VxVjE1SkdGR0lwR0locmpSL0lsaG54Y1M3?=
 =?utf-8?B?R0NjTWg4dWsyNWE4MjFFb1A4MTZoek5UV3pQY0hqZXBFOTZ2QzdMVzBySnBT?=
 =?utf-8?B?R3BwemRseGZvNVIxWHd3alBwOEo3eGRZSllZeGZoUFI2Tm14THAvK2IvRW5U?=
 =?utf-8?B?eHo4V2RjZmZaRElBdDV0RmFJQUp2Q1ZzV0ZVaU9kZTNVWnVVVVVrb09iS2tT?=
 =?utf-8?B?VlcxWUZVTk54YkZnVUh4RXVYTzFJSGlVL0Q2NUZ4aThtejFaT3RKbzNoa214?=
 =?utf-8?B?VXVrU1VzUHhOcmlVWldsYUtrNFZaQi9ZTUdkaGQ2YzZOSkRReXh0bDRLNStD?=
 =?utf-8?B?ZDZ1cW1DK0FlN2wySURacEZUeEdBbmx4QWtoMFUvRWQrM2FOaUg2bXEyTlRC?=
 =?utf-8?B?bW93NnFTSm5GSDlOeUo0Q0R6OThBN1lHV0lodkU0L1hmT09rUk1YdGYzSVlW?=
 =?utf-8?B?VDU2dlJJaXY0OFFLbDNLZlAyYVpPVitEMnpWUjZ3VnlOeTJrbzFyUThhanlS?=
 =?utf-8?B?T0VsdnRmQTBGWC81UFZ2YWFkdVk5MHVqVVJuS0h4TEJvaUlVSm9BZmpXRFZ3?=
 =?utf-8?B?WnRITkRJMkR1bXM1UjZrNTZxYldvbDZSZkVVOFk3bnlQNmUvdnpsbWZMdDNV?=
 =?utf-8?B?ZjI4QnlmSFBKcW9XaGE5TW1qNjkvMlZnNzFUaFo4bkVuSEFCQnlKek5IdHZy?=
 =?utf-8?B?aE5SZ0gzYjJMYnRYb1AzUlhTOTIvdVlqbzhjWGdwRHp5amtzeUU5RDkyZGJS?=
 =?utf-8?B?cis4TnhRaEpMR2d6RjRDQ1I1d2ZQTnkxY3hVSGhvaGFFQ0UvMUFQak9WNVU2?=
 =?utf-8?B?MWhRcUNXWlpacnBHK0xKekFCQmJSV3A4OWNXU2E1Qi9mRE1aUHV5aEQ5dUxl?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3602a8ed-71d0-46b9-fdbc-08db7c349195
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:15:42.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzPXp8MLeFXvbWuH5QY8Xn56GUtS7oXGfAyp5YtPTI94vwk7dBTHIloKaMpxTvHHsk3RovBEKx/YXParaoisBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 16:35, andy.shevchenko@gmail.com wrote:
> Fri, Jun 30, 2023 at 02:47:16PM -0500, Mario Limonciello kirjoitti:
>> On ASUS TUF A16 it is reported that the ITE5570 ACPI device connected to
>> GPIO 7 is causing an interrupt storm.  This issue doesn't happen on
>> Windows.
>>
>> Comparing the GPIO register configuration between Windows and Linux
>> bit 20 has been configured as a pull up on Windows, but not on Linux.
>> Checking GPIO declaration from the firmware it is clear it *should* have
>> been a pull up on Linux as well.
>>
>> ```
>>                      GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
>>                          "\\_SB.GPIO", 0x00, ResourceConsumer, ,
>>                          )
>>                          {   // Pin list
>>                              0x0007
>>                          }
> 
> I beleive we do not need so many heading spaces in the above
> 

OK, will fix it up.

>> ```
>>
>> On Linux amd_gpio_set_config() is currently only used for programming
>> the debounce. Actually the GPIO core calls it with all the arguments
>> that are supported by a GPIO, pinctrl-amd just responds `-ENOTSUPP`.
>>
>> To solve this issue expand amd_gpio_set_config() to support the other
>> arguments amd_pinconf_set() supports, namely `PIN_CONFIG_BIAS_PULL_DOWN`,
>> `PIN_CONFIG_BIAS_PULL_UP`, and `PIN_CONFIG_DRIVE_STRENGTH`.
> 
> ...
> 
>> Fixes: 2956b5d94a76b ("pinctrl / gpio: Introduce .set_config() callback for GPIO chips")
> 
> Can you group fixes at the beginning of the series?
> 

I'm a bit wary of this because the other commits fix it so that debounce 
handling works properly before this is wired up.  If I put this patch 
earlier I'll need to make sure it's only used for the new options and 
not debounce.

But I'll think about how to do it.
