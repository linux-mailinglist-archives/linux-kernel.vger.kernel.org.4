Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9F64DD24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLOOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:51:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2115.outbound.protection.outlook.com [40.107.243.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BDB69
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpyOq2jCCQHu2ef7nwcdcBlDvak5XsdxNHdfNq4xOuBEA6kI/6Ben65izwpiygC3vyFQCy7aAtJbMuV0H38A9dmFnmmQwztiHDPcxQvTGvEoMglNpFJS6CezZPOqnHqqGF4k9L5wLYo31zmew/9Bj4MPi4Gp1qpzjlxrhHK+RTxYpi1A2Sq3/mi0pULT6thZNfmAYMJkhsFTT/Fh8g4n1Frb8S2/xKXuCXGS/3f0miTTw3vw1Q7j3Z4216BNvDhFNQ/JqTEP1l3/4CBVMfrv6qgsndYS+nQjo/FKoeeR1jZpT1TgUTdlNfJSEZJx4K4yqicmAufd6X2qjm/o74yzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfVnoDsIdIMhQzIj91Lu7ya9KDVwBQGhGt5s1HeDCi0=;
 b=aK0EMpQbl1xPYurLLlou/F3oeLAQkJtHkbGphwHEIhfO9yNkOauOm+A7wnz7gJ7U7+W6q5Yqjz+i5QMgV4NI+e8d7pLshzndqZDbQdlEfwovmpwOadhaRiC1J+87Tj9IZsoxCKXaRRvDbzVbbA/6YiNZ5rbpJ9Df21Mrrgf/zPmw/zrns5+pJIJofHp+0Y7Lc78oLZqLu3FJUBRlKlmAyKT6Yz8jQvRZjQue7IcAG7j8sSfA/qkncBH1m1pHWprx2WBsgcVOy6OT4Emxd/oePaKVAhV3DCmYq/PunzpGNkQwmRfihd5ttPypj6zJDdYXAZh3IW3aU+pW1ojBJywXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=designlinxhs.com; dmarc=pass action=none
 header.from=designlinxhs.com; dkim=pass header.d=designlinxhs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=designlinxhs.onmicrosoft.com; s=selector2-designlinxhs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfVnoDsIdIMhQzIj91Lu7ya9KDVwBQGhGt5s1HeDCi0=;
 b=C+QIeEez0Kyb23H279hneP/QTnlBXM3w04UQbHSq0jTkbXO4ntEIfbyBUFZu+TTJbJJKClQGPBkeTYewZkqftUf/DmnxWkEgF5ct7jrDdKD9QNDLhJfsHiD2Pkvk+4ccQHAJQdM1cE/DAC7w03cH48rNjuvLY/4kbvyC5CZpwzM=
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:a03:3f3::10)
 by PH0P222MB0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.13; Thu, 15 Dec
 2022 14:51:37 +0000
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731]) by SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 14:51:37 +0000
From:   Kenneth Sloat <ksloat@designlinxhs.com>
To:     Michal Simek <michal.simek@amd.com>,
        "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kenneth Sloat <ksloat@designlinxhs.com>
Subject: Re: [PATCH] pwm: xilinx: Fix overflow issue in 32-bit width PWM mode.
Thread-Topic: [PATCH] pwm: xilinx: Fix overflow issue in 32-bit width PWM
 mode.
Thread-Index: AQHZDjEU5N5gzAz0bUac4Z7MejjYMa5u39OAgAARlyqAAAzfAIAADRjH
Date:   Thu, 15 Dec 2022 14:51:37 +0000
Message-ID: <SJ0P222MB0107D344C48E720DBA945367A1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
References: <SJ0P222MB0107F467DDDFB7392B04056CA1E29@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
 <672b1277-545c-27f0-a086-b47ce002d498@amd.com>
 <SJ0P222MB01077015D90D0B2D7F995552A1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
 <10a8b1d3-e435-0a6b-9241-2eb660f6c94f@amd.com>
In-Reply-To: <10a8b1d3-e435-0a6b-9241-2eb660f6c94f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=designlinxhs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P222MB0107:EE_|PH0P222MB0160:EE_
x-ms-office365-filtering-correlation-id: 6c6b6c04-2f0d-43ff-7916-08dadeabddf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XphensiUTekkthWhnp1QnWZO/D7TLy4TiXFpqXeNPGrPZRVrDJO/p2pUt6r6/68SlEzMaYu7TWXR3jNO8aQDfe7sSG2aD0GFjVbLZd0Dpmc2R1ltvPKnjo5HutVix1KlMn4RFJuZ3XiR73cKi0Vk74GtiEzWe+UZler6nqCXesUU76410yWMBPcveqyFkHBFMc5kESMOhXxgW57Q6JG2JtwyySkY0f4RF+BS0R0w5QtOuyWr4aOX2qtw5m4eSgx2aX41oiLDuDtGFIPoFx9Tafct53PmBoUQ2tipVtejUa+fR8mUbzdLozEnGFY7Ptj6zNipLew17hJPwdjc7edCmvRW+3ckAM5bOpqTwn/rMSu0xeZK7JUZ9c5rIken+01jwGrsmaOrZLC+73ync7oAMMfYrjd99Aaa+8q6U6lRJLClUqU37E93fymplx23sX8br4KTIrio91lQCUeXrh7O2uvT8M3oWznrjFcLnz9SQK9VjN5BgD1Ajl4iguwx9geOLZQmiu/Y9eblqLR6vRjnxV0OF0cPO7JJNF4dY+mRupwMdQuLTMmP8IIl1jQfUmywaE7VBMzn+FQTyEDtbJv7FORraVFT4ov1RKVqeDRDMxXed3Opn6nIKO1gflOKFEphJCLOWAHl1KMcPqVX1ZI5tz+hk02aqUCZG253YiQYmDor9BH2VTNt/mKY5P7xfkwBGsAlziYjXYgJm8Ljb+dKbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39830400003)(396003)(366004)(346002)(376002)(451199015)(71200400001)(478600001)(53546011)(26005)(7696005)(6506007)(186003)(9686003)(83380400001)(110136005)(38070700005)(52536014)(55016003)(5660300002)(91956017)(8936002)(316002)(122000001)(41300700001)(38100700002)(33656002)(2906002)(86362001)(8676002)(66946007)(66556008)(64756008)(66446008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tz9SjhkpMOXU3w2hbjn3HMNatO3LZNJzJEiZg/+bW2vlZG1u8xfQ4d/QjF?=
 =?iso-8859-1?Q?E+xt0lDsKqXkzWfL2t5svuU0FpbD+0z46CpW3KOMW7o/W0f5DpkiyDKTWM?=
 =?iso-8859-1?Q?Xp4Sx+TH2jImnwMKxgBXuljdZLIduF8UgUTPkED7NscIpYmr1p4vw0kHw0?=
 =?iso-8859-1?Q?frkG59W+mWPEepEYdjEY2EYn7KoTUq/lg/ZY9ITETbwYyNh+BmHg9GWb9Y?=
 =?iso-8859-1?Q?V5N8fshyI8ePL0gh6q92TjhJBfaNfZATuoP/bt7xfqZ0Ojx1CXoCuD8rh7?=
 =?iso-8859-1?Q?ASYYcV3hUT2UwARDKHCFCDcJ02l47uS8dCU0c2U8yqwCgsjsA1SGucAmkl?=
 =?iso-8859-1?Q?dl1iV6pc7Y6oOysIhi1mgIQEMkka+9dduu7cY60nI5bg7r9oGwCNogT4Ur?=
 =?iso-8859-1?Q?/cYEXjrhgQyzy5elC/ggqVssBVkVM9YIzQrtS7kwpqJJ1C76YOs0cxxPfv?=
 =?iso-8859-1?Q?BzASPt3eOhHRyFAxAgdVKuEcpblaZ1JiCYSFsyytiEdsn67e+gI2qpH3XM?=
 =?iso-8859-1?Q?ZnDblRRPM2BI4uMNDKrChIHNhsPF3vuLsTz2FBZ8hDCOGgvukb6G/JVD7G?=
 =?iso-8859-1?Q?Khv3AhBhlyxI8wwq/4MWBnL3VV/1nCKErQgoIbqePB/byB+R5Gfxe5rGhN?=
 =?iso-8859-1?Q?DvscFRkF+FvduWU+bC0YjLcTe4JNV/kL3XjD5yz2VZ23BKL5bkEFv79y2d?=
 =?iso-8859-1?Q?XbaijxyrFhy8KX/eXIAT6t8bktSnsAr0/IpC5ZmFEvzb0jjX9/rWVcT8pP?=
 =?iso-8859-1?Q?g9nUZXmRXV2B+UextaYWDQSWttAIneR+Dg+VNBmRelVruevu18fBanIXuP?=
 =?iso-8859-1?Q?3yeOp8M0QWVXo7d6MHaxyxrgfKQevZXwmnCf7Qi0A3AaBuZWHuy6WdkKGr?=
 =?iso-8859-1?Q?JJe60muBjNvlsQMaY7tuIO8kaNY5zCxjlZoP5Msd67u3FQeukDZ6lKh0Yp?=
 =?iso-8859-1?Q?c62KQ4VWK41GMh5QjIfkIIa7L1c0WXCA8+2kTA/salJwOvVZdTMjI236Zn?=
 =?iso-8859-1?Q?BGlPDigKOhZRKyAiG9rNGgde/exoNzDSqZDnqDg/RlIDvZ0BAHpZLdEtMD?=
 =?iso-8859-1?Q?REBx0NAaWmF5KcmcHUl6WquoMoeEqKb5NiutyKpm06N9Gk0LbNmhgps/0+?=
 =?iso-8859-1?Q?LgLI/LZ74sOy/klu7y8aXbXp7cBSe4VWxGLnxlKig5UcMIAk+sD+T7Z2et?=
 =?iso-8859-1?Q?PUZNgdCngTTyfr7zitR2YHgHlieCm3UARsS7AbUDiB73PRMp5CGkwdEpv7?=
 =?iso-8859-1?Q?dKnkztWXwp3ziH1CWcccniejzHsVou+zIN5lIP08CjzKyf1sV9euNl1WvN?=
 =?iso-8859-1?Q?+NmeNGHKSd7NPS9fS5oMVO8/7+HwezAqWyGtCS/amae12zQ4yF0dUmnS/F?=
 =?iso-8859-1?Q?Ao+fGhrF3fr9xLKlKOa22KnEQnvfelZz9cYQO+9WGgm6+uafHdWImHM+ph?=
 =?iso-8859-1?Q?g/eHAlU5iw5HxMaXVEM+aQQi/Z1n1iLwwD4j5XaUfHW8M79Lhv8YxM39Iw?=
 =?iso-8859-1?Q?xgOHnWSOvQFDg95CbiGdomvGNgA4VQOuNGKK8+Yx3EC/uI4OSfASM2FimW?=
 =?iso-8859-1?Q?6+99xlC9WzndzfzPqg/g3CfdELMNU7O7JcUAJM7THYksZ25P1bGNdKsAbp?=
 =?iso-8859-1?Q?XMQdj99xLj/VPwF1GXOI2Um3sOKxsQ5EB8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: designlinxhs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6b6c04-2f0d-43ff-7916-08dadeabddf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 14:51:37.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 21db78a4-85a8-43a2-9030-593b170ddfa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enYa2Hgci6YoH2SugCgE7NgtRk/SSRFoDtyNUyO0jG5IS/qVsBzB+aTtXiKFKr+E29xqJyPaUFcJaUwMvsQjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P222MB0160
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,=0A=
=0A=
> On 12/15/22 14:43, Kenneth Sloat wrote:=0A=
>> Hi Michal thanks for your reply.=0A=
>> =0A=
>>> On 12/12/22 14:59, Kenneth Sloat wrote:=0A=
>>>> This timer HW supports 8, 16 and 32-bit timer widths. This=0A=
>>>> driver uses a u32 to store the max value of the timer.=0A=
>>>> Because addition is done to this max value, when operating=0A=
>>>> in 32-bit mode, this will result in overflow that makes it=0A=
>>>> impossible to set the timer period and thus the PWM itself.=0A=
>>>>=0A=
>>>> To fix this, simply make max a u64. This was tested on a=0A=
>>>> Zynq UltraScale+.=0A=
>> =0A=
>>> Can you please be more accurate where that overflow is happening.=0A=
>>> I see that value is set only at probe like=0A=
>>>=0A=
>>> priv->max =3D BIT_ULL(width) - 1;=0A=
>>>=0A=
>>>=0A=
>>> No doubt that there are calculation based on u64 types.=0A=
>>>=0A=
>>>=0A=
>> =0A=
>> It actually does not happen in probe but when applying the PWM settings,=
 here:=0A=
>> =0A=
>>=A0=A0=A0=A0=A0=A0=A0 period_cycles =3D min_t(u64, period_cycles, priv->m=
ax + 2);=0A=
>=0A=
> ok. It means (u64)priv->max + 2=0A=
>=0A=
> will solve the problem too.=0A=
>=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (period_cycles < 2)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ERANGE;=0A=
>> =0A=
>> If the timer is 32 bit, priv->max + 2 will roll over to 1, and thus will=
 always be rejected as out of range. So, likely at minimum, a cast on priv-=
>max would be needed here first.=0A=
>> =0A=
>> duty_cycles would also have the same issue:=0A=
>>=A0=A0=A0=A0=A0=A0=A0 duty_cycles =3D min_t(u64, duty_cycles, priv->max +=
 2);=0A=
>=0A=
> and here as well.=0A=
>=0A=
That is correct=0A=
=0A=
>>>>=0A=
>>>> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>=0A=
>>>> ---=0A=
>>>>=A0 =A0=A0 include/clocksource/timer-xilinx.h | 2 +-=0A=
>>>>=A0 =A0=A0 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>>=0A=
>>>> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/=
timer-xilinx.h=0A=
>>>> index c0f56fe6d22a..d116f18de899 100644=0A=
>>>> --- a/include/clocksource/timer-xilinx.h=0A=
>>>> +++ b/include/clocksource/timer-xilinx.h=0A=
>>>> @@ -41,7 +41,7 @@ struct regmap;=0A=
>>>>=A0 =A0=A0 struct xilinx_timer_priv {=0A=
>>>>=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 struct regmap *map;=0A=
>>>>=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 struct clk *clk;=0A=
>>>> -=A0=A0=A0=A0=A0=A0 u32 max;=0A=
>>>> +=A0=A0=A0=A0=A0=A0 u64 max;=0A=
>>>>=A0 =A0=A0 };=0A=
>>>>=0A=
>>>>=A0 =A0=A0 /**=0A=
>>>> --=0A=
>>>> 2.17.1=0A=
>>>>=0A=
>>>=0A=
>>> Thanks,=0A=
>>> Michal=0A=
>> =0A=
>> Are you are good with the code change as is? If so, what do you propose?=
 Should I amend the commit message with more details about where the overfl=
ow is occurring?=0A=
>=0A=
> I would update commit message with both cases with simply saying that one=
 way is =0A=
> to recast priv->max calculation because type is taken from priv->max whic=
h is =0A=
> u32 and one way to fix it is to recast it or change the type.=0A=
> And that you are using second approach because it is more cleaner.=0A=
>=0A=
> Thanks,=0A=
> Michal=0A=
=0A=
Agreed that changing the type of max is much cleaner and would also avoid a=
ny other potential similar math errors in the future. I will update the pat=
ch with these details and re-submit. Thanks for your feedback!=0A=
=0A=
Sincerely,=0A=
Ken Sloat=0A=
