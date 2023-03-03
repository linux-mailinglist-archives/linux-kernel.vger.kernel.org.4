Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F314A6A94AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCCKBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCCKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:00:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC45C12A;
        Fri,  3 Mar 2023 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677837652; x=1709373652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V7eHBDWZZ7tTybSjAVYU6rzCLZLrl9aH/3bQZddkmMY=;
  b=1fOHKnTbaGWNQWYuaiQwUDYsrKWpnZBIsqXCCN3PtCthDgVFNQhLb14/
   Ya+yBUwfemndnVfFz7b9Mbn41Lbr5/MYkPPfoz+ZR8gaWZw1J1l7k88Fp
   jDbLgs14ToOnnpqWBvnfkeDhuDUiT+yJAJPwGhv9zfZFD056QGrZBn6EX
   ZSs0m/5Y0R3QI+sTxIjXBnBh6J8BeTwnBN0WtspMAk5czu7/HTTeJ4sZL
   WiSTeBPFoZv+E+NT1fxPRTYtQxjIhWtusN1D7HLJQb8cE3YQemOE34VVo
   DoFzUGXIWnCuZxiFXAmS+UuQq2Iwosxwv2cqOc41b0QoKADRxe/fY9tbV
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673938800"; 
   d="scan'208";a="203454399"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2023 03:00:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Mar 2023 03:00:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Mar 2023 03:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE8LtSNYGEsR8pj7eNL6K+fcPd9K1dnxhHFSbLgTeyQ8aZ7v0HpyUUCh1rqVBOzN+x4lEHYS/F4OiaBvax7pgha0Pkcnrn1+RoAGWYWLaIErs3iDOdxRdc2xB1xFqe8jkfGVVTC206bv61jxVtn1fbl5O7Q88H9ws74Mm20i7sK3iqw77PFVbdGHQglGc4tX4+BKP5zvj+HcNkE5eUjQQnDu9HRE1lTaOpoZZDPzz6/QnSQKMi1pIzmch88xFn4NXAovSiwWaA6TYCRqOwgez6gCc4l0JzthHR5tLAkZMmibjEj2Zy6j9AK7RnNuQoiq7ZrWMZS1ckkDKfGbV/mm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7eHBDWZZ7tTybSjAVYU6rzCLZLrl9aH/3bQZddkmMY=;
 b=oWzRV1ZQ9Hzjsi4qtE0LiMnXPiGEhqHzXeYeIc8XIzvWc+1UxKCHlBanj8VO4FHGhDunj/1DFghpBr7kXS+BdFiYF7ZO/+g9zYmNtSr3Mk9lY8lHCkxLtatJpdCWmsaXKTnKGHXkZA0Vs/Jp67z36booEuZzyHjJOnrcDwtk9R8m4DkWexM+x9tMVab6JKMG5PMvwHKYWLaaDK9jLoa44b6CLPlBgTOPQZjw0PoVYrYOZ0YqBE3OA/X2TK7zqAeS022I0INfZwxo66q3UXoIGsdkiCMT43n3n0TUMnugLu5jO3kHLTgm4Y6cyRTvn0VuWhZEWgphvD9N5yjY9QXFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7eHBDWZZ7tTybSjAVYU6rzCLZLrl9aH/3bQZddkmMY=;
 b=uVSzKihUdAHHDM3snwZa6dHv06Zgji+O9FqnZvCbWyIDty2EQOGJ4TRO0JbT3d7Kmnm6/pxboIkKRVHpJeI36MjYh4NsE3D3HD7JWw/AHGi68452LdMKiu2YgXBg6skhguilFiwnieGS48J5yhTWpJyhxIGWJfzx+YuUTi9REX4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 10:00:48 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 10:00:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <richard.leitner@linux.dev>, <robh+dt@kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <ladis@linux-mips.org>,
        <tiwai@suse.com>, <benjamin.bara@skidata.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <richard.leitner@skidata.com>,
        <bbara93@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
Thread-Topic: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
Thread-Index: AQHZTbcH2m0VmQtH6kS5KYUkML3+OQ==
Date:   Fri, 3 Mar 2023 10:00:48 +0000
Message-ID: <132f2216-7fbc-2b40-31f1-5262b30d56a4@microchip.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-3-aa9f7f25db5e@skidata.com>
 <b0a5c0c2-dfbd-460a-af0d-c9d498607d72@sirena.org.uk>
 <61e4485b-9211-fa38-5061-f5861292ddd1@microchip.com>
 <ZAC20AcKy/O+9DkV@g0hl1n.net>
In-Reply-To: <ZAC20AcKy/O+9DkV@g0hl1n.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB4989:EE_
x-ms-office365-filtering-correlation-id: ab50e43b-b1cd-4646-9016-08db1bce29f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Bffs38fHZMKgeZ0TBcRPyIp7X1U0VvhRsrTH+ji5/bYq9tdr/dcIOw61/gY3a/kQa5PcIeqKJgdOYGH9neiPoDh8a3ae0DFr6kWbmMCSLyavvoDc6B2V8JcdR0ce1PBvz93km1qkppEaeMdzOROveeCh1vGian5PL7lu394uw2Z8uJLHmdmoNnf6x8FEf0nKAJnJsbOXTS9oBKDqAN7yEyH0BBTd6jQuQEFSqoDcCjrLnX+Kzho4nR8e+7aAtjmZk3nxAr3J5fRfr0mBY/MJg16ubkMo+x3gur6dMrdZPHZP7Mo9Bmc8lSiT2+Vd/+7z+sn/jlkjfI6ewEZqGWus7Ywu7jxFMFYdwDa9BNeV6Ne1ow1AZlW5bwaTK9mRvucC8op1BwJ+vJDAt/PwPAC9ARFi4nQ+5fXaiKOOnL1lR55PaaAaPkRN36RRmmFQyUDimT9+OyF3ly6qh5rXvNkNtWreBkoiv9biALR+AR/FIacxaeJ9Hl8JeFRNXSeUndzo53WHJyPjDxsWcDYgTJJOjiVba2t2vkwMAcUtxEUmctnjTApiGMxvyc2CPOw1yTMi6eiVx5+/PUtJRnELXITnSYJ4SorRzXyE9bfecQmepk4M9EFo42mx6nc8qslteyMIhFu04cMifk9aAWjPD37eeek1+Xk2uPhLg/CnHtjQzRSdmbP3ecHxrc9UbnGWLdtDXwzkKUohVYnMTCfOQc8BeW258gq5SIzg0Tkv6VbfEpvnSCpo0jEdmRA+tEAUDI9TvxVmdMRN1Rro20lGR0DYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(31686004)(36756003)(76116006)(8936002)(41300700001)(66446008)(54906003)(2616005)(8676002)(66556008)(66946007)(186003)(66476007)(4326008)(53546011)(64756008)(31696002)(86362001)(6512007)(83380400001)(7416002)(2906002)(6486002)(26005)(5660300002)(6506007)(110136005)(71200400001)(316002)(478600001)(122000001)(38070700005)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlhORWcrV1hEa3lCQUVNYWFZeHI3aWU3L1c2emdvcFhwMDMwWjhYQi8wa1Iv?=
 =?utf-8?B?MUJwTzZJU3lWMExrYm5meGdsWitzTC9Pcy9acUJWbStCTjV0M0NsUCtqUXJX?=
 =?utf-8?B?R3VYS0I3cFJQRVhoMWlNVDdLWFdrVThvTTFEU3NkczFCNXN4L0xqV2dSYlJm?=
 =?utf-8?B?b1lpVHJ4dSt2NEhiU2F6K052ZzJNQldCRkNFckwyWFE5U3N5eitzUlVpVTgx?=
 =?utf-8?B?QmdpUWtGbWQwUFZXZEJQMmJ5R3N3dG5LaUdTOEJoQ1dqMm0xSDJVMy91QWp0?=
 =?utf-8?B?dzFHcm1VaXZ5c05GWHFzRnp2MHBabnNsbTJLUVR1VW4rRW1SeTBWaFJEekFs?=
 =?utf-8?B?ck14MnZoQVNKUXV3MytOb0pRT0k0emc5OG80bXpVV3UvbmdxM2VWMFdOSnlU?=
 =?utf-8?B?ZHVnSVNlL2NGYmt5aFRYaTk0Umh0MHhzTnBEeFdkRm9FZ3p2K3ZrMk1rdFNB?=
 =?utf-8?B?aW9zZE5JVmRHdEIxVG82YjFxRXhaTXFQaVhjMjZ3R2d4ZXorMUFubFMvZGNt?=
 =?utf-8?B?Tmx6V2k4d001RHV5d2lhcWtlWE1DUWxIWDBDb1RpYUtmc21HajV5YzJ2UlBk?=
 =?utf-8?B?VVdiZzczOFA2MElpK0VmaldMYmlJOXhwRXZ1VmYzR1k5QjNYY2Vlc2NPeGZu?=
 =?utf-8?B?bkpxei9MK1lST2x5c05ZUCtsSXl0V0wvVlcxbnZ1MmVqMjhubi9ybmVRanZw?=
 =?utf-8?B?U3FteVhLVjFQbUVPWGkxV2krL3NJZ2JZZktZWHBYazZ3UEpRazFCVlV2UzZo?=
 =?utf-8?B?ZWRRbWRGaTQrNE1lWm5wWmhldk9oS2NrOEN5T3dHcnp3emJ1bHF6QU9TUC9u?=
 =?utf-8?B?WkJXZTdkYUNHNjZxRTBTV3UyU2dmU05wYlF0RXkyUTgvWE56NitNb0JVa0N5?=
 =?utf-8?B?a3JxMzhzanByT0N1MGVQd3l2cnVBVXA1SGR0V0ZKZjhpY2EwVElZc0VtMzBU?=
 =?utf-8?B?UXE5M3JmMVpadUFad3pCSEFnaWp2WnBKZmlrcXhOcFZEYlB2eVlVeVJMZ01Z?=
 =?utf-8?B?MmVVY1dJYXZqcGJQbnZ3aVIzbkpvKzd6QTdsS3BEeWhvSmRQWWxDWGhVMDZY?=
 =?utf-8?B?c0N5NVRuR2RHa3JYdysrSjZJZ0tJYmIyZUttZDIyUmpvMjhBVVRpanhxbFpP?=
 =?utf-8?B?a3c1RndKM283bmZTOXV5dzUraDAvUkRKNjZsd1hsVXBBZG9VS2FCWTRGN3cz?=
 =?utf-8?B?UUwwL2hDK0d6ejUwcFBITzZhbHBlZitBbGRET0tHWEd1RTVYWk5MYmdYY0hH?=
 =?utf-8?B?Mjh4UTMzZnB0dGhFS2s1bENST0dzNGNUNE1YR1hKRFZuazNadzllenVSVDNw?=
 =?utf-8?B?M2V6TUh3bmxzeTFKaks4RXdZcVZFbnBINUVRQmNyTG5taDlRdDYvMnJWYUZp?=
 =?utf-8?B?VkRuUnQ3czZXd0t5cEtKR1JVUGprcG5XSHJNTXAxbUlDQTRubTRmMHpJZTZQ?=
 =?utf-8?B?Q3FwK25QVytkZllVWmVXTDJMMEFTMVRScHRJZVBncUszOVRaYjhvV21hTndN?=
 =?utf-8?B?SkJyTjQ0aHNyVExqK3F2WFB2N3dURXpmcXM2VDlUSWFQQnBvWHJzMlhNbXNJ?=
 =?utf-8?B?bUNhcXViMWdZd05Ta3FiVDNDOGhyWW9TQWxJRVNwejlBZlF2MW9BYnlVSnds?=
 =?utf-8?B?U0RQYVlmd2phb3lHeGhwbzBwY2dvMzl1Sksyb0tweEpDS0JvNEdaVXdZNmFM?=
 =?utf-8?B?SFVXTll2WW81d0pGQTU2VWNDZVJpLzV3SXdENzh4c1dsVDUremsrQmg2R3pS?=
 =?utf-8?B?VXlZUGR4a3YraXRDMmJaRTZrNldsd2kyWFN1YVpJUWZYY0tTWkhvSS9HbHdw?=
 =?utf-8?B?OHRxNjJoR1V2WVg5QmFLOEdibEMxdjkreWlMUlNOWDBybzd1bXdXaGEwSXYy?=
 =?utf-8?B?ODVnVDZ6NURyRndtT0FlK1E4cmgrZmhMZzViY0M1SVlKUW5qU2pUdXhpbXV3?=
 =?utf-8?B?dkpYN1c2azc0LzMzOHduVXNnODQ1SDczdENvQ1dyeE9kd1QvL2xSSHhLeng5?=
 =?utf-8?B?QVBTdzl1NGpUeC85MjdvRXY1RCtlMjVDVm9xdkhNTFpIZUJuektVYXRjN0sr?=
 =?utf-8?B?cDZ3czM0Y1V2LzFTcEk1L1I1NGlnRmUrVHpidm5SeU1IMUVFY29UNVRicXQv?=
 =?utf-8?B?M3NIdUFwSmZMTHZmZEJ5RTVTQkR0aFFidmUwdDNnRzBZOHdwNkV2Z2ZsQ3Na?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9B626D0A230AE4C8878C300D9B41BED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab50e43b-b1cd-4646-9016-08db1bce29f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 10:00:48.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GaiDdFa193HhFcsWgwn8KDz7sE0xaC+fRZNo6PxRBmhQg3j1qzorQuE5Hxd5EXUist5qraKbeEzLH/YUe7aQkbtlLkYcvvdnnCA3unyz2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDMuMjAyMyAxNjo0NiwgUmljaGFyZCBMZWl0bmVyIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIENsYXVkaXUsDQo+IA0KPiBPbiBUaHUs
IE1hciAwMiwgMjAyMyBhdCAxMjo0NTo1MFBNICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPj4gT24gMDIuMDMuMjAyMyAxNDoyMCwgTWFyayBCcm93biB3cm90ZToN
Cj4+Pj4gKyAgbWF4OTg2Ny0+bWNsayA9IGRldm1fY2xrX2dldCgmaTJjLT5kZXYsICJtY2xrIik7
DQo+Pj4+ICsgIGlmIChJU19FUlIobWF4OTg2Ny0+bWNsaykpDQo+Pj4+ICsgICAgICAgICAgcmV0
dXJuIFBUUl9FUlIobWF4OTg2Ny0+bWNsayk7DQo+Pj4+ICsgIHJldCA9IGNsa19wcmVwYXJlX2Vu
YWJsZShtYXg5ODY3LT5tY2xrKTsNCj4+Pj4gKyAgaWYgKHJldCA8IDApDQo+Pj4+ICsgICAgICAg
ICAgZGV2X2VycigmaTJjLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIE1DTEs6ICVkXG4iLCByZXQp
Ow0KPj4+PiArDQo+Pj4gTm90aGluZyBldmVyIGRpc2FibGVzIHRoZSBjbG9jayAtIHdlIG5lZWQg
YSBkaXNhYmxlIGluIHRoZSByZW1vdmUgcGF0aA0KPj4+IGF0IGxlYXN0Lg0KPj4NCj4+IEkgZG9u
J3QgaGF2ZSB0aGUgZnVsbCBjb250ZXh0IG9mIHRoaXMgcGF0Y2ggYnV0IHRoaXMgZGlmZiBzZWVt
cyBhIGdvb2QNCj4+IGNhbmRpZGF0ZSBmb3IgZGV2bV9jbGtfZ2V0X2VuYWJsZWQoKS4NCj4gDQo+
IFRoYW5rcyBmb3IgdGhhdCBwb2ludGVyLCBidXQgY3VycmVudGx5IHdlIGFyZSB0aGlua2luZyBv
ZiBwcmVwYXJlX2VuYWJsZQ0KPiB0aGUgY2xvY2sgaW4gU05EX1NPQ19CSUFTX09OIGFuZCBkaXNh
YmxlX3VucHJlcGFyZSBpdCBpbiBTTkRfU09DX0JJQVNfT0ZGDQo+IChzaW1pbGFyIHRvIHdtODcz
MS5jKS4NCj4gVGhlcmVmb3JlIHByb2JlKCkgd2lsbCBvbmx5IGRvIGEgZGV2bV9jbGtfZ2V0KCku
DQoNClNvdW5kcyBnb29kIGZvciBtZS4NCg0KPiANCj4gQ2xhdWRpdSwgUm9iOiBXaWxsIHRoaXMg
YmUgYW4gYWNjZXB0YWJsZSBzb2x1dGlvbj8NCj4gDQo+IHJlZ2FyZHM7cmwNCg0K
