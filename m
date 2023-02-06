Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2AB68C664
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBFTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFTFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:05:07 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1824C81
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgzGryT0hyJYdGZz1WaSkKO9JDjMboyZ/J7LPsAoI3B0u8uwax4zUHWyKk9fxYZc+YVGU9GA/3zjUb+5iWG2Hi3rTnd7fisgd9kX9+cWQVhiSTaXVf4fvL3mK7IOZpoIamQkzxmnvuco/oZUvwbMvlDk+aHp680GiYjjiGwBY7GIgYwwv2kCNNwNGZReSHpmX5S6d68SgdId8OPUjcD2euD83v6yWpahIbcEjisMaOpzCiUh2Ka2Nh3aOcE7T9jDHzHvCfoe4ZYF2ssfx+67wXp/ifRV1jCZ22BqvMeevK01eCDHM4+nfnZnCDvUYhRRuLIo8sQYcM/f/H32dh4SHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO/ls87Tz3Yw0/oBPckx04ryhP1s5Z2pTfSFaBPOna0=;
 b=NDVRR9wT5Vk88BJ5sYqd/Kd13B+DgFRBBPwJsyhxBi8yVEds9j9p8eeHcflM38LI7QbSiueKupmnpKHHU3lUsYVltj/QiRS20DAfMn6Y/jUSYwpMD/WM2/XGYrqHUn1VOeVg29SH9wuwQ7AmgO0oOqt6DtOPgjnlVUuxpMr7k6TOHpkf0BqlurOhb/9VYqTvbkMUIa2eofFPLKbi12MoqAvV/1DkDdWlWMc35LSZFN08fiMdEVdSBcY2MdVX2enkIJfcYvM5ZU/frDtkus1P9imGkVbdR+mpM0Tu/IIPizSCilsaGd5yh3DPxqY9UmU/tuBGfmY2eE0KZmehd9QenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO/ls87Tz3Yw0/oBPckx04ryhP1s5Z2pTfSFaBPOna0=;
 b=OP/BTYs7X45L2uQYsZV/5Ez2gW4AqKDB2dwUr5SXZX/3f+c1xLnsBS6Bg78TrVK+0td8gixOPaqlDV1x84qM7W5+5TgA5pN7tuVaCaGBH3E8eD37t8sYVq9UiuYmDCT1BXfqBDEE/FYSLQk85uwgKcsKPWhx8X8+2mxdWBTM9xo=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BLAPR05MB7348.namprd05.prod.outlook.com (2603:10b6:208:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 19:05:02 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 19:05:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Thread-Topic: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Thread-Index: AQHZONzOlqQ9zgLH5EacMBCbCDIQPq7CQ9CAgAAGPYA=
Date:   Mon, 6 Feb 2023 19:05:02 +0000
Message-ID: <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
References: <20230204210807.3930-1-namit@vmware.com>
 <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
In-Reply-To: <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BLAPR05MB7348:EE_
x-ms-office365-filtering-correlation-id: 82f981b1-e14c-4142-457b-08db08750d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k37WWoZ91VMNNeWFnpBMCr69my89uBbrzPImSFlf5bzCXo2fZ8lLOfV6cxyxDWXSVPfb5fa1YuRbQVsUiKk+Fh7HzeTWZQJ7x3jIfXvJErzTJ5zcYIolbaGnTZK35zEk536/yN/eaV5LvpgSbsrrLC0N2eAjfMgW/zwhsLIMazK+mQslpIy0jufCT+L1sOOjbRUIHnzNtfF7dBCHjA7lojV68uuSXi5Sh0EIfu4/1ZkmyqO1XJ8ste4hlKbVrn7YeC5P28qsnOdBDgextNah270g/GjTUtT8QjAPvbX2gJi3Vy9dp41/W6vd8PgOTwcEL03l/H2vbu9K2bPnzK2HzA74f/KrhWosYZIlbtVtBBrep6Ay+1IkODN+YrHhzc7JkmPdnxGn+bbbrN+DkF/AtPw/UnzpXI1vB3z3WPBUUhrykN4IKu7gRxCvR2PTf+OuimdRlUTDWPdNidbcP8LcVBUhtMNn1XD//9tCqkxlpGA7QIoBF4DAj/cPdQCgPsnG0lYLlIOyxSlhBazmZzthKR/T5IfEzReSts3BwLsToEpLtbBPUYeHLa8taPhPFZ99eCfAcyvlsUYs10OAzdt8UcTtQOMa3FreCEkD73cNChAavfcrkn9pk+fWDkm2NY603S3FE0se1mCohUrbj0YS7cbKiIj90kFev+ARb3RGROGkuc5jBkJ9qjwwqdJq2/8WOwHZUtIbd2ZoX05tA833kIZvQWdOlNoDTQujbUoxkeQ3OZqfIxQYK6ghZmJAnOP6VoSqAwrH4668o6dM6YbyfW4IeRoc3L4GgpfcpMwI34o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(26005)(6512007)(83380400001)(186003)(2616005)(6506007)(53546011)(33656002)(36756003)(86362001)(122000001)(38100700002)(38070700005)(66946007)(316002)(54906003)(76116006)(6916009)(91956017)(478600001)(64756008)(6486002)(4326008)(66446008)(66556008)(71200400001)(5660300002)(8936002)(8676002)(41300700001)(66476007)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVBOL0RnOUJUNHBhSHJuMzJxbjJpNUtmSGpHa1diZnhqZ3RuQWIvY0lqOWpi?=
 =?utf-8?B?bG9KQWJvbzVCaTdXTWdWdjQyMXVxekozd1N2NFlpOHJiM0tVdmVjUEppTlFD?=
 =?utf-8?B?MDdzRUlnd0ZpbHpYdXA3cmRld2ZJd0s2VnYwUXdWbDBBYldrL0FGTTRWOUMr?=
 =?utf-8?B?eFk3MVE1Wm0xa0VqZlluZ0dJUFJBSUJNenNkVkROQURTdGhzS0xqcS9ENHE3?=
 =?utf-8?B?cUI4WXRFLzVTYS90SWo3WmJINFkrYUF5bFd3bXFEYVBjbTljT2E2ZVpMREZy?=
 =?utf-8?B?akxqWTUybjZTQjF5eEtndGJVLzA2a0s2NW1TUE5LU1padmVBLzJzQVZ6WnlI?=
 =?utf-8?B?OVJPVU1pTStWTkRBNmRZVjI3dlVPWjRKaDR0TW5hTG1vcG5LL05JVWZGUElN?=
 =?utf-8?B?dXFEMGJqYXUrSTJDbmZQWk5CcXdEaGRwK2ZFN3RqYjBKdHpURlVtNXR6bzVv?=
 =?utf-8?B?QmNXeWZFV21aRkJzNmxnWFRXV2QyNEdQU3NkOXRUWU9PanJsaWxkb2h1bTM3?=
 =?utf-8?B?NWtNdFQ2WngzMUNhZEhRZVBwWjRRSjdkN1lqNW9yUzE0WWxVNkNpWUUvOXEy?=
 =?utf-8?B?NjlkUEF3eTYxMG5kNzFLMDBLeU0rZm1hVHJMeEFMSGpkanVudTVJSHI1cE5k?=
 =?utf-8?B?SHhtSkZKblMwaG9mbkgvalcvV1JtRHpoVnBlSnFzL2NLNEJVcEtBRXA0bnE0?=
 =?utf-8?B?MDk4SXQvZVBPaFdEUVRZemp1QVpFM1ovK3NxU1BFVlN5aHpxZHJLZjF0TWhO?=
 =?utf-8?B?VnJBaHVpenY2aWFpcVRDdE5vWnZwUFJsVjcxc1M4czF2WW5VaVRidm5KYnNP?=
 =?utf-8?B?anY1UCtwYWRqY3FXOU40WlJqenJUQnpMOFA1TnVNcTVZVnhYaVdyREEzaGFN?=
 =?utf-8?B?YTFpMW5uR0NKMk95enlCRnRkTG9KOHppK29KaXhobTlmaG9BOHhVWExpcHJ4?=
 =?utf-8?B?ZkVKRy9zMXk0TnZqdWd0ZTQ5anNPZUlNVWUyRWdJaEh4bVd0K29RTE91RnBp?=
 =?utf-8?B?N1dtTDBUYUNsc1M2bTN3QzhNRDFDYU44NTcyKzI2VUlMa1lYTUhLVXM0dU1j?=
 =?utf-8?B?eHJQMkRMa09rdWJwVmViTG9CaXhDY3UyWnoxRHpEQTR4aUJBY3VJME9rWEc3?=
 =?utf-8?B?RTdOczdsVk1vcGZhK0t5ODg2VjRRTWNzU3dSSHJkc3IvbVRmRWdrNTh6U291?=
 =?utf-8?B?ZFdHcDVZdG5vY2xBQWZITVZDRjdhMFhlTG1PQWZuZ016R3RrUnpXRTJqQnB3?=
 =?utf-8?B?RldsR3V4YnVMZGJRUVpqRlBxRnpiU2JyL0ZUcUlvL2JVNnpCUHFqSHhXTGds?=
 =?utf-8?B?eGhYYm9rbTZTOW1Yd0Z3d3NVS2dQelhkbGxZcG5TdE9NVWNXc2h1bjFIdzVM?=
 =?utf-8?B?QVZaUjB4K1R2eVZWSGNtV21jODNWZGRhdHRRUkVkVDZSNko1eUpOK3lOSGVH?=
 =?utf-8?B?aG1wZyt1MnVacHNMOXpuL2RrRlJBaUc0ekN4cXdhWHF6TDFMelptci80YVp1?=
 =?utf-8?B?VTBaS29pclBZdjR5Z3EyQUFHY2h5UlA4N1lPM0E1am9HK0grS3lwK1JlRTE3?=
 =?utf-8?B?S3U5NnoyMStHbTBLZ2tXbkczdVgzSGtjTENQaW1URHBBcWlSY09Td0dkeitS?=
 =?utf-8?B?TmtzR05HaE95eVlPRzNqNkpvazJtb2V4cThoend0R2ZTOHp1TDJkcHMrWGVJ?=
 =?utf-8?B?NjZJbFdXRGxKS0tsNDRVV0h0REZOQWtzbUZxeDBlWjQ0ZUM2dDZiWUdERG5T?=
 =?utf-8?B?RG5nTkxUaWdsODhoUDJNaXd6S09mcm1NaFZJdDRFUFFlTjlKQnpMY2Z4a0g2?=
 =?utf-8?B?R0c2TmNFOFFwVXVUWWVQYnFXMUZpc0NaNStlK3hJUFdqMGhQNGlncG1tMHFU?=
 =?utf-8?B?ZUtRMzFkVS9LWmR1akFyTER6OWJOUVJWRVIvdVVJOGdPeFk2OEZxNWhyeXEr?=
 =?utf-8?B?UnhhR3lIRzB6cVRhVXpuekIxUGtyZDRVMnJtckExVGpaVkxJbGNmcDNpNEFl?=
 =?utf-8?B?TjlaNFNYVmpjSndHOUM5L2w4M3ZPZTdOeXdMVnhnZ2FDaEVPaVpmY0x1ZmZ0?=
 =?utf-8?B?Rm9PWkJXbmV5dTk0enpOMnpHR0Ryd3FETTkrN2lnSjlRZUhPM1JhWnMyMkFI?=
 =?utf-8?Q?PUMaPyj/lBlAXFTBVtxJgdH0Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBD1F08BFF74504D9A43F46533ADE6DB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f981b1-e14c-4142-457b-08db08750d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 19:05:02.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNXqofDpd1HU5ukc5yWH/72hb8o4a9N/uRDJtbQznruVjbzznDSH9O8A/lqgQImFyCbto9WmBOF4X2CRDnXiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7348
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEZlYiA2LCAyMDIzLCBhdCA4OjQyIFBNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEhIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiAyLzQv
MjMgMTM6MDgsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwva3By
b2Jlcy9jb3JlLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9rcHJvYmVzL2NvcmUuYw0KPj4g
QEAgLTYyNSw3ICs2MjUsNyBAQCBzdGF0aWMgaW50IHByZXBhcmVfZW11bGF0aW9uKHN0cnVjdCBr
cHJvYmUgKnAsIHN0cnVjdCBpbnNuICppbnNuKQ0KPj4gICAgICAgICAgICAgIC8qIDEgYnl0ZSBj
b25kaXRpb25hbCBqdW1wICovDQo+PiAgICAgICAgICAgICAgcC0+YWluc24uZW11bGF0ZV9vcCA9
IGtwcm9iZV9lbXVsYXRlX2pjYzsNCj4+ICAgICAgICAgICAgICBwLT5haW5zbi5qY2MudHlwZSA9
IG9wY29kZSAmIDB4ZjsNCj4+IC0gICAgICAgICAgICAgcC0+YWluc24ucmVsMzIgPSAqKGNoYXIg
KilpbnNuLT5pbW1lZGlhdGUuYnl0ZXM7DQo+PiArICAgICAgICAgICAgIHAtPmFpbnNuLnJlbDMy
ID0gKihzOCAqKSZpbnNuLT5pbW1lZGlhdGUudmFsdWU7DQo+PiAgICAgICAgICAgICAgYnJlYWs7
DQo+IA0KPiBUaGlzIG5ldyBjb2RlIGlzIGF0IGxlYXN0IGNvbnNpc3RlbnQgd2l0aCB3aGF0IHRo
ZSBvdGhlciBjb2RlIGluIHRoYXQNCj4gZnVuY3Rpb24gZG9lcyB3aXRoIDEtYnl0ZSBpbW1lZGlh
dGVzLiAgQnV0LCBJJ20gY3VyaW91cyB3aGF0IHRoZSBwb2ludA0KPiBpcyBhYm91dCBnb2luZyB0
aHJvdWdoIHRoZSAnczgnIHR5cGUuDQo+IA0KPiBXaGF0J3Mgd3Jvbmcgd2l0aDoNCj4gDQo+ICAg
ICAgICBwLT5haW5zbi5yZWwzMiA9IGluc24tPmltbWVkaWF0ZS52YWx1ZTsNCj4gDQo+ID8gIEFt
IEkgbWlzc2luZyBzb21ldGhpbmcgc3VidGxlPw0KDQpJIGFtIG5vdCBzdXJlIHdoeSB0aGlzIGlz
IGNvbnNpZGVyZWQgc2FmZSwgaW5zbi0+aW1tZWRpYXRlLnZhbHVlIGhhcyBhDQp0eXBlIG9mIGlu
c25fdmFsdWVfdCwgd2hpY2ggaXMgc2lnbmVkIGludCwgc28gc3VjaCBjYXN0aW5nIHNlZW1zIHdy
b25nDQp0byBtZS4gRG8geW91IGltcGx5IHRoYXQgZHVyaW5nIGRlY29kaW5nIHRoZSBzaWduLWV4
dGVuc2lvbiBzaG91bGQgaGF2ZQ0KYmVlbiBkb25lIGNvcnJlY3RseT8gT3IgYW0gSSBtaXNzaW5n
IHNvbWV0aGluZyBlbHNlPw0KDQpBbnlob3csIGFmdGVyIHNwZW5kaW5nIHRvbyBtdWNoIHRpbWUg
b24gZGVidWdnaW5nIGtwcm9iZXMgZmFpbHVyZXMsDQpJIHByZWZlciB0byBiZSBtb3JlIGRlZmVu
c2l2ZSwgYW5kIG5vdCByZXF1aXJlIHRoZSBjb2RlIHRvIGJlIOKAnGF3YXJl4oCdDQpvciByZWx5
IG9uIG1lbWJlciB0eXBlcyBvciB0aGUgb3JkZXIgb2YgaW1wbGljaXQgY2FzdGluZyBpbiBDLg0K
DQo=
