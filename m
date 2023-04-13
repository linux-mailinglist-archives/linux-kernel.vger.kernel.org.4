Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191ED6E1609
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjDMUog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMUod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:44:33 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9483ED;
        Thu, 13 Apr 2023 13:44:32 -0700 (PDT)
Received: from pps.filterd (m0239463.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DEDNCj030473;
        Thu, 13 Apr 2023 15:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=2KFERxWeVbcr4GMkTCSwTei2dTuwJ7DtWjaCx797jvM=;
 b=UN+1w1bXWYJCvjLE9QMq9ZoCIEJh9EPacOc1Qjj0JhQt++iklciDiJiBjmUJcu+WGYy7
 7mHeCAdFlj2gHibHthW2b60Tnsh2y++8P+szgqq/8/2kRJthwJYaX5jfkFOOwFlDTwlO
 NDWgnRiszzFmx9a/H9bgosKAheLYeuS4P6XRJyRrJtnePTVDvolReQcQxQnNL0ktdXkn
 ebfKGxXnuDiuzkSBvTAehBN7h/ORpU+9J/3kpJGZMOINloWTperef0ObxzMIvmyWo3D5
 nBqDsGB8Q+9js0KpfYy92cz69mL9f688h9Ao0l4Xt9KimEQwG3+aW+QdojuNSLARlsnQ 5Q== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3pu3nf9y6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 15:44:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGtSOp2KkSviOuFA3NdRLSHXhd9hZmTwatGrCBkNWQYmS3tQ8bUKj+JOdBcpRhaC0vw7ryhmfbC6fFcyWPgWyLH5Nk2Y6iuOnHvxF8PMV1v8NrDdHERD2oDMBstUXbrtxCQVgIYmJDYlLzpwj2O1W1qIaIXSat+A30afXza30leIhi+j4gLGyebgwHrHx3AnvdZC5NNQt/yXKBdVO/xBL0fsssow+JEkWys6HO3h6AUdJJSfY+KS38EplodVHXgwcl5X2j0h4s6HZf8tO1WhPF16VmxDDWD8VYsR/DX2UD/ps+uU+Oh7DdyjZQU8aC26IQaXZKvroB0npB/9yCLgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KFERxWeVbcr4GMkTCSwTei2dTuwJ7DtWjaCx797jvM=;
 b=GJUQ1D4KOa82+pEMK1AMHlL5VqxlcdbGMubyrdaVqCvTtnR18GLv03T99ucNq1Fku79wdceIdeR+IBvgwZEeyKvvX12rAansYxnOiQmPeZWcXq/gREZX1xoJYuz51DZGEUIr8aHhVNdHrlSHESL8Z+OAoUZAX1u5H/BLrfibpBLieWtaAd+YSCswaxqJ/i5uhOFIusmTj124TBxWNWGv4qFqa2QorS0WHxHmBWytXzrWeDeUuFY99VE8oCeZqIu7FavchvyVuS8kixPuRWrrnsM+HHx12NmzPzYOsrqWYY0qjbeceYJGo2vHpn5c+xAjZIL2/Cfh80dy+JrhqrAoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KFERxWeVbcr4GMkTCSwTei2dTuwJ7DtWjaCx797jvM=;
 b=roqtojMj4QAMKF4blLTbW51vSbsIGuXSmpQ/0WSEknPGQVG3Kkw2p9Mg8cP3XsPQ4eOrDG5UZ2RhBwUR9ajfe/muhSXNcgl6kMhc3XBIXJz/o1x7gRQPgvPSgz0hv2onSZiuXqR5jWFbAgQrO9bN52QWDAJEQOIiLbaBZSu2h1I=
Received: from BYAPR04MB4966.namprd04.prod.outlook.com (2603:10b6:a03:41::27)
 by SJ0PR04MB7405.namprd04.prod.outlook.com (2603:10b6:a03:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 20:44:17 +0000
Received: from BYAPR04MB4966.namprd04.prod.outlook.com
 ([fe80::7483:2c08:7960:79ce]) by BYAPR04MB4966.namprd04.prod.outlook.com
 ([fe80::7483:2c08:7960:79ce%4]) with mapi id 15.20.6277.034; Thu, 13 Apr 2023
 20:44:17 +0000
Message-ID: <c7adbaf3-346e-cafd-e831-95f9c2900d13@ni.com>
Date:   Thu, 13 Apr 2023 15:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230410211152.94332-2-brenda.streiff@ni.com>
 <b2f81c57-9b7c-9ad6-6ce6-cc94703599db@linaro.org>
 <b92e2f18-4fd0-0510-4a85-36d7a200c9fe@ni.com>
 <6f9cfd54-c8cf-7395-e7bd-c350a06c8f16@linaro.org>
From:   Brenda Streiff <brenda.streiff@ni.com>
In-Reply-To: <6f9cfd54-c8cf-7395-e7bd-c350a06c8f16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:805:ca::33) To BYAPR04MB4966.namprd04.prod.outlook.com
 (2603:10b6:a03:41::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR04MB4966:EE_|SJ0PR04MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b245c7e-9a4b-4ccc-4029-08db3c5fd92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +A+ioF0SOFmyBkqp6fgZ4irhe6D8d0c4BKGEouFkeM9IWazjCC69lLVLHEj9eenh9rwz0TtzpFzjToPxOsl5TyoxIO/pC8nAYv0U+odvf1a9ivb6fhWQ28cJaPYGgeHte39vG/+vHtYBzKcZlZaSokPvF5EMfAxeXh8bCve5VIzc0uXjY5GWD5OScgvIqdhFjSAnPNFlgw8iOVgaBTSIphN25JfXapz4TMvv76n/3iq7w7NRiJilI+B7l/32ZsWiATGuP6Vnajp03V2Nv6/5TX2OrD5HH9yL1wEnediGmq2VS5MgafD1v041jbtNefTVMaQIDzr2VhKiB+4gGQIvcWcu9NHzzXp9g8g4gFe31j/la9jfbmVGJ2j+mId2PG77TqdnAfN1QPPEefKgSrA4CyjD0oWdqyRt70n9B78WonuofPqfTpSZcu6hH5XZOnn6b1BenfSr27wcpI70bowzAIss26yY8CKgmWic2ePV6l4sRUetqgiYCkYoF3y2wKCnZpZZYOZHtvsKQuo1fVL86FegM9RWY6CEcGXrnVf46ABR63OPqinJ9aYYQijpz/WfO1hmDpv8b24gIEzgo7xG4j+415kEAfwUd5Wk3b6MJ5ht325RaW0Ra5WeFThGvR9BQMF7jVaxTOLVrIozA/8z3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4966.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(316002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(5660300002)(44832011)(41300700001)(2616005)(6666004)(31686004)(36756003)(86362001)(6486002)(31696002)(54906003)(6512007)(26005)(186003)(53546011)(6506007)(2906002)(83380400001)(8676002)(8936002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpVOWFTSmxILzVYT1djN21xK2h2bFFtWXlmSVJsOGszWnliVVdhUTRZWktV?=
 =?utf-8?B?TkwrK24wTjJXUU9wcVorUjR1eE5VZUJ3M3ptWkg0N29JZk9wT2FMbVlzYnpC?=
 =?utf-8?B?dkVyNkJmSEpXQU1McjZoUGFSMWM2T2FzajJnOUdqVy9kWC8yUTJnRDhFVzha?=
 =?utf-8?B?bkhaYnlhMUJHb1htK3hKS2dCZ0FjbU1oWmE4RGRJeEdZN3cxVTdza3VmUjhr?=
 =?utf-8?B?MmRuOU9lWGxtTkgyRE91bGkveTRjOEpINndWMUJRbmJHaDN4dXQwd3pxZXBY?=
 =?utf-8?B?WmtRN1ZkaGRwc0pmZEI5NW1WZFI0dXR6K2ZBdHNUeVFEc2ExSTc4RklWdW9L?=
 =?utf-8?B?Mzc1aTN4cTJQWFVIT2RZZUhTMVcwdTgzb3Z3dTEyTStxM3RHSHRkeGhRUU1l?=
 =?utf-8?B?U01TRDNaMUNPeUJzN0JtUFRZeGROSG1HYnFucklVdlh3T1lqdDFMdkN5SWRp?=
 =?utf-8?B?TmhMc1BqYVAyYzE2aHhoTU50THhnelZmRHpuVVdRRUtxSmZ4QzJ3WDF2eVVS?=
 =?utf-8?B?dEQ3aXJFTWlySmxEQisrdHdVcXNYNm4yWkMydkdZRktLbExQSVBreXgxSnBa?=
 =?utf-8?B?ek1YblpEcm53cDB3WVZydGZObldKcnk2Y1d2Sko4a1l3Rmpzcjc1QTZ5eXlG?=
 =?utf-8?B?VzlxVWFhdSs3aWVxT1pmbXF1MFBYMy90cHZ4Z0M3T1BPVGNLK0NtcWl4dGhs?=
 =?utf-8?B?UHlGVmJQSUJqa0ZCcktBV0U3MUpBVG41dU9McE11alRGYjlKOTZSVS9kSUdn?=
 =?utf-8?B?Wno1RFVwYW80NFN6eXdlY0pRY1hWUlJhaUZKeThyQTU5UVBZeUxJV1dnK2Fj?=
 =?utf-8?B?TmhBVElIWUF4YVZjNlhEUFpkYXdVbFZpMnpSZFZvVmZFbE96QTJHVDhQelQr?=
 =?utf-8?B?ZkZSR09kYmpZK2NlbUw5UFdYRmk5OHViSXV6UERKUXMzZ2IyYTIxc0lBMjd1?=
 =?utf-8?B?Tkx0dHBKdjNFbjVDOS9yOEhyM2RjR3h1OGdBWUpwVytGeXptR0VRcEFRWjdh?=
 =?utf-8?B?YUQ1WDFTeUQ0SjFlK0ZscFNQQm9mT3ZvNGFpYk5EWWc4eU5Zd0ZWekp1TjVq?=
 =?utf-8?B?WkZyRFl3eU5GWEJjWktQam4zL3ZLWVlqdWZqVUoxRG5yKzJqSXFNQjVnM3d6?=
 =?utf-8?B?NXIzV3IrUEVnc0M3SnlDeVdEbThPN3oyQTJWbzVnbml0aUFwQmNmcU4rUzJL?=
 =?utf-8?B?dGpaT3lzQzRzQUVQTWxrL3FtcVA5SmhtaHptTitjRXlOTGM5QUxHYmpWNnI0?=
 =?utf-8?B?YzRQcksyeEpEaXdNcFNFYU40ZGtuREJHblZEemNqbHJVUXhJWWx4RFJqUDd6?=
 =?utf-8?B?V1ZhYmhURzMxVGZ1TnhHQUNuMmtyeDVBUUtISXpPZEFpUjcxS2RvY1pLYkZS?=
 =?utf-8?B?MnRLTWY2VzNkWjhQRFdsWW5uS0NJOGF1Q2VuY1Zod2ltQUFoQ0hBRjM1UlBr?=
 =?utf-8?B?d00vTGljTWMxaWplUjY2RVJ3dGR0ajhSOCtIL3ZuMDVQV05xcy95a0FOSW5Z?=
 =?utf-8?B?K09qZ1Jxb3JweEhqRjZGYktDS1c0cU5wRzY2VnNQWnZDUG9ydTUwQWV0Tlh3?=
 =?utf-8?B?L2ttN3ZvenIrQVJVVXhKZW1wY09qRkw0N3JYNGdMSURPTkw0alVXYTdtcVpT?=
 =?utf-8?B?MkVEdGQ2NklwQTc5ajV1R2FGTEdZQzY2UkoxTzhLUmRTQVlFS1B6dHJSVlFp?=
 =?utf-8?B?eStVT0JTRXQxYUF1WitBZzJqRVI1aWJLLzRzb0sxSHg2b0dvTjV1eW04cmZp?=
 =?utf-8?B?eWMwOHdRTklLSnBYaG1jb2hLV1FUWSsvVUsyT1NUQUphUU9vNDRmWDU3SlVa?=
 =?utf-8?B?VW5wamFlYytia3V6ZFlGaU05SE5kMEVJTVdob2k0RzZNK1hUc3Zob09pT1hK?=
 =?utf-8?B?bDV5TUtuWDFJaUJQMVN5d3BxYWR5Qnk2aUxWc3VMcVhzdk1IYzV3czRrYTZk?=
 =?utf-8?B?Tis5c3JJWVJYTzVjWmZYZE5xWm1ZK0RyRFFTMmp0aDhtTE5ZUTVaSmh5ZWpI?=
 =?utf-8?B?NFM1OExRZXlOWG1XSzFseURMSjRINjRwSzBQLzNadGl0TjdaaURIeUxrMnQ5?=
 =?utf-8?B?RnU5bVpBNzJFSE41a29ESGcrejhwQWdQbUEyWEQreCttS2JHR2R3dXcwVnFX?=
 =?utf-8?Q?6sNu5wECpeYmEEsT6AmH4w9M4?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b245c7e-9a4b-4ccc-4029-08db3c5fd92f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4966.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:44:16.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knx8LopxFxZHTgxa3cviO2BBz+5O4uCrFpJaD07L0z8MtaBAyvxX5RNGcWFvN1Jl7f/ISqg8s/E/XvAHJ5V9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7405
X-Proofpoint-GUID: WF9P1C2WWqPCANukWdvd11CgatdUDwLA
X-Proofpoint-ORIG-GUID: WF9P1C2WWqPCANukWdvd11CgatdUDwLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_15,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304130185
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/23 02:39, Krzysztof Kozlowski wrote:
> On 13/04/2023 00:24, Brenda Streiff wrote:
>> On 4/11/23 00:44, Krzysztof Kozlowski wrote:
>>> On 10/04/2023 23:11, Brenda Streiff wrote:
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-frequency: true
>>>
>>> I missed it last time - why do you need this property? You do not have
>>> any clock input, so which clock's frequency is it?
>>>
>>
>> This is the clock frequency of the UART; on our x86-based platforms this
>> comes from the LPC clock, on Zynq-7000 it's derived from a clock in the
>> FPGA. This is used to set struct uart_port::uartclk in the serial core,
>> as it is for other UARTs.
>>
>> This clock frequency can vary based on board design (especially on the
>> x86 side, due to different LPC clocks) but for a given design is fixed-
>> frequency.
> 
> So you must have clock input - clocks property. Once you add this, use
> assigned-clocks to get the rate you want.
> 
>>
>> Would you prefer this be documented further? I was following 8250.yaml's
>> lead here with the simple `true`.
> 
> I prefer to drop it. It is not correct and a legacy property. Without
> clock inputs how can you even configure some clock?

Configure in what respect? Software can't change this clock; it's
effectively a fixed oscillator.

In practice, this would always be pointing at a compatible="fixed-clock"
which declares a clock-frequency; this seems like "clock-frequency but
more steps". I can add that, but I'm not clear on what value that adds.

We also have shipping devices with ACPI tables using "clock-frequency",
so independent of support for "clocks" and "assigned-clocks" for
devicetree-using systems, I would still have to keep support in the
driver for a "clock-frequency" device property for ACPI-using systems.

(Is there documentation on a standalone clock-property being a legacy
property that I've missed? I don't see anything of the sort in
writing-bindings.rst or in dt-schema and I want to make sure that I
haven't missed the proper guidance here.)
