Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64FA5BC353
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiISHFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiISHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:05:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBE140B9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+lwWOr6x8gtofXDxIJ1EPQ+gncAHd7yX2rEV9XDNBqt6IEEe0JXdZWaKcM1QEdAPIpUSbq6TeDcSlD6XSq6w9gfszvdjUPl6zCNVwSUcVv+cEMSJrGH7keR9120km+e1F9CYnWNjAZdUoK4dJ08XqNgB9wvv5xg7NfJ8Z6SUMrc3GrtN7Ttuq0yQI9CZB5OwXxrIjrUIL8BIX3KPwSL9+Sy2zW/+Kfd2PgHQMxPRxa5xfsfd3q0lG2NIXQ+km9RsI/89RW/rcLNRn/0nwLWIoSeAUfPmRVVW/uxu5fSJpf7npAKmN/5HUK9HXLUXZIqJ83y0Y9ncIiiaPqay19tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/9HOCH45YtikcPdSz3tdo3friP6HSyUQXno8Eix1jQ=;
 b=DznvJwA+sPvNPwh63irS9mshz4om6KOrYL2Zrp34c/sMyF6Z5WokrMn1Z1YUDJ2C7yIzUed3voMmUXkfru1zrWsGFNkHv/b6NPxhVq91LbYvDzGZH9HtF0ugND/ZDWFoUyIo/z42KcKVjrQRmRiE4pd8toCsg+6HkL8Me9diQ0ZX7NWjYYu4vL3D4RFgFd4G+27YtXAJd8qMExAjNPq08rd37mVv76vyZxJukjwhTkG3CkPOtQZAk5idmU7TkQOQOsYw4BM5A0PGYtL2KcofJkJ3r5cHTNb/hlazvNqVb996cp6LL446cEM/KmwQD6S8L3VERb4R/zsS+Regb3pzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/9HOCH45YtikcPdSz3tdo3friP6HSyUQXno8Eix1jQ=;
 b=ZXAg0rB/ruFelAbnvrZ6p6QfDc/tpinhwH03P1bzN5+YEHdIc5K/2gLhm7cvKqm0bu9YbTrSfVgdBvX67UAkTgdyW2885z8+EsOd7M7hh6amP9bKkd6OcQE5MIElcC39Nr6Wsqcfhj7lcaPCrGhgTTDISf/P5I2WA3lo3rka47m9eEO6KChQCwBT00Wiz1s090xIikCnwTh0tXObwjGcEVZjUivC3vRsj8GrLYWvtSyiSW5BrhfFNslrZdizAf5lbeTbWpc80bIGExDJcV2ZiPlwDW/SH4Wi27WDQhk8hAXWqOR9yelFsDBFBzc/Y9roBFUJY/I1bp+TXtu4CoUxyg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 07:05:12 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 07:05:12 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Subject: RE: [PATCH 3/3] vp_vdpa: support feature provisioning
Thread-Topic: [PATCH 3/3] vp_vdpa: support feature provisioning
Thread-Index: AQHYyOBTnTc4N7nO402aAw298tWvH63mWm5w
Date:   Mon, 19 Sep 2022 07:05:12 +0000
Message-ID: <DM8PR12MB54006A97A99515542260B5D6AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
 <20220915085048.12840-4-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-4-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DS0PR12MB7632:EE_
x-ms-office365-filtering-correlation-id: f5e76393-02e5-45c8-4d81-08da9a0d4bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnXq7kV0k4PFUAOSiYgJ9eZAZGFTzJ19PiNxPXMx6KoKMLAY2LMPkb4Y2cKr5LQFMcbE45ZWVzJXxFXgK9eVb1RQCoFl75ovQGdOO8xhKGJppMtcHLfj4QOeqz1Gxg40G8Sdq/mK4d8pk4+H6ClJijZi9+fGetvK3cmrJRYEWPH9NeYa3MkDdeggdiTmpBziMhZqfJ6NmJBrgzsnqzp7mS54D4EOw54gBSOKAczMG9Q7QaW7x4Ono4QgD+8Zyn+H2c4wR/70hgs44EtpEthU5EsCbzlP08hpNXuljB6A5nCFmRg+bqpwgIStD3x5T95/tnBTgQqdlP0jjh8UI2M5L39iwUPvbNAPJHtBxoj5WhPRHOTmdrCp9QRizDcRDWBpsOxSNQRSl7WuR3GFLAuAVW+gqBqA+KjnKZaQFIviHVFX/rCIaOMb4SIEx1F/xNO38Zlcc5OS+k0FdNXXNvEFt+gOK2H+CadlfYcvhYDIPH78pPSOvYQT53rmcAKOya01LF1G0tvwJqC2+pybPDVzp9bztRfkafuLRXE/mHIPPbeXDSBBp4zoPTJHECpcLLIBJ2NU1VxwK2JEce7sijFpEOfijqgDA4g+WDo7jwETla2+vJViuaKg19uCm4MR4BczIH6NdQEu/Dc2/pUJnYRntohMYeCSo6brxOLPW9DmoSe/cCLtFr9/EdCp51fC6uPyke3p4967D1Z/iPh6E4mw+SNL+sZUUFk2VfIU+VMOtPTMzU0Lbt00xUJBfaP1JsG90x4Wiq0d6STDynXifGc+5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(38070700005)(6506007)(4326008)(7696005)(2906002)(71200400001)(86362001)(55016003)(53546011)(8936002)(9686003)(26005)(76116006)(38100700002)(66556008)(33656002)(66476007)(66446008)(8676002)(122000001)(66946007)(64756008)(41300700001)(478600001)(110136005)(83380400001)(186003)(5660300002)(54906003)(52536014)(316002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnZYNWJRQk5QL1JZNzlJdVk2UlJ1Q2xqQzZiZ3NxYjY1eWFlOVBFN2M4c3BX?=
 =?utf-8?B?aHNNZ3c2TFh5N0k2Rks3VkNReUJ2N2tSR2dPNlRnd3REZUdENWxnTTFkZm1V?=
 =?utf-8?B?ajNVek10eVdTWmJkYU5Qbm5iVW1iazhsWG1sV1lucTVEWU44UWIwVFRFaW9Y?=
 =?utf-8?B?dFpjamppNDBVQnVmWi8rc3N1YS9BSDN0dFpKNlQwL0xBWnpzM3ZQQ1lTM3pG?=
 =?utf-8?B?VmttRUpiMWsvbWRqRk9IRjJub1ZjTnZrSUNVR1VJdGN4VG9aQkxjdUhCWHhV?=
 =?utf-8?B?d0U1a3ZqeEhqK1hMTTNWWmt6YzA4RCtMOFdIb0QrcjR1OUpKYjF0LytnRGln?=
 =?utf-8?B?SlozNWlNMnFoWFd0RzJWaTVqeFIyOVVVeE5VNWxIUlhLVUt6UWhyZDQ3b2d5?=
 =?utf-8?B?TTN1d09kM3N5a29pTU1CNGl1eTIrQjF6UmUwV3RnWHNWSDFVSkxYMHZXNDRl?=
 =?utf-8?B?K0dEMGJQQ2hVckNiRHhDZGxYdFRtb2FiRDk2TVo1MzBDVjJWd0YvQnUxZ0Rj?=
 =?utf-8?B?Q2RiZkFiY0JiYXZtSGVYTVF5NXRFaEpNOUFEWVlucjVBNzRyamVyM2tjMWpu?=
 =?utf-8?B?YWtvVTF4ZG9QMi9iaytqb0w2Yko4VHp5Y1pLUEUxY00xQTIxUmdTRDc3YmEx?=
 =?utf-8?B?MlFsVkpHMnVxZG10WTg3UW1pTmlzWHVXU2VlZHZ1ZEhHSEpEU2ErWkVNQ0RG?=
 =?utf-8?B?NkR4eWNkZVo2bmdmUHN6NmlsbURsdWlXNy96SEhCMjR2NVZoeE5GU0EzR0FN?=
 =?utf-8?B?K0tONCtoZHpoK0pzc1NFSTMzVUV3cVpwOXZHb0QycnRReGJ6SkU4a2ZTYndk?=
 =?utf-8?B?N3RBa3B6REE1NHBpdllERXBZQTFRWm9sYStNdW1ta2dINk55K3dSd0Y0S1hT?=
 =?utf-8?B?Z0tmeEpuNExUTzI1NnpyZHFYL0tuZTJvUEgxVGpMaVBKbzFlN1AyMTlmQWFC?=
 =?utf-8?B?VUhtR2ljUjBIbTVxTUNxL2JSWUdkcFVYSmlJOVIzY3hCR2Y5WUdOU0dIeDg1?=
 =?utf-8?B?cGxWSi8wQ01YWUVDUFY1akhsZGhFanhHYmprUjlGRlF2b2VLMHBwTHZUQ2Qy?=
 =?utf-8?B?aklGNEJjblM2YUZoQnZtYUxYZTFFYXBtcE55b0Y0bVhubXdueEYyaTVvcEp2?=
 =?utf-8?B?WGJtYjFjaSsyek1lQWhKNVZHeVp1bDVIclA2ekxFU2lOVlNqWnIyYWFwL0pF?=
 =?utf-8?B?a1kwM000Wml1L1JIbGl0Y3pKc1A3RW13dHpqRzFKNFBna0FURFk1NEZHK3Y5?=
 =?utf-8?B?d1RhRTIrY1ExZGFadUo2MFVJRU5lOFdPQ29KaHRXTHpEeWQycWhaaURNRmZV?=
 =?utf-8?B?ZUl1UGpaWTNqSndnd29WOHN4RTRkQnpXcm1NUGFTTnhGWjhrcE9sUGw5ekFi?=
 =?utf-8?B?QWU1UDhGV1ZzTFFHeUpmQSsvZzJxZlhSOUQzcmkwTHlGYXJneXlEaUZnTzBx?=
 =?utf-8?B?THBLcS83M2MraWtuYUtyVzh4ak1qNno5S3dRb2UwS0xzYjIvUjZiNUswSlFZ?=
 =?utf-8?B?VFFzOG83NmNiM2RkZG1JNmtycytNVVpuNzZVeG5ZbFZlWG1MTVVQV2xQMytR?=
 =?utf-8?B?Uk8vdDIxT0w3OUUzNlhobk1qYlNLZkJsV1JXVXhmdVE2N0RHdmdoQi9Zd2FW?=
 =?utf-8?B?L202T29lL1UrZHZWM3dLL2JBUWtMeXVwUFlRTjJQQ1c3ZVFnNmNmMXJpL05D?=
 =?utf-8?B?K21ZMWtZZ3VmZFQ1RE1udmlJYW8zZlQ1YjdDdjNrYUhPY3MyY2QvZ2RXdFRN?=
 =?utf-8?B?b0xudlJEL1JmUlhzamV6bDdiSGhvNkc4Z2Z3NHNwVWNwTmxaejJka285dm5N?=
 =?utf-8?B?NkgreFBqQlhXSkVJK1UwZ25EeDg2Mmk4VDZFKzZyMGRpOGNJc01pNWI5b0I4?=
 =?utf-8?B?S2xKUFN2QTVmZzRoNXV5c2VxZUZWK1NLZC9aMlp6VENNLzRFSDlaQzJIci9D?=
 =?utf-8?B?d1h3S2hBSDh2LzdvbHlVM1EwZjJVZTUzRnk4VXJFYjJMYjBJdE9mWUxQQXBo?=
 =?utf-8?B?TTJsUDJTR3FkS2ppMGJEdU04QVdKUlhlNUhYRG56WWhPUVBBVEhRTmsyWnFV?=
 =?utf-8?B?a2c0VVN5QVhkYUI1T0p5K0lkb1NpSk5sTVpjQ3B2Q0IyUHRPakxNT2k2SnBw?=
 =?utf-8?Q?XnOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e76393-02e5-45c8-4d81-08da9a0d4bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 07:05:12.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8Ex+TlHYIcOaUKDhbqAJB/Oh6jzL4iHN5W8UytQxBNR0azYHOwGaRaQxWZSSPh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgMTUgU2VwdGVtYmVyIDIwMjIgMTE6NTENCj4gVG86IG1zdEByZWRoYXQuY29tOyBqYXNvd2Fu
Z0ByZWRoYXQuY29tDQo+IENjOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT47IHNpLXdlaS5s
aXVAb3JhY2xlLmNvbTsgUGFyYXYgUGFuZGl0DQo+IDxwYXJhdkBudmlkaWEuY29tPjsgd3V6b25n
eW9uZ0BsaW51eC5hbGliYWJhLmNvbTsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGVwZXJlem1hQHJl
ZGhhdC5jb207IGxpbmdzaGFuLnpodUBpbnRlbC5jb207IGdkYXdhckB4aWxpbnguY29tOw0KPiBs
dWx1QHJlZGhhdC5jb207IHhpZXlvbmdqaUBieXRlZGFuY2UuY29tDQo+IFN1YmplY3Q6IFtQQVRD
SCAzLzNdIHZwX3ZkcGE6IHN1cHBvcnQgZmVhdHVyZSBwcm92aXNpb25pbmcNCj4gDQo+IFRoaXMg
cGF0Y2ggYWxsb3dzIHRoZSBkZXZpY2UgZmVhdHVyZXMgdG8gYmUgcHJvdmlzaW9uZWQgdmlhDQo+
IG5ldGxpbmsuIFRoaXMgaXMgZG9uZSBieToNCj4gDQo+IDEpIHZhbGlkYXRpbmcgdGhlIHByb3Zp
c2lvbmVkIGZlYXR1cmVzIHRvIGJlIGEgc3Vic2V0IG9mIHRoZSBwYXJlbnQNCj4gICAgZmVhdHVy
ZXMuDQo+IDIpIGNsZWFyaW5nIHRoZSBmZWF0dXJlcyB0aGF0IGlzIG5vdCB3YW50ZWQgYnkgdGhl
IHVzZXJzcGFjZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCAx
NiArKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3Bj
aS92cF92ZHBhLmMNCj4gYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gaW5k
ZXggMDQ1MjIwNzc3MzViLi40YjI4ZTBjOTViYTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmRw
YS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYw0KPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92
cF92ZHBhLmMNCj4gQEAgLTE3LDYgKzE3LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC92aXJ0aW9f
cmluZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19wY2kuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC92aXJ0aW9fcGNpX21vZGVybi5oPg0KPiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmRwYS5o
Pg0KPiANCj4gICNkZWZpbmUgVlBfVkRQQV9RVUVVRV9NQVggMjU2DQo+ICAjZGVmaW5lIFZQX1ZE
UEFfRFJJVkVSX05BTUUgInZwX3ZkcGEiDQo+IEBAIC0zNSw2ICszNiw3IEBAIHN0cnVjdCB2cF92
ZHBhIHsNCj4gIAlzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2Ow0KPiAgCXN0
cnVjdCB2cF92cmluZyAqdnJpbmc7DQo+ICAJc3RydWN0IHZkcGFfY2FsbGJhY2sgY29uZmlnX2Ni
Ow0KPiArCXU2NCBkZXZpY2VfZmVhdHVyZXM7DQo+ICAJY2hhciBtc2l4X25hbWVbVlBfVkRQQV9O
QU1FX1NJWkVdOw0KPiAgCWludCBjb25maWdfaXJxOw0KPiAgCWludCBxdWV1ZXM7DQo+IEBAIC02
Niw5ICs2OCw5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlDQo+ICp2
cF92ZHBhX3RvX21kZXYoc3RydWN0IHZwX3ZkcGEgKnZwX3ZkcGEpDQo+IA0KPiAgc3RhdGljIHU2
NCB2cF92ZHBhX2dldF9kZXZpY2VfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQ0K
PiAgew0KPiAtCXN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYgPSB2ZHBhX3Rv
X21kZXYodmRwYSk7DQo+ICsJc3RydWN0IHZwX3ZkcGEgKnZwX3ZkcGEgPSB2ZHBhX3RvX3ZwKHZk
cGEpOw0KPiANCj4gLQlyZXR1cm4gdnBfbW9kZXJuX2dldF9mZWF0dXJlcyhtZGV2KTsNCj4gKwly
ZXR1cm4gdnBfdmRwYS0+ZGV2aWNlX2ZlYXR1cmVzOw0KPiAgfQ0KDQpVbnJlbGF0ZWQgdG8gdGhp
cyBwYXRjaC4gTWF5YmUgcHV0IGluIGFub3RoZXIgcGF0Y2g/DQoNCj4gDQo+ICBzdGF0aWMgaW50
IHZwX3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2
NA0KPiBmZWF0dXJlcykNCj4gQEAgLTQ3NSw2ICs0NzcsNyBAQCBzdGF0aWMgaW50IHZwX3ZkcGFf
ZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2Rldg0KPiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1l
LA0KPiAgCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gbWRldi0+cGNpX2RldjsNCj4gIAlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCB2cF92ZHBhICp2cF92ZHBhID0g
TlVMTDsNCj4gKwl1NjQgZGV2aWNlX2ZlYXR1cmVzOw0KPiAgCWludCByZXQsIGk7DQo+IA0KPiAg
CXZwX3ZkcGEgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwNCj4gQEAg
LTQ5MSw2ICs0OTQsMTQgQEAgc3RhdGljIGludCB2cF92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFf
bWdtdF9kZXYNCj4gKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwNCj4gIAl2cF92ZHBhLT5xdWV1
ZXMgPSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldik7DQo+ICAJdnBfdmRwYS0+bWRldiA9
IG1kZXY7DQo+IA0KPiArCWRldmljZV9mZWF0dXJlcyA9IHZwX21vZGVybl9nZXRfZmVhdHVyZXMo
bWRldik7DQo+ICsJaWYgKGFkZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZf
RkVBVFVSRVMpKSB7DQo+ICsJCWlmIChhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJiB+ZGV2
aWNlX2ZlYXR1cmVzKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCWRldmljZV9mZWF0dXJl
cyAmPSBhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXM7DQo+ICsJfQ0KPiArCXZwX3ZkcGEtPmRl
dmljZV9mZWF0dXJlcyA9IGRldmljZV9mZWF0dXJlczsNCj4gKw0KPiAgCXJldCA9IGRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldChkZXYsIHZwX3ZkcGFfZnJlZV9pcnFfdmVjdG9ycywNCj4gcGRldik7
DQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+IEBAIC01OTksNiAr
NjEwLDcgQEAgc3RhdGljIGludCB2cF92ZHBhX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBj
b25zdA0KPiBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpDQo+ICAJbWd0ZGV2LT5pZF90YWJsZSA9
IG1kZXZfaWQ7DQo+ICAJbWd0ZGV2LT5tYXhfc3VwcG9ydGVkX3ZxcyA9DQo+IHZwX21vZGVybl9n
ZXRfbnVtX3F1ZXVlcyhtZGV2KTsNCj4gIAltZ3RkZXYtPnN1cHBvcnRlZF9mZWF0dXJlcyA9IHZw
X21vZGVybl9nZXRfZmVhdHVyZXMobWRldik7DQo+ICsJbWd0ZGV2LT5jb25maWdfYXR0cl9tYXNr
ID0gKDEgPDwgVkRQQV9BVFRSX0RFVl9GRUFUVVJFUyk7DQo+ICAJcGNpX3NldF9tYXN0ZXIocGRl
dik7DQo+ICAJcGNpX3NldF9kcnZkYXRhKHBkZXYsIHZwX3ZkcGFfbWd0ZGV2KTsNCj4gDQo+IC0t
DQo+IDIuMjUuMQ0KDQo=
