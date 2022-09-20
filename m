Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D05BDC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiITFsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiITFsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:48:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF1491F7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0nnfIThImeaZlObEtcdogsCT3MhHlWU5UyTLURVwE3hkSd+sCDTgvX1Mk8LbkV/NyfkyHQheUl/QlNc9T3OkaKJWd+U9XOM2XHrXpXU1ts3rOYE1PmZ1UQYSeb7CK8ENJtu5mR0HwQ8jYVdJrtzpJRqI65ng9VZLjHIxt+fna34etZE7Y1wL+/xGzOZhht3fIAdhpq7cIfXtzFSkuyy/Vviehrss+KqQt7W6gkHuInD6A132USNjVpxLgN6k4LJsDikki8eFa5GUNHoqEiAlDKLCEjl7MG0WJCRaXDIYvui5QCfSqrt/kqger6cxSSg43jqAj4RlWdJwhjpE6m6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8ClAv61itMhHNYW6tBg0Bhvc1iA4bnhlMT9S5lAWdI=;
 b=DHDfz7a8hKi5GztaKn5cWmErX764GEtIejgB7+0HtVur8+IqJpLFUS9FCDEvwUAAOpCVyhTZwl0i9CwfIsFUndW/y30F0G4YDKF3UfjZGUNXT6nzlL9xMSu5uuFjqvNPZAPj6QonAiakaPgEI2WqeEDB30lzT4TjZARxgU8bd8+DpJnk/UiHGssoSza8BjxdvdldCdhjgvFhjvstD71GL7shqXmYWoowAGkvqdK7l/+WEAtReHSxKcRop0nh4r387xS8LNu00RLfa7OMX01OzuDdwmus3Pm3XPa9hr5JTHhNBngXj9Sy2WRsJklS7TD/TN8Q7ee/XFLc/Doiu5TzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8ClAv61itMhHNYW6tBg0Bhvc1iA4bnhlMT9S5lAWdI=;
 b=aa+E2tMBVi523TXGojIdtSFlzXb62okCaIYZywkrfMwNVcrfc77PRzS3Y0LPJnhMfiZXk3Ccuh1fu+vv2PaUpqsVkTQkC1OWDe6oXMOVvpZJ5htuvIUTA+m/R4kHIyGCDILyoGUmip1fE7RTtf/6YUeyDUy4On4Pi5NqgKaRjzRVKk7Qi1OL5/Fcbi3SMzZV0dOWPpbcId/fUvZZo2N6vnu3aErJ67HCVXgo5J/TtZr95arwAGgfE27mEjHf0PvN1URZoDQe2HSH7lnVi6E9F/pTu54JJjYNZ73dhG22ngHVZvA12GIBxreYUV7vNN3HsZFyTaYoSI79J7YT2A6xRg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 05:48:38 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 05:48:38 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
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
Thread-Index: AQHYyOBTnTc4N7nO402aAw298tWvH63mWm5wgAE5UYCAAENwsA==
Date:   Tue, 20 Sep 2022 05:48:38 +0000
Message-ID: <DM8PR12MB54002DE8984FB1F1D2531BE3AB4C9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
 <20220915085048.12840-4-jasowang@redhat.com>
 <DM8PR12MB54006A97A99515542260B5D6AB4D9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEtfLGjHgFV7bgWrjWoFZyiTQMf9oDBGi5L=diQ5mtNRnA@mail.gmail.com>
In-Reply-To: <CACGkMEtfLGjHgFV7bgWrjWoFZyiTQMf9oDBGi5L=diQ5mtNRnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|SJ0PR12MB6688:EE_
x-ms-office365-filtering-correlation-id: 37241b96-0506-469b-30af-08da9acbc3f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBEJ22HwJmmVZJUru0vF7f62cpOHU2YRQxuM1D9KWrikYGR419qdiYUp0PLpwt6TF2g22AMyOFGU64ccvKjB4D0Zz66e6g7Kr8+RpY0oFkzEhllks+3HMFbnIp/tzZjF1QMvDgQ76cNWu5TFTyUqOC8WYrotWrlvlQPgAu/2opYfoLk96dMkM+7WbY6SvxGlicbsL9yXSaY/X5dleYyVYKNJXgnZsj0QbrmRyx+WroCDfpUff45LsSFuWcvHE86n70Tc1L6E1BS3cldl1uvip4CggJZOGqcNfhG+C2okHsj17OIZdU09wGXFQ/gODY1ZvnadX0Mmv1G2DPOB7+lJYbrXxsM3O/EJ5cbpcNgUVJWAwzjXMVLt9vkWXi0Sb9BelN56VFSCm/ztpWL2raY5iRGfulHW/ycHSWajXVrackamaqYxalxR0IpdDJ8OIEHFt3P24MUmwexyN9QB/SNK1Z0rXfjNAlSplpLTNcK3NMEjPpWV3wy4fbcs10Jx0rPPYUrr0Sk5higLA/fw2fjzDJUAmkBni5gnN8ktztpk24B4dW/B5MB+AniPrPokFUW6+y+D/51TVyPBAKqCGocAUdxvbhooj1asjhFVr3fJUno1sWYeZy/crs2afdzjn/9ImN8GnvE37T5UtrzlxY0fxUSSXM993zqeuQhl+Mj6zBN7g2KVHbX2Oa2aGi0R1VKDa1vOQAHl6dwoc/LbMt3BeFRDYm+Zh5jur+hr5qyVMsuSmprNY49Z8RGq7Aim5+UF8lGCqLLflp2c9GdnLLjbiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(66476007)(52536014)(7416002)(66556008)(186003)(122000001)(8936002)(54906003)(4326008)(2906002)(86362001)(83380400001)(66446008)(66946007)(38100700002)(64756008)(76116006)(38070700005)(53546011)(55016003)(71200400001)(6916009)(316002)(6506007)(7696005)(41300700001)(8676002)(478600001)(5660300002)(33656002)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JkUjJFYUF1b2NHeUdTZi9YeFlNdE1PR1lyTG1xbnhZZDFUa21EdjNzbVcx?=
 =?utf-8?B?d041d2k2V1ExbUN4WWFJY0EyQXhDdlA0T2Y0bEZKeHdNYytJK1JrTzNFTXFJ?=
 =?utf-8?B?MHljR0tSdU5mRXBNN21BaWdDWVNNcVFsaDEzeFkxWVFENzArbFVUaC9lM3ha?=
 =?utf-8?B?RDBYQTJEUFFLRG8xZ0FtQ0x4aWcyQmp5TldRWFc1K1ZFRzcxcW1IeWpTNmpz?=
 =?utf-8?B?YmdNdnJ0YlAzRlFJNlRIVkVYbWw4bW9NYUlvQlgvRGovcjRVSjFCMEdLYzhC?=
 =?utf-8?B?aG1Qb3lKWXowVkllYVlRd0pmNWRNKzRsM3BLT2dCQjBsK1VvSkFVRnZldHRo?=
 =?utf-8?B?bHNSWTB4RUlyRHNITFBSOXk5MU1HSG0wbnE1b2xISVF3Z0xWREVGbkxaUHV0?=
 =?utf-8?B?enk0MFphemRVbkFHWFBrZEk1aXVTSVR1MTJqcHd0a29YenFvL3hySW55WStk?=
 =?utf-8?B?UlBEbHdoTGlrNEVnVnZXWXFkM0F5QTNkb3lwZHFXUlBPd0lKeXBJVUcxWW4r?=
 =?utf-8?B?cXFsOTVJNmJPcW5LaEs5eGVRYVdQWG9PZ2lkQjF4N2RQcGtqWk90dGFaUnB1?=
 =?utf-8?B?UDMxcVlKTUZXTTBHc1VyRjdLRUFOTHpLaGhrREg4eHR5WE82L2pNV2lxV3o3?=
 =?utf-8?B?QzVZcmZCYnNBNUxXNkE4WUlpd21jRVlQS1ZyYkFMZU5rNk9xOUZNWFFJWlQ4?=
 =?utf-8?B?VkJpTXVSNE1BdDdJT083VThlU0xGU2hvam9rM0FGSndJc2hIRWxUb2xyaXVj?=
 =?utf-8?B?OWJMQUFCVUFZS0dLTEUweXA2dXhBWURMenlNU3l4Zk02NTlKcGNBU0lzamtM?=
 =?utf-8?B?ZjhDZy9iVk5SMW0xaWc1NGFCZGhkRTJFYTFYZlNMbEtCSG5lT2tWWlMxaVIx?=
 =?utf-8?B?VkFVOXFCL1V5ZnRsWlpBc0VtVlBtSU50WjdJL25RM1A1Z0VGVkduSC91MzFD?=
 =?utf-8?B?dkd2cGxUMHV5TnNuOWRsNzU1R0krUm5KT0Y2OXFmOW1HbytDeUFhVU0wcWdL?=
 =?utf-8?B?cXJOOE5zblo0RmNnZGJLZUd6NTJQRFgrcSsvUVFYNDRJVWdRSW0rMGJwS2xK?=
 =?utf-8?B?L0dISk11enV0QklOTWVpM3IwWlRIRjQ5T00zVFRXVEJSNUdTT1dFbnplRkg2?=
 =?utf-8?B?Y1VKSm5UMmkwUzZUUzg1MUluQkdBbWI3cUxsdTllcUpkcTFmYkZWZVU5QnpF?=
 =?utf-8?B?TDFFUDBYN3k0M0k5a3dCbzlXU2pmSmNOcURYVER1L2pvQVpyOFkzTVRTcXFx?=
 =?utf-8?B?NjhvQVh5L3liNnU2aXQ4eUNHMUcxTkIzUFhEbzVVRm9XS3g1V2lDMGdxZFJq?=
 =?utf-8?B?Y0svM0hhckgzMVcxeDI5aUJmbXBTMTJsRjRHa1hleDlkQURvNFlWUzZUSEg4?=
 =?utf-8?B?SFhodkJWTDcvejloWjYvcEIwZGlOQkowK0JsSEVCdWRXN0Z1b1VrSW1SZXpF?=
 =?utf-8?B?WWdpbVUwdVJQTlpwZTFjYUxzc21iMGNIbExWbk5ValpmdmhQeTQ5dUJJeVow?=
 =?utf-8?B?NFFTd2U5MGNZYngvNEdNVzFra3NkZHdWdWx3dDVGbmh0ZVRqaGNuR2htRFR3?=
 =?utf-8?B?cVdkVVBWVHI3VGlFZ1pFRHNXSEtxeERqWFA1M3hoK0JaVDUra094cW9Vcmw3?=
 =?utf-8?B?NEl6NThrT3lXbGlDYzI5ZEp0OEFwbkJhVENMSEpmd3NSUE5GZCtVZTlxTXdU?=
 =?utf-8?B?Snd0dnY4K2dnUTZsUFphelg5QTNuQ3NtR3cvVFl5VE5ueW1VczFvTXd0R0hU?=
 =?utf-8?B?cncxdFFUUXNVQlVnc0J2YkNqL2x3YlpTSkZCVEN0NUlKUkx5dFBuMlZmVHRO?=
 =?utf-8?B?eEdxVVVtVUg1ZlNDVHZCV201ZTBHRHpjdXpkQURWTjVYZGVCTlBOOFI5TXFO?=
 =?utf-8?B?akZPVzhOTmlhNVUvUzJFK0E1b2JFSlFFTEVqREU0YU5PSUxPc0ROM2d5b0ZR?=
 =?utf-8?B?dVpsS0tuMFdKYUtCTzU3Y1pOTktPbG9oSkhLYW5qMjdOL1VVZmMrUDJTWDFs?=
 =?utf-8?B?ek5VTWxCOVE4R2taWGFBU3hHK3pBUE5VNHlqY0VrWFFYU3pPS0lSMjNhZXJa?=
 =?utf-8?B?aDFjZWN6M3FmRTdoeW9sVW95NENhcFYxTjM4LzBMbFRZaWY3TVF3dlFuNFhv?=
 =?utf-8?Q?OSKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37241b96-0506-469b-30af-08da9acbc3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 05:48:38.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fWGyWNgNzQ0Z9hR+/BlYPLjM6knzJ+NFxQ562nxwhyEzP778z2qKl3sXgZKbBG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCAyMCBTZXB0ZW1iZXIgMjAyMiA0OjQ2DQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4NCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBzaS13ZWkubGl1QG9yYWNsZS5jb207IFBhcmF2IFBh
bmRpdA0KPiA8cGFyYXZAbnZpZGlhLmNvbT47IHd1em9uZ3lvbmdAbGludXguYWxpYmFiYS5jb207
DQo+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBlcGVyZXptYUByZWRoYXQuY29tOyBsaW5nc2hhbi56aHVA
aW50ZWwuY29tOyBnZGF3YXJAeGlsaW54LmNvbTsNCj4gbHVsdUByZWRoYXQuY29tOyB4aWV5b25n
amlAYnl0ZWRhbmNlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gdnBfdmRwYTogc3Vw
cG9ydCBmZWF0dXJlIHByb3Zpc2lvbmluZw0KPiANCj4gT24gTW9uLCBTZXAgMTksIDIwMjIgYXQg
MzowNSBQTSBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZy
b206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2Rh
eSwgMTUgU2VwdGVtYmVyIDIwMjIgMTE6NTENCj4gPiA+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFz
b3dhbmdAcmVkaGF0LmNvbQ0KPiA+ID4gQ2M6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPjsg
c2ktd2VpLmxpdUBvcmFjbGUuY29tOyBQYXJhdiBQYW5kaXQNCj4gPiA+IDxwYXJhdkBudmlkaWEu
Y29tPjsgd3V6b25neW9uZ0BsaW51eC5hbGliYWJhLmNvbTsNCj4gPiA+IHZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiA+ID4gZXBlcmV6bWFAcmVkaGF0LmNvbTsgbGluZ3NoYW4uemh1QGludGVsLmNvbTsgZ2Rh
d2FyQHhpbGlueC5jb207DQo+ID4gPiBsdWx1QHJlZGhhdC5jb207IHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSB2cF92ZHBhOiBzdXBwb3J0IGZlYXR1
cmUgcHJvdmlzaW9uaW5nDQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBhbGxvd3MgdGhlIGRldmlj
ZSBmZWF0dXJlcyB0byBiZSBwcm92aXNpb25lZCB2aWENCj4gPiA+IG5ldGxpbmsuIFRoaXMgaXMg
ZG9uZSBieToNCj4gPiA+DQo+ID4gPiAxKSB2YWxpZGF0aW5nIHRoZSBwcm92aXNpb25lZCBmZWF0
dXJlcyB0byBiZSBhIHN1YnNldCBvZiB0aGUgcGFyZW50DQo+ID4gPiAgICBmZWF0dXJlcy4NCj4g
PiA+IDIpIGNsZWFyaW5nIHRoZSBmZWF0dXJlcyB0aGF0IGlzIG5vdCB3YW50ZWQgYnkgdGhlIHVz
ZXJzcGFjZQ0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92
cF92ZHBhLmMgfCAxNiArKysrKysrKysrKysrKy0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYw0KPiA+ID4gYi9kcml2ZXJzL3ZkcGEv
dmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiA+IGluZGV4IDA0NTIyMDc3NzM1Yi4uNGIyOGUwYzk1
YmEyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiA+IEBA
IC0xNyw2ICsxNyw3IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19yaW5nLmg+DQo+
ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19wY2kuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGlu
dXgvdmlydGlvX3BjaV9tb2Rlcm4uaD4NCj4gPiA+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92ZHBh
Lmg+DQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgVlBfVkRQQV9RVUVVRV9NQVggMjU2DQo+ID4gPiAg
I2RlZmluZSBWUF9WRFBBX0RSSVZFUl9OQU1FICJ2cF92ZHBhIg0KPiA+ID4gQEAgLTM1LDYgKzM2
LDcgQEAgc3RydWN0IHZwX3ZkcGEgew0KPiA+ID4gICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9k
ZXJuX2RldmljZSAqbWRldjsNCj4gPiA+ICAgICAgIHN0cnVjdCB2cF92cmluZyAqdnJpbmc7DQo+
ID4gPiAgICAgICBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjb25maWdfY2I7DQo+ID4gPiArICAgICB1
NjQgZGV2aWNlX2ZlYXR1cmVzOw0KPiA+ID4gICAgICAgY2hhciBtc2l4X25hbWVbVlBfVkRQQV9O
QU1FX1NJWkVdOw0KPiA+ID4gICAgICAgaW50IGNvbmZpZ19pcnE7DQo+ID4gPiAgICAgICBpbnQg
cXVldWVzOw0KPiA+ID4gQEAgLTY2LDkgKzY4LDkgQEAgc3RhdGljIHN0cnVjdCB2aXJ0aW9fcGNp
X21vZGVybl9kZXZpY2UNCj4gPiA+ICp2cF92ZHBhX3RvX21kZXYoc3RydWN0IHZwX3ZkcGEgKnZw
X3ZkcGEpDQo+ID4gPg0KPiA+ID4gIHN0YXRpYyB1NjQgdnBfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1
cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkNCj4gPiA+ICB7DQo+ID4gPiAtICAgICBzdHJ1
Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gdmRwYV90b19tZGV2KHZkcGEpOw0K
PiA+ID4gKyAgICAgc3RydWN0IHZwX3ZkcGEgKnZwX3ZkcGEgPSB2ZHBhX3RvX3ZwKHZkcGEpOw0K
PiA+ID4NCj4gPiA+IC0gICAgIHJldHVybiB2cF9tb2Rlcm5fZ2V0X2ZlYXR1cmVzKG1kZXYpOw0K
PiA+ID4gKyAgICAgcmV0dXJuIHZwX3ZkcGEtPmRldmljZV9mZWF0dXJlczsNCj4gPiA+ICB9DQo+
ID4NCj4gPiBVbnJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4gTWF5YmUgcHV0IGluIGFub3RoZXIgcGF0
Y2g/DQo+IA0KPiBBY3R1YWxseSBub3QsIHNpbmNlIHdlIGRvbid0IHdhbnQgdG8gcmVwb3J0IHRo
ZSBmZWF0dXJlcyB0aGF0IGFyZQ0KPiBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZSwgYnV0IHRoZSBm
ZWF0dXJlcyB0aGF0IGFyZSBwcm92aXNpb25lZCB2aWENCj4gbmV0bGluazoNCj4gDQoNCkkgc2Vl
Lg0KDQpSZXZpZXdlZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQoNCj4gPiA+ICsg
ICAgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZFQVRVUkVT
KSkgew0KPiA+ID4gKyAgICAgICAgICAgICBpZiAoYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVz
ICYgfmRldmljZV9mZWF0dXJlcykNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPiA+ICsgICAgICAgICAgICAgZGV2aWNlX2ZlYXR1cmVzICY9IGFkZF9jb25m
aWctPmRldmljZV9mZWF0dXJlczsNCj4gPiA+ICsgICAgIH0NCj4gPiA+ICsgICAgIHZwX3ZkcGEt
PmRldmljZV9mZWF0dXJlcyA9IGRldmljZV9mZWF0dXJlczsNCj4gDQo+IFRoYW5rcw0KPiANCj4g
Pg0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgaW50IHZwX3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJlcyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NA0KPiA+ID4gZmVhdHVyZXMpDQo+ID4gPiBAQCAt
NDc1LDYgKzQ3Nyw3IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVjdA0KPiB2ZHBh
X21nbXRfZGV2DQo+ID4gPiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiA+ID4gICAgICAg
c3RydWN0IHBjaV9kZXYgKnBkZXYgPSBtZGV2LT5wY2lfZGV2Ow0KPiA+ID4gICAgICAgc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+ICAgICAgIHN0cnVjdCB2cF92ZHBhICp2
cF92ZHBhID0gTlVMTDsNCj4gPiA+ICsgICAgIHU2NCBkZXZpY2VfZmVhdHVyZXM7DQo+ID4gPiAg
ICAgICBpbnQgcmV0LCBpOw0KPiA+ID4NCj4gPiA+ICAgICAgIHZwX3ZkcGEgPSB2ZHBhX2FsbG9j
X2RldmljZShzdHJ1Y3QgdnBfdmRwYSwgdmRwYSwNCj4gPiA+IEBAIC00OTEsNiArNDk0LDE0IEBA
IHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVjdA0KPiB2ZHBhX21nbXRfZGV2DQo+ID4g
PiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiA+ID4gICAgICAgdnBfdmRwYS0+cXVldWVz
ID0gdnBfbW9kZXJuX2dldF9udW1fcXVldWVzKG1kZXYpOw0KPiA+ID4gICAgICAgdnBfdmRwYS0+
bWRldiA9IG1kZXY7DQo+ID4gPg0KPiA+ID4gKyAgICAgZGV2aWNlX2ZlYXR1cmVzID0gdnBfbW9k
ZXJuX2dldF9mZWF0dXJlcyhtZGV2KTsNCj4gPiA+ICsgICAgIGlmIChhZGRfY29uZmlnLT5tYXNr
ICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKSkgew0KPiA+ID4gKyAgICAgICAgICAg
ICBpZiAoYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzICYgfmRldmljZV9mZWF0dXJlcykNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICsgICAgICAg
ICAgICAgZGV2aWNlX2ZlYXR1cmVzICY9IGFkZF9jb25maWctPmRldmljZV9mZWF0dXJlczsNCj4g
PiA+ICsgICAgIH0NCj4gPiA+ICsgICAgIHZwX3ZkcGEtPmRldmljZV9mZWF0dXJlcyA9IGRldmlj
ZV9mZWF0dXJlczsNCj4gPiA+ICsNCj4gPiA+ICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9v
cl9yZXNldChkZXYsIHZwX3ZkcGFfZnJlZV9pcnFfdmVjdG9ycywNCj4gPiA+IHBkZXYpOw0KPiA+
ID4gICAgICAgaWYgKHJldCkgew0KPiA+ID4gICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5k
ZXYsDQo+ID4gPiBAQCAtNTk5LDYgKzYxMCw3IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9wcm9iZShz
dHJ1Y3QgcGNpX2RldiAqcGRldiwNCj4gY29uc3QNCj4gPiA+IHN0cnVjdCBwY2lfZGV2aWNlX2lk
ICppZCkNCj4gPiA+ICAgICAgIG1ndGRldi0+aWRfdGFibGUgPSBtZGV2X2lkOw0KPiA+ID4gICAg
ICAgbWd0ZGV2LT5tYXhfc3VwcG9ydGVkX3ZxcyA9DQo+ID4gPiB2cF9tb2Rlcm5fZ2V0X251bV9x
dWV1ZXMobWRldik7DQo+ID4gPiAgICAgICBtZ3RkZXYtPnN1cHBvcnRlZF9mZWF0dXJlcyA9IHZw
X21vZGVybl9nZXRfZmVhdHVyZXMobWRldik7DQo+ID4gPiArICAgICBtZ3RkZXYtPmNvbmZpZ19h
dHRyX21hc2sgPSAoMSA8PCBWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKTsNCj4gPiA+ICAgICAgIHBj
aV9zZXRfbWFzdGVyKHBkZXYpOw0KPiA+ID4gICAgICAgcGNpX3NldF9kcnZkYXRhKHBkZXYsIHZw
X3ZkcGFfbWd0ZGV2KTsNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4NCg0K
