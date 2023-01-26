Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019167CF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjAZPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjAZPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:12:12 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8636E433;
        Thu, 26 Jan 2023 07:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea2kgodCoBG7qFE2TLey844p1PcnH3brgrCS8QrjhIjpSa3SG3nL7U10oXg4qQe6KSHfsYVqjMc6/PfDaUfoOmUMqwVJ2UQVOsUMdBK0LIDcWziR3ysMhuBEeIxV2M+7qqySKnz72NjF3trMpbQYs5sGJw+bkuVl3UInLV/zK6mnjRyK+k/ZYTTkAw3YYIGQ9ShVifxjVGwm/kNmQAzxmeYuW4u4UiE/nkETsXQ/mPYjHYiFImhe9r6AV13tgMH9VeCcKyWTBKEd5bZpplc6obmVItEmTyByCWiJ3ltNefUAr3NJpeEjaWUG0jMKhJnx/bl40V3OQhZaedlaZK3Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFP1pq8dJBcK96bvE7WJkQf3ahwHyCtYngYjP4UYqfs=;
 b=hq2KK4VQQlib9Oye5410S/KtcbxTm6E09HjqF6h8Z29QKbTGFsHa2WU6PwGN2V1mrqsGW1PJpPceGsnbdwd1/qAHSxRtMyQObiWFw/VbIziOrbMgy/jsCAJG93Phmg1kJN7lXTlK0jo35PKoJgpdV/CBk8ArAGGF6fL0pGEEQx8glW0vt2Uws0jc7JngxXIx7uS8LK4xnr1rTk2b1oS6RyLOv138ORJ2XOR0iHFPGIkKJHAxVd541dTKzDqD8ssBZD0eVIJqAVcHu9czPYDN6F22n09OYawsjYVH//8BgfU2b7XAlyIZOhFFrwoD8gKq5dxigqL2c0SEgUj2Tih+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFP1pq8dJBcK96bvE7WJkQf3ahwHyCtYngYjP4UYqfs=;
 b=jnmADSmE5sozw62YYwjje/Fa2inK7Jft9OvDp6/V97ajex/MCw0EnY3/4TSUGU2DVcR2nEXF6z6s/Bvdp1agv3Tw68YgI63T67QfIkz6i+sjgcEQMRHmIkNdFoe0+8mgqrsHXBLZLLsc2u8BTdW/Q3TYCh0XwKtvV/2AqxjQ1WrmxMZQfabZuaROeoN/a+bIv4XGLbyvF88OSVNnWzptATGeG8uFvWp5rMkDpaCpQhTIghLwo+TWnIEviw7zVR+fWT/LXuMF4iqLYnWVyEPO89RUC2Wl/Ilg63dYHqxTOqrwQ9eqqR+9nViN3LrBeFNr7wLU87tcfRxheVn0lVdZpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by DB9PR03MB7484.eurprd03.prod.outlook.com (2603:10a6:10:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 15:11:52 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 15:11:52 +0000
Date:   Thu, 26 Jan 2023 16:11:49 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 4/5] dt-bindings: input: pwm-beeper: add volume
Message-ID: <Y9KYNSWwlJXPcw0L@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
 <20230126091825.220646-5-manuel.traut@mt.com>
 <c519afe0-0a6f-e262-7a85-a3072a828e62@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c519afe0-0a6f-e262-7a85-a3072a828e62@linaro.org>
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|DB9PR03MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: abf8b196-3195-4db5-26e5-08daffafa79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxJ/+0o0eOTzrfaLsAVME0BtBy+kQfIA9TvCSEZpzY5MUtdJ7Gn0I3JyUUgjw2EIdSEhd0TKdato0A8YENySJoe8FLwws/KqHGNHWJ97v+IA0mdXZHDwYHW16T/jFeYwmwDn6xVtQDQOMNTYzKywVqNHHX8aFKq3z3bB/XFKnwdUxS0U2Z81jqyWGvR+tbA2WjBv7Z8W2EL7Xgq4BCYAMPPZeLx1kkoG8+BBwQufVy9ThFD49cZLsOuO0uLUoCWAGswoeYPrN2WiF8Tb3dTO6JsVu/2P7SOwuZd2Anlh+/6GeDTZoNHoN3UDpPJRRpy9iYVt/968Aue7wBYHLpYPNzGt9gpDlxylvLpTqDTbyi1FGN04Ej8i5uk91Zx4XKf5inZjsheXA28HQV8awYzqiDwU4gQQPGsW/Nc4pD2AyMedqnZ/o1BQU9ZjrE0zydrcxY8ZMyExTU4Yb4cYCoBy6RvOkU7g+WO0zYOjyomzjC5W81Jf0XbeqfT2RU2yml4qSsmvTcud+qSi46mZ2dphkYIRGdlMmjn4xTEzRYqEP/OuXuPI1H5TWfXeCXLmZN5LDzhxNlvmjL8UW/A6t0Rmcg7pr2eZFSW63+VNVHq4rqCrHJz4diB7TGP1vX+9eBfw8+IB7Hchj4+mPuOSCdPThu+QjZ6WnizX9tZ/QRm7k5oKZmfxCXBNdNmh6CuYJYS3fBepdDtcWjHStW+R+QdbbVLnHt/ziERu4n6lOaBmwDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199018)(36756003)(54906003)(86362001)(316002)(26005)(2616005)(186003)(66556008)(6512007)(478600001)(66476007)(6486002)(966005)(66946007)(52116002)(6506007)(6666004)(38100700002)(41300700001)(2906002)(38350700002)(6916009)(8676002)(8936002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhDL2daNkdPRjFZajNVaStqRTVVMmRBdkNDU045NjBiMUwyL0ZnZ1huTFJU?=
 =?utf-8?B?M1ZhK3pXcU5XN01ZODhYU3Jtc05vNlZPN3d1SG9NV3MxaUNLVWIzWDh2YTg4?=
 =?utf-8?B?UXhya0JENFdzNXVMczRzOWVzeWkzOVh2ZTVjSTZadE81aVdYVlFXcXo5YVh6?=
 =?utf-8?B?M2loT25XQStidE1uWEJ2NVJUMUk1NGJ5c3pJNVl0eGp1Wm9BaGU0OFVxTGVo?=
 =?utf-8?B?bzJRUXMveGdnYmVrd2pCWWZWZjFnUi9YTEt2UkNVblZjRWFIY1NRS3dHVmp3?=
 =?utf-8?B?dkpFMDJQSTVDa1lkdzZMOUpzM1NScXd3YTROeXR5bGJxMmRZYStDNXZ1YlY2?=
 =?utf-8?B?a1VXYzdHeUJnRko5dVowRmlYdmhtTUF3T3lJQzNSd1lPQTlkTjZBaDdNcWUw?=
 =?utf-8?B?M1BUdFk2VFNPbFA2eWRURE1TaVAzc0QzeVd5ekJHUkZlb1YweERNWkcrN1Zv?=
 =?utf-8?B?ZHVBVTg0ZHlBSk5ZSWlpY1RUVjVGWjZFUGp4QXN5aGJkRi9XbWl0UnlNL1dT?=
 =?utf-8?B?RFN6aUdRVEIrV1kycm53SFNCRmdacVlrdHUwRlBwRWttcVoyQmlobklPK01x?=
 =?utf-8?B?ZjYwUUxiUWY3anJsaWZRNy81b2U3bXh2a2tVbEtRd0g3VWRCL29vSHZQaU95?=
 =?utf-8?B?YVdZamtKbFlsRVRVY3BWa2NOTnh4ZzFWU1RQTGxBWU84N3p3UFBib0p2Njgv?=
 =?utf-8?B?Tk1HSzJrNE02aUdLRVp5WFM3WGJHUHk0azJWSW1NTXpRcU5CYlNraGFNK1J2?=
 =?utf-8?B?K1g5ZmU2K3JlQVovYTZGZXFlNGp4MlV4bkRwTWVNSXdUZWY1Z1poc0lnc2lN?=
 =?utf-8?B?RTdNUmx3UDViM3AzSWltSGlDSVJVSDE2bU9yZmhBZWxMbDYvY0FYR2IwdVAw?=
 =?utf-8?B?M0wrSmZFa3RubXphbENnRmhBaHhlcUoxYzJTc3BKZ3BFMmtpR09NMTg4OGNC?=
 =?utf-8?B?SnVWTDUzQW4vK2lSSzU1WnVuc2oyWjlLM2xRVVJMUmpJcDBtMWFDeUgxUkUx?=
 =?utf-8?B?SmhRU3FTZUwremtTaUZNY0ZRUjRQNWdWVEZSMm4xTHE0TXgwUzFNNnBQOHpV?=
 =?utf-8?B?VlFRNnlCR0FId0VQUVZoQ2hhS3JuVWgrWDhsQ3VVcnYwUE5FUTg1VlFydmp2?=
 =?utf-8?B?NWo3bktSZVBZU2hEeTlqZ2c2eTNCcmVWaW94WnZaRVBYRnd6WnZxUnVCMlRY?=
 =?utf-8?B?UTYwVUlTOFZob1RLTC9ObDIxQW5IcWdranQvMVVTZkxJY04yVEExYlE3Wmlw?=
 =?utf-8?B?Si9yaFNzRlZnRmhQZHZSaUJVNG5STFlBRUhjazdxNmVMdXJLK29NSDE2dzVs?=
 =?utf-8?B?VGlhYzRYaW1nYTRFSG9menF3aDVtMlYvcGNERVNIN1lqRFVRcmRrVy9sQ1V6?=
 =?utf-8?B?aGt3eTRJS0hVTytZd3JWcGN3bkxJbTJBamVxaWsycmhkNDZMKzZyY2VLUTBu?=
 =?utf-8?B?RVhZWmJNUWlyRS82c01PT3Bnc0JhYjJjVkV5Z0JXK29QcEdjVGp2VlVyblQx?=
 =?utf-8?B?T3ZZOTVSbDBhcXRESFYwbkdLSjhsd2s1dEVOdFBaTnZ4cm8rUEJUS3RJdUFB?=
 =?utf-8?B?OEgwNHdhbFptWmk3YXd0TklZRTJEVGVjTjFIUmFIZlBwNjRDelphMnlNWjRm?=
 =?utf-8?B?Y21sN243bXFnb0t1Y3FDeFFlSWlWY2Jid0xUWnZ2dEV2blZnVStBdlRWVm1G?=
 =?utf-8?B?RWlhbllDWVpJZy9DTFhmak5DSDhKRkgybG5maG9JejZzdy9UaGVaREN0LzlV?=
 =?utf-8?B?Q0cycjVhS0RHcFYvSjB0Q0FBRytkcDh3ck14NlVhSmhZSWRLdGtzQ3BBMzZM?=
 =?utf-8?B?ZUxmU3FGbEw4aG04N2d6ODQweXI5NWExeDhadWpiZkJod2JsMGZua0tZYVh6?=
 =?utf-8?B?cU8rZWZjKythNWl0dkdHTDBqRTJwYXZndVRsSnJkTEFyVWVFUlUycTM0aURK?=
 =?utf-8?B?Z1p1MCtBaTVFYVlja2FoZFJuVzcyV29jUHBCYjZPUjdNOVQvL040WnNnTGtV?=
 =?utf-8?B?YkdsMzNNK3ROd1dYYVNsVTVkY2oxR1hTazdEQ3Q3Qm45bGhvaENxMm9HWGpQ?=
 =?utf-8?B?VkVncUFMOTJjUythbnBGbWovMUhHWHlJeVR3MGJVRmtkUkJiZDlSbDR2Z1Jr?=
 =?utf-8?Q?UxGJFaoGEMpalyb2lAHblBn2B?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf8b196-3195-4db5-26e5-08daffafa79b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 15:11:52.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuqSb8nHeyv9fGu7GaJQbA/NHFj66UL9UGf92DIGikMgZvsSZx83vnLBrlg+s2HyrI3Z7LbVL/kSlOz2AnS25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the second patch. Bindings must be introduced before you start
> using them.

OK, will be done in v9.

> > ---
> >  .../devicetree/bindings/input/pwm-beeper.yaml | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> > index 351df83d5cbe..f1f9283ca855 100644
> > --- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> > +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> > @@ -26,6 +26,24 @@ properties:
> >    beeper-hz:
> >      description: bell frequency in Hz
> >  
> > +  volume-levels:
> 
> use -bp suffix:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml#L44
> 
> which will mean the unit is 1/100 of %, not 1/10. Then you can also drop
> the $ref.

OK, this is also fine for me. Chaned the description and implementation
for v9.
 
> > +    description: >
> > +      Array of PWM duty cycle values that correspond to
> > +      linear volume levels. These need to be in the range of
> > +      0 to 500, while 0 means 0% duty cycle (mute) and 500
> > +      means 50% duty cycle (max volume).
> > +      Please note that the actual volume of most beepers is
> > +      highly non-linear, which means that low volume levels
> > +      are probably somewhere in the range of 1 to 30 (0.1-3%
> > +      duty cycle).
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  default-volume-level:
> 
> I propose to use just the value, not the index, so the name should
> finish with '-bp' and the $ref can be dropped.

I am not so happy with this suggestion. What shall be displayed in
sysfs as volume if a user specifies a value that is not defined in
the array.. So I tend to keep this as is.

Thanks for your feedback
Manuel

> > +    description: >
> > +      The default volume level (index into the array defined
> > +      by the "volume-levels" property).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> >  required:
> >    - compatible
> >    - pwms
> > @@ -45,4 +63,6 @@ examples:
> >        compatible = "pwm-beeper";
> >        pwms = <&pwm0>;
> >        amp-supply = <&beeper_amp>;
> > +      volume-levels = <0 8 20 40 500>;
> > +      default-volume-level = <4>;
> >      };
> 
> Best regards,
> Krzysztof
> 

-- 
Manuel Traut
