Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D8691A14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBJIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBJIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:31:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2B3757E;
        Fri, 10 Feb 2023 00:31:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2Pw3nhCuFx1qtbtOocn4b4oSoqPpqxLZK3hIF0p25GbBOvsC0Tt+3r/BaxgYwFAbqSqpAsalveVMb/8KUCd07Gpl/e9z9UtOhsOx06LBRMVuH41UI9It6APy6ZR1hP7AyJb5qdqu70rJVeyLLPZrL1YUtFv+OYI37yIB4Qm9Q4IIggmbM2Ev5XuVzRk9wJNz6X4yCxO0qU18H2Z8kdWk2yddudSyujm0LeuCdz1skLw+Dwo189tI2rJyhzItJwH0LVbIoHNrISKTyoKpOgyF9R+GWgnSr5MTnaTs6sJ6aOKCUkXWBSnO2i+jrGM7OBoYny6CCgHXGHFVsIZWQuoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mq086VnRWNdPyyG/e4IcmM++MbNEncmgGhhUbjqgF08=;
 b=FAIcFNx1nzzy88ys9qXuXjNQUHoQa/oOENYyJNpabS4i59Nv7ftWuPjchwqgnXKwg0DI5vQlDsyvcsUKnn+CigiOQ4WOtF3YBdPdWGKKpeqFhzcBHeEqr4glJYO9NO/8Zl50yQ5+Nw8NoS05doJGjNceYz8oaRg9C41PLrvS1hlQw1YCOe+FHdqtnW0iaA2S7Zs8yUzjhmaPB4sfTumMsTePWs0XCfwPdv4Wsn6ix14hnEIuo6mWUhkVw5jRhMD15Zxbe2b42Xh+oYGD40tgxzZ5CoBPkFcONSdDANoFS5e/NXZSZeEvenBqXQl/aMYTW4vJDKW+e8ZuoCtEPIypag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mq086VnRWNdPyyG/e4IcmM++MbNEncmgGhhUbjqgF08=;
 b=ZAtjnH8awBN57Kimy14FJZWTQfwu/jdkmRisvGk8pBoz1VNQx16yxOtbOBLWdMOdcIaCStYHCMou5GS5W0Nq4vOFl8acH2HWOIRE51dqs/54xSWdOTGMFwWT1uVNHBV4O6c9q0haIUsIXWIMSRPGW4dMBopa14V8TZarGfBQ0C89jyDWSRm3vw8v7MMgbWqPElDUdEwe6ZN8W2N2y1I2KzxCEqNXuqd5xuoweMV1Q/xni0uc9On/Z53B9QBMPIAYWAqZHT6dvrVcQKGN0K/uEnTc2VjMsAkG76ugygeOoDgHkyPFyyq4YjxZnu0cj+5hJCoXmmdzV5XtV5k0vV6ZAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 08:31:11 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::c035:85e0:77c4:e934]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::c035:85e0:77c4:e934%7]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 08:31:11 +0000
Message-ID: <4a45f084-7d33-59d2-8ef9-cb95e29866a3@nvidia.com>
Date:   Fri, 10 Feb 2023 14:00:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] ASoC: rt5640: Update MCLK rate in set_sysclk()
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        oder_chiou@realtek.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
 <1675953417-8686-2-git-send-email-spujar@nvidia.com>
 <87lel61k3h.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <87lel61k3h.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To BYAPR12MB3205.namprd12.prod.outlook.com
 (2603:10b6:a03:134::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dea5a67-ca68-4716-5d6d-08db0b4129f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWpQrM3RGsH/58qhqrB7npBz2n0cyo8sKtTqSbEpSe2S8n08gWmjNnnnfo35n16hpbIvUIzSL9c10Gul8XskqBx4bJPK+tigUCmvZbFbgYqZPp7zNXBbdKyZmKztPUB5oYbelvpTsdzEMPPR8bnUELCMNAPI4DzQnZWnL51JV0N3OJURz2psLO579rZ+vdnC/skW7P/KxQXT/L+gCRbBYCR86DYtAxeNteiAS0ykfz1tHBz8slflLF6OZl95GLNwrBmjvTq60dvDD+6DI9Bj7SGYBP3bYXEMxnYMtIvs+G8xjc+Mq3WG9lwenDo4CaKFo37h7ZXJAm2dDJTYRgC1JJulWKcckVCzFEEzWWLadBYXDBv3iJQqb8KSnMp7iDnQoGn82ZO2dPAZTn9gFsfGTVpj7WNsqgW4KVtPKhJ8u8dKyz90Yr4v9BIkY8FRrBark7ZWWC7gMu3EhgsLPqpTrdPwWkZgsbn6Hs3WT32oSiFZTS/L87EHISo/BUbAgcpT5aQKVIvfsnMl0n/Zt/DslMZaMb0nUJPE6rOVAFdusZuSDbhDQC134oTGjunU2JBaNxxV5WHItqSjLCbCBUaX6T9zT6FYtgkFuhgY4k5vETz0teIi7TaQ7kf1oOJugQd9d7N4f2uNc5Vbgyl7yz6jl5h8ZRXLwR4oh61vhgiWk4gv9kA/TSPpHSD9EL492xCpuIJnr2Sd4XlkpweJ7jMEMz1arVlwhVA4vaFLt//kKl3RmSr7R94E8oFahywhIlDCCuySy3J63HQpTUeB82Y8705NY8mDFzuQO9cN48K768CLJN6Z/puv2w02ULt3WkleWrzlslhgN8+IhG4qUpET5AQH/8bqPiKW+xopvFkB+Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(15650500001)(5660300002)(36756003)(2906002)(7416002)(83380400001)(66476007)(38100700002)(6916009)(2616005)(8676002)(4326008)(66946007)(8936002)(6666004)(66556008)(186003)(6506007)(41300700001)(6486002)(966005)(478600001)(86362001)(26005)(316002)(31696002)(6512007)(31686004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhpQURUUVd4cHdmelZrUkppYWN6amJLOU1Gd1FZaGc4cVpWanEyVkF1cUE5?=
 =?utf-8?B?YzdZV3o5VG1JTU1yRUdQUnh2UzBzTEMwN1ZIS24yYlk3Z3I3THhrVnFoSDRs?=
 =?utf-8?B?ODBYTHZNa0VuaUFLR0pmU1ppL2dLM1I3RHJieW1IMTdxT1RncU52RGRMalEz?=
 =?utf-8?B?akV5czAzZy9ycHVwM29Wc2pYRFE0VXJJMFNUNmI2b2t1cno0cUcyVFR5U3pR?=
 =?utf-8?B?cWJxSEl4cXVkUGNWdU1TTmRZRG1mMmZMbjlxajVDaWNwREpjZld3bzdJNWhL?=
 =?utf-8?B?ZlY4WC94TU92cGhOQzB4TndtZWpzaExER1hkVi9mOXNoMmJrczFZWWJBNXNs?=
 =?utf-8?B?b3NSNU9zb2hLMTBUM2xpRGFWa2szei9KWjkxT2NDTExUc3U4R3F2VnJNWE5J?=
 =?utf-8?B?TjZPRC9pRUpsWmpUcmJIMGdCWk05eFFTNmxiTXQySUt3MDVvSEJMZjRLVjdT?=
 =?utf-8?B?VlQxRkg0VnUrRXVTc2hMaDcvVm9CQ0hoNlV2eEZZVGI5czFZb0ZYSzlianJj?=
 =?utf-8?B?b0x4bW9qSzJ5TzQxRHpkMTNIb3lBNmhZSXo4TGZUQ2tNRys3Z1hIMWdvajJz?=
 =?utf-8?B?STgwY3FKMzlhS1NncDRtVlpSaHc2RHJhWnR6dm9PUTEzc281c3lyc3VPeVdi?=
 =?utf-8?B?S0J3d3U3djFqYmEyVU5VWDZSZzVwYWZxbXYveVhQM2hxK0hWcmdvWjVkOVRO?=
 =?utf-8?B?V2JtTzFHc3FkNmdQMm9KS1JxNWtRLy9WZS9tNnZURHROTUVOOTJjajFndFpk?=
 =?utf-8?B?N0FvMTFtd2VwbVdoa1U0T2FVa3hyM1g2MkFLT0N2ZmVuQ3hQTmNCZUR5TzY2?=
 =?utf-8?B?M1F2d20yYmFaN29lMnBuTHh3SWZvdkdFWGs2b1BkN2xCY3duejJ1a0dQR0V2?=
 =?utf-8?B?blhsWUNjSGJ0eUZxd05UYUU4OE5HL3pHU0w1T2VqS2FzVFFhNWZHZEpqWmYx?=
 =?utf-8?B?Z2FsV3p6d0o5dlYxa1VjcEsrN1FBdGVLWjB4VlJ0YVFUbjZvYk1IQkRYRnlx?=
 =?utf-8?B?SDNiWmpVbUZJb3M3WmVrRHdVT003Ump2eVRrUDFJTkJIQUs0RFlHL2luUmth?=
 =?utf-8?B?RmNuMnZudGkyVTYrbXBidzJIWWJLRS9xemh4eWdmVEJ5eXJrQlV1aEVBeitq?=
 =?utf-8?B?SlVBVDdwc21VaTk3ZzdGbkdNQ3dQd0Y3RTBrZ01NWlBPT3A0czRKN2V5dlk2?=
 =?utf-8?B?L2x1MGU4bzducmhoZm1TSUwwSmpOalRnNW9EYTl5NG4vSE83L3NvZWNuOS9W?=
 =?utf-8?B?YVVTd3BCcVB3REh4TWphd3NQdkJYc2UyQXo3b0RxYWNaQ3hpMEV2RFZwS1No?=
 =?utf-8?B?WHNOWThKeVA5dm1HdWFxbGJxTnVrSGo2MjVLRXgyOG4zSzQvNG5lbG9rSzNv?=
 =?utf-8?B?N1ZGQWgxWUxBRm1lMWVobFA1OU1xWjBzOEZKRWpzaU5UV0hzVXRqalYxTUxv?=
 =?utf-8?B?eWh4ZWFiZ1piNG5yaVRLNTgwdFZqaUxuSG4zTEZDSHZQMVRYdFd0QkVlMlZt?=
 =?utf-8?B?Y2Z4eTRWQWFUc1IweEJnN3RuNmYvOTQ5ekxCWnBZZ0ZEUjdoZm04ZG4zd0Iv?=
 =?utf-8?B?UThjcmFNTlFsZVhObEwzT3YxQWNBd3d6NGE5TjM5TXpTODJTcElCQk10Q05x?=
 =?utf-8?B?WGJDS0RPWmFPeDV4V09uc2tTODRCVmptSWQ4K0llODA5a1JqdUNIdXQvSHJz?=
 =?utf-8?B?YVBURHJWN29GWkdyUmRBQVZSZkRZSStsMlR4MUV2RURaL1FoYktxN3ZneHlF?=
 =?utf-8?B?ak84S3NMeXFqdmlkZDVRK0ZqVzlVR0VnZjFjRFFwc3ZMYjc4Q2NSejV4SnJ2?=
 =?utf-8?B?OTBxckxWOGpFYkxMaWVGdGhncTBNUUd1dUpMazBRaDR2OFpEQVN4Uy80S0Yz?=
 =?utf-8?B?Q0FLMUh6dWgxQUxLWWJYVWVRZ1Z4U3h0ZTQyQXNncnc1M2Y4U2gwSGx0cnBY?=
 =?utf-8?B?SmttTG8xam1ROWtHODFxTUN5WDN4Nlc3ZUlDR0lEUExQbnd0TStiTXF3Z0ZE?=
 =?utf-8?B?TmtoVmJZeEFlVEg0bUFXOVhvQTY2RWgvWm5lRjZlMVdQK28zWC90Zk43d1d0?=
 =?utf-8?B?RFROcjc2c2VDcmdxei9VUVhoZDdSWUlIaEpmSVAza0FMU0lzSGhXaDVESzdy?=
 =?utf-8?Q?jJ+3WKrBI5CRWlITr6wqZHMud?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dea5a67-ca68-4716-5d6d-08db0b4129f1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 08:31:11.7051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhnJO4AZR5SDpuSRXwYK5UdO0G2npcwmquyZ5MR55vYsE4VDNPlFieARRkAKQARUD2Osx19Z84eQxu8OYIym1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On 10-02-2023 05:12, Kuninori Morimoto wrote:
>
>> Simple-card/audio-graph-card drivers do not handle MCLK clock when it
>> is specified in the codec device node. The expectation here is that,
>> the codec should actually own up the MCLK clock and do necessary setup
>> in the driver.
> I have no objection about this patch, but have interesting about this comment.
>
> Simple-card/audio-graph-card both are using asoc_simple_hw_params,
> and it calls clk_set_rate() for Codec/CPU if it has mclk.
> But am I misunderstanding ?
> If it was simple-card-utils side miss, I'm happy to fix it.

The simple-card-utils driver does not populate the clock handle whenever 
the MCLK clock is parsed from CODEC device node. So 
asoc_simple_set_clk_rate() will not update the rate and clock 
enable/disable won't happen either.Initially I had tried to fix this in 
the simple-card-utils itself and it did break few things on other HW.
Please see [0] for relevant discussion.

Later [1] was pushed to address the issue I was facing that time.

In summary, the suggestion was, clock property should be associated with 
only devices and device driver should own up the clock handling for it. 
The machine driver can just pass the required configuration for it.


[0] 
https://patchwork.ozlabs.org/project/linux-tegra/patch/1612939421-19900-2-git-send-email-spujar@nvidia.com/#2647112
[1] 
https://lore.kernel.org/lkml/1615829492-8972-3-git-send-email-spujar@nvidia.com/
