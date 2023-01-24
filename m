Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABA679368
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjAXIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAXIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:46:29 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2F3FF04;
        Tue, 24 Jan 2023 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674549968;
  x=1706085968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rIFXRJkDxnn/NIHZPJxMOg1bSANwp2hISXwHcufBfbg=;
  b=Q8+ywArBAllyy2HGlwC0GVQvzw/nPlclCNG5fmXE4B0UHVwZM2YbYlV+
   gDzfHlCEOiJzWycKUnBJdsO/8lC65ur4W2hlZDefHxQfgwpVojgvMgVoO
   boq8NbJ55URtjqVBHCwdFXgywqL7RueXyefZZuKXXbVG4vqxGBmp9QIR5
   vw18+MKn1e8BNTlbwRhJVUeEqklrm6I5R1CCIy3md0J8sHfFdMkYLTteK
   5jUsz1VsucWtCQS+dZufhW51mgPu8NRxG7/AFOISBCZEWo3kLKxivKqQb
   q8HQmRT6mdWBz5oWpILyn0dG8goBrnkWhf9z8VyM8X1oTi8S3oOQGMmXR
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnNWoCpUx0CZ+LjFpG/dR/wwwnHAPkxMCI7zLcvxAMm73Aa8dXNhuqIvNMelb85/D0YG5OKkgTgDhxxbvK3nL0Z0SdT9W9QPa5EZAhXmpDp00sWrH/KMI/QupCBl0Y7m7esZLfHfh41dIFJbSiEgJ1Pv8uMIbjIfDOPq80ZtQ73T+kQnjY4U9JgAiQktzlfyGoAk01y7lCyjN8i6y0qLeb4hYGJzRE7HRxlMShlh0mIQE5VCFYUzW/o9MyRmNiTqNYBXacZNoFp9Qop9y8DGBjBbjFkJjByMjUYYutQytLCpbmP36WBJPB51kc5dcnilmyar6UIU4ngX0pjiPOdKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIFXRJkDxnn/NIHZPJxMOg1bSANwp2hISXwHcufBfbg=;
 b=PfLuEXqDg8hZcim5T55S/x3z64THd5eJUZMJe6GJIpsmvCoH+IgIBxzuyXimynOM3FLSpHFPEK1pQPCDEAnSZOszIFPGq8Wx7VS4C1i+OzhmVg00TtqUI5p8uK3KLaMpLpSAaEPXL4R36CNZPBbipTt4a+FG6zuwYjPON8WB5JCysT/2Q+0rNaqIAfoBKzeccQRa+NRdEvdlR6RrUdf4Rs7OQSuaz7Dlrs82uw1GhqhFhwbBxjfjOhSbz0zFi9Qxtdom302pEdBSJdq+W/ia4gs9BEdqNQ3xr4ESOzp0Hu/L7wVVj/jLyBL4F+8FS4CunhwmQ3w8xGeWqOmMtQC/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIFXRJkDxnn/NIHZPJxMOg1bSANwp2hISXwHcufBfbg=;
 b=agciCHl+DL+IqEcNSIOu3E4CyoiwKpVGcg56EuDCtjKbarXHiQdxJVuSl/H/iWYIVwiAaVfKseUKGI2aJ1JU3GQqOosPqrqtMIL8k/1dbdKvSx6/N4xfg2ouQpCBghokP8gzapxiQBVW2C0gFRLuZWpBtgApWlsK8M1y9IZBuH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <6dffbda3-2611-2b4e-3ccd-7307b015991e@axis.com>
Date:   Tue, 24 Jan 2023 09:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Astrid Rost <astrid.rost@axis.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>, <kernel@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230120102555.1523394-1-astrid.rost@axis.com>
 <20230120102555.1523394-5-astrid.rost@axis.com>
 <20230123220928.GA2720169-robh@kernel.org>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <20230123220928.GA2720169-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0103.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::17) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|AS8PR02MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a75cc2-e0ee-4758-424c-08dafde76d49
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEILKtHbiyTcNEf3ESB38tQAiYX18xqVqwVRDlyVJV0rJwIeqw7mG2uFydr40b8lbta1ax0xFfw53Rch9NucqD8w1CixwWngO7ocYxf/JCSudyTNgyefeMC+Ja4vNFhvyPEB7srOTpFw4rFhOYZfy02j5hGjvdKvDw+eYHykwg1qP5sriVcpxz055Em0XOGDC1VSaiTXAhw4OWGvImmRd88gkVj1o7cz2N4hAZ0tbH7P8OgHIwAdzpvcXTUqyEa7ETR+DdmWlWLDfbLfPB0JjOQpRBztygeorzwNgav4lgfP6r04zVafWE6sW6SZ0U064XDUcyqXnoyRse22IIRorBtqFGlB28ZJK7gBAlIbWoAINODggDjUOnUhKxbVhIKX/NzFgd8wjSB1z5wwLCDOVA9E5jSspF8JoI4DMqbgzoYxY79VP74Xwr4cNag4EO+/Wv+AsT9DBsogBqMRCe1A/7gEGmVSuShVSx4fFxiH/O905A/KjmFb1QOFdMZBXLu8g3P2u64I+4e7TPUJowLpvMqGOJTk7phpNWuhOe8qUNKTYwltGcCf4mowy+P88zP3CHa0zs+8uAsMrrnPiqMuoqP7x/1r5+7gCPyUbFfzb6nvt61zh4QAo3liLIm7mPi+aWs2ofLZttNyC9xbhvx6S2P4lOSSng2UeCvpyHjLcbmpzyrsLOs9Xnzn4U4HO/2DpGlR4m+zED+yIFwR1fdgYz/gGx2DMFw9UuZaQu/Rqfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(31686004)(36756003)(5660300002)(2906002)(31696002)(38100700002)(8936002)(41300700001)(83380400001)(110136005)(6486002)(186003)(66946007)(6506007)(6666004)(66556008)(53546011)(6636002)(26005)(54906003)(316002)(66476007)(8676002)(6512007)(4326008)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNjK1VkU3dMMGR5S2JoYWdmRysvYVJUQklVYy9KUjNrVFdxdmVSOURnMUw5?=
 =?utf-8?B?TEJ6MWZwOEtsdEc4TkFwWFBONzJnWXVyaGt1Mm1lZmFUT0c5dkNsN0pCL1pP?=
 =?utf-8?B?WTErQnp0WE5YUkQ3ZWh2Ymd6cDdPSnJ5cFBCRytvSlZyelprSm9ramNLRVBq?=
 =?utf-8?B?VTlwU2lnUDJCa1grSDhpR1V1QWZ2aTFZaDlLdTVYNmJGQ1VhbFpHZkNMTkJj?=
 =?utf-8?B?blBDeGl1ZnFlQnVoNmxOd0tDdXhDUWJLUndubmdWMGtZNWpEMUZLQnNlbTVJ?=
 =?utf-8?B?c1BRZXdOSUZTUjBNek51WlV4TXovYTkwaDRvRmhkNXF6TFJHZHhlMFdJNG1U?=
 =?utf-8?B?dWw2TVorVC9XYmJzZzhtdUlNczZKRk1iWkp2Qy9mMEw0NHRwWlUvL1Uxa0tp?=
 =?utf-8?B?RS83ZlJ3UUhPL3hCRHAyTThDVjROTlQ2UkM0aTNUckFCeU02ZVVuL0lwa01x?=
 =?utf-8?B?NTNJNTVIZm0rb1NlUXNRak9TQXJvV3JUSWx3RHlpMUY3T29OMWZJNTJRRHRT?=
 =?utf-8?B?bHp5WUFnemJjRlVOZzRZODJJdWdUM3VuMEZBeHMvOUJtVlorcU1CMHRPMnA2?=
 =?utf-8?B?WUVtU01zcDBtdFFMZ05OcElNajdXWUlGSExNVCtjbnhiQm1EcEMyVUlTaTJs?=
 =?utf-8?B?OWIvU1JRRVFnQVpac3FQNjdybG1veDBUTm54T1NLRG1NenFhY0FjazJFQXRL?=
 =?utf-8?B?d0hwQUxiSVNTbVhuUGxnQU5oUEFlaW1YR2picHNPL0hBTXovMENQRWU1TkU0?=
 =?utf-8?B?SXNRc2hpbkpFZjRKZFprekNDVEdVWXBQNjBlYXN1ZFVqbDVQQjMwOGgvNVJ4?=
 =?utf-8?B?RXF4cGZWRWs5Y3lIMEZrZ2VWRlRLMjU4T0JlNkJIK1Vqai9VYTlZMzNNdThk?=
 =?utf-8?B?N1k2dzdMdnUvNVBwbWdLRlJhZzQ1a0owUWNTQjdtdk5hME1LN09rQ1hLT2Jj?=
 =?utf-8?B?aHVERmE2M2RjYlgyQkcvRXg3OXNXZGR2cERRbzZNUHZiT2pMRlRCWXNxTHcx?=
 =?utf-8?B?U2JhWFA3L1dkdnViK3RJY0gxajNNVkZpU2s4SEJYSytEZ05EMXRmWDlOWHlP?=
 =?utf-8?B?R3owMlE2VmV6VXNZT084alR5ZDNYeDFvQ2hnUzNwSUliNHBqQ2YrZmhoTmcx?=
 =?utf-8?B?cHRjeTJydWJFSkVIRW95d1dZTU8rdS96dUVnN3hEUEg1WU5ZeWNLdEpFQkdP?=
 =?utf-8?B?YmZmTkFzbzUwY0Y0WmY3U0hCUzhYZkpsZjAwb2p6RGVmZUtFZ0c3OGk2SFF0?=
 =?utf-8?B?NGlzS2tPbEdsdU13ZnA1Lzd1OTNiRTlZcVJCNG44NWpuS2w2TE9VMXpIZ3l2?=
 =?utf-8?B?b1MraHFmZDZHcUR2YVJ4RnA5RTRpOHl4RksxSUZ4MCtETmxlT3BoOW1MRU1V?=
 =?utf-8?B?Y2hlYU5PeWxvamtBcWE4YU8yc1NwdFRJcC9abWZURFBTYTk3UCtsL05nWlVU?=
 =?utf-8?B?eWpaNXNtbkRjZEsyblRBSGRTMTFNTmFUa2VjSjRtc1NJREJNcXkreXJDakEz?=
 =?utf-8?B?c0loWjd0MFBmWWg1Lys0elRScXh1aVI1cDRySENXS1IrWTBLREI3R2RuOXpp?=
 =?utf-8?B?ZmUvdlIxNlFmRmpsL0JLWUJ5aVRKRnBHeHZicTNUWDduRlhUNnNORDRiRmZr?=
 =?utf-8?B?R1MxdTkwbi9BaGlxSFFOMGR3ak8rdWpsVXhHOHlqVytmUVd2U2hzN0thNENn?=
 =?utf-8?B?djd0OWw5Q013ME5sYTg2eHF5ODFMOUhZS0ZIM0wyQ2hKWHgyZlJIS1Zla1JW?=
 =?utf-8?B?aVMvYXorQWZoREJOZVNjNDNZNjRwK2FmS0dFZ0VTazY2MXNITmlEQW5oSXV2?=
 =?utf-8?B?azVqRnhYVDI4MFlwd2JWMVFVeTVnRTg3WW5FRnVnQkViVFduc094S1dNYlZ2?=
 =?utf-8?B?aGw3T0pBU0VmTUNKem1jMnRITllxbjM5ejJ2d0Q4c1lsRjdVZkhWTnpvNGlY?=
 =?utf-8?B?ZmNDMXRIZzN1TThvMElwY0RMUEFRNDNRRC9tbHB3WW13ZHVIbzFkS1Fxa2tm?=
 =?utf-8?B?RXYxZEJMK1EyMkUrVkJiYjJEL0RQaUdjbFBaajlLdHd2SFF4QTNiM0l0Ujl0?=
 =?utf-8?B?M1BnTVNlWDFVNU1GRVJqMmNpbDJUVDNnZytnY3ZzRDF2R3hzZFJhTFl1dmMz?=
 =?utf-8?Q?d4UXsv0vU6wJR3jQUR3BrJPfO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a75cc2-e0ee-4758-424c-08dafde76d49
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 08:46:04.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMCw+xZg5mlLOCjZTDpEJVG+MMJkYQ7iB3mi4hXESh0ueY4TqvAcbKPJa71si4UpN+3OxWgx13S93319O44Idg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6566
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 1/23/23 23:09, Rob Herring wrote:
> On Fri, Jan 20, 2023 at 11:25:54AM +0100, Astrid Rost wrote:
>> Add jack-type: Bitmap value of snd_jack_type to allow combining
>> card drivers to create a jack for it.
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>> index 785930658029..1d949b805f98 100644
>> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>> @@ -27,6 +27,14 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> +  jack-type:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Bitmap value of snd_jack_type to allow combining
> 
> snd_jack_type? Is that a Linux thing? Bindings are independent of Linux.
> 
>> +      card drivers to create a jack for it. Supported is
>> +        1 SND_JACK_HEADPHONE
>> +        2 SND_JACK_MICROPHONE
>> +    default: 3
> 
> I'm pretty sure jack properties are more complicated than just headphone
> and/or microphone. There's buttons which are detected in differing ways.

Yes, you are right. On the buttons, someone would like to have an 
keymapping like KEY_VOLUMEDOWN, KEY_VOLUMEUP for the different buttons 
SND_JACK_BTN_X. This is always added to the jack by the ts3a227e driver.

I pushed yesterday a v3, which returns all supported jack types by this 
device. I am happy with this.

> 
> Rob

Best regards

Astrid
