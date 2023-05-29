Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFF7145AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjE2Hlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjE2Hla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:41:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7DC9;
        Mon, 29 May 2023 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685346080;
  x=1716882080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F19/SFpQJc5oAQ66etE7pHXRIwd8eXZHPPq9izMg7uE=;
  b=fop0f1NttsT8yNxJusey73x43C2mmcEWorwoI18Fp4rD7adjLFYnqIAt
   NxPZ2S8eLqjvmhvpa1pKGY7VgmKFiO9+CnyMw+9yoMJ+KYcXMJlF8gnY3
   s2XpWg8AMPKPXX1Sq/YeK4Nnrsxo8Znxa7jmZYRLYzbjKkU6TVVHL9hPZ
   pH44I+CpdHLIBd5pmAxnq8rW293jeZMSG+1WDgZtF+Kc3NZsukxkafoOv
   kkHEnc3pVkPcwBdVFaguK0RqF3xyYvozs9T66n/OhQnrp7Ic/U5c43JW7
   gxAaS0KqI7qWA0UdBhPr2KBzlnkslgig9cldwgRqK/TotULstNmuEhvFK
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTsfPX0jVFZFc+H8scO0rT8KW3kCo+K+OYMHlg0rEsva0Ed/23BIGwejkMEv9fLiDA6r2DmATDAggeROTdU8x42qVkRdd5Mw7lDkB4HSAy/v8NSCbqnOR6sAwrTctZ4T9xzn7GQe8I+som8CNk+WP2RxPwes8zUhllm4KT+Zw1M0yzApswivrTlRoAsIC37ntC/4lTdp2C9ctFy6yEIdFSeD6k61bIY9lhV9sXrkapsTg4+sTi+SKN0FCfbGyMrTOYYALB8Sy5YgvjSExVwC5gAE0/tSnkhD/ZJ4qO+MKeUGnx0sUvPbIS2KhUAy2gTmmOI9ByTaANH6V/Ipnjerjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F19/SFpQJc5oAQ66etE7pHXRIwd8eXZHPPq9izMg7uE=;
 b=Cyn3CX3X07Tb0lbNS9ymbm5ynTyZL00SYlQR0e1gkwGaqHjoeToyTOf+70+XImJlFgZyblYfjz3fxfg23mYl+KhGmxvp0+JlBevzRubpE0Et37eSSCI7+o/5r3Ve+a7LQhhqLzhXhdjsDQMlLfZYxH9BIgOMQNUh7pmgC3co+AKwynqa0bw6Xtm2NGQqHXjC0XlmC+u+uW02rgReT2IK5qSzklikwg7NKBgJI6+agt5uc8rXO7S3tlo0oF0spk2KIbk5pSEdR88ETkHGFbbaUOpzPpRHoziURjEj1rna971S1uEaxIB3TjdaXPXb6K+UcpzhHjvpGKkMvhZq9WpmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F19/SFpQJc5oAQ66etE7pHXRIwd8eXZHPPq9izMg7uE=;
 b=MtDukFVOpLT7hfsMgRlR7rhF70prpkGwEAh0mDNupo4GjEle685O555tAl3PbfF7h7dNC8e1CZtJ/8p571v25bdoUTfFA8SgOBoJ8sFLKssCb/GdMWLqvE0FlELrGdpU7+wvTYAIoPzh/9FwAMK242gTIAkAKq6C3vd7k339eF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <ca146ce1-d3d3-e5eb-ac44-3afaec8ca6cc@axis.com>
Date:   Mon, 29 May 2023 09:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/7] iio: light: vcnl4000: add illuminance irq
 vcnl4040/4200
Content-Language: en-US
To:     <andy.shevchenko@gmail.com>, Astrid Rost <astrid.rost@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-5-astrid.rost@axis.com>
 <ZHPZlA5LM5h4xmp3@surfacebook>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <ZHPZlA5LM5h4xmp3@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|PR3PR02MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: b130572f-92df-4f75-1c9a-08db601814c9
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROku/K6/3U1G1fVujONG1AJVd6S5ca03D6V/FClcKpQBrGLgornsygHK2OJ7w6g2r85MXWchV6XJdEK+5Rv2AqJ63qrVN12HgVGoTazUl8TnyYb9zzNOnfzmx3lcwE1NrdoFjsPmYGX2tasd0OxNTxX4jVg15AamvmCvmB64fBM+sczzLQDmAkNtsdu7y/NdRFPOA5zvzc/6QpyAxKdZhZfD9LWTzfUnaSrD3NnYsUWHXk21X/vcq5RwC9khv2dNXRmmjXXkWZNkwSRmrLTfEnxez2pr1uR5VkEsc33ELZpXE4sowyE2H8mvevnYsAzmYwiGzJyjFS16tm0cZr0Va++VJDFLMjwNfNLJnz6rDCuOYeXi7szaO+GRt4VtZqQOdFFOg5IQ4EMJH58HoWXMAHsFliou29/a3IILw7cNg+3YSkcp2qi9u5OyN2ToB0p9JHzmWUCXoNzxudya8I4fFzv93JGbF68Y26T6Nx5pStWnss1nZoybwRcXMGJvrY4GxMjA80pO1rJi4yQVNrX0D0dTJ3g6L1TVmJCUWcmRsskfUTdOodfAopu+jhaltesgW9q6M2olah02sPOqgy0+RBIIcMvTXyXPeF87YqaZN6cZmnOyxYvDvDuMCa3dECEIHy1wB0aWul0ELqEovFymWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(451199021)(31686004)(478600001)(38100700002)(2616005)(66476007)(66556008)(83380400001)(66946007)(54906003)(37006003)(31696002)(4326008)(6636002)(2906002)(186003)(316002)(26005)(6486002)(6512007)(6506007)(53546011)(41300700001)(36756003)(5660300002)(8936002)(8676002)(6862004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9sZUNsRmVnRVloeWE0Tks1aEdxSXRoK3ZOU2xUMERUcms1MXhGZXFHVll4?=
 =?utf-8?B?OWVQVTRLazlBd0E1S3lEV2g1SlByNGd2dkNLMTl2bkM4U2VodW9ZYnBYM2gw?=
 =?utf-8?B?TS9nR09ZQXJMVFliaFBkdjZSdXg5RnVuMDFnekpvUnNyTjgxOEx1eWdZYVAr?=
 =?utf-8?B?cTEza2RQVXd0ZDJEeGVBRGRUVWIzRzNxajRxNVBCQm85RXYrV0orMVRCbExO?=
 =?utf-8?B?ZXlxZlN1RWtCT1F3QnNhNHB2RDNlZ3R0d0RIVFFCMVhUYTdDRUVZeVRDSGEy?=
 =?utf-8?B?NVNVQ0hPY1hTT0VVVHd5NWd1dy9XazQwNnN4Ykh5ZzMxVVhkTmdJZk0rSmZj?=
 =?utf-8?B?UG5WMktST3hsOGlYalJ5UmNtMVJaQitqaHF0Umc1RmVkV0VrblNtRTVlTmNn?=
 =?utf-8?B?UzVHMkFxeCt0SVoxaitEeURaYzRFQlJTR0hRZnJwRU0xY0NrVDk0YjNoem1R?=
 =?utf-8?B?UXI5Z2hiTFF5aVloVXBPbHlqMGxaczJRakp6NnR6YXNpWXFvcHcyT0lLQllm?=
 =?utf-8?B?UnIydTc0SExZNGp1MmQ3M0pDSVVSZ1BnUGlzTk1kQUd4U1RES3haVkNheDho?=
 =?utf-8?B?K2pqekwxbW4yeG8wVlIvWUVMYkw2cFd6T1NzS2lBaUloSTZlbEYyNm95UTdt?=
 =?utf-8?B?eFVZb3ZBeWl1WnV6UzFNbUJvU3dkUnpHYk84QjZhV2NGbkJjd2lQTy9jOC8w?=
 =?utf-8?B?eTIxWkIzMDNZc1NiMjN3eUgxSXVEeS9Mc0JQOUVWazNidmIydzYrWkVQNUlI?=
 =?utf-8?B?RzAxZTk0NUt5dENsanJVK0JTakJZWXU2TlhwSkFIdHIxeFk1S0svdHp6Qlc4?=
 =?utf-8?B?VElFblB4akluajBhZCtOTG80ZXpCZGRjVWhITHJENkRWd3V2RjBQZjBiSUdY?=
 =?utf-8?B?VmtVbzJ0NCtsYitRRFZQQ29mUkJZYTVneUdXU1FLQlhndWc0OHFMMVVyWXg5?=
 =?utf-8?B?blA0OHVjY0JIRnZpVWRFQ1JnZlVNOThTOGJHdGhLWTNURWFHY0N4MmNwb1F3?=
 =?utf-8?B?a3VKaHAvcWVEQ24rejhlRWtDL3pKaTM4NDB6Qjl3T1l0ZkMvU2hFTUtUTEsv?=
 =?utf-8?B?cFFoYTVkSnViRVI1N000UXFPNmlGeEJ0VlA0akQrbk5wbGNkUXduNmp6eGox?=
 =?utf-8?B?Vk96b2h0WjdoMkxqK3pza25WSjA3d0xXZ0lkZUt3Q3NGQWFxdFFrUGt5UVIz?=
 =?utf-8?B?SndVSllpT1BxUVRHUjJrR01LWnVmQU8zckNJTW5KU0lROVBudkpVU3ZJQ0Yy?=
 =?utf-8?B?UUMwLytMMmcrUStpR3N0UldCMmpqTTdOWVZCaU5ZS3NYTFhCZTFqc3ZnSk5z?=
 =?utf-8?B?WUF5bDFqdS80MTNSaHQ1VnhIQlQ1V2VQZFUzdFdscGpFbmUrR3pZMWRMai9Y?=
 =?utf-8?B?WDlMNDM3V0NUdzRTU0pkVGhielc5Vy9uS3lzZU0wQ1ZqR29QOEFmZUthdWVS?=
 =?utf-8?B?UVVuZm9mejcwWXdGaC9xNGlOamdaTm1RWmYwRE00cW1qenB1ckR2RG5GRllZ?=
 =?utf-8?B?T3ZPRUxnR2dUaDQwVVFTdzVnd3VibHVFME9zUENzTjdEWm1ESG03Z3ViZU1x?=
 =?utf-8?B?T1VoVmt0Z0RyYXpra3FRMWZNT0hNTklWcEN2VHA0M3dNQ2hNYjZ3NmhyeDJ2?=
 =?utf-8?B?L2k2QURIcHFxT2I3OUlyTTBNUXJub0NWaGZ5bFAxeVR2WXBJOS9ja0tES0Ev?=
 =?utf-8?B?ZFVJcUQ2bWM1T1lMMldvK3NaZnNsUUgyZ0lZaHNtTER1M0ZRKzFBVGdEWjJX?=
 =?utf-8?B?aVVoNTVoc0lRTCtsWk83Ui9IUnZ2RWNUd25CdUFoN2lSOHlDeGY2SnZzNWJK?=
 =?utf-8?B?NTJLZW9XUmR3djN2SlpiRlhXalU1ajJ2eUszT3padUI0TEgwSWg5a0dHR0hH?=
 =?utf-8?B?MURndVJvdU1TMU1OTm1kTUx2NHp1QTJ4bmdRVmttUHZyWHFrN1c0cWdrRWNT?=
 =?utf-8?B?M3JSTVVBbFhqdjkrbXc5bEFHeXB2ZmJDdythOXUveFRDRlZzbm5hVGx5MTc1?=
 =?utf-8?B?U0ZiRmRiTEVXUWZYQmFQR2tlT0R6RVQ1ckQ3MEtIRDRBVzVxVXlGRDZEbmx1?=
 =?utf-8?B?K3FiMzJiMzZidDNGcWtVNXA1K21qSFZvZmFremUwSXEyZXN3ZXlUSFlLU0or?=
 =?utf-8?Q?8+GA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b130572f-92df-4f75-1c9a-08db601814c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 07:41:14.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0vPSVjsbWsnBNGVUWHP0peU0Lw3osFtn6RBNvml4ynh450D9oupbabZ4SeiAtbW5oGGLvkV4ghjsQftlkFzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6315
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thanks for reviewing.
I can change this. But this is how it gets formatted by .clang-format.

Astrid

On 5/29/23 00:45, andy.shevchenko@gmail.com wrote:
> Mon, May 22, 2023 at 04:26:18PM +0200, Astrid Rost kirjoitti:
>> Add support to configure ambient light sensor interrupts and threshold
>> limits for vcnl4040 and vcnl4200. If an interrupt is detected an event
>> will be pushed to the event interface.
> 
> ...
> 
>> +		case IIO_EV_DIR_RISING:
>> +			ret = i2c_smbus_write_word_data(
>> +				data->client, VCNL4040_ALS_THDH_LM, val);
> 
> Strange indentation.
> 
>> +			break;
>> +		case IIO_EV_DIR_FALLING:
>> +			ret = i2c_smbus_write_word_data(
>> +				data->client, VCNL4040_ALS_THDL_LM, val);
> 
> Same.
> 
>> +			break;
> 
> ...
> 
>> +	case IIO_PROXIMITY:
>> +		switch (dir) {
>> +		case IIO_EV_DIR_RISING:
>> +			ret = i2c_smbus_write_word_data(
>> +				data->client, VCNL4040_PS_THDH_LM, val);
> 
> Same.
> 
>> +			break;
>> +		case IIO_EV_DIR_FALLING:
>> +			ret = i2c_smbus_write_word_data(
>> +				data->client, VCNL4040_PS_THDL_LM, val);
> 
> Same.
> 
>> +			break;
> 
