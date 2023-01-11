Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1D6665CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbjAKNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbjAKNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:35:42 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8265CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOS49av0x2n156tknvWWtn9OurAAGhtgEIE2jytJw3Ke6jcxb9969srP1K3OqRC8ewpmmdGtGr+BmTU1KHWGpZHixF5lsint7bdmDsLWylEwbyMibTuKS8EjcOeloeus/TF4DyzJ80ePILMAy71Hh47DLkipBH3Wh3XH2L1TiPEl9reF2Tn6mvlejbYaUFJ4MYHyHOhU0n4U3ZNzs91YiBa3sPUjafZ9HnSn1XTn6PTUDUULzDwcrH9a4HBKZz4YW9IfICIJULdbwXXB9YyKXsarH2ACTeMVozyiylx5Fvp2jRQcXpVRCUWQIL8MS6QrOaEVCe984RGRgCxAHotuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHcfGl9FigzsIq6PAuisZsNIUthW2eA9FcsVnHFFUxk=;
 b=JMKEwWmuf6zJEnJMM8XOMg80E/l10nvFiRw85oy98uN3tUJ3VUdfQGzcJ9/u6pKkUsCi5QqLWLslHCNhvgzl4sNdwzk876ZlA0XkzPSG6ZNhWfh0bOEslETTYxx1ZiKa7JjYf0JmS4hs94aCVZkpUUOBbzBad4vOvlOSPAR06nXfS/sK6Htd1JVnvec+9IxdHORgM9PtFK6YhWxgrUyfc8rsqRWxcfQbJVfw62+pnrEg4tssJVmqLdBubXp7XLw7rQzHMi97TD7PNE8aINPj5eTOi8oZC0Dqz96MaEWxhAXmz8wVISJ0OHLZfR8wRDszw9+LLr+UmPqRHqtC7sY5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHcfGl9FigzsIq6PAuisZsNIUthW2eA9FcsVnHFFUxk=;
 b=umExfq4Y8ef+KNCOlbCCyw1XA6pJJGjUgO3++QjUKsGXsXWHBQJUC3Cbn6LzsfsGen4oWRbiZq5GGiulIhCKwcGH8S1OoB5LKKE/Z+VQZudwPhTD4YDImWIZT3k90ZNgurW9KfqlNPW0fptDtvlSzO1aAyc49MOMoClAxshTnDJDVvJTB8cX4Lyu5lMn8cnHcV6KBsyhagkvVCIG9MbTjLV/vD8Z8+XFJeQBcKxylsPOKnGaANzjjuAgZEICPwNduAikECRglK00plFuI1nuwciFYVwSV3wRigUfg/GQr74dM4W7L9+vsBkfTokzAE8ygGeAqqdzODFQpQSzMx9m+A==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH3PR12MB7761.namprd12.prod.outlook.com (2603:10b6:610:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 13:33:34 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 13:33:34 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: RE: [PATCH 0/5] virtio_ring: per virtqueue DMA device
Thread-Topic: [PATCH 0/5] virtio_ring: per virtqueue DMA device
Thread-Index: AQHZJYXlMPXyn1LjCEyARft/stK1Yq6ZN2iA
Date:   Wed, 11 Jan 2023 13:33:34 +0000
Message-ID: <DM8PR12MB540054712BACEF34E065C2BBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CH3PR12MB7761:EE_
x-ms-office365-filtering-correlation-id: 606f169b-5f4b-4542-bebb-08daf3d87031
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0hTG+76UhyTIcK6ukjVsd/cbwA5GVOYH++QWASrlSPnTvZcqfVo7buUH78ngtJyWszPqrKGZAgqJTrJSFUcC0zErAEc5bDQuLedqE0Flsvfw0ormyL3l5gC7M9LBTwe7yrENnbui7IaDwZZTM9vid1ahCi109b574QbYVuOUANx11tRDACou2znVg+I3ELa0fjJrPCSODeQvoyBlVqF+Ag3eOLp1XzM+6Mxmm8VgIItW2ze1IEtGwKTcztWijiDxu0jJs2nkU39peUzisrwcInBh0CfDK2/qyhauudoY2NdMdTGlXrCjlFNvXmoS+MvypxcjNnOjnryaFs5p6nH4rvp3vk0lwjPVRx2w631ww2I5UEsv7/6zX45V0eXnSwoki1CA+b4CtgkzvSRxny4ivuH5wx8Gd6oLeO5DC0J2Vjgt2CIJoM0OLbYvNcBeJ+/7P23Eogci7R6bs/z34DxWgMohd9L7W6mc2x9Yx6SJBgC8CQBsqViZYc0wLL4hyo7W0t1I1ZFitQT00uTX5OTjmEODaUX05QlR2dyREv6BJ643tr1qASjHRbeSWhUbaxJbyrxe6uOoPcpfaMrew2RNV2FBewe0JqZ9pwBcZCmVt0BFAsIKpN2lT65E0kuitxdY7i1uRlUF65UZEs4gx1vPbvScqQaBgdK+4jrDGgvojBe4m4yPVGk1cMMiOgkhwKG7dM6Mpu424pKSVz8/98vxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(41300700001)(6506007)(8936002)(5660300002)(2906002)(52536014)(53546011)(83380400001)(66556008)(33656002)(66476007)(66946007)(66446008)(8676002)(71200400001)(76116006)(4326008)(122000001)(38100700002)(38070700005)(316002)(7696005)(54906003)(478600001)(64756008)(110136005)(55016003)(86362001)(26005)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?empubUpIcWYwK3JvN0ZQMlc1TVltbkhYTTF2WXdJNVRYdGoxN1gxZmVjSVJZ?=
 =?utf-8?B?eEZ2cithZ2N3ZDdNMkErNm1od3pCZisvS3d5Ty8rK3RhN2tNOGJwMjRVYUts?=
 =?utf-8?B?cjhBanptOG91djVMZHRFckQ5U2x5YitLZWU1b25IaS9MTkNBUGpleWV3dm5z?=
 =?utf-8?B?cS9HeDVGdFRvdEtCd1NkMHBoUnR4bHQ1ZWRIZXNkU3NaemJvMlo0NWl4TXc4?=
 =?utf-8?B?M3hZRFJKMXlpRW5tZnNiajNLWDRydXpDbHRqc2c0aFlDMU9BRDg3NzFiUU5q?=
 =?utf-8?B?d1dIaXlReDQycmxQcVlNd29UaEFmVnJHR29BZzFXTHdCMDh3VW5mUE56QlZk?=
 =?utf-8?B?Qm5QTU9ERnhEcHhzdDFaR1NoazByRk9WSW44ZVpybU1KdlkvTzNLemtCTndl?=
 =?utf-8?B?YTJCQW03TTMycUV2bjRkbnZjVDltV0lMbUMzbzF2eHU0Y3VpU1NZdDVmeVBm?=
 =?utf-8?B?K2dYT2JCWExhbGsvY29wT1pSaTN3TTVmNnFXUXo4K1MvWWVQTjBrZlJ3bGRp?=
 =?utf-8?B?cFBFekFnbE5tV21oWk1Ka2xPaWhvRkljaS8zUlN6bDVWS2tNYkYyUUxSeTdS?=
 =?utf-8?B?RGNqZTBxZTladlh2TGZtZ3hEeTVqeFpSRXRnV3VpY2dwRC8zekRST0VjdVBr?=
 =?utf-8?B?QkJrK09TTVYya0dBZlQvelZVSC8wQzRBRGd4emt5c3d1VTZ0WVpqQ1M2b051?=
 =?utf-8?B?MytpREpkZ2FzY2dySEMzVlBVOHZUK3RnU3lNNm91MTdOc09tbFlxdm5UNTBN?=
 =?utf-8?B?TjZpVmRYU1dKSXRKZVNZQTV3eFlPZDRXVjlCV09XcmtoaXAyWi9Da2l5RWJY?=
 =?utf-8?B?MVNaZUEyaVkrb1ZPMTMwekw0MU5UZ3VaaU16ZDZubG9DT0VMVlljbm1UcUM2?=
 =?utf-8?B?Vzl2QldhdFBjVUhHSHpxS3ZubGRXaGJjWmxWazB4Rm11ZkdmQzFneVJBNDVN?=
 =?utf-8?B?TEdweGgrR3o1d1lvSWZSbmN1c2NrSU1hYXVCdFVBc0lHWWJZS3VQUUs1WmZj?=
 =?utf-8?B?TjM3blVoaUFtTmVXMWl4T3lLM3JTMVNNc0NSa0I5YkVHTHcycmdaV05TWWNX?=
 =?utf-8?B?aENaTWsrMWlURnY5YUxuazRxdXFOWUpuc3BLYU1CV0c1RzJLOG9EVW81T0xx?=
 =?utf-8?B?dFZvWUszWHl0YTFrSFJFVkQ4UE80akt4SlkweDZldFBhT0IyVUVBcG1HdTAw?=
 =?utf-8?B?b25NZ0FGQlBMbzZRY3Zuc25mR21Zc2R0UFNlNUJDQ29jbHRMRzg2ZnIvaCta?=
 =?utf-8?B?NE1YeXJEQXkvelVDSkpnVVk1YzJUV2RrQjRoWjdGajh3M2w2TEZjS2szT1h5?=
 =?utf-8?B?TFlKSVROS0pPeWdCYkpzbzFGWjg1YXNZT3h6R2l0VDFqWVlPN1NZdU1ESEdP?=
 =?utf-8?B?UDJPcXlnVEpJQVdhVWxrUzBaZ1YwTE92ckRYNGRLWDU4SGkzMWpDVEFxemRh?=
 =?utf-8?B?OHpWSjJhOTF2OGx0VERvMTl6MzdjQTNpcnpNOVdMTjJ0THhzMC9tM3crallJ?=
 =?utf-8?B?cytTWlh1SlB4S2ppRzFDWVUxUlVTaHpWYi81Mm4rMjdibkJqQXMxZ1oxRTdn?=
 =?utf-8?B?TWxCSFF0VFRJU2FZQ25sZUFXYzRCS0VNSTV3ZE93UjQ5L254VU84bjNrd1Fa?=
 =?utf-8?B?WGxiRkE2NlJxU0swS242QWkwQXg2Q1ZCakFvdWRJL05GZEpVSmlsWlFhR0kw?=
 =?utf-8?B?T3hKTGpQelV2Y05EVjZKSThNb0hSS2ZITUxuNzhkNUtvSE5waWthNGxoVEdi?=
 =?utf-8?B?NXdjU2FtUnFiSytFaS9admxSdU9HbHZ0dVVPTUNkemRTaEJqd1NRVFpXZTR3?=
 =?utf-8?B?TUlIbEg4TXZuaXJSUjBZNVF1YW9QQUg2Qlg3WnVlY2o3Nml4TjdoUnhVcXFH?=
 =?utf-8?B?d3Z0TE9MMEVVRU12NFBDY3VYTWcwUUFLTlNGcHNpT2Yxb05ES1Ura0doT3lu?=
 =?utf-8?B?M3M0KzFaS3J2MllYT29uNXYyUklWd2sxZVEvb2laRE8zcGJwNksvdHdtSndB?=
 =?utf-8?B?dTYveEhoMFZhdHhBblNTYVJ4ZlpGUzdUVWVPcGFuWlFPWGZmNTVKRHNWbHNS?=
 =?utf-8?B?OXMxQ0ZJd2s1UXFidCsyRElEenJjTW5sazVGc1NJRFJMMDhhUHB1OWdXbzJ4?=
 =?utf-8?Q?4lII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606f169b-5f4b-4542-bebb-08daf3d87031
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 13:33:34.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kmuf2VsaQuT+mV9fwG2NAvvWwgUTYx/RuBQI8+8zeY4sX/PPtfEwRxiDlb9+l/Hi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
dDogW1BBVENIIDAvNV0gdmlydGlvX3Jpbmc6IHBlciB2aXJ0cXVldWUgRE1BIGRldmljZQ0KPiAN
Cj4gSGkgQWxsOg0KPiANCj4gSW4gc29tZSBjYXNlcywgdGhlIHZpcnRxdWV1ZSBjb3VsZCBiZSBi
YWNrZWQgYnkgZGlmZmVyZW50IGRldmljZXMuIE9uZQ0KPiBleGFtcGxlIGlzIHRoYXQgaW4gdGhl
IGNhc2Ugb2YgdkRQQSBzb21lIHBhcmVudCBtYXkgZW11YWx0ZSB2aXJ0cXVldWUNCj4gdmlhIHZy
aW5naC4gSW4gdGhpcyBjYXNlLCBpdCB3b3VsZCBiZSB3cm9uZyBpZiB3ZSBzdGljayB3aXRoIHRo
ZQ0KPiBwaHlzaWNhbCBETUEgZGV2aWNlIGZvciBzb2Z0d2FyZSBlbXVsYXRlZCBkZXZpY2UsIHNp
bmNlIHRoZXJlJ3Mgbm8NCj4gZWFzeSB3YXkgZm9yIHZyaW5naCB0byBrbm93IGFib3V0IHRoZSBo
YXJkd2FyZSBJT01NVSBtYXBwaW5ncy4NCj4gDQo+IFNvIHRoaXMgc2VyaWVzIHRyaWVzIHRvIGlu
dHJvZHVjZSBwZXIgdmlydHF1ZXVlIERNQSBkZXZpY2UsIHRoZW4NCj4gc29mdHdhcmUgdmlydHF1
ZXVlcyBjYW4gdXRpbGl6ZSB0aGUgdHJhbnNwb3J0IHNwZWNpZmljIG1ldGhvZCB0bw0KPiBhc3Np
Z24gYXBwcm9waXJhdGUgRE1BIGRldmljZS4NCj4gDQo+IFRoaXMgZml4ZXMgdGhlIGNyYXNoIG9m
IG1seDVfdmRwYSArIHZpcnRpb192ZHBhIHdoZW4gcGxhdGZvcm0gSU9NTVUgaXMNCj4gZW5hYmxl
ZCBidXQgbm90IGluIHRoZSBwYXNzdGhyb3VnaCBtb2RlLiBUaGUgcmVhc29uIGZvciB0aGUgY3Jh
c2ggaXMNCj4gdGhhdCB0aGUgdmlyaXRvX3JpbmcgdHJpZXMgdG8gbWFwIHRoZSBjb250cm9sIHZp
cnRxdWV1ZSBpbnRvIHBsYXRmb3JtDQo+IElPTU1VIGJ1dCB0aGUgdnJpbmdoIGFzc3VtZXMgYSBk
aXJlY3QgbWFwcGluZyAoUEEgYXMgSU9WQSkuIFRoaXMgaXMNCj4gZml4ZWQgYnkgYWR2ZXRpc2Ug
dGhlIHZEUEEgZGV2aWNlIHRoYXQgZG9lc250IGRvIERNQSAod2l0aG91dCBhIERNQQ0KPiBvcHMp
LiBTbyBETUEgQVBJIGNhbiBnbyB3aXRoIHRoZSBkaXJlY3QgbWFwcGluZyB0aGVuIHRoZSB2cmlu
Z2ggd2lsbA0KPiBiZSBoYXBweSBzaW5jZSBtbHg1X3ZkcGEgYXNzdWVtcyBhIGRpcmVjdC9pZGVu
dGljYWwgbWFwcGluZyBieQ0KPiBkZWZhdWx0Lg0KPiANCg0KQ291bGQgeW91IHByb3ZpZGUgaW5z
dHJ1Y3Rpb25zIGhvdyB0byByZXByb2R1Y2UgdGhlIGNyYXNoIHlvdSB3ZXJlIHNlZWluZz8NCg0K
PiBQbGVhc2UgcmV2aWV3Lg0KPiANCj4gVGhhbmtzDQo+IA0KPiBKYXNvbiBXYW5nICg1KToNCj4g
ICB2aXJ0aW9fcmluZzogcGVyIHZpcnRxdWV1ZSBkbWEgZGV2aWNlDQo+ICAgdmRwYTogaW50cm9k
dWNlIGdldF92cV9kbWFfZGV2aWNlKCkNCj4gICB2aXJ0aW8tdmRwYTogc3VwcG9ydCBwZXIgdnEg
ZG1hIGRldmljZQ0KPiAgIHZkcGE6IHNldCBkbWEgbWFzayBmb3IgdkRQQSBkZXZpY2UNCj4gICB2
ZHBhOiBtbHg1OiBzdXBwb3J0IHBlciB2aXJ0cXVldWUgZG1hIGRldmljZQ0KPiANCj4gIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICAxMSArKysNCj4gIGRyaXZlcnMvdmRwYS92
ZHBhLmMgICAgICAgICAgICAgICB8ICAgNSArKw0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyAgICAgIHwgMTMzICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAgIHwgIDEzICsrLQ0KPiAgaW5jbHVkZS9saW51eC92
ZHBhLmggICAgICAgICAgICAgIHwgICA2ICsrDQo+ICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19yaW5n
LmggICAgICAgfCAgMTYgKysrKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAxNDEgaW5zZXJ0aW9ucygr
KSwgNDMgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjI1LjENCg0K
