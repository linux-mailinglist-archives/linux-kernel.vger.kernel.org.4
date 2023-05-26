Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E12711EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 06:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjEZEpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 00:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEZEpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 00:45:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D13122;
        Thu, 25 May 2023 21:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685076319; x=1716612319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EQFhiYVvSdgq0rWQNAZ1BTqHAtvM7Ee2pDiTecu7FDs=;
  b=QToPv4ZSACc6mmlA21041b/MPUpJuD1MLYGojBRZMKtdcMP2C/B/NW7X
   6IqTTLKWjssuj+bZQq3w0ozVN2Q0Xna/dg8dfHuE+QQVQyxofH5l0HKVP
   /+b07Ec+jEjSJ7mILL9bMWIYVNX0mZpQkCIEfhM+bqLFf+dJsRXQjrBOz
   isfzJK1JApAOSITwdu5Gwu8c3wK1CbJ3v6IX5/L6qAeMMG65y93LWg2RI
   Ywwvha7K1Lp7rt3HCH6K86/jtlXBEE/aFzccOM/Vh/gT1ZhDM1jXScNeb
   FUHZ1T72CXwqCrjMom+X/BXp1OCqpBAfklFm5133JenYwNPLhAXfVstTi
   g==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="213169990"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 21:45:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 21:45:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 25 May 2023 21:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgOMpNfPIkbayuOWdzPJI2lwv1/Y+6KW7KWi5Bu8634puB2BjVXrfuLdYmztlFP5Besyyr80ndmShhJafpr4e1tY+RGPQKMwJr+SUim0GHmfPh5thMu0v3PXLMzSahBbzVwPlthLju1dQp++OnF18xXsVhJHpntnR9hry9wnSO9S7pg8T1ra2sHClQoLZfC/86G8SYZwiDBh668ff7+ib4Wo2UL+wRbzUPNwaVV9EXOPFJSbuonXS8al2/e9RaJozTS5x72IGEY69rbKY7MiOlZGln8uoAoVMTYjGyqM2//+V/kYq6/sLoHD9Tea/CVl1eUFWBkhbCaZu/xUu/VQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQFhiYVvSdgq0rWQNAZ1BTqHAtvM7Ee2pDiTecu7FDs=;
 b=UgMk6ElBDWM2iPp/Fdw1ZslVgsYJTC2y0s+oj2xHxgt3H2mvYPwIkb+F0JA1eeAGdb3RHPSgWm1yV7eOMycOuxSuKAKC2ZsRSJ7oLPoasRddAIKoIkt10fM6UMIUBUXg4YtmvWksULpa8eF55nwZ6Q26akK8sXhh/PMzKVrX+vperJTI18h76qBJZX5O1UE2eh6KjK27fOvg75psJ/Mhq9bhK7F3UKTCf7gH6PdKWlOV90ittk7++ha1VZfP2Pm0G0aOfUi8Tj6nBMY0Fw99fVgjP7eeqpKjG77DKsU+gW90LWSRztMoRmiSYi7qjILk7KHoYmcqFLIf5HeGqZCKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQFhiYVvSdgq0rWQNAZ1BTqHAtvM7Ee2pDiTecu7FDs=;
 b=uv3nOnMumueigD5DBv5a/D4hcl4KrgDsPDTDBxK1PMOeWtKPYJQavvS1sMrqSHW8lebj4RB9iuFyvS/9cWF8v+DIFLsfwssW/93x9FgHPNqVkDg422d5sM+SuFrVdr1tFoh1pelAiFVxMg4sXkmVih02RFpgflflyOsWEDMxlLE=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Fri, 26 May
 2023 04:45:15 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 04:45:15 +0000
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
Subject: Re: [PATCH 1/5] dt-bindings: timer: atmel,at91sam9260-pit: convert to
 yaml
Thread-Topic: [PATCH 1/5] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Thread-Index: AQHZj4zdHYniZi4DrU2s+JvQ7xbVrg==
Date:   Fri, 26 May 2023 04:45:15 +0000
Message-ID: <00fb5057-cbae-528f-3440-6dbb3e65c7da@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-2-claudiu.beznea@microchip.com>
 <20230525-renewal-proposal-9620d5520437@spud>
In-Reply-To: <20230525-renewal-proposal-9620d5520437@spud>
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
x-ms-office365-filtering-correlation-id: 23a470b6-c8dd-428b-711c-08db5da3ffb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iq7eHzoll2MHGtJLn6gCttzYYgfwXmhD0cbTvYyPGYC81sMXPWsBpLzv++w5UtzO48g/RKHjD5Ml6/No1DMPvwZpOZoiCI3y+RD69PSO16H0Zd3trc0XzdVjl0MIh5gPO/pPwJUrRbTOz1gQ0BJfenQLHXXwIsHG5+5CIm31VR17Y4SdagBOQyC/GZfMc99cJrrAbm2SjHh+cT4WhbKS8YsNp3BdJYi4k1B5SWLUG0QycLND/SeVGMwC3/hFg+y9EXolcndaVrW9pP4EP0erCH+I7aPk2eHKdSVGJku7oUA5YA/9g4NXHt2Guwtd42CzBuCgf4zkI2mcDhBhBgWYR6H9Tc7ZoXvY04TLx33jpCS4FIP6CL9RaigkLvRdwXYNOashIVXC3zVN9pGK140cwsxL6HpLKK7FWGZrbMhP1feObs6/DHV2MPLEf+N8NcApVNTHF4AW0Ns0ACg/tKmUpeOId/u6HIuprGKMGnYYz1eO13XcatnJ90LXfLdt9r9gl4jzEe+Q9LwB4FLJgABQB34XOUihtor2obnO2pSIQH3f4DcKAaZTW+MotF/PwARkAwjtT/8qGXbmx7AoKNHxVWNSVkRPv44FLk1BxhndObR1vpc+inEYaY96A9i/Zteky0KZX7jAwluDWWcfxLXFNTe7ginz3KbS9rqRuNQXu6sWpBkXkePEF1kwHM6yfweOBiBtCNjW+Dh/3NpaoB3HSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(316002)(54906003)(66476007)(38100700002)(31686004)(4326008)(66446008)(64756008)(71200400001)(6916009)(91956017)(76116006)(66556008)(122000001)(66946007)(41300700001)(478600001)(38070700005)(6486002)(66899021)(86362001)(31696002)(5660300002)(8676002)(8936002)(966005)(186003)(7416002)(6512007)(53546011)(26005)(6506007)(2906002)(36756003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1V1bVRTcG5WNzhzb0hyRC8rVk95U2xtUU5LdklBd0p6ekM2YnpwbHNDVjBY?=
 =?utf-8?B?aXh1aWhGL2RKckk5Q3RyelNFUUJJSE5UbUUwbTAwNTk4RFl5ZERSZXp6TlJk?=
 =?utf-8?B?LzlNQ0pZTWpCanc4MWczTDFpeis1UjYvNmZvcVREN1hjVzJXZmVNWkZPWjM2?=
 =?utf-8?B?NUszSXk5MjlqWjNBTEMvYzBKb1BmZnhEMWV2YTB2R2ZmdVd1NUxXeWM0MnNq?=
 =?utf-8?B?L1BFLzFoL0luYkZhQ3Uyc2xrbFVaTEkxT3YvZHg5YTVsSkFmQ01FL2luSGxn?=
 =?utf-8?B?TWFuT0ljNEtadFpEc3NzVjVROFBGN0p0ZGI5UDlyRzF6bHNobEwyVjJUMlZs?=
 =?utf-8?B?Z2tlamNhUTl4bHVJS0JiUFZRbStBRVNWblEvL3BlOU5CdmVHSHRySGxSNTJQ?=
 =?utf-8?B?d25BV1BOUGFVV1lZYUZjTHJIYjFVMVVTWi9XYkl5aERGditiUXdHVW1mNXV6?=
 =?utf-8?B?b2RlSnQ3dFg1YWdzN25YVVVVYk5uWjZWQkVYRXA2Y1ZHTWE2VE82WkJyWlRW?=
 =?utf-8?B?NDBicmp6Q0I5V1ozREFhUzN3djhkQzFmNUlIcFdld0NIeVYzdzlxUDgzR2J0?=
 =?utf-8?B?anVGSEp0L015Q3JNeTlWK1hOckRubXRpc0hBMGtRcXZwSWxZRDFHRlMzdzlC?=
 =?utf-8?B?ZjBQcFpldStSVENvZG1vckdGV1J0TlZWcG5taUZsZXRXckcvQVpmOUh3T3Bj?=
 =?utf-8?B?b2JhUHY1NnNreTRlYUs0UEJjeGlET1Q1bTNvYjBvMEhVZlo3Ui80cmx3RnZj?=
 =?utf-8?B?dmRvdGhPeTNvaFJRajEvWHZwbFZLK3BjcVE5U3ZMRDFoYS9pZGhsbTR0K1Jr?=
 =?utf-8?B?NjZ2WEtBcDU5ODdrK3RhNCt5NVorRHJQem9IQmhGbVdSUEo5VlE0V0hNcXhI?=
 =?utf-8?B?bnR6VTE5S21WQ1MzWDNhZFRpaTNyVG90dWNHbXNyN29YdUdKb2hNcm9WQlFF?=
 =?utf-8?B?SWdsbkNxRmdiZWR4dEVSeXc4eUVWQTB1ZWl3L1RkZjh5VVpSUzZiRkY2OTlv?=
 =?utf-8?B?a2pvK21BNkJOUGczWGJFUFVBT0REc1BNTjIyR2lxS3BHdmovdi9oeU94MVRz?=
 =?utf-8?B?RzEvMTRGQXorZ3VBbzdqZGlzT1MvZ2duMjVTQWlwc0g5Y2pXRmp4M3lzejhh?=
 =?utf-8?B?WlFOS0FORWJ1UDR1Q0hwdE9VSkJpbDBVWEpoUnZuTEJRL0hITDQ1b1RXVFBD?=
 =?utf-8?B?U08yV0pPNXlYWmFkVkgzT1dVVlhBVHVNeDF6cmVKWDFRVklNbDM1NDk1OXJl?=
 =?utf-8?B?KzlhNFFQZm1YY2lRemJiRTkvUE8xZ0dYaC9vRDJORDhoTkhqYUpDY2xxNElF?=
 =?utf-8?B?dmN1VlhjM2NjMHR5MHJRazU1Nkl0TmNHRmR2UmxNWXR4Y0Y4bmxLT3ZtTTRw?=
 =?utf-8?B?bHVMQkhyWnpiZWFIUUx1S1JMVTRLMlArVElnaGloQlcvQ09kRlVzRk82WjdE?=
 =?utf-8?B?WGQ5VmVxN0w5bUgvbEVlM0pCcGF1d08wTi9BMVdlRWVUTlBtVHhodnVkN3g4?=
 =?utf-8?B?V1JmS0QvckVaeC9WYXQrU3NpaFlzM0lzcW0yaW9YMlIyVG0wNWVrTHAvVmVm?=
 =?utf-8?B?Y2Jnb3pvaFd0b3JJT3hFSnJpYmJlOENmR2MzdnVGQ0VjZTkvR2l5ZHZDeWJu?=
 =?utf-8?B?aG1xSm9YSkwzdVN0Q01BSXRVMG5iaGdmQjA0S2dKbklCbWljT1k4SW9TTWEz?=
 =?utf-8?B?R1pqSGZ3dnhmUTVPbjN6dE1LL0dVUEp6UmFZSXZya3E2YjB6SWdac0pNVXJM?=
 =?utf-8?B?QmxmMWsrYUJ6SU5GUVBOMzBGbTNzU3FQVS95eTdETkd5NGpzVEV3bnUvakpC?=
 =?utf-8?B?SEhFOU9ucW1Da09WOEhHUW5manlESlExUVlQS3o1N0U5R2ZneDZrVmtLOFBq?=
 =?utf-8?B?M1ZwSDJ6Qk5RZkNhZlk0V0lDRzY1LzhJUllEaDZueFMrbHlBSlBFRWJhSXpr?=
 =?utf-8?B?U0JEQVFiRXFLckpKMHlwMEpWL3pFU3NnaVNXc1ZqTnplNCt1NisrZTA0SnNH?=
 =?utf-8?B?dTFJYXd3b3drRHFzekhtR1Juajltb2hIQUtwRFozRjRMQjZRYlRmU1RrUkFY?=
 =?utf-8?B?STNaR2YyamJQR3lkdEYyQ1Jnek1xbm5FUjlqOXliTGs5NHVRRFMxSzJ6VTE4?=
 =?utf-8?B?ZkJwcm5oUUVZb3k2MXIzNnUwQ3dzVXZMblM1RnZ1Ykp5bEU4Q0poQmtoUUVo?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32706353A330784CB5EC8297309869E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a470b6-c8dd-428b-711c-08db5da3ffb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 04:45:15.3375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /r9mioajR/e0WRG6UTyKuyGvDPnoYHKvLQCAMRKtP8UEo55bjSAQKo0q22WMWeovORoWeGYyEth1hqj2NNKo9Tp1r9Fl1tY79PQDHVVbRB4=
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

T24gMjUuMDUuMjAyMyAyMDoxMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUaHUsIE1heSAy
NSwgMjAyMyBhdCAwMzo1NTo1OFBNICswMzAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENv
bnZlcnQgQXRtZWwgUElUIHRvIFlBTUwuIEFsb25nIHdpdGggaXQgY2xvY2sgYmluZGluZyBoYXMg
YmVlbiBhZGRlZCBhcw0KPj4gdGhlIGRyaXZlciBlbmFibGVzIGl0IHRvIGVuc3VyZSBwcm9wZXIg
aGFyZHdhcmUgZnVuY3Rpb25hbGl0eS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dCB8ICA2IC0tLQ0KPj4gIC4uLi9i
aW5kaW5ncy90aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQueWFtbCB8IDUxICsrKysrKysrKysr
KysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQueWFtbA0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3Mu
dHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdz
LnR4dA0KPj4gaW5kZXggNjdhNjZiZjc0ODk1Li43MDI0ODM5YzVkYTIgMTAwNjQ0DQo+PiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0
DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5
c3JlZ3MudHh0DQo+PiBAQCAtNCwxMiArNCw2IEBAIENoaXBpZCByZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPj4gIC0gY29tcGF0aWJsZTogU2hvdWxkIGJlICJhdG1lbCxzYW1hNWQyLWNoaXBpZCIgb3Ig
Im1pY3JvY2hpcCxzYW1hN2c1LWNoaXBpZCINCj4+ICAtIHJlZyA6IFNob3VsZCBjb250YWluIHJl
Z2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiAgDQo+PiAtUElUIFRpbWVyIHJlcXVpcmVk
IHByb3BlcnRpZXM6DQo+PiAtLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgImF0bWVsLGF0OTFzYW05
MjYwLXBpdCINCj4+IC0tIHJlZzogU2hvdWxkIGNvbnRhaW4gcmVnaXN0ZXJzIGxvY2F0aW9uIGFu
ZCBsZW5ndGgNCj4+IC0tIGludGVycnVwdHM6IFNob3VsZCBjb250YWluIGludGVycnVwdCBmb3Ig
dGhlIFBJVCB3aGljaCBpcyB0aGUgSVJRIGxpbmUNCj4+IC0gIHNoYXJlZCBhY3Jvc3MgYWxsIFN5
c3RlbSBDb250cm9sbGVyIG1lbWJlcnMuDQo+PiAtDQo+PiAgUElUNjRCIFRpbWVyIHJlcXVpcmVk
IHByb3BlcnRpZXM6DQo+PiAgLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgIm1pY3JvY2hpcCxzYW05
eDYwLXBpdDY0YiINCj4+ICAtIHJlZzogU2hvdWxkIGNvbnRhaW4gcmVnaXN0ZXJzIGxvY2F0aW9u
IGFuZCBsZW5ndGgNCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdGltZXIvYXRtZWwsYXQ5MXNhbTkyNjAtcGl0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdGltZXIvYXRtZWwsYXQ5MXNhbTkyNjAtcGl0LnlhbWwNCj4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmYzMDRjZDY4YWNkNQ0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3RpbWVyL2F0bWVsLGF0OTFzYW05MjYwLXBpdC55YW1sDQo+PiBAQCAtMCwwICsxLDUxIEBA
DQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy90aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQueWFtbCMNCj4+ICskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsN
Cj4+ICt0aXRsZTogQXRtZWwgUGVyaW9kaWMgSW50ZXJ2YWwgVGltZXIgKFBJVCkNCj4+ICsNCj4+
ICttYWludGFpbmVyczoNCj4+ICsgIC0gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1p
Y3JvY2hpcC5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246DQo+PiArICBBdG1lbCBwZXJpb2Rp
YyBpbnRlcnZhbCB0aW1lciBwcm92aWRlcyB0aGUgb3BlcmF0aW5nIHN5c3RlbeKAmXMgc2NoZWR1
bGVyDQo+PiArICBpbnRlcnJ1cHQuIEl0IGlzIGRlc2lnbmVkIHRvIG9mZmVyIG1heGltdW0gYWNj
dXJhY3kgYW5kIGVmZmljaWVudCBtYW5hZ2VtZW50LA0KPj4gKyAgZXZlbiBmb3Igc3lzdGVtcyB3
aXRoIGxvbmcgcmVzcG9uc2UgdGltZS4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29t
cGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLXBpdA0KPj4gKw0KPj4g
KyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+
ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgQ29udGFpbiBpbnRlcnJ1cHQgZm9yIHRoZSBQ
SVQgd2hpY2ggaXMgdGhlIElSUSBsaW5lIHNoYXJlZCBhY3Jvc3MgYWxsDQo+PiArICAgICAgU3lz
dGVtIENvbnRyb2xsZXIgbWVtYmVycy4NCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsg
IGNsb2NrczoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsg
IC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKyAgLSBj
bG9ja3MNCj4+ICsNCj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtl
eGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2sv
YXQ5MS5oPg0KPj4gKw0KPj4gKyAgICBwaXQ6IHRpbWVyQGZmZmZmZTQwIHsNCj4+ICsgICAgICAg
IGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtcGl0IjsNCj4+ICsgICAgICAgIHJlZyA9
IDwweGZmZmZmZTQwIDB4MTA+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwxIElSUV9UWVBF
X0xFVkVMX0hJR0ggNz47DQo+IG1ha2UgZHRfYmluZGluZ19jaGVjayBXPTEgLWogMzAgRFRfU0NI
RU1BX0ZJTEVTPWF0bWVsLGF0OTFzYW05MjYwLXBpdC55YW1sDQo+ICAgTElOVCAgICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MNCj4gICBEVEVYICAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy90aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQuZXhhbXBsZS5kdHMN
Cj4gICBDSEtEVCAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wcm9jZXNzZWQt
c2NoZW1hLmpzb24NCj4gICBTQ0hFTUEgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wcm9jZXNzZWQtc2NoZW1hLmpzb24NCj4gICBEVENfQ0hLIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy90aW1lci9hdG1lbCxhdDkxc2FtOTI2MC1waXQuZXhhbXBsZS5kdGINCj4g
RXJyb3I6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9hdG1lbCxhdDkx
c2FtOTI2MC1waXQuZXhhbXBsZS5kdHM6MjYuMjktMzAgc3ludGF4IGVycm9yDQo+IEZBVEFMIEVS
Uk9SOiBVbmFibGUgdG8gcGFyc2UgaW5wdXQgdHJlZQ0KPiBtYWtlWzFdOiAqKiogW3NjcmlwdHMv
TWFrZWZpbGUubGliOjQxOTogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVy
L2F0bWVsLGF0OTFzYW05MjYwLXBpdC5leGFtcGxlLmR0Yl0gRXJyb3IgMQ0KPiBtYWtlOiAqKiog
W01ha2VmaWxlOjE1MTI6IGR0X2JpbmRpbmdfY2hlY2tdIEVycm9yIDINCj4gDQo+IFRoaW5rIHlv
dSdyZSBtaXNzaW5nIHRoZSBoZWFkZXIgZm9yIElSUV9UWVBFX0xFVkVMX0hJR0gNCj4gDQoNCldl
bGwsIEkgbWVzc2VkIHRoaXMgc2VyaWVzLi4uIEkgaGFkIHRoZSBpbXByZXNzaW9uIEkndmUgdGVz
dGVkIGFsbCB0aGVzZS4NClNvcnJ5IGZvciB0aGUgbm9pc2UuDQo=
