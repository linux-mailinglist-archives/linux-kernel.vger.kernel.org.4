Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5F711EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 06:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEZErm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 00:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEZEri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 00:47:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722A119;
        Thu, 25 May 2023 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685076457; x=1716612457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WBgCGNEYTZiX/UFiGdM5cN8VstJfhRrCbfJGg9Oeq6E=;
  b=BsZs8RKMNAGUu/O1XZr+7ziJjN2Qv3up5rZQP7FiGWo6snPuMP2/39z+
   j8UJA6GqAkSWX4adzYxDTKQKFeOJyP5QoEu1W2GtSoEsV0TSmgU9QS4FD
   82Z/4QqXo8eM4WcvJk5PEJkRez4xWitJM9I4yY0I2Y6GrgKqlT9vOp8Xd
   8dapUy9R1dcm2badMjiCbCwjA9M27BvVMiRywKQJlEJnHV3d6WEZQLLCE
   DcUdhE4NDj/G+7drmQ1l0pANK6SzXNRdQft/ul5IUzXDVmVZVsRftcJwo
   tz6zyiq2M78401/2rytdnuhgjmVeyvoJXzbo01JLTCCy3L1WtLgvFyhn8
   A==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="154035536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 21:47:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 21:47:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 21:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgoonwY44nO8yYMWZKqcHSIKgwqw3R/TgTrourpEd5WexAeo+iNEcyqDJUBqNOPfGXXFfFqGLgd/gdljZTa2OaOA6AJFCD1aWThEtmH5Tzc5BGRbX38N/wAhxuKTK+9gGqF+8pqQ7e/uEFCDFRujPulS6jznGDuICadKBRYlT7ZlkTtmvhZfLCzepsGRPW8+yfgsc4YPm1+JrajDYtmzCCAuqaiaenHEUWGyOix1diCyXBwLnq+fOsYkZyn9RE4aV5eGgzWirbMyegzlj4mqEfbWf8r86+uOaCLQmFa+VlRFZP9GDOWZhyH3dYxHbK1rIr0ohn1Fd79j1Abxyh1FaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBgCGNEYTZiX/UFiGdM5cN8VstJfhRrCbfJGg9Oeq6E=;
 b=SjcX28p96yzyEYSS2ttWmMjoorIyJlMB4gw2MgJTQk32I/kZr48G40+52zMcCH2K8gl5hAuLOHtUIf6bXnth3jxrGHZOGzFEh+XXn3WdmnO3z32rFt42PwRRMigXLm3AN7mgh6Jy+Tt8b0b6vca84c1651bcvoWKV/dQoBgG4SdFnEqdHNRZqZLp8+07lJEvK+i9uH/EDDB5XohyyBWWVIiuxLy77oSqqgisNSKPVQ01vajb832jRd8zZcLAZOEfKiGNmnEM6VvTk7dr+uMBQsyb06eCU0xqd1Y7kZVVONEyj7q5nXIHud9rGkyVLmbD+Jacysv+f5VBfSDac0uApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBgCGNEYTZiX/UFiGdM5cN8VstJfhRrCbfJGg9Oeq6E=;
 b=fc+6xJhePR+7hZJnsSrUkMQrHUfb4/wxdeHwJInDQ9rGeeVvMxvEwnT7FeDJSPTy6kducJukdxycS1jc5z+RQMf5Pa4oDdwwuJbRnxUpKxwHwf8mhjdZx4x4wwXqw05S2S7Uc//X8V5+JzGdQlfTzJeuOdLKgbbvqw/e/983OhM=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 04:47:28 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 04:47:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <conor@kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <sebastian.reichel@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b: convert
 to yaml
Thread-Topic: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b:
 convert to yaml
Thread-Index: AQHZj40s9TcsRJXZ1kOxioXAUdLI4w==
Date:   Fri, 26 May 2023 04:47:28 +0000
Message-ID: <5edf3d3b-6f59-0af3-6414-940a278962bf@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-4-claudiu.beznea@microchip.com>
 <20230525-straw-fidgeting-4c1099aa16fe@spud>
In-Reply-To: <20230525-straw-fidgeting-4c1099aa16fe@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|PH7PR11MB7594:EE_
x-ms-office365-filtering-correlation-id: d18a4f9c-1574-4e5a-5604-08db5da44ede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wz/+7kNfqZBA1k1m9qtFuxpblFNto8IK5VA1e8V+wfCi2aLF1sh1o5G5SwMzIIdU0J4EeW1zuVcXlAnqBNKw/y0bRrGGzbe9MQ1RxCOvINN1/14nard/EGW5zPfa9Q+rL27UDH0p0cAM4R2YJcMUreNRUV1ZBWYJqIPxydvxBARCJc4/lIrekNe5FROdM1oxcWuzxxFJqbsmqFO6DzJJjpSqCih8lFeZrJYA3MFEflK8V9+GVLOE/5fy12bHhFlSk2evxVLPfYgZ0BSpGfSQPYk2dIHQHZX/0UbBWDs7JxSlVSer8O6EXalqhs23Ld3e7JfSZHG1NvQ+T9IHqc0Uv3hzTVMdHKQcKYNadd+kzDphndx6esyj9F88GCmvQzqXAr8kW4Enk2a8XUvD9/NTL5CvzhnDqalIDilNLcKlimn112ihsWZSgUt6OnNg5ggxx9R1OWdX8AfVGIDipRCSrzrtp/5OLQeyfzn0EIYIoFD8oJDWKKc7gZ+OxW1flVwub58rn8tcFa3ztVMhHYtFyvXIjbo7XUHuuenLyrz2AhEh6iYJepr4ZdiQKgdvJi+5zayTzKYpV84z9Keo05z31zeo0BGa4NgYGIerXFfUdV7yuf4k0gLefkjBqtfeG7TM9gdQe0WlWVTEyOo3Whh5nOaytWN5TI2ye0Ab+So4LfkXiAXXsXHjKUsoAtn7Rzkt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(316002)(54906003)(66476007)(38100700002)(31686004)(4326008)(66446008)(64756008)(71200400001)(6916009)(91956017)(76116006)(66556008)(122000001)(66946007)(41300700001)(478600001)(38070700005)(6486002)(86362001)(31696002)(5660300002)(8676002)(8936002)(4744005)(186003)(7416002)(6512007)(53546011)(26005)(6506007)(2906002)(36756003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0lpZVNBUFZraThHeFNsN3hDUk9HZlZjMmtVWjJzNWdlS0FMSG1sSVRuNlpZ?=
 =?utf-8?B?dkxwVWN3QlZXQkVlbXNhcGI3OE5KMEVsREtiUzJzWFZrQnJUS29NelRUeXR2?=
 =?utf-8?B?aU1nd3VxVlVuYWtGTVJ4WFVPcWc1S2d3UHdYRTdtU3U2ZnpPSmN4T3M4YkE0?=
 =?utf-8?B?L0ZZVm1UcExVejc1TmJPTGNkQkxKNGlyUElDU0V1czFaTkZEaXBNUDNIeHN2?=
 =?utf-8?B?V3FGRXU3N01DYmdudDIzZTV1VURiczVFVkVZUVdPMlJaZ0Ntay9VSXdTVWpy?=
 =?utf-8?B?ZGRQdzFUMXNzbVJpRmV4YlhjQ0ZBS0R1THZKd1U5WGxGUjI4RkNpQVR6NUVO?=
 =?utf-8?B?YzhMOGRob0JieEFidUYzTnlNQk1wOHgzbHNTYWRsSm80eUJoU0M5VnVTdDRu?=
 =?utf-8?B?Tk9FbU4wQkgvTjV5em11YXNZOWxIalo3L1ZEQTI0ekowRzFEYzhvZk9TMHpF?=
 =?utf-8?B?WmdpNFprQ2Mrb013Sld3YmVzL001cHhRRXN4aDFPcGtpWjZUc04xSk9HcWpj?=
 =?utf-8?B?UzVWbWo5OG8xdThYVEVtVEpkVWxNRW11T1VUQUFrelBLYy9tMTBPTzlYaXp2?=
 =?utf-8?B?ZGZtR2tpdlFwTXRyTHFQdjVpTGxxcmkvbjg1bWdnTUtzODVlQVZnMjNQaGJp?=
 =?utf-8?B?aWZaN3hqWmxtR0l1MWhiTURMeDJOLzJLM1Y5bkJRZ3RPZkttUmdEb0s5Wmxs?=
 =?utf-8?B?RFJyUURMc2FQYktMb0pHejdtUFNMT1ZUamdhZTVqL2JPUEtGVWg5bHB6cjkx?=
 =?utf-8?B?NVRLcTJjVXJmUjQ3OUJ3NzBlaXllb0ZaaiswajBkMTEzd2cvTG5VRFF4bnU3?=
 =?utf-8?B?Q2p3cTJLTDNjak50bmJ6QkRtaStTdWUwQmEydUJ1dHY4SURuM0tEK2x2MHIx?=
 =?utf-8?B?NVhFaE5VWExvUDFBU213ZTRkaStRSlM0SmQ1UlZBcHZGUkZjVXk5OEpQK1BU?=
 =?utf-8?B?T0tZRk1PSTNyQUdHM0xxMzRNV3BPVHpmcmRRb0tYUE13ZHpORjZhNUkzbU1L?=
 =?utf-8?B?cmtiNGRFaDBHOEYrSzFUSzlHUmNRSE54OG5waGFmZU5OSDIvdlErbmlIaUhG?=
 =?utf-8?B?MjNZaWNGamFHSmxkVFVubnhmN2pDVzBCREd5MDY1TFl1Q0h0RFc1b2ZkdVUy?=
 =?utf-8?B?QmNLTGlMOG9ZMnJGNEovMStYNlhpU213a3BZeUFrTGV6cnRtWk04SmJRM1Mv?=
 =?utf-8?B?MUQvSFZwbE83akdQZEZLcjhpOG95dGNiTXJIcU5STlRpeTE1Q2owOTc5S0hV?=
 =?utf-8?B?UGhnazNnZVMxcDVZMzdZMFFkbnpqdFkyMjFlUzB5alVqckJmNjdaNWRiNkI1?=
 =?utf-8?B?SUlETHluSC9aaUc3WTg0UFFLaHIzSXR5KzNQQWtrc2ovNzZ6VStRYnIrMG9S?=
 =?utf-8?B?ZVovTFhBRFlTZzNtTG9pcXFHZ1hBb3JjNzY1VklSeUFVR05mK2lrTUdDUFdv?=
 =?utf-8?B?RXJwY3JWTk96UFc1Q0R0TzRKbHd6Tktyb3pubHNnZzdRcDFiOGd1akFPdURp?=
 =?utf-8?B?dyt4Y2FBVEswMENmVHlqL09MYzc3RWc1RHRtQXcyQSsxN1F6VERPMEt1QStl?=
 =?utf-8?B?NnRRRTMzUElFVUVyQWpXNEZiaG5BKytLUW1YcUw4dUhScEdTYklaenVpMDFQ?=
 =?utf-8?B?ZkZQZUdLdWxqLzNqN0hDa1R5RlgzWUF6bUVuTXlCam01VzcrRkhVUU5ubE1I?=
 =?utf-8?B?WGh0RUZoRWNYazBxamxMNVdWSC9hWmZkR3lCUEZ6ZlNnU1hjMlFWWUdycEFz?=
 =?utf-8?B?WFp3TkRiTFZJeVZPeGNQL0VrdnhvZnBRejdoVWlIYW5qVHdpYUlQQWRwRnA0?=
 =?utf-8?B?cmZVRFlpTUxDbHFPaTVrdFUwQ0ZPRTQ4ZDlobTNrRjlGT2NJcVVMUEVwanRK?=
 =?utf-8?B?bDVxT3FSWkNNYXFERzB5Q1kzU3JleDZHMVY0S0pGZ1FIZ3RlMm1peDdaMUxm?=
 =?utf-8?B?NStLQ0R5RnlUTE51VU8rTXU2OEtUV0dCZjVwYVZJWE05NGxaK2I1a2pxWnhl?=
 =?utf-8?B?YWE3VjVPOVdCR3hIVnpZTllEMDl0dVZha2Rpa20vR21vdVo1c2pxWis3a2dX?=
 =?utf-8?B?NW82bktXM1ZFNFdTN0NPaFJGdzhxeUdvRTBGa1pPd3hXa21pTzJGdDVFbk85?=
 =?utf-8?B?MzBxaUlkT0RjamEzdERxNXVvN2ZmZ0ZrK3FFODU0dGF5cmdzNVJaT01NdjFv?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8550599E11979A418E6CBDFEF91FA23C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18a4f9c-1574-4e5a-5604-08db5da44ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 04:47:28.1914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTEHTKevbXIRIW/uTXumVevDq8FhMO7YuXWKcvjK1/on5aWi86NbXK4zCqCLrw4ubm9Inm2tt0n9Bw1UVYc4KiOjj12IAWFfrb9+Vqm7UyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDUuMjAyMyAyMDoxNCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gQ29udmVydCBNaWNy
b2NoaXAgUElUNjRCIHRvIFlBTUwuIEFsb25nIHdpdGggaXQgY2xvY2stbmFtZXMgYmluZGluZyBo
YXMNCj4+IGJlZW4gYWRkZWQgYXMgdGhlIGRyaXZlciBuZWVkcyBpdCB0byBnZXQgUElUNjRCIGNs
b2Nrcy4NCj4gSSBkb24ndCB0aGluayBib3RoIG9mIHRoZXNlIFBJVCB0aGluZ3MgbmVlZCB0byBo
YXZlIGRpZmZlcmVudCBiaW5kaW5nDQo+IGZpbGVzLiA5MCUgb2YgaXQgaXMgdGhlIHNhbWUsIGp1
c3QgdGhlIGNsb2NrLW5hbWVzL251bWJlciAtIHNvIHlvdSBjYW4NCg0KQnV0IHRoZXNlIGFyZSBk
aWZmZXJlbnQgaGFyZHdhcmUgYmxvY2tzIHdpdGggZGlmZmVyZW50IGZ1bmN0aW9uYWxpdGllcyBh
bmQNCmRpZmZlcmVudCBkcml2ZXJzLg0KDQo+IGNvbWJpbmUgdGhlIHR3byBpbnRvIG9uZSBmaWxl
IHdpdGggYW4NCg0K
