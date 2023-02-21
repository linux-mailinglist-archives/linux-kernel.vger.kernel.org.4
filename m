Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA45069DBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjBUIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:10:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF11E5C1;
        Tue, 21 Feb 2023 00:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676967010; x=1708503010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dSp77IrOtLKPhVZc2rI79L0ZE4Jd8PMstunqaRKumOM=;
  b=R0YDNzqQ9LP2cvv4PMpwRMJt/0NsFwoMAJZ3IZWls6rvyHZ/uXOCqnjS
   ZTsqtp/Ig1JTp9TsCO9S2aTo+oilNLyQVEIN6oD6fXB11s0njVAvybCki
   LEuK8eX0TRghbyDdFu9EQn1h16oiyKX2SaiirUbFhRt8yH6JOLDMzMO8N
   6FN7wt1PBnVfDr4CQwcBUbL7m9BK09pfMDO7EjMP3UXlSYiKhofnVlYCM
   E5BBqgkN24w3PicMpjrgJoklQc6G5cYmjQxsAVkhL2nYbFElC0twdIfDX
   yoCLvsNyht2glVoCyv9XcoMCkg5QLlYyuVpxyf9sZ6T+KmpM4xyQQYiM1
   w==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669100400"; 
   d="scan'208";a="138234722"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2023 01:10:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 01:10:04 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 01:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzku0P04dt8RV+8BwhcEmXM+aiq9phZsdnoSPOsx7PuBUXSoYZFj6o9lfSVnvHu3YHjcmZp3fr2cBRMbdX/WU2rVpilP7Uu/QwAQcqwhNYqBGYbUkXfaHaabM8MNxS1lpVTtHvme750cVB/uY0dUoD5rq+ND4jKMrWPX01ipJXQ8y+REkeNZXJhQKQktx252nD83EgFW5hxDREyWieTjC9++DnZZIwgWxsWgvzblgRylRNrioGEDcmM9S5NaeXy5oaNMNBgDfRjsw+RmT7YrftT6E02jbZFusfCImf0pYLT+/TU1koJzRcCz2wmWwCZnzqlZbUS6RyCwSNefhYeUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSp77IrOtLKPhVZc2rI79L0ZE4Jd8PMstunqaRKumOM=;
 b=CzDHLR29RTYpuvMmJFRnJ6P5/Kvu4adZYkdj9Kfkutx/Tb2WkyfKcbLshXL0ER6CO3bshPOBbUJlofNO0bAbsXQr+Zvj5wIyElcx5r/mHBvzXJL5adVAhZhjUbbCJIYFn8VP6n3njZNIubvoCrZDNXeAOT8tnayGEXUxDeNP7G33eLovareBAETWuA6Vwq2F95iHNvxcypigobtxAgYCROey06MZkBT8FN9wDBjLKTOox8SbmrFGgtsdU0k+NRYsk2Dzwc11o7amwtK8UD/ZMWE+EnQTo82INy9qH8DPtLRvpWoURG7hYWdAhDsFl6KC6/xOriMjG08v3BiODJRefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSp77IrOtLKPhVZc2rI79L0ZE4Jd8PMstunqaRKumOM=;
 b=NfmeoW9H0u7ha0I7J/Batz29xR3WprJ6PGRMBpehKP5nZmcH+Lfh8Tg9H+gOjS5y6gXVc7hwp5vuNHkoGHRGk9su8fWXVbKEseTvlt06mhGvFGtfe3OibcDuQnGtflXUZac7A9VOjb+5F5KWBsC0gpEC9ihVpCh9DPl6FGkGqLU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 08:10:03 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 08:10:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Thread-Topic: [PATCH v2 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Thread-Index: AQHZRcvmK4ii/DZHHEqD7R/0B9uoxQ==
Date:   Tue, 21 Feb 2023 08:10:02 +0000
Message-ID: <69c4eccd-9d81-ac0b-802a-8e4e0d57589a@microchip.com>
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
 <20230217124151.236216-3-claudiu.beznea@microchip.com>
 <20230220225601.GA545317-robh@kernel.org>
In-Reply-To: <20230220225601.GA545317-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CH0PR11MB5538:EE_
x-ms-office365-filtering-correlation-id: f16a28bf-d153-40fe-32e7-08db13e30893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVpkddOgSy+TRZaYFkbUMnE0RlgUWsuTd9UQdowhlNXDe+aDttsE9WBoriYhPhhxed4451dkWH3F5cQ/zUfdf4mT9uYoeuDFu9/x7hIfXtry8KJ1NgzAS6EXX8E1tr/1PGYLJhniEc7rvQaL7Y/73St3Ib2LOM36COq0da7J/bDwecRiQrnm+yqQY50mH797Sgjdl9gEOxy3gWpE6jFOuQyQJVFFRc1SW5kRtnQUnJaiqgHCcPnaWllQ8SNMMtrEum72izZ2zcSrjkJONVsCnqK46ZDcdu608ofDw2TKb0RE3d44WtzdEJ50/QTXNyvFnVKUB2w683zT/KxWqu6BRToZGd8iu7r3DH52pvxVpvZ7cVEr7Jt4YevHscEfxTpjD3oAX75b+ULOIaLYUPK0E7JT3rQGbkTjVkl81ZhVjKx0SCi7w+LYlJKxPXoHfCpoWRqazdWtr7959M3JaC0D4zJeaaW5taix02VeQBOMt7eUXY3doljjITyMs/4fEg5i25gPF00xzmEDTeb5L/socDGfMqXrFt/31ewRNuGieo6GlY3RNXpYARBebW2HsDYOBa2JGn4+tEaLKue6terzkxV4/QKCbPpGF6K4rwCEOk9jPFof1Xp+02vifgZ4xOnuWElvkgDUhWUyF6OOLQ3poOOHYKvNYag3UPzbc5qEA2B6jnppowO7zaq7yqO1Dg++JWC0Qj3887MfgOX70sO3YVn/naT+MIHAfqbqL08NRlyQoJTpuNRAVjmbCdLng+vYsO1MpdUkrHpNNg/Wm+9BVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(36756003)(71200400001)(54906003)(83380400001)(316002)(6486002)(478600001)(76116006)(2616005)(53546011)(6506007)(6512007)(186003)(26005)(41300700001)(38070700005)(86362001)(8936002)(2906002)(5660300002)(7416002)(4326008)(31696002)(6916009)(91956017)(66476007)(64756008)(66556008)(66446008)(8676002)(122000001)(38100700002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFJiMGcvaGFydGhFRGdZWUMrNnQvK2RFVUVaLys3OUVjWkV2VHppUmFCZFk5?=
 =?utf-8?B?UDA4ZlJYVjhTRmNzM0pNdE5TaFZYTlJwTVIyR00xSFlNOURmYS9OSFRXTXNM?=
 =?utf-8?B?S2tpRUZncnFBN3Q0TnVjM1l6bjBaQWJpeWJIV2hRZE13QzRMeDBKK1JlY0Zp?=
 =?utf-8?B?YnR1WFNXV1pGdHpxZHFYc2w3ZFlhZDM5K3gwdExSOVpiMTJjM1NWUzg1Y3By?=
 =?utf-8?B?aUVRdVFHQStyVVU3alkycytOZEdrRm5WYkMzUUNoS0VDcmh4Mmp5QlBUZmhR?=
 =?utf-8?B?WWZRcWVYSExvMWMzT0hyTmFHamJNT3d3S2pLeGNiYTJrcmY1VzBYUThRWnh1?=
 =?utf-8?B?cFV5NEtrOWxPamtrYlJYYXhqV0VrUGcwZmxmV0JMa09sbzZuU3VmbDdQMjVr?=
 =?utf-8?B?ZklaMEkrUDl0dnF1cTJxNGUzTzV5NlVaZzBEOE9QS3RFT1ZpMXFwL2lPVVVI?=
 =?utf-8?B?UWtaQzIvUjR3amlETlVkSEtuZlcwaHVwdmRLSGlIS1J0ZEdYbTBZR1RiUnJu?=
 =?utf-8?B?NWtiUWpJL2MxSk5pUUxRR1d5Z3lkenJXTUxKcTFxdVJhb0p3bEl3VmpDZURt?=
 =?utf-8?B?eWU3NzZCeGxoNWVzZEc1dU1NUER4U2R5Z0R2MzZBWlQyOWJDb0d2NWhuMmI4?=
 =?utf-8?B?MXYyb1VZTUpvK3RoTC9TbUxXYzJ5QVpOK3NlTW1veEF0ZS82UEtmeXNBb3l0?=
 =?utf-8?B?RzZRRWthbzEvcFgvWml0Q1pTTXpxd2RZR1NRUXUxSWJOWEwyVU1FUVpKNVVU?=
 =?utf-8?B?NjRyc1Q2bFVnV2tOcWpQZmJ3SG9mWGxubHNBak1NZENxTGxHdWxWREV4and3?=
 =?utf-8?B?RWQ4UXlHRzh4U1ozWmJSdHpOUDF1WFVLdUJxUENEWEN2MzJpRWI3czFiUGVi?=
 =?utf-8?B?K2RCUmFBMVlnSFFvb0xjSHRueWVveFJVeWhwQ3BnL0pYMk41aG9hMHhGbXpV?=
 =?utf-8?B?Y3Y0UGlVOFpxUUV1R0RFYUZLK1FVT1VqOVY3ZXJIVkZFMHdpUmFGTUQzc3BQ?=
 =?utf-8?B?VitFNEFxaGkyYVFCb0hzSDJIMTVobU5pMmoxZmlEaENUUmpJWjRyNWlWZjFa?=
 =?utf-8?B?OUFYaU5kQzNLaEJSRnRQSTdtVlNiT0NoZ1lEbjMyRkdBSm4yb1BJN2VaWXht?=
 =?utf-8?B?cGUzbXVhejVNd0JtRWsyK0JYbkc4eDdsY2t2ZThWV01JVExWUEdNK1dOUUJk?=
 =?utf-8?B?cnJjdm5FSGpsNXplYXFYOHRFL3RkNWhIT05PQ0FzczFGcis5VCtPdHpqUmVV?=
 =?utf-8?B?dVRBTldhaXZpV2w2V2MwMFJpYmxxeEhOUWp2SmVkWXJkOE9LUEpYYXptYUJk?=
 =?utf-8?B?ODMvbU02Wk9YUWtFSVh4MUZpWENMQkM0MFo0ZVhYV1RwblU5MzdpS1FTRUNG?=
 =?utf-8?B?aGVjcXhSeUg5RTNxdTFkQUJjVmdpUloxejI1eHowVGR3VGFQWG9wc08wWGV3?=
 =?utf-8?B?VmFjMWFlaG8vRXlpc2xWanpWZDJxcWtqQnJ1RW1aK3J1SzhqbTJPNjVQRVJ4?=
 =?utf-8?B?aVd2bk9ic3luODBVd2FEMFV2TDN3YnhBa2E3bGdiQjBkcVJMbUZRTXBULzdE?=
 =?utf-8?B?RTdETFgzUDZMR0NtL0hWbnRIWkxKRWxsQ2d0TUpsZUU2cGF3SE9taklESHV4?=
 =?utf-8?B?T0dLeHRWaW9GbG9heGZEZzUxaG1zYVNRL282a2ZMeWk2NDhnTXhjUW1FVXpR?=
 =?utf-8?B?U0FxQzJpMXQxSnVFQzE3MDREMy8weUtVWWZLTnc2bGJKekhNblhZQW8xTFI4?=
 =?utf-8?B?cGMxUGhEbkxmOGpJWWJUVENybWo0aEsrZXFrcDc0WTF3NWhmQ1lOdHNKbEk3?=
 =?utf-8?B?WWFLbGQ2QmFFL3BVdnByeTJ5U2FJM3lBQUFSeTlkc1JnV00rZWM3TURhMUQr?=
 =?utf-8?B?dERzcC94UTZFNElseGQ3M3psS1dReXExOTgreWV1OXVjOEc0cnhnbFhzRkJm?=
 =?utf-8?B?UThvRk5OOFlnWDNyS3M2elB2R0FMb3VnQmllUll1ZFZLcHorTXljY1FHRDE0?=
 =?utf-8?B?b3BXREs1T1hYd0JvU1JFa2l1RWlPRGx5SnpvR1UyZ1RaK01tNmZGMDJseTE4?=
 =?utf-8?B?VFF6bU81N0RaaHgySkZKM3NtLy9nWUFjZjdSSEs4Vm1tZDZsU2FTR1RtRlQ5?=
 =?utf-8?B?K1RnSGNpVGtnb1g0MlNtZUlZMm1mOGI0R2xVQ2grK1JLYW9CaHNUNGlWa3hX?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BC461C4F44AED45A212F3A9883F7E4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a28bf-d153-40fe-32e7-08db13e30893
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 08:10:02.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7BaY3zOEjH2QRJKgwo/Rq44buxaww8d6Gp0GJbrn4MQ5Lg5IBX0K5rh/kmK9FpDRoXxqn07ER9wX/bwQg5FjIuH2C4jB1yHo7Ir/vix4T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEuMDIuMjAyMyAwMDo1NiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpLCBGZWIgMTcsIDIwMjMgYXQgMDI6NDE6
NTBQTSArMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBBZGQgbWljcm9jaGlwLHN0YXJ0
dXAtZGVsYXktdXMgYmluZGluZyB0byBsZXQgUERNQyB1c2VycyB0byBzcGVjaWZ5DQo+PiBzdGFy
dHVwIGRlbGF5Lg0KPiANCj4gVGhlIGRpZmYgdGVsbHMgbWUgYWxsIHRoaXMuIFdoeSBkb2VzIHRo
aXMgbmVlZCB0byBiZSBwZXIgcGxhdGZvcm0/DQoNClBETUMgY2FuIHdvcmsgd2l0aCBkaWZmZXJl
bnQga2luZCBvZiBtaWNyb3Bob25lcywgdGh1cyBkaWZmZXJlbnQgYm9hcmRzDQpjb3VsZCBoYXZl
IGRpZmZlcmVudCBtaWNyb3Bob25lcy4gRGVwZW5kaW5nIG9uIG1pY3JvcGhvbmUgdHlwZSB0aGUg
UERNQw0Kd291bGQgbmVlZCB0byB3YWl0IGxvbmdlciBvciBzaG9ydGVyIHBlcmlvZCB0aGFuIHRo
ZSBkZWZhdWx0IGNob3NlbiBwZXJpb2QNCnRvIGZpbHRlciB1bndhbnRlZCBub2lzZS4gVGh1cyB0
aGUgbmVlZCBvZiBoYXZpbmcgdGhpcyBzcGVjaWZpZWQgdGhvdWdoDQpkZXZpY2UgdHJlZS4gV291
bGQgeW91IHByZWZlciB0byBoYXZlIHRoaXMgaW4gY29tbWl0IG1lc3NhZ2U/DQoNClRoYW5rIHlv
dSwNCkNsYXVkaXUNCg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9taWNyb2NoaXAsc2FtYTdnNS1wZG1jLnlhbWwg
ICB8IDYgKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWlj
cm9jaGlwLHNhbWE3ZzUtcGRtYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvdW5kL21pY3JvY2hpcCxzYW1hN2c1LXBkbWMueWFtbA0KPj4gaW5kZXggYzRjZjFlNWFi
ODRiLi45YjQwMjY4NTM3Y2IgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbWljcm9jaGlwLHNhbWE3ZzUtcGRtYy55YW1sDQo+PiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWljcm9jaGlwLHNhbWE3ZzUt
cGRtYy55YW1sDQo+PiBAQCAtNjcsNiArNjcsMTIgQEAgcHJvcGVydGllczoNCj4+ICAgICAgbWF4
SXRlbXM6IDQNCj4+ICAgICAgdW5pcXVlSXRlbXM6IHRydWUNCj4+DQo+PiArICBtaWNyb2NoaXAs
c3RhcnR1cC1kZWxheS11czoNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBTcGVj
aWZpZXMgdGhlIGRlbGF5IGluIG1pY3Jvc2Vjb25kcyB0aGF0IG5lZWRzIHRvIGJlIGFwcGxpZWQg
YWZ0ZXINCj4+ICsgICAgICBlbmFibGluZyB0aGUgUERNQyBtaWNyb3Bob25lcyB0byBhdm9pZCB1
bndhbnRlZCBub2lzZSBkdWUgdG8gbWljcm9waG9uZXMNCj4+ICsgICAgICBub3QgYmVpbmcgcmVh
ZHkuDQo+PiArDQo+PiAgcmVxdWlyZWQ6DQo+PiAgICAtIGNvbXBhdGlibGUNCj4+ICAgIC0gcmVn
DQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0KDQo=
