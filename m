Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484F71562F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjE3HGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjE3HGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:06:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F62A0;
        Tue, 30 May 2023 00:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685430370; x=1716966370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M1sCd9loaRSAp2UF0iAYNVoLAiUwvMeulIqIsDc44pM=;
  b=gE30t64U3BvepdRJsgi9J2Cjv5MCwIm2NOeQNE/aDtrFE45LnOdiS3uY
   JbAX82fYazYp+BvBEaRq9S0RxBS6+cRfOGQlnHPDjaumNmi4+mKbtzG+U
   hIlgASHkPKhgfinjmW1oIb4DyiN+3T0270RXRNygxZAn85pLFu7F/IcgR
   VGWZWONIk1w71Z3iTa2OjeNpQ94f6I1mrfZHHdY2NCtEYd1bgC/ZJS/8V
   W8iKB5E1vX1xocuxqD9IEEAlTQ3Huakfj7GkvOc5QJpn8wlOw43/jR413
   f1kfa+mLBnc8EjT3YfN4fObLjeU/AiIKQGLUYvbSjzhtqPBA/6XgZSNQm
   A==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="213663059"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 00:06:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 00:06:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 00:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdyX+I7MCEJcufOVI+Wicmc8ufVWcRQxvStEwN8nDWeRZEea+ZfhD1lZSliOCps6mXne/hYxoL/S3Cb3Fyd9KWRorZJRTVygpc9ezChZpnjZZvOnrChw3Fd5xTswGiMi8MMWJF2TksqWDOaeQ7ZmFuo5/iVLpP7m7X30MH1z2q/q5YQdgqCMwx6f65Zkjk4Q52mvTNtD7ozLGl9sCqNLKUqjqTDFKsRZ+mLaSex+HQB1up46uD+dA9+Ox7NO181Ql5SAC/JyKoemV2pEs4tTYsflvWb8wKNVF9gxQF9oiHvpTSHP7xh4+5ohE0wf4pThqF8cYm9dmCf9nquKjZAX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1sCd9loaRSAp2UF0iAYNVoLAiUwvMeulIqIsDc44pM=;
 b=XdZvaSF8vSI2LYy2pHDlSToeDccgTLpzROz1SahMBWcuIv6QlRtRhzjG5ZAyOd5TJVE4kCX5LwYiKowJ4OtJydqJjwr5H7/7F8s6+groWFbQfY54nRdiqqdBCkaVAJpyLETFzrlTlq8x0/tR4PcRyxp8fnx/wjXwcX3zSGR7Kua3ws+ReFFS6E9vTkW3L/EbhwqH4qb7iAeP+YvjtRZDk5GGTp8HSL97JBcd+X23G0JHV2vOHIzOBoj1BHzs/tYE9E96K/83D//1jlOR59YJodtfz0xIam5QvzKuRshyEWnmJxkstcAAtylNhFiJ3jjxXW4jQTtoksAbywART1AUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1sCd9loaRSAp2UF0iAYNVoLAiUwvMeulIqIsDc44pM=;
 b=GhTXgpS5Oj4euUVeBKwdKecRvhg/9fu6JS61zQ+M4cHZt6XKyCNGE1yf5WkroNZKj3KhWdYFA/oAQEZJh/SKtTzXRWfSD9KmEL6AGCN/OlpnwkmHTjIvkXyNjmRfEkbDuLgcjLQ61DMRgfWQcfl2CqesT8iov2O6kjoSmMLnAuw=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:06:04 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.020; Tue, 30 May 2023
 07:06:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <walker.chen@starfivetech.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 2/3] ASoC: starfive: Add JH7110 TDM driver
Thread-Topic: [PATCH v5 2/3] ASoC: starfive: Add JH7110 TDM driver
Thread-Index: AQHZksLQbOi9N2ZAKkCgvv+8WuoIua9yZN8A
Date:   Tue, 30 May 2023 07:06:04 +0000
Message-ID: <7a1a3ac3-10ec-9935-bca1-023cec6c0024@microchip.com>
References: <20230526145402.450-1-walker.chen@starfivetech.com>
 <20230526145402.450-3-walker.chen@starfivetech.com>
 <143e2fa2-e85d-8036-4f74-ca250c026c1b@microchip.com>
In-Reply-To: <143e2fa2-e85d-8036-4f74-ca250c026c1b@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CY5PR11MB6284:EE_
x-ms-office365-filtering-correlation-id: 08b1d116-f1d8-40c2-1aa6-08db60dc555b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cnmVuIwtldZpVhn18/e2B8Zou6Gf+rq9qLtHznPxnO57jIyWyLC/TjukoQQR8c6tbthfYbG+cNPrcaMeBAW6OPbf6Yamj8LB48ZHWsurtvhcM4KJu984YyajQi6jnZ5GSaRVblTjBfMmk1dpEEbajT5PpWYvX+jAi6M/2oFtqnucCLYNu6O+LUkTS6DeLG+h70zM8df0s/a4EytedkNPgcMRtN9FoYVvo1CrCX95o2BSMFU76+L+ElJBPA3i0vzXWfF2ZArh9Y6sde+FRLO1Tb0sYb8HjRsKqrn1eBKSNIzWD2Q22vapwJ0Bavbwe03bib2LEnF4n3mzKHWTHda6lJaoiGxXrxSgn8C2t11uqVGr4dTf2BGcTHLkHynTkQNySabtfMj5lsxXj4URJNGqyxAZFfzTOAWUvmucFhyyZ2Uyip01jqKrc6PfwxWIkAJCWZq0X6/lpdGSVqPrtro5tSokALPyF694FXOQHjvQ62iBW2PGgHHofeAhB8R1FaJgmN0h7Jk1/aHkK/dxLZo4ut2tln0B0xDrPa5RVESuplYRqrdUFCYBjI/Tqa49yedi+hL5zz0ElsC5LcwbvPW/EqXbSMkDtf3nT+ctDZZlA0SOrofaRs+Khd5Rt+YF2ednOgSkBEUEqrgOpEbQbiKSFEvZpCEPTv8gZQwnKs0DPRp1sFWX6SQZwL1dpNvO9SJoQ6i42hLjf7oOc/Rn04ttw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(31686004)(478600001)(66446008)(91956017)(64756008)(76116006)(66946007)(66556008)(66476007)(38070700005)(110136005)(54906003)(4326008)(316002)(36756003)(86362001)(31696002)(6512007)(6506007)(53546011)(26005)(186003)(41300700001)(8676002)(8936002)(7416002)(4744005)(2906002)(6486002)(71200400001)(5660300002)(38100700002)(2616005)(122000001)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3RiKzB5OW9ua2wwY1JodWFLWXhtV1M5TVo0QS92ekNrNjQ3UVZxZ3NQQ1hh?=
 =?utf-8?B?M0U5OXczWlZpbk5VdkNyZjZnczl2R2FwMU9FK0VjZ0grczcxdzAzbDVPR2I1?=
 =?utf-8?B?VkFJRTlqTno3NkxUbG9XUkV0QnoxbjRWU1RCY2hGejVTakxLbHNEbDg5MHNL?=
 =?utf-8?B?bGd5MExlaUhvc2IwVW1ZNDR1dHQvTExUYmtzZW9kTlhTS3c2Z3o4VkVoemc0?=
 =?utf-8?B?ejk3Ylp6RWhFcWF1aC8xcXVzeTNPZlJqUEoxTldqamthM1FNczFHOFM2OWMx?=
 =?utf-8?B?Vm5YSmJrRm9qc0MxRUtnOWo5RXNNdjQwUDRPTFlDTFJGTVZKWDlhLzVpRjEr?=
 =?utf-8?B?d0FOakJhWWpIcjl4bDlYMUlKNDUyd3VtVzN0UGNHS3ZUcWN2QllQK3BVeTBO?=
 =?utf-8?B?dHBaM2YxS0hPYkZKRGR4YnpmbGM4TlJGWEttYk5GWGY3L1MyNER2dlh3WGVQ?=
 =?utf-8?B?a09WcFd3UzloMGJrK3FoNlp1SHpNVU9KZVhSZ2JXU2swYytmNENOZnFLNDMy?=
 =?utf-8?B?QUhzdlZBU2xIeDdIcXRjaGZPUzkrMEEzdVE1RGdQbzRvSms5NS9wTzROc2ZW?=
 =?utf-8?B?VnpFQnpENGhyUS9LYW5qd2kyTzdTZVZLTkpOUllnM0lhd3Z6alFsenJ1K29s?=
 =?utf-8?B?bHpvNDVCTHB5Q0xYWnJSUnN2MVFxVlJMSm0vNDl0ajhEZFBtdWNCeGZvS2RY?=
 =?utf-8?B?dGZHNmZsV0w3MU1mczBKT2wzUms0ZjQrR05xaW5mdFhuYmttbjFSMUJzY1lx?=
 =?utf-8?B?K3BvMXlFbHBHY3dOYzRRVlAyME1oUkIrZFM4SGZ1aWJEV1ZMNlBhOE16QWpq?=
 =?utf-8?B?Wk5nZ2RKVE16eldLaXpNZzBsVHhtRE5sTS9RNWIveU9PdVZuMGtPSlJpU2tI?=
 =?utf-8?B?ZWt5cUZzREgxbTVTMDJYQ0loMC9RNjQ2SS9YNVNkRHhWdXlUeVM0RVlkRSts?=
 =?utf-8?B?MFg1SWNFZG5Sb1dlZ01oVVR2TWZQMzd2Rlh3cGk5UnBTcnZzZ0pCTmVyQ01U?=
 =?utf-8?B?eFEvb0ZpNmxPYkxlMUUrSGVuKyt5MnBRWmorVzFURHBMQ1oxbzhsUWJ2TXIr?=
 =?utf-8?B?MWpQSWM0aEpUREhSZmpFTXlaWGJYREljNEZvM0ZxNFE5aUFyY0hXTHZTMUJO?=
 =?utf-8?B?cU8weTNDcDQ3bmFPME5NeHBhZVZ6QUtJTVoyY0ZBK3BOQnN5MDlHN2g2T1FZ?=
 =?utf-8?B?VXBkbVNYbkZob29SRU1hamNKVkhuMC9EbWRBOGZnN0Z2U3l2VVBJTVlkcXl0?=
 =?utf-8?B?RnREVlJJTVU2TGkxWUxocU5YeXBMbm50aER0SEFLTjRzNFBScGJDNlRhSXV4?=
 =?utf-8?B?Yms0eG1LZHVZWCtmM0tReGNpNmxSQjVUZHcrdGp5cXdrV29zWmlZS2NMY3lH?=
 =?utf-8?B?cWpQSFNNdHZTL1ZwNlluVmhmS25WZFpTcVMyUGlOdGJ4NjlQWkVCL3gzRTNY?=
 =?utf-8?B?QWVQcGkyRjVDaTVOQmsxTVdBVzA0S0U2eUhmOWtOQTV3eDAwNjR2bXFjK0Vn?=
 =?utf-8?B?NzFpS2dCdVlGZWwwYVpmMk1VTFY5TmZlUFJEMHM5UGFFTjR3cUsvb3BFekNi?=
 =?utf-8?B?NDBjaVZtOVh1UXFmUjkrcEYyQjVNV1VRWXY0bEdlVG41dGJOaVhMQlo5aWQx?=
 =?utf-8?B?RFJFbTFLY3Y4bHY2K3ZoWnVlTnd2b1Q2bmhpMVZndEJyRmNzQ2RWdHUrem4x?=
 =?utf-8?B?WFdjMTBoTHFJblM0eVF2eGZUd1I3RmdraWI2OVhVMk9iVmdheTIveHkwblpC?=
 =?utf-8?B?ZGRabVBZVlpabXNGaDZDQnkzZldvZ2E4dlF2dUt3RTBmZkYxQ0VvUWtMWTBT?=
 =?utf-8?B?K2R6NWZSV09DREZPR05LTDFzQk5MRDBkb2pGNk9sTDZ2YTRtRXVBWk4vNFZ3?=
 =?utf-8?B?ZUt6VW4zcmdWbnhQRDllWXdLYW40Z24ycGJTN1BidU9LQkVjUEVvRWJMMXVC?=
 =?utf-8?B?U0E5ZVlrY1Fnano3WUd4bzRETkNxNksrR3ZkRnR3NHlib0NxQm1RL3FBM0Na?=
 =?utf-8?B?blFKbWlJOFB6MCtndjE1SGQwU3c0WnFka2h1dkxhR0R3OUp0SEVod2o5Z21V?=
 =?utf-8?B?Q1lhOGlqWTRmMWEvMVBpYllMUUtZcHI1YlNzSFNWUjB4UDNZTXNtMGtsVWZW?=
 =?utf-8?B?MGU0WGxwR0kxcDVLV1p5UENIMktXdVVoNUgrOUlmTXhPc2luWWFUdVJwM0kz?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78087D165833404BB92F5459463720DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b1d116-f1d8-40c2-1aa6-08db60dc555b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 07:06:04.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2uapvBBYAXHw21n4/ASm1U8U2BNgqPdLtFV0rwcHFK2u7vabyKWDqUlVjK92dlAZshR1atWYPJtHdBQmdEytxU7IvJ+cJoRb3Ls6rX2A78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDUuMjAyMyAwOTo0NywgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+PiAr
ICAgICAgICNkZWZpbmUgQ0xLUE9MX0JJVCAgICAgICAgICAgICAgNQ0KPj4gKyAgICAgICAjZGVm
aW5lIFRSSVRYRU5fQklUICAgICAgICAgICAgIDQNCj4+ICsgICAgICAgI2RlZmluZSBFTE1fQklU
ICAgICAgICAgICAgICAgICAzDQo+PiArICAgICAgICNkZWZpbmUgU1lOQ01fQklUICAgICAgICAg
ICAgICAgMg0KPj4gKyAgICAgICAjZGVmaW5lIE1TX0JJVCAgICAgICAgICAgICAgICAgIDENCj4g
SW5zdGVhZCBvZiB0aGVzZSAqX0JJVCBkZWZpbmVzIGFzIHBsYWluIG51bWJlcnMgeW91IGNhbiBk
ZWZpbmVkIHRoZW0gdXNpbmcNCj4gQklUKCkgbWFjcm8gYW5kIHVzZSBtYWNyb3MgaW4gcGxhY2Ug
aW5zdGVhZCBvZg0KPiAgICAgICAgZW51bSBURE1fQ0xLUE9MIGNsa3BvbGl0eTsNCj4gICAgICAg
IGVudW0gVERNX0VMTSAgICBlbG07DQo+ICAgICAgICBlbnVtIFRETV9TWU5DTSAgc3luY207DQo+
ICAgICAgICBlbnVtIFRETV9NQVNURVJfU0xBVkVfTU9ERSBtc19tb2RlOw0KDQpTb21ldGhpbmcg
aGFwcGVucyB3LyBteSBlbWFpbCBjbGllbnQgYW5kIEkgc2VudCB0aGlzIHNlY3Rpb24gYnkgYWNj
aWRlbnQuDQpUaHVzIHlvdSBjYW4gaWdub3JlIGl0Lg0K
