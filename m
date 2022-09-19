Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D945BC345
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiISG75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiISG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:59:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C7299
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGNEiqbwt7/9+WFT6RfMC3T00I1Utxh7ly6icID9rhnD2uDIC+wL6MiieKm8xKyZV+ChOdl2aNanLw8D4aLf8JwhG1nSuWg64RhZvXfmDm78xNhg7Dg/a3QiHBfW2fZawYRSn78albE0Cl9YhyMbY6o53asaqlAJR+hA+V/gefstOcYEsqfgoh9/kM+bkCuEQXTV4IC2ylDN6Ucy6TKEYUQIu0tvufzguyxt+uA9uTAm3ROUQL2X3uF/wgU6mHTtMRXAYLgYmtmJ5YZ9AwGaGMB2p5Ld+VF2b0g+ZW4l7OiwvIgjumlh7VFtxSrg8qIdFbB9O41G2t2K/wCiZqsNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAlrkm2TamWLb6AEGP97m/XQ47qPORH8EybYt3x7/iE=;
 b=AkD97S+s8ltp9eeX0H+1C9Q4hgDn9RwV+xUK7ZANSK4S4jJ8D/bnjldXteMPLFfA0P/VgbQmXlX4scAP0uYyr/Vv/dYnhIgiahAOVr0yHf2BjKrNYX9S3uSA0nfYc0I8eK+HADA2oHKcRytSLr76JxzLIkob2HmQ3EoMefFVTVfIOaBpUqsFgGJ3yL+HJMQfj6eiF1sOUMLNnINBbB5ywdjhCbrP142C3u0eLQ0D2WupGJICIDqXB8Dr+MCFoJT0OK9JdximCehqWif//FGWB6hOqUFbrsQI+fWqGeelRAB2TVVrTJK9xu1h2YMb6MrHqDffeRJwbPbnsUUU4RobwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAlrkm2TamWLb6AEGP97m/XQ47qPORH8EybYt3x7/iE=;
 b=p3cc+mQkpGbJ4FbIZIWoTHWFW5eDsTvYpvceeTM0bvjkpBPgHt5in048zh576eMoEspHcNJh2O/6cCxjqBgJiTvbGCk4oR5F4MtM1OUZa6kyKxhiS9QyE8WPOQ7LHEch5m0DIjobkAqj5uQaF3+k6GLjN53co7tRGxB/+0zKSy7JPh67OEh0d4iSPI8IuThXFU301VYs+cHTNZFetg1dJsEQ23brPGwn9qFKqQfzDyBvxbUNcJIqNQdaPD0DV2gMuAAau2AWQzlXxpT423X2wY8lasJ8iq4es23+N+2rGBVrc45PEnDZUu81bGlzHs8TBY4sjiKKIJKWwmyo+0V43g==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 06:59:27 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 06:59:27 +0000
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
Subject: RE: [PATCH 1/3] vdpa: device feature provisioning
Thread-Topic: [PATCH 1/3] vdpa: device feature provisioning
Thread-Index: AQHYyOBML5FnVXAkVE+O02UXXWksUq3mWIAg
Date:   Mon, 19 Sep 2022 06:59:27 +0000
Message-ID: <DM8PR12MB54008DB26CFA60DEEF2A9181AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
 <20220915085048.12840-2-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-2-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|CO6PR12MB5411:EE_
x-ms-office365-filtering-correlation-id: 86d1624c-723c-4add-b9ca-08da9a0c7e08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+puTld1+RGxq02IC0Kb1j+7OTaCIoiGgqnvu9rZDgMeX/RN6xA9Brsy0CQjzzj2GyVe+RaIsuh58jdo/OYB8kxSAEsKk0SR3HEiJSU87X1KIMiDIRC9keljCRjXSFUnXPPcqHkc0WqeMIa4udowRKhdFz2Eq1DWhyM8Ky6MI+j2cKIzoMsRDNwB9Q7ipbOQN9lxpp7IofGkQBVhBO1kGyi1lY4GDCRQV+PppLqhrax/HOTYe9bdElTt+deScHBmp4/OndZ/dhyIefaDLEXQHPhnBGiR6C8jCUFpjXPt3ubn9KYz2WX+5dtbTw8abFPhGyP5t4yMW6rWRs+/Zf6dAp39YiRoyiR1UOUEIYHD1A1T3/79fH4Qd9nEvpYCycIrddomPhC2i0jW8tMPzwavVm6YbS0917VPrYkJOSj/ab1Vzf3J6D4eNxl7pMHHtjaKW0YN3T8XmztZartH6uRy3/m7B5uGWbRFjm8RjhC3WirYaCcBnhUY7P61PVkE53AZPo7Tysobc710XpkJXx2/fD8e4RbE71u/t3J5btSipW8PszO1ABv1Lf8wuFjtzGK7hXqIozqZxJABXhSwkGKV9L9nHPCOzDHx+5umP2okhrDxHeyIRPghT6ppU1kIuF3wV+Al0hAULj/cEkkZnKSqamcQOEpnjuxRsLe/OiVAkyiXtk9I81lMiRnKsLXrQrv9VSi1FW+z5zkEDIVeFCHZnctavNDtFR6z+i83KUiYlPhAGj5wEAXClv1RGDMNUs7eYrsjrbsVfYW2d+TuT+Jeeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(66946007)(64756008)(66556008)(8676002)(4326008)(66476007)(5660300002)(66446008)(76116006)(7416002)(110136005)(8936002)(54906003)(86362001)(316002)(33656002)(122000001)(38100700002)(83380400001)(52536014)(53546011)(7696005)(6506007)(71200400001)(41300700001)(478600001)(186003)(9686003)(26005)(38070700005)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emNrUUZJY1dvVmRqdmNhY1BycTVxVmNKNU5SbG1IajJNanA3a2Y5S0VUNmE2?=
 =?utf-8?B?b01XaURPemFLSWY3Q203TVp2Mks5c25Hbko5MkpRTEQ3TEFDZEg5NUVPVHdS?=
 =?utf-8?B?bXB3T21iMWxXUVdWNDN6b0lFQld1dmhacjkvRFRldEg4WG9rb3hReHBHdFBM?=
 =?utf-8?B?TkRVdjZKVkU3SHFURXIxeDRZalVQOVZrbVo5U3FITGgydmRyQml0UnRydUhx?=
 =?utf-8?B?eG03bmhmWFVtcmN4U083Tng5dFBSNHpzTVhsa2F2TkY4QkVvalBaaUYvTmlT?=
 =?utf-8?B?RWhsbTBzSHI5QzBxL1ZudCttMDNDTkRCQjY5TlBzN09Hc0NoZWlXaVR5TTd5?=
 =?utf-8?B?eS9xdkFBVmdveTRGYmpkYkpiRWs1QnJoamtLaVBKVmN1T2Fkcm1PNnZUanlM?=
 =?utf-8?B?VWkzSXBYUTFNbm4yclhyMlRhczBGMmFFZlJNMHNOWkZqZmJLYkJoQVorNisw?=
 =?utf-8?B?UU8xSWVjZHZLNFI0UThkOG5kM2JBUDJETFllRnRmQ0pzbGRyVnB5aVNyRURi?=
 =?utf-8?B?ekdvUzVHVVQ4Q0xqWDZzanNPSThjWFhVRVNBTTQvRzNUYlpmdUVUNDBjQ2Zz?=
 =?utf-8?B?N0x5OEVQZVEyN3czbE1xaENXR1pyMmhiTFNuZUs5aXBoNlR0T2Y4U2hHd2Z3?=
 =?utf-8?B?MnlBSjBvRmNuaTdlSHpNc1JNSzhiQXZaTGtjckZ0MVZQdFRXNVZjTnBxWXk3?=
 =?utf-8?B?NHJBbm9JNEtRbm9DcXpPUk92QndHbWJGaXk4UTJXZjlhNmlsU3c4eEZwT1hx?=
 =?utf-8?B?NU1XakFQK0RCVGlxZnZneUFWSkJ2NVFFTlNHdXZST243bjQ4NFllUVg3N1VT?=
 =?utf-8?B?ZzliOTNjRmpIZlhFYjJLNWpLN1psWDJUQlVvM0lpTjNoSEd5bFhqQTNZdHlu?=
 =?utf-8?B?QnUxNlJvZlRzZUNWUU5yWFJ0SFZIaXE0R00vN2lEUkxiV3NMcDRQMEFnVk9Z?=
 =?utf-8?B?QzAxeUtNS3ZQZjZsOElzMlBnZFdSZEUvYytiUVNFbkRDNkVlRk1nVGxITC9J?=
 =?utf-8?B?TXhrRXBERUdNck1yMlJqMEk1aE5WRmJDaWhSeXVOTkZ5QTYwVkNnZlpWUk9T?=
 =?utf-8?B?b3cwUHVBREtyeUVVNVRuQlpnYTJsZDdha1VYRHBmanV2ZnFYMzQ2SGpQWjJT?=
 =?utf-8?B?YjVuQVFibWZiVXVYYnl1Y0xYaWxYczM0UG9SL21tY0VHU2xQUWV0ek9mUnht?=
 =?utf-8?B?bzBFY3AzN01NK25IQ3JZUFc1djNGa3I3OFUrVWNpWFI1NU9MSUdCaWxjcTBo?=
 =?utf-8?B?bUlKRVVzNTZSZVpoTWo0ekNPNWtwbmVXd255ZE1SRUl0WkhWZXZDS01WVHI2?=
 =?utf-8?B?b1BuQkJHMW5BWnpFN3NWanVzcVU1Y0g4bUVCeUtaZWFNanRUTGxYcWNSbFp4?=
 =?utf-8?B?QWljUW16VVVyblAwZVZpdUNObHRvdElXL2VTNyt0SDFrZEpiSlZHU1lkT0dL?=
 =?utf-8?B?YitHSW54NjFaV2RLOXFGY1JORGUwRGFrRWpkUEVyZEtqSVZmZTg2TGdSUDQr?=
 =?utf-8?B?b0ZxQlhrWmlwU2lWVkpGK3VXUm1RcmxxcW44azk3OGtCTi9oWEFSQU05QlJ5?=
 =?utf-8?B?bXZOOVB6NjF1R0hxc1hKL1FmbTBvV2k1OEE0cmZvanVQQVUxdzkxbVA1eStZ?=
 =?utf-8?B?NGsyanp5WEdYaGRPK004RWpydDdVcDdETWJGYjdLZ1RKVzc0bmQ0ZUJSVlpp?=
 =?utf-8?B?ZG45c3dFc2sxSlQ3Y2JZNUdmVFo5akt2cFhvSEdONWQ0alVTeVpIOXk0cWpa?=
 =?utf-8?B?WmVmUld3Njg0bEdiOWJsZTFJZzJGc2Zrd3FQT1BEWkJCMk9VeFUxUlAyWHE3?=
 =?utf-8?B?RVFpRWhGS0hhdUlrUW9Gb3FreERBOGo5NUttZ0UzM2JmTlM0VUpMSk1DOWFP?=
 =?utf-8?B?UXRKNEp0ZElwVFRaUTFrTFJTM2I4U3JJM1B4WjdPV2ZCb1lOMm1aSjJodHo0?=
 =?utf-8?B?OUg0RlBmdmEvRU0xVE5ZTEVxSkVEOTcyWTNQOUZ6SHp0UGJSY1JkTU0rMHlh?=
 =?utf-8?B?aFJ6eHBrK0RxaFM4YytvQWZ4TkxCN2R2Uyt6N3NrQUdyYXJqY0FXYmR0V1Rs?=
 =?utf-8?B?WUhLMTgzUkdsd1d6VEh2Y0RnNXdWRzY3emVpQ21ER3Z6S1VTclF2RjRabUd5?=
 =?utf-8?Q?EPTM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d1624c-723c-4add-b9ca-08da9a0c7e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 06:59:27.0507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxHvQAANxQQ91vmnrAz70ep51haaPClROHW0t+yNh8/WHaUT9V34aURC7xyd7uZ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
SCAxLzNdIHZkcGE6IGRldmljZSBmZWF0dXJlIHByb3Zpc2lvbmluZw0KPiANCj4gVGhpcyBwYXRj
aCBhbGxvd3MgdGhlIGRldmljZSBmZWF0dXJlcyB0byBiZSBwcm92aXNpb25lZCB0aHJvdWdoDQo+
IG5ldGxpbmsuIEEgbmV3IGF0dHJpYnV0ZSBpcyBpbnRyb2R1Y2VkIHRvIGFsbG93IHRoZSB1c2Vy
c3BhY2UgdG8gcGFzcw0KPiBhIDY0Yml0IGRldmljZSBmZWF0dXJlcyBkdXJpbmcgZGV2aWNlIGFk
ZGluZy4NCj4gDQo+IFRoaXMgcHJvdmlkZXMgc2V2ZXJhbCBhZHZhbnRhZ2VzOg0KPiANCj4gLSBB
bGxvdyB0byBwcm92aXNpb24gYSBzdWJzZXQgb2YgdGhlIGZlYXR1cmVzIHRvIGVhc2UgdGhlIGNy
b3NzIHZlbmRvcg0KPiAgIGxpdmUgbWlncmF0aW9uLg0KPiAtIEJldHRlciBkZWJ1Zy1hYmlsaXR5
IGZvciB2RFBBIGZyYW1ld29yayBhbmQgcGFyZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZkcGEvdmRw
YS5jICAgICAgIHwgNSArKysrKw0KPiAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICB8IDEgKw0K
PiAgaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaCB8IDIgKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBi
L2RyaXZlcnMvdmRwYS92ZHBhLmMNCj4gaW5kZXggYzA2YzAyNzA0NDYxLi4yNzhlMjZiZmE0OTIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMNCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGEuYw0KPiBAQCAtNjAwLDYgKzYwMCwxMSBAQCBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rl
dl9hZGRfc2V0X2RvaXQoc3RydWN0DQo+IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGdlbmxfaW5mbyAq
aQ0KPiAgCQl9DQo+ICAJCWNvbmZpZy5tYXNrIHw9DQo+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01BWF9WUVApOw0KPiAgCX0NCj4gKwlpZiAobmxfYXR0cnNbVkRQQV9BVFRSX0RFVl9G
RUFUVVJFU10pIHsNCj4gKwkJY29uZmlnLmRldmljZV9mZWF0dXJlcyA9DQo+ICsJCQlubGFfZ2V0
X3U2NChubF9hdHRyc1tWRFBBX0FUVFJfREVWX0ZFQVRVUkVTXSk7DQo+ICsJCWNvbmZpZy5tYXNr
IHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9GRUFUVVJFUyk7DQo+ICsJfQ0KPiANCj4gIAkvKiBT
a2lwIGNoZWNraW5nIGNhcGFiaWxpdHkgaWYgdXNlciBkaWRuJ3QgcHJlZmVyIHRvIGNvbmZpZ3Vy
ZSBhbnkNCj4gIAkgKiBkZXZpY2UgbmV0d29ya2luZyBhdHRyaWJ1dGVzLiBJdCBpcyBsaWtlbHkg
dGhhdCB1c2VyIG1pZ2h0IGhhdmUgdXNlZA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92
ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaA0KPiBpbmRleCBkMjgyZjQ2NGQyZjEuLjZkMGY1
ZTRlODJjMiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC92ZHBhLmgNCj4gQEAgLTEwNCw2ICsxMDQsNyBAQCBzdHJ1Y3QgdmRwYV9pb3Zh
X3JhbmdlIHsNCj4gIH07DQo+IA0KPiAgc3RydWN0IHZkcGFfZGV2X3NldF9jb25maWcgew0KPiAr
CXU2NCBkZXZpY2VfZmVhdHVyZXM7DQo+ICAJc3RydWN0IHsNCj4gIAkJdTggbWFjW0VUSF9BTEVO
XTsNCj4gIAkJdTE2IG10dTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92ZHBh
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oDQo+IGluZGV4IDI1YzU1Y2FiM2Q3Yy4uOWRj
ODU1ZjM3YzU5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oDQo+ICsr
KyBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmgNCj4gQEAgLTUyLDYgKzUyLDggQEAgZW51bSB2
ZHBhX2F0dHIgew0KPiAgCVZEUEFfQVRUUl9ERVZfVkVORE9SX0FUVFJfTkFNRSwJCS8qIHN0cmlu
ZyAqLw0KPiAgCVZEUEFfQVRUUl9ERVZfVkVORE9SX0FUVFJfVkFMVUUsICAgICAgICAvKiB1NjQg
Ki8NCj4gDQo+ICsJVkRQQV9BVFRSX0RFVl9GRUFUVVJFUywgICAgICAgICAgICAgICAgIC8qIHU2
NCAqLw0KDQpNYXliZSBWRFBBX0FUVFJfREVWX0ZFQVRVUkVTX01BU0sgd291bGQgYmUgbW9yZSBp
bmZvcm1hdGl2ZS4gT3RoZXIgdGhhbiB0aGF0Og0KUmV2aWV3ZWQtYnk6IEVsaSBDb2hlbiA8ZWxp
Y0BudmlkaWEuY29tPg0KDQo+ICsNCj4gIAkvKiBuZXcgYXR0cmlidXRlcyBtdXN0IGJlIGFkZGVk
IGFib3ZlIGhlcmUgKi8NCj4gIAlWRFBBX0FUVFJfTUFYLA0KPiAgfTsNCj4gLS0NCj4gMi4yNS4x
DQoNCg==
