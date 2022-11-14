Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D947627825
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiKNIwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiKNIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:51:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C3B1C915
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZMLVlaFwvSokNw9uq8jVH/dgULSwWiXX3r8ajLWkHqHE/DhfE1Cdf5WW9d6Rtk0LZtQ8EzURv6i7Lsgphc30LpQfSBqgOiJyzy/sgZ+EbYypTxAOHgRGUjkWRcss7bXRbbAAkH0qB9YBHDPI5RD0ZFV3YZvjJ2OdLFtyRbv/UWzVYjG62C2Q5qwX028S+XRwLTFa4tZEdL2wcpymQb55/DxhtYrNA7zCGO0lk7UXrPqiTPaJKbCxfSlohOgm1L/hx9CPkjt15CH75nrk71bUlEwy3KHbfVSvYcSGqTgp89qwHdgDeAtfB67kzQ6yIPr9db2vEMv/civ33+crKPbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxdL+YIRqoCeJEXguKSbx8yeuAfMVOwryJcmea5MyFM=;
 b=L32P/z8HcxWtr6s3+i/36T8aUy0gRqwcA3khprONQqe/T2jMnN9xXcjb9I9WCdiq4pgDOzoFpQ5Jj8tC/IqW0f4qhieGWeL0agmqBB2Q97SHvJ5yECCpojVK1quqerXFDqb15K3rEzD8jCv/jcAAguZEX1FWYEJsFgenQbcjkajEFhb/pnGsZ8zAJSABMvO2LyexSSWMeT1q0qNDVj7QFgy/2V3ZNfiwkPTELJNbroJ/CaSTMN0tS+eY8B1n5aczeVytBrjSUOxiCV3TXx/okvkyZeu9qXy5uIy9Z+jYFNKfVEqb6YLTFKIPxYKg4KCCrIu9TFyB3WZb5t9fpf5aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxdL+YIRqoCeJEXguKSbx8yeuAfMVOwryJcmea5MyFM=;
 b=E/OgwnVakNAabyWrgapqNrYqLAk+yvcbt3pNqm7OuPks/81bpcGAxoVLx1A2meo0sQMvYRyYstL45bBipNi5jHiJiJP8HYlpo1e8vbXjVqxmoWjBkGbnG5k8M4DQOkRvk9A1JRE7vSP2LgKb2Jiyz8+2ZyJwD5NlgdPqf1We2dRMG7nWUiUsaUvepesqiz39pJU6zE3EaigTwxde1KxPCZaroTIDRPoKbRadOsIoFFNZjO3GHyVzRVfejwJWA89z4+dAC7nCkXO8r51roRhefbSQnlnynV3UJvg4u4cumeJOEqKXGmqEneYggvu4PfdbE0pADzQVR58NDbuBMY7oSA==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 08:51:51 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:51:50 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 5/7] vdpa/mlx5: Add RX counters to debugfs
Thread-Topic: [PATCH 5/7] vdpa/mlx5: Add RX counters to debugfs
Thread-Index: AQHY92YqsUnL2XgtVk6gf0puegqTZa4+BhoAgAAXrfA=
Date:   Mon, 14 Nov 2022 08:51:50 +0000
Message-ID: <DM8PR12MB54001B5DA44D89A0948378A9AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-6-elic@nvidia.com>
 <CACGkMEs4YpUUtkW-rWkQpYQY4vFLh2YcwY6bSqUGTd60Xq37_w@mail.gmail.com>
In-Reply-To: <CACGkMEs4YpUUtkW-rWkQpYQY4vFLh2YcwY6bSqUGTd60Xq37_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|MN0PR12MB5860:EE_
x-ms-office365-filtering-correlation-id: b2145902-8778-4feb-1c7f-08dac61d78c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaSOpHqSRzgH4HuHA++plUhMf574CdYUsYeeGK/i2X1yGSlOwTu+SnNjukNXYQLWq5NO6hbYc5GvUbC82yRp5XV+HK6AsxBkkaGpwMc9y/WRZU6XZbr7oYfnZgYVTJmkXlpIWsVvFYwTWztmDyqGZQphrsR5szpx6nU74zdwJf6DI59CEisUA/SCEF1+1LXZYo/Flfx/KUi5Aquls6d8gy1Y1Q4d/uHEd6QcVO8q9vUuiTdUB9ELk6Ekkr+B/pLjzhr3JhikGVrTpIyaHjVDWp+bzP/PX3hGh4D10RYltoAWFu8ITw7hRhX94N/heor3s6Hx3zqkgFo2dOYxYIqSWn+RBQMxSZUfJ4JCxFyOiCfoRD1hm6otP6ZR3xQCksoFbf6DeCeKOUcrRZP5KBS79FuJxJdFGzjOiazvi5vbUAdunTBmaEJdn8AYecWliUHKbv7ZQLh5hlBdsl7gABWKv3GGgTGpT+7T+khcODjKopr9mUCkqWRlYNSnirP/+Ss4NwotOP7F8WIDNb4N4C49KQ+ylprizn0Fi605CPgTezkbhBFFkrG/28SuHfb5wYDiUuqLM0Ok0oKgBajZLFkgT7DpVuUL4r9jKu1QH6vZLoW1/N+iCZIlU4//yvlkW0SIVAr/FzTpUvN2xBVTlHIyaBCjJM/tvpMgLgaqunOrfKrujUV1ku0YMfHeBhIvDDUW8iqEctzxjPBCg3TgZ7BRX8mp2S03nPUPBuwPW1m78Aqgm2jD8iaoExpxolbasHrT9ZEoaGPJyAmStpR8da9YRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(26005)(316002)(9686003)(53546011)(2906002)(33656002)(83380400001)(38070700005)(41300700001)(66476007)(66946007)(66556008)(66446008)(4326008)(64756008)(186003)(76116006)(5660300002)(55016003)(8676002)(8936002)(52536014)(86362001)(38100700002)(71200400001)(478600001)(7696005)(6506007)(6916009)(54906003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1J4MWlTVWMrMmh5VjdMWXlzYU01WTAwckg4aDdsQ3JuUUtxOTNrVWFLUG1w?=
 =?utf-8?B?M2hpSEhIUER1blBpbEFGcFJaYzNQUjBRQVVJdTBMVTJEWEt1ZkNQSGg3WXhH?=
 =?utf-8?B?enZUS081NVNTSkE2TVVKU0V1d0VwRE4wS0JlL0l1VUkyeXBCb0UzaWtYblVP?=
 =?utf-8?B?YnVPZkhyR3pabjRaTDQ2Ykp2VUZFYkxhSlYwZ2RPV21iRVo2U2ZrYTdISTZl?=
 =?utf-8?B?MlpWMzR2LzVwMXdBRlQ1VlNRN01jNnFUeGFhRi81ZUZWSHZSRmE5b3lwUXJ5?=
 =?utf-8?B?eHR3R3FZc3Q2M3VZL2UrNFlWSndXdE5SVVl6MDVESmM5cEpqWnpGUy94RFRG?=
 =?utf-8?B?MXFEMmt1OFJNSSs2NmYvcGpVVldkaERRcGJER0p0UGdlU3pJa0VnbVM0SUZP?=
 =?utf-8?B?RnZDYnRBUUZaLzFma2I2dWNPTjU1cFRTQTN1VUY5RzVpME05bkc1WlVnQU1x?=
 =?utf-8?B?RHJoUDRic1ZNQ2gwWHhFTld3M0dBL2JNMUd6SStrMGsvVXArM1grZDFJM1Mw?=
 =?utf-8?B?aWFhTWVwVjArMlQvYW54M1k0eFVXSGQ4K2JNdDIyY3hTUllpWVdIM2pvTFl3?=
 =?utf-8?B?ek9PTlE0S3JOanNZR2hwOVRMaFg1UzhMSEd3U2xaemlLTGZCRWh6NlEwT0dF?=
 =?utf-8?B?d3VlMklZK1hZVWlrUU8xR0pjSm1wc2RBTk1zTHFKV2orenQ4ekRyVDcvS3Zs?=
 =?utf-8?B?U3JoM1o3cDlCM2pobldKa2c5ZVg1ZkR6OVlkN0czTjZlOTcrMjRYV2dmbGpN?=
 =?utf-8?B?Nm5GT25COUVqbUlEUTJPWEpQZE9JdFRYOWRFRngyOWNSQVFUUUFyKzVzZGgv?=
 =?utf-8?B?UVJSNkhxYnNhM2t2YmtSUlhjdSthcTExVEVmT0lmTm92SUUyWC9uellzQUlB?=
 =?utf-8?B?VVUzYTZkcUY1S1V2aitRekp2U1B6ZzBCcEpiOWV2NklaaDBmb0NhTHZsRjVw?=
 =?utf-8?B?dGZIbFJlaTBEelJTVit4VXNYbXJwUjZ1bExvRVB1aGM0bG01L0YrbVp2dEwx?=
 =?utf-8?B?TlpmUm9INXB2ZG5YOExIVm9KZm5BdEQ2MGRvaVMrditSNm91LzJFYU4xS29P?=
 =?utf-8?B?bytmdjFlbUhiSWFNM1hVSFU1RjhySk5mMjI1aEYwaFFGa1IzR1JYZktsYnFx?=
 =?utf-8?B?TU01SXhIb2IzY3p5WFNOL28zbWRpMWMzK0s0dlBETXRrcUs0aDR1bXgxVU1w?=
 =?utf-8?B?UWM4SnBvMHZxYzJBRk80bDR0ajNQRVo2SzlMNnBhQUlBVkJKQkJUejkrd0Vh?=
 =?utf-8?B?TU5RN3JicEplRVc3a2Q2NEFaNUc3RHZ0bnl0TXVVQUZrL2FWczBCc1NpVGFu?=
 =?utf-8?B?SVh6N1ZVK1lTdnhjZm4vb3k1V1dSTklVWnlCWmpaNDEyRHY0TWZMUUIxL1Fi?=
 =?utf-8?B?T1p6TjNRMEFkMnl5d0M0VmRlMGUrM3N1MmM5M3hrT0dkTEFJRXdLTERkYlB3?=
 =?utf-8?B?dzNkV1J4d1JwVURXbmh5Nm1hWE5pSVlxRWFxcjVRYWhKVHhXSVBoMVhNeGE3?=
 =?utf-8?B?eUpQV3VNaEpXbnhDNWxON3VBMlM1MWl0UXYzbjd1ejNyWFh0TTJRQXFnRUVm?=
 =?utf-8?B?SW9VeGFRakViSDk5VlNOQWtCOVI1TWp1ZTk2Q0hhS3VTTDlUUDAzUk9oeXA1?=
 =?utf-8?B?RzJVekVNVXJJQ1JxVVJKRTJsSWMzdCsveTRCVFY1R1ppdk42aWVpYk9xTGNK?=
 =?utf-8?B?L2xZYStkcDIyQUFOVTVBeHZtS0NSZ2JUZ0VPUUNhSDBXYmJneSt4azRvakZG?=
 =?utf-8?B?ZFBkcTFDTFE0NDU1Y1RDWWViVi9ocTNBTlRxalpqckVmYldoYmk5U0pvSEdx?=
 =?utf-8?B?UU1tMXczeG5QUEFxVXR6bExkTXhrb08xRXlvWjVyRDJZVG5pcGVUN1FIeUNy?=
 =?utf-8?B?ZTFwK1pVejI3bkNid3R0bnJJZkdqaXRaYTB6MzlZdmlTT3Y1L2YzYVpMSnFC?=
 =?utf-8?B?MnJTeTN4UVZUWlZ0MzRGKzdMaG5xaC9pTVNFNDFuYmd6Zmh1Ty8vYnlaclNq?=
 =?utf-8?B?dlRWcG5YaVlYcmRVOXV3dnYwT2hxV2czY3BrTmJhV205SFNudVpCNXZpL21o?=
 =?utf-8?B?WVlETXJLaW95ZVRXazNKNWgySnY5OEIvYVJST3BjWlNwOWhjTkpsUktDaVNQ?=
 =?utf-8?Q?rJXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2145902-8778-4feb-1c7f-08dac61d78c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 08:51:50.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ln9i2jmvN0VSIuYXG1Wmv8ygdJVGgHBcDWOYDX8sQyiU8fVG8h2IVqCuwwinQPL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXks
IDE0IE5vdmVtYmVyIDIwMjIgOToyNw0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgdmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBzaS13ZWkubGl1QG9y
YWNsZS5jb207IGVwZXJlem1hQHJlZGhhdC5jb207DQo+IGx1bHVAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDUvN10gdmRwYS9tbHg1OiBBZGQgUlggY291bnRlcnMgdG8gZGVidWdm
cw0KPiANCj4gT24gU3VuLCBOb3YgMTMsIDIwMjIgYXQgOTo0NSBQTSBFbGkgQ29oZW4gPGVsaWNA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGb3IgZWFjaCBpbnRlcmZhY2UsIGVpdGhlciBW
TEFOIHRhZ2dlZCBvciB1bnRhZ2dlZCwgYWRkIHR3byBoYXJkd2FyZQ0KPiA+IGNvdW50ZXJzOiBv
bmUgZm9yIHVuaWNhc3QgYW5kIGFub3RoZXIgZm9yIG11bHRpY2FzdC4gVGhlIGNvdW50ZXJzIGNv
dW50DQo+ID4gUlggcGFja2V0cyBhbmQgYnl0ZXMgYW5kIGNhbiBiZSByZWFkIHRocm91Z2ggZGVi
dWdmczoNCj4gPg0KPiA+ICQgY2F0IC9zeXMva2VybmVsL2RlYnVnL21seDUvbWx4NV9jb3JlLnNm
LjEvdmRwYS0NCj4gMC9yeC91bnRhZ2dlZC9tY2FzdC9wYWNrZXRzDQo+ID4gJCBjYXQgL3N5cy9r
ZXJuZWwvZGVidWcvbWx4NS9tbHg1X2NvcmUuc2YuMS92ZHBhLQ0KPiAwL3J4L3VudGFnZ2VkL3Vj
YXN0L2J5dGVzDQo+ID4NCj4gPiBUaGlzIGZlYXR1cmUgaXMgY29udHJvbGxlZCB2aWEgdGhlIGNv
bmZpZyBvcHRpb24NCj4gPiBNTFg1X1ZEUEFfU1RFRVJJTkdfREVCVUcuIEl0IGlzIG9mZiBieSBk
ZWZhdWx0IGFzIGl0IG1heSBoYXZlIHNvbWUNCj4gPiBpbXBhY3Qgb24gcGVyZm9ybWFuY2UuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICAgIHwgIDEyICsrKw0KPiA+
ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvZGVidWcuYyAgICAgfCAgODYgKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxMTggKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuaCB8ICAzMCArKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNl
cnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKyAg
ICAgICB2aWQgPSBrZXkydmlkKG5vZGUtPm1hY3ZsYW4pOw0KPiA+ICAgICAgICAgc3BlYy0+bWF0
Y2hfY3JpdGVyaWFfZW5hYmxlID0gTUxYNV9NQVRDSF9PVVRFUl9IRUFERVJTOw0KPiA+ICAgICAg
ICAgaGVhZGVyc19jID0gTUxYNV9BRERSX09GKGZ0ZV9tYXRjaF9wYXJhbSwgc3BlYy0+bWF0Y2hf
Y3JpdGVyaWEsDQo+IG91dGVyX2hlYWRlcnMpOw0KPiA+ICAgICAgICAgaGVhZGVyc192ID0gTUxY
NV9BRERSX09GKGZ0ZV9tYXRjaF9wYXJhbSwgc3BlYy0+bWF0Y2hfdmFsdWUsDQo+IG91dGVyX2hl
YWRlcnMpOw0KPiA+IEBAIC0xNDMwLDQ4ICsxNDc1LDYyIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X2FkZF9tYWNfdmxhbl9ydWxlcyhzdHJ1Y3QNCj4gbWx4NV92ZHBhX25ldCAqbmRldiwgdTggKm1h
YywNCj4gPiAgICAgICAgIGRtYWNfdiA9IE1MWDVfQUREUl9PRihmdGVfbWF0Y2hfcGFyYW0sIGhl
YWRlcnNfdiwNCj4gb3V0ZXJfaGVhZGVycy5kbWFjXzQ3XzE2KTsNCj4gPiAgICAgICAgIGV0aF9i
cm9hZGNhc3RfYWRkcihkbWFjX2MpOw0KPiA+ICAgICAgICAgZXRoZXJfYWRkcl9jb3B5KGRtYWNf
diwgbWFjKTsNCj4gPiAtICAgICAgIGlmIChuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgJiBW
SVJUSU9fTkVUX0ZfQ1RSTF9WTEFOKSB7DQo+ID4gKyAgICAgICBpZiAobmRldi0+bXZkZXYuYWN0
dWFsX2ZlYXR1cmVzICYNCj4gQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WTEFOKSkgew0KPiAN
Cj4gDQo+IFRoaXMgc2VlbXMgbGlrZSBhIGZpeCBmb3IgcGF0Y2ggMT8gSWYgeWVzLCBsZXQncyBq
dXN0IHNxdWFzaCB0aGlzLg0KU3VyZSwgdGhhbmtzLg0KPiANCj4gVGhhbmtzDQoNCg==
