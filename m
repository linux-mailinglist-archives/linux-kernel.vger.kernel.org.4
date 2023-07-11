Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9974E481
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGKC4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKC4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:56:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F71AC;
        Mon, 10 Jul 2023 19:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijkT/dDxaBp/RLCFi/H5ujpFwpanIAMgq0hFmExAh9dILhq2kbO8HPJOwWFnIAl5bl6Y2bK1UomrbqEjspWuTidSYL6AaY59eqFZKW0ZX0/j/xNLIhvp1qCnMHMbsGjJRwvgBY0fpNFtK863+5D+6RExgIofq0ej5RFGEt4Z4E7a40XfZDjUgs4BDR4ZbHDtB90tlJh1MOsXWGOmFFaBmk5Qjy/bqedPx+NJKwFodASAOesLT96u8DMOW0Ae0CEz/W2C4g/2EV4qruVdx7anAir8Ybua5NBuXLjl0cBTDX0tjET8+1lCSVCWrASrHG1fgfSV05MEim+2h9VZtX+eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8sLj2z/zdbCrc0uFXcWWJ1/gJjErwNBL6EidAWxGHA=;
 b=Y2W8vIqOfYOxhrDuS2Ivf06Lwa+nscRvwO4zzuq1cxWlUs4xf8rPznyG36kZnGS1sgR3iqXjhn9P2FNVbJXuvAZuO0OaBhFmXn7WOZOkgTWpFlAPv32DJRDevoSXZ8MKuzvi9rFtwmyFR6Lw3yL+g82RWEAoK8y5fJA/RsL1jUUhH6qaSZkF/CQCgZanv6ke/s2UOBUaUNImdY+OJywxvucB2rS81eQT+FCOIJWW1Zrjkt0C4M+eLQ8sLqe0tQMJxNYLXe7n9SvsmuLifa2nko5kvxs+pXi7z+WJqMB4l77Ep58zcZOhVE0KNAUd40TdliUpHYeE1Yp2K6IhR3HB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8sLj2z/zdbCrc0uFXcWWJ1/gJjErwNBL6EidAWxGHA=;
 b=DPfPGWfL4JxrFzIIm6t/vjDTmEVBpCu5vEpTPsg+Ca7mSPSTTg4Ta6n1YKDGmQcwGNeuwKxsy+Cm79SG8+EzjBoEQYHWu4rRIEitWGm0dn5lE+vTYkLmFIWEMWuGdWlpguWPP2fLIkbC+Q9+gwitVxN58TUAcrht+LHEbPN92GD6AGguvL9+4hRCoopOBdf1h8xP0nxHaGneHSpWLdK7Trvf4nNNrmTGXxAE0o0CGIi5LH63L4PtIF+LXMfydybRYaAdD9InZH8sLDZnjxSD8XrE17uVTpiYpemmdoSUExJkM1r10WsKwB5+2ttykuogbPyKWfZvo1XLh6R8hWY9yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com (2603:1096:820:cb::11)
 by SI2PR03MB5706.apcprd03.prod.outlook.com (2603:1096:4:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 02:55:47 +0000
Received: from KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::66e9:429b:7b34:639a]) by KL1PR03MB7221.apcprd03.prod.outlook.com
 ([fe80::66e9:429b:7b34:639a%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 02:55:47 +0000
Message-ID: <424cb61a-9102-9a43-c999-36939e8d6cc0@amlogic.com>
Date:   Tue, 11 Jul 2023 10:55:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/2] dt-bindings: gpio: Add a header file for Amlogic
 C3 SoCs
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
 <20230710042812.2007928-2-huqiang.qin@amlogic.com>
 <20230710-maybe-mantis-e647d94fd13a@spud>
From:   Huqiang Qin <huqiang.qin@amlogic.com>
In-Reply-To: <20230710-maybe-mantis-e647d94fd13a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:404:28::23) To KL1PR03MB7221.apcprd03.prod.outlook.com
 (2603:1096:820:cb::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7221:EE_|SI2PR03MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 167b8fe6-ad5e-4d6b-0223-08db81ba5397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pysdV6BfESXCoiqSsCgCbWrZa8xQruQ1QLcbS+tdaUSTWiKiW/uVIGnmQZVSPMUR4rBCktclGtWgKybaIoKPO8ex+J0EH9GKFErImpf0DqoD40jhneM9jld9nKrHtILrbej0NMq4pOURLTqcUCYO9txlKJxxjEVWG2wZBxuY5IVAdRvLHnpHfWMNwR2hsMPKzszDiltxci7ocjvoQ3vMryC0LMsSWw5l7ofdVfZfW+fQ+qPLEbJvF9ZV4N/Qzb/FZUmzYbTF8mv3QDpa4nR0Qg6LQhrGkwM1MMoEAV9x43tYZrak4cxs/N00+rlrbYlNAsipdtNvIpjPovoPlcd7vYc0sz8cpG20Yf8WH80FEz7Y89wMjMh3vd62W3Va1xzJatvSH3XkIPPueRKcdk5bMiwan3aVADo7Y5wceU68aakttX4hzHRwabaGK0YR6cGp/8fYxLjfKyyYBjuBq5fIU3ziwoqas2FCafjJO19tM5pR8qNohZkJbBeYLbHjrCDuDTkaNxODl/RYZe9IxznlMAlCprhbWyGkRNMaTP3yQaZcuEof9f8bYcsS5QQKb7QXNjzN/4OPbcgesvZqxbFju4qwWReNfyoFNCmL7+Xsr0j3RgRmgw9ddwFql3iPMnX+cPnqDJ8IPgxLaYARorrvtrTXvMgKazWkZogUqv5EAjFNZmgfbkyeN/kO+Vp9B+MexQK4WqymxdPUlzoXR7ZTVri7QvMzgdGYfODEV74wiMwNEwfBMOHTwCSXalHN7jxK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7221.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39850400004)(376002)(366004)(136003)(346002)(396003)(451199021)(186003)(26005)(6506007)(2616005)(6512007)(53546011)(478600001)(83380400001)(41300700001)(4326008)(6916009)(66556008)(316002)(2906002)(7416002)(5660300002)(8676002)(66476007)(66946007)(44832011)(8936002)(52116002)(6486002)(6666004)(36756003)(31696002)(38100700002)(86362001)(38350700002)(31686004)(87944012)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWErU2toQ1hhVExpenBQWjNERGcvTnozOU1tZFhEcktodGgvbGllaG0wMFpP?=
 =?utf-8?B?amJYQTU5U1dHTWVoRVloMnNURUZraVc0SlhrREE0dXpIZHJPN24zZ21Kc2lW?=
 =?utf-8?B?cHA2RkFYZ0pEcXk4ZXA5c2ZkNWszYlVlMWZid1FkZTJ4aTNlM2hwYXM5SXV2?=
 =?utf-8?B?MVdlbjRyajFWazlsSmtsb3FwY3lTRFN0QjIvSXM5czNnWWRCeXU5a2tTYzhq?=
 =?utf-8?B?RnJlNmh3ZzFPTVhyeWtzWVNmZE9hVWtXQncwakNFTytNbXkzMjE3NFBkSHNO?=
 =?utf-8?B?UDNySm9RdHRiZHRSUW55azAxaUJpeG9DRmxMRDQzWHJnVzFPMGVJaGJnKzZk?=
 =?utf-8?B?VHYwV0M0d1Q3Y1pCeEhNWDlGbWt0aTVYYmpJRUhCZjgrODVGVlB2MGFha3Ju?=
 =?utf-8?B?M1Q1SFZIQlNwS29pbkZPazFSSHpQYkd6cG9kVkxkWnRKckh4bTRPNVFrV3Zv?=
 =?utf-8?B?Ujh6WVpINTRCMk56VXB3bFIrc3BSM01EMER1OFVKNm5SOGNzamg2S3BXbFUv?=
 =?utf-8?B?SEd3dngreFZESFo1MGtLTUtaVm56NXZ1U1pRb0txZFdoajc5NlYyUWd4NktK?=
 =?utf-8?B?bFJVTmhNUkVpcGdScVNkdWxLRXhWakJSaHYrNW9tcXNPaXJnbDBQTTFUd28y?=
 =?utf-8?B?WXhFWVMzZU5rYVZBRFM0K2ZjSitGa29ZNWxIY09hKzJWRE4vaUk4dTNOV2hT?=
 =?utf-8?B?dHkzMThQZXA0NlJFQTMwT214cVd0elJJSEprVlhFenkrUUswOTlONXphcm9L?=
 =?utf-8?B?Z3VVWjdqSUMyZkZNdXBQTnZZVkhFMjdLZ1NhUUE3VmMxRnlkb2ErTnpWRWI4?=
 =?utf-8?B?WTVGcEhTQUFDeFhiRGd5MlVyb0RwejA0MFV5V1BNK3RIazNSNGRiTHJjaHk4?=
 =?utf-8?B?Skgra1Y2akc5VDBmTWxlemdBa1NqYitTNFN2MXRobmNjUXFtRnB4TkpQU1Yx?=
 =?utf-8?B?bUhZdDFNTWlpYTVJNnhhQmRuWU02YXBMVThXbnY1M3NYaEN3ZGpzSUc5YkFP?=
 =?utf-8?B?R1F2RURlYmxWT0RIWlpHd0llYkpxQ21BSDRuOWlqSFBSNGNoaWRUbTNKaTlx?=
 =?utf-8?B?TTZDZFdBWkhGbUlicFRpOWM4S09qY2VwWng0RS9wb3JqVWFWcTJ4VnBucVZI?=
 =?utf-8?B?N0ZRNmpjK3B4TzJ4TWlxNTFzdnRIcmhXbHdmeWdrVndtZXBhcVZ0Q25VSFVL?=
 =?utf-8?B?UkRORXlvMTAwSHdMSlFwa3NwU3dRdnZ5djFBby9zMWJweXFiUUZuTkY2TlZE?=
 =?utf-8?B?cU1WRVg5cVh3NldtVlN1cGIzZHVjZjZPTXJOQzdCMjE4dHJ2VUNkQmZpOEc4?=
 =?utf-8?B?bEhUUzUwUlpnVHZ5SnByOG5vaThMbjVTVEUyTGQ2R3V4NDBhT0lqbXQ3Wkxy?=
 =?utf-8?B?cTBYOG9BQUw3eUdNOGVFUFhzWWgvdDJzT2IrS0lKbXIxdUk5bmJpY3oyVkt3?=
 =?utf-8?B?ZXdNcUZ1T0VoaGpqK1pVOFpVRGZuQS80TkR2YkFRR1hNY3IvRHhleDQrL3Fu?=
 =?utf-8?B?SmpMakZKdGFFNzNKRFJ5bkc5eUNudHdLbUNsVlhaaktLdEZpdzAxNk1IRDli?=
 =?utf-8?B?a25hbDNRUzZBNlBBNm02V0NFcDRmWm15dWVGZlBSa1ZwZWxkSlV5VEY1VXBV?=
 =?utf-8?B?Z1laRndad1JQMDhRRkJ6T1hhZE5icXhic3Nvdnp1ekg5amNNdms3TFdHMVdo?=
 =?utf-8?B?Lzk4VXZNeVBNUUJMalFnUnY0cEtqcm1LcjdiQjg5VnRLa3BGZFowbkpsbjR4?=
 =?utf-8?B?SlpQc2xCVDhYVzBDUlhDaUhxemhoWGc2U2tVcmQzTEhVdStjWk01bWNwL3lL?=
 =?utf-8?B?R05IL2J6LzJMRDV2YzhHMUd6T3FDd0VIaGc2TGUwZ2YxaXpicFhtNDNPcUNF?=
 =?utf-8?B?QUdLdjFmWGdsVXBBOExIaUozdURCRGhGOENJMFlnN1RWWS92alFqRWZCcE81?=
 =?utf-8?B?WTFkcWlZU24rWE5ZNGYrSG9RMWIraVo2MFg0MzZNZzEzUXZJRVVwamhTU21t?=
 =?utf-8?B?bFVDQlFPL1c4NnYycHcvcFE4VXB4YU8wSDJHMmwwUGNvV3lDUmJZblcxanFp?=
 =?utf-8?B?MUxzQVJyeCtMbFNKelowRzhiYytCQzlnOUd5ejZaZ2FYZHRzeEx4SFZBRkFT?=
 =?utf-8?B?U2pXQlhVTzNVZCtsa2R1THlQU1VuZzJKUWZpSzdDSGtQRFpLQTIvZVh1c1Nm?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167b8fe6-ad5e-4d6b-0223-08db81ba5397
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 02:55:47.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHbYKuioOURQdwAEdbzcaURCcWGCtLW8//fnM5MUoUJphe9B1uL6NLCQf/de3Sw551hUo1s0rc0iUvW8B/m/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5706
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

Hi Conor,

On 2023/7/11 0:38, Conor Dooley wrote:
>> diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
>> index 99080c9eaac3..e019b6aa6ca3 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
>> @@ -17,6 +17,7 @@ properties:
>>      enum:
>>        - amlogic,meson-a1-periphs-pinctrl
>>        - amlogic,meson-s4-periphs-pinctrl
>> +      - amlogic,c3-periphs-pinctrl
> Alphanumerical order here perhaps?

Okay

> 
>> +++ b/include/dt-bindings/gpio/amlogic-c3-gpio.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> Any reason to deviate from the usual license terms for bindings, which is
> "GPL-2.0-only OR BSD-2-Clause"?

I initially used the license commonly used by Amlogic (reference: meson-s4-gpio.h):
```
/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
```

But when I checked the patch, some warnings appeared:
```
WARNING: DT binding headers should be licensed (GPL-2.0-only OR .*)
#37: FILE: include/dt-bindings/gpio/amlogic-c3-gpio.h:1:
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
```
So I followed the prompts and changed the license.

Can I ignore this warning and use the (GPL-2.0+ OR MIT) license?

---
Best Regards,
Huqiang Qin
