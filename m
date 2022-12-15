Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69164DC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLONoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLONn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:43:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17B5220F4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:43:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9TkrFzPJIeuLt//Tqf4vmNiIVXkM/sxeoBDLACVNfiJ3j6bazbet4O0wIPXrzbyD5p0NSsBeV2wNd9DCd0fvJ6wEFQ7qeaw1hraUNYPi2IxBGZhjCyorV+Wtq3BoLcTah+XZZN6UOexPcog9ttpwQ1GMreGsG69NaRjwx6TodaSuoek7A5tauAgqJayTxKmx5izJ7Ybv/cxgcNhtCmOmyb/D28FV5tjG4GvfGD8zlKUebMnQV/DShUvLz1QUYUFNfTtq8Avib778oJcNOzjrIa2Pujdd3NWfI6oqTpD1F3d87G/RoHJ6sp1daZQ9sB4HsOGLQqlHE8GemC4zi35Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYySswvUNXLtwYAPaJlZxLYJh8es8twtxJTMCNQ6KsA=;
 b=S888QzuPP+963U7JhVB+0wuxtYR7FhYTE8sR4vsEN/X15kyWwQ9YYNt6eYvBDwnPNnPv4vmEwNQR7nxwdLCIfzNfqv06VpzYG5BTn7wLSKSA4yfTSFMOQboELunkUifnNz1HU1U3TxdHn3x+k2sAW69bUe6ud4K1+lnmweVlk0Ppy3J7q+QE7bGjvhTQmvlt66ULW1amV1wZfJSECGomX2rfU9OkotEHCmiFK124IWrJyVGpSkpDsgkYCMbSKtVKUCNevYldsaRF2ijgvTOWyDJ2kpQQF61RaS7kY5DkaRCcw//KseWu8yFN0DPhjYWEGJNJO5c/ES47kf/f/iSgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=designlinxhs.com; dmarc=pass action=none
 header.from=designlinxhs.com; dkim=pass header.d=designlinxhs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=designlinxhs.onmicrosoft.com; s=selector2-designlinxhs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYySswvUNXLtwYAPaJlZxLYJh8es8twtxJTMCNQ6KsA=;
 b=aDQ407Xv42MuexiT9uC8ocvHGIZWe7tdJpuWPtNm7v3uo+zo2MB1PZZ7b1EjlDtGAHF1BqW8c/R3GMzPSef/Z8ArNdmP7hL9J+lEBrdSPvN9emI7dF2TaRFm9ZIuGP9lv6r7eEfNi4AhEqSGeM6ka5ORhbTml44BBLoUIkAlXJA=
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM (2603:10b6:a03:3f3::10)
 by BL1P222MB0634.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:39e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 13:43:53 +0000
Received: from SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731]) by SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
 ([fe80::7c3b:bab5:a29:1731%9]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 13:43:53 +0000
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
Thread-Index: AQHZDjEU5N5gzAz0bUac4Z7MejjYMa5u39OAgAARlyo=
Date:   Thu, 15 Dec 2022 13:43:53 +0000
Message-ID: <SJ0P222MB01077015D90D0B2D7F995552A1E19@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
References: <SJ0P222MB0107F467DDDFB7392B04056CA1E29@SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM>
 <672b1277-545c-27f0-a086-b47ce002d498@amd.com>
In-Reply-To: <672b1277-545c-27f0-a086-b47ce002d498@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=designlinxhs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P222MB0107:EE_|BL1P222MB0634:EE_
x-ms-office365-filtering-correlation-id: 69b19e10-4ebe-46f3-4480-08dadea267c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/qWGkJtraCKIpzkYEc3d06J3ECWBaQRJjDNhK/JEPe+fhLo7MQIoleujImWe/s7tG9tzPs2BQ+nlXpaRM5l4Hrz/AR8XxZ2n0O0hRtv7jqB99szMTuLlqq+ItIc3GSbc2SPlFVyJ18NhG/dSNIR9VGrI5Z2NYa7fTMQsR8EvfP/Gx9b2D1UtJL4xV49zR2hxJBh7WyFhewYehD85n18zCiYI1+dC+EPSfWANfrsHW+MpovShW4HzzpUJZZtvCAP32Lz7+/Ew0HdyhwMCpMg3wcYwtah8ijXGq+AchPhEysc1263tYy7gpMQULi1E2pUC6JYJOlnxtiACtRFoWV55b86SdNTyhPVnQuNfyUwfu83Fw0cUpWjI9fjBnSBBJlqZPK/dWMtyuieJ4Lrx+B5HRicmU2kgdXwCm+oW4PcynN4ljxrBd/Cs3gYVz9xSk2S5mjEQnBP+NIbzFkCzgm4zITh7x6oA5WODREKrXroFpVY29jX3ldqDQzaFwHagSaq8nbZ03vsAq9wTDrWB9aeHNpcDBKsWZ//LgqpPgz8rQkH/s9kpCBVEwXJUyXOY5MpSHFIZDERqH43FS6PCom/dsksUJ3aAPN8noz1RwpV/vbUtE8kwjR4YeH1yCf1tPCihPkh5F49hxXOpZzTQNZc6+SqTGFTWleqMduoW6SstJ/MIGd6cF4jMJo8SpkMIb1OYnkclL5OCRDw71+IUKPZEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39830400003)(376002)(346002)(136003)(451199015)(33656002)(2906002)(122000001)(86362001)(5660300002)(8936002)(55016003)(38070700005)(38100700002)(52536014)(83380400001)(110136005)(316002)(186003)(9686003)(41300700001)(26005)(66556008)(64756008)(7696005)(6506007)(66446008)(53546011)(478600001)(76116006)(91956017)(71200400001)(8676002)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n/3gqsxJcIAxSp05fMv4sfTikN1yHcagLUygfy+j/lNQl6efGwz4/0c9dg?=
 =?iso-8859-1?Q?PNILtLR5zdEd0YGX1E6MuJiTCZBEnYQPQtzh436Efk6slzVztj+KyCBpr8?=
 =?iso-8859-1?Q?eB0nf6XIUnpR7oq4xnM5ZuWxpLvP0lcuvONgvu/wsWmSegXc8LQTHVQJJM?=
 =?iso-8859-1?Q?nJ22+GV3d+K0AOOb/0cvjD5plYuebxqTj66KUZ40PBpSXvwMqj2xeXPMVz?=
 =?iso-8859-1?Q?aar7WGJUAIFkXvIwUvKDEaHP6pJenFkTN9zg98mCmDiSP5/4sEB/WEhPfZ?=
 =?iso-8859-1?Q?DKt4/s91pR/G2UQYbbH8xJux9dWaiKoY4hLdHSnf59jDij8RxJJTE/6Qpe?=
 =?iso-8859-1?Q?fudi/6LDQVCrap07unIOaY55lz4d0EcvuBtAUnLsbunDGgpaYuOmwQ7TIk?=
 =?iso-8859-1?Q?I5vsbIWWsarmx1k7vg63TCtRlVbTMKaS5M4QMZ20Htp0JvvSFhY1+q7ieB?=
 =?iso-8859-1?Q?8vly2Q9lcrluWbjpT+j1KBc8KdXu7Ln5XMTYnUJtbn221Sfb1EQivPRE/X?=
 =?iso-8859-1?Q?0GsjlNB2K7V1DoeVWQAkRUIdVXW+Hv8HBGhxkm6p+hFmn6ea59o8LgMYfE?=
 =?iso-8859-1?Q?sT62LfmBPFscOtjiFdFmRNCOn2mTq9KjQfkLTvnd8Jpe/Ki45RyWAcX2K6?=
 =?iso-8859-1?Q?P8LwE5puOhRF63zzelLkKtSa75W+NEkapIvE0OtI43eUwpawnw2W1AKF5r?=
 =?iso-8859-1?Q?bH86gDUT8N5/RnvPHtV56MoKUT4mJgwV0TVIpyYSLaiDntrhRZ5So9a8cz?=
 =?iso-8859-1?Q?ppHIPZLP0G+iNxYn2aQYZPewqZi6+BBsQqS7YyuoicHxFYnPBHOoGIbDqp?=
 =?iso-8859-1?Q?JQJpt9sMir45Vp4frgRlpYapeaqEu6PifuLNcXPedo5+mhKHLn00V3VAxF?=
 =?iso-8859-1?Q?7lfBuweu7qY2cWsrL9Om2fnStEzNE0R/VP8+xNVBhGytyjyxy2IZyCOlaR?=
 =?iso-8859-1?Q?ILL/GDYJVy69CI3sPMJoTo20x+ppHFTa3aUgG4XTJSxPrNFTXZnGZFQT4x?=
 =?iso-8859-1?Q?8vzC/43thdgRuuREHZAQ/DLf4QWFQbQLgqh3aE7TO86f08akZ8aNhs65WN?=
 =?iso-8859-1?Q?zafIZO0aTI5d6xjA5upYlVPyvAPB1JuUqoDkzKjGFHsKlkcaTooIGnWQUX?=
 =?iso-8859-1?Q?GtRfS1beagyYT3Ei+CgtcmWzzls5w8UC/oFspTFIiMIiQjnD4MocwYq7ba?=
 =?iso-8859-1?Q?BqzI7T6OpJCCodDdLsPtgESdF7PafCEsdytPSPhFSsWbvRpurb3GTNhYdn?=
 =?iso-8859-1?Q?2HiusB50mtxMe2NCXRp5BpPEuAmqbCeC2+5G5lhRqm5AmcwfMD7QJPitr9?=
 =?iso-8859-1?Q?3VyBsWDMgF6tGqvg9fbVoANPALDW2QPNxy6BOOb4YStMPH6VGQ0+gfZUDs?=
 =?iso-8859-1?Q?jfc5nMO0ZPeGGktjN1B2Mpj3v+mole7wp9j9Yoa8jWUxCFSwNL0cwWyFTM?=
 =?iso-8859-1?Q?L1YyTG+BIIrj9dwVpl579Ovhqgt0eNn6WyEAPMUibIJlely3vwOcRX2je5?=
 =?iso-8859-1?Q?R/N8eAqzA9Kd9Mra96+Ee2daBsTsVKKo0PRVRNBUS1rSz1JmL49TUf62oG?=
 =?iso-8859-1?Q?as0iTcOKPwOT4os6kHTaaCucVIDkEPprtJFh2WY3wxC02uYYlDx+/sJbPG?=
 =?iso-8859-1?Q?HOuPkWFf5npwZIhG/1wf7HdW0ksGGSyC67?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: designlinxhs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P222MB0107.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b19e10-4ebe-46f3-4480-08dadea267c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 13:43:53.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 21db78a4-85a8-43a2-9030-593b170ddfa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkpP2Jua1tV+FVNJljSi53Nz70EHyulimAbCI7SCJUFo83//fraEebqiBHwp24jDQ0O2aFpfBkNmA7dY4hhFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1P222MB0634
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal thanks for your reply.=0A=
=0A=
> On 12/12/22 14:59, Kenneth Sloat wrote:=0A=
>> This timer HW supports 8, 16 and 32-bit timer widths. This=0A=
>> driver uses a u32 to store the max value of the timer.=0A=
>> Because addition is done to this max value, when operating=0A=
>> in 32-bit mode, this will result in overflow that makes it=0A=
>> impossible to set the timer period and thus the PWM itself.=0A=
>> =0A=
>> To fix this, simply make max a u64. This was tested on a=0A=
>> Zynq UltraScale+.=0A=
=0A=
> Can you please be more accurate where that overflow is happening.=0A=
> I see that value is set only at probe like=0A=
>=0A=
> priv->max =3D BIT_ULL(width) - 1;=0A=
>=0A=
>=0A=
> No doubt that there are calculation based on u64 types.=0A=
>=0A=
>=0A=
=0A=
It actually does not happen in probe but when applying the PWM settings, he=
re:=0A=
=0A=
	period_cycles =3D min_t(u64, period_cycles, priv->max + 2);=0A=
	if (period_cycles < 2)=0A=
		return -ERANGE;=0A=
=0A=
If the timer is 32 bit, priv->max + 2 will roll over to 1, and thus will al=
ways be rejected as out of range. So, likely at minimum, a cast on priv->ma=
x would be needed here first. =0A=
=0A=
duty_cycles would also have the same issue:=0A=
	duty_cycles =3D min_t(u64, duty_cycles, priv->max + 2);=0A=
>> =0A=
>> Signed-off-by: Ken Sloat <ksloat@designlinxhs.com>=0A=
>> ---=0A=
>>=A0=A0 include/clocksource/timer-xilinx.h | 2 +-=0A=
>>=A0=A0 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>> =0A=
>> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/ti=
mer-xilinx.h=0A=
>> index c0f56fe6d22a..d116f18de899 100644=0A=
>> --- a/include/clocksource/timer-xilinx.h=0A=
>> +++ b/include/clocksource/timer-xilinx.h=0A=
>> @@ -41,7 +41,7 @@ struct regmap;=0A=
>>=A0=A0 struct xilinx_timer_priv {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct regmap *map;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct clk *clk;=0A=
>> -=A0=A0=A0=A0=A0=A0 u32 max;=0A=
>> +=A0=A0=A0=A0=A0=A0 u64 max;=0A=
>>=A0=A0 };=0A=
>> =0A=
>>=A0=A0 /**=0A=
>> --=0A=
>> 2.17.1=0A=
>> =0A=
>=0A=
> Thanks,=0A=
> Michal=0A=
=0A=
Are you are good with the code change as is? If so, what do you propose? Sh=
ould I amend the commit message with more details about where the overflow =
is occurring?=0A=
=0A=
Thanks=0A=
=0A=
Sincerely,=0A=
Ken Sloat=
