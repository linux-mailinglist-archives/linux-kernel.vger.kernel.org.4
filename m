Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DC71205B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbjEZGlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbjEZGlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:41:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EEA12F;
        Thu, 25 May 2023 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685083304; x=1716619304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ofvqqv2Mdo2CN9KNsti+MXhwOGx8unpKccGhNVFykDg=;
  b=ZjYTZCHcpJVqX4cRhdlDzdFwwmDYmwWSmaoVMOh9AbquuIO02E+vFbxE
   xWxKf0wgrXqIdec/wzDxjQ/we3MLoamEuHgzLtHx5me9b2EKW/kZSHy/j
   Eiwm0JdhNwElW6tgZcP/SDZSO/nFKO8A3ilYwJbtBXgtqlT+2ojo3CtH6
   JOeIU6WXCYk2DMN8MaVMnKRiHbtnYK9blek4XcJ0wPnkis2DO3YQjy789
   p/ABCohi0DeK448xih7194hy5C5fdF6c+BIZaXTRWti6fc3arb42whDMY
   4a4l6TFtksmqe70/7s1JrwiIwFKGZfxjAGwohokHyC81FuUAiztYaBX3W
   A==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="217418113"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 23:41:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 23:41:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 25 May 2023 23:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvZNxnxxX2tKY3kkZ4f1jirvpZDyQ2a2faH5bvoV3FdzysOzFsdDowg4Chov40xjS4vhWuUCX+89LLg+aECL+ReFC6DBphlj5VVFfIXxF6KbfsdlJd3N4MPjX1xzcGSBmmJSL2xRyv067iTeHoX2n9Rz/xops55uCmC3oAwNLtVr+Jq4ZS45ZqYqvOa4+eWEr4Ohjb2bUupCRycfEW6KX7pr5LrFBTzeVVGDbfrgFQfwLNCGKBEvCi//tgyTVCLur+VfH97yGIFd9bMgR1MjQrAWaUiiNSliJZ/zQEos38hoIoywrWXtdRWHXLyv9zdu9nIQAzO9Na7wJwcweTouIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofvqqv2Mdo2CN9KNsti+MXhwOGx8unpKccGhNVFykDg=;
 b=CQU+9ukvLljL/IWrtPyqc4JF0fSw3ZJtTFRIUaFQLJZduJEHU4dGs1xHbf3zViEVt6QKlfXqoqwO2XGdS7SIkFw/N7S8DQKwlToKY7oBb6T9y62oGfOfxMZ/TlGaXETIeozG4C5yVdcePsDDjnbq60GDw2Drbds+i1km2DkW3vylngXVgY8xTuaBWkF0a2CCamwHCqZ0UCvmJnzlkgT0412ZzLRTPi4or31dtdpd/0ta11sPPfSzWxoCSoaE83HAqJ2i8vDCX7WsQhXrSWm6eqQu40Us8syi7R0IhCR7HbR/7dmSUBAPydbS+UfMBRZ6SlnIKW4IIwKCQyQWWZR7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofvqqv2Mdo2CN9KNsti+MXhwOGx8unpKccGhNVFykDg=;
 b=oiZcGyXJEmeSzJNiHcS/Z9zQdtbaSswXwThOb0GYYXQ9uU7zDXV5rLRfOrfhJjyrSmu5xGllvx7SZVDS945mB1S9Db/1V04ro9LtR9I1wLs5bjp/pgUK8y26PTgKB2bnMODfmToR0Ge4N5fym4KCRqhEXIDKDHlIDCZbTdhZ2pc=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Fri, 26 May
 2023 06:41:40 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 06:41:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>
CC:     <devicetree@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <daniel.lezcano@linaro.org>, <conor+dt@kernel.org>,
        <conor@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <tglx@linutronix.de>,
        <wim@linux-watchdog.org>, <sebastian.reichel@collabora.com>,
        <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b: convert
 to yaml
Thread-Topic: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b:
 convert to yaml
Thread-Index: AQHZj50fp08eOlsluEqhLuQqAw4PCQ==
Date:   Fri, 26 May 2023 06:41:39 +0000
Message-ID: <5a5d25a2-e6b5-fd69-f615-cd3d6ed33b9f@microchip.com>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-4-claudiu.beznea@microchip.com>
 <20230525-straw-fidgeting-4c1099aa16fe@spud>
 <5edf3d3b-6f59-0af3-6414-940a278962bf@microchip.com>
 <20230526-knickers-aim-e01220e6a7cd@wendy>
In-Reply-To: <20230526-knickers-aim-e01220e6a7cd@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SA1PR11MB6847:EE_
x-ms-office365-filtering-correlation-id: 6eb0d5f8-9504-493f-a6df-08db5db44265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1M1CHZemiFcEX0j96IbzYzglkJ+rL3lf34pTAfyE+eEu9ztdhwWt2nWw4y5pSNTrYiegqOeuqVf/BRT9CVFLVg3TXRk/Mjx597Gbaz2+d9wIoQqvzd4N1UK+uADxdT0ThQdS49cKMTRycPolzZZmQo8H/OSkpHWGku8vCtNOeePubx+MTGzel0u7YeMVN/BromhgMqQM1SO17sMcqIxo3iLy7uVnGzWgxHxZeb3unQEYJpHsSvTQNp9YqIxWd3MNLhi2My1YGToS1oBZKnrgRWiT7PtwXrF/tjsK9Wdn8Yzf+F98+sLHhMrTbb0N8U9ITeoj+yWSebdOVZ1yA/p5o1oND5Q41OP8aJgndNxVYuv08d2XsHhbplU/HvSJVcMV3hhvxtaS47uSchUu3yHYub2n2Gl7er4o2RKj39qoeVVDHAU6Q3cnfGXu70gr9tvtEwqfrdb57QxtorbUISaj7eY4ZPszXXZXkYqblgkd09bN4pl4rTZhsj7GKzHriE1mMCaXi2peIA4shgNNOcxCc3gNd4MHxwPsaDqq5BI10zDCn7VROInA/Dh81XXeBRdyjxdFkXOjtVykIbM2xvt9JwnjL5D2Ai4FrMOwVpSjc4mi7lJDYuQLUSdZN+pVoSfgFjWD9RGj+Kzqgf5D2HNZL47UFbLcVNoKYSDNx0uXkmI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(316002)(6486002)(41300700001)(7416002)(6862004)(26005)(53546011)(6512007)(6506007)(8676002)(8936002)(38100700002)(5660300002)(36756003)(31696002)(2616005)(83380400001)(38070700005)(2906002)(186003)(86362001)(966005)(122000001)(6636002)(4326008)(76116006)(66946007)(91956017)(66556008)(66476007)(66446008)(64756008)(37006003)(31686004)(54906003)(478600001)(66899021)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEZjZnZ3bzA4YTFYOGR2OEF2dTI0NjY1TE9RbFhMQXdJclJxeEp2MmRFTWJj?=
 =?utf-8?B?OG5SVER0ZDVWKzJXdDBUYXlBVlJnbWEzMTJnNjZadzcyR255QTdubzJ5WGdt?=
 =?utf-8?B?cXJuTVVmdXU1QjcyR1hEMDlTZGo0S3BWSkhJRXN1elBQUFNTSlhmaFNkQ2FT?=
 =?utf-8?B?aDIzRTVMSExLOGJyb3JVZjlPRHprditEekRPUWRCUDJuWm9FYzJEQm5oRis5?=
 =?utf-8?B?WDIxQW9WUTg1T05iSWFTVWpFdzNXckJxbFdnUjNIQjJVSE9FdzNOTFJ1c3lY?=
 =?utf-8?B?OFJlUHFKaDhKVEN6cHpNbm52a1RXa1dvVjZ2WnJELzJwalZudGZ2Q25HL3FV?=
 =?utf-8?B?SXRwTEpPSHhhelMyZXg0MzB6dVNBeHhSUEhTMEhOSjJFamdDWFo2VHR0TDNq?=
 =?utf-8?B?SDEveGdZcmpXRlVWdURrT2hjbGFTdlE0dlNrYmpYNDB2ZEFmSmJ6MXBqcGs2?=
 =?utf-8?B?Rm9peHR4cjZBN0wvbkR5cnVjeHMxMlg5ZjViaGo3N2k1YU5xd0Z5cFgrcmda?=
 =?utf-8?B?ek15MXA1cWtGRjY0SFJZc2N4YVFESVRHYVhBZld3dkx5Nk5Vc2lkOTVNYjkv?=
 =?utf-8?B?ckR4d1gyKzFmNWlxVWZWNTNzQjlJMjJOczRBZVJBVmhpaHRUS0k1QlFxdUJ5?=
 =?utf-8?B?bXhwUkJYN29hSEpYRDlESDRpd01DRVF6cTF1a0Jzbm9ZZkt0bEt6V3AxRTg1?=
 =?utf-8?B?R3FjL1Y4MmJ4V2pWa05Wd1R6b2FaL1VkQ0JyVkhkeHIyZ3pGalJaekZmUnpM?=
 =?utf-8?B?REswMWFldG52QlU0bElWS1l0YXBjc3FmR0lmRVdpaVVtN3VMdzVOMXFGT0t0?=
 =?utf-8?B?RjlEZEJ3N0FnYTFhLzRvRVZLYTdGcjY3bnpMMmZUVzJ4c3dVOWlIWGNNWlFj?=
 =?utf-8?B?VzNBaDJHMWZSNTBIUTd4UGJWZEtqajllazJobFQ2bW1qdGFqTkN2R20xOXlF?=
 =?utf-8?B?R2xwZVJLYklBdXlEamVodTdVL2xLbWR4MlE2a3dJb1ZTSi9lTHRON1U5aUFt?=
 =?utf-8?B?VDlVaWIxZG9vSUxVVnpDa041WGxtMEs5NW1JNkkvVlFjNVV6L0Robm15MC9n?=
 =?utf-8?B?eGt4VGJrTURWQzJQbW5FTkRGQW1VTnRheHUvTUNsQ3NsRm1KUCttUk9WNGNq?=
 =?utf-8?B?WGR3LzU2RjNOWE54ZUdXZ2lHcEhHRXUwcjIvMnBsVGFBNkNzMWx6L1dRUVNJ?=
 =?utf-8?B?dFAvYW9lS0FlRXJXb1ptS3dYb1RIT0N5TUhFZitFWDlkNVlVMUlXV3IwYjRR?=
 =?utf-8?B?TEtPeFRMVnFBUGZNc1F2cFZzNHBBM3d5KzFzeFVONGZYdXpFcUE0ekR4dXA5?=
 =?utf-8?B?Z1dNc2NIVEJwcnBab2t3TkJSdmpmRlVLYS9XSkVTbW5oWWE2TEJ6aytFcEtp?=
 =?utf-8?B?MGFweEZKaDhSR1Y4dmxienNLYkhrRGQrZU5yQ3dHdEcvNHBmK1pac2wwbzQz?=
 =?utf-8?B?cGZac2paYWsrbVkrS3MrVGcrWTNyWmlZeXJETU1hZWVRSndWZm0rV2JEMEZu?=
 =?utf-8?B?K25aUTZodzM2MWhIY1F4S21PZmR0aExXYU8yZ3FZWG9pMUdleFlWTUdZR0hq?=
 =?utf-8?B?akp5M2VBL0VpOVd5K2hlU0NsNlFkSEFMRFA5bVZjQldvVXd2ZG9YakY5UjdE?=
 =?utf-8?B?M2dzRE9zQlhsY2w3UkU2UGtMQVd2cS81Wlh6alBTVlFyZUF6SWxlUVN4TThW?=
 =?utf-8?B?RUZhdXNMVlc0dE9vWmhubVVCSityME4ySUI3eGFuRDJOenRub3h1VHBiVlBp?=
 =?utf-8?B?cnlKLzA0NitZWlFxY3FHdHE2NFVrNCtQSTAxQWlZZm1tcmc5Qm0zOEQ2OEFy?=
 =?utf-8?B?NzJoNGlvd0JQaWJOVnMwOVlKYy9FUWJtN2JXeFJheHovUGJ5MW0rUTNaZFNQ?=
 =?utf-8?B?M3dIbEhLQXNWR2EvZUc0bXhlOVpqb3I2ZTRkbkZZMnpycERCeDFMOTFHQzZO?=
 =?utf-8?B?dDJ0eGNyTjl6Y1RybXd3bGFJRnpUclduYzRhK2xJTmlTV0NBYllEd0ZHN2s1?=
 =?utf-8?B?TmpMTmhOTFJpQVJxckFUY0dmVlRkclZvdWRMVUJhd2ZHR1lIZ3lCbUJTWnk0?=
 =?utf-8?B?ZkRqR040dVdoYmlEeFZ1Z0JjOHBZN1ZvNjZrZmhFcXd1SE9wUXJtaklqMTlI?=
 =?utf-8?B?T1dyTFdXOUU5RHpXem4yLytmamViWFQ2TlVyYjFmR1lnRVg1Y2JxR0xHMWZ2?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <855C4C0D4C0B144C98F017311CE6E2C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb0d5f8-9504-493f-a6df-08db5db44265
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 06:41:39.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ia/b1VnGTUU7X96GsunnrL3o2WamTPvL9ohjh7A+anhBQ5p5eNOpmYNQqDEYQ1vZw9c4gvbU1v8s93ZWtS3vTjfO1zu6XioL2Ihx4FlWSXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDUuMjAyMyAwOToyMywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhleSBDbGF1ZGl1LA0KPiANCj4gT24gRnJpLCBN
YXkgMjYsIDIwMjMgYXQgMDQ6NDc6MjhBTSArMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IE9uIDI1LjA1LjIwMjMgMjA6MTQsIENvbm9yIERvb2xleSB3cm90ZToN
Cj4+Pj4gQ29udmVydCBNaWNyb2NoaXAgUElUNjRCIHRvIFlBTUwuIEFsb25nIHdpdGggaXQgY2xv
Y2stbmFtZXMgYmluZGluZyBoYXMNCj4+Pj4gYmVlbiBhZGRlZCBhcyB0aGUgZHJpdmVyIG5lZWRz
IGl0IHRvIGdldCBQSVQ2NEIgY2xvY2tzLg0KPj4+IEkgZG9uJ3QgdGhpbmsgYm90aCBvZiB0aGVz
ZSBQSVQgdGhpbmdzIG5lZWQgdG8gaGF2ZSBkaWZmZXJlbnQgYmluZGluZw0KPj4+IGZpbGVzLiA5
MCUgb2YgaXQgaXMgdGhlIHNhbWUsIGp1c3QgdGhlIGNsb2NrLW5hbWVzL251bWJlciAtIHNvIHlv
dSBjYW4NCj4+DQo+PiBCdXQgdGhlc2UgYXJlIGRpZmZlcmVudCBoYXJkd2FyZSBibG9ja3Mgd2l0
aCBkaWZmZXJlbnQgZnVuY3Rpb25hbGl0aWVzIGFuZA0KPj4gZGlmZmVyZW50IGRyaXZlcnMuDQo+
IA0KPiBIYXZpbmcgZGlmZmVyZW50IGRyaXZlcnMgZG9lc24ndCBwcmVjbHVkZSBoYXZpbmcgdGhl
bSBpbiB0aGUgc2FtZQ0KPiBiaW5kaW5nIHByb3ZpZGVkIHRoZSBmdW5jdGlvbi9kZXNjcmlwdGlv
biBldGMgYXJlIG1vcmUgb3IgbGVzcw0KPiBpZGVudGljYWwuIEkgd2FzIGNvbmZ1c2VkIGJ5Og0K
PiANCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBUaGUgNjQtYml0IHBlcmlvZGljIGludGVydmFsIHRp
bWVyIHByb3ZpZGVzIHRoZSBvcGVyYXRpbmcgc3lzdGVtIHNjaGVkdWxlcg0KPiArICBpbnRlcnJ1
cHQuIEl0IGlzIGRlc2lnbmVkIHRvIG9mZmVyIG1heGltdW0gYWNjdXJhY3kgYW5kIGVmZmljaWVu
dCBtYW5hZ2VtZW50LA0KPiArICBldmVuIGZvciBzeXN0ZW1zIHdpdGggbG9uZyByZXNwb25zZSB0
aW1lcy4NCj4gDQo+ICtkZXNjcmlwdGlvbjoNCj4gKyAgQXRtZWwgcGVyaW9kaWMgaW50ZXJ2YWwg
dGltZXIgcHJvdmlkZXMgdGhlIG9wZXJhdGluZyBzeXN0ZW3igJlzIHNjaGVkdWxlcg0KPiArICBp
bnRlcnJ1cHQuIEl0IGlzIGRlc2lnbmVkIHRvIG9mZmVyIG1heGltdW0gYWNjdXJhY3kgYW5kIGVm
ZmljaWVudCBtYW5hZ2VtZW50LA0KPiArICBldmVuIGZvciBzeXN0ZW1zIHdpdGggbG9uZyByZXNw
b25zZSB0aW1lLg0KPiANCj4gVGhvc2Ugc2VlbWVkIGxpa2UgdGhleSBkbyB0aGUgc2FtZSB0aGlu
ZyB0byBtZSENCg0KVGhleSBkbyB0aGUgc2FtZSB0aGluZywgdGhleSBhcmUgdGltZXJzLi4uIEJ1
dCB0aGUgd2F5IHRoZXkgZG8gaXQgKGZyb20NCmhhcmR3YXJlIHBlcnNwZWN0aXZlKSBpcyB0b3Rh
bGx5IGRpZmZlcmVudC4gV2l0aCB0aGlzIHdvdWxkIHlvdSBzdGlsbA0KcHJlZmVyIHRvIGhhdmUg
dGhlbSBtZXJnZWQ/DQoNClRoYW5rIHlvdSwNCkNsYXVkaXUNCg0KPiANCj4gQ2hlZXJzLA0KPiBD
b25vcg0KPiANCj4+DQo+Pj4gY29tYmluZSB0aGUgdHdvIGludG8gb25lIGZpbGUgd2l0aCBhbg0K
Pj4NCj4+DQo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQoNCg==
