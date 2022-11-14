Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA762760C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiKNGog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiKNGoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:44:32 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA173E58
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:44:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Noii4WB29oxcB+cVPK+rk7CtzSPHeNVtz8RJfjZaAvGBpAJP+6EA5AztThGiHuy+Gh201q4gcUrRR5HM1eCfliL0Iga/TEqmk4TwJL/CsiSOsCpFq72l9SdfpSJnqU+ijOqQmF40YeWjAIEw7ZVG+KKtyfRs7+V56ONyBF92cEZxKvezvTpbHToDt0LPwhsjn9JPAaMNsQJ2AjMJzScDZqymyMoPji+PmrOzet3OQK6pw9aFtMNDH9/61t7HhVfyFAU13qCIcJwZf6VDxufzVNaE44df4e1xGQGSbstcQ+HjclNL4UnK84I0qsNzqKcVrqhMCSwlemCXm39ka/9I/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3GyKhO0/esqKTAQvVo+T5VYrU/n5+Oh/7bUNJrRQZo=;
 b=IwGRzI49WjR97wFStlEuHagInBqksRc4Mo6b6GiH3FrPbemunWtpyhVZ72wDlUa6Xj5K/JA4BkLCCtOcRpQbGzHcq0mwwOxNgIKpEjnE42sAD9Q+cE7t3dEIVpPif/jiW8RA+u2V6r7HwHYosaEICI97itSiIxTutmxu7sz67h7e0Wslqtn5NmEbe/2b11uOSL7bXBOayCr4ddf9MSCryVEjduLXaHAZY5oZyuF7Yg8nTMCbriw35KggvGeKl2bz/2sm5VK9uikCPn2ZfRbNE2LW7MJYOahoBq1eJyTaUAzrXRK2Vg4tJNAR1Lqy2z0sVrMP6f9M+yO+jbI4y2owXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3GyKhO0/esqKTAQvVo+T5VYrU/n5+Oh/7bUNJrRQZo=;
 b=Yx7/oBf/MnnRMjJwV91gAewVbCi0+HjNNgsDY8ijC0fGwOx6+emZYNJJ1AxKF1D+b/y/pz35iDq2ESEbsiBFfZQK/sSJrdzUmeB8c8CGsIWoNf/hap5PM5m3P5KIl33iVF5idwtQt1qjXgpzE4i64Lt3zLnEjETTh5CcQUqvFb4tBbW9XOad9rOveuJARLaee2kIJNErctPp6WEp11Lp/C8kOlgkksN2IUPQeOF7+q4E/hRnLcSjR+DtV9+Ey8bw1or3WgHLD/V/3eULHPxOt5idYfqjn0+bKSXJGyZ8mImR3LOeNTNFcGY6tP6HYLtca1bXBaQVwFdGMkyp8K7C2A==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 06:44:30 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 06:44:30 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Topic: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Index: AQHY92Yko8iGoP1kJUuMoxi80YSfj6491zQAgAAi87A=
Date:   Mon, 14 Nov 2022 06:44:30 +0000
Message-ID: <DM8PR12MB54006C35F5CDB250CA757108AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-2-elic@nvidia.com>
 <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
In-Reply-To: <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DM4PR12MB5231:EE_
x-ms-office365-filtering-correlation-id: fcdb586a-f6f3-4c87-c769-08dac60baeba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8zS6G1/PfGvgImknCvRzJ+0rmgyYuulPHW+9FX9VDWBaUQbrFU7OVC0G+Jzp289psPJPMl3imdx0/HYS7UJUMT9222zO4XEWeCu8Q4H4P1JvRrHymOIITfI6EEzmJD/r25haLclnwzHpffZoYCT3S87Ufx1C95CqF/H7/7HWH3enNk1TQF8JROLajsRTwM87zqElc2tkrEXQ05L/o3a/D7hVvR1kSF7fsZGSyST3aiuV2Ozp9Go8GAyTTnwcR9pae5cVTbBAq3imY78VKBjfYJHcGnY8sNDUznIYah0V9AkS/VI66xejP9Djbc0R4i7tW507tXqf3+csaexSXSApjyQpBTj3iE7BydiAD1jBsNFf6NL4BN7IrnCNtUV7UMNHS142dqEJxmXgsnqpy23bPlaMFPArjkur+iecvR+ha+ohysmRfFJdWedJmd6Eam93OeyECP2+ki5B/81qhJeGVg676+pWTOJnfvk40JgOpZhqq/LyHTQlOc6rqr6BbGyRkIFhMH/Y4GNZILCeA1wZhyfqhrKl1eI2yVdcShO7fDqZwlvSO92HwTYpGfudKHtnUNDLUA2m/a1MXpTO8Cr+iT1oQtiWixkmERBvLPvHnQbF+h9keV3G24ndLHOcFnDvcM7gslcG5YF/yH/PhDnMfaBFhO9cgnj0LX2Uw3WTUzCI+0kVgWZMGxEJ+ooy3NpgP3H2TTiDUtjREm9oFVavipdXZTg3EqbjOxJDClm2ukEYjaFyaNg5//Fx3uRvsUNl5gP1vsndPTDQ/GuEMvHnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(55016003)(83380400001)(9686003)(53546011)(6506007)(26005)(38100700002)(186003)(7696005)(122000001)(8936002)(2906002)(5660300002)(52536014)(71200400001)(478600001)(8676002)(66476007)(64756008)(66946007)(66556008)(66446008)(76116006)(4326008)(54906003)(41300700001)(316002)(6916009)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjF6SHRyeXhjSmtuSHJqTWp1aEx5NEtYUEtPcWt1cjBCT3pZaWpjZXlaaVZR?=
 =?utf-8?B?RGNUQWlQaFNCRE5VZUlYWXM1MVhSN1BVM2JoRWdmclN6bk5xQjkxY2ZDOVdB?=
 =?utf-8?B?Rk9jL0ZISVJoT1Ixd1VDWlRrWWljNFBzajFVK0JOMWZwL1RoU1Noa0VrbG1D?=
 =?utf-8?B?MlRsZGJHUFN3SmFmd3J0SU9vQlIwSDAvcWg4YUpYNmYzbG5TM3F6QkNTU2hX?=
 =?utf-8?B?NlpnMG1FUGUrNyt5MFhmcGJ1VzY5SS9TY0VYaDdGZkludCtRb1B1UEpnZHFo?=
 =?utf-8?B?TXIxL3NVcDVTaHJwQkxMNVRNeVFaM1hUTGt6aVVGYkZZbTdnQ21QVjEwWHdM?=
 =?utf-8?B?b3FEQXRiWU4vWkVpV2N0K3dvMU9LVTRQMXRaL3o1UmpLRTZLeFkxOFcrS3c2?=
 =?utf-8?B?QkhWdVlaNlhDMWI5ZjZmMjV4cWdvN2pFYVQ4TXNBc2RseXJlbDl0QXBXR25q?=
 =?utf-8?B?NDNnQVVZTHBKeW1iUlZ4M3VUVFFnMUxXTkVHeU1USGZsTEU3Z2xZM2l0OTZh?=
 =?utf-8?B?Z0NEcTlESnArZDRObk9obVVRVFVya1cwZUVVSXgyb0NxT09qQmcycWx2R2Zz?=
 =?utf-8?B?VXpOb1hMMWtRTkZHWVhlLzk0SXAyNTc5YUpsTFgyVWpRV2VwTzliMlNuWm1G?=
 =?utf-8?B?N3F6WlJJcXhFUSs4RGdNZ0Q4RTc0WEpSeFZIbE9rdGVMVXV3YWcrdVM3RHBK?=
 =?utf-8?B?dFNxbGVVNmVkM2V1R0ZwMU94ZnpCVUdPZkh5eVRjOVJ0WGRMMEVQams5ODho?=
 =?utf-8?B?UWpQUjB6V043ZGgyMlRzaE1pcTRjZTBpaEtDRVZrOTFFNC9IQnBGTE9kQ1Ur?=
 =?utf-8?B?MGhqODlDRXhhTHBmVm1wM3F3bjgzaWZiQ1ZrdC8yZ1pWejlPWCsyYXQvb3ov?=
 =?utf-8?B?TnVxZGN1RzkyN1VwbTFHdmtlSnJXR08rblIvcmIyVjBreUtUVEFCM1RReTRk?=
 =?utf-8?B?RVpxcGFzYUxHUUNnVGlMODBDZitNSTJYelRnOU0rczBZU2ZGY3ROQ1IzM3pm?=
 =?utf-8?B?YXhXQWVkV210MFN6KzBpZTVyNjJIcmZDUGQxdUV6bXlkak5IbUlDUVE3NDVn?=
 =?utf-8?B?MGZEWE1DM2w4anNRa2oxeCtMYXJ3VkNNZkwxQWVhK0NjOTBrOG9QOHdyaU5z?=
 =?utf-8?B?em10eFdBTTMyOUQ2dTRzMXZhRHNoOUd4cXA3c1lsRmo5bHBxbThYM29RQ25k?=
 =?utf-8?B?VFJyeVRkcUZITmpYdExMQVFjdk9jU29keXNvcDhISXJzaThCdXpORE5ZUmEv?=
 =?utf-8?B?cXRpQ3ZRYzBocktpbWQ0MHQ2MXhPd0tlYUVMWWEwTmovVEpXa3NCV1lWYzdh?=
 =?utf-8?B?NDZJVnliWjBZNElkSCtEZExhSWRxL0psOEpiVHV1RlZFSDhOZkdybnJjalps?=
 =?utf-8?B?cUxtZ1VQTklIR2tMOWI3SVFramNQaUdneUc2NFg3T25KWXdzK2EyVnU0NUtL?=
 =?utf-8?B?U3dXQmtCa0RPa2hkL2Z6ck1ETytqN2svbzlWY29BNWJISlp1a1NOOXN1NWVl?=
 =?utf-8?B?NUo1bFlJZDhMaHduK3NSdkxPK3Y4WjlZa0lWMW5Sa1BGYk5hU1B3RUV1clBT?=
 =?utf-8?B?VWZKcWpkRGVTODRaWHl4cSswVXk1OC9rd0dkQ3pzcnBCaFBSL3BMcDhsazJx?=
 =?utf-8?B?RHZRYTJTUFFFZlFSNUM1OG5JYWRVbzFYeU9XdTNTQTh4NEhPenA3RHF3RlRF?=
 =?utf-8?B?R0lMSi9WaUxpNzY3eE5xT3RNNGdLU0dRWjlYRzZ3VDNuZVYvQlN3ZXdzSXVQ?=
 =?utf-8?B?THdTZ2liNG83aGNWL3pkRWNwUXg1RUVtV0RRK2tRWUZHRU81N0ZEcFBvaXlx?=
 =?utf-8?B?ZFpLeUVQem1rNlIrSnVxV21xQ1lFWGVhdTZVdEprcWtrbkFKb0R6K1BCUjFI?=
 =?utf-8?B?aFZmRHBvdmJxWXl5Ykl0V1l4bEZwMm9Zamttc0MranZzRkNGb24zdjJHNk4z?=
 =?utf-8?B?dkVNOWdzYVpydTJvaFhLZXRNZHU4T2tDRmNsNjdOdjBJL3N2ZmZTVWY3ZzFX?=
 =?utf-8?B?azVnMlNTMElLTHdNVkUyNFN5d3lNMDZtQUd4Q3NxTkdGQVdkTUt6eUJFTGhJ?=
 =?utf-8?B?aFdJZFBGSEp5R2NIZ1A4L3JGMjBJSnBmcW9tNGZ2ckIyWFRublhxSHY1dGNl?=
 =?utf-8?Q?gfhc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdb586a-f6f3-4c87-c769-08dac60baeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 06:44:30.4137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpfNFOlu+/QirgETMBBYhqadofZmy5tOwW58mEAAM4B9llMZB5j2smfpXCa3EO2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
IDE0IE5vdmVtYmVyIDIwMjIgNjozOQ0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgdmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBzaS13ZWkubGl1QG9y
YWNsZS5jb207IGVwZXJlem1hQHJlZGhhdC5jb207DQo+IGx1bHVAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvN10gdmRwYS9tbHg1OiBGaXggcnVsZSBmb3J3YXJkaW5nIFZMQU4g
dG8gVElSDQo+IA0KPiBPbiBTdW4sIE5vdiAxMywgMjAyMiBhdCA5OjQ1IFBNIEVsaSBDb2hlbiA8
ZWxpY0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNldCB0aGUgVkxBTiBpZCB0byB0aGUg
aGVhZGVyIHZhbHVlcyBmaWVsZCBpbnN0ZWFkIG9mIG92ZXJ3cml0aW5nIHRoZQ0KPiA+IGhlYWRl
cnMgY3JpdGVyaWEgZmllbGQuDQo+ID4NCj4gPiBCZWZvcmUgdGhpcyBmaXgsIFZMQU4gZmlsdGVy
aW5nIHdvdWxkIG5vdCByZWFsbHkgd29yayBhbmQgdGFnZ2VkIHBhY2tldHMNCj4gPiB3b3VsZCBi
ZSBmb3J3YXJkZWQgdW5maWx0ZXJlZCB0byB0aGUgVElSLg0KPiA+DQo+ID4gSW4gYWRkaXRpb24g
bW9kaWZ5IHRoZSBsb2dpYyBzbyB0aGF0IFZMQU4gZmlsdGVyaW5nIGlzIGVuZm9yY2VkIG9ubHkN
Cj4gPiB3aGVuIFZJUlRJT19ORVRfRl9DVFJMX1ZMQU4gaXMgbmVnb3RpYXRlZC4gV2hlbiBub3Qg
bmVnb3RpYXRlZCwgYWxsDQo+ID4gaW5jb21pbmcgdHJhZmZpYyBpcyBhY2NlcHRlZCBhcyBsb25n
IGFzIGl0IGlzIHRhcmdldGluZyB0aGUgbmV0IGRldmljZSdzDQo+ID4gTUFDIGFkZHJlc3MuDQo+
ID4NCj4gPiBGaXhlczogYmFmMmFkM2Y2YTk4ICgidmRwYS9tbHg1OiBBZGQgUlggTUFDIFZMQU4g
ZmlsdGVyIHN1cHBvcnQiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyB8IDExICsrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jDQo+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
DQo+ID4gaW5kZXggOTA5MTMzNjVkZWY0Li5lYTk1MDgxZWNhMGMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4gQEAgLTE0NjgsMTEgKzE0NjgsMTMgQEAgc3RhdGlj
IGludCBtbHg1X3ZkcGFfYWRkX21hY192bGFuX3J1bGVzKHN0cnVjdA0KPiBtbHg1X3ZkcGFfbmV0
ICpuZGV2LCB1OCAqbWFjLA0KPiA+ICAgICAgICAgZG1hY192ID0gTUxYNV9BRERSX09GKGZ0ZV9t
YXRjaF9wYXJhbSwgaGVhZGVyc192LA0KPiBvdXRlcl9oZWFkZXJzLmRtYWNfNDdfMTYpOw0KPiA+
ICAgICAgICAgZXRoX2Jyb2FkY2FzdF9hZGRyKGRtYWNfYyk7DQo+ID4gICAgICAgICBldGhlcl9h
ZGRyX2NvcHkoZG1hY192LCBtYWMpOw0KPiA+IC0gICAgICAgTUxYNV9TRVQoZnRlX21hdGNoX3Nl
dF9seXJfMl80LCBoZWFkZXJzX2MsIGN2bGFuX3RhZywgMSk7DQo+ID4gKyAgICAgICBpZiAobmRl
di0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzICYgVklSVElPX05FVF9GX0NUUkxfVkxBTikgew0KPiA+
ICsgICAgICAgICAgICAgICBNTFg1X1NFVChmdGVfbWF0Y2hfc2V0X2x5cl8yXzQsIGhlYWRlcnNf
YywgY3ZsYW5fdGFnLCAxKTsNCj4gPiArICAgICAgICAgICAgICAgTUxYNV9TRVRfVE9fT05FUyhm
dGVfbWF0Y2hfc2V0X2x5cl8yXzQsIGhlYWRlcnNfYywgZmlyc3RfdmlkKTsNCj4gPiArICAgICAg
IH0NCj4gPiAgICAgICAgIGlmICh0YWdnZWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgTUxYNV9T
RVQoZnRlX21hdGNoX3NldF9seXJfMl80LCBoZWFkZXJzX3YsIGN2bGFuX3RhZywgMSk7DQo+ID4g
LSAgICAgICAgICAgICAgIE1MWDVfU0VUX1RPX09ORVMoZnRlX21hdGNoX3NldF9seXJfMl80LCBo
ZWFkZXJzX2MsIGZpcnN0X3ZpZCk7DQo+ID4gLSAgICAgICAgICAgICAgIE1MWDVfU0VUKGZ0ZV9t
YXRjaF9zZXRfbHlyXzJfNCwgaGVhZGVyc19jLCBmaXJzdF92aWQsIHZpZCk7DQo+ID4gKyAgICAg
ICAgICAgICAgIE1MWDVfU0VUKGZ0ZV9tYXRjaF9zZXRfbHlyXzJfNCwgaGVhZGVyc192LCBmaXJz
dF92aWQsIHZpZCk7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAgICBmbG93X2FjdC5hY3Rpb24g
PSBNTFg1X0ZMT1dfQ09OVEVYVF9BQ1RJT05fRldEX0RFU1Q7DQo+ID4gICAgICAgICBkZXN0LnR5
cGUgPSBNTFg1X0ZMT1dfREVTVElOQVRJT05fVFlQRV9USVI7DQo+ID4gQEAgLTE4MjEsNiArMTgy
Myw5IEBAIHN0YXRpYyB2aXJ0aW9fbmV0X2N0cmxfYWNrIGhhbmRsZV9jdHJsX3ZsYW4oc3RydWN0
DQo+IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1OCBjbWQpDQo+ID4gICAgICAgICBzaXplX3QgcmVh
ZDsNCj4gPiAgICAgICAgIHUxNiBpZDsNCj4gPg0KPiA+ICsgICAgICAgaWYgKCEobmRldi0+bXZk
ZXYuYWN0dWFsX2ZlYXR1cmVzICYNCj4gQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WTEFOKSkp
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBzdGF0dXM7DQo+IA0KPiBOaXQ6IHRoaXMgc2Vl
bXMgdW5yZWxhdGVkIHRvIHRoZSBwYXRjaC4NCj4gDQpXaWxsIHB1dCBpbiBhbm90aGVyIHBhdGNo
DQoNCj4gT3RoZXIgdGhhbiB0aGlzLg0KPiANCj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+IA0KPiA+ICsNCj4gPiAgICAgICAgIHN3aXRjaCAoY21kKSB7DQo+
ID4gICAgICAgICBjYXNlIFZJUlRJT19ORVRfQ1RSTF9WTEFOX0FERDoNCj4gPiAgICAgICAgICAg
ICAgICAgcmVhZCA9IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmY3ZxLT52cmluZywgJmN2cS0+cmlv
diwgJnZsYW4sDQo+IHNpemVvZih2bGFuKSk7DQo+ID4gLS0NCj4gPiAyLjM4LjENCj4gPg0KDQo=
