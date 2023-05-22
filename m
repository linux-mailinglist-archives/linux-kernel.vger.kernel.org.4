Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DFF70CE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 01:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjEVXH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEVXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 19:07:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFEC6;
        Mon, 22 May 2023 16:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPQwCwbnxxsC36YMoHRmrremRTd1tNPSbV4M374C0qoD8HxhZKdXKp1oS2C7nFxNDBR0xc4fiQLuYbBayQw0r9u8zqc5atvMTRKdrrsr9ODR6QYKHrk3Fgk1MtUGM/oRcy/guFAccxv+GLHdtkxotA9op7/wolnwT+LpvEJC/7aEK4uAPRCABa1CvSpnq6nK5uxkljWGyovMHuCwJEaLE08XqvMEj5cQDLawUnkqcumjNl+yI4pUbwjF+zH5nR0wL/UQ9dTVCaEYe52rVDDyPIFueQTInSHAST2ZpDwt2IqPooVfroF5bqueE/oxcqmGQzH99J5rezgYZ9bJM4g8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Exc6wih/mhHs2FGoR38LuGf3cZD/TRWYWEd8Np4E2yk=;
 b=DpCBq+881ox+ZK+6fDS8OuS/HDYIbUHkMA/dmUgnOHxqGjUsbMEkb+EO0ZgPomJ9Xj4tLrGIp5ywMBWt8xP6y6pQZD44RHAiahGBdcCVvSaJx1kdWLNwFmXL2YGgwiA8+00C/Hjyc2R/uzKrYSEyzGrp1xks4ICmFshHzefYZntRE5gbu9h4obdVkrQFjE+BFilzIBR6C5AIO2RaTueyRdhTap9mqsucsQ5qoimHkeS9pZq+/h6Vmc9USBFNKD0U6R3gJLtbkrXRJ4FMXJ8Wo+bQ8h94cpFvwl0/uMCaKZQE3LLhWoY199ze0PKTHHbtIcRFZlevwDT7luB+5iRHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exc6wih/mhHs2FGoR38LuGf3cZD/TRWYWEd8Np4E2yk=;
 b=BeKmitMjrUkJDxcyGY+QVE7hSnJ599/rFglxbCRR4V0IDwBrqGroOhoMoLoMShOfOl49XkyqNs53tGd2t44NX/5jgiFHPDHvkDlNO5nfhummJKuAcgYmGACYXk/fZD4jRIinD9lc4GSbw1lrPnwR9ugreKdIGon/uBop2XxZtx0=
Received: from BYAPR03MB4757.namprd03.prod.outlook.com (2603:10b6:a03:13b::28)
 by CH2PR03MB5174.namprd03.prod.outlook.com (2603:10b6:610:9f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 23:07:22 +0000
Received: from BYAPR03MB4757.namprd03.prod.outlook.com
 ([fe80::aec7:afbd:5eed:9ec3]) by BYAPR03MB4757.namprd03.prod.outlook.com
 ([fe80::aec7:afbd:5eed:9ec3%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:07:21 +0000
From:   Andrew Duggan <aduggan@synaptics.com>
To:     Jeffery Miller <jefferymiller@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Andrew Duggan <andrew@duggan.us>,
        Jonathan Denose <jdenose@chromium.org>,
        "jdenose@google.com" <jdenose@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Huang <Vincent.huang@tw.synaptics.com>
Subject: RE: [PATCH] Input: synaptics-rmi4 - retry reading SMBus version on
 resume
Thread-Topic: [PATCH] Input: synaptics-rmi4 - retry reading SMBus version on
 resume
Thread-Index: AQHZg3V7BQdJ1wF3e0myTEbF/FoRyq9T7vkAgAMcNQCAD+s8gA==
Date:   Mon, 22 May 2023 23:07:21 +0000
Message-ID: <BYAPR03MB47572F2C65E52ED673238D41B2439@BYAPR03MB4757.namprd03.prod.outlook.com>
References: <20230510192731.300786-1-jefferymiller@google.com>
 <ZFv5VkIzTEVwo2PI@google.com>
 <CAAzPG9PpP4_hUxmpYmTGQmH7qd5AbgEBv1fDcE_sYJNnYn=bgA@mail.gmail.com>
In-Reply-To: <CAAzPG9PpP4_hUxmpYmTGQmH7qd5AbgEBv1fDcE_sYJNnYn=bgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWR1Z2dhblxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTY2NWIzNWFmLWY4ZjUtMTFlZC05MTMwLTA4M2E4ODVhZjk3ZFxhbWUtdGVzdFw2NjViMzViMC1mOGY1LTExZWQtOTEzMC0wODNhODg1YWY5N2Rib2R5LnR4dCIgc3o9IjU1NjAiIHQ9IjEzMzI5MjcwNDM5NzgxMDAwMCIgaD0iZVg0WCtaNnlKbS84ajBnWEtIQTF3eXRyUkdvPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB4757:EE_|CH2PR03MB5174:EE_
x-ms-office365-filtering-correlation-id: ff84cfbe-e0fc-407c-7f13-08db5b194c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5vQmDkes4nLzRkoss6IEMGuX6ZAH1gyym3/R2JK3+MUA+TU0OKnGNKvKB3/3zbp1+xyqUZush2d7o/yJrI6AmzXQxhbIowz9pnRizps9I8egS4ifezAtimoY7goljKaBayqDeD+HTAdm7duRLieuuvEqpe7wJ3rJotjluZKaYgJZRClJvTMpz4Ko8aY16KRc1ICCHW6bhw/P8UhFB1NvjiKUzMyndlmT7CyxB4Et5xWrkqP8AlCFKtcGHlybBECW9umNZZTaMSFgiQ/bA7J0cd+w9MB4Uo/x2lSJhvseFiT5CYjfJKaWtYyeYjY+U0ecgevXezXRmd0GzIOF0WyF1F63LMrHgWHosQOTRhR4o2upiSqQnOnPUvR+rNEFx3R1DNxHY7vcXOD+2zqU9KQqJ8PuEDaLQYp63YQLUvZTxmjAY+ZeEDIb9EcrRV0fLlzpKyZ6mOuSs8qPmmVzlS9L2+NiZUfASTpBQoAaind7JhyZ5JesFT4RL11mJ57IVfUUtOZdqZ3qBg9vc3B6bkXQyO1JTxiA2PyIBiLSvO7S5yZ5bNi7ricmXFSPAVlhvkEGbuOl3O6NYfMB3Goi2c4yBp2OHYBwUWdOskwAWEoRYIhMWRT8DH/1tcGFDGKYVP+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4757.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39850400004)(451199021)(8936002)(8676002)(7416002)(5660300002)(52536014)(66574015)(83380400001)(9686003)(26005)(6506007)(53546011)(107886003)(86362001)(186003)(122000001)(38100700002)(38070700005)(33656002)(55016003)(71200400001)(478600001)(66946007)(7696005)(316002)(4326008)(41300700001)(64756008)(66476007)(110136005)(66446008)(66556008)(54906003)(2906002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWREMTd6d0NjVCszUlkyTUpZdnJ4N0ZJK29kVXlNSmR2UVROS21adlNpOEo0?=
 =?utf-8?B?bVNwVlFmV0VOMDFXcENFcGJKRTNUMlhIMkxGbXJKWDB5My91MXFLLy9Vblpp?=
 =?utf-8?B?ZS9EemJkMWpsUkVMYmlxLzc2amJ2aXU5Y2Nja2VkWHpzUWttaFc4Y29sMlpw?=
 =?utf-8?B?OTlaSFpUcTFadDdlYUV0NzFZY2FyOUIzcVlIck43T2RwcmFLem5wMy9wcGRT?=
 =?utf-8?B?aHNrT2FoM3YrYUoybTlEbENsalNNMjZXM2NkSW1wRTB5ZnJiZE1EaVJIcXRB?=
 =?utf-8?B?ekVuSXNZS21IaU84ZVhaZloydnEzMjZ1SWlta2I0eG9iV1BKOFdUTXo2K2FL?=
 =?utf-8?B?c1BTaEdiTURLWGs4UkNNaUZYRWMxU21ibGorQTVEVThJYWhiK1JFSzZXRW9z?=
 =?utf-8?B?bG5JVDdDeDdwOTF4TEpKZ2pHRm8rVFA4bnVMa2dNeE9LS2drb29NakpnTkdy?=
 =?utf-8?B?M1VLMHEvS0trZzVWdXNMQmJtaTFCOVBWUFU1eHY2SDdRVUZqQXJSOFN4Ukoz?=
 =?utf-8?B?V2liSHZCc1BJeWtBUk04a1dEb29JbUZ2VnQycklhSHJjTUI4S1ZVYmZxZVVw?=
 =?utf-8?B?NkFlY3NPRDc3NGtOTUNELzN5VWtwaGlJU28xQ3NpUVNWeDF5STErTXVFemg2?=
 =?utf-8?B?b1lMdnUrV0Q4S3R2c1hnTVFwbVdkN1BEb0U2RWlnbGRNWFNkUjRQeTdHa0tJ?=
 =?utf-8?B?RnZidmJlTWRvTXM0N1I5UVZhOFFzbjNvUGpkT1dOKzJMZVFpRnU2aDQrTmhZ?=
 =?utf-8?B?NnZubkxvR1gyeXMvSG9DTXRwRW1MVUl2c1o4ZzhHTUx0ekJaU2lzbFpudUZI?=
 =?utf-8?B?dzIydEtYNVN0dFcvQ3FGNmJlVHhJbjJpU3FIOHZQVndzemxpMUR1ZnVUaHRQ?=
 =?utf-8?B?R1lMUVlZSmNSY1oyZ0k1aHpySm8vcnJFdkhDa1NheW1uVUYzL0ZwcHo3OWtN?=
 =?utf-8?B?dnJHMTdHNTBpUUFqdE1xMWdHekFtenhjSXBDb0gxZU9nVFk2L2daMjBRUHNE?=
 =?utf-8?B?RlFaV1VqUHRCbncvNjRDTFhreWtDNHlHbmF1K0RFcWQraiswcks3ZmVDTkpq?=
 =?utf-8?B?Q2l3czh1d2Z4SGhJczRHVTU4Vmx5VVNiczc2ZVc0SVNHOVRob21HUEltL2V6?=
 =?utf-8?B?U1Q3WU1vSDNPRThMTDZZVk9sWUFhRkVBeTg2SDEyWG91RUJTalR2VVFFQWpQ?=
 =?utf-8?B?cWdQZjhvWExrVUJCSnhxbXg1NzFEVEJDRGZNUThydHBJK1Z4UzNDNEsvbzBX?=
 =?utf-8?B?bWRIUmszVUhNWUU0MmxmeHZuWENEbnl0ZDdSRWtGMjZkcjN4RDJpdEo5aUlk?=
 =?utf-8?B?T3JQa21VWlZiekdSTjFoSUJmZ0lZbmxPTDRySjVTKy9lTCs2RDFONUZXci9q?=
 =?utf-8?B?YlQxb3ZYNDFyS0JtNFRUeDB5NldJQ3Y3cm51aFk0N2FIeS9sTDZ5bno3NnBh?=
 =?utf-8?B?MUFRUmhDVmk4WW5ndzlsYWlCamNhK093aFk1RUc1dmplV0Q0azdyNGxHdjE5?=
 =?utf-8?B?TXZkQ25DQ3g3NVoxN1Z5b053TXBzaFVnank4U3c4OFVDQVAzSXNRRmxUSDhO?=
 =?utf-8?B?MThMTlJVUm5jYTN6Ump2ZWY5OWlTdmdwMUFSZm9uRFBlTzFxMUJFbnZoQUdV?=
 =?utf-8?B?RXVROTNia3BZaFRHT0NIOWlteG1qWDdtMzZ5WnREc3pMczB4VmhyWWZHaUdE?=
 =?utf-8?B?L2hQOFY0YVd5dWEvcHBNZVkrZFdLcVdNZG10QjZsM09QVDBlWm9rdTdydU41?=
 =?utf-8?B?RzhIRDdqbkNuZ0tCMXNCVEI1VndvUUpYV2d2WjhPejc4cTdWUXEyRnN0U0VK?=
 =?utf-8?B?enZ2YmV6eEkzL3RXVjFDZVhFZDJJZFdhVHlocTkwVUdTMFlta0IydFhsWG1T?=
 =?utf-8?B?NmVCNEJFMlZ6bVg2T3RieEx0WnVIZnJhY3dkYjhzbHo3S1pleWI1QkV6Slhn?=
 =?utf-8?B?UnlPV2p4bng3ZDU3QzAyK1J2anVHK3RxdFVNbjVQU1luUVlhc2UvbUJwRi9Z?=
 =?utf-8?B?Y0JDaDJHOFo3OStUeXp6L04zQUQ3S1hzNjI5TXljTVJsN3VPN1NoV055dTYz?=
 =?utf-8?B?eXJVNERwb3ZRcGtGaFVXbXI3NWQ3aEViVm4yTHFSMHBtYmJxNlNvazh1Y2lX?=
 =?utf-8?Q?hqzmfNwlksY0D/n9fUPMG0oYs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4757.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff84cfbe-e0fc-407c-7f13-08db5b194c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 23:07:21.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vhRSj1a4WSzl1M4kzqzfcY/kBymLAA8De7U0LZX19v63xOkNk+GNieIfsb6tryihbWXHH3IjGXBtck+47/tXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5174
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZWZmZXJ5IE1pbGxlciA8amVmZmVyeW1pbGxlckBnb29nbGUuY29tPg0KPiBTZW50
OiBGcmlkYXksIE1heSAxMiwgMjAyMyAxMjozNw0KPiBUbzogRG1pdHJ5IFRvcm9raG92IDxkbWl0
cnkudG9yb2tob3ZAZ21haWwuY29tPg0KPiBDYzogQW5kcmV3IER1Z2dhbiA8YW5kcmV3QGR1Z2dh
bi51cz47IEpvbmF0aGFuIERlbm9zZQ0KPiA8amRlbm9zZUBjaHJvbWl1bS5vcmc+OyBqZGVub3Nl
QGdvb2dsZS5jb207IEx5dWRlIFBhdWwNCj4gPGx5dWRlQHJlZGhhdC5jb20+OyBsb2ljLnBvdWxh
aW5AbGluYXJvLm9yZzsNCj4gYmVuamFtaW4udGlzc29pcmVzQHJlZGhhdC5jb207IEFuZHJldyBE
dWdnYW4NCj4gPGFkdWdnYW5Ac3luYXB0aWNzLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPEpv
bmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT47IE1heGltaWxpYW4gTHV6DQo+IDxsdXptYXhpbWls
aWFuQGdtYWlsLmNvbT47IE1pZ3VlbCBPamVkYSA8b2plZGFAa2VybmVsLm9yZz47IFV3ZSBLbGVp
bmUtDQo+IEvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPjsgbGludXgtaW5w
dXRAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIElucHV0OiBzeW5hcHRpY3Mtcm1pNCAtIHJldHJ5IHJlYWRpbmcg
U01CdXMgdmVyc2lvbiBvbg0KPiByZXN1bWUNCj4gDQo+IENBVVRJT046IEVtYWlsIG9yaWdpbmF0
ZWQgZXh0ZXJuYWxseSwgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4g
dW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiANCj4gDQo+IE9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0IDM6MDbigK9QTSBEbWl0cnkg
VG9yb2tob3YNCj4gPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPiBJIGFtIG5vdCByZWFsbHkgZm9uZCBvZiBhZGRpbmcgcmFuZG9tIHJlcGVhdHMgaW4gdGhl
IGNvZGUgYmFzZS4NCj4gPiBBbmRyZXcsIGRvIHlvdSBrbm93IGlmIHRoZSBTeW5hcHRpY3MgZGV2
aWNlIG5lZWRzIGNlcnRhaW4gZGVsYXkgd2hlbg0KPiA+IHN3aXRjaGluZyB0byBTTWJ1cyBtb2Rl
Pw0KPiA+DQo+IFRoYXQncyByZWFzb25hYmxlLiBJdCdzIHRydWUgdGhpcyBpcyBhIHNsZWVwIHRv
IHdvcmthcm91bmQgcm1pX3NtYnVzJw0KPiBleHBlY3RhdGlvbiB0aGF0DQo+IGl0IGlzIGFibGUg
dG8gc3VjY2Vzc2Z1bGx5IHJlYWQgZnJvbSB0aGUgaTgwMSBpMmMgc21idXMgYWRkciAweDJjIG9u
IHJlc3VtZQ0KPiB3aGVuIGl0IGNhbm5vdC4NCj4gDQo+IEkgZG8gbm90IGtub3cgd2h5IHRoZSBp
ODAxIGkyYyBhZGRyIDB4MmMgaXMgbm90IHJlc3BvbmRpbmcgb24gcmVzdW1lLg0KPiBJbmZyZXF1
ZW50bHkgaXQgd29uJ3QgcmVzcG9uZCBvbiBib290IGR1cmluZyB0aGUgaW5pdGlhbA0KPiBwc21v
dXNlX3NtYnVzX2NyZWF0ZV9jb21wYW5pb24gYnV0IHRoYXQgaXMgbGVzcyBub3RpY2VhYmxlIHNp
bmNlIGl0IHdpbGwNCj4gc3RheSBpbiBwcy8yIG1vZGUgYW5kIGp1c3QgbGFjayBmZWF0dXJlcy4N
Cj4gDQo+IEkgZG8ga25vdyBhZGRpbmcgYSBzbGVlcCBpbi1iZXR3ZWVuIHRoZSBwc21vdXNlIGRl
YWN0aXZhdGUgY2FsbCBhbmQNCj4gcm1pX3NtYnVzJ3MgYXR0ZW1wdHMgdG8gcmVhZCBmcm9tIHRo
ZSAweDJjIGFkZHIgYWxsb3cgaXQgdG8gc3VjY2VlZCBvbiB0aGlzDQo+IG1hY2hpbmUuIEkgZG8g
bm90IGtub3cgdGhlIGRldGFpbHMgYXMgdG8gd2h5IGhvd2V2ZXIuDQoNCk91ciBXaW5kb3dzIGRy
aXZlciBkb2VzIGEgMzAgbXMgZGVsYXkgYmV0d2VlbiBzZW5kaW5nIHRoZSBkaXNhYmxlIGNvbW1h
bmQgYW5kIHRyeWluZyB0byBjb21tdW5pY2F0ZSBvdmVyIFNNQnVzLiBJIGRvbuKAmXQga25vdyBz
cGVjaWZpY2FsbHkgd2h5IHRoaXMgZGVsYXkgaXMgbmVlZGVkLCBidXQgdGhpcyBpcyBob3cgd2Ug
aGFuZGxlIHRoaXMgY2FzZS4NCg0KPiANCj4gSSBjYW4gYXBwbHkgd29ya2Fyb3VuZHMgdW50aWwg
dGhlIHVuZGVybHlpbmcgaXNzdWUgY2FuIGJlIGlkZW50aWZpZWQgYW5kDQo+IHByb3Blcmx5IHJl
c29sdmVkLg0KPiANCj4gSSBjYW4gYXBwbHkgcGF0Y2hlcyBhbmQgcHJvdmlkZSBhbnkgc29ydCBv
ZiBkZWJ1Z2dpbmcgb3IgZXh0cmEgaW5mb3JtYXRpb24NCj4gdGhhdCBtaWdodCBiZSB1c2VmdWwg
dG8gYW55b25lIGZhbWlsaWFyIHdpdGggdGhlc2UgZGV2aWNlcy4NCj4gDQo+IFRoZSBzbWJ1cyBj
b250cm9sbGVyIGluIHRoaXMgcGFydGljdWxhciBtYWNoaW5lIGlzOg0KPiAwMDoxZi4zIFNNQnVz
IFswYzA1XTogSW50ZWwgQ29ycG9yYXRpb24gOCBTZXJpZXMvQzIyMCBTZXJpZXMgQ2hpcHNldCBG
YW1pbHkNCj4gU01CdXMgQ29udHJvbGxlciBbODA4Njo4YzIyXSAocmV2IDA0KQ0KPiANCj4gUGVy
aGFwcyB0aGVyZSdzIHNvbWUgd2F5IHRvIGRldGVjdCB3aGVuIHRoZSBhZGRyIGlzIGF2YWlsYWJs
ZSBsYXRlciBhbmQgaGF2ZQ0KPiBpdCB0cmlnZ2VyIGEgbmV3IHByb2JlIHNpbWlsYXIgdG8gaG93
IHBzbW91c2Vfc21idXNfbm90aWZpZXIgaXMgdHJpZ2dlcmVkDQo+IHdoZW4gdGhlIGk4MDEgYnVz
IGJlY29tZXMgYXZhaWxhYmxlPw0KPiANCj4gVGhhbmsgWW91LA0KPiBKZWZmDQoNCkFuZHJldw0K
