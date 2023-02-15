Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9092E698498
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBOTjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBOTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:39:03 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020021.outbound.protection.outlook.com [52.101.61.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EBC3B657
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 11:39:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihbCd/Rga//W/eggXkUuReXvbRr4PGzjR027NK5Feg1PBaqJK5+OhaLYVESTvROIg669sUb4XeS1S6fRP0GaPtDizeUF7wtRcy3NhZE9ZDKZVuCPfeLnr6tpnl7jUam15HYB2wsDraG1fUSYeo9TeG6kwK7P2wnf2Z+D4gpoPaUHt9RjL5W5mw/o41+Mjc0+mMO3/4PIyMWb/ZK+nR1Eb8JFxlAAJG7vOeU7V8cWG2JL1RCHL6vLoO6XZY6BKwKG+RsVxjyZOeXjysvmscatP/qL+bmBqAunmEJuZxXhYvhkQPYZim+JwFQjGObZTgsoWevLJEtwsw4iPSBoKB71Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmTlN51RrzbxH1pOl5cjBJQ8T3e0P5I1ixW1KbbDUas=;
 b=Ryjb2riUqrkG/7HG3C2sYTI+jbU/TPR/Q5k+lbD5wyeUVdw6HISi4tnnjzg4wcqdNtbKgUU8/EwyHlfPOCTVcR3r2T7GJPsYCKTlJTdXo0FtDyM4VojKc1uA08OVh2qsS2jpOLWMup2bw0MpjPLIm+H6YAJJUmlny7CFf54QsYn6KJI4Xx+VjSrv5leb34Va9yrATjBrllkY8muChILvJBhCAb2LyUujdn0RTIHlKWJL553OGsnPIZt2nfeB7tTJmmjJhe4P0sNwCDdJEIv4yCdeBSdArwY7rnohlVALm3jPrfcr6s42OTYZMq2kBjw7Yd0aCZDltoSo2og4j1jacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmTlN51RrzbxH1pOl5cjBJQ8T3e0P5I1ixW1KbbDUas=;
 b=gKgn9Uu5vo3Oa1U5NdQp2qlE3YTwO6f8+ZuZHCkXwBHioyWbFjVPfVzmetSRR4sA0b1jtqtZ6SqlqFGPKfsdfFg6S3+kly5LBxGnW0LYUyTEzM2mMizn9/+gz8WPYYtktUr6O5lsFPw4rAQVOOffZ7lwA6ncl9Lpx2WVLyzxe14=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3228.namprd21.prod.outlook.com (2603:10b6:408:175::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.1; Wed, 15 Feb
 2023 19:38:58 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%7]) with mapi id 15.20.6134.006; Wed, 15 Feb 2023
 19:38:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Topic: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Index: AQHZPFdbFxstpbOX7kmH7AmnajmUt67LvPoAgARQXgCAAF++oA==
Date:   Wed, 15 Feb 2023 19:38:58 +0000
Message-ID: <BYAPR21MB1688180BD889936A9B7CCDE3D7A39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
 <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <7e4c5d0f-4cdc-8aca-0ce9-19b5f2371ea6@suse.com>
In-Reply-To: <7e4c5d0f-4cdc-8aca-0ce9-19b5f2371ea6@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b83c1f3-7ea9-45f0-9c2d-6fa498a46584;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-15T19:22:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3228:EE_
x-ms-office365-filtering-correlation-id: 920608cc-bc44-4454-f426-08db0f8c4869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yf63YfE0aR9n3/084seW2YfETRpp2sC2uC4nYkiKFB/zAgiSHNiOA/aTkbhD+qVH33r1/Nj6oxCYcRiSgpAtmZRJwW9kO0g/GnnWjcI2cTuLa8SKFnR4zF37YOad3wDRqDlhf6/6kvZAuCuwjo8oOlvwZYL/FJZvBE04ic7sE1EXhadBXNR53mQzjq5PRFNCgg4Nsc9ssYZ43kQdLCH6No4b3LOnFsXg/WbaUtozfxWYsBd6h1p2QlWU9S8NAaEw9AA+R4esNwElFlwR4bGBlXXGAXyzX11f2Hszzjrop9uZJ2jlXk9Y8EnZdRwAhsFbnUJ/C9C4wTrmTWhMsawLNsonO0dXOP/2GvZi8grJQh38GaqiJJttdpXRP+BI/7Z8rq8b4InzjrMTWEnWANjZZuYtavsd5MLtjBB/3gMSrwyvCPAXgOnJO/48KU54yPwUBhbJPrSVDq6VbuA6LafiSOEJKh0xR/h5sIRiIJ1gk4KFHIRWzP7u2jA5dgKeWIS7SfD6uV8lDtndZHtqrlgvT0Mc7vlhcWVG3VKgVQBBZsOnotfMaBjACUh+2V4Eswncuaiivvv78YS6pZbVsQfBu57XIoYWbaWdMz51ieWxklpnxTbcJ4uTrGbmvHh8ZKxDHSMueB4YaQnMOi3DyyDkmzi2ahiSx4yRceeQ08yVrcnh0nza4bQ3qmvj2QbWEdt7RaWjzLxaezqXYwHkhFg/WNNySaM5pE0sDKAkWtSYWJLdawBoWuPWX7hoSEH/5cy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(86362001)(38100700002)(33656002)(122000001)(54906003)(38070700005)(66476007)(4326008)(316002)(82960400001)(66446008)(52536014)(8676002)(64756008)(76116006)(66946007)(110136005)(8936002)(41300700001)(7416002)(66556008)(82950400001)(2906002)(55016003)(8990500004)(186003)(83380400001)(478600001)(6506007)(10290500003)(9686003)(53546011)(7696005)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzhPTHBldHFBV1RGL0pyb2ZyaThaSitkZ3R6R2tLQmNYRHc4bGxmS3FySjNy?=
 =?utf-8?B?bEYwSkpEbjRBeGdiUU0va2JDVVc0SisxR0pTa3R4cHp3eGZsMUxLN1h2MnNK?=
 =?utf-8?B?ajZpQktDbUJtZ2hteW8zaGVIMDlFNWhsR2RhVkcwakx3ejg2M0dkaHNwd0pi?=
 =?utf-8?B?M2QvRVpSekRCUnc1OW1QZ2RVbmwxd3NmL2xOTkh2MGZHRGltV0liOXM1NW1Z?=
 =?utf-8?B?REwweGpvand6K0lJcC9WVXFRSk1yMi9ZRHpnUy9hWEhOWGtnd0dCcHRqcE9l?=
 =?utf-8?B?cVgvTjVJOG8vcmcvMDhpRjFkRnI4U0tLRWtJWTBEV3l6MWNaR2NvaEd2OHd2?=
 =?utf-8?B?SEwvQmFXejRESGNxb2lUcS9kREF1MUNnaEhuQytweDhaT09TcVhUM2QzaUFG?=
 =?utf-8?B?STB4U281STN5WjdNZFVBYnZ6RVhabzI2Q21lV1AvRjduQXJRbjB1NXFOMG1u?=
 =?utf-8?B?N3JtTzBBemw1K0ZJWVdUcGU2cXF2QmZHYS9LVGlwMXByc21CckhJY2o0c0c1?=
 =?utf-8?B?M2VjY2loUTI1Q2V4dEsrbUpnMVJtWmJucjJXYWNjVWxOb3pNbHFkOTlnaUgv?=
 =?utf-8?B?emRCdm5keHN3YjZ1TnRFVzJPd3FOOTZyN1hsdjJMSUhvRU0zTmVyb09QbW5P?=
 =?utf-8?B?aGpRbk1PYlZyckZIRTNLNzBxcWhmbTQ5QnBlUmJQVTVsT2s3WG1MNElBNGh6?=
 =?utf-8?B?VkltYURqbnNaeVo4NjhrZVBhZkV0WE1vRVN4TlliOStzbG9aMnNxbDlrYnIr?=
 =?utf-8?B?OWs2UjByMlFDWndDL3pkcXVsRHVBLzdoMnJ4UjZXUzVTWFVVNkFBd29mMWg1?=
 =?utf-8?B?dHo3Q2JnREFXUXRPQk14cGRGbzQ0bXJUR3IwcjFwTjNFZTdsUlNFeVdlQUlY?=
 =?utf-8?B?Q0RiT3VCSU5TeUE3UUNzVzJUckh4SGtRUDZaUUthWjRYYzRHMHdZRnEzWDh6?=
 =?utf-8?B?Rnc4Tm9jMm42elNzWFgvb0FaYXdZVEgwdzRnRlJzRTM3bmJndWhCNHE1SWhH?=
 =?utf-8?B?RENvcmcrVFdERHBnUmVRVTZBK3A3TVAwN0laczVmdFRtNXcrY0poK25ITVMx?=
 =?utf-8?B?aGZETjVLK2hTb3ZkMlRROEtvV0RtZENFQjFlb0szaXpBSzBwMUdVRURBY2Nm?=
 =?utf-8?B?dFdQZjJ4UnhOdU5DN0RCdDNJc2Y2QUdSYThGU0tzWUI3bUp3RCtyTVZsS0do?=
 =?utf-8?B?UXNDZlc3Vk4rRFdMZGxkSFFUYnpYZEg0djJicmc4aTZkQUpEeTcxSmR4RDNU?=
 =?utf-8?B?NlZhVXl2bG5BT21zMkFsdndvbDJHT2V2UWtBQ0dLZ3lLU0szTW9id2lSdFQv?=
 =?utf-8?B?N1Rpb0g5S29sU2U0ZU8rcnRmMWhuN1ZKYVh4S0JsajF3clhPZTJXb1g5QUt0?=
 =?utf-8?B?YVBINi9jNWhGcGJsZkE4V0graFk3dDhVSGpwS0E5NVYyelM1ZTdubTFMNFJF?=
 =?utf-8?B?bHpJUDIrZktrVC90SjBBeUdnYWt2cCsyZm5qNjVGOXRkdWFWc3dST1kxeVVY?=
 =?utf-8?B?aDJkMUh6RVZzamhSQy8wbDRNWi9DTTVTcXVYeWxJOFJFYjRUWHNPb1JBMjNi?=
 =?utf-8?B?Y0ZxWUdMa0Exdm1GNEdLekNQanEvWVpib0ZIWVQzZHpPNXZTUVB0TStJSWNz?=
 =?utf-8?B?bC8wMDhNNWZnb0NzbmRaUjFyUjRoSVFZSVN1RU82T2NlNldaczkzbEJjQnFi?=
 =?utf-8?B?SkpVRUxIaE9VdzVUZmh5Sll5am5SQjlBVEhLNUo3RHB4eHlIbFMyVUdHK1Vr?=
 =?utf-8?B?TzZBQWhpcGdEVWVGRXRsN1RrdzNFMEZ1QWk3ZEdZNm1KaHhDSXEreU84M2pu?=
 =?utf-8?B?bXUzWTRxMWdsTEpCU0d0dVNyTlFTNzlFSFF5U0pKdWt0NFJ6em1yVkV3dk1G?=
 =?utf-8?B?Z2JyREJwVzRDdk81WmM4em8wSFdDQkVmaGUrd1c1a0NlWmJqck55RWk1eC9h?=
 =?utf-8?B?WVEzYlprVFE0eW0zOENyNHZDcFFXYTRqemZNNHh6VklmZ1p0ZDVhUmRmL1Ja?=
 =?utf-8?B?bUVWYTkyVDByODlRSFZMd1NkcUltS1Y5bCsyL3JNZWVraFl5YnptbndZaXRz?=
 =?utf-8?B?THdIOHhia3JuNVRsYjM3RUFIQmNKUWxMMTI3MllpUUwvcFErQ1R4U0lBdmYx?=
 =?utf-8?B?eDgrZzZiaW5ybmdvYzNSNDMzb3pobkcrTFlIRmV0MXVDRnZaTFkyWDIvYWRC?=
 =?utf-8?B?Y1lNNHJRNUZMb1Z3a3NPdURsM1pwdVJPTDlCOC9HbWdEYmtUckR1OTZBUEtR?=
 =?utf-8?B?MGU5NmxQcG9IbTJxM21NVmg4UmFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920608cc-bc44-4454-f426-08db0f8c4869
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 19:38:58.7642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcQTvjotyIUzP7+LO5+3qQtxHecUB5SQVwX1T3dTBnNP0WUGdpgaLxr9ZNbIAi6EhHaBk4M1rTwX/GqT+qtdMdhJlPuRvNZSDbF6fp7GZKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPiBTZW50OiBXZWRuZXNkYXksIEZl
YnJ1YXJ5IDE1LCAyMDIzIDU6NDAgQU0NCj4gDQo+IE9uIDEzLjAyLjIzIDAyOjA4LCBNaWNoYWVs
IEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEZyb206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0Bz
dXNlLmNvbT4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA4LCAyMDIzIDExOjIyDQo+IFBNDQo+
ID4+DQo+ID4+IFRvZGF5IHB1ZF9zZXRfaHVnZSgpIGFuZCBwbWRfc2V0X2h1Z2UoKSB0ZXN0IGZv
ciB0aGUgTVRSUiB0eXBlIHRvIGJlDQo+ID4+IFdCIG9yIElOVkFMSUQgYWZ0ZXIgY2FsbGluZyBt
dHJyX3R5cGVfbG9va3VwKCkuIFRob3NlIHRlc3RzIGNhbiBiZQ0KPiA+PiBkcm9wcGVkLCBhcyB0
aGUgb25seSByZWFzb24gdG8gbm90IHVzZSBhIGxhcmdlIG1hcHBpbmcgd291bGQgYmUNCj4gPj4g
dW5pZm9ybSBiZWluZyAwLiBBbnkgTVRSUiB0eXBlIGNhbiBiZSBhY2NlcHRlZCBhcyBsb25nIGFz
IGl0IGFwcGxpZXMNCj4gPj4gdG8gdGhlIHdob2xlIG1lbW9yeSByYW5nZSBjb3ZlcmVkIGJ5IHRo
ZSBtYXBwaW5nLCBhcyB0aGUgYWx0ZXJuYXRpdmUNCj4gPj4gd291bGQgb25seSBiZSB0byBtYXAg
dGhlIHNhbWUgcmVnaW9uIHdpdGggc21hbGxlciBwYWdlcyBpbnN0ZWFkIHVzaW5nDQo+ID4+IHRo
ZSBzYW1lIFBBVCB0eXBlIGFzIGZvciB0aGUgbGFyZ2UgbWFwcGluZy4NCj4gPj4NCj4gPj4gU3Vn
Z2VzdGVkLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4g
Pj4gLS0tDQo+ID4+ICAgYXJjaC94ODYvbW0vcGd0YWJsZS5jIHwgNiArKy0tLS0NCj4gPj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJs
ZS5jDQo+ID4+IGluZGV4IGU0ZjQ5OWViMGYyOS4uN2I5YzU0NDNkMTc2IDEwMDY0NA0KPiA+PiAt
LS0gYS9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMNCj4gPj4gKysrIGIvYXJjaC94ODYvbW0vcGd0YWJs
ZS5jDQo+ID4+IEBAIC03MjEsOCArNzIxLDcgQEAgaW50IHB1ZF9zZXRfaHVnZShwdWRfdCAqcHVk
LCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdA0KPiBwcm90KQ0KPiA+PiAgIAl1OCBtdHJyLCB1
bmlmb3JtOw0KPiA+Pg0KPiA+PiAgIAltdHJyID0gbXRycl90eXBlX2xvb2t1cChhZGRyLCBhZGRy
ICsgUFVEX1NJWkUsICZ1bmlmb3JtKTsNCj4gPj4gLQlpZiAoKG10cnIgIT0gTVRSUl9UWVBFX0lO
VkFMSUQpICYmICghdW5pZm9ybSkgJiYNCj4gPj4gLQkgICAgKG10cnIgIT0gTVRSUl9UWVBFX1dS
QkFDSykpDQo+ID4+ICsJaWYgKCF1bmlmb3JtKQ0KPiA+PiAgIAkJcmV0dXJuIDA7DQo+ID4+DQo+
ID4+ICAgCS8qIEJhaWwgb3V0IGlmIHdlIGFyZSB3ZSBvbiBhIHBvcHVsYXRlZCBub24tbGVhZiBl
bnRyeTogKi8NCj4gPj4gQEAgLTc0OCw4ICs3NDcsNyBAQCBpbnQgcG1kX3NldF9odWdlKHBtZF90
ICpwbWQsIHBoeXNfYWRkcl90IGFkZHIsDQo+IHBncHJvdF90IHByb3QpDQo+ID4+ICAgCXU4IG10
cnIsIHVuaWZvcm07DQo+ID4+DQo+ID4+ICAgCW10cnIgPSBtdHJyX3R5cGVfbG9va3VwKGFkZHIs
IGFkZHIgKyBQTURfU0laRSwgJnVuaWZvcm0pOw0KPiA+PiAtCWlmICgobXRyciAhPSBNVFJSX1RZ
UEVfSU5WQUxJRCkgJiYgKCF1bmlmb3JtKSAmJg0KPiA+PiAtCSAgICAobXRyciAhPSBNVFJSX1RZ
UEVfV1JCQUNLKSkgew0KPiA+PiArCWlmICghdW5pZm9ybSkgew0KPiA+PiAgIAkJcHJfd2Fybl9v
bmNlKCIlczogQ2Fubm90IHNhdGlzZnkgW21lbSAlIzAxMGxseC0lIzAxMGxseF0gd2l0aCBhDQo+
IGh1Z2UtcGFnZSBtYXBwaW5nIGR1ZSB0byBNVFJSIG92ZXJyaWRlLlxuIiwNCj4gPj4gICAJCQkg
ICAgIF9fZnVuY19fLCBhZGRyLCBhZGRyICsgUE1EX1NJWkUpOw0KPiA+DQo+ID4gSSdtIHNlZWlu
ZyB0aGlzIHdhcm5pbmcgdHJpZ2dlciBpbiBhIG5vcm1hbCBIeXBlci1WIGd1ZXN0IChpLmUuLCAq
bm90KiBhbg0KPiA+IFNFVi1TTlAgQ29uZmlkZW50aWFsIFZNKS4gIFRoZSBvcmlnaW5hbCBmaWx0
ZXJpbmcgaGVyZSBiYXNlZCBvbg0KPiA+IE1UUlJfVFlQRV9XUkJBQ0sgYXBwZWFycyB0byBiZSBo
aWRpbmcgYSBidWcgaW4gbXRycl90eXBlX2xvb2t1cF92YXJpYWJsZSgpDQo+ID4gd2hlcmUgaXQg
aW5jb3JyZWN0bHkgdGhpbmtzIGFuIGFkZHJlc3MgcmFuZ2UgbWF0Y2hlcyB0d28gZGlmZmVyZW50
IHZhcmlhYmxlDQo+ID4gTVRSUnMsIGFuZCBoZW5jZSBjbGVhcnMgInVuaWZvcm0iLg0KPiA+DQo+
ID4gSGVyZSBhcmUgdGhlIHZhcmlhYmxlIE1UUlJzIGluIHRoZSBub3JtYWwgSHlwZXItViBndWVz
dCB3aXRoIDMyIEdpQnl0ZXMNCj4gPiBvZiBtZW1vcnk6DQo+ID4NCj4gPiBbICAgIDAuMDQzNTky
XSBNVFJSIHZhcmlhYmxlIHJhbmdlcyBlbmFibGVkOg0KPiA+IFsgICAgMC4wNDgzMDhdICAgMCBi
YXNlIDAwMDAwMDAwMDAwMCBtYXNrIEZGRkYwMDAwMDAwMCB3cml0ZS1iYWNrDQo+ID4gWyAgICAw
LjA1NzQ1MF0gICAxIGJhc2UgMDAwMTAwMDAwMDAwIG1hc2sgRkZGMDAwMDAwMDAwIHdyaXRlLWJh
Y2sNCj4gDQo+IEkndmUgcmVhZCB0aGUgU0RNIGNoYXB0ZXIgZm9yIE1UUlJzIGFnYWluLiBEb2Vz
bid0ICMxIHZpb2xhdGUgdGhlIHJlcXVpcmVtZW50cw0KPiBmb3IgTVRSUiBzZXR0aW5ncz8gVGhl
IFNETSBzYXlzOg0KPiANCj4gICAgRm9yIHJhbmdlcyBncmVhdGVyIHRoYW4gNCBLQnl0ZXMsIGVh
Y2ggcmFuZ2UgbXVzdCBiZSBvZiBsZW5ndGggMl5uIGFuZCBpdHMNCj4gICAgYmFzZSBhZGRyZXNz
IG11c3QgYmUgYWxpZ25lZCBvbiBhIDJebiBib3VuZGFyeSwgd2hlcmUgbiBpcyBhIHZhbHVlIGVx
dWFsIHRvDQo+ICAgIG9yIGdyZWF0ZXIgdGhhbiAxMi4gVGhlIGJhc2UtYWRkcmVzcyBhbGlnbm1l
bnQgdmFsdWUgY2Fubm90IGJlIGxlc3MgdGhhbiBpdHMNCj4gICAgbGVuZ3RoLiBGb3IgZXhhbXBs
ZSwgYW4gOC1LQnl0ZSByYW5nZSBjYW5ub3QgYmUgYWxpZ25lZCBvbiBhIDQtS0J5dGUgYm91bmRh
cnkuDQo+ICAgIEl0IG11c3QgYmUgYWxpZ25lZCBvbiBhdCBsZWFzdCBhbiA4LUtCeXRlIGJvdW5k
YXJ5Lg0KPiANCj4gVGhpcyBtYWtlcyB0aGUgcmVhc29uaW5nIGJlbG93IHdyb25nLg0KDQpBcmdo
LiAgSXQgc3VyZSBsb29rcyBsaWtlIHlvdSBhcmUgcmlnaHQuICBJIGp1c3QgYXNzdW1lZCB0aGUg
TVRSUnMgY29taW5nIGZyb20NCkh5cGVyLVYgd2VyZSBnb29kLiAgU2hhbWUgb24gbWUuIDotKA0K
DQpJJ3ZlIHBpbmcnZWQgdGhlIEh5cGVyLVYgdGVhbSB0byBzZWUgd2hhdCB0aGV5IHNheS4gIEJ1
dCBpdCdzIGhhcmQgdG8gc2VlIGhvdw0KdGhleSBjb3VsZCBhcmd1ZSB0aGF0IHRoZXNlIE1UUlJz
IGFyZSBjb3JyZWN0bHkgZm9ybWVkLiAgVGhlIEludGVsIHNwZWMgaXMNCnVuYW1iaWd1b3VzLg0K
DQpFdmVuIGlmIEh5cGVyLVYgYWdyZWVzIHRoYXQgdGhlIE1UUlJzIGFyZSB3cm9uZywgYSBmaXgg
d2lsbCB0YWtlIHRpbWUgdG8NCnByb3BhZ2F0ZS4gIEluIHRoZSBtZWFudGltZSwgaXQgc2VlbXMg
bGlrZSB0aGUgTGludXggbWl0aWdhdGlvbnMgY291bGQgYmUNCmFueSBvZiB0aGUgZm9sbG93aW5n
Og0KDQoxKSBLZWVwIHRoZSB0ZXN0IGZvciBXQiBpbiBwdWRfc2V0X2h1Z2UoKSBhbmQgcG1kX3Nl
dF9odWdlKCkNCg0KMikgUmVtb3ZlIHRoZSB0ZXN0LCBidXQgaGF2ZSAidW5pZm9ybSIgc2V0IHRv
IDEgd2hlbiBtdWx0aXBsZSBNVFJScyBhcmUNCiAgICBtYXRjaGVkIGJ1dCBhbGwgaGF2ZSB0aGUg
c2FtZSBjYWNoaW5nIHR5cGUsIHdoaWNoIHlvdSBwcm9wb3NlZCB0bw0KICAgIHNvbHZlIFJpY2sg
RWRnZWNvbWJlJ3MgcHJvYmxlbS4gIFRoaXMgaXMgbGlrZWx5IHRvIHBhcGVyIG92ZXIgdGhlDQog
ICAgcHJvYmxlbSBJIHNhdyB3aXRoIHRoZSBIeXBlci1WIE1UUlJzIGJlY2F1c2UgdGhlIGluY29y
cmVjdGx5IG1hdGNoaW5nDQogICAgTVRSUnMgd291bGQgYWxsIGJlIFdCLg0KDQozKSBJbiAqYWxs
KiBIeXBlci1WIFZNcyAobm90IGp1c3QgQ29uZmlkZW50aWFsIFZNcyksIGRpc2FibGUgWDg2X0ZF
QVRVUkVfTVRSUg0KICAgIGFuZCB1c2UgdGhlIG5ldyBvdmVycmlkZSB0byBzZXQgdGhlIGRlZmF1
bHQgdHlwZSB0byBXQi4gICBIb3BlZnVsbHkgd2UgZG9uJ3QNCiAgICBoYXZlIHRvIGRvIHRoaXMs
IGJ1dCBJIGNhbiBzdWJtaXQgYSBzZXBhcmF0ZSBwYXRjaCBpZiBpdCBiZWNvbWVzIG5lY2Vzc2Fy
eS4NCg0KTWljaGFlbA0K
