Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A852732470
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 03:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjFPBG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 21:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjFPBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:06:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E92D40;
        Thu, 15 Jun 2023 18:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3MqG+KNLhKpAmUBqIw7+xMkIJIf9NKakP+VjsgBq4X1Li7Y6vrPhshM27tXSylb0z1yQMdhHHFyhojRMDUxViDqkOiPZy4EOogoGkewIZhRZmWFL5lJOEcGAebmZj4DNXREm//kccSyUh0YDvsN5CxvREtnIrD19/+7AaZHvRjJnjoBl+fFYee7SsUzQHenTK6+ejDWkXb72C5OpPkKCkeYI8nt6u8+kAG44jM2ckbZWNUstcH4HHaCDl5J/07WPX8a/EhaeDCPyleE0HSceaS1mn1edc7Fj+skVPv599198zRm5lyqeUMOmb+gqjCeaxeujMLSSI1mL8ON2VP9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTwAte3sq1HtUqfDc/CFfQFp+tjleHF2UCCviaN7QN4=;
 b=Vh4+dq+tKRYMZU1zqF6ct/DEcwqCEhu/DsHTcWA4BeHY+0ExP2ntL+fMfEMeXMMRcenyxvWrSOSDO9yvVaPn6eEFtpS1uQkpXXL3Gz3RELAkV/AS2ccx1pH+ZfkCX2It5qd6gZqcGVWq2OJyGiv8hW8Y90RLuj+LJBrVqPlpQRAwQA2ixmNys5k2YNuuMWZf+VM0r0MLoQeAO/hcEYCztfdfV/6+veBOtYbVV6bdI11iOS3okPSwlsjdh3J9kc0jeKZQnADrl/WsUdOINiwzWJOsS0Q18BRVsgGZdH2XJboMglJJ6uZqmPnSK3hWVIHuyZ0YtCFidrDIQUDH/pxV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTwAte3sq1HtUqfDc/CFfQFp+tjleHF2UCCviaN7QN4=;
 b=F33cLi0bfvO4xxgvPog78c6pCoYCHnpnJRCkyYe168/c/ztd5Yam6ZyMHQXuaA0rVYYvSyAvZF49HJEFxmecwCDGrtbEnqjcXihkOW8VxQQI0Xy2kouhoh5bfSflfx8X7yYAwyeEf1b+HCcM4d9Y1q1WVE81yRo+V5o31Pckbho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8952.eurprd04.prod.outlook.com (2603:10a6:10:2e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 01:06:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 01:06:19 +0000
Message-ID: <60c95298-68cd-0f6c-38cc-745da7b2a6ed@oss.nxp.com>
Date:   Fri, 16 Jun 2023 09:06:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
 <4844567.31r3eYUQgx@pliszka>
 <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
 <3e397cf5-0ca3-fa10-b5d8-bbc7b1038a37@linaro.org>
 <DU0PR04MB9417A508A757AF8964CDAEA6885BA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <7e843caa-8369-1fb0-36c4-a4482d37b211@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <7e843caa-8369-1fb0-36c4-a4482d37b211@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9fd743-8f69-4662-85e2-08db6e05e46e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKPD1oUIvxLS2INB733ZYJ979cnGbWzfYlyDtyHSxm0wvonq8tDIInQBrNiZglys5pLgw8hT0Ofx7icIZEabcbOXgIVnpV3o277J19DtXyXxb2K+3mSZBjWEyRsqLEcaPLtozJsIgLmEiLVvDBIYLSE+CqcmWc8+6UvDnhx7y6xFZm78vBvJL6hm2aO3BW7To+kbOftme5umWCCFy5Us2o4xGLnpIBbhsFoCAJY482SbW+f91o3Toi5ihKav6t4ZsA/jZJNnNDydCutxImdYSV5kzFSSo23JeDQZoI5CHOjjMqh/6O7Ngvhs0RA39y/zK5FZJjJSptXeRFvA3A1rq3rDSwZNLJt63zx9E/Ag0YV7mg890a09GexPt2Xk0TjQn+7gktJGlA4MZ0u3FlkxPot3WMXsyW1gKKeq5OcOEa8XdXdobJeBepWoSMgKJizev2WShHC1w/flfwz02DmvG6K1RuvikHUjZvCusxTHHIGmDwyd/Hr7Vt9tQtBn3+yYDQSbT9n2wJXACyfVk9QnqGuUVfh7ij0ilFyFG0Bs9yDlB5bzqt/+0UNNiJlYx2hZ4MlNjY3kuvKLzqAUyll7bRfnQ8yRioeFs8g9l39jSzMztTWyZ2svWeNqx/Jgk25yU0EwdoVsdF0CjJ50/39v2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(86362001)(2906002)(186003)(54906003)(110136005)(83380400001)(2616005)(31696002)(8936002)(41300700001)(8676002)(6486002)(316002)(6666004)(478600001)(38100700002)(66476007)(66946007)(66556008)(4326008)(31686004)(44832011)(6512007)(6506007)(53546011)(26005)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRlT3EwNm5DRmhHU0JoMG1nWU9CdWdBVStYU2FaZ1NUbGVydkRnNkNGeG14?=
 =?utf-8?B?ZCtteGxlY013RkErRnBhMjhCY29EdFNKNlhzUmpSRkVvdTRHb1dKZmoxYVpr?=
 =?utf-8?B?Z1lvK25SZ2dMWmhCOGZlQkJWNThyTjNlWnAxdGVpOTN2TVdQb3o1cEluT2Rh?=
 =?utf-8?B?WGpvVW1FMi9HM2M0UVZoVnNteTRHM0VGZXBCVU1PQVdkQ3htSldTRDdiak1n?=
 =?utf-8?B?VHlOaFk2MUU4Y0JrU2ZibW9jeVBKYm5uaWtJVWZKRUhGVUlNREltQjFjeWRV?=
 =?utf-8?B?S29PdFgyVTVvQWdlRFdyNGIyMmcrMEhvbXcyb0h1SkhMY1JRdDA0U3NyUDcv?=
 =?utf-8?B?Y3lxT29jV2VrUG51dEg5d2ZQSHpVblpqVE1sU0dkOXh2UHR5VE1MdGJ0enQw?=
 =?utf-8?B?b3R3dEM5TkpTU3BMS0dmdjlCc3djWHlGcUdDWFAvd0VDRklkbGFIM1Qrbk9G?=
 =?utf-8?B?UXNlWmx6dkExSVJINHVteDRzTzJiUVFZNTdGd28vSkcwU2dvZDJrYlY5TDBB?=
 =?utf-8?B?a1NFN0h6elV6OGloc3NKTEdMT3pERDNWZ040amRwTDVsWVhQSGtDb00ya3VN?=
 =?utf-8?B?K2dZYU5YaDhuNEJQLzFESmdqTGpycU8ycHpkSlJDR0V5QTdvajd5KzV4TDNH?=
 =?utf-8?B?QmM1KzZaSmh6Y3k1bFliRzJYUk9hYTFGcEFEMHVMWUxKUFNRY0xsNmdEQXNM?=
 =?utf-8?B?Zjd5T1h5VVlhclB4cWlEK2FtaFN6T0hUWTNsdGtRcVR3cUpsODlhNXVkdzhm?=
 =?utf-8?B?bjRkOS81RjFRRldCYnFqQ0tCNXhlTVFsOHNpZUZaNEs5RStoL3NRZVpHQjlH?=
 =?utf-8?B?elBXNjNKL24xMW1BWnpPeVFzU2RKQnl1OVBORE9tVmlWNmNGSmJ4TGZQcmM2?=
 =?utf-8?B?OUhMYVV5RWw5c0NkbkZaU1RZTEJRWTNKSURxNTdJRmhrb3dJVUVCTGVVdVpa?=
 =?utf-8?B?dGp1VVJNYk9FNy9Ka1JXczJKMWF1WG9hQitMQ1I3dnQ2T3lIY1VTZmFOWnRD?=
 =?utf-8?B?ZER2cmpRREhPZSt6bThGUTBOMDBiZE9IbFEvQkFFR3pnaW1pbkdCLzgyQlFK?=
 =?utf-8?B?ZUR2TVpyeGI1Tm5MMm90WkZHN1FkSmNscnlQRzQ0aThZWWhZeVk3Q3cxN3No?=
 =?utf-8?B?dm1DMjBsWXc5eGIzaEpZMzl5b2JLM0FDT25QVENTN1liZVkwN1U2djdLblBK?=
 =?utf-8?B?Q3p5bnpBUm1ydm5neWhxY1U2Qy8rK29IUmRFTUJ3U0hVZ1czck16cEpZS0VH?=
 =?utf-8?B?WTJPdDlNL3pxYXp6YzFaRzMwN21yODRIMTRTeSt4QWFEWEJ5aUFKcGdGSk95?=
 =?utf-8?B?VlpqU2NFdEZ2cEpmYWNpaWUvZit5NFRBZzMyZWlRcTFtNklHY3crWXlZaXRv?=
 =?utf-8?B?UXVIbTZBUzE4YTdJbE4raXZIWVk4Y2E2cXMwNllDcGErZTlmYUJkMThCUWNi?=
 =?utf-8?B?RlFQcGY3N1N2SnR5aVpqYTJDS2xvc0pHeDUvRWQzd0Q5Vm82OXh1Z3hyU1F3?=
 =?utf-8?B?U1hIRVFJNDF6QUZJTWk2TVBOVUhZQkkyWHo0bmhjN3hFMVI5aDF4UmEwNzBW?=
 =?utf-8?B?RTNxK05kejVoZEtwUVNiU1pSVnhDdk9BVndyVGREaEEvaXRQbmRhQUg3ODRK?=
 =?utf-8?B?RW5DT1RucGNMZnRKUFNaMWFWeG05ZzFQZmx4anRJR1B6Sk4xL200UXJaK1BL?=
 =?utf-8?B?amJVdUFBL0Erb0xGVldJTWxJNXJvN2o3c2xXcmw5aURrVk1GSlk2Y3d4YTlW?=
 =?utf-8?B?U3pxeFY1Y3VKYldvWFpMekpRQ0dZNDZiV1Z1dlZ1V0p0RGN2S3VMM3ByTzZL?=
 =?utf-8?B?UkJBMmdueFRxRDlzZFJ2K2FlMDQ5WmZQQllTL0JveURTeG9GZjJrNjFKM29R?=
 =?utf-8?B?SVVhVnZlbzVVZmczVlBzZGZ0VmlWYnFJOWF3M1p5NzJKMGlzNUFtN09qZDlR?=
 =?utf-8?B?Q3d1cDJZZVkvRXhBM01TQ2VBTkUxaUJDL24wdXppbGZIT3A3MXRSMExUNmZx?=
 =?utf-8?B?aEYrUlQrT1J2S0xtT2ZhT09CRFJNRFlPR2c4YXZkMTZVMUlHYTZzVGNDVVVN?=
 =?utf-8?B?TUZMSHVEc3ZkTDU3N1RoOEkrQXU1L0RXamRaZVdLa3NkN0VrUlZXNzhWS3c2?=
 =?utf-8?Q?6jANHVzkvIlMtrVKxK5WC/XzD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9fd743-8f69-4662-85e2-08db6e05e46e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 01:06:19.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhBqK/Y6e6ewHHMYv+sApvZcLakpzl3yqlmtHKLE2GTnBujYC93Vq5Oo9O7B164y9NW3VqlGD6+pzfCQJRBP1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8952
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 9:49 PM, Daniel Lezcano wrote:
> Caution: This is an external email. Please take care when clicking links 
> or opening attachments. When in doubt, report the message using the 
> 'Report this email' button
> 
> 
> On 15/06/2023 14:07, Peng Fan wrote:
> 
> [ ... ]
> 
>> Per i.MX8MQ Reference manual:
>> MSITE:
>> Monitoring site select 0 - 2. By setting the select bit for a 
>> temperature sensor site,
>>   it is enabled and included in all monitoring functions. For proper 
>> operation, this
>> field should only change when monitoring is
>> disabled. If no site is selected, site 0 is monitored by default.
>>
>> ME: Before enabling the TMU for monitoring, the TMU must be configured,
>> see section Initialization Information. Failure to properly initialize 
>> the
>> configuration table may result in boundedly undefined
>> behavior.
>>
>> So we must set the SITEs bits before enabling ME bit. So set TMR_ME when
>> each time call invoke mode violates the spec.
>>
>> As I understand, change_mode is per zone, which means per msite for TMU,
>> but TMU_ME is a global gating bit which should not be set before all 
>> msites
>> are set.
> 
> Mmh, IIUC correctly the documentation, it says the monitoring must be
> disabled when changing the sites. So in the proposed code, we shall
> disable the TMU, update the site and then enable the TMU.
> 
> Can you give a try to see if that works? If yes, then can you submit a
> patch on top of this series. Meanwhile, I'll pick those changes.


I did a basic test on i.MX8MQ, it seems work. But I still have concern
because it volitates the spec, need disable TMU before updating MSITE.

And if we disable TMU when updating MSITE in your patch, there is 
potential risk that zone0 is reading temperature, while we disable TMU
and update MSITE for zone1. So zone0 may get invalid temperature because
TMU is disabled at this window.

no good idea from my side, unless we keep check TMU_ME when
getting temperature.

Thanks,
Peng.

> 
> Thanks
>    -- Daniel
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
