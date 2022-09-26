Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2745E9999
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiIZGfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiIZGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:34:39 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120047.outbound.protection.outlook.com [40.107.12.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF432DB9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE4rvm5CSGY9aR5MSS8Oc1Z+LdwmPX/XweGidVNINTeqL0bsCDuN/yxLWyQ5Manlx4n53/riL9F2oTWL3hxoz3soGu7eEkidmmB5XxaB8EO02l3/kwl20k/QTyAjJyaiKaL66xu6dOhhqD7MaPTMBej66VcebA32X+ruMBOZBWE6deDzhSXMz0lOdWMOQ69yxrB8uy0xvqRdtT6n4B3YI3Ygj+hxs1mW8ttj1CtRQBMrrOK1Mdd/MQt9TZJijr0i3PSO5CE9gd8Ad4BpvicamzWVlWLewKhOkHRxFAveG1320Pi9Ms6pkepknAfyy2fwPA/XdaQUC1P8opPzXwVkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyang3UgXAUbCVvoTYDKZO/KOmkTbn5K1nZIzEFnExo=;
 b=gUG2VPYYSlRNnq+fEqt0pYdMP3FHdn+a9IYkozsTcnqFYNjj6XqVJcsLFgy9/aTZWHfwwbOvPfGuyGnxW9bkg2jeCr9hpjNiSxVgJk47oGH1rOXmWnJfv1IDzlfcG6uJSsOrpQ6Exaiuvp1QZBMRNzkloP8opCJ0lZQ+BAFhlmqqG4EoIEiHnXAcRi+U+rCbdu23SpZob0HSR3yDqSDF1D54DLh7ubdHJIy0hMSXykxXQHyNup0qMwlIQRb21G4x8uUwIAPQD4hfkZbGWJRlnhwYp0tCeBYfAUuKEFapVpngtqVf6FV+eQC0IeIg+YEXnX9qkxKfsCZoz7fhhXeUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyang3UgXAUbCVvoTYDKZO/KOmkTbn5K1nZIzEFnExo=;
 b=xAAdRvybXvjQ74Mrg2RS113aNuyQkWmtvTbS7bqlE7MXi6M/iZoyVFvzmaND9tLIy0eou/4R068BD978JoTiBGwBJ85EPt7poFYjLdNtBuhNV/o4FKLbeEdaxwvfI5zPEtLgvIt+BZF2j5ghvKXETUFpRHK27o9fniGPqG5j9ClJ+ZYiejh8JQySD1RgJ4/dXeWFJTZouVLYnk4c6OMK8xnwGmm3V2Ut9JN5R5FKmkUYmztU6XiFqzBi7t/5tJvxbukXEn2oKRKGtcrjc3QzoEBs7GtCUtkqNKxkxZEF7fkkQ2U8Tj//9axN2NmK10xtQsv0K8+1eSPjjQp4LzSZEw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1538.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Mon, 26 Sep
 2022 06:34:17 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f4ad:3944:a7f4:fcf3]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f4ad:3944:a7f4:fcf3%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 06:34:17 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ssx@qnx.com" <ssx@qnx.com>
Subject: Re: Is PPC 44x PIKA Warp board still relevant?
Thread-Topic: Is PPC 44x PIKA Warp board still relevant?
Thread-Index: AQHY0JyJEpaHikms2kKuSc3Pv0A+DK3xQseA
Date:   Mon, 26 Sep 2022 06:34:17 +0000
Message-ID: <ed43b0d6-d6d4-73d2-b4ab-637f6d2e310e@csgroup.eu>
References: <Yy/hv2fOLzdWOuvT@google.com>
In-Reply-To: <Yy/hv2fOLzdWOuvT@google.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1538:EE_
x-ms-office365-filtering-correlation-id: 76973936-73cb-4316-3c14-08da9f892308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCNXbZqqJRTo6bUeF/7TnuPNDo7UDWfzR/f+LZzKh4blT9UuNQH9vsZKDP1vrFVIPiEkMiP4VFajpgqvDf8TeRGa+QRdgHXV4/WA6eq9hs/vfOvrR14jtMjlL24WzPlDJAmqF8b5PLstqOu7NH+dBtSoFxEVZ4exlnTsOuW/gW6q5xiHrN7YGZl0MhxCtrwDhMZ0d8czXCMHodZwCS87jr+0s2iTtBHM+n8KaWQ7ToZDYCxiZV4DjXM6NAzOYzpYybWCsU+P6zc8FEJNaL0e74fqaHzo68mqFYHBjgcrU8ZSg8yXIlOMAY4gvG15YnwYT4Ltxjx6MBBxGetxk05/+MVKUvqdkAP9A4zFTbSlVIwJanq7mgx5Xwi0sTStSUuefRtnnR1v2Hd46Le/xlJ6Dp7W0PeMKE2A1eSz6UpeBWpcpsIbKi4gN1JFh4K5x0Z/TTvKh1u4BU+fL6jDy4BVmjhf65UDmPx9mFJHdIFw3SgiCUPYb6FNbH4W7wuM98FwIaRlnPcu+5wjaqn5LfZqyDjpezhC19WW3mjV+qN0NBpjwgjMpAflBaQEUMoCuD97FyWguaeTJOxpMZ1EWvKBe6Bsiqkv0WyAYi4U5tPL5GkqTlQ9qA41d7LoyVVVpPbNQZqITGOp/SCtOvYPNRHnCoNQteqyRPYmuVQ5MnUT8g3BNoizNWppOm8H7yvH5QwAqNSvDtx3LPq+VcrqKfPTUHGkPtWhKBp5N8PKAqEU+E674z15d/4hi/LjLclbiozb7YUMpqqX3dL3/lhBQ4YXwlLDMlr9SepQH9ldPwkcMYCjeIE6VXRkSed1cQ5fEGxDyf97TKtjdqltiNoB461hYGfJ6ZEM/Sq0GAaTFqLP4YM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39850400004)(396003)(451199015)(6506007)(6486002)(71200400001)(966005)(41300700001)(478600001)(6512007)(26005)(83380400001)(66574015)(316002)(186003)(2616005)(2906002)(44832011)(5660300002)(54906003)(110136005)(66946007)(66476007)(76116006)(66446008)(66556008)(8936002)(91956017)(64756008)(4326008)(8676002)(38070700005)(38100700002)(86362001)(31696002)(122000001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3k1R1dUZzc3NFRiUkpPVWhacm1iem9aWU1JSXBHRWpuUFl4cUxncktHSFJn?=
 =?utf-8?B?cFBFdWJPUmY0K2RCWVpvNThDV3RNdHg3aVNHWHNacTJzNTN5dmJKdldxQS9r?=
 =?utf-8?B?ZjJzcXdoTzg4T2djZzJMd1F2NWhYSkkxd3hvSnBHNGppdFNuUldOeExSeXZo?=
 =?utf-8?B?Y2JZOU1vQ1ZuZ3YzeGZlTU5wa0djZnhUOElFOThBcnVuVm9EZml2SlBmSVJQ?=
 =?utf-8?B?WEI1VkNsOFBRUFZIK21hcTY3UzNhekNrNFcweHhmOE02RlloZ3IwOUNDSkdD?=
 =?utf-8?B?M1lsN3NpNlZ6TUhOVHIvVXNFdVU1dmp6RTdqYWRBbVZla1BKczF3V2kwOENj?=
 =?utf-8?B?V0VpNDdpNWNxdG9pSU1oL1ZnTnp3dExKYlZmcys1SkgzWjNvQWw5RG54Vmh4?=
 =?utf-8?B?SlQrNGJWakQySFkwcGJ3VUJzMHQ3VEVINkJJTjZwSUFpR3ZaT1VMOVU5aThE?=
 =?utf-8?B?elMyUWpDcWJGcUhEd1ZuWGZlVldXUk5pVXJoN2xRa1V5RVNoeHJBWW1lbmh0?=
 =?utf-8?B?UGh6eXlpNVVXVWdvVXdYTEVCcUZ1L09TMTYrTm9UdzdBWm03aEIyKzZUZnRJ?=
 =?utf-8?B?WVo3QmllUjdmbnQ1WmkrTWcrU0w3NnVrWThLQnUvQjJSMC9wY093b0h2TnZu?=
 =?utf-8?B?T2FudlFVdG9qU004RUhZakwzOVpqYzllaXNlM1dTaWh0OUx2WWxKVGNlNTFs?=
 =?utf-8?B?cUxldzRrY3lBTzRpUE00ZkpqUllpMC9iSjF4cGJ5YnA3Y3UyY1pXc3pGRWFS?=
 =?utf-8?B?UjBRUTdqdmtvVnlIQmtEZzVGTlZNQitQL0tGTHdWUUtSYmdiNWV5SnMweFVk?=
 =?utf-8?B?ZitqUi85STFzOVRKN21NMnJpUGZ2dW1MMXkwZ2o5cFc4MFcydUgrQ2VCK3Zx?=
 =?utf-8?B?bzVpM2NyNU1uOUNMZWt2Ni8wWWZpVVlnYUFOb0ZFcjNkUWFBWGtKMnhIVkRy?=
 =?utf-8?B?eVpvdWVQS25rUUtQUU1ZRWtrME01Ukg3VW85bEFnamFnMllGVDRuVXNPekIv?=
 =?utf-8?B?bHVZNTBtZGd5aGt4bCtvbyt6TFVpb1kyWkxUMGFCcExWOHVvdWZYQTJzNWQ2?=
 =?utf-8?B?UUxvUGthcDFKVTVCY1JEZUUrZWNPNjgreDgxZFZ4QktacmJDeUszMkZDRGhq?=
 =?utf-8?B?NWM2YVZhOFBqRUZ1bFdIRjllOFhWM2E5bXdTdGZoRVF6V2xLbEVKc2U4Q0VR?=
 =?utf-8?B?NTNGc2c2dFhvZ3NaeGdsbE11aThNZzZSVzdJbjZONzJOTzBMSE1TeGZhOUFX?=
 =?utf-8?B?d1NUN2lyaTVaQzhZTnVSYjhZc1V1OWdVSEJFdlhjTjNTVThSSGRvNzR1anRI?=
 =?utf-8?B?eTlaTW1mVENvek92Nm1EbGJ5aERCWjdPYnZDSDE4c2dvbThOL2tlOWNoaTNm?=
 =?utf-8?B?Uzk0R25WUURpaDJ6MEJBcjR0VjJvWFpudGtib1RKYUx6Zy9wZEFDN0lOTUFU?=
 =?utf-8?B?dkZUeFB4Kzh5ZWE1dFRCRmtobFlZQ29XWDVMZnQ5WUltcy9ZTis4ZlZ2bEdj?=
 =?utf-8?B?L0JYWkV0cThRTG92R1pBZXg2VGdBWUZxcHhYYlZ0ZGFnbjNBWVJ2QWUxV1U2?=
 =?utf-8?B?REtJRkphRmJBZHJiZGxKeUlSQjU2aGVCL3pXd2hjTW1xR1JOeUVKSVBNWlFu?=
 =?utf-8?B?azFWM1JqRHJKZEtENmpIcmJSQ0E4N25rSE5Ma29HSm9WaFRGSlZIWXFiSFBF?=
 =?utf-8?B?cndReWMrTjkwaWJKclJzZkRNb0l1c2NYVlhlMmFYVFlIWlg0WSt0Um41d0xZ?=
 =?utf-8?B?ZXp0ZHNGRmE2Q2VVbk9MNkM0cFpzSnRadmFtblNIeldHYkljVDM1Vkw4bDl3?=
 =?utf-8?B?bXpEYWlyYlVINWhVWXhKMjBrQlZJUHdzMjVVQi9EOHJ5NWtQK3lra2hac05m?=
 =?utf-8?B?UDNFd2FFWGJRSUw0TmcvMWtRVmRETEhpd3NkRUIxZEpCQ0d5elpWSW8vTlNY?=
 =?utf-8?B?Z09qdmEySVl3N2sveWoyQ2NOdGIxVnZUWk5QbzlBa3JuU1p4eVJUUlIwMFpw?=
 =?utf-8?B?WFdLSzBiYURGS0tQZVEwbXhXZ3NuNnhGUG92b0NDVVpVeHRaNXpKcnR1dFVq?=
 =?utf-8?B?QUxmZ00yZ0VKdnZoUSsyQ2QyWm1SSFRqYy9LWDI3VThpMmNLTkpxdHA0SHhC?=
 =?utf-8?B?THBLeG1yTUVJUTZIQjVyNDV0eW05UFZLTzRlY1ZOWGhkUVkxQ1VPb0JRc2VW?=
 =?utf-8?Q?8KLgNE5jbMwU9pQNoPCpgLo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <721F6152B76ACB4E854AE6DE932D1067@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76973936-73cb-4316-3c14-08da9f892308
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 06:34:17.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ai+mGgHDja5JOtRYf/de74tV/Sv6F/6vNqGCi3iZS0jSzovu9U5nC4EkJDiKDCh1rSMeIVtglrQ+B87sKEAZw5vfPoLZ6JOqHm1rBrFY94M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1538
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5DQoNCkxlIDI1LzA5LzIwMjIgw6AgMDc6MDYsIERtaXRyeSBUb3Jva2hvdiBhIMOp
Y3JpdMKgOg0KPiBIaSBNaWNoYWVsLCBOaWNrLA0KPiANCj4gSSB3YXMgd29uZGVyaW5nIGlmIFBJ
S0EgV2FycCBib2FyZCBzdGlsbCByZWxldmFudC4gVGhlIHJlYXNvbiBmb3IgbXkNCj4gcXVlc3Rp
b24gaXMgdGhhdCBJIGFtIGludGVyZXN0ZWQgaW4gZHJvcHBpbmcgbGVnYWN5IGdwaW8gQVBJcywN
Cj4gZXNwZWNpYWxseSBPRi1zcGVjaWZpYyBvbmVzLCBpbiBmYXZvciBvZiBuZXdlciBncGlvZCBB
UElzLCBhbmQNCj4gYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy80NHgvd2FycC5jIGlzIG9uZSBvZiBm
ZXcgdXNlcnMgb2YgaXQuDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoYXQgYm9hcmQgaXMgc3Rp
bGwgYmVpbmcgc29sZCwgc2VlDQoNCmh0dHBzOi8vd3d3LnZvaXBvbi5jby51ay9waWthLXdhcnAt
YXN0ZXJpc2stYXBwbGlhbmNlLXAtOTMyLmh0bWwNCg0KDQo+IA0KPiBUaGUgY29kZSBpbiBxdWVz
dGlvbiBpcyBzdXBwb3NlZCB0byB0dXJuIG9mZiBncmVlbiBsZWQgYW5kIGZsYXNoIHJlZCBsZWQN
Cj4gaW4gY2FzZSBvZiBvdmVyaGVhdGluZywgYW5kIGlzIGRvaW5nIHNvIGJ5IGRpcmVjdGx5IGFj
Y2Vzc2luZyBHUElPcw0KPiBvd25lZCBieSBsZWQtZ3BpbyBkcml2ZXIgd2l0aG91dCByZXF1ZXN0
aW5nL2FsbG9jYXRpbmcgdGhlbS4gVGhpcyBpcyBub3QNCj4gcmVhbGx5IHN1cHBvcnRlZCB3aXRo
IGdwaW9kIEFQSSwgYW5kIGlzIG5vdCBhIGdvb2QgcHJhY3RpY2UgaW4gZ2VuZXJhbC4NCg0KQXMg
ZmFyIGFzIEkgY2FuIHNlZSwgaXQgd2FzIHBvcnRlZCB0byBsZWQtZ3BpbyBieQ0KDQpiYTcwM2Ux
YTdhMGIgcG93ZXJwYy80eHg6IEhhdmUgV2FycCB0YWtlIGFkdmFudGFnZSBvZiBHUElPIExFRHMg
DQpkZWZhdWx0LXN0YXRlID0ga2VlcA0KODA1ZTMyNGI3ZmJkIHBvd2VycGM6IFVwZGF0ZSBXYXJw
IHRvIHVzZSBsZWRzLWdwaW8gZHJpdmVyDQoNCj4gQmVmb3JlIEkgc3BlbmQgbXVjaCB0aW1lIHRy
eWluZyB0byBpbXBsZW1lbnQgYSByZXBsYWNlbWVudCB3aXRob3V0DQo+IGFjY2VzcyB0byB0aGUg
aGFyZHdhcmUsIEkgd29uZGVyIGlmIHRoaXMgYm9hcmQgaXMgaW4gdXNlIGF0IGFsbCwgYW5kIGlm
DQo+IGl0IGlzIGhvdyBpbXBvcnRhbnQgaXMgdGhlIGZlYXR1cmUgb2YgZmxhc2hpbmcgcmVkIGxl
ZCBvbiBjcml0aWNhbA0KPiB0ZW1wZXJhdHVyZSBzaHV0ZG93bj8NCj4gDQoNCkRvbid0IGtub3cg
d2hvIGNhbiB0ZWxsIGl0ID8NCg0KTWF5YmUgbGV0J3MgcGVyZm9ybSBhIG1vcmUgc3RhbmRhcmQg
aW1wbGVtZW50YXRpb24gaXMgc2VlIGlmIGFueWJvZHkgDQpzY3JlYW1zID8NCg0KQ2hyaXN0b3Bo
ZQ==
