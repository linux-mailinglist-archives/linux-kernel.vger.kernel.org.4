Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B490C6CC5EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjC1PUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjC1PUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:20:08 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E2FF00
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RilT++KBKUZ8RpF3iMEjwfDHnIrg3tb4E3P6th6eQNz4hJcj9ff9cArt3GqB4nvr8QQJlTBVsgErGQOLtSN0LBmI74RYc7dqaHTylnEvhR2LP2YK0SzmqxTVapnOkzy2tylhinUvvE5CHj6q/xmxNImw9a41X/8LDZIsPZX0JBZNjIEGzpj+fQw7BHPl0fzZ2CqEjvj3BuMrk/iPSpCGv0xhks6sNuMoHRK1PDnpdc2/o9KFd5Ibv/R+2obIMOwDIusfsM5EEN+kSyVYihy+HJ5TcnSoxiqr6rykBiG4ovbMMFRnlQggRuXiVJctJxKNYLxKmHqoxniRaveniG7ZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztDaN6KtN69ED4CGbXyMyAlRUM1cWDySZNfnOH9Ytx0=;
 b=L4ViQeOgqXQkeDxDO8ByOvF8xXv6oaaYsm+QPsjw/XBzFbx4y51pyK7xE+pYYGP8jWdtbvWvDt7A7SpF3JwQYxx5Hoyeeqty8VKVsd1Qw049sRbhJFbMCT4QpRTH2tV5Ws7HPKxEtj+tc8ygw0jRXuHzpplA4H0DF4ztln5f91cWTj+xHT5+y/8jCFHmEwgf5gBnZ8oBY8P0YyR3sqYpcU6ExXAQAv6MX24gAHNZ5aBTML201yiQuxLx+ITim/CuitxJLa1+U3rB3ingbXgbN673isKvPPO/hG9VXaG4RjHc+VDS5LuBVuL6to/RIP/pCfuC3MMCrN4az92xbr4CDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztDaN6KtN69ED4CGbXyMyAlRUM1cWDySZNfnOH9Ytx0=;
 b=R7sXSjWVKXWfJ/0pFD6NlpJmqye9fZUbiQAzMcXfN2vOMZ7e+TE07FEw+I2n8V9JGYWouvfkSNZpCBNdvqsPtmM/yXEBoNywMjP8Xgjwvn8jfI23iId6HRSS9+MjbSnrveeLpZm9N+1odKu8rOMP3wsy+H9uqxWScx6dT/LwUFI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB2056.namprd21.prod.outlook.com (2603:10b6:a03:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.6; Tue, 28 Mar
 2023 15:17:48 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6277.006; Tue, 28 Mar 2023
 15:17:47 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC:     Christoph Hellwig <hch@infradead.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Topic: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZX0LG5qMB8+ZzCUqrEQruwKd8m68PbDKAgAC/CxCAAA6ygIAABf5wgAAPoICAAAKCUA==
Date:   Tue, 28 Mar 2023 15:17:47 +0000
Message-ID: <BYAPR21MB1688B76012618BEA6B0DE6A5D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
        <ZCJEAx/G0x6zokPF@infradead.org>
        <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
        <20230328155017.5636393b@meshulam.tesarici.cz>
        <BYAPR21MB1688983A72B114BBC3AA1DE2D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230328170739.10e33345@meshulam.tesarici.cz>
In-Reply-To: <20230328170739.10e33345@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c38fca52-5416-4dd2-b38b-95187e69f860;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-28T15:16:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB2056:EE_
x-ms-office365-filtering-correlation-id: 5b9d4075-ffd3-40e8-ca56-08db2f9f969f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3gO0EN+0lgtIydNPb//SNZSBR+n4+saVtfYy2lBFvREoCsZid8KM9fGqtZ3UXgwF5y310X4omMTFxcqYCM6Ku7/bKoj7eMhtnwEzXlTvuB4XCazzV4Oa5NM86UtJtoIkBSn2q9tvdmRjBATww2JKID/tGxInGs1+GPRXLtslN4K0nFjS3lWOPYb+LKULb4XKT+yIyhIedURdX62W7fFtkR8KI+gZ9LTMDR9KVrKmf+UGvVXETSHG+smhmv17hasoAOywIE7lZ15gP2R94YLUnaI5fOjSUv1wz1XbwZQVe5iFro9JPk3lG81U/JlPnEAiZieH6uB2Iowlvdwaq7iK5H9WNoRGqqPWRbF1+Rk/XXEydacrccss7jFe+zGeMY5RSe5lY4vbCPpe3J66WvtUKaO1NICJsZDHA4003Loq6pKSa1CjsnL3R7UeNoekX8FYPwSJd1YjoEoKhm56K9MRjld42YlAi/JySgRYH6kaYY+jf3U9tzW72yL5cXiWZoSUWX1KAQjjYAPkIZosDL4ygQhecnNQR9BlC8imEWa77zwM0aMWlkTDWt9mw1BmHwb4GOXi8SdcguIdt0qDJAJavucgJYVZhNLwlK9rjEi0CSoh0PpkYpvsDLF7MZpCiLbsJhqSq0ZYYkVOeapn+WBTlPmx+C680Mt5PoDjiVDcKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(38070700005)(33656002)(38100700002)(122000001)(55016003)(86362001)(76116006)(66476007)(66446008)(64756008)(8676002)(66556008)(6916009)(66946007)(4326008)(186003)(5660300002)(8936002)(83380400001)(41300700001)(52536014)(478600001)(7696005)(71200400001)(9686003)(6506007)(54906003)(10290500003)(26005)(316002)(8990500004)(82960400001)(82950400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkhhYTBGdWJldXRBV0FHUEI0ZklLWEhyVVZOUlZ5V3lBRElxTjJWdHVBUXpw?=
 =?utf-8?B?dlQ2VFJPZjIybit4d0dVRnhvZEZMcm82aFVKdE5jVzYrb0haajh5ZG5HMU9D?=
 =?utf-8?B?bXlWMGpEWHBVb1JzRjFHV2NHVU56OVRHUG1FTTdRRDRTZTdtNHJIU3VvaUJM?=
 =?utf-8?B?U1Npa0NFSlh2MXdEZTFsTmZVTWhKbG9wT0ZqUkNEZFJxSzdPWGw4dzExMHB3?=
 =?utf-8?B?NENmbnFJODkxOEZCQ3BwZVk0ZXdHT2JFVkJmMDVBVXh2QU1yL1Z1RWxZeXEx?=
 =?utf-8?B?ZmcrRFdKelV0NzdITzNwMlBYMzNuSWM4L0Y1cmQ2SE0zRXZoSndiT3pHYVBO?=
 =?utf-8?B?S2ZBek40YUwrWjg1T3ZTa2M3NDRhSU9FenUrWTlDaFlJNklualF6VW9rT2kr?=
 =?utf-8?B?MG13YVp4RWtGQ3BFN2FGTm8vaEZ2RXFrMHNyREt2N2oxdCttWGNqRndMRTQy?=
 =?utf-8?B?WUl5OTQ5VnJKRkxLTG1kT0ZFN2tVaFh4K2NlRHIrcmV0TisvYUMwTDVsRzNU?=
 =?utf-8?B?RTM3NzhEK0tISnFlaU4yTVpSbHJDallEMXNNZ3lwZGZudTB1ZUJPNVZnQm42?=
 =?utf-8?B?RWJyQmRINVUzZlR6ZEZmdndZak9sU2ZBTGdQRVk2Y0loS0J4UkJ3dnIwNVF1?=
 =?utf-8?B?bkNFc0doRXVyTUV4bHJ2ZkJxbVp4ckVCNjEraDU0cHN3RElBRDl4Smp0V2VO?=
 =?utf-8?B?aGY2RXRncTg4SGZaSnV5MVQ1N3F3NFZDZWVxTklmeVNIYkQxakhJcnkwSUhn?=
 =?utf-8?B?TFU1S0VONTV5MFUwUU9YVHFnZTNjMTVDZnlnWnFtQXdOVXd1ZFNWSTJmSjJS?=
 =?utf-8?B?cmVJZ2RFSFA0QWFDSmg4VXd4djQ2NVJlVElreWdhRTFiRkN4amlhWDZzSkEz?=
 =?utf-8?B?ZUpzellkSTd2a3o0Qy9xd05TZUxkVHhJaE4waXhaaTYyZmhNVnUyMzArSkp5?=
 =?utf-8?B?WFpDUDNZZEYzOFRTYTV1cmFGb2J2WVFnQ290cGZvZ0dsZ2lTb1NtVmt5aWNI?=
 =?utf-8?B?Z01jVlFiSzFVSTJHaHU5UW8rYklnQ242aEUxbmVSQlVoK1Q4MTZWMEFkc1ln?=
 =?utf-8?B?ZHN0ZGFFZHFhYTQrZWNHQzh5WGpQaHVWbFF3TXJ4aGcrVU5MSEpnbktWT2NC?=
 =?utf-8?B?R0xkYXcyLzd1WGVYelV3aklkMzlMRTE4MWhnZXo5NzdrSFpyTmNNOG8zMUg2?=
 =?utf-8?B?Ulg2bzZSZ05YeGR3NXFaWkhSSWNyR2lVcjVWeVpIYk0vUE5SVGdBT0dkU2Q0?=
 =?utf-8?B?QzJuUXlpelNONlVBaW9oN0o0bVRkSHFnT25DdExuZEdNcDVVaHI3dVlTaXRJ?=
 =?utf-8?B?K2tKdDR3c3BUWVMxYTlTTWh5cDJscENuUzFvWXA3K1FMVEtmdlB6NEtOL1Ux?=
 =?utf-8?B?eGFHc1pUVlI4Q0RWV0NCOXkxbHZhM2ZHdjJMd2E1Z1dtdzhpaDl3cEhtRlFV?=
 =?utf-8?B?M09jKzlzVmtwaUdjeUhwR0taMGUzQ3gyVVhYL2lVdkEraFBMOVJrQm4wUk9D?=
 =?utf-8?B?WDdpRkMxa0tsNU9kaGV1R1pCYmREV2dXL0U3QkJaelFnS0RKRHBjWFp0ODZu?=
 =?utf-8?B?MWdVWnQvenZSY3UxVHo5TENLTnhmczA0WnBSMlVFSWlPRVV0Yzl4Y0ZWSFNM?=
 =?utf-8?B?YkZqMTZ1cDRqNGZrcVNRMHhPQ0hVR3lLM0VLamdjbGI1aEcyU1VsTDA3aDRO?=
 =?utf-8?B?NFpLSjJMSkNEd2VBZCt0MC80NVFSaml4NUd2L0pHcm40ODE0ZnFTcGxXT3Ri?=
 =?utf-8?B?Ry9FMlJTV0xFRFk4NjY0cEhraXBudFhSY01ZSS9pTVZOYTZ5Skc1SURpUGdO?=
 =?utf-8?B?SWJ5ZGJESGZpc0NoaUFRYXI1VURRR0ovSU9FYzdHSktDNnZUMDA2L2MwMngy?=
 =?utf-8?B?M2I0dlFDUFVOaitmSFBFZ01OVVVuTUU3SU5nNzg3OS9yM1J6N0RyVkxrMlU1?=
 =?utf-8?B?OGswS3pHNlBKTCtQTjZ6YVFnLytqZUpWN2QxbGE1K2ErYmpmWlJxTVd5cGlL?=
 =?utf-8?B?UVB0UDFYTnAwSTBGTGNmQ0I5UVFISFVWTEFTMkxaVU53L0pjelVkZW9CaExL?=
 =?utf-8?B?dDlvbE1laTFsOERCbnlzeWZIQW5jWG5IYXhOOFRpVGV1V1U5cU5BcStINFlq?=
 =?utf-8?B?Y0FWRVlBWTU3RnlUNlhPWWtWOGRBaHNtTEd3OTNGY01mVWFyU3hlbGY3NEtB?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9d4075-ffd3-40e8-ca56-08db2f9f969f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 15:17:47.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCo8PjnMD1IKRuHtTfTWOLY4B+pA5Zm71ffScw4ah1MS3gx3F+UQ+z3E5rsHDorpPkHIsfspno9oBJzAuLhHW0tG4Ze2skhpXsxJPU4+cBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2056
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDI4LCAyMDIzIDg6MDggQU0NCj4gDQo+IE9uIFR1ZSwgMjggTWFyIDIwMjMgMTQ6Mjk6MDMg
KzAwMDANCj4gIk1pY2hhZWwgS2VsbGV5IChMSU5VWCkiIDxtaWtlbGxleUBtaWNyb3NvZnQuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+
IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI4LCAyMDIzIDY6NTAgQU0NCj4gPiA+DQo+ID4gPiBPbiBU
dWUsIDI4IE1hciAyMDIzIDEzOjEyOjEzICswMDAwDQo+ID4gPiAiTWljaGFlbCBLZWxsZXkgKExJ
TlVYKSIgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJv
bTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiBTZW50OiBNb25kYXksIE1h
cmNoIDI3LCAyMDIzDQo+IDY6MzQNCj4gPiA+IFBNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBT
YXQsIE1hciAyNSwgMjAyMyBhdCAxMDo1MzoxMEFNIC0wNzAwLCBNaWNoYWVsIEtlbGxleSB3cm90
ZToNCj4gPiA+ID4gPiA+IEBAIC02NTksNiArNjYzLDE0IEBAIHN0YXRpYyBpbnQgc3dpb3RsYl9k
b19maW5kX3Nsb3RzKHN0cnVjdCBkZXZpY2UgKmRldiwgIGludA0KPiA+ID4gPiA+IGFyZWFfaW5k
ZXgsDQo+ID4gPiA+ID4gPiAgIGFyZWEtPmluZGV4ID0gd3JhcF9hcmVhX2luZGV4KG1lbSwgaW5k
ZXggKyBuc2xvdHMpOw0KPiA+ID4gPiA+ID4gICBhcmVhLT51c2VkICs9IG5zbG90czsNCj4gPiA+
ID4gPiA+ICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYXJlYS0+bG9jaywgZmxhZ3MpOw0KPiA+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyBuZXdfdXNlZCA9IGF0b21pY19sb25nX2FkZF9yZXR1
cm4obnNsb3RzLCAmdG90YWxfdXNlZCk7DQo+ID4gPiA+ID4gPiArIG9sZF9oaXdhdGVyID0gYXRv
bWljX2xvbmdfcmVhZCgmdXNlZF9oaXdhdGVyKTsNCj4gPiA+ID4gPiA+ICsgZG8gew0KPiA+ID4g
PiA+ID4gKyAgICAgICAgIGlmIChuZXdfdXNlZCA8PSBvbGRfaGl3YXRlcikNCj4gPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gPiA+ID4gKyB9IHdoaWxlICghYXRvbWlj
X2xvbmdfdHJ5X2NtcHhjaGcoJnVzZWRfaGl3YXRlciwgJm9sZF9oaXdhdGVyLCBuZXdfdXNlZCkp
Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gICByZXR1cm4gc2xvdF9pbmRleDsNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEhtbSwgc28gd2UncmUgcmlnaHQgaW4gdGhlIHN3aW90bGIgaG90IHBh
dGggaGVyZSBhbmQgYWRkIHR3byBuZXcgZ2xvYmFsDQo+ID4gPiA+ID4gYXRvbWljcz8NCj4gPlsu
Li5dDQo+ID4gPiBGb3IgbXkgcHVycG9zZXMsIGl0IGRvZXMgbm90IGhhdmUgdG8gYmUgMTAwJSBh
Y2N1cmF0ZS4gSSBkb24ndCByZWFsbHkNCj4gPiA+IG1pbmQgaWYgaXQgaXMgb2ZmIGJ5IGEgZmV3
IHNsb3RzIGJlY2F1c2Ugb2YgYSByYWNlIHdpbmRvdywgc28gd2UgY291bGQNCj4gPiA+IChmb3Ig
aW5zdGFuY2UpOg0KPiA+ID4NCj4gPiA+IC0gdXBkYXRlIGEgbG9jYWwgdmFyaWFibGUgYW5kIHNl
dCB0aGUgYXRvbWljIGFmdGVyIHRoZSBsb29wLA0KPiA+ID4gLSBvciBtYWtlIGl0IGEgcGVyLWNw
dSB0byByZWR1Y2UgQ1BVIGNhY2hlIGJvdW5jaW5nLA0KPiA+ID4gLSBvciBqdXN0IGFib3V0IGFu
eXRoaW5nIHRoYXQgaXMgbGVzcyBoZWF2eS13ZWlnaHQgdGhhbiBhbiBhdG9taWMNCj4gPiA+ICAg
Q01QWENIRyBpbiB0aGUgaW5uZXIgbG9vcCBvZiBhIHNsb3Qgc2VhcmNoLg0KPiA+ID4NCj4gPg0K
PiA+IFBlcmhhcHMgSSdtIG1pc3NpbmcgeW91ciBwb2ludCwgYnV0IHRoZXJlJ3Mgbm8gbG9vcCBo
ZXJlLiAgVGhlIGF0b21pYw0KPiA+IGFkZCBpcyBkb25lIG9uY2UgcGVyIHN1Y2Nlc3NmdWwgc2xv
dCBhbGxvY2F0aW9uLiAgSWYgc3dpb3RsYl9kb19maW5kX3Nsb3RzKCkNCj4gPiBkb2Vzbid0IGZp
bmQgYW55IHNsb3RzIGZvciB0aGUgY3VycmVudCBhcmVhLCBpdCBleGl0cyBhdCB0aGUgIm5vdF9m
b3VuZCIgbGFiZWwNCj4gPiBhbmQgdGhlIGF0b21pYyBhZGQgaXNuJ3QgZG9uZS4NCj4gDQo+IE15
IGJhZC4gSSByZWFkIHRoZSBwYXRjaCB0b28gcXVpY2tseSBhbmQgdGhvdWdodCB0aGF0IHRoZSB1
cGRhdGUgd2FzDQo+IGRvbmUgZm9yIGVhY2ggc2VhcmNoZWQgYXJlYS4gSSBzdGF5IGNvcnJlY3Rl
ZCBoZXJlLg0KPiANCj4gPlsuLi5dDQo+ID4gSSB0aG91Z2h0IGFib3V0IHRyYWNraW5nIHRoZSBo
aWdoIHdhdGVyIG1hcmsgb24gYSBwZXItQ1BVIGJhc2lzIG9yDQo+ID4gcGVyLWFyZWEgYmFzaXMs
IGJ1dCBJIGRvbid0IHRoaW5rIHRoZSByZXN1bHRpbmcgZGF0YSBpcyB1c2VmdWwuICBBZGRpbmcg
dXANCj4gPiB0aGUgaW5kaXZpZHVhbCBoaWdoIHdhdGVyIG1hcmtzIGxpa2VseSBzaWduaWZpY2Fu
dGx5IG92ZXItZXN0aW1hdGVzIHRoZQ0KPiA+IHRydWUgaGlnaCB3YXRlciBtYXJrLiAgIElzIHRo
ZXJlIGEgY2xldmVyIHdheSB0byBtYWtlIHRoaXMgdXNlZnVsIHRoYXQgSSdtDQo+ID4gbm90IHRo
aW5raW5nIGFib3V0Pw0KPiANCj4gTm8sIG5vdCB0aGF0IEknbSBhd2FyZSBvZi4gTWluL21heCBj
YW5ub3QgYmUgZWFzaWx5IHNwbGl0Lg0KPiANCj4gPlsuLi5dDQo+ID4gUmVnYXJkaW5nIHlvdXIg
b3RoZXIgZW1haWwgYWJvdXQgbm9uLWRlZmF1bHQgaW9fdGxiX21lbSBpbnN0YW5jZXMsDQo+ID4g
bXkgcGF0Y2gganVzdCBleHRlbmRzIHdoYXQgaXMgYWxyZWFkeSByZXBvcnRlZCBpbiBkZWJ1Z2Zz
LCB3aGljaA0KPiA+IGlzIG9ubHkgZm9yIHRoZSBkZWZhdWx0IGlvX3RsYl9tZW0uICAgVGhlIG5v
bi1kZWZhdWx0IGluc3RhbmNlcyBzZWVtZWQNCj4gPiB0byBtZSB0byBiZSBmYWlybHkgbmljaGUg
Y2FzZXMgdGhhdCB3ZXJlbid0IHdvcnRoIHRoZSBhZGRpdGlvbmFsDQo+ID4gY29tcGxleGl0eSwg
YnV0IG1heWJlIEknbSB3cm9uZyBhYm91dCB0aGF0Lg0KPiANCj4gV2hhdCBJIG1lYW4gaXMgdGhh
dCB0aGUgdmFsdWVzIGN1cnJlbnRseSByZXBvcnRlZCBpbiBkZWJ1Z2ZzIG9ubHkgcmVmZXINCj4g
dG8gaW9fdGxiX2RlZmF1bHRfbWVtLiBTaW5jZSByZXN0cmljdGVkIERNQSBwb29scyBhbHNvIHVz
ZQ0KPiBzd2lvdGxiX2ZpbmRfc2xvdHMoKSBhbmQgc3dpb3RsYl9yZWxlYXNlX3Nsb3RzKCksIHRo
ZSBnbG9iYWwgY291bnRlcnMNCj4gbm93IGdldCB1cGRhdGVkIGJvdGggZm9yIGlvX3RsYl9kZWZh
dWx0X21lbSBhbmQgYWxsIHJlc3RyaWN0ZWQgRE1BDQo+IHBvb2xzLg0KPiANCj4gSW4gc2hvcnQs
IHRoaXMgaHVuayBpcyBhIGNoYW5nZSBpbiBiZWhhdmlvdXI6DQo+IA0KPiAgc3RhdGljIGludCBp
b190bGJfdXNlZF9nZXQodm9pZCAqZGF0YSwgdTY0ICp2YWwpDQo+ICB7DQo+IC0JKnZhbCA9IG1l
bV91c2VkKCZpb190bGJfZGVmYXVsdF9tZW0pOw0KPiArCSp2YWwgPSAodTY0KWF0b21pY19sb25n
X3JlYWQoJnRvdGFsX3VzZWQpOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gQmVmb3JlIHRo
ZSBjaGFuZ2UsIGl0IHNob3dzIHRoZSBudW1iZXIgb2YgdXNlZCBzbG90cyBpbiB0aGUgZGVmYXVs
dA0KPiBTV0lPVExCLCBhZnRlciB0aGUgY2hhbmdlIGl0IHNob3dzIHRoZSB0b3RhbCBudW1iZXIg
b2YgdXNlZCBzbG90cyBpbg0KPiB0aGUgU1dJT1RMQiBhbmQgYWxsIHJlc3RyaWN0ZWQgRE1BIHBv
b2xzLg0KPiANCg0KR290IGl0IC0tIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IG5vdy4gWW91IGFy
ZSByaWdodC4gIEknbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCk1pY2hhZWwNCg==
