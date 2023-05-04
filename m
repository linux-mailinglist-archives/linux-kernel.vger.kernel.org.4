Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB96F67E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjEDI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjEDI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:59:45 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8E40CA
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQRD1V3tcPBKdneZB5/rvH3zv/81Qo9P5bl7a5OYi5gkT/13A7ndy7P50k1pmtM63HHcrpFYJmY6ZcFPY2ecTJrmvM8LdDi2qAmgMx7UNT+rldfCmtyQppEUmAWwlVe/fBsn/tJmFE8DGaNThERO19fdTaKxPRssO9X332W+ZETR/UwbOcnx0i/XkzWUyJPgZX2ZtBBWE91UDwwxZjfYUjUoapkogBp4jqAJXh69NxLGZ7YYkLSPRYWO+7l7Ucj6t5QKEtKUyJrr52DFwPWj2Odut/y1E7F6b2XaJdgfK+PXL4tQHOWBJnEk+KvsZ0s3IQqVgOOP/04Z8HYgjZhEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUp0uU6OGY86Zv0qdpFqDYVX/2SA5tZ8THCjaVp4HT0=;
 b=e9f7w+kAvVepOkuwoFYqDZriWdFDyCVQ+X3qnDoFVSGlLD5RehEhhcfdC7DrfVMI+JyHlk4SkfOx3RXWeL6BESr+IRQM/yW20lZeiM8JFahh+jMIIFzYiiRUkINDMpZO7wc275HxUYValCW95IV6/sJHA91nqdyQtd/Qw/X4TjhgyPfItsstBOUawxXzcNiQxSKcdD7919FbZyXupg8VLOQ0fAZUUi9pPZuG8pikQJFq0MGEwKPWb636171DDbwElQzxdxtCsEGGqibQeGEUX1jPinWRkrrWZJLKOSb/PpXsLEVL+FVGh6ISIN6Mpb2DuMxk2MUozn9EcpfpwefC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUp0uU6OGY86Zv0qdpFqDYVX/2SA5tZ8THCjaVp4HT0=;
 b=QiSnPmpsS/7JVMbzpk6V8sA09Ur1Z+WjnAc9aMcJrLSgILBjhV0OieTOc9omFiLAV+q3n46CdKekiyMwf1g99713BIGxengqG2qbuqMB7bCwBLl4ehGhnrmOf1rtWb6cvOA2pQcNgt0hdrpBb0y4jn6le4Ep54TEAfhhHFNwFbI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 08:59:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 08:59:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "saravanak@google.com" <saravanak@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>
Subject: RE: [PATCH] devres: provide API devm_kstrndup
Thread-Topic: [PATCH] devres: provide API devm_kstrndup
Thread-Index: AQHZfl1v2dJ+Xn8wKEaaSfsJTGo6Qa9J0F4AgAAAOdA=
Date:   Thu, 4 May 2023 08:59:41 +0000
Message-ID: <DU0PR04MB9417B76952E9B21E89946C09886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230504075754.372780-1-peng.fan@oss.nxp.com>
 <2023050413-margin-devotedly-468d@gregkh>
In-Reply-To: <2023050413-margin-devotedly-468d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7870:EE_
x-ms-office365-filtering-correlation-id: eacefbea-ac94-4239-406a-08db4c7de5ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84Fb57HCfBwaowqpD4aRK8ASOrEfWUhpihX3UsYDnegUYWg5yxG8n8j5KVQLPgFoQE3upk/uSTbYBq0EaXTiOEF8eL0UEVMVjQ2iIEdYHhw2o0guHXm/YZPcaFtIgTq08FW+4GbW+PCKorWDoCGtFLhhnUO4RD6lFGfO8ckH2oe4lET0hz6dZFsZrS8ofVs24xaI9tfAmfFUzw3BNjKhpwpDre6iRLP5bHL8I4N7g9u2O1Op07B9ePCK2qCUBjrnifJ7c6eOlvU0assGOipewudXp0C0mAnq2WwdhbH7pSef8xf1xTf8PPeDGVVg/YxJE7Ti8prvb//vG4zXcHTct2+06qzzEGLWTZSKctnNKtH1fYq5/di5tfgrmdqBYk2l7J2V93jpBs11tRPoKqQpkc9Qqj/n3YxY9/ypfhTM6NRzUHeBDNyq8YJJo3xf4DU6KcA72fmKnegzeyQ6HIjVOnu/yCzcOcE6G4AmlcwZg1QdRUijPxLecPDq3ZyQ6qffpub8vXiejGb9OfDfST6aeOgUjAFBOoNfa4bZ1j9vHZgg1sT/s7kRBls3syqfL+peZFkl7miekr0jz6V3sZN698nc51gcbOT4hDnX+WMSswo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(52536014)(44832011)(186003)(33656002)(7416002)(8676002)(8936002)(55016003)(71200400001)(5660300002)(7696005)(53546011)(9686003)(26005)(6506007)(38100700002)(966005)(86362001)(110136005)(122000001)(83380400001)(54906003)(38070700005)(316002)(64756008)(66556008)(66476007)(66446008)(66946007)(76116006)(4326008)(2906002)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dnJoZXJwalpRdDBLQUJXZWlFakdJL0puUUZJZXp0NTJtTHdXSHB5Y3dUMURt?=
 =?gb2312?B?WlpKaENFQ0xIVW1XYnA1d3dmeXZjcmNZdjNVZ1djSnVLaTVMaGZsM2g5ZmM4?=
 =?gb2312?B?bHVkbU0yZGwrZVFVSzJweHhFQW5CbWRxbXMxNzNYV1pBVUtSLzl0RTQ3WlNr?=
 =?gb2312?B?aWlVL1V3d3d3YnllbWxOSFNwS1U2UGNSTXRWVFdTVWh3RFBzN3VhWG9GUHFl?=
 =?gb2312?B?SzRnZXdYeDBBVXg4V29nWUxzREVkVi90REdmeEdYTE1uWFRQeXFiWkptc3Yx?=
 =?gb2312?B?QStCKzJhUnozVTNaRWRYTFV5V2JjMGhHbUhkWHZaWG5WTGt5ZStRVkEwSHFl?=
 =?gb2312?B?Z1NBd0hDQS9HODFaY3N2a2ZZVWJ5ZVVaZS9YMEhlbjArZ1hHV3F5TmRsQ3pC?=
 =?gb2312?B?Z0FvNXYycmpTQVNFY0oraHFCSGd4K0xneUtQKzU2bmhUckd3cFZZMjJ3dTRv?=
 =?gb2312?B?ejgza0h3K2RQd2tqMHZQeVNaeXVtUmE4RlhHWmNkWW5MZnVTMnV2dkZGSHFl?=
 =?gb2312?B?S3AzMkVXZDJ5eGNXZUZuZUZERmlMcFNKVTZxQ3hRbFV1Vm8vNk5TeGpicEx1?=
 =?gb2312?B?Z0phckkwMVVWUGpmU1hqcFd5R3hNL1V4Vjh0UHl0NWthaHBrSVp2YTkremo3?=
 =?gb2312?B?RVY3ODc3NjVBMlhvRm1sZ2NrcmtlaDNLSnlVK20xZ0xhVDV6VDhGQ1JKUGFH?=
 =?gb2312?B?ekRKdGw2S2ZydTNwZXhKWS9mdXRQaCtiOHhvQnhYRjZjUHh0VFA1ZTdwWFoy?=
 =?gb2312?B?dVdHRzVSQjhpUEhvdWM5WU5YY0hJL2duUk9HSHF4Z0p5VW15UXQxWlk2SjRH?=
 =?gb2312?B?V005bUZaYW9hcXZpbkhoRFRHR1poLzhFenJqNkVyNWh0Q0hVbTlMbVFuVklu?=
 =?gb2312?B?cm9iWTFtZTFrOG1JR0cwVVphU21MNkJlZ01vdmh0M3JreWNRZ3NqYTJrZURR?=
 =?gb2312?B?U0JtWTN3UHRweGNhSWpHandVNFBkQUgwcS9IaTFxS1kwaU1GWGJTK2p3emZP?=
 =?gb2312?B?cElDU2loUHM3ZUk2SmNEVzhWVVZtVGdZNjk1cWpjN0YzOVpuNUJGTll4dlVL?=
 =?gb2312?B?TVYrM0I4dnV6aVJRdkpuSFl5a1lwZkg0Q2RhQmJTMUxJOFZpVmEwS3NrbWw4?=
 =?gb2312?B?cW1XQVloME1uemVHakNBU005aE1rTG9xRXJtM2I2ekhFRkcwNmRFM3hvK203?=
 =?gb2312?B?MzI1aHpsbVZ1d0RJWnVzYktJemhMMFlSWTk1bzQ4bTZmREVwVEMwY05LK0NK?=
 =?gb2312?B?RkVHcUIyaUd0ckloR1pISVhLWHNMbjFWN0huMUJIU3JoOEE2NmFBWmhTUlM5?=
 =?gb2312?B?RVI3eks1cHJzY0paM2xjSks2bVpYcW1CS0ovbWhwN2ZxVDNEbWtpWVJjUXdt?=
 =?gb2312?B?c1pwRHZWT0VHMU9EbFR0TmdQRmdlTkxrdEVkQk5XZ3ZZeE1VeHgrbS9XTU1K?=
 =?gb2312?B?d1pvOTVFbkl3L2EyUmxpN1ZWOWo1cXNJK21HSlBtQ3RWdDlYR0I2MWpzMEpL?=
 =?gb2312?B?TzZJVS9qQWcyOVplL2hqS1p4a1IydUEwdDgzdk1mVC9seGNuS3RMekR4eXVn?=
 =?gb2312?B?WlBwWDlvTnRYVTc3eElZY3ZYZUs1VnhORXplWEpyNDdsL0QvWnlBUExrUEdv?=
 =?gb2312?B?RDBzcUZsT0hLb3hRL24yMVB5bkY4VDU1d0kzeVFpZGxUVS9HeHorL2hDcnJM?=
 =?gb2312?B?R3ZDMERNK05lL1JlaFVCWU8yREEwMTVyV0xhSjhpWVJNdlNJYVNSclgxMlZp?=
 =?gb2312?B?REluMGI1S0dJMmpCOEpiMmRtUjVDSm40emJCdkNZbVhMY0ZJSlBvdHlZRnlB?=
 =?gb2312?B?RWJBbjNDYjdub1o3QVp4TnhxejFyb3crR2NBeW9ReDRJMVFseGZCT1hGZHVi?=
 =?gb2312?B?Zit2bGpCS3RTVVBwMDZmdE90VjZlcmVRaWIrZGcvRG8xZmkvOEhqSVdCTzNK?=
 =?gb2312?B?ZXpnb1dJRlBjUjBDeUVQLzNpQU1YRnJxWk45TDg1enEraDZqYyt6SFRCTEts?=
 =?gb2312?B?WTY1NEF2dGVBcUE2aVhJOUxDUE1CSmpSSTVqT3RPbGExV0l4SFluUUNXRWht?=
 =?gb2312?B?NTZiZ0cvRGhPSk1yNjVNOXhwMnNjL1NZS01TZWZBaUdlRkNscTZjZ1pjRW9m?=
 =?gb2312?Q?a6dQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacefbea-ac94-4239-406a-08db4c7de5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 08:59:41.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k45F4SyjxILXgEL3fJbyJfqueafbDlusXO4MWe5w4t6Gw6+Uxam7k2ZX7cRwNMipIHtJSXJOFL3+LjKLM4q9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogMjAyM8TqNdTCNMjVIDE2OjU4
DQo+IFRvOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IENjOiByb2Jo
K2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gcmFm
YWVsQGtlcm5lbC5vcmc7IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsNCj4gaGRl
Z29lZGVAcmVkaGF0LmNvbTsgamdnQHppZXBlLmNhOyBzYXJhdmFuYWtAZ29vZ2xlLmNvbTsNCj4g
a2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGFiZWwudmVzYUBsaW5hcm8ub3JnOyBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZGV2cmVzOiBwcm92aWRlIEFQSSBk
ZXZtX2tzdHJuZHVwDQo+IA0KPiBPbiBUaHUsIE1heSAwNCwgMjAyMyBhdCAwMzo1Nzo1NFBNICsw
ODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBkZXZtX2tzdHJuZHVwIEFQ
SSBzbyB0aGF0IHRoZSBkZXZpY2UncyBkcml2ZXINCj4gPiBjYW4gYWxsb2NhdGUgbWVtb3J5IGFu
ZCBjb3B5IHN0cmluZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Jhc2UvZGV2cmVzLmMgIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IGluY2x1ZGUvbGludXgvZGV2aWNlLmggfCAg
MSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gV2UgY2Fu
IG5vdCBhZGQgYXBpcyB3aXRoIG5vIHVzZXJzLCBwbGVhc2Ugc3VibWl0IHRoaXMgYXQgdGhlIHNh
bWUgdGltZSBhDQo+IGRyaXZlciBuZWVkcyBpdC4NCj4gDQo+IEFuZCB3aGF0IGRyaXZlciB3b3Vs
ZCBuZWVkIHRvIGNvcHkgYSBzdHJpbmc/DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIzMDUwNDA4NTUwNi41MDQ0NzQtMS1wZW5nLmZhbkBvc3MubnhwLmNvbS8NCg0KU2hvdWxkIEkg
c3VibWl0IFYyIHdpdGggdGhlIHVwcGVyIHBhdGNoIGluIGEgcGF0Y2hzZXQ/DQoNClRoYW5rcywN
ClBlbmcuDQoNCj4gDQo+IA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9kZXZy
ZXMuYyBiL2RyaXZlcnMvYmFzZS9kZXZyZXMuYyBpbmRleA0KPiA+IDVjOTk4Y2ZhYzMzNS4uODdl
Mjk2NWU1YmFiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9kZXZyZXMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvYmFzZS9kZXZyZXMuYw0KPiA+IEBAIC05NjMsNiArOTYzLDM0IEBAIGNoYXIg
KmRldm1fa3N0cmR1cChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0DQo+IGNoYXINCj4gPiAqcywg
Z2ZwX3QgZ2ZwKSAgfSAgRVhQT1JUX1NZTUJPTF9HUEwoZGV2bV9rc3RyZHVwKTsNCj4gPg0KPiA+
ICsvKioNCj4gPiArICogZGV2bV9rc3RybmR1cCAtIEFsbG9jYXRlIHJlc291cmNlIG1hbmFnZWQg
c3BhY2UgYW5kDQo+ID4gKyAqICAgICAgICAgICAgICAgIGNvcHkgYW4gZXhpc3Rpbmcgc3RyaW5n
IGludG8gdGhhdC4NCj4gPiArICogQGRldjogRGV2aWNlIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3IN
Cj4gPiArICogQHM6IHRoZSBzdHJpbmcgdG8gZHVwbGljYXRlDQo+ID4gKyAqIEBtYXg6IG1heCBs
ZW5ndGggdG8gZHVwbGljYXRlDQo+ID4gKyAqIEBnZnA6IHRoZSBHRlAgbWFzayB1c2VkIGluIHRo
ZSBkZXZtX2ttYWxsb2MoKSBjYWxsIHdoZW4gYWxsb2NhdGluZw0KPiA+ICttZW1vcnkNCj4gPiAr
ICogUkVUVVJOUzoNCj4gPiArICogUG9pbnRlciB0byBhbGxvY2F0ZWQgc3RyaW5nIG9uIHN1Y2Nl
c3MsIE5VTEwgb24gZmFpbHVyZS4NCj4gPiArICovDQo+ID4gK2NoYXIgKmRldm1fa3N0cm5kdXAo
c3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpzLCBzaXplX3QgbWF4LA0KPiA+ICtnZnBf
dCBnZnApIHsNCj4gPiArCXNpemVfdCBsZW47DQo+ID4gKwljaGFyICpidWY7DQo+ID4gKw0KPiA+
ICsJaWYgKCFzKQ0KPiA+ICsJCXJldHVybiBOVUxMOw0KPiA+ICsNCj4gPiArCWxlbiA9IHN0cm5s
ZW4ocywgbWF4KTsNCj4gPiArCWJ1ZiA9IGRldm1fa21hbGxvYyhkZXYsIGxlbiArIDEsIGdmcCk7
DQo+ID4gKwlpZiAoYnVmKSB7DQo+ID4gKwkJbWVtY3B5KGJ1ZiwgcywgbGVuKTsNCj4gPiArCQli
dWZbbGVuXSA9ICdcMCc7DQo+IA0KPiBXaHkgbm90IHVzZSBrc3RybmR1cCgpIGluc3RlYWQgb2Yg
Y29weWluZyB0aGUgc2FtZSBsb2dpYyBoZXJlPw0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBr
LWgNCg==
