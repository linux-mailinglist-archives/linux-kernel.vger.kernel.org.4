Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841C6809C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjA3JkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjA3JkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:40:06 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BAEF91
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675071580;
  x=1706607580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GK5nfVUPpDDOvgLVU24NBLX1MLI8LDGrI/NMS03B804=;
  b=f+pkK9LB8HR65yQolrAgYM6CsXZ7Z7DMyuP1wlov6+zm//uMpPYcbsY6
   GsGArbIvX91l+dylknh26G9Bb1Lb8f6hYt8wKkkSq3pe52r0/9wR2RSqw
   4Es3KSH96+s86tuWcxJ8T+l20xnBORmkmF6ILsu+mILe+iQwWJsGEMQCB
   qiBLKRxdVFG0X1ur/6veBocNV2Vb/OExOmxML4Xs5nsjCE3Hss27iQbTm
   +K1cyR+YiJmCNHz9wd0/GEVwIDpCrmDaDteWCmhlE1JNTo8uSUP1PftlF
   lcU1CEyykK9fCuyI+3bLh+WCV/0UU4mZIwPWpHMqJu+iz3bTk3DJY8bWF
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ/T8us88xiztlos9U6JzmI4b2hvugBE98MCUSrliHWQ+BjALOPUS8rGqQS+ItkHivrD04gjtCiWqjNu+03dqIGa8MMauvKoK9ihdkjeDR2IWZhv0klzLv4k0y1ceXXUlp0GlFPeinqTwcWr6EI/oLBHO8WcaF+PDvUUmk/1SIfEAJZXsl7+ir3vOF7tISvHEa311dREa2F2Q6SmD2xrUmAuFgolPELLk1N/YTK8PiqnxonRJNmCjwf9bAy+kFzgDambYr5aTj0/kfp1Wz2Z6LkZc3m4yBtUO8db/5pVN2BH4IqMeSWdHpujcB6T4tK51uFCNlJWGq2fX4Xwn2HV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK5nfVUPpDDOvgLVU24NBLX1MLI8LDGrI/NMS03B804=;
 b=cM/HC0jIe1DxR3YTn0ByMS9ZC+fMmOoUK6oEG/Szx0Ww1cBQ7Eb1X96zmePNYeuE2zY5XfTu2Lalo7uC2kORr8kJ2UAgnAK1wuUdWBB6JH9Z1wIRh/5tVh4gWTexOJ6dkPoRtet0ubn0sAze8GpsT7hpebPGU855Z1HP7KsYzFGEvT1kEr/pMKGKGoHAOmN0xaFRP8vXromY/d4faVzxP7pBlBpD8Nrm3KuKkO0tFLFdU75Yml4wnae6lmqnvKi7AQAkvV/JsyMOdhSzrVGta5XuVcf0CAAdi0AGPDR8bNJ2OPNvku4Wq46zKlm3odiPOhwefgJ666UdTkUl2vZ9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK5nfVUPpDDOvgLVU24NBLX1MLI8LDGrI/NMS03B804=;
 b=L/ascvr9N84z0bKF+Mahf2eb4cskR1rPEaYmV43Ri8jWmsS8+FPYQgiObscYz/8AzLjpuuiFQww4XtAfKxpitsPCAEj/qlB2t8wgXga/Q9kRNyB0CpBHPjZzjnOxdg4of6BrJUXAqZSMfPk75dGqEuTcFriRP34PLuNSpZ9LfEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <0177c346-d969-f8d2-6a31-e3ce570c8251@axis.com>
Date:   Mon, 30 Jan 2023 10:39:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/3] ASoC: simple-card-utils: create jack inputs for
 aux_devs
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Astrid Rost <astrid.rost@axis.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <kernel@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20230123135913.2720991-1-astrid.rost@axis.com>
 <20230123135913.2720991-3-astrid.rost@axis.com>
 <Y9PBZjkW7Nrsg4j9@sirena.org.uk>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <Y9PBZjkW7Nrsg4j9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0042.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::7)
 To DU0PR02MB9467.eurprd02.prod.outlook.com (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|AS2PR02MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a3f2ae-e255-41ff-f0fc-08db02a5dd07
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peHVtdPMRKFTZQIawFwo9Q5Kri9mUOqKsmtNw5M2B27tB0ZK052v37QvBjEGMX1+/bIB3d9efCcIOtoXqPKjnDlD2uIeVlNthuHIHO/L2+IMhb4NHvPW2nOwhe96Gz36Po4d0cV2D9fDlGhTdFptipzdzejwOknWZKFbvj7qN/Gx01hVWALvgAwR9+aD5/PbZlNnRHRaU6LWfLEJFn9ft7pmq12bz+gNuoENNX7YuGQEI+vVQKFtKFVAzQmlmhD2g0rk4wug6ANXxWvpkMDcZGYP8J+3Bck4Axj0NV3LdLNIU2zmv6A1Ram51RSgPvzS1shzbJRcbmRW+PqynbQ9fvV7azoERJTCMlAa/oQoHNAK74zosrLe8AqaLX38HcJYausjHcMOGvQk2rCa+j9cgPbqfKqqguTfoNsTGsCcfe7kkP2TpApowL+O1H+0p9Lq0m08LqVKtPdfSD5ifdnEbLR1sAIq5vPyiee4T2gBPCXMF7/pwYxvqZkHPG5MS3QPUFb+SOsPt1YtRgydBMWKG3IQyVyXEHV7cAKOA0lERUQz4TIApVSKARbighMDWiIQTcFa5IMupFH0UaujthdkVBrMcATET8edGLrTKqTXGuJ6lvq8mjBHbtFfym3Q+b+0KamUOD8U6oI/U2utXuGIsQX0FsiQ5Drij/QcOPvB4Hx8Eh4LpCoaW8Db4vLKzBjDBQXK0UOxTcWwza/UYjddO5V+1u+29NLDvS4B7UBy9vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199018)(41300700001)(38100700002)(54906003)(110136005)(8936002)(31696002)(6636002)(5660300002)(316002)(2616005)(36756003)(2906002)(83380400001)(53546011)(6506007)(6486002)(6512007)(4326008)(26005)(478600001)(186003)(31686004)(66476007)(66556008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFnczZuS1UvWXA4WkFVUmN2RTlQekRTR3RLVVYzZGZqUHNzeWV0RGN5MVAy?=
 =?utf-8?B?VFp4TVU0VFVHdDNYZ3hxSnR5R2tTUStnVithZHlENlVWQmZtOFhEbThLdm5l?=
 =?utf-8?B?L3pHYTJCZjNZS09xTkJpTUo2S3FGclpLVm85dG1XRzExbzBqeFUyKzJYcFJm?=
 =?utf-8?B?R2FFY0dSSTFTcWhpRmZoVzdvZ3NtcDVuY3ZvWWlKVlFKcDEvMXgzUTM2S3dv?=
 =?utf-8?B?SmJyZU9SS2JtaDJ6c1RtYWJKQmtTY2NJVldWbCtycDIxVTZYNUF6UUpzR3li?=
 =?utf-8?B?M1JNQlNydy9KcVhLenNPZU92WWsvd2h5Zy8yWGw3NFBZZUYzekg4Vk41aFgr?=
 =?utf-8?B?WEJCOFJPRzVUZ0VaWGJkamJYOHhoT014cnh1S0haT0d6amh0TSs0YlZhdjRF?=
 =?utf-8?B?Q0VUVTlqVnIrZWpFeGtqdmc5VFgrbVA5MVRCTnBlNEpDK21BK25NVVlpYThW?=
 =?utf-8?B?Y3Bzb01Eclh4emdFME1xOWlldndERU1kZzdlRTRyeTFLelpRRlo2YmFYUTF5?=
 =?utf-8?B?K3Axc2pKS3NtdDIraXNmWG5XaElRR1J0Mk83MUtxRlBDQXprcEtiSXFQTDMv?=
 =?utf-8?B?NnVGbFN4elBqKzJTUTBUU0RhMmgyUlorNDhYcURHQ0JBTmFKQ0dGVlpKUll4?=
 =?utf-8?B?S011ZXlnMFhTL2ZjUkxtcW1qa240M1JuVzlNVlRpclc4QTFQUTRHeThDWkZY?=
 =?utf-8?B?Q1ZGYUJVNzdrV2Y4VmRFOFVlM2E4d1RkYkFRamlRdUs4b0daMGFDQUoxNHFv?=
 =?utf-8?B?MDVsQU41TDVodDdZUmpZYytXbTk1bys1U1dOUHljTWFia3UrdE5IaVp4ampJ?=
 =?utf-8?B?OVJmeHpteVZORWpBSi83TmJRaTVIM0xML1ZWQzJMWnpLTHZReHo2MFNNeTVo?=
 =?utf-8?B?M2tra3VOcDJHL0Y0eXNUeWpjUTJHSUorV2RaSWJmNDN0S2dMV25xZERzdFdU?=
 =?utf-8?B?VmRMQ1dFR2JoODI3dHhjRDQydVNvREtIbkYwNlczVXZ3ZkZJTFRZR2wyTkVt?=
 =?utf-8?B?OEdpbEZjaStiSlJvdlNFVnN3eVozU1ExdUNkaXgyOWlpOFJTZjJtQ0JVbTBl?=
 =?utf-8?B?NHh6RURZSzhlUG9ZU1c4VUZvRDNCMm4wbHRneHRFeWlqSWowREZDcVVPSE10?=
 =?utf-8?B?WlhGZGpEVDQrRk1TWWQwc0ZDemZ4SkZJbnVWNnVaT20xemJtTDVtSmhsaXg3?=
 =?utf-8?B?NnJ3QW9GNHVTMVNmWHVxVk1qTUd6VDk2bDk2aUR5STU2cTBVdTY2UmUvc1Y1?=
 =?utf-8?B?NHJ1cmVIb1l6ZVB2ZG9Pd3gvcGp5RlpuTWlrbEU2SExNWGo5Z0VidGZiU0Vz?=
 =?utf-8?B?Smh1L2Vid0dCRUZCcUNGL0NXYi83ZGpyVFZnK0R5eWRFeWExcXljejRCbkZ2?=
 =?utf-8?B?UlBGaXMxeWJPZ2lKRG1uakV3NDNnbE5XZjlpUm90b2NlbjFFaGloMEhhT0Jz?=
 =?utf-8?B?K3F4eUxlcXNVNjk3T1J4ZVJpdVFsWFZFeExXQk1uU3lGL1lCa3hMbzdoYlJL?=
 =?utf-8?B?NnNtQzVWUGlkUHZJVEkyZGRjOVhNRnFDVHNRTm14di9UV0JELytBcWVmdFBG?=
 =?utf-8?B?cWJMRlN1Vk9xN1E1OS9IOG5mcnFxNjFHdEkyWWFXR3Y2dmF5K09DYnNBUXV3?=
 =?utf-8?B?Z0N5YVhoT0Vza2JTbjlKaGFQWnBiZENGekpqOWpibUlab0hldjZzTW1BYWdr?=
 =?utf-8?B?eHVpdHBWMm9qSHZwY3hOd0w3R1JRMjNXZ3RwQ0Q3QnNQcTdWbkhLYWc1TUVK?=
 =?utf-8?B?VWwwdGJBZk5DeFpxOEw3cGJIUnFXMUJhYWJ2QXBQa3o1ZmJ2YjlCb3I1dk9j?=
 =?utf-8?B?OURTdis3ZEw0WUxYWHYyRWwrVXMrRkVEOHZ5ajVUQzVoSXI3cjFOWS9Rb1Jv?=
 =?utf-8?B?c3VwR1dHa0ZWQjB5R1Jpa2FiM0hucEExZ1hqek5jMW10VytQVmVpcGNmdlRo?=
 =?utf-8?B?NmpoVmJBMHltdlBXWXlwKzlVUHY1RmdNQkN5aFgydlBzenpIcHY3SGpWMGxR?=
 =?utf-8?B?SHY1V0ZqcVUyK3V2VHJmZ0tnRDFTT2YvaSt2bE1neHRtZFcxVURyUkhZNnhT?=
 =?utf-8?B?RWNrOXlSM1l2MUQ0dVJxbWpWRFB6TGpaMUcxQ0JDTkUrRStKQXZEVlBNZnVv?=
 =?utf-8?Q?4rVKoN5aUBY9nW1R6wKACj+AH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a3f2ae-e255-41ff-f0fc-08db02a5dd07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 09:39:20.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpGw1rvw4yy1vJGHk3uPzSi7NTYhkCtbb+3lPwDqJ1NaY2wJFhBmAkM9OEoX3fw8VlYOsVDUpaV+k4fF5nCe6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9291
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 13:19, Mark Brown wrote:
> On Mon, Jan 23, 2023 at 02:59:12PM +0100, Astrid Rost wrote:
>> Add a generic way to create jack inputs for auxiliary jack detection
>> drivers (e.g. via i2c, spi), which are not part of any real codec.
>> The simple-card can be used as combining card driver to add the jacks,
>> no new one is required.
>>
>> Create a jack (for input-events) for jack devices in the auxiliary
>> device list (aux_devs). A device which returns a valid value on
>> get_jack_type counts as jack device; set_jack is required
>> to add the jack to the device.
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   include/sound/simple_card_utils.h     |  3 ++
>>   sound/soc/generic/simple-card-utils.c | 49 +++++++++++++++++++++++++++
>>   sound/soc/generic/simple-card.c       |  4 +++
>>   3 files changed, 56 insertions(+)
> 
> Given that everyone is really supposed to be using the
> audio-graph cards for new systems this should be hooked up there
> too.

Hello,

Yes auxiliary devices are very useful, e.g. for GPIO. I can make a patch
for audio-graph-card.c  to add it.

Best Regards

Astrid


