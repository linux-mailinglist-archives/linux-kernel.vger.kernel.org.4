Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F586F9FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjEHGbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjEHGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:31:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E15819D5E;
        Sun,  7 May 2023 23:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5eKAKLoSanjAE7cPmKJxjXDaxVeRTrTDMSb8OpjJT/lCoSSfLeYr509vl4vmXonrOo+gA1sj3twhFT5GcN7vVQRVHAeTNdpB41EFK0cUHUSXABTnPngFy4FxZh2Agu/47LpMicCQhGUepROvCcmZNEbVypHE5h4oz1Hb2XEZi0icRSlG1wDtfyjf1VBZilSvtZuDRPE+Bf2M5SM6lpCz0xrWCJHRlbwjQjWX4NBZcfBmuLDmVnR3L6ixr93ueZkP852N5GCsZ3NAejPHa9akTr1ANe/HuD2z+S8E5Biv4ffFT3MvGB7deVFFJVmN7P+Gzq0kHiarpht0jYL+lRpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/Zmds9eJTra9AD+Hl/Z0CVlZJvyadpLRiEHxcIoRiE=;
 b=Fu+RAO5cp0RCdUYCgzPISij+XZf39SWerwZXBvVmGTh+yJ9EkKo+RF9yJxa4ub2yV9SiRMe4ycLNS+FDyNV3dU6ePbiDX66YqpFySb2jMSDCUC1trNMOvS9FRcxhb0c0bFAhusKxi5D3/CCHyiyo0QaBzM3S85lS5uJXos1d08hK5Gu7mKUkv8qWCM4w9aWxgGMoKM6QRS4cKNNmaNYxYm8JCZFvsdstvD0SadkqLwkbvEIJSj82IVvfbCgoXaDggItCwaOhvJJDRjcEgkyw3AWORww+1DbVLOquh72glu5iG/Do426H6i3fyDulRiRnqvR9Yob1NZ9EKvI0UPI02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Zmds9eJTra9AD+Hl/Z0CVlZJvyadpLRiEHxcIoRiE=;
 b=feUYiN64DDkBstNg6WG5RxeDgBF+U+A9Gk4qMH/8RHL9Y+7aVV7sny5xCvkhVNIuM51h+qw5/Er+MulkF2vEhm+khMWLsIk3kG29VWcjitJv4PHToDzywEBwfQcedl3KiMQz5ME4ur8PkrDLT+/ZB8cZodBuEPVqa4FSfmExsqliKesZba1WsFdg/ojUw1TsdaYnkJeIiZYSesZ9tuFoXVJWyajHCzU12AXK9sGdrfXY9Wm/NOYcC9ht8bDRCX9CQHvmy7tphZ8ZcotHcRrJl5iqpJz+Mu/oTQqC+eeLJSlL4B/9b0KvTWnJ+bfm7sTMxyh6Nkw+Vao/jH3bK7LMKw==
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 06:31:39 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::ba3f:3597:f05b:ab9a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::ba3f:3597:f05b:ab9a%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 06:31:39 +0000
From:   Maher Sanalla <msanalla@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build warnings after merge of the origin tree
Thread-Topic: linux-next: build warnings after merge of the origin tree
Thread-Index: AQHZgWccekvbbmzATkm2BYsWcV2Gy69P6dbA
Date:   Mon, 8 May 2023 06:31:39 +0000
Message-ID: <PH7PR12MB6657089C513022C1F249A402B9719@PH7PR12MB6657.namprd12.prod.outlook.com>
References: <20230508143935.2cc24467@canb.auug.org.au>
In-Reply-To: <20230508143935.2cc24467@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6657:EE_|PH8PR12MB6747:EE_
x-ms-office365-filtering-correlation-id: e40ac7f7-a266-44ea-8cf0-08db4f8de14f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7JSPRGykN8wYS/NvcEsqNeCAlaeaizWbsKLxvvXMl7q7HLOC47/sl7EbB7jU/OpCwSCCyvasC08jzrA2vm2pjkag8KKdKJI8knF9nwzq2Wirmmcx8vWXMd0ngyxB+5sHMq9W1ud/vg9KyIaTCE0Mv3rA5x3C9J2mkFaOWEvma0CckP6SDDSA2W80FoFl4hcq1rXhrcMWfVYUoCyOXMt+TRMsNdkqic5wO3HkAQRv4hqQEM06iH/gtOGER5tsY1NfrqJau8yWBkIQ1F4RN3M8WY9ZI/AUcwzAwgy8O0kXCJMOdT1x2mZ5Dk67lrn91NHY0njBkbBCVM2DauyPDJCIAm7Jueq9e3D5ttroBX5krWxjVcFZ7qE7xkw1qqOLY/P1Z00qHCpjKXHHPgAG+x7tBv9RdnRQzZlwZnV5273P+nLbP4uTBwX40nJmVXRhy5AH3LHauIU7vAKA7uSgEUriTUjJlOpNCMdna4zVUfbMV0mbK8J7++fQsKboHGfqemeVub4KnZktC3Fiio6ys3i1i+j2OQzPnSqo7tsi+Lf/fN4bxeUVYbPdQZaK6hkOPZLAVKMa3wzvOoOukQ6BIJcW40nr7iTYbi256oZcnuMOwIgyhnHrMBwpvTJMU5TesRsqi2QgurGYIDNcwK3zn078hRQuaCg4DniUENUpf7X3iE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(966005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6636002)(4326008)(478600001)(7696005)(316002)(110136005)(54906003)(86362001)(33656002)(83380400001)(53546011)(9686003)(6506007)(26005)(8676002)(8936002)(5660300002)(52536014)(41300700001)(2906002)(55016003)(38070700005)(186003)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE1rMVM4a3hGTm01N0VlUEpScUQvNmdwQzd3OENWTVRjOFZiakdwOVRKeTlq?=
 =?utf-8?B?cGdvMDY1a1ZMZUhCNzQ2N1lLQitTc01nNTZFNldVVnNWMHdxbW9hd2lmclVQ?=
 =?utf-8?B?U2tUNFNJL3dNY2FnQXJ5eDQxUW9XdTJWdlVHVndoeUFxVDJWOHk5d1pJeFJ4?=
 =?utf-8?B?V0RpMnhRczVlZEN3YkxwTlF1SlJ4eExqU2E2ZWpERzZLQTRldENCZU9Bd3Mx?=
 =?utf-8?B?SUNoV0p0TWp3VWM3QXNJd2lVL0wvZElQTllhNWlVMlpiZ0kycmdpY2lhaFYz?=
 =?utf-8?B?bGxTZzlCd3ZZTExsYUwvdTlIVlFWZVY1S1YycmRuQWpRcFd1ODRxSGRtaFJX?=
 =?utf-8?B?RS9VU2o4TkxhSUhZb3ltS2JXbFBHamNBa0xiL295bVorbzZEL3VQd1p0V3pk?=
 =?utf-8?B?MGdHTXBnTXVMdTJrSTEzaFkza3A2ejFaY01ZM2lJVkFpcHIxWjhDamQyZ1BP?=
 =?utf-8?B?WlVYUzRzcUZRUTlWM2l0Z2JZaU1rZ2hPdnZDNVdyRW9FQmo4MFU5WGdYQ0Mz?=
 =?utf-8?B?MzFVczBFR25NTTdHL3lIdWpsY3FtbEVONUxObXR6akl1dVYxRHcrMFAvbk5B?=
 =?utf-8?B?emo5UlRIRC9PTit3WW1NbEx6ZnplMy9rSjB0VS92cjZIMWxHRUEzRnQ1SVAr?=
 =?utf-8?B?dWpDTGM2TldrdERORCt3Ykh6WE9OYkRNRDl3MmUwekpSYnBkQlRhMWZBb2xW?=
 =?utf-8?B?bDYySGcyVmhhZWp1QmRqUWtENy83L2ljNWoveVNmay9mcHhQSFQ5b1cvVXdZ?=
 =?utf-8?B?UmNFUkZ2cFZiMnBvYnBPVHF2OU5aYit5TEl5UWFDK1R0cnpjcy8rUmJyeElm?=
 =?utf-8?B?YzRDMHErQUttUVlscFVhcWRQUEdNL2hhaDNEeE9ERjB4T1lETTY5RHh4djNU?=
 =?utf-8?B?U1ZOeGhEdnNhNFI2WEhJa1FhTEMrRS9XcUhnWm1iMDRPeXZoenJhZWhNU2hl?=
 =?utf-8?B?L3hteFJnc2Ewa3RPV2lqZkUxemFpalIxK2tQVm95aXN0VkV6RFFOWmtPdTVH?=
 =?utf-8?B?Y1JDWmwyYVJVdDllNjZPdy9CMzRvOElja0tFTlB4V3lyM3lPaWtRZHB6c2lm?=
 =?utf-8?B?dkc5ckZGYktHWDhXWjg1MXFwZDdXMksyRU5COFRGSmVZK2w4TmFUdzRFbFJw?=
 =?utf-8?B?dXN0UXNiNHZWdU9yY3dJTnFnL2pDdjBiS1lHSW4vWTBmaFhQVXdUU3c5amRU?=
 =?utf-8?B?SXNlWmRzbTNXYk54REhOZGhZd0hqV1Y2UkRUY0JVN0plWW9KOWRoTHdvVVl5?=
 =?utf-8?B?d0NLQWhKT01MRkJLOWMwaUJudUJWM3BUb1RyL2xMcjRFZDFpNm9uYnppMUJF?=
 =?utf-8?B?U3REbGJQMy9TYVA3Ti9SSlp1UVcwV3JWUWpZM3FVTFQ5MG0yUlRkWjVldFg1?=
 =?utf-8?B?eXJWd2JWUFZQYXJCdStBWmcxL0duMlkyNWdqa01aQ3RhSmErRW44bmJsTWJO?=
 =?utf-8?B?bkhJWTV3Tyt3VlFyNzRwTUdzMUZ2anJ1Q0lnYkU5QjNxeGF5Nkp4NnRjTnpw?=
 =?utf-8?B?bmRWL1lyaFVwcTB6Q3A3VEtWZHRtUXlYZFYzUFh5cm5uMWVUdUtkYnlITEFS?=
 =?utf-8?B?Z3Z1blpUYWdwell5Y2xBNFpTbS9wVUxaTjVUMnpXOFl2eGNGKzkweEhqSC81?=
 =?utf-8?B?NUlLaUczeWVFeFJpU1N0WG9NS0crTDlsbmVkcmdaSVF6NTY3UnVIb01sVTlM?=
 =?utf-8?B?VXYwQkVFZkU0WGhsY3AwcTJ4MUR3cFdaNEdIZnB2ckNPaXpETnhNN3M1TTdw?=
 =?utf-8?B?UTNKU296NTlsOW9IZTE3RnBRVXBkNVZBdHB4NnNEc0hML2FBanE0blRDQk56?=
 =?utf-8?B?UXdkcTlXdmFhaDdUbEZaQncvMUtjc1NxMkxaSCt2QnBqdHV0SndjNmFmcmxx?=
 =?utf-8?B?QThTK3A2VWw2enk3c0tKL1M4SFY5WURCSi9jbG4wOHpsS0p5ZXlVa0pHNU16?=
 =?utf-8?B?aGZ3VHlwL0RiVnRyOUtFQndCK3lNTFBSNkJ2ZWhZaVJDN1dIZmhQK2lZOXEw?=
 =?utf-8?B?cGJoYjE3UDlYdTBsaUpNY3E3K3BIUEkyUGJ1VVpUYlRtS1hZa2thQkZ1Zmty?=
 =?utf-8?B?Y3A0L3gvTUk4dzZPYVA4L0hmMDQ3OG9pSnMva2xVSmJqLzZWYUdUS3hqem1k?=
 =?utf-8?Q?blrGdCqDHw+BUrwiP2+56q7G2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40ac7f7-a266-44ea-8cf0-08db4f8de14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 06:31:39.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9oBeGjgF2FYkHeAKmJBBVIofWddlLQXSqLZ1W3HE9PLnyfFdQlFo0v+1r8M82DIm9VZ5rwTRApiZUMJeLvwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KVGhlIHdhcm5pbmdzIHdlcmUgYWRkcmVzc2VkIGFuZCBmaXhlZCBieSB0
aGUgZm9sbG93aW5nIHBhdGNoZXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAy
MzA1MDMxMDQ3MjQuR0w1MjU0NTJAdW5yZWFsL1QvDQogIERvY3VtZW50YXRpb246IG5ldC9tbHg1
OiBXcmFwIHZuaWMgcmVwb3J0ZXIgZGV2bGluayBjb21tYW5kcyBpbiBjb2RlIGJsb2Nrcw0KICBE
b2N1bWVudGF0aW9uOiBuZXQvbWx4NTogVXNlIGJ1bGxldCBhbmQgZGVmaW5pdGlvbiBsaXN0cyBm
b3Igdm5pYyBjb3VudGVycyBkZXNjcmlwdGlvbg0KICBEb2N1bWVudGF0aW9uOiBuZXQvbWx4NTog
QWRkIGJsYW5rIGxpbmUgc2VwYXJhdG9yIGJlZm9yZSBudW1iZXJlZCAgbGlzdHMNCiAgRG9jdW1l
bnRhdGlvbjogbmV0L21seDU6IFdyYXAgbm90ZXMgaW4gYWRtb25pdGlvbiBibG9ja3MNCg0KVGhh
bmtzLA0KTWFoZXINCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU3RlcGhl
biBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+IA0KU2VudDogTW9uZGF5LCBNYXkgOCwg
MjAyMyA3OjQwIEFNDQpUbzogU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPg0KQ2M6
IE1haGVyIFNhbmFsbGEgPG1zYW5hbGxhQG52aWRpYS5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXggTmV4dCBNYWlsaW5n
IExpc3QgPGxpbnV4LW5leHRAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogbGludXgtbmV4dDog
YnVpbGQgd2FybmluZ3MgYWZ0ZXIgbWVyZ2Ugb2YgdGhlIG9yaWdpbiB0cmVlDQoNCkhpIGFsbCwN
Cg0KV2hpbGUgYnVpbGRpbmcgTGludXMnIHRyZWUsIHRvZGF5J3MgbGludXgtbmV4dCBidWlsZCAo
aHRtbGRvY3MpIHByb2R1Y2VkIHRoZXNlIHdhcm5pbmdzOg0KDQpEb2N1bWVudGF0aW9uL25ldHdv
cmtpbmcvZGV2aWNlX2RyaXZlcnMvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9kZXZsaW5rLnJzdDoy
ODc6IEVSUk9SOiBVbmV4cGVjdGVkIGluZGVudGF0aW9uLg0KRG9jdW1lbnRhdGlvbi9uZXR3b3Jr
aW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L21lbGxhbm94L21seDUvZGV2bGluay5yc3Q6Mjg4
OiBXQVJOSU5HOiBCbG9jayBxdW90ZSBlbmRzIHdpdGhvdXQgYSBibGFuayBsaW5lOyB1bmV4cGVj
dGVkIHVuaW5kZW50Lg0KRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0
aGVybmV0L21lbGxhbm94L21seDUvZGV2bGluay5yc3Q6MjkwOiBFUlJPUjogVW5leHBlY3RlZCBp
bmRlbnRhdGlvbi4NCg0KSW50cm9kdWNlZCBieSBjb21taXQNCg0KICBjZjE0YWYxNDBhNWEgKCJu
ZXQvbWx4NWU6IEFkZCB2bmljIGRldmxpbmsgaGVhbHRoIHJlcG9ydGVyIHRvIHJlcHJlc2VudG9y
cyIpDQoNCi0tDQpDaGVlcnMsDQpTdGVwaGVuIFJvdGh3ZWxsDQo=
