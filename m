Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D4627851
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiKNI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiKNI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:58:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBD81C434
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnOKEtdEuSqHHbVgar4qLUHY7oIax6tMZ+PIefKobvIWmRPC2SCXrrwr/QMsL0BxAmf5aDpa6xuF9d9kXSrNK9FDVuH1VXbroujdwPJTMB7Z4sZvjh/Z+v4e6PyIQYi/HkDA1AGX9yiHoMdYPndKiKtAZPYXteiopaqVthVzmee9jXaCHEnqYQCmSFQoyF6Nm0zU1BJBKCUg/G7MzJFBgTAYX0CBT3Wv5wfcPev1AfGiJ7klMVEMfWjLSmE6zTLBARl+oX/dT1RN0ts1xJqizrijWildIxqk0Ij8plIQHZNu/t0ryEE6J1vZYILD+TNp/7I94ixtCHCYn6dIo6orjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29uzU+X4w1SKhzcSnR9SDV3ndKA349kBSBXifBxZ8EU=;
 b=W2XaUOZlBspZhJMrsrS1EogV4ZrGI7awo6turohEXFToQEoksPg7vytcMrusttWP4e6K+eyJomkDJaxKYqcq/kKXNlG3hO4RABW62ihOIqVCCDUxtxSfL+Y0mJ6QPi901BBPUnDvm8LpsDPRTPlw/m2sc4IscRfMeSj1g+wMW+s8emFzyw32YbRr4sqMZSysVTe9hqxsxpILfz++qrxyv9SbAkBUTiW5ByrbjfwIzFtRroigViyn1Dm5BPBcLFpkm/htmGiGQrCKbnR+mGF9YuSSfMfWwWF3PzQb/hI14asffjhrL/EB5YPb6OcMIf0xFTLTOSZXu/gz7/Zo2yYViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29uzU+X4w1SKhzcSnR9SDV3ndKA349kBSBXifBxZ8EU=;
 b=UR4QrFTzGIH0i2k55W5/Q3ZVquc5GHKwe655ZLJ+bpy+sU0077QiWqQU1nFcgWZdrcJ3GkKDTE8i4+E/5abskU1Il4dQCALL9j2wOTxksKo6wbTY84Q5x52LeXKJQm4bS1cpFbQ4XKKgtmx4EBggEX7uopsOkG3bpP31SBjaiPy8I1VkEc6mm4Wn91GGXROqTiOJFEx9+tlFrUAjqcFLdANVcBCJGECkxcGSkCJY9h3/rgulDo1i1UxY3lVcOf16RVIIFduGMMfHVyDVK4JB5OllIYo7pHu1HdGei+a+bTFmNuTx8FzwHoi+eNpOROfG/tQhof6NeRbfqcqCBum4Qg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 08:58:45 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:58:45 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Topic: [PATCH 1/7] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Index: AQHY92Yko8iGoP1kJUuMoxi80YSfj6491zQAgAAi87CAABc/AIAADlzw
Date:   Mon, 14 Nov 2022 08:58:45 +0000
Message-ID: <DM8PR12MB54003D01BE6CFB1FF41BBBA7AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-2-elic@nvidia.com>
 <CACGkMEssbrOaYJDrHb1e_brjteKk4Xfw+sVogeiRbYE0RiMgRA@mail.gmail.com>
 <DM8PR12MB54006C35F5CDB250CA757108AB059@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20221114030644-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221114030644-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|MN0PR12MB5860:EE_
x-ms-office365-filtering-correlation-id: b28bc6b6-a3f5-4f27-bc5c-08dac61e7007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igIXbLM3ZwiOvcjikWAugjchEyMjMBaLnZndBFo0ffinx9P1kHh8RCFXZnBHtTsjfkPnrj/MU7vlfAsRasvtQyxmSh4KT4F5n+l8mHD85du0qtKTXxqKR+DaOndW8pNaCBzZeyjkpqOO73OQXQ7c3Azv07CY9VwR2PP5mPDnS7sedf3Gs57KOnl3LGCGLRE7VRAQ7uH1/F+R44jEj0OBRv7tKKqg4k+HjgTGVxnIRWc3jtpPdPV5ALEPv1/RfFilnSFePqebQwDTLf2THTNK3kye9oxL+OsMZWCJvUEdzQfTbi/eF8TJ5FMxbDvBOXDCN1bCPXJS1Bl3YEM6wU5nreW8xfGWqpAH9kFDrxFPwVnUtmQV7JK8JliWGxLR1aQdXoRtjExkVmATifuvrFTC29DDswOVbNHuvZwATo6f1p4kk0n/oGVsRaENFTaGlnhwv1dbAzjhZiqJCWhR+qvCNzQc494CDDe0sRcaGWRvQfJ9Qg5e752Iqi2c7a1EchX6MfRJw8NQPzryJhCEAJ+HC8RtoP6ga5kL+ZcIUQWpws9osP4WI22ZQWhBRCXztXWXD36xmaLxmyrUoI7F585POmnlbNQkiyofRjKBELPct/mVdDWwe+HcF4fcuyUtmthTpy2Z+5MH4VVjdTeOrodhhWdu5b9LKEUgmjLcZ0OnB700PkAvCGztW+yCJ2VDsi8M1N/BdRN8swgqIH58o0+jhDVaxdKC9U3QLrai62l+NTnhUHJqCLuNJk0GPw00uhN1H3/d3n9vd44OXMVmTBNGKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(26005)(316002)(9686003)(53546011)(2906002)(33656002)(83380400001)(38070700005)(41300700001)(66476007)(66946007)(66556008)(66446008)(4326008)(64756008)(186003)(76116006)(5660300002)(55016003)(8676002)(8936002)(52536014)(86362001)(38100700002)(71200400001)(478600001)(7696005)(6506007)(6916009)(54906003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjVsRU1ZcFJCdmRHaHZpWHFUU0J2Z3VYV01vUURIb2cvbXd5a2dnczBLa2Rh?=
 =?utf-8?B?VjAwbGw3c1JOalByaHdVc0FiUkNLOFh5aW80OWdnVndldGw2WHVaeGppcTYx?=
 =?utf-8?B?WmtNT2kvTWRFc1JQZ1A0VUZDcFRyK2IvOVJ3czVIVzJScjVTZDMwVGl5Tnoz?=
 =?utf-8?B?M1I4L3MrZjlPemlBZDQ2dkVtb3FMT0Z5U3hCa0x6Vm1GdXAvZmdMbUx0eWp5?=
 =?utf-8?B?THRQQjBYbTE4SnJFZW9nWVBSR0pjRmhYclRpRjNUanZVUkxYUzVma2ZWbWho?=
 =?utf-8?B?dHplMlFiamVHN0FNdkh1TVNwMkpTUTRtalRHalM0bGZPblRWendybVI0SWo4?=
 =?utf-8?B?TEdGSFU2SW0wa01PaDFDM253RU5ncUJMVmFLOEdNdmJCbnFsVW1LbGNLUzBI?=
 =?utf-8?B?ZkZiYWNJb3JHd0dOc2lpcnltdjRxRnZKL0wzeE5OaTN3TFM2eHZWUXYycCtw?=
 =?utf-8?B?S0gxLzNlZ1YvVmhQU2wxSmRrNXp3OGw1dG9VcGxpSmVyY2xYUEVRZTdaS0gv?=
 =?utf-8?B?dmFZc1M3SldDeFg4Vk0wdGFHbGRNdXVxWHhsakduNGdDUFN3VFVWZWxjMXRW?=
 =?utf-8?B?R29RMDA1MkVJNmFnUDJJSmU5cDlveFl1d3Z1Smd1eHNaS0xOY1pydUpUZUtu?=
 =?utf-8?B?NWM4ZFh0UXQ0QTBxVURWc1FEU3pLa2hYR1h3MnVnTFpYcXJNSjJqMWUxOEdQ?=
 =?utf-8?B?SWhxZThBYU5zSmVJYVRyUXNmZW1sbTRLU254Z2lXc0Zhc01aQ3pJaVA0SEVw?=
 =?utf-8?B?eUdtL1JDMUVRZWkzNDVWencxbVNrOGt3Z1IzQmlVTS9Ndmg0U2J6REZJQmor?=
 =?utf-8?B?cHRhMWU5b2RIUTlIeUwzaUhFcEVCd2RYN3AwQTdxMFlxTHY2V2hxUTFXbGlp?=
 =?utf-8?B?MStqTHBucmNUMHA0b3A3a0tOZXp0dDU0WUVwTlF3cUZRRG43Y0pmNEZQQ3Rr?=
 =?utf-8?B?dVJCRFNCcHRWQVJ0MVlBSUYvMHZrSkt0ZmpFUTBwYjFiWEtsZkNEVzZKazRl?=
 =?utf-8?B?Ti94MmVqMEliZ1NUekFPRTdqTWdyNVJ4RnI4c0Z6em1kRTRNUHZBOWsyaS9j?=
 =?utf-8?B?aWgvKzBjaDhNd3F4QlpuQURMdVZwRldOK3plQnhQVC9NUmJTN24va3AyTlg3?=
 =?utf-8?B?VllMS05BVjdoaE5XVFdwM3l3cTM2YzJFcUlQdWlHcFlKWFZvWVBWbytqb3V3?=
 =?utf-8?B?TzdMNDJGTDFON2RnTTNkWHd6OTBvUVd1WURySEpReFJHM2ZlRUYvV1RwWmdj?=
 =?utf-8?B?UTVXTlA2azNoNzRXejlIK2E5VGVmZDBEVE1WR1NRVEEwY3dHeXNaMTZtS0xJ?=
 =?utf-8?B?ZGlmRjBCa0k0YlZHbUZ0YzZqYlJjTERZcUFZR1BibTVpbjhFeGk0K2htVE9J?=
 =?utf-8?B?ejZYT3k5MStGbDhicThMV3BUYmtrcEFCTE1xSVg2U2phd21wN2Y1azJLQWxD?=
 =?utf-8?B?ajhOdDgzTlpreDJHQVhJY1pXVkFYb29XTncwemNFZ3JVWVNpQWZHWWhqMkZH?=
 =?utf-8?B?UHNvREFQQkorVU9pdGlRT3hRNXd4UWhYVmY5VldXTzRibmVhL3JSdDd0SDQ4?=
 =?utf-8?B?K3NzTDRzbTlPZnBxK0d4UGlrSmlValNPa29WVzVFRWtGVW1vUTFuVk82WHY5?=
 =?utf-8?B?RlNMa3dOMjBZUVZYMG1tMjFZZnowWUtmYmg1RmJlZHpVSVRUZ1FWQlEwZVpU?=
 =?utf-8?B?NkljLzVDTzhaZ1BqbHdKL2hGWTVEU3R0RUROOStXNjN0T1ZSdFNPQVdaWmN4?=
 =?utf-8?B?V0VqYldLeVNmdHliRVczRHpENUJqWmRwSVNka2NjaHZOelM1NEEvNTdGbmI5?=
 =?utf-8?B?UHhydWlVbi9vRW9tZXUzTkV2Rm9LNk15eCtUZEJtbEVlNnhkR2tzQm5FVEVY?=
 =?utf-8?B?NDY1c0J0VExwOGJWZ3JkQXdPYkpoMjl3ZjFXL0Y3dFk1aU5GdmtqaVNSTGth?=
 =?utf-8?B?M0o4bTJXeVhpQXlRV2ZDTjN1bU95dkVlaDFJaHh1TTNxdmhXdUplWjBtK0ts?=
 =?utf-8?B?YkFOd3pCdWVMUUVCTWtKcldlV2tzTjBoc29nTXVraFB6UUpjQTZ4NVE2d3p1?=
 =?utf-8?B?em5mT0E4Y2hVb2hYck41dDBiYlR1VXdVeVZIVTM1YVFpd2ZYcmRMT1NhT3Z0?=
 =?utf-8?Q?i4uY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28bc6b6-a3f5-4f27-bc5c-08dac61e7007
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 08:58:45.7063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7kzvSU886LXg1R7Cfcn2Mew1e/tQpNIDNM41l57eayJ2NtgYNdlRvB0jVRVUiGS
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCAxNCBOb3ZlbWJlciAyMDIyIDEw
OjA3DQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gQ2M6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB2
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgc2ktd2VpLmxpdUBvcmFj
bGUuY29tOw0KPiBlcGVyZXptYUByZWRoYXQuY29tOyBsdWx1QHJlZGhhdC5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzddIHZkcGEvbWx4NTogRml4IHJ1bGUgZm9yd2FyZGluZyBWTEFOIHRv
IFRJUg0KPiANCj4gT24gTW9uLCBOb3YgMTQsIDIwMjIgYXQgMDY6NDQ6MzBBTSArMDAwMCwgRWxp
IENvaGVuIHdyb3RlOg0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgMTQgTm92ZW1iZXIgMjAyMiA2OjM5DQo+ID4gPiBUbzog
RWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiBDYzogbXN0QHJlZGhhdC5jb207IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LQ0KPiA+ID4gZm91bmRhdGlvbi5vcmc7IHNpLXdlaS5saXVAb3JhY2xlLmNvbTsgZXBlcmV6bWFA
cmVkaGF0LmNvbTsNCj4gPiA+IGx1bHVAcmVkaGF0LmNvbQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzddIHZkcGEvbWx4NTogRml4IHJ1bGUgZm9yd2FyZGluZyBWTEFOIHRvIFRJUg0KPiA+
ID4NCj4gPiA+IE9uIFN1biwgTm92IDEzLCAyMDIyIGF0IDk6NDUgUE0gRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBTZXQgdGhlIFZMQU4gaWQgdG8g
dGhlIGhlYWRlciB2YWx1ZXMgZmllbGQgaW5zdGVhZCBvZiBvdmVyd3JpdGluZyB0aGUNCj4gPiA+
ID4gaGVhZGVycyBjcml0ZXJpYSBmaWVsZC4NCj4gPiA+ID4NCj4gPiA+ID4gQmVmb3JlIHRoaXMg
Zml4LCBWTEFOIGZpbHRlcmluZyB3b3VsZCBub3QgcmVhbGx5IHdvcmsgYW5kIHRhZ2dlZCBwYWNr
ZXRzDQo+ID4gPiA+IHdvdWxkIGJlIGZvcndhcmRlZCB1bmZpbHRlcmVkIHRvIHRoZSBUSVIuDQo+
ID4gPiA+DQo+ID4gPiA+IEluIGFkZGl0aW9uIG1vZGlmeSB0aGUgbG9naWMgc28gdGhhdCBWTEFO
IGZpbHRlcmluZyBpcyBlbmZvcmNlZCBvbmx5DQo+ID4gPiA+IHdoZW4gVklSVElPX05FVF9GX0NU
UkxfVkxBTiBpcyBuZWdvdGlhdGVkLiBXaGVuIG5vdCBuZWdvdGlhdGVkLCBhbGwNCj4gPiA+ID4g
aW5jb21pbmcgdHJhZmZpYyBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIGl0IGlzIHRhcmdldGluZyB0
aGUgbmV0IGRldmljZSdzDQo+ID4gPiA+IE1BQyBhZGRyZXNzLg0KPiA+ID4gPg0KPiA+ID4gPiBG
aXhlczogYmFmMmFkM2Y2YTk4ICgidmRwYS9tbHg1OiBBZGQgUlggTUFDIFZMQU4gZmlsdGVyIHN1
cHBvcnQiKQ0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNA
bnZpZGlhLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgfCAxMSArKysrKysrKy0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ID4gYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiA+ID4gaW5kZXggOTA5MTMzNjVkZWY0Li5lYTk1
MDgxZWNhMGMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMN
Cj4gPiA+ID4gQEAgLTE0NjgsMTEgKzE0NjgsMTMgQEAgc3RhdGljIGludA0KPiBtbHg1X3ZkcGFf
YWRkX21hY192bGFuX3J1bGVzKHN0cnVjdA0KPiA+ID4gbWx4NV92ZHBhX25ldCAqbmRldiwgdTgg
Km1hYywNCj4gPiA+ID4gICAgICAgICBkbWFjX3YgPSBNTFg1X0FERFJfT0YoZnRlX21hdGNoX3Bh
cmFtLCBoZWFkZXJzX3YsDQo+ID4gPiBvdXRlcl9oZWFkZXJzLmRtYWNfNDdfMTYpOw0KPiA+ID4g
PiAgICAgICAgIGV0aF9icm9hZGNhc3RfYWRkcihkbWFjX2MpOw0KPiA+ID4gPiAgICAgICAgIGV0
aGVyX2FkZHJfY29weShkbWFjX3YsIG1hYyk7DQo+ID4gPiA+IC0gICAgICAgTUxYNV9TRVQoZnRl
X21hdGNoX3NldF9seXJfMl80LCBoZWFkZXJzX2MsIGN2bGFuX3RhZywgMSk7DQo+ID4gPiA+ICsg
ICAgICAgaWYgKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyAmIFZJUlRJT19ORVRfRl9DVFJM
X1ZMQU4pIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIE1MWDVfU0VUKGZ0ZV9tYXRjaF9zZXRf
bHlyXzJfNCwgaGVhZGVyc19jLCBjdmxhbl90YWcsIDEpOw0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgTUxYNV9TRVRfVE9fT05FUyhmdGVfbWF0Y2hfc2V0X2x5cl8yXzQsIGhlYWRlcnNfYywNCj4g
Zmlyc3RfdmlkKTsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ICAgICAgICAgaWYgKHRhZ2dl
ZCkgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgTUxYNV9TRVQoZnRlX21hdGNoX3NldF9seXJf
Ml80LCBoZWFkZXJzX3YsIGN2bGFuX3RhZywgMSk7DQo+ID4gPiA+IC0gICAgICAgICAgICAgICBN
TFg1X1NFVF9UT19PTkVTKGZ0ZV9tYXRjaF9zZXRfbHlyXzJfNCwgaGVhZGVyc19jLA0KPiBmaXJz
dF92aWQpOw0KPiA+ID4gPiAtICAgICAgICAgICAgICAgTUxYNV9TRVQoZnRlX21hdGNoX3NldF9s
eXJfMl80LCBoZWFkZXJzX2MsIGZpcnN0X3ZpZCwgdmlkKTsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIE1MWDVfU0VUKGZ0ZV9tYXRjaF9zZXRfbHlyXzJfNCwgaGVhZGVyc192LCBmaXJzdF92aWQs
IHZpZCk7DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4gPiAgICAgICAgIGZsb3dfYWN0LmFjdGlv
biA9IE1MWDVfRkxPV19DT05URVhUX0FDVElPTl9GV0RfREVTVDsNCj4gPiA+ID4gICAgICAgICBk
ZXN0LnR5cGUgPSBNTFg1X0ZMT1dfREVTVElOQVRJT05fVFlQRV9USVI7DQo+ID4gPiA+IEBAIC0x
ODIxLDYgKzE4MjMsOSBAQCBzdGF0aWMgdmlydGlvX25ldF9jdHJsX2Fjaw0KPiBoYW5kbGVfY3Ry
bF92bGFuKHN0cnVjdA0KPiA+ID4gbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU4IGNtZCkNCj4gPiA+
ID4gICAgICAgICBzaXplX3QgcmVhZDsNCj4gPiA+ID4gICAgICAgICB1MTYgaWQ7DQo+ID4gPiA+
DQo+ID4gPiA+ICsgICAgICAgaWYgKCEobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzICYNCj4g
PiA+IEJJVF9VTEwoVklSVElPX05FVF9GX0NUUkxfVkxBTikpKQ0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIHN0YXR1czsNCj4gPiA+DQo+ID4gPiBOaXQ6IHRoaXMgc2VlbXMgdW5yZWxh
dGVkIHRvIHRoZSBwYXRjaC4NCj4gPiA+DQo+ID4gV2lsbCBwdXQgaW4gYW5vdGhlciBwYXRjaA0K
PiANCj4gDQo+IE9LIHNpbmNlIHlvdSBhcmUgZG9pbmcgYSBuZXcgdmVyc2lvbiwgcGxlYXNlIHNw
bGl0IGZpeGVzIGFuZA0KPiBmZWF0dXJlcyBpbiB0d28gcGF0Y2hzZXRzLiBUaGFua3MhDQoNClN1
cmUNCj4gDQo+ID4gPiBPdGhlciB0aGFuIHRoaXMuDQo+ID4gPg0KPiA+ID4gQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+
ICAgICAgICAgc3dpdGNoIChjbWQpIHsNCj4gPiA+ID4gICAgICAgICBjYXNlIFZJUlRJT19ORVRf
Q1RSTF9WTEFOX0FERDoNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJlYWQgPSB2cmluZ2hfaW92
X3B1bGxfaW90bGIoJmN2cS0+dnJpbmcsICZjdnEtPnJpb3YsICZ2bGFuLA0KPiA+ID4gc2l6ZW9m
KHZsYW4pKTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zOC4xDQo+ID4gPiA+DQo+ID4NCg0K
