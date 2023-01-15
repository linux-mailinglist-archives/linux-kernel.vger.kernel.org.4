Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CD66B084
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjAOLIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAOLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:08:47 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AEF753
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5kmlvoEvggRbycsSorAMLSXJd0e1/jYNWsL4fEWCg6Eo2LoxKVRt9JIqjURUryiPcSdyUO5ojg61X3VspL6i/f6rVdIC1vJ1tILw7pZLN4SXAeLmwvUc9QYyLsLy8Si0ISmOX4yW+ye21DSmaNUWXV15SoybnHlP0UG9xq1LmYBxobsDOfY8g7aRv8KcR4855Bcxz+3/XSku/3cNAI/pcVadHHaO5Vs4VcI/Bdp+DwspTBYINHu8J9c1As2XgWY6kFWs+gFLSa4Tqdod/Gzgdtydq4FivuOriAY31GSkTmec4DAztM5qQBgYcHG+u9hZQJcdNFcoPNT96i6laGQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lRoTDJDg/xzPMmQuewbbTtQEFoUEnJzhOw/9Lda+YU=;
 b=YRnXov4OBQkPBidv0jA+jHbKUEV9FV8Hq1TYHQBPG98OKMaWjAGEnA0qfh0k57yJazMq9e74RZz/k5q6CIWanL90FaZ4q1kaibQJ30zhFabkwsH7vBca4Qn4dM1e6GVu0fsRTRzIJJjpezJONKsM9rB3UVU3Za631fFMTmdKOnj07iN0VLBFF+81gGhCKx3lWiNKl74boGap5sWLMYV8pcDNEDrGsp9UaB6Ub3N3xOKSRQvDYvjll2NEZJ3b2HJH+Yc6kVlby6oV4/+eG7cP/6Skcz6GaagbJAMf6WFbJa395SXWKYqRZHUDL5px6tVNN/Zj0SHVm3vcRNoq0NnCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lRoTDJDg/xzPMmQuewbbTtQEFoUEnJzhOw/9Lda+YU=;
 b=bF82ydIZlHFWDV0TzDDWtdbsUSgUgU74um9NcBFZiQ2hWTo50ucuGfnbnNcONxQtLb94ATaDDW2CHjDf/C7U+5RMKmQuF7llTYQY8tn25NED4Zu1bbYy3MXSIYDiVSMrU67GffLnH+2pUP+RW6PLtkNNrdhNVXpw9yV6lCJwdqhZ9SIhPAJmm5fcAEkj/6oMYbzhkWEktTT5G+vIB0lnx4QslFX/GnDvTb/cdZkFtwZrSUf1x/k8czh3r4iB/l1tLOWcztmhM7nhUGUEl8bPRK3FIBeqk+nzvycf466L9LX4IayVa+GZJoTCekaN+xbpv8b5JONhAvlDS/mv6v9Ocg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Sun, 15 Jan 2023 11:08:44 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Sun, 15 Jan 2023
 11:08:44 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
Thread-Topic: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
Thread-Index: AQHZJYXygZIj7fHHL0WXt6dEN4fjiK6fWBFw
Date:   Sun, 15 Jan 2023 11:08:44 +0000
Message-ID: <DM8PR12MB5400D84460E084D3459B49B1ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-6-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-6-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CH0PR12MB5219:EE_
x-ms-office365-filtering-correlation-id: 547da18c-0112-40ae-af1d-08daf6e8ddf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZkjdpYMT8cxI9IcFnjA3kx+aYpI6n0GwXbtYpa4tms451zk9kLH6qXGKt5XlZQy8ms5RWk6xQa4Y16lFmJJ7z7CDjDM+5jDLmlwYRW/7honON7P/OwtixMMNA2z6f0wcJ6M/LjU9XtDwiiVKwB9t2vGAWyIqsyo6NkUtHLEGiqmByHz/ecbVNj8NAYoVlvGiEHskypwxFyrcZqoyll+CvpARgUCb6V1qtjfByvEequLLa4pZ4wXwVMfh2QRfASrlYmoJI8nfdS+WQIHK2/pHC17N81j/WTFC6K9qhZU7aNy7ArYLWth4KCIxiK2R9JxaXPzgSkKt1hvdYVZJMib+dR7GLAMMlAmt0lsoWMGqfjIgyniDBYEyFx+GGSZha57XKn9C/ESfcl8RK3LUx3Gc6NsbPlifT0VJhqkrIl/d2UUXsq4tRo+jmxh/FiL8NzQao8foJbLm7piIFJi0q3eWtsJVfLVD44ytszU6rOcLEjyTjdwnOurC2fRYYyDPu8LxGiI+swrP1I7dJEnelc3x596ydmtD1xD5ir7O3et57MJzxDRiGaZ4QovtsevwGvD3pUH6h3DJc3JxgU7BOG+jXNKHJaw6d6HKTWDmKg6XUqDpTNkAZFoY+NgWfDGLeTmvWScwIiPEW/kT4Hy7lU352h3Vpucj3WltoubdcN62BBgYYEbTs2Hr1MelBMIq8TsFEkrYOlkxkIKrC6KyifbxHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(7696005)(71200400001)(33656002)(478600001)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(41300700001)(110136005)(54906003)(316002)(55016003)(38070700005)(38100700002)(122000001)(6506007)(53546011)(26005)(9686003)(186003)(83380400001)(86362001)(5660300002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTlDN2R6b0h2YjFMUFJzc3ZpbE5WTGN5dS8yVnBsQ2Z2L25GNzZ4THNLOUMw?=
 =?utf-8?B?Yy80MTVPOFFuS1hDNWg1ZjV5TUcxS3o2QlpBREx6TldORW9iSEVxNysySTB4?=
 =?utf-8?B?Y3k0YkZ1aGRyb2hIMlhrU09XZkp3NGtpT2hJRXF3bTJDMFM1RzgyQVJtTlFq?=
 =?utf-8?B?aDZ6Sm5SWmRBZUJSRGJPZ0VEU0ZNand6d0o0Q1VnbklPZ1BtaXc4Q0xLODNu?=
 =?utf-8?B?ZEVKaFU4TnVtVW1SWW5aTnkrbzFOZ29TR0gwWUEvRnAwekorRS9SOUU4TDlO?=
 =?utf-8?B?S0hhbnB4RC9hTTdPMVN0cGdndmRwd0o4d3Z1aWJIN3BzMjRjdCtuQXV5VGY1?=
 =?utf-8?B?NjFIM25lR29IUTdKTkxGbjRyZitZMEV6RnAwZnBscDNQWFlLc2VYM1BGeVZV?=
 =?utf-8?B?NUF4RzkxZjdZNjdDejRoWWZTWVpmb3RrQURDYkw4T3hIQlN4RERXYVRHNkZD?=
 =?utf-8?B?N3ZMVFk3blZtYTRpN1ZBNlVWaXlaV0JPUzdmY2pOVVIycFNtRFFaKy9yUUVm?=
 =?utf-8?B?RHVKMVpTRlNZK29wVFVocWhJZHZVYzFyWVhETVAyOGg3ZnBvWTR6M0JrWXE1?=
 =?utf-8?B?b1BvTTRGTDNUWVZBTTh4K0s5VUlwV2lmbHBsRmdwZE5ycmVpRkp6ckdtR2dM?=
 =?utf-8?B?K1JwWFZaRVYzSml0YjVjRXQ0VnNNcU9CTmk0YkdLM01ZQTZKT29STng2aTZW?=
 =?utf-8?B?UnlzTUNENWpWWWlzbExQVXlFckVqdkVjQmJCNEREN3J4MmRrZDlYdWZuRkFS?=
 =?utf-8?B?REoxWnJlUVo3VTIwMzBYTDJmQVljYnhIMTZQUm83djBYNUszelFlRkVObmRn?=
 =?utf-8?B?aVd4cUYya3FOVmtHTjlCampLL1g3aGV6VUdQeW1wS0gycUE0QjdmelhJTHFM?=
 =?utf-8?B?RWZ1Vi9yRVg5VWhTVGEyTEYvY1pxUHJOMHBoZS93VnNTQ01nRWp1RTN5aTFO?=
 =?utf-8?B?dDdXWTF2S2NMbG00elltYXdYUUdPc3R4ekdEc01FV01abElRR2RHTms5TVpH?=
 =?utf-8?B?K0h6cUt3Y1g5T1RwanFnYWpML09xUnc4UnJ1TjNxdUorSmtFRlI2UTJmb2J0?=
 =?utf-8?B?VDBtU3E5bUJCT1laampENzU5SE1qbE0yRktrNXd5Zk5hV0lWVnRiM1l5SG96?=
 =?utf-8?B?N0puWFBSUEJpOW52eHdTNjJza0tuTkZyc1p4ZVFvMENGS1pHengyWUp3ZUhv?=
 =?utf-8?B?dDJaR0VsQXFRYk1hbU1weVhqVE85NlhZZkxCQUx3dk1LSEw2RkdlbW9hVS9E?=
 =?utf-8?B?YjFXN1l0ZlczMzQ4R3Q5K296M3RaQndLQ2V1dnV1M2FucklsN2hPdG5hT2k2?=
 =?utf-8?B?SWR0cnh6Y0xIbnI1QVcwcmFuYmp0S3NTTzFORm56dDllTW9uaXFjd2x2ams1?=
 =?utf-8?B?eURTMDJ5MVVSUE5YK0JsdUJ5WUIxR05VdHNIY2lCdTYzSFpmZTBHWHVtWDZF?=
 =?utf-8?B?MW9qSUNyK21aMXZKVE1Valh6QWFkWmszVmtVempYRG1GTHBWRnFyZk51VCsz?=
 =?utf-8?B?OFY5b2tSV0JiemRwYmhwUVBvbnNNRUt5TkJRc0ROSmJFajhLbEVzMENab2Zx?=
 =?utf-8?B?UWFXTnVhODNhdDZlRmlUcnlhc2dyTDdhRnhoSVZnNlY3Y1dVbmhNTGZyaXZo?=
 =?utf-8?B?Mno1UFhLQlJEbGRXbHhiaEpYc0FuK21kdmJVZWZFbCtlcGRCRXk5cERqcllL?=
 =?utf-8?B?TzBGRytVOFBveUV4T1JyV1QwYmQwZldRbW1vS29wNld6V1FyU3piWXE4SlJq?=
 =?utf-8?B?QjV6bTY0QWtzSXR6NXBhS3ErWVpTUGE2TE9nQzBFQVhzbDVDNWtEYVhpMGZ2?=
 =?utf-8?B?bnVuYWJsZVpRNnBNTHVLdk5yU2JGNVk0UDhwRXczaTk2d05GQjNmeGZXUElH?=
 =?utf-8?B?WTN4bFJLQlJ2UjdXTHpoRnBLcXR6eGlCbFRSMVN1bjVpa3BJMDF0NHZLN1c5?=
 =?utf-8?B?S1pUVVB1T1ZjSmllZ0U3T1p0NGN3cDlHeGIwdUk4SUwzWllMY2tVOFAxNXg5?=
 =?utf-8?B?STg4ckNBQWtSRGYwV0Nlb09tbXhYMkJCUHFBZVlEOGJncTNDZnhRa3Vzc0Mv?=
 =?utf-8?B?L1lEQ1JvdENKcnJXanRGQStOcXU2VVJIZnphSXUzc1JZaXpRSnZ6OG1lRktz?=
 =?utf-8?Q?x1vI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547da18c-0112-40ae-af1d-08daf6e8ddf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 11:08:44.2549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v30k9F5sZoIvGZgwEGzuAMI4HmH6sdZFB7zNIKo0XKy3tNi9/y1wCqtf45Pg9Kba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIDExIEphbnVhcnkgMjAyMyA4OjI4DQo+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdA
cmVkaGF0LmNvbQ0KPiBDYzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+OyBnZGF3YXJAYW1k
LmNvbTsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHRhbnVqLmthbWRlQGFtZC5jb20NCj4gU3ViamVj
dDogW1BBVENIIDUvNV0gdmRwYTogbWx4NTogc3VwcG9ydCBwZXIgdmlydHF1ZXVlIGRtYSBkZXZp
Y2UNCj4gDQo+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBwZXIgdmlydHF1ZXVlIGRtYSBkZXZpY2Ug
Zm9yIG1seDVfdmRwYS4gVGhpcyBpcw0KPiBuZWVkZWQgZm9yIHZpcnRpb192ZHBhIHRvIHdvcmsg
Zm9yIENWUSB3aGljaCBpcyBiYWNrZWQgYnkgdnJpbmdoIGJ1dA0KPiBub3QgRE1BLiBXZSBzaW1w
bHkgYWR2ZXJ0aXNlIHRoZSB2RFBBIGRldmljZSBpdHNlbGYgYXMgdGhlIERNQSBkZXZpY2UNCj4g
Zm9yIENWUSB0aGVuIERNQSBBUEkgY2FuIHNpbXBseSB1c2UgUEEgc28gdGhlIGlkZW50aWNhbCBt
YXBwaW5nIGZvcg0KPiBDVlEgY2FuIHN0aWxsIGJlIHVzZWQuIE90aGVyd2lzZSB0aGUgaWRlbnRp
Y2FsICgxOjEpIG1hcHBpbmcgd29uJ3QNCj4gd29yayB3aGVuIHBsYXRmb3JtIElPTU1VIGlzIGVu
YWJsZWQgc2luY2UgdGhlIElPVkEgaXMgYWxsb2NhdGVkIG9uDQo+IGRlbWFuZCB3aGljaCBpcyBu
b3QgbmVjZXNzYXJpbHkgdGhlIFBBLg0KPiANCj4gVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIGNy
YXNoIHdoZW4gbWx4NSB2RFBBIGRldmljZSBpcyBib3VuZCB0bw0KPiB2aXJ0aW8tdmRwYSB3aXRo
IHBsYXRmb3JtIElPTU1VIGVuYWJsZWQgYnV0IG5vdCBpbiBwYXNzdGhyb3VnaCBtb2RlOg0KPiAN
Cj4gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJlc3M6IGZmMmZiMzA2
M2RlYjEwMDINCj4gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+
ICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQ0KPiBQR0QgMTM5MzAw
MTA2NyBQNEQgMTM5MzAwMjA2NyBQVUQgMA0KPiBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAg
Tk9QVEkNCj4gQ1BVOiA1NSBQSUQ6IDg5MjMgQ29tbToga3dvcmtlci91MTEyOjMgS2R1bXA6IGxv
YWRlZCBOb3QgdGFpbnRlZCA2LjEuMCsNCj4gIzcNCj4gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMu
IFBvd2VyRWRnZSBSNzUwLzBQSjgwTSwgQklPUyAxLjUuNCAxMi8xNy8yMDIxDQo+IFdvcmtxdWV1
ZTogbWx4NV92ZHBhX3dxIG1seDVfY3ZxX2tpY2tfaGFuZGxlciBbbWx4NV92ZHBhXQ0KPiBSSVA6
IDAwMTA6dnJpbmdoX2dldGRlc2NfaW90bGIrMHg5My8weDFkMCBbdnJpbmdoXQ0KPiBDb2RlOiAx
NCAyNSA0MCBlZiAwMSAwMCA4MyA4MiBjMCAwYSAwMCAwMCAwMSA0OCAyYiAwNSA5MyA1YSAxYiBl
YSA4YiA0YyAyNA0KPiAxNCA0OCBjMSBmOCAwNiA0OCBjMSBlMCAwYyA0OCAwMyAwNSA5MCA1YSAx
YiBlYSA0OCAwMSBjOCA8MGY+IGI3IDAwIDgzIGFhIGMwDQo+IDBhIDAwIDAwIDAxIDY1IGZmIDBk
IGJjIGU0IDQxIDNmIDBmIDg0IDA1IDAxIDAwDQo+IFJTUDogMDAxODpmZjQ2ODIxYmE2NjRmZGY4
IEVGTEFHUzogMDAwMTAyODINCj4gUkFYOiBmZjJmYjMwNjNkZWIxMDAyIFJCWDogMDAwMDAwMDAw
MDAwMGEyMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDINCj4gUkRYOiBmZjJmYjMxOGQyZjk0MzgwIFJT
STogMDAwMDAwMDAwMDAwMDAwMiBSREk6IDAwMDAwMDAwMDAwMDAwMDENCj4gUkJQOiBmZjJmYjMw
NjVlODMyNDEwIFIwODogZmY0NjgyMWJhNjY0ZmUwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDENCj4g
UjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwZCBSMTI6IGZmMmZiMzA2
NWU4MzI0ODgNCj4gUjEzOiBmZjJmYjMwNjVlODMyNGE4IFIxNDogZmYyZmIzMDY1ZTgzMjRjOCBS
MTU6IGZmMmZiMzA2NWU4MzI0YTgNCj4gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZm
MmZiMzI1N2ZhYzAwMDAoMDAwMCkNCj4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IENSMjogZmYyZmIz
MDYzZGViMTAwMiBDUjM6IDAwMDAwMDEzOTIwMTAwMDYgQ1I0OiAwMDAwMDAwMDAwNzcxZWUwDQo+
IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOg0KPiAwMDAw
MDAwMDAwMDAwMDAwDQo+IERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBm
ZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+IFBLUlU6IDU1NTU1NTU0DQo+IENhbGwgVHJhY2U6
DQo+IDxUQVNLPg0KPiAgIG1seDVfY3ZxX2tpY2tfaGFuZGxlcisweDg5LzB4MmIwIFttbHg1X3Zk
cGFdDQo+ICAgcHJvY2Vzc19vbmVfd29yaysweDFlMi8weDNiMA0KPiAgID8gcmVzY3Vlcl90aHJl
YWQrMHgzOTAvMHgzOTANCj4gICB3b3JrZXJfdGhyZWFkKzB4NTAvMHgzYTANCj4gICA/IHJlc2N1
ZXJfdGhyZWFkKzB4MzkwLzB4MzkwDQo+ICAga3RocmVhZCsweGQ2LzB4MTAwDQo+ICAgPyBrdGhy
ZWFkX2NvbXBsZXRlX2FuZF9leGl0KzB4MjAvMHgyMA0KPiAgIHJldF9mcm9tX2ZvcmsrMHgxZi8w
eDMwDQo+ICAgPC9UQVNLPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4NCg0KbWx4NV9nZXRfdnFfZG1hX2RldiBuZWVkcyB0byBtYWRlIHN0YXRp
Yy4gT3RoZXIgdGhhbiB0aGF0Og0KUmV2aWV3ZWQtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPg0KVGVzdGVkLWJ5OiA8ZWxpY0BudmlkaWEuY29tPg0KDQpSZXZpZXdlZC1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+DQpUZXN0ZWQtYnk6IDxlbGljQG52aWRpYS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTEgKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+IGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jDQo+IGluZGV4IDY2MzI2NTFiMWU1NC4uYjBlNzRjMjViZjQ4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gKysrIGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+IEBAIC0yNjgyLDYgKzI2ODIsMTYgQEAg
c3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X21hcChzdHJ1Y3QgdmRwYV9kZXZpY2UNCj4gKnZkZXYs
IHVuc2lnbmVkIGludCBhc2lkLA0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+IA0KPiArc3RydWN0
IGRldmljZSAqbWx4NV9nZXRfdnFfZG1hX2RldihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUx
NiBpZHgpDQo+ICt7DQo+ICsJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYo
dmRldik7DQo+ICsNCj4gKwlpZiAoaXNfY3RybF92cV9pZHgobXZkZXYsIGlkeCkpDQo+ICsJCXJl
dHVybiAmdmRldi0+ZGV2Ow0KPiArDQo+ICsJcmV0dXJuIG12ZGV2LT52ZGV2LmRtYV9kZXY7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9mcmVlKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRl
dih2ZGV2KTsNCj4gQEAgLTI4OTcsNiArMjkwNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRw
YV9jb25maWdfb3BzIG1seDVfdmRwYV9vcHMNCj4gPSB7DQo+ICAJLmdldF9nZW5lcmF0aW9uID0g
bWx4NV92ZHBhX2dldF9nZW5lcmF0aW9uLA0KPiAgCS5zZXRfbWFwID0gbWx4NV92ZHBhX3NldF9t
YXAsDQo+ICAJLnNldF9ncm91cF9hc2lkID0gbWx4NV9zZXRfZ3JvdXBfYXNpZCwNCj4gKwkuZ2V0
X3ZxX2RtYV9kZXYgPSBtbHg1X2dldF92cV9kbWFfZGV2LA0KPiAgCS5mcmVlID0gbWx4NV92ZHBh
X2ZyZWUsDQo+ICAJLnN1c3BlbmQgPSBtbHg1X3ZkcGFfc3VzcGVuZCwNCj4gIH07DQo+IC0tDQo+
IDIuMjUuMQ0KDQo=
