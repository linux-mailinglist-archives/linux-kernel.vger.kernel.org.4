Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3D728D64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbjFIB6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbjFIB6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:58:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C2C30CD;
        Thu,  8 Jun 2023 18:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdnCSkorPURz6q4Sxufws/wAWDGakpcwhBadWj1t6TNQq4hZGRPUKkkP7HevhFOjUuYhAXU+pf/siDvj+QZ3p9kdSnpe+OtkZFYw2xyLBWBpejEv48+LquJCMUJ8wuMmSn0lLihLaJ2SYOyNTDHSxl/ZGXdqviOjUaamG99oT2BLCkS1ZW6sg55UHxgTq1tTBSL9W2IYfjXPDuwBW1lcXRipmwYd5SdczbLPF1aAkKwELIk9BnnkVu/4KhvVOCsUXO7ocbwUXbqjZmC9g1NhqOrCKRpMcKgvl1gnLMgloMdMq+mL+WnHKJAMHbNNX0nl33gZ0TLNSssY6jk4VvfszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iOEzOgg/lBsx/ijNBxg3dvpMKzyvcjipMNLFZrrQuc=;
 b=fonkht/kNsij+CrZcoJwmvQXA6/8eJy7LOlJidXVXjEpcr5kfQ2uDa9RhqyvIrKi6AVjLKcFvfoJQeCylQ7r9f6nO8Vu9LA+B3doL15F4exxhuhAHOoZ296hbbEbFzUxEIqCiB2NZMZugUGGcu+Wj4H230mqORhvsaGJD5XTsTt3/Yk4C+B5voNVyCAwfc3AFij+Vv3EvhEl36rY9MTntxKZrhiRI0WLV9X/GAhBcg8v02pWCUIGpdNw5EEny+ScWQsuxJ8Q94GIkXhMtsjZbjQCb8Cx6p+qSfABt4/Jvp69kYf48XEttzUS0OcA0H+/F5T/8wDdyVVKXDkkeqOJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iOEzOgg/lBsx/ijNBxg3dvpMKzyvcjipMNLFZrrQuc=;
 b=N3UDZ3hXkFdfi5NqVLLmQZ2+2wMT5oNdBjjGE/Fd4gEH6/LHJWrk/9CJjE4KpOvp5ymYMvOKWn+47eygDHacE3jYZDDCovN6Zz4b5ziX3qu1pT0D9XBuJDyF10FUdCunNu/c9y1X5CZy7JD0wzYeyl9S1p6HDzmzensEj1L6TkU=
Received: from DM4PR16MB5004.namprd16.prod.outlook.com (2603:10b6:8:43::15) by
 SA0PR16MB3725.namprd16.prod.outlook.com (2603:10b6:806:91::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Fri, 9 Jun 2023 01:58:18 +0000
Received: from DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::a733:90e1:bd47:cf69]) by DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::a733:90e1:bd47:cf69%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 01:58:17 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chevron Li <chevron_li@126.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Justin Wang (WH)" <justin.wang@bayhubtech.com>
Subject: RE: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
Thread-Topic: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
Thread-Index: AQHZjWdihWBVzy0abUm9tKKNGHDpg6+BJ88AgACoXyA=
Date:   Fri, 9 Jun 2023 01:58:17 +0000
Message-ID: <DM4PR16MB50042091C0D48F4832427F35EA51A@DM4PR16MB5004.namprd16.prod.outlook.com>
References: <20230523111114.18124-1-chevron_li@126.com>
 <CAPDyKFrAi04_4d-F+kNncE183ZZuD9ERL2qTb+M-nj_dNfojGA@mail.gmail.com>
In-Reply-To: <CAPDyKFrAi04_4d-F+kNncE183ZZuD9ERL2qTb+M-nj_dNfojGA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR16MB5004:EE_|SA0PR16MB3725:EE_
x-ms-office365-filtering-correlation-id: 2abd756c-95c9-482b-004a-08db688cfe77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aW/JpAqfC1AbiboD3CbYvDGhGd2DgzPbHrgRJpS3OwPlzzs+uUy1vJaJMq3OxTt7PXMWffcGBf4CEHRETFzRL41QC6xWDdb8rjLBIJzopEpijH1ZW+SPku02Z51/SSh8/cdg6UZdj4SihOaFzMxmVtKl6xirQROaYR8T0/P3CA6Ej7vbgX+lXjPaf5tpe+XxMYYMNTJi3SGFlHfr6JVADQs73KPrQ6hhoOPZj/7Oktarbub458il8XzvB5+7qXR2GolF7LfguIj6/nJnrCAGj/bihtCyxfSMMKEIHqMjuhePDun7T8fPAOJfKrJ3fpmCBuLEGcaQTxaBWtImtCAfpH6Fo+Ib2VH5axNrT0MuKuFrju3oaTIH8vajQZucYnR1hFjT89IY6y7xWzDwPPRJjXSOAts+97Pp70rQ4QcWB54/2DSVreCm+ecwCLBLAXl6sOGPaZpK5mtvh+11Z7Yy4OZrfU6fa4NeZidNSqHUzV5916MjzirZr49+GH6s79kMTFwPMvE+rAS9Wluuh8HPnNhxHtVveGbslCaGH1n4MHqEDrXAwbqO8UXWmktjYeJoR9FHi/ou8NGOD1S/2GxsEGw3pcz3gPsvxzS+Wf6xXQGeVhjdNSEiyOISvWqEgOMP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR16MB5004.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(39840400004)(346002)(451199021)(107886003)(26005)(6506007)(186003)(9686003)(53546011)(83380400001)(7696005)(110136005)(2906002)(71200400001)(8676002)(8936002)(55016003)(54906003)(33656002)(478600001)(38100700002)(122000001)(86362001)(5660300002)(41300700001)(66476007)(38070700005)(4326008)(52536014)(76116006)(316002)(66946007)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm43dmZWR1p1WDQ0NmZxZURYdVFQU1M1dExGWVZnLzE1SUFLWDlVZkgzYTJy?=
 =?utf-8?B?a01HSmcySEJxbmYvaklnL0hpS1pVQ2xtT1REK3FyY1dBUHBQaHZvdHJZUVkr?=
 =?utf-8?B?YUxMR0NBMmV4Zk9tMVJmNVJLcjRuQk1MYjhFRlZLb3EwVlRRSCtDLzUrLzk0?=
 =?utf-8?B?cXVpbGhiWitTK1R5WlpxYzlQSmdkRjhSMGVrS3FaUTYrdW5oNTZsdVVFWlpu?=
 =?utf-8?B?SVIyNnRwOGw2c3RsMHhSWEZTUStUZVhGZ2ZSa1pBTWRidUVvcjhKeTh6VjRO?=
 =?utf-8?B?S2dicFdTN0FtbXJBL1lZYW1xa2d5SGhvbzJNU0JJTmhxcCtuZGx5MkZzQ2J4?=
 =?utf-8?B?YmU5cjFNMllOL3BQTzVYV0NDSllCUXRhQnlSYmxrZnAvcC9vMytwRnl3TVJX?=
 =?utf-8?B?eWRrUmRRUFN4dUhXNUh3UnU4MytQL2dKZldzWjBLOVFWd2J5d2Y3SUp4U0x0?=
 =?utf-8?B?cTJVV0VtOSs3UVNMVWNMMlkrSTFXMHFnaGMvSlZwN2FmMjRwVVhPSnNDeXlN?=
 =?utf-8?B?dmhmckNCNEdZN3UrZGJrSW5QbHVUNDJTOWxWRXlIRVFxclZOb1ZLdWlLZFgv?=
 =?utf-8?B?UjdPVWs1dHkwcnVmWEVtSER2UFo1cXZza1FNVGFWa2l3bEhrd2Vhc2NGQVRz?=
 =?utf-8?B?OWFhVkhqMVhyRkJGOHNUak9IbHhQQmYxQmRBNzMraWtHVnVXaXZoejNUQTZj?=
 =?utf-8?B?aDBwTEdXaVppeXZ1dWtpNVY4N2Rmd1VaTVIvbk5YOWs5RGtwQmxpMTNGRGEv?=
 =?utf-8?B?SVZIQ0V3dllybXFhdFdjK0tPanYraCsyUklSejNDb2Q5RitIVE5aZUdkUU5G?=
 =?utf-8?B?TFk4bSt5OTg3MWw2b3JuNUFNRm12ZmlOajVtb29ncFJlUi9IK0lQbGk3eGFv?=
 =?utf-8?B?Q1BFT1FLZG00UjMvSVM5VkR3clY2UEp4clhlcEVDeWIxczBpcFgyZ3Q2RXho?=
 =?utf-8?B?OWJUZmJqTk1YWWhldlNBWXpURTRST21wcWl5S1VMQWZ5OTdlZHZwNzhWNi8v?=
 =?utf-8?B?OGVYQ3FIZ0tVR2JxNE52VngwOWlNcDN1S1NCSEJNc3ZBY3VydUkzWEV2L0tT?=
 =?utf-8?B?VUNIZ3pHUFpWbXJHUkhoVStBUWdaZ1FCcHNwWnhmVFdDZUxiYVdVazZJYVNr?=
 =?utf-8?B?enk5MkhkazQvS2V2dXdySWdLSVkxKzJUNzVpY3Buc0RqSFV6TFkyaTFiaFA2?=
 =?utf-8?B?ODRqZ3JtUFNjNHRDN1pxZTRJL1VTKzY1YzRlZ3hNQXNSR0taTHhVNFRSckYz?=
 =?utf-8?B?ZWtxa0RqNXd3SWRPMzhhdHNETCt2ZWFFMEptZXBnVFY4VkpwL3hKOHZvRFYz?=
 =?utf-8?B?dXJDeFpJV01JaWsrU0MyTzhYQW42cWV2dXhva0xYcDdqV2JJRjl3a05OSXRq?=
 =?utf-8?B?U21hK08rTFFYWENnZThqc29HMmtRR1M2OUdVbzJDU256VVVKY0VGV0tidXlJ?=
 =?utf-8?B?c0NYYjhRcFlhSDNHSUMwbndrVXpIRElvZ0Vtdm5Bd3ZUQ2FlK21aS3pCSzND?=
 =?utf-8?B?TjhqbVFRZ1NTTWd5c1phdFNYaEIzZTJaQk1ycUJXdXVJYlU2d3JONFlCejBU?=
 =?utf-8?B?d09RUE9OWWxRRGhNaFVaMkU2ZExZKzQ4dVRncm1YQ1ZRM21temlaUTF5QTZL?=
 =?utf-8?B?MXBCVFBsU0lWQmZaeFZIR21tK3JUSFJkU09tWVBOWndRQ2ZJQ0hVNEZraUta?=
 =?utf-8?B?WlU0L2NsZmMycUtjenFmeWdSTHgycjVPcnV4U3dPRFMyd01EMU1BVUtzbHRD?=
 =?utf-8?B?Z29LT3llWlhXTVRib0Q2SGZ3ZXJmRjNnNkM3Z3czdnlpakFyMnZoWUwrNnlN?=
 =?utf-8?B?VExwV05Eb043OGh0ZS9jakRZZkREWXlFNWN5NEJPeVpBMS80RnM3UXFidlBU?=
 =?utf-8?B?RTg5eXZQRy9FNW50NGJPbTlKNURIMkNUcmVHbXBNdkYrVVY3S1FGMVlHdTI1?=
 =?utf-8?B?MkFZaURNY3NtdWdraXBIYTlybWFMMFZzT0NwZ29VamFJYjZlNFI5YmI4UXlL?=
 =?utf-8?B?MWM3SzlNZXFCZ0Vvb0pORmEyQkhGb3hPT0JLYzdyTmdwejM2cU9aUlBwYndS?=
 =?utf-8?B?OHkwODV4Y1ZaazlKRUlFcFlHTGYwTGQ3c2V0NE01RVduM3JDbk15ZVhHdXh5?=
 =?utf-8?Q?Y/E1B3U2EJ5psGoZ1b3HCaMXb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR16MB5004.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abd756c-95c9-482b-004a-08db688cfe77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 01:58:17.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDDdjoOJ4ZmVwxkUdyp4D5kjSU41GpZ42pdgOkNyugLTiq0Nxk5Uk95FZS5L57dO70eNJcDBobTmlSM98Rh29m9wgLQfUj7zczTnRaBO3Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3725
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFVsZiwNCg0KWWVzLCB0aGlzIHBhdGNoIGZpeGVzIGEgcmVhbCBwcm9ibGVtLg0KDQpCUiwN
CkNoZXZyb24NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgOCwg
MjAyMyAyMzo1Mw0KPiBUbzogQ2hldnJvbiBMaSA8Y2hldnJvbl9saUAxMjYuY29tPg0KPiBDYzog
YWRyaWFuLmh1bnRlckBpbnRlbC5jb207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaGlybGV5IEhlcihTQykgPHNoaXJsZXkuaGVy
QGJheWh1YnRlY2guY29tPjsNCj4gWGlhb0d1YW5nIFl1IChXSCkgPHhpYW9ndWFuZy55dUBiYXlo
dWJ0ZWNoLmNvbT47IFNoYXBlciBMaXUgKFdIKQ0KPiA8c2hhcGVyLmxpdUBiYXlodWJ0ZWNoLmNv
bT47IEp1c3RpbiBXYW5nIChXSCkNCj4gPGp1c3Rpbi53YW5nQGJheWh1YnRlY2guY29tPjsgQ2hl
dnJvbiBMaSAoV0gpDQo+IDxjaGV2cm9uLmxpQGJheWh1YnRlY2guY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFYxIDEvMV0gbW1jOiBzZGhjaTogZml4IERNQSBjb25maWd1cmUgY29tcGF0aWJp
bGl0eSBpc3N1ZQ0KPiB3aGVuIDY0Yml0IERNQSBtb2RlIGlzIHVzZWQuDQo+IA0KPiBPbiBUdWUs
IDIzIE1heSAyMDIzIGF0IDEzOjEyLCBDaGV2cm9uIExpIDxjaGV2cm9uX2xpQDEyNi5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gRnJvbTogQ2hldnJvbiBMaSA8Y2hldnJvbi5saUBiYXlodWJ0ZWNoLmNv
bT4NCj4gPg0KPiA+IEJheWh1YiBTRCBob3N0IGhhcyBoYXJkd2FyZSBsaW1pdGF0aW9uOg0KPiA+
IDEuVGhlIHVwcGVyIDMyYml0IGFkZHJlc3MgaXMgaW5oaWJpdGVkIHRvIGJlIHdyaXR0ZW4gYXQg
U0QgSG9zdCBSZWdpc3Rlcg0KPiA+ICAgWzAzRV1bMTNdPTAgKDMyYml0cyBhZGRyZXNzaW5nKSBt
b2RlLCBpcyBhZG1pdHRlZCB0byBiZSB3cml0dGVuIG9ubHkgYXQNCj4gPiAgIFNEIEhvc3QgUmVn
aXN0ZXIgWzAzRV1bMTNdPTEgKDY0Yml0cyBhZGRyZXNzaW5nKSBtb2RlLg0KPiA+IDIuQmVjYXVz
ZSBvZiBhYm92ZSBpdGVtIzEsIG5lZWQgdG8gY29uZmlndXJlIFNEIEhvc3QgUmVnaXN0ZXIgWzAz
RV1bMTNdIHRvDQo+ID4gICAxKDY0Yml0cyBhZGRyZXNzaW5nIG1vZGUpIGJlZm9yZSBzZXQgNjRi
aXQgQURNQSBzeXN0ZW0gYWRkcmVzcydzIGhpZ2hlcg0KPiA+ICAgMzJiaXRzIFNEIEhvc3QgUmVn
aXN0ZXIgWzA1Rn4wNUNdIGlmIDY0IGJpdHMgYWRkcmVzc2luZyBtb2RlIGlzIHVzZWQuDQo+ID4N
Cj4gPiBUaGUgaGFyZHdhcmUgbGltaXRhdGlvbiBpcyByZWFzb25hYmxlIGZvciBiZWxvdyByZWFz
b25zOg0KPiA+IDEuTm9ybWFsIGZsb3cgc2hvdWxkIHNldCBETUEgd29ya2luZyBtb2RlIGZpcnN0
LCB0aGVuIGRvDQo+ID4gICBETUEtdHJhbnNmZXItcmVsYXRlZCBjb25maWd1cmF0aW9uLCBzdWNo
IGFzIHN5c3RlbSBhZGRyZXNzLg0KPiA+IDIuVGhlIGhhcmR3YXJlIGxpbWl0YXRpb24gbWF5IGF2
b2lkIHRoZSBzb2Z0d2FyZSB0byBjb25maWd1cmUgd3JvbmcgaGlnaGVyDQo+ID4gICAzMmJpdCBh
ZGRyZXNzIGF0IDMyYml0cyBhZGRyZXNzaW5nIG1vZGUgYWx0aG91Z2ggaXQgaXMgcmVkdW5kYW50
Lg0KPiA+DQo+ID4gVGhlIGNoYW5nZSB0aGF0IHNldCAzMmJpdHMvNjRiaXRzIGFkZHJlc3Npbmcg
bW9kZSBiZWZvcmUgc2V0IEFETUENCj4gYWRkcmVzcywNCj4gPiAgIGhhcyBubyBzaWRlLWVmZmVj
dCB0byBvdGhlciBob3N0IElQcyBmb3IgYmVsb3cgcmVhc29uOg0KPiA+IFRoZSBzZXR0aW5nIG9y
ZGVyIGlzIHJlYXNvbmFibGUgYW5kIHN0YW5kYXJkOiBETUEgTW9kZSBzZXR0aW5nIGZpcnN0IGFu
ZA0KPiA+ICAgdGhlbiBETUEgYWRkcmVzcyBzZXR0aW5nLiBJdCBtZWV0cyBhbGwgRE1BIHNldHRp
bmcgc2VxdWVuY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGV2cm9uIExpIDxjaGV2cm9u
LmxpQGJheWh1YnRlY2guY29tPg0KPiANCj4gQXBwbGllZCBmb3IgbmV4dCwgdGhhbmtzIQ0KPiAN
Cj4gSXMgdGhpcyBtYXRlcmlhbCBmb3Igc3RhYmxlIGtlcm5lbHMgdG9vLCBhcyBpdCBmaXhlcyBh
IHJlYWwgcHJvYmxlbSwgbm8/DQpZZXMsIGl0IGZpeGVzIGEgcmVhbCBwcm9ibGVtLg0KPiANCj4g
S2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZSBpbiBWMToN
Cj4gPiBTZXQgZG1hIG1vZGUgY29uZmlndXJlIGJlZm9yZSBzZXQgZG1hIGFkZHJlc3MNCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5j
IGluZGV4DQo+ID4gMzI0MTkxNjE0MWQ3Li5mZjQxYWE1NjU2NGUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jDQo+ID4gQEAgLTExNjcsNiArMTE2Nyw4IEBAIHN0YXRpYyB2b2lkIHNkaGNpX3ByZXBhcmVf
ZGF0YShzdHJ1Y3Qgc2RoY2lfaG9zdA0KPiAqaG9zdCwgc3RydWN0IG1tY19jb21tYW5kICpjbWQp
DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAg
c2RoY2lfY29uZmlnX2RtYShob3N0KTsNCj4gPiArDQo+ID4gICAgICAgICBpZiAoaG9zdC0+Zmxh
Z3MgJiBTREhDSV9SRVFfVVNFX0RNQSkgew0KPiA+ICAgICAgICAgICAgICAgICBpbnQgc2dfY250
ID0gc2RoY2lfcHJlX2RtYV90cmFuc2Zlcihob3N0LCBkYXRhLA0KPiA+IENPT0tJRV9NQVBQRUQp
Ow0KPiA+DQo+ID4gQEAgLTExODYsOCArMTE4OCw2IEBAIHN0YXRpYyB2b2lkIHNkaGNpX3ByZXBh
cmVfZGF0YShzdHJ1Y3Qgc2RoY2lfaG9zdA0KPiAqaG9zdCwgc3RydWN0IG1tY19jb21tYW5kICpj
bWQpDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAg
ICAgc2RoY2lfY29uZmlnX2RtYShob3N0KTsNCj4gPiAtDQo+ID4gICAgICAgICBpZiAoIShob3N0
LT5mbGFncyAmIFNESENJX1JFUV9VU0VfRE1BKSkgew0KPiA+ICAgICAgICAgICAgICAgICBpbnQg
ZmxhZ3M7DQo+ID4NCj4gPg0KPiA+IGJhc2UtY29tbWl0OiBjYzNjNDRjOWZkYTI2NGM2ZDQwMWJl
MDRlOTU0NDlhNTdjMTIzMWM2DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
