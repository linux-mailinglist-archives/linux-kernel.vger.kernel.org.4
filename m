Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A9A7291C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbjFIHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239406AbjFIHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:51:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2599449E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686297039; x=1717833039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fqy5zoim9VAgnoc4IMuriBChYyA/to271uQCNonVXEM=;
  b=yj1Fe52+K0qn9dsAAIIlUVPR/H5bzFYXLQjKwlPgjwQEVTkN8852duRk
   daXceq7n4dtU//Hg+sBwQWzdcwtw8rryYBwbRXu0/3spNfCQqMxjj0l/l
   ViKSdqeWpv9766adH4qG/l3T+b6Y3ZI00bl8Ob58RGvSNgCteGAa9hkk8
   9gCv8siWHQ+xsvihuE/+t+na9+jKSNbZZXVfuN+pWnJf4xXbpQZrHch7u
   8xVDbLXmBFCAarZH/9a6I/jnw1MGsqn0mQAinsEG7uKB+DNSAQhyzosQy
   duj9Jf5So9ePMa33VU/5xBobo+YBQCDEttnRyTPWsePiSbI5i7sCC7cwE
   g==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="156231842"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 00:50:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 00:50:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 9 Jun 2023 00:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjVgWIV+AHcpR7VMCJxmr3Ok2jJv3i1Q8Oe8haLLCtFqHk86V50JLdR1u3W9yGPCtau3VNKOiYIIZxfFrSX6ufhZIwZ0xB29bqf4FA8w30tYWLEiLRgxmHSiRJWTOXWoz214SecO4KFnUteoJBRuBT6NuT1DcMlz3AhYyNsc6CJzIgaKAh4aNpMWcnRzoc93wsgEYQU/bYdCsglR8Z3LSQ2Mk9+l+2oemtZFrdDe168924/tz2aNJEEGFZtscfmYEc4uGZ5Y8XtTDRW2CtN9cHbxccQtEoV0akNI6bo0lrdLcwn85ecIHiaM2ViAw7kL0YhA6RDf98bIz0U1Q8xU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqy5zoim9VAgnoc4IMuriBChYyA/to271uQCNonVXEM=;
 b=L2L9b1P5qHdbGeXo26KzDFO6Sj2g87Kx2NFTrBUDW6UzzD0OCanpZhcxpUePRsG9QqM/RdmFgVfA28NZ1PzxbJsvCdnJDNQOaipNYjSt+UdgDtQQIGuUaBuJE0gCu+Dr4NCHhsRomPUKgFRqLsJNiCkhaG9QITu8yBRdiSaGaumw1QWJnTNpf2KIEPCZwjTcQYb4AfyIZQ7GN5SzJa4kUfFRWb69GAFDL36bgXi6QaM+0sDKk3IsQDUjlcvIflyj9i5Ec7q3CtkEI8U9MBZDAVpKtfh1BDxouuhDTfbgYXJ2ixclHyFI3oUIuP6SHSGpf1ZOE//h8dLBNnzX5PnuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqy5zoim9VAgnoc4IMuriBChYyA/to271uQCNonVXEM=;
 b=JlDu2OSU56dzceylP97Gjz4vUHiYMzK1JDoIhhLxjfV5aB+U0I2H2SVb6C2mNebVNwvvBqM1JBl1xFx2pS3xGSiAIkY2ViBPYNcgEr83BvjiQbebnqgjMjiPC8GLnASyejlN9k8jWEbFLz5W+OWDlD1YW4oKCkolwJfyQ0tccSo=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 07:50:23 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Fri, 9 Jun 2023
 07:50:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <walker.chen@starfivetech.com>, <broonie@kernel.org>
CC:     <dan.carpenter@linaro.org>, <lgirdwood@gmail.com>,
        <tiwai@suse.com>, <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ASoC: starfive: Cleanup and fix error check for JH7110
 TDM
Thread-Topic: [PATCH v1] ASoC: starfive: Cleanup and fix error check for
 JH7110 TDM
Thread-Index: AQHZmqcLHVElYeHJskuiJ2S4SJLmYA==
Date:   Fri, 9 Jun 2023 07:50:22 +0000
Message-ID: <a3e522e3-9836-426f-6f46-336eb157e1ef@microchip.com>
References: <20230607081439.1517-1-walker.chen@starfivetech.com>
 <3eb7ffc5-a16a-4ac2-93a0-260f7cb1f81c@sirena.org.uk>
 <d941ac20-e8b3-cb13-4258-3a9a86e978d3@starfivetech.com>
 <fbbc0963-fba5-4178-b886-fbb35c0c8df2@sirena.org.uk>
 <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
In-Reply-To: <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CYYPR11MB8431:EE_
x-ms-office365-filtering-correlation-id: 38cfa019-7822-44f0-0292-08db68be2dd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MZhTxJjb4ZNq/1bd8P7ye8PfBrqHdJzVyDSANZvHyvxqcI5Wm/1NfQ0YhvE2KpXcJIzam9dubDGvW5DIy992+1zpkl8HRQ9Rhja7VZjOSQiMOBlnR6rjN2q0GqRRPgsmaGyI1aXhD6peI+sPEhg3gMS811s+ktJaabSJRGzMvs8Vz3L13OSjr6KleesbXYbf46n+xG/FpQRFSS6MXHpky9TVcf0l4uDTRcaTePLqv3BnHGWlNJ2Jp3wuPKuInZazpzN/5Kf2SnFeabrG5qj+kEPjBMRTh/HnSvhD+abWEhIxG5ce5M/HhCqi9US0WuGQNJm8MKGb8IrOy/CBaCELICVE4yr6D5deNpj7xbp1fUWeGJTU1vTzsmGBx5qQYs+nyeuTT6CvXvPYPWsZdml6B16PDUg6xM8XErQuoCVPVELudxhumQy4NAFbijj6AwYVxcjHpxlBVGXcL1BsLbIRwYBKzO/1Po9PwzjK7oLs3T7B8xM9ganqeQv1Cmn+3xLRbvv9Rf7LCE35VgPcPXNSFs+qWY/JK6iYyfjWm55L9E6OFldlwg79xrCup91vYnlySSJjPlOjIdyAGYxD/BhWLuFPOWGbJthfzHuk4R/uVnRj7sYX3pmJbWEaClia5YoUK1eeS+R1LVxmMMQ8e/q7Ryn8Z07GGFOAb6ftfPrgjxWifyQST2aUEBiwCD7Dx+mLNcaG1AxyJ+yD0KyEzTP+KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(2616005)(6512007)(53546011)(38100700002)(6506007)(41300700001)(31686004)(6486002)(26005)(186003)(966005)(71200400001)(478600001)(110136005)(54906003)(64756008)(122000001)(91956017)(66446008)(4326008)(316002)(66946007)(76116006)(8676002)(66556008)(66476007)(8936002)(2906002)(5660300002)(31696002)(38070700005)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3Q1ZTI4SURZbTFjV3V3U3ZZcXF6YlNTY3hySHFkZU54V3QrSzBmMVo5VndL?=
 =?utf-8?B?STExcU80STUvay95QzNnM0o4UmxMT1dGeWJONWJoTFdPVldrZDVmbUFBR1Zu?=
 =?utf-8?B?ZHhURVVsMjQyNVl5blBPRzBlNjZOYzh2UjAvNWZSbVRKU0hld3RrWmUzZHd6?=
 =?utf-8?B?anR6d21HNDZNWW5kdFRjdTNpU1hLdjBleG5CdFh0T3BmWnVaYUUwVTNwSVlY?=
 =?utf-8?B?dFpLT0ZFQmoxMzJveTA3OEREYTdOUnovQm5HZ1RPV0tEWUlXMDVLUUVmZzZH?=
 =?utf-8?B?WEc4Umw0cEYxSHpKV244NWhKL2NZSTdNK0NIZXlkaDk2OWplZnZVS2o1K0dC?=
 =?utf-8?B?dTBmWFdHR2V0WXhieGU5UldmOTdNRXpzK0Z6VDk0UzU3cm4zR0xFcS93MUpN?=
 =?utf-8?B?Wk5pdzExSE81emtTR0g3bWRXMFZCVVkyMHBpb2hZQkhSN21UN3RWS1cxbGk0?=
 =?utf-8?B?T1NRTlJWMldTYWF3Z0dYZ1dJNGxkTFQ1ekNJRlF4Zlg5eXlaQWRMcVBYZkpr?=
 =?utf-8?B?WktIR0dXMzFTUDdMcGQ0OFR5OEVnTkUwWDI4b0puSk5LQUlBSE1HeVFERjdm?=
 =?utf-8?B?bEIrcWpVQmIzOHFiZkVMV1FONzBacEJESi9OMVVXMUhBY3VLVmpTY0owbXgx?=
 =?utf-8?B?ZGJOQ1ZoOUtNdlhaTnVyOE45U09Xbk5nVW9uQmwxS1pWSkFhNlFkdkthUkpl?=
 =?utf-8?B?UzM4bERjb0VZSnVlZmxlM0hucXJUeHV4TUJReXNDZE5mQVg0SW5EOEprejBy?=
 =?utf-8?B?YXk3OTVsT1dvSGg4N3k1M2ZhcU9sYTBnbzdGVE95aTQ4Zmg2KzRqWVhrL045?=
 =?utf-8?B?anZHRXluR1prY2wvYkY5Vi9IWnRUdmQwVnVhblk3R1ArNlM4UDB0VWFCYXhl?=
 =?utf-8?B?aVJtbElHLzA3aS9kcnhHUmhtSldMSkNZajRXUGRHRmdHVWlmd2JPZURYQmZw?=
 =?utf-8?B?ZXEzQ3E3ejh3d3ZoUnh3MDNPWVJiUWozWmpDSCswcUR2OXdNNENhNVQ5OEJ6?=
 =?utf-8?B?OGQ3S244TUhtTGRHUWFMSll4RlVSU2hEckFzTXZ6VlRMTFJNeE5SM0E3SHVj?=
 =?utf-8?B?WE1JZEJCMTBmRlFwaVFIUFJtdjljRDdDZU54TlJBV0ErYXZxdjRndGh0T2dl?=
 =?utf-8?B?RlE3Vy9DZkpVVllwQzFhVzBCak1rejBSdWNLTFFUK2ZqZ2NXTVNZRFR0eFVh?=
 =?utf-8?B?dFF1bkNHcHFmdjc5VFFrYTlKVzdyZlRTREV3S2FMSENrR09wL1dodEh3aVJK?=
 =?utf-8?B?dG16VnlrR2VpKzZHeUVnamVXY3ozVVdDMGIweHpxQXlwL282dDNGRzhmRnhM?=
 =?utf-8?B?RndRQTVBZnBCQnovajZncjh0bU13OFk3YjZBUGNwQXlKM1JIcGpXTDB2Ry9B?=
 =?utf-8?B?TEJVaWRtTGQ5T3RiWVE1MWdXSkRqc2tzZEcraWFRSEZjb0JuUi9QcXdPQXhJ?=
 =?utf-8?B?ODBSVmlyWGVLK0FKbFdqWk1JK0xGcWp1czlVZzE5Vjg1b1EwYlI4aW1QTCtx?=
 =?utf-8?B?RzRpcit6WnE5akxxcWFlR0hGV3pTOWNqaXE0OXVsZk1wQWFrTzVQb3dYM1Av?=
 =?utf-8?B?RlpvQ0VkUVQxMmltNVBaZzRKNndpNGFPVHl0UjFqUFU5b2tGOWJ4RUpXOUpM?=
 =?utf-8?B?NjNMS0pvSWZUclhIOHJLenpoMkNqUHUwSStxZXVBWDduVTRxeE9LOHByd0pm?=
 =?utf-8?B?L0x3NDBJUi9DWVdpcUZCSngwWjV4VWVObmF1SnRLRDdsVVF0S2ZMWGJLdFBE?=
 =?utf-8?B?RWovMEs1aHYzenRReXFTL3BNa25ZOC9NbXlyd0lSN0srTFg5N0JISTExRUxV?=
 =?utf-8?B?Q010SE10NFplVzFlZ1ZaekN5V2dSdXJObDdGR3VIdUE5UzNaTWZBVGVsZ3lG?=
 =?utf-8?B?dkZsYXFnNHBFenQyV3R0cUtmVkpmVEJIcXBxdXZxckIvWG1KWHltbW1DODZv?=
 =?utf-8?B?RXFmaDFmYzZkRXVtRWk4R1ZDdHBpa0dHMU1QMmtBZzBFdjFYbHVnWjJHUUlY?=
 =?utf-8?B?MkdLZGVPRVdobFZQOFc2ZnlFMEFFRExqQWRQRkxVOENOSzlIRWhUUnMzN2RV?=
 =?utf-8?B?cEd3c2JKdlV2SkYycmgvby9OdnBmTi9TblBmVWthcEVLWFVnZDBFV2FnSzJu?=
 =?utf-8?B?QjAwRlFGVlFjakpVM0lRaEJaR1pWaFVxK2FFS0dYS2t6TFkxbS9wWmoxQm10?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <237969BC23B8634EB40C900704A151AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cfa019-7822-44f0-0292-08db68be2dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 07:50:22.4759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voRmWnPZQ6Pqx990nF3kgDpAk83uIbpoLiPWEZZEaqgJSYqjXZAg6bz8uA7arpJ4LGbYjvU9L5S5xo49RWqCV+XmCLC2Z7Lvz/zdlpzsM6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8431
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDYuMjAyMyAxMzo0MywgV2Fsa2VyIENoZW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAyMy82LzggMTg6MTUsIE1hcmsgQnJvd24g
d3JvdGU6DQo+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAxMDoxNTowM0FNICswODAwLCBXYWxr
ZXIgQ2hlbiB3cm90ZToNCj4+PiBPbiAyMDIzLzYvNyAxOTo0NCwgTWFyayBCcm93biB3cm90ZToN
Cj4+DQo+Pj4+PiAtICAgICAgICAgICAodGRtLT5yeC53bCA8PCBXTF9CSVQpIHwNCj4+Pj4+IC0g
ICAgICAgICAgICh0ZG0tPnJ4LnNzY2FsZSA8PCBTU0NBTEVfQklUKSB8DQo+Pj4+PiAtICAgICAg
ICAgICAodGRtLT5yeC5zbCA8PCBTTF9CSVQpIHwNCj4+Pj4+IC0gICAgICAgICAgICh0ZG0tPnJ4
LmxyaiA8PCBMUkpfQklUKTsNCj4+Pj4+ICsgZGF0YXJ4ID0gKHRkbS0+cnh3bCA8PCA4KSB8DQo+
Pj4+PiArICAgICAgICAgICAodGRtLT5yeHNzY2FsZSA8PCA0KSB8DQo+Pj4+PiArICAgICAgICAg
ICAodGRtLT5yeHNsIDw8IDIpIHwNCj4+Pj4+ICsgICAgICAgICAgIFRETV9QQ01SWENSX0xFRlRf
SjsNCj4+DQo+Pj4+IEknbSBub3Qgc3VyZSB0aGlzIGNoYW5nZSB0byB1c2UgbnVtYmVycyBoZXJl
IGlzIGEgd2luIC0gdGhlIF9CSVQNCj4+Pj4gZGVmaW5pdGlvbnMgbG9vayBmaW5lIChJIG1pZ2h0
J3ZlIGNhbGxlZCB0aGVtIF9TSElGVCBidXQgd2hhdGV2ZXIpLg0KPj4NCj4+PiBUaGlzIGlzIENs
YXVkaXUncyBhZHZpY2UuIFVzaW5nIHRoZSBtYWNybyBCSVQoKSB0byByZXBsYWNlIHRoZXNlIGRl
ZmluaXRpb24gb2YgKl9CSVQsDQo+Pj4gaXQgd2lsbCByZXN1bHQgaW4gYmlnIGNoYW5nZXMgaW4g
dGhlIGNvZGUuDQo+Pg0KPj4gSSdtIHF1ZXN0aW9uaW5nIGRvaW5nIGEgY2hhbmdlIGF0IGFsbC4N
Cj4+DQo+Pj4gUGxlYXNlIHJlZmVyIHRvIHByZXZpb3VzIGNvbW1lbnRzOg0KPj4+ICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMTQzZTJmYTItZTg1ZC04MDM2LTRmNzQtY2EyNTBjMDI2YzFi
QG1pY3JvY2hpcC5jb20vDQo+Pg0KPj4gSSBjYW4ndCBmaW5kIHRoZSBjb21tZW50cyB5b3UncmUg
cmVmZXJyaW5nIHRvIGluIHRoZXJlLg0KPiANCj4gWW91IHNob3VsZCBzZWUgdGhlIGZvbGxvd2lu
ZyBjb21tZW50cyBpbiB0aGUgbGluayBhYm92ZToNCj4gDQo+PiArICAgICAgICNkZWZpbmUgQ0xL
UE9MX0JJVCAgICAgICAgICAgICAgNQ0KPj4gKyAgICAgICAjZGVmaW5lIFRSSVRYRU5fQklUICAg
ICAgICAgICAgIDQNCj4+ICsgICAgICAgI2RlZmluZSBFTE1fQklUICAgICAgICAgICAgICAgICAz
DQo+PiArICAgICAgICNkZWZpbmUgU1lOQ01fQklUICAgICAgICAgICAgICAgMg0KPj4gKyAgICAg
ICAjZGVmaW5lIE1TX0JJVCAgICAgICAgICAgICAgICAgIDENCj4gDQo+IEluc3RlYWQgb2YgdGhl
c2UgKl9CSVQgZGVmaW5lcyBhcyBwbGFpbiBudW1iZXJzIHlvdSBjYW4gZGVmaW5lZCB0aGVtIHVz
aW5nDQo+IEJJVCgpIG1hY3JvIGFuZCB1c2UgbWFjcm9zIGluIHBsYWNlIGluc3RlYWQgb2YNCj4g
DQoNCkFzIG1lbnRpb25lZCBpbiBbMV0gSSBzZW50IHRoYXQgYnkgYWNjaWRlbnQuIFBsZWFzZSBp
Z25vcmUgaXQgYW5kIHNvcnJ5IGZvcg0KY29uZnVzaW9uLg0KDQpbMV0NCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC83YTFhM2FjMy0xMGVjLTk5MzUtYmNhMS0wMjNjZWM2YzAwMjRAbWljcm9j
aGlwLmNvbS8NCg==
