Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06E2603838
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJSCuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSCux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:50:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F3D7E0B;
        Tue, 18 Oct 2022 19:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5t85n1JaM/BJkFbTOoIJ660+b3r6/VwdTjWRm+xo27L64HoWmG1awr9CubEtuQi3CdyyQM9jXIu1JWehpjQrWSIzeQPL08nOl99c7cOKkB4maOuvjEmfybtG2yTrAv5pf8kvEOqmPF2zTEeqn1bytC9Kx2gjcai/z4ZCANmrS2fNKNgiKOGAWc3Dy2/zkcI8QMPQWgiGUs2aioZ7TMlpC5wLQS2HC47Blp3eZ8bfFFhG4SjrbRjb6nD5Dn+4GW3vA4AZMiXgQjVVnkHPU7ipm/QtAZXdLzDOTiNijiy36+14LdQhQAKNhXd+mwHxf4mqZZkNWNvuxQwan+e+LrJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpQrECDiG5QmF9awuoZpZqwVMQo18Ku3BGwkdBHo/CU=;
 b=nW8nFQDdR05IO+G5NKHMuPxLMrcWuB5Jvy9yHAlAg+MpLPuSV3je01BBZ2ZrfPbvLhIoEZ+0GaTPNmYKdfF2vYUKQV3+EMIRQn48IB4muMcFlYp0Qm3hIByfv8Ds002l0oLtRvw59EZxpUSDKZnjUuLfB3dHoJCq/xi4cOXBvO2Hwimnk7oj3HpXZYHd87rXMWUzIhVQ6rmqn/FMO1OueOr/xtpP86JpV4cpqLw3/gUZw4cn4xuxB6tOp30IZjjffxFIt5IYhlkk1XJL57ZbyJird3y9X80R6XEeYnuqNvr7Ree91CBGrbL2XOoh5/TpQFRnHmS25VbF2exJXPQSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpQrECDiG5QmF9awuoZpZqwVMQo18Ku3BGwkdBHo/CU=;
 b=h+aE4xOcIC6FYw3xVAswyZswbCHjKAzO0Aoy02aYJexllTo5Q8ISgYAOIF9Uu93BBk7L+iqah+WuI42F6mbzffqDT44XCrmGD8RbtkDSp6w43oa/uJeEJbNe8CbWd9bND0umd5z3Faz3uaP9mukSEHdAZLAufkdGAIltllLYp6Y=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TY1PR01MB10723.jpnprd01.prod.outlook.com (2603:1096:400:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 02:50:49 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%6]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 02:50:49 +0000
From:   =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>, lijiang <lijiang@redhat.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "crash-utility@redhat.com" <crash-utility@redhat.com>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>,
        "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
        "yixun.lan@gmail.com" <yixun.lan@gmail.com>
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Thread-Topic: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Thread-Index: AQHY4sowOW0HNCQqKU+2PSWxrOMtua4T3VOAgAAEI4CAAAqigIABCJqAgAAQ6AA=
Date:   Wed, 19 Oct 2022 02:50:49 +0000
Message-ID: <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
 <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
In-Reply-To: <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TY1PR01MB10723:EE_
x-ms-office365-filtering-correlation-id: 911b7ebb-93b3-4c50-ffcb-08dab17cbabd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfzAMY81V2x/TWQE8JFGEPLlCPqOA5bx8ow1IYpTUmtVIQCCJsddI51ZRI9oGHtHj4an5JUmG97qdyLQ8zgs8JQxhMJRqNt3qJB98t6XJ8r/2Z1gSIvGnDtg3sYKZtXwrXIFW/rsfXczAMtm47y2FS8z6nBjPSH+KfD0iXL2YkbZPGu8osI1hNKoscMuXHR62bcgUzqmuLp6bOl37CSLZWj1PgA97/gUvKSbQZwwqQYdNrKXYvCSIcyl/d/mX/G7NN7hLkk1ru+3WtLxWY38bk9a1iP7USm2kWFzux7P5zV0Ay1nbG8fU9aTa6L67KyFLT9GzbyPL9pg5Y4ZkQHpofSLfiIZF9vxtcPVSpC/Uv2C83VRnHa9b9qYTpvgJhIar7EPqVk5BHO9bzHHb2YBnS21O0adRfJ1ksK7oLtRVIKB1Y+u+CdVzlU0RVCSDdg2DZbgd5un6eCY2GlwH2WjCtcAvLJ8muUZ05JZjUAlqqvAr6/F3xTGJDS1UyEK65Dtp97V9PRNg+Q14XGrPsob3lrDF06ve9s94DaezIaS6wo6FVoaUBXJm2ewDf4ZpsNVHWkDT6NMnsohV8hdt3uKxe0vKG1pTNpY6/vsifkl63UlzqBSPOlSD0xO+3iDzM/wISHnCBgcFjqxjVkjYbxc/PNf1s80m8g9hRfhdaja7soKeeUCuQJziqEgqpsc4g5SoGlugPdryScLWPYyN/WQdlR01sFMUXvO+S8lKDQD04E+IMl6Cq1AziT2Cu9/8uTRjdElKHn+A5QUzFt7FcPUhaGlB/snL3V23WOZyUew8eQYhZx4PQOFfOK9TYMz5qt/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(86362001)(36756003)(41300700001)(71200400001)(31696002)(2906002)(478600001)(966005)(85182001)(8936002)(7416002)(316002)(5660300002)(110136005)(54906003)(8676002)(4326008)(64756008)(66446008)(6486002)(76116006)(66556008)(66476007)(66946007)(55236004)(38100700002)(38070700005)(26005)(6512007)(122000001)(2616005)(53546011)(6506007)(82960400001)(186003)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFRnektKbXdxVDFlbEdGTnZ3Z0pBditoMGs3VVp5QVVWWFFpdUFGQXZuVGMw?=
 =?utf-8?B?R0lvL1B1WEQ2ZURNUjZKQ2wyVTJtbklGc0JBcWpZc3FQMnpZUUR6YWxnMERW?=
 =?utf-8?B?M1pQTGtIUWhlSmU3QVRZRDRxdlI5cXVkYTJrRGl5b2dxOEpETjVMYW15cnlp?=
 =?utf-8?B?c3FRR1ZyUGJNZXZoVHpCb0RFNGFycUMySVpkNmhMbzVUaDFFMi9UNUNzRTVV?=
 =?utf-8?B?UVUxUC9lYW1zcUhjZ1pHM1NmZEUrQkdzQjlwV3M5aHAwc2VXTkFBVVJZSDhX?=
 =?utf-8?B?ZjhNTDdjek01WC90SjlkSXErazA1UDI3clVKUmZscm1ILzVnR2ZTTWJablBL?=
 =?utf-8?B?QUdZcWtFS1RTalhicnBEN0htcjdxQS9BaVRoNXF3MUJ2TncvUmdjTm9leEV5?=
 =?utf-8?B?aFJVSmxRTlVZempYbWxsbFRHWGtFZjFTYi94bWU2OXJITlBBYzB3SFdOZkNi?=
 =?utf-8?B?bmhhU2hXZnI4ZTZYcDNrejcyb1F4NHZGMk56czBGZmFPb0VpT1RnZmxaR0Qy?=
 =?utf-8?B?SVI1NjZlZHRuc0FrMnJVakROaFU5NUZPK09iVG5vOHdtRy9UbERkR1V2UVdN?=
 =?utf-8?B?NXpFdjk1c1VHMHl4R2g0amlRSUtMSzVQdzFZQlJDU0c4Zktxb09EUmhkeWJr?=
 =?utf-8?B?UXlzc3VFVnliSVRKVG1JZU1tZ01mVkdzaU5tcGgzWm1aZngwSWcyZms3SDhS?=
 =?utf-8?B?VkNiYlIvZ3RuY2JGNDNMdDJTcUZGemc4cEFlNTFuaTUzLzNwNG5WRFZ3dUpB?=
 =?utf-8?B?UEhpV1ZhbjFiZzlDNFpic1VqTUV6ekM4VlpxSzZocXRFdml4S1FRMTdaN2Jo?=
 =?utf-8?B?NjVDT043NklrU0FqeEN5K1dlUHJPR1daOUIxZ3Y0V2RDSisvWGRVVXJabUZF?=
 =?utf-8?B?RW5uN0R0OE8yQUFMVkZIQjQ2ZTBEM2l2QnBVbjZzN0poeFlpNWV0ZU9MTnEv?=
 =?utf-8?B?Lzd2Z0hyMEROUlBOZ3dJT2ZjTG80NlQvTmFseHJDWG90QjB3OVMrNDFzZ2FP?=
 =?utf-8?B?b01aMklhNU1sOWZ6QjZjWDZpYzdERzRFWk9RdTQrQUZycW9qMTczLzBvMTZD?=
 =?utf-8?B?MHV1YzFQRHNnSEozOFN3SFJJVzY1R0Y3Mll6dGFvWFFnbXBxVVVzaGRLaytR?=
 =?utf-8?B?THMvK0txOHpWUThFZ1ZZa0tqZDRLc29FWS9QakRZaDZZTGJIQ2xCMzNteXRr?=
 =?utf-8?B?NXArR2xnc25CRjMyNm84QTF3K25HOWRoOU1TSURsNFNGcVhhNXZOeHVoY2ZI?=
 =?utf-8?B?bE5WeHM2YmxpUy9VTXNWV2lWV3NaNlBCeE1mR2ZWZDhPamJoNTE1ZisvSVFu?=
 =?utf-8?B?WHNUOWNSaDE1OHEweWp6bmlrUTF4MHhMTnFoVUVMOXFpVzhhT1QxOEZwVito?=
 =?utf-8?B?MUZhbHJVVmw3d01aMStjNkxKSG5VaVpYa2k5ejlRdFExVHJsYWxxUm0xSGZ5?=
 =?utf-8?B?MG5iOWtybVV0SzRnS1k2RDAxT1hhSk13V2VEdXRwaytVeUVVdXFkdFF3UnFB?=
 =?utf-8?B?Wno5dGNlbms4ekx1Mkc0QmgrTWF4dllZczk5dzZ1cTNlWWpMcHAvOHhnRmFx?=
 =?utf-8?B?SEVsSUZCSDhiYU5tLzVueUtVVCtzM0ZSM0kwTWJJWDhwazhZaWhEWWV0U0Js?=
 =?utf-8?B?Q1A3U1RyeDFjbkN1U2hoc3hLWlNINUc1ZlZIOUFidUdsUGYrdU8xdWRJRUI0?=
 =?utf-8?B?eXhwNnQrTHk2YVVQbUh4VFV2TnVEQlRxODhOK3hSRUxOTFZHYWRyNDJSZkhQ?=
 =?utf-8?B?a0cwVkdhMTBHRFlLL2hETWRVUlZUK1hvc05teFp0Z05TSnpKVU05S3ZVM1ZT?=
 =?utf-8?B?TFJ2OGNkR0lJODMwbmpjTUlYVGZlR09Ib2ZZNm5FYkorc2grT21SamlKVGY1?=
 =?utf-8?B?eW4ybkppMzdCcVpVMTVDN1FMSi8yWFZsYTU5Y29peElzTWx1QzlQY3pwRFIv?=
 =?utf-8?B?UWF0U1J5VjVrdVlIbDltcnd1d0E4NExiY1V2VFoxRGhFQm5VOVFwalJmSXEy?=
 =?utf-8?B?WVJXeEFwb1pQTlRoT05wSXJWcUZBZTNWZFN6NmdRSDh2RUQ4alVLUHNPalJ4?=
 =?utf-8?B?YTVlcERHTDE4bnNlbXJVZjYxbUFsUWNiaFVueUt2cktTUk0vT2ZUZ0lXbm9S?=
 =?utf-8?Q?l2YppLHGNj27g4THZbOT4SJ9c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFC54A03F1049D4082AB224A03DEFDE9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911b7ebb-93b3-4c50-ffcb-08dab17cbabd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 02:50:49.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bcG8GWq/r44gc1jEwWzg2tm2uRssR/5htiWYpUPUqtOzpD0Q/no3CV3MNsF/QCEc8zjWe1FZZ/THdMz3ohiYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10723
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMC8xOSAxMDo1MCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4g5ZyoIDIwMjIvMTAv
MTgg5LiL5Y2INjowMywgQmFvcXVhbiBIZSDlhpnpgZM6DQo+PiBPbiAxMC8xOC8yMiBhdCAwNToy
NXBtLCBYaWFudGluZyBUaWFuIHdyb3RlOg0KPj4+IOWcqCAyMDIyLzEwLzE4IOS4i+WNiDU6MTAs
IEJhb3F1YW4gSGUg5YaZ6YGTOg0KPj4+PiBPbiAxMC8xOC8yMiBhdCAwNDoxN3BtLCBYaWFudGlu
ZyBUaWFuIHdyb3RlOg0KPj4+Pj4gQWRkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvKCksIHdo
aWNoIGV4cG9ydHMgVk0gbGF5b3V0KE1PRFVMRVMsIFZNQUxMT0MsDQo+Pj4+PiBWTUVNTUFQIGFu
ZCBLRVJORUxfTElOS19BRERSIHJhbmdlcyksIHZhIGJpdHMgYW5kIHJhbSBiYXNlIGZvciB2bWNv
cmUuDQo+Pj4+Pg0KPj4+Pj4gRGVmYXVsdCBwYWdldGFibGUgbGV2ZWxzIGFuZCBQQUdFX09GRlNF
VCBhcmVuJ3Qgc2FtZSBmb3IgZGlmZmVyZW50IGtlcm5lbA0KPj4+Pj4gdmVyc2lvbiBhcyBiZWxv
dy4gRm9yIHBhZ2V0YWJsZSBsZXZlbHMsIGl0IHNldHMgc3Y1NyBieSBkZWZhdWx0IGFuZCBmYWxs
cw0KPj4+Pj4gYmFjayB0byBzZXR0aW5nIHN2NDggYXQgYm9vdCB0aW1lIGlmIHN2NTcgaXMgbm90
IHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUuDQo+Pj4+Pg0KPj4+Pj4gRm9yIHJhbSBiYXNlLCB0
aGUgZGVmYXVsdCB2YWx1ZSBpcyAweDgwMjAwMDAwIGZvciBxZW11IHJpc2N2NjQgZW52IGFuZCwN
Cj4+Pj4+IGZvciBleGFtcGxlLCBpcyAweDIwMDAwMCBvbiB0aGUgWHVhblRpZSA5MTAgQ1BVLg0K
Pj4+Pj4NCj4+Pj4+IMKgwqAgKiBMaW51eCBLZXJuZWwgNS4xOCB+DQo+Pj4+PiDCoMKgICrCoMKg
wqDCoMKgIFBHVEFCTEVfTEVWRUxTID0gNQ0KPj4+Pj4gwqDCoCAqwqDCoMKgwqDCoCBQQUdFX09G
RlNFVCA9IDB4ZmY2MDAwMDAwMDAwMDAwMA0KPj4+Pj4gwqDCoCAqIExpbnV4IEtlcm5lbCA1LjE3
IH4NCj4+Pj4+IMKgwqAgKsKgwqDCoMKgwqAgUEdUQUJMRV9MRVZFTFMgPSA0DQo+Pj4+PiDCoMKg
ICrCoMKgwqDCoMKgIFBBR0VfT0ZGU0VUID0gMHhmZmZmYWY4MDAwMDAwMDAwDQo+Pj4+PiDCoMKg
ICogTGludXggS2VybmVsIDQuMTkgfg0KPj4+Pj4gwqDCoCAqwqDCoMKgwqDCoCBQR1RBQkxFX0xF
VkVMUyA9IDMNCj4+Pj4+IMKgwqAgKsKgwqDCoMKgwqAgUEFHRV9PRkZTRVQgPSAweGZmZmZmZmUw
MDAwMDAwMDANCj4+Pj4+DQo+Pj4+PiBTaW5jZSB0aGVzZSBjb25maWd1cmF0aW9ucyBjaGFuZ2Ug
ZnJvbSB0aW1lIHRvIHRpbWUgYW5kIHZlcnNpb24gdG8gdmVyc2lvbiwNCj4+Pj4+IGl0IGlzIHBy
ZWZlcmFibGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWluZm8gdGhhbiB0byBjaGFuZ2UgdGhl
IGNyYXNoJ3MNCj4+Pj4+IGNvZGUgZnJlcXVlbnRseSwgaXQgY2FuIHNpbXBsaWZ5IHRoZSBkZXZl
bG9wbWVudCBvZiBjcmFzaCB0b29sLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFhpYW50
aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+DQo+Pj4+PiAtLS0NCj4+
Pj4+IMKgwqAgYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGXCoMKgwqDCoCB8wqAgMSArDQo+Pj4+
PiDCoMKgIGFyY2gvcmlzY3Yva2VybmVsL2NyYXNoX2NvcmUuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+Pj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKQ0KPj4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvY3Jh
c2hfY29yZS5jDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL01h
a2VmaWxlIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4+Pj4+IGluZGV4IGRiNmU0YjEy
OTRiYS4uNGNmMzAzYTc3OWFiIDEwMDY0NA0KPj4+Pj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwv
TWFrZWZpbGUNCj4+Pj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlDQo+Pj4+PiBA
QCAtODEsNiArODEsNyBAQCBvYmotJChDT05GSUdfS0dEQinCoMKgwqDCoMKgwqDCoCArPSBrZ2Ri
Lm8NCj4+Pj4+IMKgwqAgb2JqLSQoQ09ORklHX0tFWEVDX0NPUkUpwqDCoMKgICs9IGtleGVjX3Jl
bG9jYXRlLm8gY3Jhc2hfc2F2ZV9yZWdzLm8gbWFjaGluZV9rZXhlYy5vDQo+Pj4+PiDCoMKgIG9i
ai0kKENPTkZJR19LRVhFQ19GSUxFKcKgwqDCoCArPSBlbGZfa2V4ZWMubyBtYWNoaW5lX2tleGVj
X2ZpbGUubw0KPj4+Pj4gwqDCoCBvYmotJChDT05GSUdfQ1JBU0hfRFVNUCnCoMKgwqAgKz0gY3Jh
c2hfZHVtcC5vDQo+Pj4+PiArb2JqLSQoQ09ORklHX0NSQVNIX0NPUkUpwqDCoMKgICs9IGNyYXNo
X2NvcmUubw0KPj4+Pj4gwqDCoCBvYmotJChDT05GSUdfSlVNUF9MQUJFTCnCoMKgwqAgKz0ganVt
cF9sYWJlbC5vDQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29y
ZS5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jDQo+Pj4+PiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZDdmNWZmMTA4ZGENCj4+Pj4+IC0t
LSAvZGV2L251bGwNCj4+Pj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NyYXNoX2NvcmUuYw0K
Pj4+Pj4gQEAgLTAsMCArMSwyOSBAQA0KPj4+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkNCj4+Pj4+ICsNCj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvY3Jhc2hfY29y
ZS5oPg0KPj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9wYWdlbWFwLmg+DQo+Pj4+PiArDQo+Pj4+PiAr
dm9pZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbyh2b2lkKQ0KPj4+Pj4gK3sNCj4+Pj4+ICvC
oMKgwqAgVk1DT1JFSU5GT19OVU1CRVIoVkFfQklUUyk7DQo+Pj4+PiArwqDCoMKgIFZNQ09SRUlO
Rk9fTlVNQkVSKHBoeXNfcmFtX2Jhc2UpOw0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoCB2bWNvcmVp
bmZvX2FwcGVuZF9zdHIoIk5VTUJFUihQQUdFX09GRlNFVCk9MHglbHhcbiIsIFBBR0VfT0ZGU0VU
KTsNCj4+Pj4+ICvCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1BTExPQ19T
VEFSVCk9MHglbHhcbiIsIFZNQUxMT0NfU1RBUlQpOw0KPj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZv
X2FwcGVuZF9zdHIoIk5VTUJFUihWTUFMTE9DX0VORCk9MHglbHhcbiIsIFZNQUxMT0NfRU5EKTsN
Cj4+Pj4+ICvCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1FTU1BUF9TVEFS
VCk9MHglbHhcbiIsIFZNRU1NQVBfU1RBUlQpOw0KPj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZvX2Fw
cGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX0VORCk9MHglbHhcbiIsIFZNRU1NQVBfRU5EKTsNCj4+
Pj4+ICsjaWZkZWYgQ09ORklHXzY0QklUDQo+Pj4+PiArwqDCoMKgIHZtY29yZWluZm9fYXBwZW5k
X3N0cigiTlVNQkVSKE1PRFVMRVNfVkFERFIpPTB4JWx4XG4iLCBNT0RVTEVTX1ZBRERSKTsNCj4+
Pj4+ICvCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoTU9EVUxFU19FTkQpPTB4
JWx4XG4iLCBNT0RVTEVTX0VORCk7DQo+Pj4+PiArI2VuZGlmDQo+Pj4+PiArDQo+Pj4+PiArwqDC
oMKgIGlmIChJU19FTkFCTEVEKENPTkZJR182NEJJVCkpIHsNCj4+Pj4+ICsjaWZkZWYgQ09ORklH
X0tBU0FODQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1C
RVIoS0FTQU5fU0hBRE9XX1NUQVJUKT0weCVseFxuIiwgS0FTQU5fU0hBRE9XX1NUQVJUKTsNCj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihLQVNBTl9T
SEFET1dfRU5EKT0weCVseFxuIiwgS0FTQU5fU0hBRE9XX0VORCk7DQo+Pj4+PiArI2VuZGlmDQo+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoS0VSTkVM
X0xJTktfQUREUik9MHglbHhcbiIsIEtFUk5FTF9MSU5LX0FERFIpOw0KPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKEFERFJFU1NfU1BBQ0VfRU5EKT0w
eCVseFxuIiwgQUREUkVTU19TUEFDRV9FTkQpOw0KPj4+PiBTZWVtcyB0aGlzIGlzIHRoZSBmaXJz
ciBBUkNIIHdoZXJlIGthc2FuIGFuZCBrZXJuZWwgbGluay9icGYgc3BhY2UgYXJlDQo+Pj4+IGFk
ZGVkIHRvIGR1bXAgYW5kIGFuYWx5emUuIEp1c3QgY3VyaW91cywgaGF2ZSB5b3UgZ290IGNvZGUg
Y2hhbmdlIHRvDQo+Pj4+IG1ha2UgdXNlIG9mIHRoZW0gdG8gZG8gZHVtcGluZyBhbmQgYW5hbHl6
ZT8NCj4+PiBLQVNBTl9TSEFET1dfU1RBUlQgaXMgbm90IHVzZWQsIEtFUk5FTF9MSU5LX0FERFIg
aXMgdXNlZCBpbiB0aGUgY3Jhc2ggcGF0Y2ggc2V0Og0KPj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1yaXNjdi9jb3Zlci8yMDIyMDgxMzAzMTc1My4zMDk3NzIw
LTEteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbS8NCj4+IE9oLCBJIHdvdWxkIHNheSBw
bGVhc2Ugbm8uIFNvbWV0aW1lIHdlIGdvdCB0b25zIG9mIG9iamVjdGlvbiB3aGVuIGFkZGluZyBh
bg0KPj4gbmVjZXNzYXJ5IG9uZSwgd2UgZGVmaW5pdGVseSBzaG91bGQgbm90IGFkZCBvbmUgZm9y
IHBvc3NpYmxlIGZ1dHVyZQ0KPj4gdXNlLg0KPj4NCj4+IEZvciB0aGlzIGtpbmQgb2YgbmV3bHkg
YWRkZWQgb25lLCB3ZSBuZWVkIGdldCBhY2sgZnJvbQ0KPj4gbWFrZWR1bXBmaWxlL2NyYXNoIHV0
aWxpdHkgbWFpbnRhaW5lciBzbyB0aGF0IHdlIGtub3cgdGhleSBhcmUgbmVjZXNzYXJ5DQo+PiB0
byBoYXZlLiBBdCBsZWFzdCB0aGV5IGRvbid0IG9wcG9zZS4NCj4gDQo+IEhpIEthenUsIExpIEpp
YW5nDQo+IA0KPiBDb3VsZCB5b3UgaGVscCBjb21tZW50IHdoZXRoZXIgd2UgbmVlZCBLQVNBTl9T
SEFET1dfU1RBUlQgYW5kIEtFUk5FTF9MSU5LX0FERFIgYXJlYSBleHBvcnQgZm9yIHZtY29yZSBm
cm9tIGNyYXNoIHBvaW50IG9mIHZpZXfvvJ8NCj4gDQo+IEluIG15IGNyYXNoIHBhdGNoIHNldCwg
SSBkb24ndCB1c2UgS0FTQU5fU0hBRE9XX1NUQVJULA0KPiBBbmQgb25seSBnZXQgdGhlIHZhbHVl
IG9mIEtFUk5FTF9MSU5LX0FERFIsIG5vdCByZWFseSB1c2UgaXQuDQo+IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yaXNjdi9jb3Zlci8yMDIyMDgxMzAzMTc1My4z
MDk3NzIwLTEteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbS8NCg0KSW4geW91ciBjcmFz
aCBwYXRjaCBzZXQsIEtFUk5FTF9MSU5LX0FERFIgaXMgdXNlZCBpbiBWVE9QKCkgYW5kIGxvb2tz
DQpuZWNlc3NhcnkgdG8gbWUuDQoNClRoZSBvdGhlcnMgKEtBU0FOX1NIQURPV19TVEFSVCwgS0FT
QU5fU0hBRE9XX0VORCBhbmQgQUREUkVTU19TUEFDRV9FTkQpDQphcmUgbm90IGN1cnJlbnRseSB1
c2VkLiAgSXQgbWF5IGJlIGJldHRlciB0byBhZGQgdGhlbSB3aGVuIHRoZXkgYXJlDQpyZWFsbHkg
dXNlZC4NCg0KVGhhbmtzLA0KS2F6dQ0KDQo+IA0KPiBJZiB3ZSBuZWVkIHRvIHJlbW92ZSB0aGUg
dHdvIGFyZWFzLCBJIHdpbGwgcmVzZW5kIHRoZSBjcmFzaCBwYXRjaCBzZXQgYW5kIGtlcm5lbCBw
YXRjaCBzZXQuDQo+IHRoYW5rcw0KPiANCj4+DQo+Pj4gSSBhZGQgaXQgaW4gY2FzZSBvZiB1c2lu
ZyBpbiBmdXJ0dXJlLg0KPj4+DQo+Pj4+IFRoYW5rcw0KPj4+PiBCYW9xdWFu
