Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4D74E865
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGKHve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGKHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:51:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF7122;
        Tue, 11 Jul 2023 00:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ash7nFDJlZvXlCk43ozWTFMfogtUy7gpJXOVdf/YEOjxSqyDJfR1q58cbaWKqAi4V8y5pgvoyS8GWPgswYzCyNWV0KjntNLOaH0BRyUGjv0uIs5fOguUiV3nY/l4phDyU5IwuQMg/GAoMmRxg8FNDiOrlt8TcwuYpRZJEhfUpohMRxSmgb2xw9jXbjHRauEL7W6jM5nfE8zVdqFtgkl1w2fIDQRc4ehUrTMtGQy8fko0mKwkTpwrs0NB8sMX+VxMXyoaZDcuyX8zCSrRS8CBEwL75aBnj7ZkY9dukii8ASBPjYMZZjYPkXuItbk9sM6Gzrb2YQivOYnXu2UqJJpnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpoQhsnXfdsKgiripAAJlAUU7wO/Utt/xC6TXg5FiCc=;
 b=cT9eRtBk9Lo+X7POb0PqHXjisyADx9QOYjfO92A40Pe6Rad3K3rHLEk/Kw1ZKlUkaCwNDqGV2Xrjup8iVXVxiUGSB2BeY00pDot8j1hphX4J6Fp4+v5S2qc9YVJy+upNiUVcvAfOeNMdSPSnR74wedP7692BI7fui3c7hheL5kRDzReQ/66Gi8S0955vocl2emvNPdP7XwlhJzDUtvRU+E/PRFedRp+1uNZTy8MCRH8/pvqE548gEBDX1EUVAmO8CY7+K/fd5CqTO6xvxZpgJdd+NiH+RCw+lGpV8RO8atSOYiVvPKk6UyBmGZf8vfhrgK26HZ03FhcSkylEvGXnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpoQhsnXfdsKgiripAAJlAUU7wO/Utt/xC6TXg5FiCc=;
 b=sDWMDAZYRfygnanJmmBC8m9YTxssSP/Bti+YEryYl12lo+HKQd6eXGGWLXw6ucjdwphywFwLn2m01TXXTzfbC9Y4sN9A+O6tQWYhzwBFxfYCvaRW0CKzvuDV0loVjUk5NHU7Vx2Us+K2K0jRl/k9EeDYKou9c/pPUUBIe79Jlbpq7UgsxkK2bXhX1BvJBDGrBB7uZo/sNi49kO1Iq6+WcmGOoKIQbVvEPK9/m72YZmTj4DcD+0zHYwjdy8CxHPxNrDpesOsD569IxKb+zfDP0bz5qx+3QqNJqtWd4bMzpZb5fjdTCj7MGujJIaNTrphjWHz8mCVA5VdYs+dtWmvJBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com (2603:10a6:7:17::28)
 by VI1PR06MB6461.eurprd06.prod.outlook.com (2603:10a6:800:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 07:51:25 +0000
Received: from HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3]) by HE1PR0602MB3241.eurprd06.prod.outlook.com
 ([fe80::8413:b7d5:15ac:63a3%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 07:51:25 +0000
Message-ID: <85e9dfbd-baea-1d73-aaf0-d6c14a1305eb@vaisala.com>
Date:   Tue, 11 Jul 2023 10:51:22 +0300
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
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
In-Reply-To: <6cf76d72-4747-46d2-a1f7-d2f1131491f7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVYP280CA0015.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::13) To HE1PR0602MB3241.eurprd06.prod.outlook.com
 (2603:10a6:7:17::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3241:EE_|VI1PR06MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: c8618a15-92c3-4571-72be-08db81e3a04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z2OjnbnaAwrD6bZj3nU6vcpe65NZee3ENVDyOAo0ARFXUI7Rppy1tTOrPEIxhC5bDMgITM9V8kL6SYrwUOaLiL7T85knyfDZ6lg0SEVqdAxCTa7Ls4H1Lzbpu9qIdpDykvhzxBL+7PCPYaPmfUXE4ut0dNqOKp4DTcSF/001Tt5XJYglrAcjirwXkAGIDSXp6mAkZfrWf12AjePJyGb7dCpal0XxgGc8iajbz00EzQt2J+GlHnWFKfcMcOY7mlIlIophvQWWNB+Pvpn+Qjd59BZyRcEkULCN7OczP11odY2l6L4G6sFkhQ+RRoTdY7QiHM2SF5ETx4tRgxg4cyzCXFMh/A3xo7EggQEanCQtyGHc6FQCn4AJYNm90d7GLIY4iNf4Rb9UpDr8NOrQMRxUzpbZlSk6XP98TR2MDEghW0Qfy0ZThgzh5I7fen4T3z9SR03c35MLpTPeMjmm+T5XOr4DhU2Vkkd1EyuZJVO9nisGr9eeFlxiI1AFiL9FB9tpO3gRDw8NbAobugDh5VmWXY5a4c4FZaD1Mrhx8518qnqubKPf6YNBbEIO/7Rb6DgfxRItJ2ORdib6MvJOXAEVGrC/QhZhexGIyCvtwfdbGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3241.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39850400004)(346002)(136003)(451199021)(31686004)(66574015)(2616005)(41300700001)(7416002)(85202003)(2906002)(186003)(85182001)(36756003)(5660300002)(38100700002)(45080400002)(26005)(4326008)(6916009)(8676002)(8936002)(6506007)(66476007)(66556008)(316002)(86362001)(54906003)(66946007)(31696002)(478600001)(966005)(6512007)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtFWTROTmVhRHRlc20rWHh4dHcrV1B3bGFSQVBleCtlSU12UHhKSm42SUVi?=
 =?utf-8?B?Q0wwOC9pbitBMHV3UWtoRnJhallmazB5N3UxMkxqRmI5RUZTZWpVRUxDWjJI?=
 =?utf-8?B?TzVnVGNaOFdwSlhQLytPbm9vKy9rR1NjSWNqd0lqTHdJRWhKUVJMVmFhR2VL?=
 =?utf-8?B?ejVPTWJlc0h6aUQrU0ZPb3I3cHcrWDgvVXVmN084dXBEQ3M2WncweEptTjVW?=
 =?utf-8?B?T0tzUVBFTzkvbG91MnkzUkRNQUw3R0VJUWxHVkNOREFUWS9EVU9NaEZOWEhZ?=
 =?utf-8?B?RmJMVmdIWmdpdlNxUTNpcGpJNmVUZHFUQUlQc0ZXMmhGQkRlS3ZudWZhTVEz?=
 =?utf-8?B?M1R0ZHJGSnJ3SCtFY0ZldkFUWWw0WHRZamZoeXUvNUJsSmZldVZyNy9VblpK?=
 =?utf-8?B?clVDTUJabDNtR2puU3Q1MTNjSzB6dkRRaG1wSDI0YzNUMXRUSnVoT2RJbWNi?=
 =?utf-8?B?QzJOa2JFS0hGSlVyQmV5dkZ5UHF0bHZsbVBNMklTRHkxRVFlTEttWi9wa2hV?=
 =?utf-8?B?bFB1ODR6Y2V4ODJoUEYvK2h3WlBuVXhrRFNSbDJ6OUQ1Z3VoVWhpU2REcENa?=
 =?utf-8?B?NXJBTjFsYktWQW1vd3h1VFhJL3pMaVJRSDMyL0lLRlJOa2Z3cXpOTWZKdGZK?=
 =?utf-8?B?dFZPNzRjcm95T1hLZzJVV1NYTXh3bUs2REVyZ3RTVHFMQmQvNUtITUxNZi9X?=
 =?utf-8?B?MW9GQ0JOS0hsaXFqZVFPUE5sc1VUbWx1SzlKOEFpUVhqY0xRemg1cFN6ZVRO?=
 =?utf-8?B?M1paUURveEVjVmxONy8xb1VOcVZERGRSUitLZzRDSEJ1d3IxOW1Fd3V3eGMw?=
 =?utf-8?B?b1NzR2xMcklhRDJSa2xHNUdjNzZ3VHNGVVcxMmdsc21EclBnRlRBTjVEeUda?=
 =?utf-8?B?NmRuQkdiSUNtM0o2UlFaSTAydDBoUDh5VHcyY1QxT2h1TE5Nc0dMbUdWd0Fh?=
 =?utf-8?B?dTF5U3UvVFFYMjFUdlFwZm9MQncvVnZLU3dJWnF6c3FGYkZyWWVseGVOejVa?=
 =?utf-8?B?TGFmOWNoV1RXbHZjU1RGYy9SSjdlN0E4WFFIUnl6RkRDN0JDSmN1TVhmb0Qv?=
 =?utf-8?B?V0hmcG1tVmpsb2pibkdWRWtCZDhDQ3VZOVhtUHdYRlFjVGtMMmd6TktiZXZj?=
 =?utf-8?B?NGF0Q3hhSTc1aVg0SUZ2bjd3OHpLZ1RUN2pRSXhDeHVqeHZTWFZPSVlYNDhW?=
 =?utf-8?B?UWp0VVZZVDVVWHhXZy92VDNPQzc0Smk3ZUdUVFRBSExISTgveUI2WjlEbktD?=
 =?utf-8?B?bWtlWEVadHArYVlyY2JOdDNmamtpcFBZZmVrVmxXYmcwRFk1Nm1DQ1VKT2J2?=
 =?utf-8?B?V2hKRmljd2NOQVpWQ3gvTVArTXliUHNSRFRTYVVoeE1sSGs3aTRCUHRKYVEy?=
 =?utf-8?B?cUpMZnZUdWJ5WTQwVmNuSmRFcDFwNUJabUlwM2wraDJpWC80S25yOUxHVjlN?=
 =?utf-8?B?MGtkOFNCelFhMXM1RDNkZ0xoVDZZdmVwY25tSmJMNzhPcXVlYno2azdXYkJx?=
 =?utf-8?B?c0h5YTh1Z2hiNGJQMFRxWDhxTDhVZDV6Z1VlQXFHblZYUExIWVNOZG9iQ2Vk?=
 =?utf-8?B?b2lqa0xmWEZJOXdIb01DZnZMUE1mQ3dqNE1GRzcycDQxMXh5c0ZMQitPQi9j?=
 =?utf-8?B?TFVIL3hzcEZGQzVrZ0Z5RzlrUDBTQWkxZkZzZEZBNFA3WVd1UFZ0NXpaRzV2?=
 =?utf-8?B?NmpqYWZYNHhGUGxlbWpQc3JNRTlNcWpVUDkzY0N4WU9ncnRuVjJYeG5leVZl?=
 =?utf-8?B?cjUyZkhDZVJidCtuV1VsTzdLbWpTUHZ2ejZPcHFkUmhFRWVGSVA2OTFsTnc2?=
 =?utf-8?B?QkpZa3BReXB0djRGQTdhUm1vRzRCREFudHFoVURrbkE0MnNKZ0JVc0dqT2VU?=
 =?utf-8?B?OGtoSHNySUkwQUlGZGFGME9jbS90WTZ1UXptTUE1SC85UTlrRHpQNk1aL2hE?=
 =?utf-8?B?ZG5XOVAzWkNGS3QwZ1hBamV5YmI1NTBHQ0pPZnRXVTRpOUpaYzhMN3ZlZGtt?=
 =?utf-8?B?N2RTUDVDZnloS21ZS1prV3RBTC9ESDBlNkJpaitKVENmSXNleGdHNk01NUda?=
 =?utf-8?B?aXZIQ3hCVkZDemhzaVBnekVRbFlBYTRnQ0l6ckwxd0tXWG54cVI3RGhiNU1E?=
 =?utf-8?B?U2s3UEMrQkZOcWZTRlhtQ016QXRsemYzWDJqbXdYbmk4SU92V1ArckhmYjFQ?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8618a15-92c3-4571-72be-08db81e3a04e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3241.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 07:51:25.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1a9ai+NUZ9Q3e0oG8efnbs/HYIwiPkVqg9ZOI9oMutFM7oBRRjunTqHUIyyVOXljI0QvsE0pNCqSvWGA92h96MiayXvHLct3LIAcSeZSdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6461
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

Hi Andrew,

On 10.7.2023 22.38, Andrew Lunn wrote:
>> Hi Andrew,
>>
>> This is needed for configuration in link between DP83822 and Ethernet Switch
>> chip.
> What switch chip is it?

Microchip's KSZ9897.

> Most boards just connect the MACs together and don't have PHYs in the
> middle. There are some boards which do have PHYs, but they don't need
> any special mode.

In here there is PHY<->PHY line link. My understanding is that in this 
particular case PHY link works better than *MII links.

>> In the connection there there is no Ethernet cable at all but routes
>> within the circuit boards but instead has capacitive coupling on routes.
> So you also left out the magnetics?

Yes for this chip-to-chip link.

>> So the setting itself is related to specific circuit board design.
> Agreed. So it is then valid to put it into DT, if it is actually
> needed.
>
>> MLT-3 is related to encoding used in the signals -- I suppose wiki page is
>> good introduction reference:
>>
>> https://en.wikipedia.org/wiki/MLT-3_encoding
> MLT-3 is well defined. What i could not find is any reference to what
> reduced MLT-3 is. If it is not part of any standard, why don't you
> just hard code the PHY to always use MTL-3 which is defined as part of
> 802.3?
>
> I get the feeling reduced MLT-3 is TI proprietary. As such, it should
> default to MLT-3 as defined in 802.3 and there could then be an option
> to enable this proprietary mode for anybody we wants to use it.
>
> So before accepting any patches, we need a better understanding of
> that reduced MLT-3 is and why you would want to use it.

OK.

My understanding is that as we have PHY<->PHY link it needs to handle 
itself in standard way. Thus the MLT-3 full mode is required for 
communicating with Ethernet switch.

It seems that Texas Instruments has figured out additional power saving 
mechanism by carefully selecting used magnetics (they have guidelines 
for that and list of supported ones). Now the thinking might have 
continued that let's make the power saving mode the default for all.

With carefully selected magnetics one most likely gets correct looking 
signal when measured from the cable and thus the other party then gets 
properly looking signal. I suppose this is the majority of the users.

Now what can be the default operation.

My thinking was that let's keep current functionality as is so that 
no-one would get surprises with it -- and it is default setting for the 
chip too.

Then again there has been also others like one in TI's e2e forum that 
already had problems by not having the MLT-3 full mode enabled so 
default could even be MLT-3 full and then have extra device tree setting 
to enable this power saving feature. But then again one does not benefit 
from power saving features developed by chip manufactures if we by 
default try to cancel the effect. And this cancelling most likely would 
happen afterwards of the original driver implementation as these are in 
special registers.

I tried to look up what does this class A and class B mean but I am 
unable to find the reasoning for that.

Do we have people from Texas Instruments that could share more insights?

In a way this could even be:

   ti,force-standard-mlt-3-signaling;

Then there is no ambiguity what it does.

Thanks,
Vesa Jääskeläinen
