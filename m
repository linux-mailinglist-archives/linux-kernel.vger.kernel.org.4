Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA3637265
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKXGeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiKXGeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:34:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E59825F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:34:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+0SsDCSG8RBbKKg/wAM2H0g4xpdvN47CFVIscZQEcXwpsAOYc0Q4Q78B6n+WWlAJeTb+tQkfma68u3Ti8uzdVfEtnsIG9lqkDEZ2DNSGxD0wVvXrUDLMIOJwiosc72sN+aKo8DZOJCTMnUPyJZF2vYyQrz38kK0Wpuuhj17Gn9DipS8TdqoQ0WTcseiBKXi4NrarU/C+tvanY0V4A1LhP5f27gZrWPGG1MdkMkFfechZa1fBRpAXsHkuTEc0J6gNU5NTStrhJLQiR4+Qj7IqrU5RZOfMIdBnQCxB65PzKBQaDCWXtD3gYUBAS8V3uXQ/f93R2jChw2uw+KXoDLrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkORolk0PrauBp/bNdsRa4WmvY1W6zWyQaMJsRL5b3k=;
 b=RgEhnkEAAcWJ5EJD11c4786H4TClXSH+kNNBFvv0l2X18IbsU6C2qr2bntEnlA4M2yGAoc3QBXR+OLEi0x4VGb6Qliq4mUHDQpGpW6ZaeYj+ecLQbY/uF2xE3DlSBrfThazI213ZFR82wM6KpjEcOg//rNhNyHhuaKodcJZi6VB/gs8bVTMDFM8imqeQxeYke/u14SOH1jFjmhITpIIW+1tEX+SIlyov5mNda69vLoePGWWae3wkAVGU9uVvwqLCMRma8HKp6gbkbXqDwZGSppA+ru6v+Szh5RGfIqVy8+KXZXCg31TdLUkQnXagCJ6u7ohhlgz3QQxfYNtXER+mRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkORolk0PrauBp/bNdsRa4WmvY1W6zWyQaMJsRL5b3k=;
 b=hannCyUbZZ5IPMSPxWf4M5oa2307VkTP+lj0Al1BSE48fYTQSRldD/gdmnf/7ghSadyEcv/AJq+27zB1qQdDSpNMNF6ajhdmmiUnDgRPRDO/hD3LiAb+JBceNmbjqTLT0GnjDaSAK1dpkKIbOHpHPK1t9h3qBxhzseOR5FE8iyquIDBQz4OstkTbnwN6fHGhalCK2P2iDtl1+2RG6330wfihfGNPiBS/CiyrRXQIUqZHaFS2zwPLCiFW4tHqZXKC8+qeIvn/uyPooVGeLnV1qDgJ/fYeFPdq1dLKQAevmvgNZ/b6if1Eg5jk1xCr28bBbwVTP2E/PPMO57Em0P5uiQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 06:34:04 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 06:34:04 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
Thread-Topic: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
Thread-Index: AQHY+CuMzadJp/Y8rUSM5UwMlBdRsK5NrLHg
Date:   Thu, 24 Nov 2022 06:34:04 +0000
Message-ID: <DM8PR12MB540016371DAF2915B3277949AB0F9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221114131759.57883-1-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-1-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|BL1PR12MB5802:EE_
x-ms-office365-filtering-correlation-id: e1fbed60-2e89-4bc0-dd9e-08dacde5e19b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXFrrYRtKWEQQ3Y9KVUE45m8rNyxa01AXhd0vZf38z214DuaT63+xf3GJ1KEk/TC165sLJhoYdqb7NdGSltpn/ajf/IjlGYisSwjSMq+p8OZLJ9VmdlgWkazQxbP94vozy7XQ++U6mQVGrIGq0+DnbcJ06Kftr9pyv14thZiQYUd1Ww3/aXjIPbiIfUfU7lCa5a9Ud2zBT29LIEKjuKp3cgmQgw46ULDcyPocNUkrx2P93Dzsx50HsB4MuhfexnvEB1+wfiznbVge5WJmXb6vydbhkdAy5pV/SpEA0uUv3oDcgMvFowRVmE3FTkPxXPgYjekucSy82fE6LIBjJzOKA978YoQxCNeiSFdW7v0StzGoQrrGa3qLQjUTh+DCBy6ASnXoNHx89NYiVf7W1Xr3f3keDiapYITAKyAyMHzIFL7BGwpvEz8NWv2NduSzM1AzBnPDxwxk/3P6wiIxGq28KmHXL60B50eOtQZwH1VFMhpxIPpmOWe41KcP7RFsZy464M2hMcyr3L8Nzr3uPQkBC2ESmcI0y5mS12e8excxCDIezF4S+KIJTi2rnd3fwYf1XXg7lgCyaR2++r/MAfnYfwpTzCbtacHJJCVHn1EP70SQOWX/ZaSY3A6LpHNklBpqZE2qxkHDkbXyPDCtt3wKD7jhcfYEOoIajDc+IGi5FcX6kuPBt8yv8wsJa0H6HN6C42/ItHU7L1QH9kmaLGx1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199015)(122000001)(33656002)(2906002)(8936002)(52536014)(41300700001)(5660300002)(86362001)(66946007)(66446008)(66476007)(4326008)(66556008)(76116006)(64756008)(110136005)(38070700005)(54906003)(8676002)(316002)(478600001)(55016003)(38100700002)(9686003)(7696005)(6506007)(26005)(83380400001)(71200400001)(53546011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjJta1dvOGJTYlFvM1ppcTJrbCtvdjBqOWFaWS9XREQxRjNUVmJjY2xUdWxV?=
 =?utf-8?B?dXoxT0RzNmV3NTRoekduWmlUQmRsTWQ4cDhGaFNHSyt5aDFHYlBhUXJnTnpn?=
 =?utf-8?B?VXJBTlRBNWlJdTNyZnJrRkphTWNnZUdScmdQZ2hZVjVUN2FzbVZZSUlNdjdH?=
 =?utf-8?B?V3VrdS9OSVJrT1NobnFIWWRFVjZZWmFjZDNoM0ZFaHNyWGgrTjhnclBxSEU1?=
 =?utf-8?B?eGJiUWtVQVhKRWlKYmJTVmdLQ3dITEZRSWxxWDEwY1hsQmoxeDMwV0pwVVhQ?=
 =?utf-8?B?bHNnTThuczB3bk11SUFXNWEyanFxTHlLMytWZ09DblFCMkIwbmYyN0VKWWFy?=
 =?utf-8?B?Y3EwVGtudUJVT0tBTkVBSW04c1pSWkFuWE9CbjVPS0hPUEJrMUVIbmVjRFNE?=
 =?utf-8?B?aXluNDZaRk96WXdVWXU4akNkUSs1UGd4WDlDWW5kWXgzb1YyTkNqWTVibkI0?=
 =?utf-8?B?dlgvakxPT1ozS0tMazdHOUE2dld0STg2VTBISnZOVHhTL1J0NUxtMXBsYmh2?=
 =?utf-8?B?Z1RVQUNHb2xQSytmdG9RcTNseWhydGFIWUNabWQ3TmV4aVNtbVRnUGxyVFgr?=
 =?utf-8?B?aFpRT08rV0F4ZnFwNmVXa2hyekl6R2t1WWtycHBXRm42ZGJoZ0VUU2EyTlN3?=
 =?utf-8?B?NzdoKy9ZNjBsR0w2VTgybThFRXRyZldxWG1pa0htNkp4ZE4rMG9FU0h4UkRR?=
 =?utf-8?B?RHRIQ3BjV1B3RXkyWUw2aUhaTkl5OHIvcnp4Tmw1b0REUlpTWVNPZWlNSE1E?=
 =?utf-8?B?azlYem1jSm5NQkdRdHJ3Ukl0T3VUeHNBeUh0Kyt1Yjh2aXlDMlVWcFlvLzJZ?=
 =?utf-8?B?QzJnTlF4Zmt4aklZVnNoZGxUallkR3Z3dGVlTHpqU2NVZXlTQ1BvQWpNU2Jq?=
 =?utf-8?B?dm1MR3Y5ckJzbDNQTUNqaUYvWnByWUxVNWx3bG5hano5MkxXTEROOFRybmNx?=
 =?utf-8?B?bWkyTG5CTklMSis4dDY1ZndKTEJ4YmU5ZFlnZTh5azhLb1VOcHFMSEdiakVU?=
 =?utf-8?B?cGR5VkNrdTZlMWp3QjVSN1NsZ3dxVlNpcFVpMDAySGsrdWJWZmRiNGNzMTBw?=
 =?utf-8?B?YjFzZTc5L3NYK1I0TWo3eEJ6MjNsQzlDZTBtQnp3R1BwdTFoTEdza0xRL2xq?=
 =?utf-8?B?WnQxejhXb3F3eHZxTzlHK21EUkdldDlKS2FQRG9Ncmo0aVBEZC9xdi9KSk5l?=
 =?utf-8?B?SWNGVkdyRTNHVjEwemF5UURpS21WWmovUFJLMDkyM0xTMm9sTVFaUXh6ZHRB?=
 =?utf-8?B?SjVzK3ZabGRpYk9TWUVwNWNJb3J4M1YzcHpFMWpUbklvUGlUZDhtUzltU2o4?=
 =?utf-8?B?SC9IRS8wYUFUUWRiVEREbWxrS29CV2tjdmFFdjBOR0x5dTNFbkRkUSt3YmVz?=
 =?utf-8?B?RkJ3c0tYOFc2OUZ6SU5HRzR0OEp0VGYvZnNqS21LaURXazFyUnp0MmxqR0ZK?=
 =?utf-8?B?cHBuUzE0SkZ0RHp6U2F0MDRkbFJMamR3VlRoc3lXTGJDUlZJUVh5WGphdmV2?=
 =?utf-8?B?bTBxb1FSaGIyak0rQnJEYWxlUWcreiszcU0zNVJoVjlnL0lSVU9ZSGg1Skl6?=
 =?utf-8?B?cWtkYjMrYkhsUkFOSFpSa0MraUtDeEUrMWNla1ZObzhzd1luWWtjNTMycTNW?=
 =?utf-8?B?bC8zQzV2bEFieFZoMUluSS93ZUVuZStSOENHSzc2M2x4RDdDZkVzZHZlMXl3?=
 =?utf-8?B?bVFPWGM5QTlrdFUreTBMYUFxaHJiS0xsZDVVMDhUZG1pS0YrNkNvMGlQYjZw?=
 =?utf-8?B?YkE2VEgzK0R3K0R4R25FYkl3Y1lvK20wN1I3UXVrazNsV2hldmZIcDMvVHo0?=
 =?utf-8?B?NGZwOEEvbjNtcUJpY2NveTNsbzE5bWtCSGdqT1RHT2lqOVEzWGNWT0E2QytC?=
 =?utf-8?B?WDVFQXlXYzlWbW95YkpFQ2xya0w4NXJxKzRud1VSc3lreC95YWZpY3Bnb2x4?=
 =?utf-8?B?Uk1tUWJXSE1DNVJhcFNPOHhDY3JkQ0R2bGUyOVd4RkdUV1hvaWVEYWc2aXh0?=
 =?utf-8?B?eTl4MlhPZjgzSzBlUTM2NjVPYTRjeER6dWZjSjJqR21MZUlvZnR6UUtmcUNn?=
 =?utf-8?B?RUZPWThva040THpGNkVSSWtFMnhBSmMxdmYyU2NraGN4OGFycFFRR0Iybk1Y?=
 =?utf-8?Q?19Hg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fbed60-2e89-4bc0-dd9e-08dacde5e19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:34:04.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhjcEPpjQN0ld5bAcNjc94z2FYswWsf4uiT+7v+nNh+MzzQHkdfLA3WwSlGFEM8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCwNCg0KQXJlIHlvdSBnb2luZyB0byBwdWxsIHRoaXMgc2VyaWVzPyBJdCBoYXMg
YmVlbiByZXZpZXdlZC4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIDE0IE5vdmVtYmVy
IDIwMjIgMTU6MTgNCj4gVG86IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogc2ktd2VpLmxpdUBvcmFjbGUuY29tOyBlcGVyZXptYUBy
ZWRoYXQuY29tOyBsdWx1QHJlZGhhdC5jb207IEVsaQ0KPiBDb2hlbiA8ZWxpY0BudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUSCB2MiAwLzhdIHZkcGEvbWx4NTogQWRkIGRlYnVnZnMgc3VidHJl
ZSBhbmQgZml4ZXMNCj4gDQo+IFRoaXMgc2VyaWVzIGlzIGEgcmVzZW5kIG9mIHByZXZpb3VzbHkg
c2VudCBwYXRjaCBsaXN0LiBJdCBhZGRzIGEgZmV3DQo+IGZpeGVzIHNvIEkgdHJlYXQgYXMgYSB2
MCBvZiBhIG5ldyBzZXJpZXMuDQo+IA0KPiBJdCBhZGRzIGEga2VybmVsIGNvbmZpZyBwYXJhbSBD
T05GSUdfTUxYNV9WRFBBX1NURUVSSU5HX0RFQlVHIHRoYXQNCj4gd2hlbg0KPiBlYWJsZWQgYWxs
b3dzIHRvIHJlYWQgcnggdW5pY2FzdCBhbmQgbXVsdGljYXN0IGNvdW50ZXJzIHBlciB0YWdnZWQg
b3IgdW50YWdnZWQNCj4gdHJhZmZpYy4NCj4gDQo+IEV4YW1wbGVzOg0KPiAkIGNhdCAvc3lzL2tl
cm5lbC9kZWJ1Zy9tbHg1L21seDVfY29yZS5zZi4xL3ZkcGEtDQo+IDAvcngvdW50YWdnZWQvbWNh
c3QvcGFja2V0cw0KPiAkIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9tbHg1L21seDVfY29yZS5zZi4x
L3ZkcGEtMC9yeC91bnRhZ2dlZC91Y2FzdC9ieXRlcw0KPiANCj4gdjEtPnYyOg0KPiAxLiBSZW9y
ZGVyIHBhdGNoZXMgc28gZml4ZXMgYXJlIGZpcnN0DQo+IDIuIEJyZWFrICJGaXggcnVsZSBmb3J3
YXJkaW5nIFZMQU4gdG8gVElSIiBpbnRvIHR3byBwYXRjaGVzDQo+IDMuIFNxdWFzaCBmaXggZm9y
IGJ1ZyBpbiBmaXJzdCBwYXRjaCBmcm9tICJBZGQgUlggY291bnRlcnMgdG8gZGVidWdmcyINCj4g
NC4gTW92ZSBjbGVhcmluZyBvZiBuYl9yZWdpc3RlcmVkIGJlZm9yZSBjYWxsaW5nIG1seDVfbm90
aWZpZXJfdW5yZWdpc3RlcigpIGluDQo+IG1seDVfdmRwYV9kZXZfZGVsKCkNCj4gDQo+IA0KPiBF
bGkgQ29oZW4gKDgpOg0KPiAgIHZkcGEvbWx4NTogRml4IHJ1bGUgZm9yd2FyZGluZyBWTEFOIHRv
IFRJUg0KPiAgIHZkcGEvbWx4NTogUmV0dXJuIGVycm9yIG9uIHZsYW4gY3RybCBjb21tYW5kcyBp
ZiBub3Qgc3VwcG9ydGVkDQo+ICAgdmRwYS9tbHg1OiBGaXggd3JvbmcgbWFjIGFkZHJlc3MgZGVs
ZXRpb24NCj4gICB2ZHBhL21seDU6IEF2b2lkIHVzaW5nIHJlc2xvY2sgaW4gZXZlbnRfaGFuZGxl
cg0KPiAgIHZkcGEvbWx4NTogQXZvaWQgb3ZlcndyaXRpbmcgQ1ZRIGlvdGxiDQo+ICAgdmRwYS9t
bHg1OiBNb3ZlIHNvbWUgZGVmaW5pdGlvbnMgdG8gYSBuZXcgaGVhZGVyIGZpbGUNCj4gICB2ZHBh
L21seDU6IEFkZCBkZWJ1Z2ZzIHN1YnRyZWUNCj4gICB2ZHBhL21seDU6IEFkZCBSWCBjb3VudGVy
cyB0byBkZWJ1Z2ZzDQo+IA0KPiAgZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICAgICB8
ICAxMiArKw0KPiAgZHJpdmVycy92ZHBhL21seDUvTWFrZWZpbGUgICAgICAgICB8ICAgMiArLQ0K
PiAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8ICAgNSArLQ0KPiAgZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tci5jICAgICAgICB8ICA0NCArKy0tLQ0KPiAgZHJpdmVycy92ZHBh
L21seDUvbmV0L2RlYnVnLmMgICAgICB8IDE1MiArKysrKysrKysrKysrKysrKysNCj4gIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAyNTAgKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0NCj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuaCAgfCAgOTQgKysr
KysrKysrKysNCj4gIDcgZmlsZXMgY2hhbmdlZCwgNDEyIGluc2VydGlvbnMoKyksIDE0NyBkZWxl
dGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvZGVi
dWcuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuaA0KPiANCj4gLS0NCj4gMi4zOC4xDQoNCg==
