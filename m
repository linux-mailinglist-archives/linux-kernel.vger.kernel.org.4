Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BE6F2357
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 08:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjD2GXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjD2GXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 02:23:31 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2089.outbound.protection.outlook.com [40.107.12.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD72117;
        Fri, 28 Apr 2023 23:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOChEnA/zHt6qtYTcwPGpdM8qEmV2QP+KL32RmZHCBxRwzNzlKkKdbL+2pxqbCYeohsTN4KS9sq2G4pF1kREgw+BE8hRNsgPNdy5hYws4qdPHPa9RjJfcpXYOccv6Fq7OP8yo3J7sXcVm7cJf5RjEU7IDhd9Aky58eGtdzBgnKcC3DEVqY1jAXxAMJby4PAn/drZDZURuD95hzvHRk9bjtMsg+gyAlyBoExbS8SytvZaOAsf0vFpOsYd+uCIFeD0C2PkveIRoPbgwSPX+KOPrTNGvun0QvcdcsiZhRyGQTB8eyYbODrilKVRagHduBT6vF0E/jDBsLM+A8rq85tlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3T0vaHx2NEU3vmcFNs4xacAwxoJnHxd8ZHMthm62nI=;
 b=DcgFB72N1CC2wzHraOkuwbMmpWmMRW0+79n4oDEofgXxeMbnqxNbJmtXFfYRa5Znd74sRDPcwZxOJdHRjLYG1HSPEnKxssJUYEo3BRejElvas3nbXvlxJkCS+MLT0g8faksuIwSpQY9ettL8Dw91LXRzgn0T9N/4InUuwkbiDBs03ChDjupRx1rezE5hul+U+D/k8k+bHipZe9/XQwSp0aqB9oyzVhrvTNovapCXM8HtF0c8nC5DwzVaUIJwoHF8Hf1w1ZjoHu2o1dB4f5fzigXoKb7/iCBeF0oPtPb77awKB2IRAp7mU2Vp11UDcG+lTVvBe6BjFk0pJVlxKAzQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3T0vaHx2NEU3vmcFNs4xacAwxoJnHxd8ZHMthm62nI=;
 b=nFsdxdPzHMCM2og2HL5lhxtfJIiUh6qupQzARY4bEYd/C0ocEWGatmRAadPSvXQy0KbCYaDsmAtLVS1CTpIQExirQgfqtoS4GACpceHeAalqleM3oa8VHUJOHskl4Juy0QGO6TbitBPnCyN5K4wx96sv8G2Lhur00yda2T+LHhhXqf9ALJJSo29mbJgWNUzefNnVnsJmIg4mUcdfqYIwBS1Lt1z/KVIFdFwyvT4xU1XT94zd8MHAqw4Hw82DeeYc/cn/PKreRdnSXxuV+MIcr029VafGox5jCKCtHhlEPfdEi4CNj+iFj1pR1SbO78ZvSVKOK/cCxmRyqxmXLkpOOw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2063.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Sat, 29 Apr
 2023 06:23:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25%5]) with mapi id 15.20.6340.025; Sat, 29 Apr 2023
 06:23:25 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v2] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Topic: [PATCH v2] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Index: AQHZegoM7UXCl4eraki9dS+FdVzcgK9B0h8A
Date:   Sat, 29 Apr 2023 06:23:25 +0000
Message-ID: <c4c26104-80a0-ceff-bf06-0a02813acbfc@csgroup.eu>
References: <20230428194541.510674-1-andreas@kemnade.info>
In-Reply-To: <20230428194541.510674-1-andreas@kemnade.info>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2063:EE_
x-ms-office365-filtering-correlation-id: f9a581b5-bcfa-45fb-0e54-08db487a3d30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4uWkfU7YXesXS+a9+shaZMt+CZknCD5Wcubk7ASHEZxvLH96DA4eIuH/hjACpAK0jhCJy/YV06EcqRCFXZca/n75/kh9WfMLjd/qFIB8Df5lfxMaLLgKFGvmGUKLUUbK3YkclqPbPRUVhhLeIavRmXS4eC+f5VOYiq8erMLy56mY607PBD/38Zx2qDrAYr51iy4skTrjYeE48UpLRSBYWKbT9y/qa+KaiJYwnnZrtKjeOJupP7x8Cd4jpjL2RxnnKlJx9eHk1EMwzF6Op1MEITNeV5uBnJRIvKW61utBAOB5FBTSyk1kl5o1nHy0ne8SGzhLxtmutelgD0+pQm2k5czh9nfTtFL2pRKadwVSdhn7twXYF6qDgN8LJ5y7SefU2MHD44EYjLjPRk7T+CDUAgubVEdzTmCkW5otMeUtHfz7tDAp0vFWLhZZ1Q6Fybh52NyEaYrj87dG8Grfvf5gnnwo1MWFVbygzCXS9/DQTThJaHwgUqISMLPIe6CmlQ9G7GxZDA8DsrcOKA1DmSdplICz+x1ztIqZZb/Mhpy43ulZeATNzvpGsVlUTCaijGFT2mekkhTofWKP9ExjfQKHtyfcrK37rtFhyvVVdCLB8iIp5K4/QOTD0eoIcqDFhf5VRpxNCKt0q/Vf25iMA/1ORoriD45MDhFlDFT9Tr4qMZQsitm4wEskCj8ebBa+or4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39850400004)(376002)(451199021)(31686004)(316002)(2616005)(6512007)(6506007)(8936002)(44832011)(8676002)(38070700005)(31696002)(86362001)(5660300002)(66946007)(26005)(478600001)(76116006)(110136005)(91956017)(186003)(41300700001)(2906002)(38100700002)(36756003)(122000001)(66446008)(66476007)(66556008)(6486002)(71200400001)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnA4aThVekRxdEZ0Vnc2Y3hneEJjK29DYXQzOEM5TTh2OGdBQTVJajRVVWJK?=
 =?utf-8?B?MnBUa0F5ck9obmMwaGFmQ1pTNVpnQmMrbU0yeEhDM0RlQmxqNDJUYXNFc1ZZ?=
 =?utf-8?B?aVZiMlQvV2wvMmlZMmlQclQ1ajNGNm9EMFUwK1FLek82UVhtbFBwR0JEalV4?=
 =?utf-8?B?b0cySmRha0w2Y1JWMW5jNVpYb0FVOXh2TjRZclhoYngrcFJLazh0NjFhZ0Vm?=
 =?utf-8?B?V1FhRS9qSzdvVWEwZFpvekJDSnplc2hNU3hoNVZOTGF1eGcwUEs3NUZOdktw?=
 =?utf-8?B?ODYxRUE2NHV5QWNoZXJmNGYvQXZxSUg4VG1OSFI4MlRtYzZrTVdRWnRpd0RQ?=
 =?utf-8?B?eUQzbVR1RDIveGJFOGpGNE5TYUxyOHVSN2JtK3o3RUNkTVYycTMyaTJmeGtq?=
 =?utf-8?B?akY4aVRpdU9LRGVkVERUNkpkVmExZWdmVEFxdzk0RVZKYkl3ZVZqUitwRnBV?=
 =?utf-8?B?S3NLSzNuNEhiZkdvQ2FWZUxQZSs4T01YSGZ1K0xWYjRSR2lzMmF5ektyS0Z1?=
 =?utf-8?B?NUVmcDFMN3RxUE1BbnJ2TkVpS21mMnVUOUZPVVFhdWJZMjEvV3lZNm9FM3Mx?=
 =?utf-8?B?SWJnY041SVgvdHdLWGRyVnhHSVBwemx6MWI3Vy9pVm5IakdCVjkwNnUxVjhl?=
 =?utf-8?B?VmpCVGdHblU5blBGOGVHME1tQnVhVjZRR1dxOFUvNGRxMitZbE5uRkxQdGdK?=
 =?utf-8?B?cGlzWTdUL1FYdm5Zbk1NeXJ0V1NlY0lkK002eWg3eEtKRjFmTXU0aTk0eDNK?=
 =?utf-8?B?azlXVzhrNUJ1YWc5RlY0MXpQcXJHYUkvWEdwdmpCRkZvemJXdUduVFJHeXZl?=
 =?utf-8?B?VjNoS1IzeExWYWlrc2NvQVVVMlFaNFQ3bXZUbUQrU2tKTmtCUGxaUlk2QTds?=
 =?utf-8?B?ZkY1UkVUWkRlN3lXaFFBRExUTkJqV2RzWXkzSk5rQkJoZWxiRXJoM21hZHdQ?=
 =?utf-8?B?ekFkSlFlL3pCL1UyZGkycGNwYzllSWdwVWlYM2tOQUZjYnJtdTM4V0luWnpO?=
 =?utf-8?B?MjF2ZkxkUnRJcWRjckRWd0liWi9PNkt0cWhvYmd0UkY3R0NZNndJWGNwaENJ?=
 =?utf-8?B?bENBbElVSm13Mi92aFQ3OVJWbXgzYVk2WTFQbmxHRzliMFNpNHBEOStyenVO?=
 =?utf-8?B?K3dRL1Q4Yyt0clkvSFRIeEQ2a2ZhU0pOaDVORWFGa3dWbmFCYzc2NTIxdUY4?=
 =?utf-8?B?UXd1YmlvaDVOVW5kY1FSeVhFbHlsTHRKUm9pQkYwSW1tMzdySDF5UkJDUW9B?=
 =?utf-8?B?K1hXTUtDaVo4NnI1VVU2R0d6Q1pWVWttTGxRVDZHVUErWitKUEF5Wk5qQWpM?=
 =?utf-8?B?dGdGQ0VTSDJiUDgxVWpCbTlNL1RvMVE4UnByR0xPZlZwVjNvblZtRjE3a0li?=
 =?utf-8?B?SG1nU09pUEZ2dDhGb3RrZjFKb2U1QTFCUXhxUTlSR055WWhaZTBYMUpjbGZl?=
 =?utf-8?B?NVltK0pxRXMwaEFXYVpBSDdsb0dyV0xLdm44RXp0N3NvTG1IY2tES3l3MDZ2?=
 =?utf-8?B?ZS9UUnN0elFVZ2JNcmc1OGtzYnR5MDFJNmlSSldBOStiZ01lYk56bWZVRTNK?=
 =?utf-8?B?TzZmbU0wTFk2TlZKelpJSEVIbzVlK0xLMHo1WFRXTGMxdGNRd0RUVkllR0ha?=
 =?utf-8?B?a0NsQ1J5MWdibTR2NWF0aU9wSC85bXJjNkhQTkJuSDFWbDl4SkFCZ0lJd0Zu?=
 =?utf-8?B?cmlCZnVYeUVkbFhpMDZxL0c3QzZwU1JhR2ZNY01TZk9LZDdYbUxQTW9URHlD?=
 =?utf-8?B?bGhqQXM5ZG1PNzlicDJFL0RZaDgwWVcrM29pb0pXV2FqRzhJVDF0eUpBMEpU?=
 =?utf-8?B?YTdPTkRaSW5lWFNUZkVsUFAveWc1eWZ3bkRlZyt1WVVNUTRpZFRpRzVacm9H?=
 =?utf-8?B?eHRIL1FoV3cvTW9TS2pwck10cXZnaTB3REcvMGx4N0E3VFYwbWF2VCtrdTIv?=
 =?utf-8?B?eVFvRUVRUjB4WGxPVUhURlpNNjdUNDF1SC8ya3duYXhFMURJaHBIcFYxWDIy?=
 =?utf-8?B?MnNDUHpoaHptSk5mKzNYYTZ0NUpaWFBEd1prcVk4VTBEQ3JtSGRXMlMvSmhZ?=
 =?utf-8?B?OUZaQ0wvTzc2dDMrMlFsY1hhOHFRU0dXK09aODhzNzNZSFBocHQvMnJoYzhi?=
 =?utf-8?B?aUlVTXlQT1hTcWlXTGhVRENrSTN1TnQ1Q2pmQndZVlAyZUlOR1ZMQkV6d25N?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1858C65D820074CB60CF87C2DBA5AC2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a581b5-bcfa-45fb-0e54-08db487a3d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2023 06:23:25.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdxZZ/QRVndsXsXf9ErKuQmnB6MxPIga7A3wkqzorlK2L+BqoYvRsFsYMJj7nIFpbCGZUr2PpPWo8Xh6fwheZCPOjSFgQ562R8pgJwlsKSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2063
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzA0LzIwMjMgw6AgMjE6NDUsIEFuZHJlYXMgS2VtbmFkZSBhIMOpY3JpdMKgOg0K
PiBJZiBzdGF0aWMgYWxsb2NhdGlvbiBhbmQgZHluYW1pYyBhbGxvY2F0aW9uIEdQSU9zIGFyZSBw
cmVzZW50LA0KPiBkeW5hbWljIGFsbG9jYXRpb24gcG9sbHV0ZXMgdGhlIG51bWJlcnNwYWNlIGZv
ciBzdGF0aWMgYWxsb2NhdGlvbiwNCj4gY2F1c2luZyBzdGF0aWMgYWxsb2NhdGlvbiB0byBmYWls
Lg0KPiBFbmZvcmUgZHluYW1pYyBhbGxvY2F0aW9uIGFib3ZlIEdQSU9fRFlOQU1JQ19CQVNFLg0K
PiANCj4gU2VlbiBvbiBhIEdUQTA0IHdoZW4gb21hcC1ncGlvIChzdGF0aWMpIGFuZCB0d2wtZ3Bp
byAoZHluYW1pYykNCj4gcmFjZWQ6DQo+IFtzb21lIHN1Y2Nlc3NmdWwgcmVnaXN0cmF0aW9ucyBv
ZiBvbWFwX2dwaW8gaW5zdGFuY2VzXQ0KPiBbICAgIDIuNTUzODMzXSB0d2w0MDMwX2dwaW8gdHds
NDAzMC1ncGlvOiBncGlvIChpcnEgMTQ1KSBjaGFpbmluZyBJUlFzIDE2MS4uMTc4DQo+IFsgICAg
Mi41NjE0MDFdIGdwaW9jaGlwX2ZpbmRfYmFzZTogZm91bmQgbmV3IGJhc2UgYXQgMTYwDQo+IFsg
ICAgMi41NjQzOTJdIGdwaW8gZ3Bpb2NoaXA1OiAodHdsNDAzMCk6IGFkZGVkIEdQSU8gY2hhcmRl
diAoMjU0OjUpDQo+IFsgICAgMi41NjQ1NDRdIGdwaW8gZ3Bpb2NoaXA1OiByZWdpc3RlcmVkIEdQ
SU9zIDE2MCB0byAxNzcgb24gdHdsNDAzMA0KPiBbLi4uXQ0KPiBbICAgIDIuNjkyMTY5XSBvbWFw
LWdwbWMgNmUwMDAwMDAuZ3BtYzogR1BNQyByZXZpc2lvbiA1LjANCj4gWyAgICAyLjY5NzM1N10g
Z3BtY19tZW1faW5pdDogZGlzYWJsaW5nIGNzIDAgbWFwcGVkIGF0IDB4MC0weDEwMDAwMDANCj4g
WyAgICAyLjcwMzY0M10gZ3Bpb2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAxNzgN
Cj4gWyAgICAyLjcwNDM3Nl0gZ3BpbyBncGlvY2hpcDY6IChvbWFwLWdwbWMpOiBhZGRlZCBHUElP
IGNoYXJkZXYgKDI1NDo2KQ0KPiBbICAgIDIuNzA0NTg5XSBncGlvIGdwaW9jaGlwNjogcmVnaXN0
ZXJlZCBHUElPcyAxNzggdG8gMTgxIG9uIG9tYXAtZ3BtYw0KPiBbLi4uXQ0KPiBbICAgIDIuODQw
MzkzXSBncGlvIGdwaW9jaGlwNzogU3RhdGljIGFsbG9jYXRpb24gb2YgR1BJTyBiYXNlIGlzIGRl
cHJlY2F0ZWQsIHVzZSBkeW5hbWljIGFsbG9jYXRpb24uDQo+IFsgICAgMi44NDkzNjVdIGdwaW8g
Z3Bpb2NoaXA3OiAoZ3Bpby0xNjAtMTkxKTogR1BJTyBpbnRlZ2VyIHNwYWNlIG92ZXJsYXAsIGNh
bm5vdCBhZGQgY2hpcA0KPiBbICAgIDIuODU3NTEzXSBncGlvY2hpcF9hZGRfZGF0YV93aXRoX2tl
eTogR1BJT3MgMTYwLi4xOTEgKGdwaW8tMTYwLTE5MSkgZmFpbGVkIHRvIHJlZ2lzdGVyLCAtMTYN
Cj4gWyAgICAyLjg2NjE0OV0gb21hcF9ncGlvIDQ4MzEwMDAwLmdwaW86IGVycm9yIC1FQlVTWTog
Q291bGQgbm90IHJlZ2lzdGVyIGdwaW8gY2hpcA0KPiANCj4gT24gdGhhdCBkZXZpY2UgaXQgaXMg
Zml4ZWQgaW52YXNpdmVseSBieQ0KPiBjb21taXQgOTJiZjc4YjMzYjBiNCAoImdwaW86IG9tYXA6
IHVzZSBkeW5hbWljIGFsbG9jYXRpb24gb2YgYmFzZSIpDQo+IGJ1dCBsZXRzIGFsc28gZml4IHRo
YXQgZm9yIGRldmljZXMgd2hlcmUgdGhlcmUgaXMgc3RpbGwNCj4gYSBtaXh0dXJlIG9mIHN0YXRp
YyBhbmQgZHluYW1pYyBhbGxvY2F0aW9uLg0KPiANCj4gRml4ZXM6IDdiNjEyMTJmMmEwNyAoImdw
aW9saWI6IEdldCByaWQgb2YgQVJDSF9OUl9HUElPUyIpDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJl
YXMgS2VtbmFkZSA8YW5kcmVhc0BrZW1uYWRlLmluZm8+DQoNClJldmlld2VkLWJ5OiA8Y2hyaXN0
b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIFYyOg0KPiAgICAg
aGFuZGxlIGFsc28gdGhlIGNhc2Ugb2Ygb3ZlcmxhcHBpbmcgc3RhdGljIGFsbG9jYXRpb24NCj4g
ICAgIGFjcm9zcyBEWU5BTUlDX0JBU0UNCj4gDQo+ICAgZHJpdmVycy9ncGlvL2dwaW9saWIuYyB8
IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncGlvL2dwaW9saWIuYyBiL2RyaXZlcnMvZ3Bpby9ncGlvbGliLmMNCj4g
aW5kZXggMTliZDIzMDQ0YjAxNy4uNDQ3MjIxNGZjZDQzYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncGlvL2dwaW9saWIuYw0KPiArKysgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi5jDQo+IEBAIC0x
OTMsNiArMTkzLDggQEAgc3RhdGljIGludCBncGlvY2hpcF9maW5kX2Jhc2UoaW50IG5ncGlvKQ0K
PiAgIAkJCWJyZWFrOw0KPiAgIAkJLyogbm9wZSwgY2hlY2sgdGhlIHNwYWNlIHJpZ2h0IGFmdGVy
IHRoZSBjaGlwICovDQo+ICAgCQliYXNlID0gZ2Rldi0+YmFzZSArIGdkZXYtPm5ncGlvOw0KPiAr
CQlpZiAoYmFzZSA8IEdQSU9fRFlOQU1JQ19CQVNFKQ0KPiArCQkJYmFzZSA9IEdQSU9fRFlOQU1J
Q19CQVNFOw0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmIChncGlvX2lzX3ZhbGlkKGJhc2UpKSB7DQo=
