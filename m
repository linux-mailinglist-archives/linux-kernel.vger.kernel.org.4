Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DDB738AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFUQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjFUQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:18:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA1E41;
        Wed, 21 Jun 2023 09:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/MCXpt/9UM89E+gL28beh9XrNXeFzjHBtyaC9DZRKgJKD5SWT4jtLhkBqqWLpZdnQUFUdh24Y93bmQ2Iin1j0FriqbbOGkGrtlhAnubvjF0qzhA736f19X+RMvm362AyUrUayIEj4ykMtilUROb396q8B0yRnopNZN0aFhPnft66ChxZbbkGw3U/OYW0a16O47s8GtB+T2kWmPGamWlOgqRnY+ZYNdMfhJxV/3bI37G1okQldArqHEPyFdrMLdFWQlpil6+Vfs1Ey4KR10tv5nMurTH6ma8aDcdON8929Zi7bX/MqqfPNYNMY/AjGeczQp4c0YS9R+8bpVjP7p1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oQeTMoDq3KCwbOT3ek6TC7AqmS4vcKI6ZWPThDzRjM=;
 b=mBJQl+WIhfoHbR7HC4c7wrQRCqNi70UXxCCEnY/tZACDjZwvG146j9siXIoKd7OTcaUZHD1jeLPX6QDV+9L2H/GDhrHPbIEVXxw2D5iYq2iTSkDAzPo3Bb9vGj8FL620vbW93mLnU2TTafLbSg8+x7tRd0yHetTn1R7hOqP1jwtBZt8FYnTpQJbsYgqckZFkMZZRSYm7JJ74fjByop4FUmWH9drk7l1MRJ8tCCkaVfmBz8v087S/od0BUlnnNxzYEbessY9UO01gBShcumsNkv+VX90c7fbinyxSVeEr6olocUpRu/AAU0ynaT2/4YzG9+lSpbUyv1wJ09mEZN3NNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oQeTMoDq3KCwbOT3ek6TC7AqmS4vcKI6ZWPThDzRjM=;
 b=RIE9M6u9xzy02Q0tby4hDe77P43GZrV86h9H6B9sAyIeDfHAVyxUl6S3AmQ9oleHPXXYZgHGdbrkqCi1aFcmrwJ7vyoi7mQCH2tObso/G4gvGiYA5cF9Ac1D5pPj7/DHdQBy3ibNGZ4hqlmSeq0ai1wlOjOvszMb/Ei2QUK0A/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB9449.eurprd04.prod.outlook.com (2603:10a6:10:36a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:18:31 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 16:18:31 +0000
Message-ID: <b7365082-55e4-44c4-88d7-3d5c65de8406@oss.nxp.com>
Date:   Wed, 21 Jun 2023 19:18:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP
 interrupt enablig/disabling
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com,
        stable@vger.kernel.org
References: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
 <20230620203145.2da7c958@kernel.org>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20230620203145.2da7c958@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0087.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::16) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6054e20b-5c85-44f7-b872-08db72732765
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTx+fWA1G9xbdJSDXmMuxGukp0c9qjwgsD98oz0DOS09XN4yTaoil9BlxFvu1JAY24wS4ziSigSAbAihAyN3o9KV48NdZQsVbLrma7PFpGYSAb1gHjjVI250KZgvz20lPHeOBde31EHKcxz2qZkgo++JrcpDUizSbhaR5CXCQGPu54RwB7ZandBVYy1JUGZPlDXc6UhCGacng2CQGP0/0WssF2ozYUaoPxwRHqCdcnq2h9iQzk/cl+Be4AZvaq2BNiixNdC4PA+qsFpQAzW0jU9p4nUg570eHaTiNBgZeHQpTz/1FTuGXMydOiIOXXZHOij6CEL2wpKeLaW/tQTqQNS82ogAlQSwcGwr1Yb4SXLgX54vHkIbEx1gdeLp/GPc0hpgDwjAazA/b9FKPGWAINc5/g3GL1TFChbrVc7jXR84HJswf+c+uBuhmpCuIWBRTL6j4s7dyiHfh1qSIqk1NLsEE9yJptPSogWqH7fYc2YweANfzP3G4UC+NNtARjLNCXHX1b5pll/W+Ouw0we/Ia2vg15f3YYs35tXmhwLtarc3mhdGk7xRqi9Tjvy6gXgBGScvCIvY7e047IootFvY4eowqFb2Hj+K6XQKM6e9TdBh6b/HZx+jA8BAlObwAqYouianCIiAUIO8k0KH1yzmATd4x0dMdXK3E2s8s21rhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(6666004)(2906002)(8676002)(8936002)(316002)(41300700001)(7416002)(31686004)(5660300002)(6916009)(4326008)(66556008)(66946007)(66476007)(6486002)(478600001)(38100700002)(86362001)(31696002)(2616005)(186003)(83380400001)(966005)(53546011)(6512007)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdXVEU0eXNyZlFVS3FkdmZZd3RRWlN6d0RLNDNrTCtmK20rTXAvTDhuN0pz?=
 =?utf-8?B?N1lkVUpNQ0IybkFRUENGNTk4UmJ1MWtHVTRSbnpjb0NGZTYxaTR0c1A3ODk1?=
 =?utf-8?B?VXVuakZmY0NWRTNmZ3lRandXK1N1OEErVC9IMVBNeExDWFJqYkNZNFYzQUhR?=
 =?utf-8?B?ajJmOFlITTVobWRuUzYyRlU1alI5ZXhUY1lIUHhqVExOU3piRlBrK1puTUMv?=
 =?utf-8?B?eUxsSmVzMU9pMlh0K0trZ3IwdjdsWG55Rm11YnVnWEd0aG1hRU50K1JnbnRF?=
 =?utf-8?B?LzBZRStRQXpLRkxic2NwVHNNemdZWGc4KzBZOXNNYmtSZ0pZc3M5c1oycEZW?=
 =?utf-8?B?VDR0dS9iSUFrcENRaGVSeDJaVldCOUs1YXIvY2NUZUVCYzhNem82bWR5Tlpj?=
 =?utf-8?B?bnBLSDIvQ3AxaDdQMldDY1hOdDVWR282N1ExaGlwNUovejlYbWpvNit3QTJx?=
 =?utf-8?B?RE52djUyemRPYm9rSXB4MGYzK3RYS045ZDY3a1RhNThpZFhyM2ZobWNhTlNi?=
 =?utf-8?B?TUJwK2txbTVlYUZ3cEFuZ1FRdnFQVlk4SUZGbE8va29DbmF5azN3Q0p2NEw5?=
 =?utf-8?B?UVljazFHbjViaU9VVnovdDRrd0hvbWRUUUgySW1rYyszZUtLRkQ5OVRuN2Vs?=
 =?utf-8?B?bVhDZ1g4SFZaeXVnaE1kZTFHSnkyRWdEZVJtcmNWYVI3YkhyZkNNTzhvZXB5?=
 =?utf-8?B?T0JabDRGaEVQOVZQdHRJUHNLNnFCTDIwUkFMVG5kLy9nTmNkL1U0Qi90NmY3?=
 =?utf-8?B?NElGMEYrdHdmb3YwQVVLeE40cnRXakhrSUhqZUEyRWpPSElxM0pxOXlhYVI0?=
 =?utf-8?B?K2F6dDV4VTUzeUNYcGJpS0dUN3pSU241TS9zTTNzWSsyalBjMDJxOFg3VXQx?=
 =?utf-8?B?VlpZK3lzSDU0a2ZuK3M4ejdoMnM2SUZCTmZwci9oUVRVR2Y0clBFUUREeTVh?=
 =?utf-8?B?ZldsbE9LOU96MDRXT2tLRXQwNStKUWRCR3dZWndTNFBhUWE3ZnN0dEl6bmxp?=
 =?utf-8?B?dUZoelVYMGE3Q2I1d0dLeVlkamJxeU9ncmIwcDZLbVRiRXpYYmRFdm5VUHp3?=
 =?utf-8?B?RkVOaExmTisxT0ppYnM1TEZlVERzZkdQVUFmc3VLZktUcEE3Ykp0UjFrZk5I?=
 =?utf-8?B?Znd2dUF5VnJzMGh4YkdiR0RhSDVrVTAvb3h3NENhYWpVd29ZdGc4YXU4ZjZy?=
 =?utf-8?B?cjRvbWtsWGQ4dzBsMjRPbWRoUEZsZk40NHZoWExzL3NkdlA4dXJTU05rSzlk?=
 =?utf-8?B?dUFwa1pENlZ3ZzBBMHcwQWw3TVBZMDR6SFY5aVc5K2MwZTZiQTVZM3dGOG5i?=
 =?utf-8?B?THFYZE4xS3QxTWFDWThjd05IclY5TXN6cm5lYUtsT3Nvd3Q1ZzVZRkNOQzAz?=
 =?utf-8?B?Vmw1cUxZVk0wRzIvYU1zbHl4NGNvR1VwcnVMVXVUMFFGOWhIb01wQThDTFJC?=
 =?utf-8?B?UXdBZUc4TVM5RXE5ZWF5akIwZWtucFBOT3ZlbER2TE5lcWJCcVBsZDloWW9O?=
 =?utf-8?B?M00xejNPeEZrRUo3anhMcnlNRDZRdS9yUXFTc2pYYmZFU01XZGFpNjBjNkJO?=
 =?utf-8?B?a3c2WlhYY1hxcHZnVitjWUNjN3pzR29lMkl0ZTZkRE1OOGdkak0wWHFrQ2pn?=
 =?utf-8?B?aFRwc09yQUxNcFpaZ2pZS242MFU5aS94MjVsVmcrZzQ4MFlXYzk5YS9tdnhl?=
 =?utf-8?B?L0l0UlBncUVCSVRBdEdVRDg1ZG03OC9nRnZXM1NxcEF1UWc2OUR1Y3ZrNE1y?=
 =?utf-8?B?RUZiVUUwUmZ0c0xwZTBLa24wMGdrOU01T0lBdWllZ1lCNTlnNk1sT29YT1Zp?=
 =?utf-8?B?YUg2cUdPcXMvK2VjM3BLam5QVkdPTDJITGhrb3NuRnptOWhPSGJGRXFRcjJU?=
 =?utf-8?B?Q2x6dXdvWnlOcjZUd3BoZC90Mk9qZTNhVGJKNzhVVm52K2x1WnArZml5L1Uv?=
 =?utf-8?B?dWs3MzBLeUg4YzN1cGRBMGd0TUtKc2pvc0ZvdnA1M1R1Q3hqU1FhaW96djFE?=
 =?utf-8?B?ZFVpQkFEL3o3eGpQUzBlYzRNc1Ard0lNTkhvNHdqR210V2ZUbFRZTWRqaTNS?=
 =?utf-8?B?K1RheHZIVms0Sk1Lcnk3Q2F0ajlmc2NLVDVuN3MwRG9Dc01WWUNrMVdHYlli?=
 =?utf-8?B?emh1dHovR1YrUmM2VDdaMmI3UjR2NUt2RDFuMlB2SHVrNk9waVBUbGxCYXBa?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6054e20b-5c85-44f7-b872-08db72732765
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 16:18:31.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hm77dqEOCWyHFYXCFckKrJn1ekBL21Oy9JPQI4qggcfx/oW1R4mKj1c6OYLWDL2sJR7DogSP2OCR9SLJAIshgp2jh6kVA6pfx8i5fuDSdP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9449
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On 21.06.2023 06:31, Jakub Kicinski wrote:
> On Mon, 19 Jun 2023 16:28:51 +0300 Radu Pirea (NXP OSS) wrote:
>> Subject: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP interrupt enablig/disabling
> 
> typo: enablig -> enabling
> 
>> .config_intr() handles only the link event interrupt and should
>> disable/enable the PTP interrupt also.
> 
> I don't understand this sentence, TBH, could you rephrase? >
>> Fixes: 514def5dd339 ("phy: nxp-c45-tja11xx: add timestamping support")
> 
> For a fix we really need to commit message to say what the problem is,
> in terms which will be understood by the user. User visible behavior.

If tools like ptp4l are killed, will leave egress timestamp interrupt 
enabled. And I would like to say that I was able to trigger any bug 
related to this, but I wasn't. So, I don't have any bad behaviour to 
describe :)

However, now I realize that disabling all the PTP IRQs is not a smart 
way to fix this virtual pseudo issue.

> 
>> CC: stable@vger.kernel.org # 5.15+
>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> ---
>>
>> Where is V1?
>> https://patchwork.kernel.org/project/netdevbpf/patch/20230410124856.287753-1-radu-nicolae.pirea@oss.nxp.com/
>>
>> Where is V2?
>> https://patchwork.kernel.org/project/netdevbpf/patch/20230616135323
> 
> This link looks cut off.

https://patchwork.kernel.org/project/netdevbpf/patch/20230616135323.98215-2-radu-nicolae.pirea@oss.nxp.com/

> 
>> +     /* 0x807A register is not present on SJA1110 PHYs. */
> 
> Meaning? It's safe because the operation will be ignored?

Yes. The PHY will ignore the writes and will return 0 on reads.

> --
> pw-bot: cr

-- 
Radu P.
