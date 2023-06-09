Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F092728C92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbjFIAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFIAm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:42:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82430D6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3AHKPKjOjuwjbLizoqksRRscJPvEMqoUvbEVZ0jVNjrUC0mWTF5LfH+6oI9bfVsnyQz2ZDVkoo78fOZSkoDANMse/xvVQEYZGwLXCEry8H49EzVr3iyHBqvWD18Af/SZrLohJEQSPxSHJaJpLa0XvjcKRsCqVu6KVnUFSn3/HVraidIyoVWjXm6TXSnHteL1iW6s74tMTc2r2VORWb7hl9Av7mB5cbwmJfjgOTX7EOyJI/p4naON6CZaSS00go8zqI+RLaYv4AuHdN21DBq8S9mSzkQU1gRU1vjDbvlv08Rcf7q5UbYL6t+3PKqo2cgwejHME9M9Rq36inVanRNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJZg9WNNNLjUjstiG4Q1/IReE/c4KL/0ijxcqx6b2gk=;
 b=BykmLf6+yrUPqVuRyxm11atz5Z0PFOUiflQsxeycSbF+XrkAzMFRvdm2OOEiwWU3WaubH+pkcWmVEz4D6HMPVssdpgo8RRpHWmQo6dGT1T2J/TIAvfg90gPYj8xKjVy4nZKtS9I5duTL4DWDBIw/mi63IRMVrARf8tIrktwLYh0FjxZn+zkhnThGT1IWL17kGtHTO+vHbCMwxRsZtwzQf5LTL03x7ys+jZBjEsz/0jVUNBRONQE8vKANBVnDZqXzPUfJ1AG/JNL/qwRQ6gvmXnmo17rb0tlwoR1uB331afoqXJ6JN+Qrr57N6A16+wObWL6UoxDo6jAxyawwxzTLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJZg9WNNNLjUjstiG4Q1/IReE/c4KL/0ijxcqx6b2gk=;
 b=GSaZ0V6m4YlnB8K8m35K7p1Q6Q9KCFE5ziOIHv/fpgweo/kotT6MlnjvPaaiO8nedWAyiL+qwAO2IeHSfNyx7TPhhMU6Ajwfos0W2H+7TbSaO9wAvnrtIfxU/a3tH/K7rTHsB+Nd3k+SLswFOeJWQRl3wnnumWKXZ9aaODfugyCGsK82CoiVl1kNKYBWIuuqUPC5CeajO1vKw8qTCMZMOFM+WWw2fWcY9pgn+baR2xy8NxFEHHrp+WteXb3FBB4IW05RX+op+VGta5cy5ofevVD6EzhA5q+RqDO+XD9fYoCS7UjkAxMN6/Qm7K2cwV/4fKvVeKDGmSkrwCzz/krnZA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB5074.apcprd06.prod.outlook.com (2603:1096:400:1c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 00:42:22 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 00:42:22 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Topic: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Index: AQHZmefhGgrgL1M5iUCr+LYolFSqU6+BT5cAgABRsWA=
Date:   Fri, 9 Jun 2023 00:42:22 +0000
Message-ID: <TY2PR06MB34248F29ED36A5DBB4FE0E2E8551A@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <20230608154400-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608154400-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TYZPR06MB5074:EE_
x-ms-office365-filtering-correlation-id: 4c28512a-20cd-4317-b8fb-08db68826363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CW0dgrkUNWUvfb2X1ZAiXfsZDnu4HCkhRpj0Xt33SqS+9Uw7jESOyL9RB5Iq8KbSNqq61UwpCe0NGR9pPYgOEZDXlYydBtud16QpIji8lL4+reH95hdWmfp91XHuJL5OfIRhBqFGZTeqjaAydlypN5W9viB2z6wyzQqv9aAIoJ4kEFtlBn+jCMP71c+bZvDEOpBXn257Kk1vYmet746OoLd5ikk3E2pFAMHZX+J+P3e5V9VonMZLXUYm3uft3pXPpvRI6desg1dgZHtmEvx4EF7SBiPqedwBrL48g+2AOe2EyVkO0BOJ3NAHi8C64W3aIrts5o41WBlmBRZWjtY2Hh9/SAK+Ry8cE6KI/TxM3oFb12qJwejbiHSUVsuTppdy4AgjCYXP+sCVdRzs66Rs7OG/oRhjXcz3LUsWlhcgMis/g6kpMM/Y9vz5vY3CYcrTrVzLHzkw8DIC+d5XrUsqf7yFXvW+cgA39h5hGdeTxRcuAkO1m1lr2VKtee4n0ZZoklbmhybaOOdYBlO/BQ9CD8evwOkABIrgvj6AT3QJDsRv7uuuOKfXo2xIfoPWO8Ewxq8oRKYnKV6XE9w3ePb4E9AuGnk0SrY28kxa6em9HvwWVIQT4D4QnWEHnUTs9Vvo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39830400003)(136003)(396003)(346002)(376002)(451199021)(33656002)(38070700005)(86362001)(6506007)(38100700002)(122000001)(83380400001)(316002)(53546011)(186003)(7696005)(71200400001)(54906003)(66946007)(5660300002)(52536014)(8936002)(41300700001)(66556008)(66476007)(64756008)(76116006)(6916009)(4326008)(66446008)(8676002)(478600001)(44832011)(2906002)(9686003)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlRyYnVwR2pWdk5WVUpmWUwwRmU5YUJ0MEdUZFpQUTBqWmVQR0o5VFdiN2Nt?=
 =?utf-8?B?KzVGKzFpQzJ2cWVWVVZBU1owZTVocUhaN1FNazVQd3RpdTMzVG5ocStmRG5U?=
 =?utf-8?B?aDhRWmJ2UUZ3aEdMTzRrQ2pCejcwM2FpRmIrZGp1UlJybUVER2ZnRHBSSXdK?=
 =?utf-8?B?Q3FNN1dsTklvdEFjeTRXWGtZSGRLa2xRZHJlWG5WUGVDaUU3R2IxMDk0eG9y?=
 =?utf-8?B?eFl1SEkwdVJsektYVU9VUE1WNUczayswUlBtc0tXaXVlQkt4V3FBeXZkZUQ4?=
 =?utf-8?B?RVZBdGNxR25FcHJrcXF1eGFjallGMWpkV2k1Q0ZMckRCV1ZZSmlxNllNS3V4?=
 =?utf-8?B?NXk0ZUovTWIzbDJHbTh4eHFHalV6WXpEekE3Z1dpdWlhakw4UnlURnpVeGpo?=
 =?utf-8?B?MG8wK2lhWSsvcXhsMlZHY3E4VUphY2hRQ3JPOHNYV1hxOW5JU2JoSjRYRkd2?=
 =?utf-8?B?SWhaMGQ2VTUyVzhBWTZucGNHL1NKOUhIYmxUamkrcGo3TXEwL3I1VGc3SUZy?=
 =?utf-8?B?T244MFpZaFgxaURaUTYzZG1ITU5QOFhSbjJEb1hPczhHVERPQmxyb0RoRUpU?=
 =?utf-8?B?UUROREVCNDVYbGtxdXAxNDFVYTFaTDNYWnNnTS90TU54TmpJQmo2K3paTXMw?=
 =?utf-8?B?bXBPdFFxOFJNOHEvQThwSUdNekd6WEZIS2J0UmM4QnBSeFFuU0gvM3Vwa0NV?=
 =?utf-8?B?d3JzbXpsWHBNampUZXlvV1ZFdEpDbm9TaTlIYUpPRmNaY2tnOEdkTndBT0wz?=
 =?utf-8?B?a0UrWWJGODJYZXM1L084T1BPZnoyYlpmU0ZpWXp0ZFRJZElOSWtkcmN1T0o0?=
 =?utf-8?B?ZlFiUTRDb0Fybk10UXJyTHBEOWZocUEyNkNGYUhhMzA4UDhKYnZCc3RZZ3NO?=
 =?utf-8?B?N3liWko4OVVpNFBsVmNqbndKV2VLSW45SHBWTXQzSmNJZ1lhSHZMMHd1YkdY?=
 =?utf-8?B?UitoY2l4V0loTTFzTlRkNWx2ZXE4SEU5SEMzTUpENVZqY0h1aHA4YksxYTIz?=
 =?utf-8?B?YXprMFh1T0dtV1o4dEVkcjZ5SXExc2NneUJKa2hUcWZ0bVR5aWhGK2Nscngy?=
 =?utf-8?B?NGw3SFZsU2prUTZjZW8vYmZzTVUyMnVIeUxrV3JXVzJvWWUvK2RZdjZaRS9V?=
 =?utf-8?B?L3RDdFc2OEIxRVd4MGYrbkpJT0NGT0IyK0ttWkFuSTkxRit0WlBYcVZhTVU0?=
 =?utf-8?B?MkxJVlZBdUpCeFpYY0tMWnZWVVR6Nmo3Mk5BaDBBM1F3SjZDWnhlVGY3OGtL?=
 =?utf-8?B?ZHhnS2VYT0xuUEJWTXdyT2FtRDBYaFdJekpSMHU4N0dicWxDRkdqSlRuOGtY?=
 =?utf-8?B?YkwreTQzWVdyUTNXRHJTK1A3RDF4QzRQblpEQS8rbnJlbU85UXd3MmhBTnBW?=
 =?utf-8?B?c1VPUjYyRWtEL2pMcE04Z2NUd3NEL21CWCt6eTJnOEYvdWVjU3FlQm5uZ2xM?=
 =?utf-8?B?ZzNLVTRwbllUcXY0M2oybUJjUEUxVllJdXhYeHBCMjl1SDVlVlE0OTBaVkk3?=
 =?utf-8?B?R3diNk5UM0FxaDZBQ1FtVU5YY0FJcTBQSDF5Tno4cGtQM0tSV2VmZjR5MlJ0?=
 =?utf-8?B?L2traU1pbUFrTzRQb0xzbGdWNU9PSDVUVXNHUXNxbkZUNGpkd2xpVGw5U25B?=
 =?utf-8?B?N3M2cFV4R0E3Ri9XMGwzdlFSdUU0b2tWeWthakVsZkNNSXNVbis0SjhaT3NW?=
 =?utf-8?B?LzVVUkw5OGdOcEwyajlodXBaNkV6RDI5cFEzRXJhamR3WE5WRHZoelgxV1My?=
 =?utf-8?B?TnU1OTYyMVM2UXgvUFJ3L2YxQVNaa0puZElpcjRlWEpwdXBFdHIrb0NBY1JQ?=
 =?utf-8?B?Q1pIYU53elpmK2VwQUQrV0R0ZEl6ZlVIa0hlazRteFVWQ1VOV3JHWHZJSTZL?=
 =?utf-8?B?cDF1YlIwTFBtVm9TSTJBMHd4RVRNTElMWmU0NnZKcXozNk5KalAxV1I4VGNI?=
 =?utf-8?B?eTFvUDVKbVRtTnUyTFp0RmtQQXkxSklpS2ducFhUMFNOZlN6blovampLOWo4?=
 =?utf-8?B?VFdySXVhcm9ETGxMRzZwQ3VYWnpBTVkxOTZNQUdwUWo3SGhhazJoYjdLVStF?=
 =?utf-8?B?WVFlUHhLcXd4MlNQb204eEpLbEtBbGx1Q3pTdis1bkVYZklXUkkwRld5eHY0?=
 =?utf-8?Q?EihwUoW+Vjw1a7TLItc6DLv4G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c28512a-20cd-4317-b8fb-08db68826363
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 00:42:22.5312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+ZKCEClriQlZiqlMEuTkIck6Thfg644HUxt8CfTrWu+Nje7f8eWyz95KbKCyf+vIKlbM/AtvJnSWNaNeohDJ2+RjHfBH56Atiyv8pumSjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDksIDIwMjMgMzo0NSBB
TQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENjOiBq
YXNvd2FuZ0ByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyXSB2ZHBhL3ZwX3ZkcGE6IENoZWNrIHF1ZXVlIG51bWJlciBvZiB2ZHBhIGRldmljZSBm
cm9tDQo+IGFkZF9jb25maWcNCj4gDQo+IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjAxOjI0
UE0gKzA4MDAsIEFuZ3VzIENoZW4gd3JvdGU6DQo+ID4gV2hlbiBhZGQgdmlydGlvX3BjaSB2ZHBh
IGRldmljZSxjaGVjayB0aGUgdnFzIG51bWJlciBvZiBkZXZpY2UgY2FwDQo+ID4gYW5kIG1heF92
cV9wYWlycyBmcm9tIGFkZF9jb25maWcuDQo+ID4gU2ltcGx5IHN0YXJ0aW5nIGZyb20gZmFpbGlu
ZyBpZiB0aGUgcHJvdmlzaW9uZWQgI3FwIGlzIG5vdA0KPiA+IGVxdWFsIHRvIHRoZSBvbmUgdGhh
dCBoYXJkd2FyZSBoYXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1
cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gDQo+IEkgYW0gbm90IHN1cmUgYWJvdXQgdGhpcyBv
bmUuIEhvdyBkb2VzIHVzZXJzcGFjZSBrbm93DQo+IHdoaWNoIHZhbHVlcyBhcmUgbGVnYWw/DQpN
YXliZSB3ZSBjYW4gcHJpbnQgZGV2aWNlIGNhcCBvZiBkZXZpY2UgaW4gZGV2X2Vycj8NCj4gDQo+
IElmIHRoZXJlJ3Mgbm8gd2F5IHRoZW4gbWF5YmUgd2Ugc2hvdWxkIGp1c3QgY2FwIHRoZSB2YWx1
ZQ0KPiB0byB3aGF0IGRldmljZSBjYW4gc3VwcG9ydCBidXQgb3RoZXJ3aXNlIGtlZXAgdGhlIGRl
dmljZQ0KPiB3b3JraW5nLg0KV2UgSSB1c2UgbWF4X3ZxcyBwYWlyIHRvIHRlc3QgdnBfdmRwYSxp
dCBkb2Vzbid0IHdvcmsgYXMgZXhwZWN0Lg0KQW5kIHRoZXJlIGlzIG5vIGFueSBoaW50IG9mIHRo
aXMuDQoNCj4gDQo+ID4gLS0tDQo+ID4gdjE6IFVzZSBtYXhfdnFzIGZyb20gYWRkX2NvbmZpZw0K
PiA+IHYyOiBKdXN0IHJldHVybiBmYWlsIGlmIG1heF92cXMgZnJvbSBhZGRfY29uZmlnIGlzIG5v
dCBzYW1lIGFzIGRldmljZQ0KPiA+IAljYXAuIFN1Z2dlc3RlZCBieSBqYXNvbi4NCj4gPg0KPiA+
ICBkcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCAzNSArKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAx
NCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlv
X3BjaS92cF92ZHBhLmMNCj4gYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4g
PiBpbmRleCAyODEyODdmYWU4OWYuLmMxZmI2OTYzZGExMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmly
dGlvX3BjaS92cF92ZHBhLmMNCj4gPiBAQCAtNDgwLDMyICs0ODAsMzkgQEAgc3RhdGljIGludCB2
cF92ZHBhX2Rldl9hZGQoc3RydWN0DQo+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hh
ciAqbmFtZSwNCj4gPiAgCXU2NCBkZXZpY2VfZmVhdHVyZXM7DQo+ID4gIAlpbnQgcmV0LCBpOw0K
PiA+DQo+ID4gLQl2cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IHZwX3ZkcGEsIHZk
cGEsDQo+ID4gLQkJCQkgICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsIGZhbHNlKTsN
Cj4gPiAtDQo+ID4gLQlpZiAoSVNfRVJSKHZwX3ZkcGEpKSB7DQo+ID4gLQkJZGV2X2VycihkZXYs
ICJ2cF92ZHBhOiBGYWlsZWQgdG8gYWxsb2NhdGUgdkRQQSBzdHJ1Y3R1cmVcbiIpOw0KPiA+IC0J
CXJldHVybiBQVFJfRVJSKHZwX3ZkcGEpOw0KPiA+ICsJaWYgKGFkZF9jb25maWctPm1hc2sgJiBC
SVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQKSkgew0KPiA+ICsJCWlmIChhZGRf
Y29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzICE9ICh2X21kZXYtPm1heF9zdXBwb3J0ZWRfdnFzIC8N
Cj4gMikpIHsNCj4gPiArCQkJZGV2X2VycigmcGRldi0+ZGV2LCAibWF4IHZxcyAweCV4IHNob3Vs
ZCBiZSBlcXVhbCB0byAweCV4DQo+IHdoaWNoIGRldmljZSBoYXNcbiIsDQo+ID4gKwkJCQlhZGRf
Y29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzKjIsDQo+IHZfbWRldi0+bWF4X3N1cHBvcnRlZF92cXMp
Ow0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQl9DQo+ID4gIAl9DQo+ID4NCj4gPiAt
CXZwX3ZkcGFfbWd0ZGV2LT52cF92ZHBhID0gdnBfdmRwYTsNCj4gPiAtDQo+ID4gLQl2cF92ZHBh
LT52ZHBhLmRtYV9kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+IC0JdnBfdmRwYS0+cXVldWVzID0gdnBf
bW9kZXJuX2dldF9udW1fcXVldWVzKG1kZXYpOw0KPiA+IC0JdnBfdmRwYS0+bWRldiA9IG1kZXY7
DQo+ID4gLQ0KPiA+ICAJZGV2aWNlX2ZlYXR1cmVzID0gdnBfbW9kZXJuX2dldF9mZWF0dXJlcyht
ZGV2KTsNCj4gPiAgCWlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FUVFJfREVW
X0ZFQVRVUkVTKSkgew0KPiA+ICAJCWlmIChhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJiB+
ZGV2aWNlX2ZlYXR1cmVzKSB7DQo+ID4gLQkJCXJldCA9IC1FSU5WQUw7DQo+ID4gIAkJCWRldl9l
cnIoJnBkZXYtPmRldiwgIlRyeSB0byBwcm92aXNpb24gZmVhdHVyZXMgIg0KPiA+ICAJCQkJInRo
YXQgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZTogIg0KPiA+ICAJCQkJImRldmljZV9m
ZWF0dXJlcyAweCVsbHggcHJvdmlzaW9uZWQgMHglbGx4XG4iLA0KPiA+ICAJCQkJZGV2aWNlX2Zl
YXR1cmVzLCBhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMpOw0KPiA+IC0JCQlnb3RvIGVycjsN
Cj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIAkJfQ0KPiA+ICAJCWRldmljZV9mZWF0dXJl
cyA9IGFkZF9jb25maWctPmRldmljZV9mZWF0dXJlczsNCj4gPiAgCX0NCj4gPiArDQo+ID4gKwl2
cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IHZwX3ZkcGEsIHZkcGEsDQo+ID4gKwkJ
CQkgICAgZGV2LCAmdnBfdmRwYV9vcHMsIDEsIDEsIG5hbWUsIGZhbHNlKTsNCj4gPiArDQo+ID4g
KwlpZiAoSVNfRVJSKHZwX3ZkcGEpKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJ2cF92ZHBhOiBG
YWlsZWQgdG8gYWxsb2NhdGUgdkRQQSBzdHJ1Y3R1cmVcbiIpOw0KPiA+ICsJCXJldHVybiBQVFJf
RVJSKHZwX3ZkcGEpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXZwX3ZkcGFfbWd0ZGV2LT52cF92
ZHBhID0gdnBfdmRwYTsNCj4gPiArDQo+ID4gKwl2cF92ZHBhLT52ZHBhLmRtYV9kZXYgPSAmcGRl
di0+ZGV2Ow0KPiA+ICsJdnBfdmRwYS0+cXVldWVzID0gdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3Zx
czsNCj4gPiArCXZwX3ZkcGEtPm1kZXYgPSBtZGV2Ow0KPiA+ICAJdnBfdmRwYS0+ZGV2aWNlX2Zl
YXR1cmVzID0gZGV2aWNlX2ZlYXR1cmVzOw0KPiA+DQo+ID4gIAlyZXQgPSBkZXZtX2FkZF9hY3Rp
b25fb3JfcmVzZXQoZGV2LCB2cF92ZHBhX2ZyZWVfaXJxX3ZlY3RvcnMsIHBkZXYpOw0KPiA+IC0t
DQo+ID4gMi4yNS4xDQoNCg==
