Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027C973D5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFZCmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjFZCmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:42:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2068.outbound.protection.outlook.com [40.107.215.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3910D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvTQmHUSQlY55akbip05EB0ke2D+oITWEgZ5ZRRk5dcCXd07TYjD+8vPQgNjd4rfyi15vb7qJqBs/5ZSi+VleZsaG3sQcTvdOqZl45VtfPmNpefahfimQ9dEvi28XUkQv35BhC7cJcV2txyHN8xO9I4Rgjswz1aC1hHGCkfRASOdZn6gOXeCW4uGxkEdwKruBIfV32+Yt1EqKi+ebOu+jcKPWBqlj1KpcytoEq+4aYSVHxkCrjSlS/eJGOz77sKv82PcgXl/QcZC4PClRmtbhWWDYkID1gkEeHGT+R+Fh0Joz38cF1+VvvNpZq6GZLbF5SZYOVurSrbNmoGU3jMSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWJ2FnxADYc5Q3JMR1GB5E6kJT8dCIOVO2QBQDotccI=;
 b=SdPjIWYz6X1WIeFmZIdmENIx04vlZ7D588wtYflxk9IVLJP8O0hZHnFRs2sbw+ZafItJoWR9Gl7wNuGaDTR1MchWsayUqzI/eAztbb1jYAH64/LJI5EaqGkp6wcNlHDiNWL07EGlR0UvHH2/RBPMbQDxlRFDXPpudGnZFhfpk+YAksq7mv0aaeWM6hV2tlk1NqxpfFrrufJ7pyiyXvX1ieeftWSVFSNsLlnbqvxup5zopppnGUtHmrwWcekBGfkZbr37a9/NNATQK/ppV4byXjBJ2y6I4SW5l5oln6QsL+XzVUlSlamASHjOd+7jk8v1Q1ieRackoQTC9OmhUwV/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWJ2FnxADYc5Q3JMR1GB5E6kJT8dCIOVO2QBQDotccI=;
 b=Jareslr1FkZ0PU9293UZE1zE7M1umslFK8yHjPVqHEItyC8INoq8gNsA7sqfkz0kqz/VsfzcCLCxiKaVZlMA3aEYzAYxgwmbzHoAKG2IlbIU1bcHl5hcIK3Vhm6bi/PFpyFYblMpSppAxC3hN3Kdjqhl3w9CpdYpA423zvOBndJM9qN6vOrOG2+sk0NDel/lZt0j0bl4ctsPRegHH8VgckOxZJwEjSLqVpKfnSh0D/Ko12Bkh2uKqTLmuXHxUKpXmXyxrnRQTVO5DZyZLhTEW8yQ/hlWIw0GWY9eB7/f5ZOEMlekTcBlCkhekEwNWOIKU/EwQ9md3bWP+xUJs0Gh9w==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TY0PR06MB5234.apcprd06.prod.outlook.com (2603:1096:400:21a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Mon, 26 Jun
 2023 02:42:28 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:42:28 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Topic: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Index: AQHZmefhGgrgL1M5iUCr+LYolFSqU6+ceIAAgAACjaA=
Date:   Mon, 26 Jun 2023 02:42:28 +0000
Message-ID: <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
In-Reply-To: <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TY0PR06MB5234:EE_
x-ms-office365-filtering-correlation-id: 11acd5e4-045c-41ce-9960-08db75eefb3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aK7z3/wuqjZjGSYE2EvA3G4YvLxiOAxNw/nLlpUCuDwbKu8SeJ6rjc959TGJv1EHCcgFrvHvm4H+rYQ3z4/b7OV3TZlqXx+Nb+U1q9Kq63H+zxm1u4b49cBnS1RQDQEgoCgM+OCdmcmErO29uuCvcnmrEYTy5K+LGVkMk7D80wEIKpTV944wlhVsTxC9zO1FGqqMlfOsSTOvxiXmv7FCO8DhlJmDFM1nnv1lnah507AYR4i5v1Vj218pHnmVHsTNsUQgrUeSmiv0C3GTbxw0k7IKoe+vzNDXeI+inQ10Nz2BkWbZpm5ETxwY5Zs5XRQnNUvKBocNHSw86q5M6tyzo0lI2PfSr0/85tw3vAR0FQwpV3NPZMmoDrcUnMZDfCYkenBVt0C/nclHTwEEQPUUPoFcp34NAav3fA6o0u2jcCaIiNSjFJTBI2kcx03D3s5WLejtRtmoKchO47L11DNjOwraL659WDgsonClAnVT8yKwqyf2QrghEze+hzmE/3tpeXk+7hKHfkl1gr1g7p0Bac60eNO7SQCU4DiK2vJo7liu3eElUvqf1SrALmJ2ItJE+qKSSXNjXqPOY+TXMMp639/wIGPoJyaVRTP+fpEoX9w6uj6wuIqFimqGtWJXeCD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39840400004)(451199021)(2906002)(7696005)(71200400001)(122000001)(38100700002)(83380400001)(6506007)(26005)(9686003)(53546011)(186003)(55016003)(41300700001)(54906003)(86362001)(38070700005)(478600001)(316002)(66476007)(66556008)(4326008)(76116006)(66946007)(64756008)(66446008)(6916009)(33656002)(44832011)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzV4dnQvR1QzT2ZvaVVkRUxteFM0TFhkQzFhMkNETkRacnJjYWpIdGpPcUxI?=
 =?utf-8?B?QlZhSHFMYS9LYlhJWnF4bnYzTUc0RkpDNm5lRmhmVzJiNTZQQ3J6bVRxS3pH?=
 =?utf-8?B?eVcvZ2k0SG9LcXZxbmtnb0VLN2pxQkJIaThsclQ5c2RJMGVLb3lyYmdyaUYv?=
 =?utf-8?B?VkNwQ3ZjbnY2RXpXeit4WEhCTDJyL09pQ3p0Q2hzMmtkQ1RyQ2tTMmNnK0FF?=
 =?utf-8?B?WDlQd1FjRTFaM3lEcDdwYk1BT05WR0RjdnhxdnZ5WnEzSFpuNUMyeEVkdWlx?=
 =?utf-8?B?c0ZlTWszNHg4dVkwTjM4K3dsbDM2bVVuV3hiVFNjcGM1S2tweCszcEJBYXo0?=
 =?utf-8?B?cksrRkN0RHk4UWY5bS81b2dxaEdTQU1tU3VhMW9tV3pqYUN1cXBlaWJJZHE4?=
 =?utf-8?B?THV5UGdJVEtha21oZDZQdGZ6cUhucGpXNm9ya292M2Fjajl1aUpBZTBNeEdM?=
 =?utf-8?B?cU9uV2FOS3kyMjRkU05Wa3UwelhKRnQ1eVNWclJvWVg5WC9ZUFpwcVludWVs?=
 =?utf-8?B?Nm40b2NvTUJNOW9ja3FpMGVMSEx5d1pXbXVRRjU2bENTRWZxaTFzaFNpTmwr?=
 =?utf-8?B?ZnMxWU1lZDNWOGZaUnl4SkpVOTA2dXNpcjNyNGVoSjEvZjV2TjJuZGY1MHpn?=
 =?utf-8?B?b3RIc2I1bTY0a1NjcWNSSFE2b2VaL0REeEdMMXRjV0JSWDllemxvSm9ONERp?=
 =?utf-8?B?aGZNV0pQdGpqdk1MYzc5RHI5eTVLS2ZkQWkrOHFXcWk0T3pXUU15YmptK1cv?=
 =?utf-8?B?RzJ2NU1HVjMzUmJITzJkNjQreDgyZXpIWS9WSUNMNjZiV2FHeTZRa2ZPQnU4?=
 =?utf-8?B?U0wyamoyMGUzdFc2UzJtMmY3d2FDOTZuYk5nY3hhbENmSXZRaGFVcnRLQUxV?=
 =?utf-8?B?TUdGK1F4MDUxbVFqZGhHRUwvOXhvMGNnbExHbnF5a2Q4eEE1M1hxRUdMSzc5?=
 =?utf-8?B?OTRjbmw3azlLeVQ0NFYxMThNR3hnR2R0Yk1CNmpVSXlmK0NhdXh4SnJHVnRi?=
 =?utf-8?B?elUrWFFxeXUyMmg1SkYrYnFERTZaNlpMeks0TTVMOEoveTFYcVVkdE92aVF5?=
 =?utf-8?B?aFVNTDA2RDRIa2NWM3BCRERQOG52RVh3Y01QQm1mQVlaVmd2bGlYdHZjZS9T?=
 =?utf-8?B?UlhvVVROS1htNXhnMzI2U2c1UHhkeDQ2Z3NDdDRKU2JJNzBZeFdvcXJxcXh4?=
 =?utf-8?B?KzBVMG1nZlU5RmFlWDFYcWVTUkNZWmtrWXRxTlYyaUFnOTg2N0RCRGV6ejFC?=
 =?utf-8?B?eTlKcThRSmRlTmVnZGtLZlpLSSswVTJ6YTBLNG5sWFRMdDZUTjFaRVRLRTdh?=
 =?utf-8?B?OFpCeXcwclY4S2tCVHdPcmhhTFhuNmlTd3ZDUkY3L2o4ZUU3elE1Rm56eHkr?=
 =?utf-8?B?RTIwZ29BVXNZcE1NR2tqamRwdWdaNm4ybzlrSGlPMEVuZUYranpWT1NnTDNv?=
 =?utf-8?B?VXJhTGljLy9xTnhJaHB6Z053MEdGcDdha2xySHh1UnVXUHA0cGJ5b01ndTdG?=
 =?utf-8?B?WE5WYlVRY2l0UXhCOFU1eGtsUUdGZ3VSVHZLWTRBT0tTdWxkVVJyVndmSWpy?=
 =?utf-8?B?VGFYUVNwNVcyQWNsVlhVV0p5b3NqbGNZdG1lTDhndzFlQnMxZ0ZDak5MVVRO?=
 =?utf-8?B?WjZLVmVBYnRJcjJvSjFwMUE3a0MxSGVHNUNlMHhVTkhXQm9XakdQWE1Eangx?=
 =?utf-8?B?TlhPK0k4S2FxZHJjR0l6UEc1MzdlSmwwYnU2dXYvKzY4VHY4azUvYmJJakZQ?=
 =?utf-8?B?cllMQkI1QnZydjdTOUxKaGh4V21qV1RrejVHekQ0eDlMYUFiYmtKbzNPblFL?=
 =?utf-8?B?VDZIZTJiTTBrZFFENUJtckxCRXU0NGJZTWh0SjRVYW0yYkVqTS9Wbkdxdk1j?=
 =?utf-8?B?dHVKK01QSmJkLzlxbTZmaGM3bUNPUzZQZy9pQ2M3bTFNKzg0MGN1MThTU2dl?=
 =?utf-8?B?UThQQWZPb2dtOHpXK3VJY3dYUDV3MmxHRFVqTjB1ajlwYzU1YWNuNmVOZ2Rx?=
 =?utf-8?B?bTdmWUg1dW0xSzhJOGs1ajRnSE12Vk9vTWVQbHJ2YzNzczBUdEV0VkdSa08y?=
 =?utf-8?B?d21jK3ZsUE1EaWM1L1BkMWNkdEpCZjJuUVpnaWVDcFU2Y0I0ZUJySEpDZ2I5?=
 =?utf-8?Q?Up40RkaVSX+92tn7IxHo7iEEG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11acd5e4-045c-41ce-9960-08db75eefb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 02:42:28.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkRJvORSM/LN5+XrOMP9k2SuIqwgE4VmhF9Fhyx2094fziib/bQHXl1iW2ZrqKGQNdDpw6z29lXKF5sX2ciessUtBXTBtmRVb16OJ3xHQ8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIae+8jGphc29uLg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjYsIDIw
MjMgMTA6MzAgQU0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29t
Pg0KPiBDYzogbXN0QHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjJdIHZkcGEvdnBfdmRwYTogQ2hlY2sgcXVldWUgbnVtYmVyIG9mIHZkcGEgZGV2
aWNlIGZyb20NCj4gYWRkX2NvbmZpZw0KPiANCj4gT24gVGh1LCBKdW4gOCwgMjAyMyBhdCA1OjAy
4oCvUE0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gV2hlbiBhZGQgdmlydGlvX3BjaSB2ZHBhIGRldmljZSxjaGVjayB0aGUgdnFzIG51
bWJlciBvZiBkZXZpY2UgY2FwDQo+ID4gYW5kIG1heF92cV9wYWlycyBmcm9tIGFkZF9jb25maWcu
DQo+ID4gU2ltcGx5IHN0YXJ0aW5nIGZyb20gZmFpbGluZyBpZiB0aGUgcHJvdmlzaW9uZWQgI3Fw
IGlzIG5vdA0KPiA+IGVxdWFsIHRvIHRoZSBvbmUgdGhhdCBoYXJkd2FyZSBoYXMuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4N
Cj4gPiAtLS0NCj4gPiB2MTogVXNlIG1heF92cXMgZnJvbSBhZGRfY29uZmlnDQo+ID4gdjI6IEp1
c3QgcmV0dXJuIGZhaWwgaWYgbWF4X3ZxcyBmcm9tIGFkZF9jb25maWcgaXMgbm90IHNhbWUgYXMg
ZGV2aWNlDQo+ID4gICAgICAgICBjYXAuIFN1Z2dlc3RlZCBieSBqYXNvbi4NCj4gPg0KPiA+ICBk
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCAzNSArKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3Bj
aS92cF92ZHBhLmMNCj4gYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiBp
bmRleCAyODEyODdmYWU4OWYuLmMxZmI2OTYzZGExMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlv
X3BjaS92cF92ZHBhLmMNCj4gPiBAQCAtNDgwLDMyICs0ODAsMzkgQEAgc3RhdGljIGludCB2cF92
ZHBhX2Rldl9hZGQoc3RydWN0DQo+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAq
bmFtZSwNCj4gPiAgICAgICAgIHU2NCBkZXZpY2VfZmVhdHVyZXM7DQo+ID4gICAgICAgICBpbnQg
cmV0LCBpOw0KPiA+DQo+ID4gLSAgICAgICB2cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uoc3Ry
dWN0IHZwX3ZkcGEsIHZkcGEsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsDQo+IGZhbHNlKTsNCj4gPiAtDQo+ID4g
LSAgICAgICBpZiAoSVNfRVJSKHZwX3ZkcGEpKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGRldl9l
cnIoZGV2LCAidnBfdmRwYTogRmFpbGVkIHRvIGFsbG9jYXRlIHZEUEENCj4gc3RydWN0dXJlXG4i
KTsNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIodnBfdmRwYSk7DQo+ID4gKyAg
ICAgICBpZiAoYWRkX2NvbmZpZy0+bWFzayAmDQo+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01BWF9WUVApKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5uZXQu
bWF4X3ZxX3BhaXJzICE9DQo+ICh2X21kZXYtPm1heF9zdXBwb3J0ZWRfdnFzIC8gMikpIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJtYXggdnFzIDB4
JXggc2hvdWxkIGJlDQo+IGVxdWFsIHRvIDB4JXggd2hpY2ggZGV2aWNlIGhhc1xuIiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZF9jb25maWctPm5ldC5tYXhfdnFfcGFp
cnMqMiwNCj4gdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3Zxcyk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAgICAg
ICAgIH0NCj4gPg0KPiA+IC0gICAgICAgdnBfdmRwYV9tZ3RkZXYtPnZwX3ZkcGEgPSB2cF92ZHBh
Ow0KPiA+IC0NCj4gPiAtICAgICAgIHZwX3ZkcGEtPnZkcGEuZG1hX2RldiA9ICZwZGV2LT5kZXY7
DQo+ID4gLSAgICAgICB2cF92ZHBhLT5xdWV1ZXMgPSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMo
bWRldik7DQo+ID4gLSAgICAgICB2cF92ZHBhLT5tZGV2ID0gbWRldjsNCj4gPiAtDQo+ID4gICAg
ICAgICBkZXZpY2VfZmVhdHVyZXMgPSB2cF9tb2Rlcm5fZ2V0X2ZlYXR1cmVzKG1kZXYpOw0KPiA+
ICAgICAgICAgaWYgKGFkZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVB
VFVSRVMpKSB7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5kZXZpY2VfZmVh
dHVyZXMgJiB+ZGV2aWNlX2ZlYXR1cmVzKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
cmV0ID0gLUVJTlZBTDsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2
LT5kZXYsICJUcnkgdG8gcHJvdmlzaW9uIGZlYXR1cmVzDQo+ICINCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJ0aGF0IGFyZSBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBkZXZpY2U6
DQo+ICINCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJkZXZpY2VfZmVhdHVy
ZXMgMHglbGx4IHByb3Zpc2lvbmVkDQo+IDB4JWxseFxuIiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRldmljZV9mZWF0dXJlcywNCj4gYWRkX2NvbmZpZy0+ZGV2aWNlX2Zl
YXR1cmVzKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgICAgICAgICAgICAgICAg
fQ0KPiA+ICAgICAgICAgICAgICAgICBkZXZpY2VfZmVhdHVyZXMgPSBhZGRfY29uZmlnLT5kZXZp
Y2VfZmVhdHVyZXM7DQo+ID4gICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgdnBfdmRwYSA9
IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCB2cF92ZHBhLCB2ZHBhLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldiwgJnZwX3ZkcGFfb3BzLCAxLCAxLCBuYW1lLA0K
PiBmYWxzZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKElTX0VSUih2cF92ZHBhKSkgew0KPiA+
ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInZwX3ZkcGE6IEZhaWxlZCB0byBhbGxvY2F0
ZSB2RFBBDQo+IHN0cnVjdHVyZVxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJf
RVJSKHZwX3ZkcGEpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHZwX3ZkcGFf
bWd0ZGV2LT52cF92ZHBhID0gdnBfdmRwYTsNCj4gPiArDQo+ID4gKyAgICAgICB2cF92ZHBhLT52
ZHBhLmRtYV9kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsgICAgICAgdnBfdmRwYS0+cXVldWVzID0g
dl9tZGV2LT5tYXhfc3VwcG9ydGVkX3ZxczsNCj4gDQo+IFdoeSBib3RoZXIgd2l0aCB0aG9zZSBj
aGFuZ2VzPw0KPiANCj4gICAgICAgICBtZ3RkZXYtPm1heF9zdXBwb3J0ZWRfdnFzID0gdnBfbW9k
ZXJuX2dldF9udW1fcXVldWVzKG1kZXYpOw0KbWF4X3N1cHBvcnRlZF92cXMgd2lsbCBub3QgYmUg
Y2hhbmdlZCwgc28gd2UgY2FuIGdldCBtYXhfc3VwcG9ydGVkX3ZxcyBmcm9tIG1ndGRldi0+bWF4
X3N1cHBvcnRlZF92cXMuDQpJZiB3ZSB1c2UgdnBfbW9kZXJuX2dldF9udW1fcXVldWVzKG1kZXYp
LGl0IHdpbGwgdXNlIHRscCB0byBjb21tdW5pY2F0ZSB3aXRoIGRldmljZS4NCkl0IGp1c3QgcmVk
dWNlIHNvbWUgdGxwIC4NCj4gDQo+IFRoYW5rcw0KPiANCj4gDQo+ID4gKyAgICAgICB2cF92ZHBh
LT5tZGV2ID0gbWRldjsNCj4gPiAgICAgICAgIHZwX3ZkcGEtPmRldmljZV9mZWF0dXJlcyA9IGRl
dmljZV9mZWF0dXJlczsNCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29y
X3Jlc2V0KGRldiwgdnBfdmRwYV9mcmVlX2lycV92ZWN0b3JzLA0KPiBwZGV2KTsNCj4gPiAtLQ0K
PiA+IDIuMjUuMQ0KPiA+DQoNCg==
