Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B8638B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKYNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKYNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:48:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214C1DDF0;
        Fri, 25 Nov 2022 05:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669384132; x=1700920132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8LwxqAFegKxylOrr8maAOjC9ERzDkmvLSk3NqD8GFwM=;
  b=dbnHOKWfbBMUpJ8awOn92XgwFPRyDP581wvb1+pKpD7Ut0UH7wQ9W9KJ
   YhEa1TSNnscc/RAsOfOKBV1kLBanX2NMtMUUldQCHU5Bw4RT4hJgL09Vj
   nbLfaOzyHNVqr1ouUy616ooInh9C4nGGTXV119KEwEirtlUQT5lxC3UK6
   LwEBfZ2Cd3L6rtv+mpR47gYvWX+MEAPoBiNjX6okFH/s/yhIu2eBeVhRc
   fuXVSMNkDWM0bzJIIPNum6f/o5XXeMfwqHjZbuJWuB54odBjYK0vz7s+s
   7IqrUW5m+6dUURz8ZYypEZKDtFJWyBaqFFrAp7Bf9FTWJxxv+t+7oFS/K
   A==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="125110639"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:48:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:48:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 06:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUTZwFVJhN7xcBWwe86zv3CJsoOUHfAJH7W4K5qswJFPApVLZu7bsqt4j6DxjI8eWfxbUiCMShsN0wWaMSHKCOpHDkLMPtJlQ4ODrn5NjYaXJsm1CNr1TyRzNuaFe4EolT05DR3FKQC+2CJLb739sayKDJCLAKC18hUdZHBtW/69e6L1KMFH0PDqpjgz/c0VLVAUw15OFyvN1e3lvcPzb3WtVSrFh5xT79ralVgG0+uNsCtuNBhJBnA3JK/oNt79oJ90NjLDVVHALtgcHL4W6V1fcJpk1+e+iMpVz/QaoGf4ONkug5MvoySgsMRzVYZIqHCcjpHbEROISx9c2afa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LwxqAFegKxylOrr8maAOjC9ERzDkmvLSk3NqD8GFwM=;
 b=aOxgMI9M550nhxI8xDTgO2y8d5akvdgRajnnZcyF020P50CTPitYsbS0QTdz9Wk6JzIF/SIHaGN31mhAN3m7QeXXDjQ0CAculzybr3vmZQkTUVJfSty/nag5APqE7+oydqxg0RMRzsyjuuWH3coJFiXl4tGRDGbtLfe9J8HzJ3P9hL53zohCnmfhppT6WfCvUErFQZYFZjsUEN8uQj2UVrD2L9OF9FbOkaauqlWP0H3mJDVN+q3cb9tmQmn3Kf9DT1s4BWBClVW5kxSk1dhlJYRfaMP1kiU93/7nZ06a45+rDweakIIUAmem6p9pD+otROkftT+XAHnsIoaoORnUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LwxqAFegKxylOrr8maAOjC9ERzDkmvLSk3NqD8GFwM=;
 b=KUAE1OdXtAstpfNJqEDaVJTVsjbFR5l8DNcSdjjkEW2HXAXfd/BqzCOUPopS/iZZjelgIyGW51TN+HUWxStwjswKv/EGQkdz/Nt1PzfqsyIdoXmSbXFYRVpVmlpteJ+SNBuZ5jQOciCEEf1Yn21l2y5xbmyqUxEmS8I/4xUMPAw=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 13:48:48 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 13:48:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <conor@kernel.org>, <tanghui20@huawei.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH] clk: microchip: check for null return of devm_kzalloc()
Thread-Topic: [PATCH] clk: microchip: check for null return of devm_kzalloc()
Thread-Index: AQHZANSlTkpcm0pSKEWmV+iEeeD/bg==
Date:   Fri, 25 Nov 2022 13:48:48 +0000
Message-ID: <666f8502-86dd-b000-92d2-ec3fd90e332d@microchip.com>
References: <20221119054858.178629-1-tanghui20@huawei.com>
 <Y3izOuF56/NywpOR@spud>
In-Reply-To: <Y3izOuF56/NywpOR@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: 562a5a1a-1bd3-4641-ac8f-08daceebc781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrUP7Kjq39BMW39ogtI+Vwto6k9icUJ1jGcvFk2zsa5inlxtXG3EyUiZBMVFW8VITkYKugy5/8BnthMnqOpP/b2nFCy3P/vfSgFc4apvCOSm2yWasWEFlXAQqdaed/G9/M1vcZ7SjVzvVNl/Y8dvaGy1lXRUtaOKlkQYdx0wLbRPuTQyhsrp9tP5jp8HT/NemwgqRQBBMYSpzm5XpNfd7WCwadhE/BlsBWfaXzry9W1VC6GAP+x8F6d90VOZmk1UZkQGNGY/ykxl1yAYnAj8vGIdhmFWNRfatpNNMq8ZEUmzUZv9P5qQg0PTvPPHvWcClUcTmfVF3o1GH6g53lR6gKgzP3chtVqVXsFlEVyfIC2ylMwxLfP/NIVt5eTqZvzROenSLeXOKh6aqakqgmk5O9jvP4h0M4URJOga6OUiWGG75X+2yHr4tIL9eGi+g8EoGgSaeR9/OHlNnj8pO8q940qw1IH9cp1qyV+wCTNW8V2JQexoe+A9uDucCkzRj4fShlyXscqcGOxZHFixtHj6arnEvTct4xFq+yQR4mL98HhKGx4XqYnYcTVmx58Zppudrg2ZZE6TbSDEyC5wd+1D4apMqpaqee1dIOhebeCNnB+wesfsDi13O0BLrRMyR8yIPN18RSS9t06T/i0O10hHKh1FLXAsEGAf5mXBotEQr7CeD21uJiZ7tgS0ToEqigw/BCmtf36Jba013NOTBMuMp5lZv0HvVBitdbGAAEgsA5AcVumN6/ys5F3HzhOgt3FSzzVTHKBOy3t2nsB1a2r+0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(31696002)(86362001)(76116006)(66556008)(64756008)(66476007)(66446008)(66946007)(8676002)(4326008)(91956017)(110136005)(41300700001)(38100700002)(54906003)(316002)(6506007)(8936002)(6486002)(5660300002)(2906002)(83380400001)(71200400001)(38070700005)(186003)(107886003)(478600001)(2616005)(53546011)(122000001)(6512007)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdlWTNuVHRFbEdnaWVLZGgyRkgybjg2aFNDSFM3K2pXYS9aRlREYjNFbjR2?=
 =?utf-8?B?TjYvVjE0eHlQOU1lTS9nNWYxNEcveE5Qdzd1ejVmdys0a0FiVzVPdHUxYW11?=
 =?utf-8?B?a1kvaHBLRy9pK3N4WFUzcDRZY2pybmtSc0N6WVVPMmFHYVNaUG9xdFpHZE5x?=
 =?utf-8?B?SE5lYUpINlIydVFHMjRLaXBZTW1Nc3BmVFByVGlZMk5JVUliOEFzeStoZERn?=
 =?utf-8?B?ZW9nMWRhY3NaS254T01NWEVQaWsrMnFpVGZzZG5MU2poQVVUSTNtRXZNUEZI?=
 =?utf-8?B?RFhLSkR3UUs0NHlVaDdsUVl6d003cXU5ZEZpUmN3aUJFbmdHdjNLbHdDSE4y?=
 =?utf-8?B?VzEyZzZDM09yMGE0ZTNNQzNqaHVQd0hIeVRvcGMvbWRmSVhKWUZFN1FDQ1NK?=
 =?utf-8?B?SGFiWGFiaU53dk52WmJubmU1cmVHTmlyLzlZY01ZS3dwVTlMRVJGRGt3S25C?=
 =?utf-8?B?b2lvNVEvWjFyMnlGTWIra0xtemNSMEdsYTVrbUxRTXZlWXcrOHhnVUUyKzRH?=
 =?utf-8?B?cmc3K0RBWXNNUDIxY1gyN25QaFdOZXAyYkNjb1hiQ0k0ZStOTURoQVhUdUl0?=
 =?utf-8?B?dW82OG1NRTFhcWtia1QvV3N2Y2dJbzRNay9VWC9Mb2NDOGxVbWozcEpOTkx3?=
 =?utf-8?B?TGlDNUpEbU5zczNXYU9rQy9sOCtoUmlaT2tjdTFVL0kzRzJyUFNlNmR5TW1v?=
 =?utf-8?B?VU9xdXVkNktwckFDK0l1d0tuc3puekV0V1dhdkdwM3hrb0NXak9zaFVzVUJJ?=
 =?utf-8?B?RzJudkVjdmhxZk81YVVwUWdxMnFVV2J5V1o4UDFHMEUyUzFocmN6VnFSTDMy?=
 =?utf-8?B?RFZkdXlveDZBdzRHV2JVRzhGRUdnSzUvOTMxRG1USXV1L1l0azBGOGlTRVZa?=
 =?utf-8?B?SFVaN3NrbW91RkcrUWhrbzJ5Mi83TFYwSkpPdWhmWU84NHhTbDFubmtFUVFT?=
 =?utf-8?B?WHhWQ0VJL1hFclJTNjJEa3FWUWR2YVNna08xZUg3MlBEWFZxSWI1amg3TGVM?=
 =?utf-8?B?ZDFuNGxza3pHM0hzVXlIUitUNjBIV2tVMnAwUkxWK3pTMFkrTWVKc2xUaWFP?=
 =?utf-8?B?MFY2WVRHanJMUGVCQ1dmVlEvSXJWWlczbFZvRW12ZWtSMzRuQWFYN0NlWGN1?=
 =?utf-8?B?ZmVHTU52ckNCQWFCN1lmMkNrTkRpU0xvNDNVaWZjZVlxaFUwR2YyS24xTUR6?=
 =?utf-8?B?QmhPUVJ6Vmp6TUlVTk1SVVJpbk90K28wc0JuSllWbDF2U3RaNTl5dVJqUFRx?=
 =?utf-8?B?V3dDbDJzSG0xbnk1cU1GK3ZUVHBaOW9xbWpaK2FITDhlUkdKS0ZTQlJ2dEt1?=
 =?utf-8?B?ODZzSlJxcWtJcFZyVCtWeEFMcjFQVk1lVEZPUUl1aSsrdUxBd3BuckhyWmdT?=
 =?utf-8?B?U0huSEpPYnFjV1lpYVhEdzlPR05xVzR5SXdicGczbmxqSzNNd04xRGpkV1pj?=
 =?utf-8?B?M0p4dlZheEtmSjdtN01HWnd5ZXJlZ0RTZFNJbnBVVHRtZkkyeTZneEErRE5W?=
 =?utf-8?B?U2E0UHB6NXBNTEp2VzRHS0FQRHc1RE8rTjZDYU9lVHB3U0lmR0UyMlYxQkJH?=
 =?utf-8?B?aE9nTEZOUlVxUWwxOFVPNmFqN2U0QkhHQWZwcnNxVWtKMWFCQXptN3lwNVFM?=
 =?utf-8?B?ZWcxUGQwNnVqd3IxT2k1bVpDclNLWjBWWDJXMzJLVEdrVTZ0M09hbjk4dWxl?=
 =?utf-8?B?MUlMNFlVRzMxQlRoaFRvUlREajhNcXRWZTlQMFk1RmIwQkh6VGVNaFN5TkdN?=
 =?utf-8?B?SGJCZ1JhcFBQbVdhdko4anVwclJaYUlleERFS2JraU1yNUl1VW04djR4R3F4?=
 =?utf-8?B?a0s5VTcrWitvb2tXSVYrUW1LNkpIK0Voc0ZoMnMvcStRV1R4SVBPcVBmRm42?=
 =?utf-8?B?TXBabk5aQWxEMzRqRk5VYWs1MUR0SktEeUpZN2NVc2E4SXlJWUlJNTFjeUd3?=
 =?utf-8?B?TVhZY1NBL3B6dXNYSlMrS042Q3RXM1VZMXBQSVlRTlNrRVg2MWZmcGJOYVoy?=
 =?utf-8?B?dTl6ZnN2T1Zlb1BzN0plaFhrUXBMYWhwbXhvTWsxdnV5cVJFVlRoN1pDUmVF?=
 =?utf-8?B?aHY0RGxWK0hldmVVaGhhZnFIQ0tYRTZ3ZGdydXA3WjdzRmFGQjBJWlRTRWVq?=
 =?utf-8?B?SU5xV25vUndqLzl3WGFJSE5hYlRVaHlIRE5LWWNvNndRa3d0OTNGNTN1L2Zl?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D528B0B3DB5A8F4198E9C6961D723623@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a5a1a-1bd3-4641-ac8f-08daceebc781
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 13:48:48.5834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNbu1MESrYwsd666BC6pIHenKAGxR9vZDc/IUntJTqcCZjk5p12xl3oXGnZFeZF/OCCWj2G15LAT8uP06YzHGqr03UXpboGOGP1JVkBI868=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMTEuMjAyMiAxMjo0MywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFNhdCwgTm92IDE5LCAyMDIyIGF0IDAxOjQ4
OjU4UE0gKzA4MDAsIEh1aSBUYW5nIHdyb3RlOg0KPj4gQmVjYXVzZSBvZiB0aGUgcG9zc2lsYmxl
IGZhaWx1cmUgb2YgZGV2bV9remFsbG9jKCksIG5hbWUgbWlnaHQgYmUgTlVMTCBhbmQNCj4+IHdp
bGwgY2F1c2UgbnVsbCBwb2ludGVyIGRlcmVmcmVuY2UgbGF0ZXIuDQo+IA0KPiBJbiB0aGVvcnks
IHllYWg/DQo+IA0KPiAobm90ZSB0byBzZWxmLCBzL3JlZnJlbmNlL3JlZmVyZW5jZS8sIHMvcG9z
c2lsYmxlL3Bvc3NpYmxlKQ0KDQpBcHBsaWVkIHRvIGNsay1taWNyb2NoaXAtZml4ZXMgd2l0aCB0
aGVzZSBhZGp1c3RtZW50cywgdGhhbmtzIQ0KDQo+IA0KPj4gVGhlcmVmb3JlLCBpdCBtaWdodCBi
ZSBiZXR0ZXIgdG8gY2hlY2sgaXQgYW5kIGRpcmVjdGx5IHJldHVybiAtRU5PTUVNLg0KPiANCj4g
SSBhZ3JlZSB3aXRoIHlvdXIgdXNlIG9mIG1pZ2h0IGhlcmUuIElmIHRoZSBhbGxvY2F0aW9ucyBk
byBmYWlsLCB3ZQ0KPiBsaWtlbHkgYXJlbid0IGdldHRpbmcgdGhlIHN5c3RlbSBvZmYgdGhlIGdy
b3VuZCBhbnl3YXkgLSBidXQgdGhlcmUgaXMNCj4gbm8gaGFybSBpbiBjaGVja2luZy4NCj4gDQo+
IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
PiANCj4gQENsYXVkaXUsIHN1cHBvc2VkbHkgSSBjYW4gcHVzaCB0byB0aGUgYXQ5MSByZXBvIG5v
dyBzbyBJIHdpbGwgdHJ5IHRvIGRvDQo+IHRoYXQuDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0K
PiANCj4+DQo+PiBGaXhlczogZDM5ZmIxNzI3NjBlICgiY2xrOiBtaWNyb2NoaXA6IGFkZCBQb2xh
ckZpcmUgU29DIGZhYnJpYyBjbG9jayBzdXBwb3J0IikNCj4+IFNpZ25lZC1vZmYtYnk6IEh1aSBU
YW5nIDx0YW5naHVpMjBAaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvY2xrL21pY3Jv
Y2hpcC9jbGstbXBmcy1jY2MuYyB8IDYgKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xr
LW1wZnMtY2NjLmMgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMtY2NjLmMNCj4+IGlu
ZGV4IDdiZTAyOGRjZWQ2My4uMzJhYWU4ODBhMTRmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9j
bGsvbWljcm9jaGlwL2Nsay1tcGZzLWNjYy5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9taWNyb2No
aXAvY2xrLW1wZnMtY2NjLmMNCj4+IEBAIC0xNjYsNiArMTY2LDkgQEAgc3RhdGljIGludCBtcGZz
X2NjY19yZWdpc3Rlcl9vdXRwdXRzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNfY2Nj
X291dF9od18NCj4+ICAgICAgICAgICAgICAgc3RydWN0IG1wZnNfY2NjX291dF9od19jbG9jayAq
b3V0X2h3ID0gJm91dF9od3NbaV07DQo+PiAgICAgICAgICAgICAgIGNoYXIgKm5hbWUgPSBkZXZt
X2t6YWxsb2MoZGV2LCAyMywgR0ZQX0tFUk5FTCk7DQo+Pg0KPj4gKyAgICAgICAgICAgICBpZiAo
IW5hbWUpDQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+
PiAgICAgICAgICAgICAgIHNucHJpbnRmKG5hbWUsIDIzLCAiJXNfb3V0JXUiLCBwYXJlbnQtPm5h
bWUsIGkpOw0KPj4gICAgICAgICAgICAgICBvdXRfaHctPmRpdmlkZXIuaHcuaW5pdCA9IENMS19I
V19JTklUX0hXKG5hbWUsICZwYXJlbnQtPmh3LCAmY2xrX2RpdmlkZXJfb3BzLCAwKTsNCj4+ICAg
ICAgICAgICAgICAgb3V0X2h3LT5kaXZpZGVyLnJlZyA9IGRhdGEtPnBsbF9iYXNlW2kgLyBNUEZT
X0NDQ19PVVRQVVRTX1BFUl9QTExdICsNCj4+IEBAIC0yMDAsNiArMjAzLDkgQEAgc3RhdGljIGlu
dCBtcGZzX2NjY19yZWdpc3Rlcl9wbGxzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1wZnNf
Y2NjX3BsbF9od19jbG8NCj4+ICAgICAgICAgICAgICAgc3RydWN0IG1wZnNfY2NjX3BsbF9od19j
bG9jayAqcGxsX2h3ID0gJnBsbF9od3NbaV07DQo+PiAgICAgICAgICAgICAgIGNoYXIgKm5hbWUg
PSBkZXZtX2t6YWxsb2MoZGV2LCAxOCwgR0ZQX0tFUk5FTCk7DQo+Pg0KPj4gKyAgICAgICAgICAg
ICBpZiAoIW5hbWUpDQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
PiArDQo+PiAgICAgICAgICAgICAgIHBsbF9ody0+YmFzZSA9IGRhdGEtPnBsbF9iYXNlW2ldOw0K
Pj4gICAgICAgICAgICAgICBzbnByaW50ZihuYW1lLCAxOCwgImNjYyVzX3BsbCV1Iiwgc3RyY2hy
bnVsKGRldi0+b2Zfbm9kZS0+ZnVsbF9uYW1lLCAnQCcpLCBpKTsNCj4+ICAgICAgICAgICAgICAg
cGxsX2h3LT5uYW1lID0gKGNvbnN0IGNoYXIgKiluYW1lOw0KPj4gLS0NCj4+IDIuMTcuMQ0KPj4N
Cg0K
