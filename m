Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE674F463
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGKQFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjGKQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:05:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B309170C;
        Tue, 11 Jul 2023 09:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrYeu2Cmk96WH/iqe9IUshMAa+jcDPo3ktamyTqG9tEMesACbuiXpJ7nD5sPuCzh0Twe2AScxFg3vKeQyjaaPvHUA+s7LCl3LrU3PQaNLKT6S8BpYIPJBaCNUE411esIFvb475Aj0MMVwjGSz1BZSv/SIkvH0vNPbhR2CjVB4/GmBuW6rHHElCjE7m/nTmZHsQmSjUnEhpxu4dNJW802B09+WtBOIuKajnwAaPWNp3oeK1QWxM86K8wOvOmzie8vd5+I3HPe2rvzl2VeRBUYVRGF0JdM2S9YlITULahsfR0+xOAoLo6gGJpLSzw6pDykUOrGX/cnwvh2bLab/zwqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L+ZdFhqdrtHeSjrYxQol7P/lIu4DeIa2Dn0lVE3IdE=;
 b=NQMaYcJQrJvn49LUcBOE+SxQUm2svbX4s7bvFL7gdBzvQeuvIhxq6coXERsH84afpUkQA1KRR4XVmzA5kJ3FCLsVl9FKUw3BCO8UzXlnA3HXE5La/wf4msVAVlQiiIQE9DDCgxwozSdxqNizmfiU6Xej/YGJ6JLAxGeKa49B8DdR3/tv0jGlcpi3OWOpY9TWFyaiaQxkvEdsg0fMgG1tljPFdQRm0m2SAPgi/9nuRtzUtiU0gEP6jkJSPB2bIbmvvgwVcrcesi/Iar9Nqd74hfi4f+oraKOBsRs4Zx9K7349bhFa+AHZIzPB5PaLld+cr/D0B0jLA7ldb/1ZLH+dEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L+ZdFhqdrtHeSjrYxQol7P/lIu4DeIa2Dn0lVE3IdE=;
 b=uQXYla271ZOJuZuznn56qRoTrxThkDyvX7dAHoVN19iexdtWp+zsHQBW4oSHuLQQpFOfkhdvQ9+gw8ingKuXckaTnZIhD8cnkSv5WcXrNe4hfM00scNBBqt72m3EzPcLUQIvS70mScI5kfQFn+rW9QKZVU5aonm493s4CMwRLrQSxNykWOXgzZn3EgLApFCzOa8CcCT8LnUT6wyl0DP2Oy/KeGlxXSHPI9yYB3/pFhFU0Zn0oxniS/J2PvNRZ7b0SOVcJCjWRXnl1d4My+IGir+BCEYGk8Ed7jxzwuALkUqoJ5SyYeohymH+re6iOFiNBnSTZ42DrNcstacI3V4dpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com (2603:10a6:7:17::28)
 by AS5PR06MB8889.eurprd06.prod.outlook.com (2603:10a6:20b:651::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 16:05:23 +0000
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3]) by HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:05:22 +0000
Message-ID: <3a5f8c34-dc89-fbbf-c330-6a00298e980c@vaisala.com>
Date:   Tue, 11 Jul 2023 19:05:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] net: phy: dp83822: Add support for line class driver
 configuration
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
 <261cb91c-eb3a-4612-93ad-25e2bc1a7c23@lunn.ch>
 <87fac0dd-9a97-b188-4887-8c4bb21196d5@vaisala.com>
 <6cf76d72-4747-46d2-a1f7-d2f1131491f7@lunn.ch>
 <85e9dfbd-baea-1d73-aaf0-d6c14a1305eb@vaisala.com>
 <0ef64a05-64a0-4119-9dcc-83e65434cd24@lunn.ch>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
In-Reply-To: <0ef64a05-64a0-4119-9dcc-83e65434cd24@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF000000EA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:14) To HE1PR0602MB3241.eurprd06.prod.outlook.com
 (2603:10a6:7:17::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3241:EE_|AS5PR06MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0f3119-5a1f-49d6-47dd-08db8228a14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWVHst1nsor82adH0NnsBN0LoXQtkqgXswCL71jMjiN7dD4nX/EkgEZ5MlAS7tZ2mrcKppXYQgiSeuVOzz4mXbmpWzYZL8Oe/Q5bF2ScunSb26n4Lpz7A8VnIZS0lBfzvVtHJX6GMxdjbQKnja7HRIWH2kEQCX/3pZKArE0hkzbeP7a0ndTp5+ZJ9aW1ZmCXAod0vCS4E+Uhkp/i08j+fof4orqRFGHojUumzF1pP9j18C+lPlV4PRqgbC7PM3AywZr8mtXfjm5W99v2SEWA1Rl1Q0qNSMpRNEuOggY+1lBkNIqtjII+uW34gWcfSyGt+AMMIJdAk0B06Kn8kuWkyDK9A8J1VWvMhJ/n6bC4EVUmZY+LVYL3YW4FhJSbCmGiEZxLunIwBcbdJuKB2/CpvjdQNfbjuWkbKCqL2EZqb/G69qyRvWiQAhfWjfgs93p6qJGf9CI3dvq/PNMFjA3CvRzMGVU5ciqfvXHUWAhXdpTi8Vy0yNhrkFt6pBspHUYXbyWk+2TZCuBnCpZxCwXM9pX7mbR24uSE5Twzfr6P1r5WYtEqGSnFDHF6omWd5Q41C+LSYnmu6EmdRfQ7ZTVM+//aY1/6DFKKWUKZP3RLBg5ZqlnU2G6tJlfCt4qhPqvnq8k5nD9FNK91R7vm46vFnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3241.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(31696002)(6506007)(41300700001)(26005)(6512007)(31686004)(83380400001)(2616005)(186003)(478600001)(54906003)(6666004)(6486002)(4326008)(6916009)(66476007)(66556008)(66946007)(38100700002)(316002)(7416002)(86362001)(85202003)(8936002)(8676002)(5660300002)(36756003)(2906002)(85182001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzNpN005NFprbXRJK2xEamUxemlmYk9WMkVFK0QzNVhiRkdRSEpyRHBBMENh?=
 =?utf-8?B?RkN5Uk9UeTBqSWQrcmFPZG9QdXZya1UwbUtkdERKUWYvbHNzanBiSWQyL1NK?=
 =?utf-8?B?SmIwMzlxeXpyejNpWlBGRmpESlptcmlhUmRxRnJFc3ErRCtIL1VjbTBHY3dR?=
 =?utf-8?B?VjF6TWhIWEtNL0lYRXZUYXpOS0RhaVFUUXNrQjJSa2ZFREV0NzFvSzBwcUg1?=
 =?utf-8?B?bElTN2doUjFsN0kzSG5oVTF0Ly9ZckJGbzFxUDZidENFR1JxcUVqOUtsclI3?=
 =?utf-8?B?enpHbE9IbHEwN2xZd3l5N2tqTkRiaWxrQUx5TCtaVWhYdWZOQnZ2MDY5V2Jv?=
 =?utf-8?B?SXkzcGRmRnc4VGh0SW5ZMWRLS2x5WklDeEJVUVU4N2FmQ1JxT1RyQ3hzY2px?=
 =?utf-8?B?dklGNDd3a00yNUNUK2JJOVMvZ1d2YS9KcFZUZlFMYllBcW14REZaRXMvU0x6?=
 =?utf-8?B?V1JaQUdpNHFtM3BRSTBnQmJ3c3dRdTM3eTFEWHAxVE1GeXBOZDl6ZGRVSXZh?=
 =?utf-8?B?Q0FlbmIyd3I3SU93U2xzMC9uOXhzdXNPQlhEd09qVDhyT3g0TXlicElDUzk2?=
 =?utf-8?B?TkhIT3VKN3dXL084czNRRUl4b3Jsc2plRTFlK1RRMGNRYUtYV2RlK1BLTVZw?=
 =?utf-8?B?MmRLcHFUaENtSnNjdm92c1B2STE0R3BYaC9hU201c2FqMWlDRjFLUldyZFBx?=
 =?utf-8?B?WXBMcU56MXlGSEZSSTlJL1hZY1cyN0V3WE80alhjYWhZQ1RmaEVMTVpqK3E0?=
 =?utf-8?B?WnZkYndlRGROdG1vb1AzMVFuczRCLzVGSDkyU0ljbFR2ZEoweTdjUWNZS205?=
 =?utf-8?B?SlQ2UWxvUTBjYVQrVnZlcEhSR09YKzN2MGJVd1dIS1J1KzlUcHB2cHdXdUs3?=
 =?utf-8?B?eEE2bXk3c1dDVWl5Q1dVVUNwVCt3Sld5MDR0Wm4wdU1Ub2NFcEgvN0xQL011?=
 =?utf-8?B?QXZCbmJDWm1hc1FwMEdCSkczWG1XOElNM2dWbEh6R202ajhwd0JLSW9Vd1k3?=
 =?utf-8?B?c212enJtVmdqcSt6RGNSemw5dHlpWUFac0FIMnNxMjY3MXBINlN2bUcxR2lh?=
 =?utf-8?B?UUpVMzlOYTZGdWdWREp5YVFKSGFGMDVDbmpjeWFwVkxyTFdFVFpIT3hJQ240?=
 =?utf-8?B?ZE1oL3Nod3NETmpYTTh4TWlhbTBjYzhGZmhaVnJscmtKTXBQZ0thSzc4dm9N?=
 =?utf-8?B?YlYyT2FCUjFRVmNTbkZFVDZNNTVhM0oxN0NaS2xRZFdVL2xkcVltcWJBaVVJ?=
 =?utf-8?B?TWhCM3VjaEU4eHB2aWd1bnJCRG9ncjdqbEZzNG9seFBkUEJFU3FTcWxGZkdJ?=
 =?utf-8?B?Q0Fad0hPVVhrc0F5dkk2aFZORFpMamZXWGtuS2xNZE0xbENxNTV1U3ZVV3k1?=
 =?utf-8?B?WjI3VkQwaTlZcWtNMGR3cUlDTlpIWElrckxHMlRDY0V2UytIa3JwSDMwOXJG?=
 =?utf-8?B?UzdHSVAxK1pPOXFUWXQ5OUw5L3VLcFc1M0lydC9LOGExK3AxM2ZXeGZGSWc2?=
 =?utf-8?B?VEhPV2VYNEp2SnM0NHpVZ3JsdkdSblZWNHFIMzVySk5VSGkyVFZGRXFkZUhi?=
 =?utf-8?B?aTN6L0U0OHpOazBTcEJMb1piSVJrZTRCQjRFRzVmb0UxSEJ3WFVnZ3hwZlpS?=
 =?utf-8?B?L04rczFCTnNZM1pwdkxkQVRjc1BheEVCRmM4NW1YMUtoTTdlc3dhdHdmVWln?=
 =?utf-8?B?bUxPMVl5cGRFNzRxZ3JkTVFkK3lMTFhPWk1hZnR0dUtJcUVoN1M0cHU4S1FR?=
 =?utf-8?B?ZXhLMDNibnJRRStPdW9KSmN6dldWNitNYVk1emVwb01ZVzQ2VkQ5N2tPejh1?=
 =?utf-8?B?RGhOWWQ3dkIzTWcydW52UVlqQjVEVGlLSzQzaWc5K2J5UVhGRkJoa3dpczFl?=
 =?utf-8?B?K3A2T0taMWQ2ZVdWY2ZxYmY0TDc1dm0vUHdMSksxaTBmVTkrT1FkVVd0MHha?=
 =?utf-8?B?T2VtQWo3aGJFVUtmUEpUU0Zva1pzTklVdUZ2b2Zia3Z0YnFxeDNLNk16MEdT?=
 =?utf-8?B?ZDlZWmlJYWtRRXo1UWRzQ3pXaHp6YWhwak1pdGpLd01aeE5CSk1walZWR0JF?=
 =?utf-8?B?b3h2WThRUGZJeGVDZnVkdEZnZEx5Lyt2bURmdVdqNFYrYmhxeDZ5T3BHVmVw?=
 =?utf-8?B?bFlHWEZYSUFhL3B4SjM0QklySjJCSllZU0VXT00rVDVDU1E4NVo2SjlTWHpv?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f3119-5a1f-49d6-47dd-08db8228a14a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3241.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:05:22.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeEyEZNGsyMgLh3/duz+prhM/QOPwRJ5wOCfT2TM6f0w0R5YF6P/xmCL+zQzq1gPq4JDK5W/+U5sO76CazFzU17/1xIaTwTYypLW/kdj1wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8889
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.7.2023 18.35, Andrew Lunn wrote:
>
>>> So before accepting any patches, we need a better understanding of
>>> that reduced MLT-3 is and why you would want to use it.
>> OK.
>>
>> My understanding is that as we have PHY<->PHY link it needs to handle itself
>> in standard way. Thus the MLT-3 full mode is required for communicating with
>> Ethernet switch.
>>
>> It seems that Texas Instruments has figured out additional power saving
>> mechanism by carefully selecting used magnetics (they have guidelines for
>> that and list of supported ones). Now the thinking might have continued that
>> let's make the power saving mode the default for all.
> Do there guidelines for magnetic says anything about what to do when
> using unsupported ones. Like turn reduced MLT-3 off?
>
>> With carefully selected magnetics one most likely gets correct looking
>> signal when measured from the cable and thus the other party then gets
>> I tried to look up what does this class A and class B mean but I am unable
>> to find the reasoning for that.
> If you look at the oscilloscope screenshots in the support forum, it
> looks like in reduced MLT-3 mode, The TX- and TX+ pins only have two
> states, not three. It relies on the magnetics to combine the two
> signals to produce a three state signal, and handle the bias in each
> signal.
>
> When in MLT-3 mode, i expect the TX- and TX+ pins do real MLT-3.
>
> With real MLT-3, you can then do capacitor coupling to other devices
> which conform to 802.3.

 From the datasheet 
(https://www.ti.com/lit/ds/symlink/dp83822i.pdf?ts=1689018777543):

"8.4.3.1.4 Binary to MLT-3 Converter
The Binary to MLT-3 conversion is accomplished by converting the serial 
binary data stream output from the
NRZI encoder into two binary data streams with alternately phased logic 
one events. These two binary streams
are then fed to the twisted pair output driver which converts the 
voltage to current and alternately drives either
side of the transmit transformer primary winding, resulting in a minimal 
current MLT-3 signal.

The 100BASE-TX MLT-3 signal sourced by the PMD Output Pair common driver 
is slew rate controlled. This
should be considered when selecting AC coupling magnetics to ensure 
TP-PMD Standard compliant transition
times (3 ns < Trise/fall < 5 ns).

The 100BASE-TX transmit TP-PMD function within the DP83822 is capable of 
sourcing only MLT-3 encoded
data. Binary output from the PMD Output Pair is not possible in 100 Mbps 
mode. Fully encoded MLT-3 on both
Tx+ and Tx- and can be configured by configuring Register 0x0404h (for 
example, in transformer-less designs)."

and then about transformer:

"11.1.3.1 Transformer Recommendations
The following magnetics have been tested with the DP83822 using the 
DP83822EVM.
Table 11-1. Recommended Transformers

[table here]

Table 11-2. Transformer Electrical Specifications

[table here]

"

They have also application note 
(https://www.ti.com/lit/an/snla079d/snla079d.pdf?ts=1689063082391&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FDP83822I%253FkeyMatch%253D%2526tisearch%253Dsearch-everything%2526usecase%253Dpartmatches):

"2 MDI (TP/CAT-V) Connections"

and

"10.2 Magnetics"

Which has more or less same info as the datasheet.

To me that just says follow these guidelines and please select one form 
already tested lists. And if you must then look for similar products and 
make sure that these limits are matched.

Perhaps you are able to decode that better :). I trust our electrical 
engineers to do the right job ;)

>
>> In a way this could even be:
>>
>>    ti,force-standard-mlt-3-signaling;
> Maybe. Or ti,disable-proprietary-line-coding
>
> Lets give TI a couple of days to comment.
>
>       Andrew

Sure.

I am OK with any of the three variants proposed so far.

Perhaps leaning towards more to new ones above.

Thanks,
Vesa Jääskeläinen

