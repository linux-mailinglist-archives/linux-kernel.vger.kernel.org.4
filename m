Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18785FE613
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJNAJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:09:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE7E199882
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he/cxwFDd8hWrNJ2ZIG+j5nv8zDiGpTuPIW+C8wt9hdRow6KL7G4X1IlNXop/h1qFMnElIECARKUrnqGdnoIhX7t8ekz1dySr+lExdahYdNgv17nkjAIudA6798zyH8R+wBau1CDc7Ov3lHqApNmRbe+1FS7+BXGS6a98ijIzZwtyeLpErt3hKO8hFSZcu+H6BV+61UaAm/j+NcSa/Zbswyj500AgAe0TjPpOuEfanMWnjnPNGNAcyRolvZOCgfIGvXW/asEzAXaMZ9cwlsQSPTvBRIK2JrE1LUUyW16f4Fn+cfl+6dcJ6iPraG8crOnoY0+DIv2kZjONiJ6BNX48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urGcxZh1hBvPhMr9HRntkdJzjXfzX3WzJm+9UjQvIno=;
 b=kA/S58gvN2MaWB04F+hjWYfkx7u0NHONMbeB+TERs09ickQJ9uJMdNqQIyeT8kTzfov/L12TA8J7qSP0jZkssyNIxv0urZ4CH7D8fy/1qY5keDU29lTe5lnmyxStoi5jhZrqdDWHdbsFiJD9dmb8/LBYag/tP0bGriVzPYqqtsua1bneSaEmL5tpRp0hoG1LBlg4VdDM+H0LHSFBLa+onDHaJL+jfySiq7alB+oKo9CSSUtkHsefDlqaYs1I2/UwyNCFNsFlSMN9cjiI4u5yX8aj4eFU+K6hEOjr3JQz/7ENOCyzYyiLy3uueNRzXE7rAjzu6PYK2qyv2yV70Ywydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urGcxZh1hBvPhMr9HRntkdJzjXfzX3WzJm+9UjQvIno=;
 b=iVWhEjlBiyiNK32BXbRWWkd6LNOd00cdB2pkKtrzKs08WnsbAsjEqbG5s6hEs49vTT4xf83O24Vvea3RBtGIxLnoHBKc/tQk+8v5ShkWCu1XBTX6qx1JOL4NFjOoWzPRKxObosk9BDaXbym0hIps6E6nmx9SeoP89BgQkIQScpQSe7BdC8Oag8lQ6Y9NXnhIvysKGcBebTYCPMInwZ05UBEgcpU2AOGl+HewaB3G4o0jiiExWORu3iohiqX/8Nf7j2gSl2pWIPkUPYaUB1YLsAyUs2O9KuW+cNENUJFOmuXv4hu+5gZZ9RrhcZ99ByryOnQIMdltrMorxhFFtYjebA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TY0PR06MB5659.apcprd06.prod.outlook.com (2603:1096:400:275::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 00:09:19 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5709.021; Fri, 14 Oct 2022
 00:09:20 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH] virtio_pci: use irq to detect interrupt support
Thread-Topic: [PATCH] virtio_pci: use irq to detect interrupt support
Thread-Index: AQHY3oaSvnjJONZcVEWGOotcO2IZka4NActA
Date:   Fri, 14 Oct 2022 00:09:20 +0000
Message-ID: <TY2PR06MB3424171328BEE476FCB9942785249@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20221012220312.308522-1-mst@redhat.com>
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TY0PR06MB5659:EE_
x-ms-office365-filtering-correlation-id: a1cd7383-850d-4fe2-0d9c-08daad7857e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F10JHj7n6QybIrnclpuj0uyWdEXuA53q5j+R42ocS5M88r3Ff5cH5fWbL8yyCjfPzPg6LyOhmTLZ47mXWyh4lg3ga+A8ZN392OhDlOpaXcq5FV8ZeZsevXZJOBKnGcBCItzi4MYiBsnCJw06aHzA2LwJEox6VtlkH7VFBDa9u3IA62ZH1gcOW9xoFzQJbnQvy/AAFjB7MjV3tOvyoOYJtcwc7clEtG5ycIChmfogih5ZOTyJZSCPiPsTpaKHy3kWhwOURkgPTcLIQk1mTuXQoWICDvtaIaFxxfZ+7qhrR9zHt6ag9UXxuxtWaf6QwHt3i3NVlO51+ZGbZ81Os7/Ws4nYT1+qtslex50q7wSLaJb4PKDn3I0/K0ejnm+L6TRRJXX2ql34iay3Q6ENkvmXhB7KctFg+zZPcRr+fwLBGsPZnL+QEVOIH/smQW5rfCPMVFBOiwsekQFDzY8cJQZ8d0/MWXQpufGx2t5YVmMI6ImuCzSMxgVgpFZ7yGokln4g2/u0UrwdFhDMyzpdinZLm4TC+t0lzIU8+oWXXnSlvSmY5mrqm4pTxJv7kN1uvwJedmkpxANVYdhgBTN1FtjVbFUpla7TILshPoSJpHB2pn78aHVXuAGBVf2VZNvgln6H1RDAgOSeHvmwt+jD76vhkFClX3PUAxU85wk/VofBmkTJUR60TTnLXugFXv8eBVNUI0nEox78qNgicPld7BNaZcAUZrcQ9pbIoCY++b9GET8Gm4nz8NiZzlzSXXr/8fq5TVcl2EyqhExVsvHT/G4qkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39840400004)(396003)(346002)(136003)(376002)(451199015)(33656002)(5660300002)(478600001)(38100700002)(76116006)(44832011)(41300700001)(64756008)(66476007)(52536014)(8936002)(2906002)(66556008)(8676002)(4326008)(66946007)(66446008)(122000001)(54906003)(55016003)(316002)(9686003)(26005)(71200400001)(110136005)(83380400001)(7696005)(186003)(38070700005)(86362001)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlFVOHF0TzBVQ0lLOFpscWEzNE1vYXFURDY4czMzS1g0aUVPbld3SThsN3NZ?=
 =?utf-8?B?SzUvTGozck04dEZVTzlPRlIxVUNBWVdGRkVxSDJSa2FjTmZ6aEZwa0hwYldS?=
 =?utf-8?B?dmpzNjRrNjdZdktYN1hscHY3ZGJkZ3dENXJ6ZU1uT0k1Uzhkdk5odk1pbkZN?=
 =?utf-8?B?VktNODh5WW9aY294ellnbEVEaTRoS2dqUWczREQvWkJTRi9uUEpWTnFDejNG?=
 =?utf-8?B?WXhOalJiZk00NkxSelMwZU5ndGo4Ymc0cjljS0JiQm1xdGpVYytmb09pUGZ5?=
 =?utf-8?B?bzBHYk9uL2ttVE1uTkhTdmF1Z2RvZjlNYUJ3aHNucVZmQ05YcjZCOTdWRGJC?=
 =?utf-8?B?Rm9FbTM3M1BMb2VuMGZ1ZEd3K0RPeHE0Zjl3QnlnNGhMZzEzQ0NMNXVTTGN6?=
 =?utf-8?B?cmZRaFRSM1NzUEJSM3RtNmJ0VlIxam9Tekdod0dZUCtzZGRPR1BpcUxTRk83?=
 =?utf-8?B?MlVMTU5vdEd6UEJodGNSY0ZpVG0yZjRZRVJzYVFHK2IrVFdBY25DdkdMZWhU?=
 =?utf-8?B?Y2wra0FFTlZ5UTNoVHlyVkVzaHRaRjBTOExWaWY2OGNiOWJZRUdyRzlieWkw?=
 =?utf-8?B?OEJXbTFnUHE4cEdDdlV5MmVxb3RrR2JkcndsM3dRZHV3RVc3VnFxRSs5eDNW?=
 =?utf-8?B?T3lVT0wzb2dQTnJQanhKMStJVU5HWWxwWG41S0prQ3lnTUNLZzkzTEJZeTha?=
 =?utf-8?B?Z3paOXRxM0JsZlArNXcwcFlpTzY2ZmpwMWZ3TmFPY0RCMXdGUDVTcjlXalJa?=
 =?utf-8?B?aGk4bEhQaWVlY2g3RVFkK3ViREoyZjE5eW91YU5uakVEeWNERTBseFNzOE9Y?=
 =?utf-8?B?MnliYVpQNnhiRGNLdXd6U2cyRFdVd3VWNjdXNlpkdmM1VjBEWCsvTmQwYTlh?=
 =?utf-8?B?Q3Zuamt6ZVNKT0hSNGwxdzNOc25Cai9WSjV2R0lPVGk5SlpCaVhxc0F3QzR3?=
 =?utf-8?B?L2tzVFF4V0RwOHRXaUNPMXBEcjZMOHlhMHhIbUtnMHVjcWtSalgwaGZaTDNI?=
 =?utf-8?B?OWNGSDU4MDdLWlp1ZmFpZHpnOUtyZkwwLzVpa2kxZml6MVk2RUg5aWpENTRz?=
 =?utf-8?B?d2lMcHlCTVZYMUZJYkpObjBSNisveFh1VkNReHRUMEFwelBpNVUvTEFkM2lu?=
 =?utf-8?B?UHhtSHBRa3BpTTU5QzZjTkdpYll5YXlTL2wrT2xMTDZFVXNVckxkU2ZBWlJy?=
 =?utf-8?B?WlVBdnRXSzVTck53WlJsS3NsLzhnTHAyOFYyenJYN1JyYUJGcnZGMk1EL0Uv?=
 =?utf-8?B?NW9iUnEzZWhIVkxPWDkzazJzbHNZSGQ3b05UQ3ZscEFiWSt0QXdBWldBQXk5?=
 =?utf-8?B?YS82VzNtMUR5R1JuOUZNN1ZnWjZ2SEpiV2hXa3RmVzErUFIyWjlaQU1EbEZN?=
 =?utf-8?B?TDh5Nmo3SVB0RVdoUDgxUFRGcXpjdHNOUFJTemNZV3NlbXlhN0FsbXBEanR6?=
 =?utf-8?B?aHdEUUQ4aTRaeU52L2tPZ0tXREZDR2FJMHJ5b3pZSFplS0JDUy9USS9TMjFZ?=
 =?utf-8?B?cktlanFnbFh4MXR1Nk9va2wwSXhPem1xQUVJdi9JeUVsTDZlNG1SZk5BNmxR?=
 =?utf-8?B?M1QrZHU3djl5N3lXdlRJaDFjcFNkVUYrQjcyeWVuOHdjejE0Vks0ZXhZanFz?=
 =?utf-8?B?aHhUSTZyS1M4TnZwcDJ5aWFXS2U1YllxQml5UnlyTlpXZnNOclN5SlJ6aFNE?=
 =?utf-8?B?OGFIakNNZ3RBODd6UGF2S2pGek1lSGs2MjVDMHM4N00yRGV4cWhucU5NdmZm?=
 =?utf-8?B?T0xKaFdTQlhlanN2bWtlTnJkTTFvL1IvU3JmN0VZNjB0dlBGbklvWERjN3Nj?=
 =?utf-8?B?QlRLb2p2U1hVM2tOeTVUVmxSZkZ0eWhDSlk1Ukh5RHhTV0lkU0xvS3I5S0pm?=
 =?utf-8?B?OXZUT1ZHeC9RM3dPKzN5ZzFEakx5ZEVUOGhFeVhtaHp3aW9scW1aOEJCWFBi?=
 =?utf-8?B?WWMwL1NIQk1kN2FHVFhBTE1hQXQ1emozVnhuMFRYaFo0MHpjbFZZVFV4dWJs?=
 =?utf-8?B?bjA1UjlKN0dwSmthRSs1bXdaajByTWNHQmtCMkZ2Y0dzV3plOUtXWFp3L05O?=
 =?utf-8?B?TE1heG5vTXRTS3JQb1JZTUhtUkpENloxWDBIVmFrQzA5c3FRM3BHNXgwRy8y?=
 =?utf-8?B?bHBCUmRWZXZBUzVRaWl0YVAxWmpjNTFpU3VlL0hzSTArak5Tb05XOGJtdGth?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cd7383-850d-4fe2-0d9c-08daad7857e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 00:09:20.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuKjr6rP608Di/6kNm7NIbUpa24YwANrUUM9vyv4+62qoOuoD1UgjZpaeKk/+soNhK5RFuczR8LXV79gKKMDmL2LakEa2+ILR7/IlDMDlU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXN0DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTMs
IDIwMjIgNjowNCBBTQ0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
TGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTWljaGFlbCBF
bGxlcm1hbg0KPiA8bXBlQGVsbGVybWFuLmlkLmF1PjsgQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+OyBKYXNvbg0KPiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgdmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gU3ViamVjdDogW1BBVENI
XSB2aXJ0aW9fcGNpOiB1c2UgaXJxIHRvIGRldGVjdCBpbnRlcnJ1cHQgc3VwcG9ydA0KPiANCj4g
Y29tbWl0IDcxNDkxYzU0ZWFmYSAoInZpcnRpb19wY2k6IGRvbid0IHRyeSB0byB1c2UgaW50eGlm
IHBpbiBpcyB6ZXJvIikNCj4gYnJlYWtzIHZpcnRpb19wY2kgb24gcG93ZXJwYywgd2hlbiBydW5u
aW5nIGFzIGEgcWVtdSBndWVzdC4NCj4gDQo+IHZwX2ZpbmRfdnFzKCkgYmFpbHMgb3V0IGJlY2F1
c2UgcGNpX2Rldi0+cGluID09IDAuDQo+IA0KPiBCdXQgcGNpX2Rldi0+aXJxIGlzIHBvcHVsYXRl
ZCBjb3JyZWN0bHksIHNvIHZwX2ZpbmRfdnFzX2ludHgoKSB3b3VsZA0KPiBzdWNjZWVkIGlmIHdl
IGNhbGxlZCBpdCAtIHdoaWNoIGlzIHdoYXQgdGhlIGNvZGUgdXNlZCB0byBkby4NCj4gDQo+IFRo
aXMgc2VlbXMgdG8gaGFwcGVuIGJlY2F1c2UgcGNpX2Rldi0+cGluIGlzIG5vdCBwb3B1bGF0ZWQg
aW4NCj4gcGNpX2Fzc2lnbl9pcnEoKS4NCj4gDQo+IFdoaWNoIGlzIGFic29sdXRlbHkgYSBidWcg
aW4gdGhlIHJlbGV2YW50IFBDSSBjb2RlLCBidXQgaXQNCj4gbWF5IGFsc28gYWZmZWN0IG90aGVy
IHBsYXRmb3JtcyB0aGF0IHVzZSBvZl9pcnFfcGFyc2VfYW5kX21hcF9wY2koKS4NCj4gDQo+IEhv
d2V2ZXIgTGludXMgc2FpZDoNCj4gCVRoZSBjb3JyZWN0IHdheSB0byBjaGVjayBmb3IgIm5vIGly
cSIgZG9lc24ndCB1c2UgTk9fSVJRIGF0IGFsbCwgaXQganVzdCBkb2VzDQo+IAkJaWYgKGRldi0+
aXJxKSAuLi4NCj4gc28gbGV0J3MganVzdCBjaGVjayBpcnEgYW5kIGJlIGRvbmUgd2l0aCBpdC4N
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5k
YXRpb24ub3JnPg0KPiBSZXBvcnRlZC1ieTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFu
LmlkLmF1Pg0KPiBGaXhlczogNzE0OTFjNTRlYWZhICgidmlydGlvX3BjaTogZG9uJ3QgdHJ5IHRv
IHVzZSBpbnR4aWYgcGluIGlzIHplcm8iKQ0KPiBDYzogIkFuZ3VzIENoZW4iIDxhbmd1cy5jaGVu
QGphZ3Vhcm1pY3JvLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IA0KPiBCdWlsZCB0ZXN0ZWQgb25seSAtIHZlcnkgbGF0
ZSBoZXJlLiBBbmd1cyBhbnkgY2hhbmNlIHlvdSBjb3VsZA0KPiBoZWxwIHRlc3QgdGhpcz8gVGhh
bmtzIQ0KSSB0ZXN0ZWQgdGhlIHBhdGNoIO+8jGl0IHdvcmsgd2VsbCBvbiB4ODbjgIJJbmxjdWRl
IGxlZ2FjeSBhbmQgbW9kZXJuIGRyaXZlci4NCkFuZCBJIHRlc3RlZCBpdCBvbiBhcm0gc2VydmVy
IGFsc2/vvIxhbmQgZmluZCBzb21lIHByb2JsZW0gYmVjYXVzZSBvZiAwLjkuNSBsaW1pdGF0aW9u
Lg0KICJwbGF0Zm9ybSBidWc6IGxlZ2FjeSB2aXJ0aW8tcGNpIG11c3Qgbm90IGJlIHVzZWQgd2l0
aCBSQU0gYWJvdmUgMHglbGx4R0JcbiIsDQogQnV0IHRoZSBlcnJvciBpcyBub3QgZWZmZWN0ZWQg
Ynkgb3VyIHBhdGNoLndpdGggb3Igd2l0aG91dCBvdXIgcGF0Y2ggLGl0IHByaW50IHRoZSBzYW1l
Lg0KQW5kIEkgdGVzdCBtb2Rlcm4gZGlydmVyLGl0IHdvcmsgd2VsbCBhbHNvLg0KU29ycnkgZm9y
IHRoZSBsYXRlIHJlcGx5Lg0KPiANCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9u
LmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uYw0KPiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMNCj4gaW5kZXggNGRm
NzdlZWI0ZDE2Li5hNmM4NmY5MTZkYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uYw0KPiBAQCAtNDA5LDggKzQwOSw4IEBAIGludCB2cF9maW5kX3ZxcyhzdHJ1Y3QgdmlydGlv
X2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50DQo+IG52cXMsDQo+ICAJZXJyID0gdnBfZmluZF92
cXNfbXNpeCh2ZGV2LCBudnFzLCB2cXMsIGNhbGxiYWNrcywgbmFtZXMsIGZhbHNlLCBjdHgsIGRl
c2MpOw0KPiAgCWlmICghZXJyKQ0KPiAgCQlyZXR1cm4gMDsNCj4gLQkvKiBJcyB0aGVyZSBhbiBp
bnRlcnJ1cHQgcGluPyBJZiBub3QgZ2l2ZSB1cC4gKi8NCj4gLQlpZiAoISh0b192cF9kZXZpY2Uo
dmRldiktPnBjaV9kZXYtPnBpbikpDQo+ICsJLyogSXMgdGhlcmUgYW4gaW50ZXJydXB0PyBJZiBu
b3QgZ2l2ZSB1cC4gKi8NCj4gKwlpZiAoISh0b192cF9kZXZpY2UodmRldiktPnBjaV9kZXYtPmly
cSkpDQo+ICAJCXJldHVybiBlcnI7DQo+ICAJLyogRmluYWxseSBmYWxsIGJhY2sgdG8gcmVndWxh
ciBpbnRlcnJ1cHRzLiAqLw0KPiAgCXJldHVybiB2cF9maW5kX3Zxc19pbnR4KHZkZXYsIG52cXMs
IHZxcywgY2FsbGJhY2tzLCBuYW1lcywgY3R4KTsNCj4gLS0NCj4gTVNUDQoNCg==
