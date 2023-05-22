Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16A70B42A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEVEoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVEo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:44:26 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A8E0;
        Sun, 21 May 2023 21:44:25 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2N5xY032235;
        Sun, 21 May 2023 21:44:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=dl1I6QC0drVtd/XFOUiCLqJJNatimnYIxzAxPAmPwUk=;
 b=SZEObFIGO7+dXUJNQ3364BrUr6k3ebdcQEU7dE32TVJ24HUv/1nUU9YNUopmfiT1sMaQ
 DUe8TQOxCeDXG5VX6aFSeg+lYWu+f0qu4uj205J4g/GYLCMmLHyYEZ8SHejhjK/EOe/O
 juYQlOqkMKkEbQpZd+VsmawA6jaamEhBzwGDVrO6M1X7CN5SFdj1qFGG49cslfVwO0zr
 2/aL95+Si8f5ef34+3/QPXsE+uBy9QRUW6gWGVaFVq/qDb7E1loDzHcC04HsFnxs7vjc
 C4+tg9vwUjQ2t7dBLyo3bbGH5TQz2Nc5dxsb3AQBRuQ6x6p4nXDeQAiV+44kA1ilp3UU 5g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpthrahu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 21:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTYnTNhl6hlIvwp9R2Y+1QV1UAkTwx9skpWe/RD1wKPyLtKm4N3tS6ElVnXL5ub0eigZSUVKg9OKyszbgkX2vHuos1KgN3BannVsulXqvtt6wAWnpp0wgafFQq+oZrtgIPWjCfsaaC7cSHOf0T46W6lHcd4mZRvG7ZopTt/ejtuIf24aqoOyDMB0afD04fbWF7khSAaUJyp/SXSUiDPHuuaFfU4miUjLpr5NhjGXjkYdpm4rR2tMhlyBz5oU2QPeAEUzPd+gIARqUt/STLT9S+4HowM/kLkWWh1I3JC5LeOSAHzCQluh1BK3k2hDHeUnp39xPz4e8gp61Srw/pkVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl1I6QC0drVtd/XFOUiCLqJJNatimnYIxzAxPAmPwUk=;
 b=kxMY89cQb1rghN/YrAZpTHQc7r2XBOJGhajwK8Kt+q7WXc5/qXdC3BO4Xozr0OwzbIKpFLhFpDdfP2ufdnuOMW41CMLc97lf19JhaWjnv5P9R6nP36fjBcWy1CfyQzlrZqz4xBvC9Gjt1pepnfuf4vA/Oqv3QCKydDaAL6uq+cxUP8FzsZODrMdRCWqrQbT5hiNL3379USTUsL5OGGHqEtPLZfVJueAlr72CS4/oZalFkqmZ059HBbLJ2Ro8t0XUJ5ekd2X6MofyjwTxmE25hFhCLmWmgFHvj4uNYDOXPpzIcB10BAV19IVGsF2/WOHoyHpO74cyt+oQfDj16tfsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl1I6QC0drVtd/XFOUiCLqJJNatimnYIxzAxPAmPwUk=;
 b=rTpattIeiMTVowQ5FMnt6fGj4QZBqdClmVupskEDgzv32XvgmI2wzQlupk3ScnafoYgft5aQQDyU//JIk1osV6myi9PuDc+41uIaQwcCnjT1zf4hIn6afay4q7WEcCvUQtLc/7mHEBJbAJ+BvTVSfPIix44ShruGyhCpL+6QoXuV4h27RGJPzPeZJWrpP1zAI6o3gdI4WW8LWCWaE88xy0HtBoS2wNiEYB9yTmuNzNq5ltg4elXGrHazWFIxbQEN2rCEgoALyMtBY0r20CrjCDqbibIQM04xr0/OiRnWpGiI1OGCEdP/WfhrbYZ1jE68Jn9bKxtNiwYHAF9Ulymo4w==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by PH0PR02MB7607.namprd02.prod.outlook.com (2603:10b6:510:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 04:44:20 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:44:20 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] audit: do not use exclusive wait in
 audit_receive()
Thread-Topic: [PATCH v2 5/5] audit: do not use exclusive wait in
 audit_receive()
Thread-Index: AQHZg8hzC3laSlFeP0CRyEYk44U9Aa9iILKAgAOn0wA=
Date:   Mon, 22 May 2023 04:44:19 +0000
Message-ID: <CB4B209E-8931-4FEC-A967-F3D50C0D7B1C@nutanix.com>
References: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
 <e9edf9db340cbf753fce43772abdef4e.paul@paul-moore.com>
In-Reply-To: <e9edf9db340cbf753fce43772abdef4e.paul@paul-moore.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|PH0PR02MB7607:EE_
x-ms-office365-filtering-correlation-id: ac9c95ea-ce72-4312-242c-08db5a7f3503
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGGxAwr+3TzASswuUF6d6WImiVQV062onfdmpN+95BpqZ08YdjtpGco8D/l1rR5MtWKqVXonYY6/zWImgWAffLIbKLDOw+jB2pKCuO9ab9dlBO7BX6mBsi6fx5/doI2qfqnaXoFTk2ee6xncU3whzcegZzB0nEF5CGDbnTVQlKePY+k1ccLlqSz6qAUnUDEvkmR+WjA/Vdm0DsMu7rqhNFZ3Ums3rBCVE1E8Mkn1eSGQoz+1m7lwOGoik9E1rqz9MbwmH68ZS/0YPYvb3xjJrICtT7oCIeViM9dDp/GnD036hZzW7zq7SPioJW+sXmOCgsgijmKt2OBS/F368puJEr2BkpWBDyEf0J4ptWI48ImLNOCCCupSng2WiCOc+c9qQDppiPJiZDpNPfgCIUqWKe2IzZDDcAeEAMSa1FemzobapFXF9zR0Yv5AYiUF4osqTg+pRlMD9VyDq51Hv1Hf8eUDuYklFg1c/shuPzRxUzdKHx50wX8XjxW6M6W4MwzDoxs5kh5a9M0KddmYFwYFc7AZFU11IqTx2KVoTFdqNZjaY8NWCbG9PmXRo20koc1HWTlMTLk15dOp+VtqisJ2spB90OlQFbbdh1lA2gmNeB73Ah88vITnOJYTqZQ7DN/y0xyyK9JCyuWDhafK38R+gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39850400004)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(44832011)(83380400001)(186003)(26005)(53546011)(6512007)(6506007)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(6486002)(33656002)(71200400001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(91956017)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk4xWmp6UjhsR1VRRkVQNEYxSHBxTy9LSUdLZ0VrSXduc1RkTWlVWU5sYlgy?=
 =?utf-8?B?VGlpMHBhVVltY0E1bGZYZGJLK0svWXp0UktXaTZXV0NsYXpTR241NUxRS0xT?=
 =?utf-8?B?YkoyTXNDZ1o2UHJvQlcxWHI5SHJqSGhDK25VMmplOFpKQVNaU2hNZytaRU9m?=
 =?utf-8?B?MUhBblhUQUhEV0laMkgzS2ZGRndkekVZV2pQMml6WUVyamxRL2VGTENIeSt2?=
 =?utf-8?B?c3d2MGVsTGMwNGZHVjFKblkzcC9yS2w0ZGlTS0h4Q2c2MkFjUk53MFN1Rnhr?=
 =?utf-8?B?UFRnemV5eVFNN1NCWlFOVFJsZ0cvWS9kOUsvUEpJN2NGWnF6OVYyMjRDSGhZ?=
 =?utf-8?B?RnlVVDZ3ajlTUXZZeWJocFJYdmo4dEZxQ0hycW5hVXhEUWQ2VW5GWDBmTWN5?=
 =?utf-8?B?QVVuc2c3clVBMGRqczROcWlXNWR6d0hFOGEyYzlPdUtzMytPemI0cFc1SEFL?=
 =?utf-8?B?NTRkcGdzVVZuVVAzcGVUQ1pLdFBHUmtzY085eHd4WkJhUEFYRlZBL3JicUNx?=
 =?utf-8?B?RStXdk8zTllRdUp0UjhWblJxU2I0alM4c082WjdJSUV5WGR1anJ3NW83K0Rz?=
 =?utf-8?B?bkdiMlg2Y1FpdDlCREcrdThUOTFMQTR3cS9EOU1XNmZFdHFIczlUQ0RrWWtu?=
 =?utf-8?B?TXIvRVpRdHZZc25Ta3QvblJMU0RYVXM1ZWh6SUxCcFJIMldDbWRSTmJ2MjJQ?=
 =?utf-8?B?RHRQa3c0UnBodkpQc3lXL0Y3cVgvamNpT0RTcDY2cFFZQWNhWjY4MkxoYUZZ?=
 =?utf-8?B?dnNmSE1lQXFKcnN3dk1Ha25nVWl2eUxROFBnU0dXcDdkVUVDbHZmbDcvaktz?=
 =?utf-8?B?cUZVSkZUaVhiZC82U1dQNW1HKzhKdjJ0KytLRk1NVUgrMzVObjZXSmNKcXkz?=
 =?utf-8?B?eVFGbzBUNy9SL2dWYVRyMmpCbnhxMXlGUnk5dGlxTys4OWlqLzRMMUpTTWIw?=
 =?utf-8?B?ZFJ1cE0vdGwzUDF1UnI0UFlJU0YyZ29OZUJkSU9RSDJqZXI3T2h6VWo5OUo1?=
 =?utf-8?B?L2JxbUlMTzRaQmJ1RWFncTdSZndNRkFEVmZaVW5RSEJoZFI1ZE5rL1p5Wkc3?=
 =?utf-8?B?M2hLZkhvajhyRlhJRFk0VHI5YWNmamxDaDhLZDlJVG1xMzNrSjMvQ3B6UmtT?=
 =?utf-8?B?bkV1U2pxS3ZSNUVnNTR0cm9JbWdvSlhxVUdjNFhWQXJNNmlxbSszaU5yWGhO?=
 =?utf-8?B?VkUzb2pZWUh4ZVllcHBteFdzYUZ5bUo5NzFiVWlqTGw1NGF3RDhHNEZpd2sv?=
 =?utf-8?B?clplUjc2TGJHWk9kRVV6eDJtNGpJMHZqRVU2UGZ6ckVIaWJnNGV2cmk2NEVP?=
 =?utf-8?B?NERZbzBIN3NZR0QxRlU4cWYxbE5DL0Vpa0RLOWxPaEFMUVcrY3k3L1BRTjNj?=
 =?utf-8?B?bGg4S2w3djdkeVZNeEMyUnVaYUNRMUNZeks0a3R4WnVpa1pBZUMzZW1qMWx4?=
 =?utf-8?B?eWV4QkFRbkVFdGg0d1NLSTliRzRxVll4VkVxclpiMW9vNXJaNFI0K3NOM0J3?=
 =?utf-8?B?cjFLVkpKcWxLSkVCK3U2bWttcVcxRko2QnE2c3ZuakRad0ZXdjZqS1hKR1FH?=
 =?utf-8?B?alFJbCtKUGJhSU1BQkd2R0tZenFIYnFaZUhFYlhTRkdKTDJWcE1SU2RWWUZV?=
 =?utf-8?B?RDNaNnNIeW9weE0vYUU5ekl0Rk43U080TDNqSW03bjJPdzRLZGxIWlEySjhn?=
 =?utf-8?B?T3RMd1JZcWhZcFRZRzFPZCtYbVFrVzJkaUJtb013SDBwMEE1Zy9GUVR3UUVy?=
 =?utf-8?B?Nnk3dmdGYVNFOGlwbHJmdEpyV1R0azBYNWZFc0FBdlpMRS9Sb3pVQ3l2WStU?=
 =?utf-8?B?Z2w5Qm9xVWExSFFyOFg5OWc5cFJ5aVVuOXZmK2ZGV1RMOU1vdE1oWENOM3di?=
 =?utf-8?B?QnJTdHlFZmRadCtvdzdYeit0YUhpOGhQd3RDV0ZhaFZzVEdrYWdjREhsUFFO?=
 =?utf-8?B?NlRqYjZmc3AxZG9uUThXNDRKYUhsWHU1L0lYVytRZzVVSlY4UGhpVTlxdW5p?=
 =?utf-8?B?MkxlL0JvQlZzVkRMK1ZuYk9GakFFK1BPb0lOYUp4OEtkYU41YWNQa1BjS0gz?=
 =?utf-8?B?ZitZMXpjNTVvaGkzWk41a2dENFhyVW1XYTJaU1hFTUJRbjhKOEY5T1JiRGpt?=
 =?utf-8?B?ZTVMTGUwdS9LQ21Celhsc2tGRlZLdXQrcHdNRWk0K2pEZ0x2dFhtRHVZL1ZP?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74C83DDA68995A469012010C10CC61F7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9c95ea-ce72-4312-242c-08db5a7f3503
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:44:19.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9H35l60kwWCO/RsWBy5hMVI3aUhCDRCTLz7r/DsxfOjuWFSR3fMAWOmOPNaODr9X7CtXY7QBncYmfm/ioivKEW6rRIvUAwzn+rEI5XzfX0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7607
X-Proofpoint-GUID: Q2nKmEVmFJ3QBW0PuSOaQWoOV3KEHMfe
X-Proofpoint-ORIG-GUID: Q2nKmEVmFJ3QBW0PuSOaQWoOV3KEHMfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDIwLCAyMDIzLCBhdCA1OjU0LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1heSAxMSwgMjAyMyBFaWljaGkgVHN1a2F0YSA8ZWlp
Y2hpLnRzdWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+PiBrYXVkaXRkIHRocmVhZCBp
c3N1ZXMgd2FrZV91cCgpIGJlZm9yZSBpdCBnb2VzIHRvIHNsZWVwLiBUaGUgd2FrZV91cCgpDQo+
PiBjYWxsIHdha2VzIHVwIG9ubHkgb25lIHByb2Nlc3MgYXMgd2FpdGVyIHNpZGUgdXNlcyBleGNs
dXNpdmUgd2FpdC4NCj4+IFRoaXMgY2FuIGJlIHByb2JsZW1hdGljIHdoZW4gdGhlcmUgYXJlIG11
bHRpcGxlIHByb2Nlc3NlcyAob25lIGlzIGluDQo+PiBhdWRpdF9yZWNlaXZlKCkgYW5kIG90aGVy
cyBhcmUgaW4gYXVkaXRfbG9nX3N0YXJ0KCkpIHdhaXRpbmcgb24NCj4+IGF1ZGl0X2JhY2tsb2df
d2FpdCBxdWV1ZS4NCj4+IA0KPj4gRm9yIGV4YW1wbGUsIGlmIHRoZXJlIGFyZSB0d28gcHJvY2Vz
c2VzIHdhaXRpbmc6DQo+PiANCj4+ICBQcm9jZXNzIChBKTogaW4gYXVkaXRfcmVjZWl2ZSgpDQo+
PiAgUHJvY2VzcyAoQik6IGluIGF1ZGl0X2xvZ19zdGFydCgpDQo+PiANCj4+IEFuZCAoQSkgaXMg
YXQgdGhlIGhlYWQgb2YgdGhlIHdhaXQgcXVldWUuIFRoZW4ga2F1ZGl0ZCdzIHdha2VfdXAoKSBv
bmx5DQo+PiB3YWtlcyB1cCAoQSkgbGVhdmluZyAoQikgYXMgaXQgaXMgZXZlbiBpZiBAYXVkaXRf
cXVldWUgaXMgZHJhaW5lZC4gQXMgYQ0KPj4gcmVzdWx0LCAoQikgY2FuIGJlIGJsb2NrZWQgZm9y
IHVwIHRvIGJhY2tsb2dfd2FpdF90aW1lLg0KPj4gDQo+PiBUbyBwcmV2ZW50IHRoZSBpc3N1ZSwg
dXNlIG5vbi1leGNsdXNpdmUgd2FpdCBpbiBhdWRpdF9yZWNlaXZlKCkgc28gdGhhdA0KPj4ga2F1
ZGl0ZCBjYW4gd2FrZSB1cCBhbGwgd2FpdGVycyBpbiBhdWRpdF9yZWNlaXZlKCkuDQo+PiANCj4+
IEZpeGVzOiA4ZjExMGY1MzA2MzUgKCJhdWRpdDogZW5zdXJlIHVzZXJzcGFjZSBpcyBwZW5hbGl6
ZWQgdGhlIHNhbWUgYXMgdGhlIGtlcm5lbCB3aGVuIHVuZGVyIHByZXNzdXJlIikNCj4+IFNpZ25l
ZC1vZmYtYnk6IEVpaWNoaSBUc3VrYXRhIDxlaWljaGkudHN1a2F0YUBudXRhbml4LmNvbT4NCj4+
IC0tLQ0KPj4ga2VybmVsL2F1ZGl0LmMgfCAxNyArKysrKysrKysrKy0tLS0tLQ0KPj4gMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBUaGlzIHdh
cyBhbHNvIGRpc2N1c3NlZCBpbiB0aGUgbGFzdCBwYXRjaHNldC4NCj4gDQo+IA0KDQpUaGlzIGJ1
ZyBpcyBtdWNoIGVhc2lseSByZXByb2R1Y2libGUgb24gcmVhbCBlbnZpcm9ubWVudHMgYW5kIGNh
biBjYXVzZSBwcm9ibGVtYXRpYw0KdXNlciBzcGFjZSBmYWlsdXJlIGxpa2UgU1NIIGNvbm5lY3Rp
b24gdGltZW91dC4NCkxldOKAmXMgbm90IGtlZXAgdGhlIGJ1ZyB1bmZpeGVkLg0KKE9mIGNvdXJz
ZSB3ZeKAmXZlIGFscmVhZHkgY2FyZWZ1bGx5IHR1bmVkIGF1ZGl0IHJlbGF0ZWQgcGFyYW1zIGFu
ZCB1c2VyIHNwYWNlIGF1ZGl0ZCBjb25maWcgc28gdGhhdCBvdXIgcHJvZHVjdCB3b27igJl0IGhp
dCBiYWNrbG9nIGZ1bGwuKQ0KDQpPdGhlciBpZGVhcyBpbiBteSBtaW5kcyBhcmU6DQoNCigxKSBV
c2UgZGlmZmVyZW50IHdhaXQgcXVldWVzIGluIGF1ZGl0X3JlY2VpdmUoKSBhbmQgYXVkaXRfbG9n
X3N0YXJ0KCkgdG8gZ3VhcmFudGVlIGthdXRpZCANCiAgd2FrZV91cCgpIHRyaWVzIHRvIHdha2Ug
dXAgYSB3YWl0ZXIgaW4gYXVkaXRfbG9nX3N0YXJ0KCkuDQoNCigyKSBQZXJpb2RpY2FsbHkgKHNh
eSBpbiBldmVyeSAxIHNlYykgY2hlY2sgaWYgQGF1ZGl0X3F1ZXVlIGlzIGZ1bGwgaW4gYXVkaXRf
cmVjZWl2ZSgpIHRvIHByZXZlbnQgDQogIGF1ZGl0X3JlY2VpdmUoKSBmcm9tIHVubmVjZXNzYXJp
bHkgd2FpdGluZyBmb3Igc28gbG9uZyB0aW1lLiANCg0KQlRXLCB0aGUgZGVmYXVsdCBiYWNrbG9n
X3dhaXRfdGltZSBpcyA2MCAqIEhaIHdoaWNoIHNlZW1zIHByZXR0eSBsYXJnZS4NCknigJlkIGFw
cHJlY2lhdGUgaWYgeW91IGNvdWxkIHRlbGwgbWUgdGhlIHJlYXNvbiBiZWhpbmQgdGhhdCB2YWx1
ZS4NCg0KRWlpY2hp
