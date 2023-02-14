Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F672695A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBNHTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBNHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:19:33 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E8DBDE;
        Mon, 13 Feb 2023 23:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8ih1/ESPQBtmFCaSP9vLwANF/mFSgJpfIHKaiQbDlpRCZS4UIDJEip8VB7plPCXxXd367IJmIcgWpvxKXfLpn1M3xL1RT99Xq/vMmatt+dCGY/k6PIg7IrY2BvtHDg1wU3gTNOto7Gbh1hrSRYQzYM4lKWs1jn8xrSa5ea6Q+woa13r5VxN6E5fA2acMMCv0wQa1Tfp74H3bblpEMJ6BI0EXLqP+RML+4Kn/17+1a/EIuynef0gjx3wF9OAw5XDKnyFlzVJ9qdIzUK2XrxnvMq1b23xeYN6CczVSnE7bTlFnqvfYmScmvt7PmiTeYCM3pFxTZRilmDBIFqhaMe2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOOi//3qGDF1iftGREy0qAJtUAm7tOYrSqwbgObWsRU=;
 b=mJjsI7JbtsR/YO9h3WIqYJRwV/yKGzsJI+eur2qMcPE3yaiYGIbTCXyMSmc2EMwrcA4trIkhcBzUKFaF9BEUMErpnTWfLrjF2YrbpVTS2vawQL5V6KhtdbNgbo5rcUQJcP5OB4956TAsmnBj1N2zaumVyzLPAWv0u3sANsBw7gk9AkrOz0JJgWHtLlt/tjaQpa7crXz29ee+GbEjuwbS08TdMZxK3ODuetCfgWV1cUhHA3n6QTRW+11mkbJn+yZv1CF7yD2sGMUtRpw5KzBKden4KIbH9Bj3cEUpFLjLHcNfZZiUVfG85rNyzgHWckx0CX7ln/5e4EYrNbNmFvAypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOOi//3qGDF1iftGREy0qAJtUAm7tOYrSqwbgObWsRU=;
 b=FYcwtvdh0tAQ6rF+xhYcfJFJ+dJRmQ0aVnDBf64uO15njD98aNXYXvAO29dryHNkx74p0vaRIzWmeMOYv+tbmY09BayvMf7IDugfTkLc1hnVnpGAwuX37Pxg0QtwBeJfQ7ZsMRwCjupNEtedU56+ihxIqeiw2q7kZDYdf+CRtM/M26iRGZhh4NrB7/4UhhG1xEgtf+RbLnysUr3xMqylKhpPHizP6kaZiW+6/SmGlieQvGrG4PIjLlOx9nhJkKmWa3nNUL0dCbFDnCGbL7X+A47XN9UKWth8kcV3lTEJ2TqxECwSLJ+URdISt33BvXGXfRe6LEnEedY7Md2En3SthQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3058.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 07:19:27 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 07:19:27 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jgross@suse.com" <jgross@suse.com>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "dalias@libc.org" <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [PATCH v2 12/24] powerpc/cpu: Mark start_secondary_resume()
 __noreturn
Thread-Topic: [PATCH v2 12/24] powerpc/cpu: Mark start_secondary_resume()
 __noreturn
Thread-Index: AQHZQEL33lGs8jLy3kyVtrUVS4KVD67OCNAA
Date:   Tue, 14 Feb 2023 07:19:27 +0000
Message-ID: <3a1be09c-b9fd-a473-0819-81a4ebdf34cc@csgroup.eu>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <b6b2141f832d8cd8ade65f190d04b011cda5f9bb.1676358308.git.jpoimboe@kernel.org>
In-Reply-To: <b6b2141f832d8cd8ade65f190d04b011cda5f9bb.1676358308.git.jpoimboe@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3058:EE_
x-ms-office365-filtering-correlation-id: 036ce762-ea50-4c9a-5f15-08db0e5bcea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlM2WL7gzKouOCRcDxGdANrT3eFPzbRudlRUE2W4RDxPaEwA4QcHCfrSsHSb7teWFu0HMh2HD/0Wtcs7BQnXtIPnHU0f1dkspb8uRRBjEQJbkyAHK07DiMlYNVReYlYpQTq7b/vPBWGm96QblFYhjYjgY3bK7Doz4PTT27QHG+qzBFJA/GuY7nhFy23PcT4sFaL8VD5Y+e0yLmqZOgEpthkUdpl60S5A4mJaqg8sp11UyzqWjuHCtV9a0HqtaEQq76p0K6MD3dCs6xyO932PAgGaOcr+QGWmbTAor8Tuwfxugus4gQK4BdUW8cxmllXWJyuYVKDSxqmqB3NnbHDWCYq7hkNE5r5/aS6wXIBINyjzCb61xpy2NKGTf7411y8TcQ2G6K8kc3QroLFjGRcomkO76GykJOq95wiiCkUPyXPHPXiF4wipk6GgW38ZTTGBzMTLhJTGPK3QYBGrchh4r4+PN2flf/gCfPlSs18v8FprXTGvrUpdZx9s5ZW8ajk7f1cvVlGMpWu1STr0ixPi4olORFZ20JNb+Az8cMEu5Txiz89oQFO3uiQ+IApQA3bHdStb8feoITF4C68CJhOLy5M7WJGURVB1OTl8tTKujck/1U8voj7gUZpvkt4etjGU0GjIQGinddNjaOwli275SLu80DqWVjLjGCv+Er2luJ/d8K4xcEYPV1gK2lWoaqDeJponPojLjuOPOGxyQ3b5imwAaWKryvFodvlGS/TR9c1wvDTJupChX52Czxjb2n4Kr5sjDk8iyslcNWVIaMoFww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(451199018)(8676002)(66556008)(4326008)(64756008)(76116006)(66446008)(66476007)(66946007)(91956017)(110136005)(54906003)(2616005)(316002)(83380400001)(31696002)(122000001)(36756003)(7416002)(7406005)(86362001)(5660300002)(44832011)(2906002)(41300700001)(38070700005)(8936002)(66574015)(38100700002)(478600001)(6486002)(186003)(71200400001)(6512007)(26005)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFFLQXUvOVFwYkZETVAwdnZUN0FBQ0c3RVRlOGdkTjY1ZUJ0dXFFcjViaGFv?=
 =?utf-8?B?ZTA4OEkrb3d3NUxNRUVmWFBmejlhZnFtdDk5VGZMM3pGYy9sVnZnUXRId3Qr?=
 =?utf-8?B?NmtCV3Q5Y2U0NEM1a1lpeE4xNEpDTlJsWWJTY3NwbzNPTkd5N2gxZVZsM3Ri?=
 =?utf-8?B?SDI4d2loVDlyNFp6TEhzbnJSeEx4U29CS2E5R21vL295Z1lzV2Q1bmNEdGZE?=
 =?utf-8?B?TE5rL281a3NReFZ1cnFvSDNPWU85UTd3YVJ0Wkt3R1JwOHpodVoyVi9IRXNa?=
 =?utf-8?B?cC9KTnJIZjRRT0tEbmdLREpWSGRnZE5OcldvR2lacG5XeHVLbi85ZGM1N3ZB?=
 =?utf-8?B?anR4OW5tT3VNb0tXSy9JaWplc0VIWThoc1hpOWFpQzZwaDdySk5ITWMyMnhj?=
 =?utf-8?B?dGlHWE1QdGFNSW5ySWlxc21OWGhxdDdPVkpZT2Z6dnQ1SWFXZXV4aTJ4YU1u?=
 =?utf-8?B?NFZha1lHWmFkVi9mLzVDRWlZbGpwOEZwT2VTdDhTdExRZkR6Nm1WOFdXNXFa?=
 =?utf-8?B?VUxHTVpZaWV2NWlvWWJuSU1OTm1penB4TjhOQ0Fpd0w4OEkzRG1DZmNyU0Vv?=
 =?utf-8?B?YUJsbWhHdDFiaytjL0RPTkR4V2syMzdySHhsTzJ2dTR2QzJLdjJaQTNSQ1hH?=
 =?utf-8?B?L1JmcUdVRTVBU1BTMWlOQ1RhYm9PZXIraUJoc2VIbjdOa0lQdm5odW5rcHo1?=
 =?utf-8?B?bjl3MWlNY1lvMFBGdjRPU0h3T0lPVzFjWHFrWTZ3Nk12T0lua3JGclhjQ25m?=
 =?utf-8?B?aEt6SDE1TE81dUNsaTVqVUplUlVqMUl2SkVuOUFCR1FwYjE4c3VlbUpRUWts?=
 =?utf-8?B?WEZUT3JGNUEyTHFkdkY4Q0Z1ei9QT25tQjhITEVxaTNHL1dvdzZIRVVhcDdX?=
 =?utf-8?B?V3dhSWdlOXo3eDNmZ0tiTEgvNVJ0NmRtQkpBWlVLMjhva3JGcnphd05JN2Yv?=
 =?utf-8?B?VXNvL0JVellNRFRCZ2cvWHlWM2lweWVCRU5zWEZXeDI4NGVpZnZIU1FpK0t0?=
 =?utf-8?B?bTZwK0dNU3NWak1jT2QzZGVZOUdZVFA3aUdMT08rZWZyQ1V0eGJDK2tLNCtJ?=
 =?utf-8?B?OEdhbUhQT001NVNWUU9NLzFLVGlYMHRmWDVlSXo1aGlXSWgreHcxVE5iV2l3?=
 =?utf-8?B?OWtReVl4YVh0S1d6YWNzUS9FWXpPaTM5SzQ0MkhZc2pHSzhRdk9zK1ZDNHZm?=
 =?utf-8?B?SDVhK2Q5dHlkNmNrTkliR1VFL3JORjV2MGovMXRzZlMyZUhzY1EvUHFYa2JL?=
 =?utf-8?B?b2dZYmViTzFKaFd3SmtGNjJHZEN6blVnVmZRUmMvalJ6QmNkWVFDMXIrUXc5?=
 =?utf-8?B?dzc2ZjQvZThJbVBYVjR2eE13bmthekorSDQ2N0NBQ3BPZldDSE9vRjlOdmFw?=
 =?utf-8?B?MnFwWGJ6VHFqVXZycVo2K3VyTHdoKzJ5WlVYOVlvR0lFS2YraU5SL1UveHpQ?=
 =?utf-8?B?REtSTFdvakxzSmpleDhENVRoOTBZU3VYQW91czBaUm5WazdmTWt1czA1OUM1?=
 =?utf-8?B?c0l4Y2UyeFRGTUQ1NW9oai9xZWpCcGxyZHdCbFVOWmo1TlAza3I5M2dkV1Bp?=
 =?utf-8?B?UmYxbXUrV1ZmaG5QUjVMeEgzRUR1dlJrdHJOTDUwT01LZGhZQ2xEUW9OVjF1?=
 =?utf-8?B?WDV4YnFQYWRMMkhlTHI1dDJrS0V3MmRVc2tWRnc0VVZCMmdkYldjWXI3Rk9w?=
 =?utf-8?B?OFc5UlpWWWNoS0lHZ083WFZmVkpZWmVkelNvQlFiZG0vODFKb2RoclBUVWN0?=
 =?utf-8?B?cjZxVDRKdmI4SW56YlpTSktuNmZ0WmNxNjRZTzNDZWhyYzNyNENUZjBPZG9p?=
 =?utf-8?B?d1cvWHM1N0pzeVJKanhvQVpzNDJ4M005Rk8xTEtpQUFrUjdVVS9kOGxkUTB1?=
 =?utf-8?B?VHhnVDFLN2xlQVpETkFnem9hdk9hMlNjNDFzVnltVjNLU0VYNlJPb2dGaGdj?=
 =?utf-8?B?enAyR1RBdlhQbDNPYkxPYlhKQzBwdThwUHd4eVNJZVMwanJMbU1QWFROa2tn?=
 =?utf-8?B?VVFrSTRYSTRsdXkyRWRVMU10SHB6cnVua2dYZy84cGNoa2dXQ2ZXbEtyL05D?=
 =?utf-8?B?WWJWTXJXZ3hxZDdid3c3blp0ays2SnMxWEdmc3JwQWorSlNrZXB3ZEl1RWcz?=
 =?utf-8?B?WGgxcmFIbXFuYk44RUhld2dPMzN3ZkF4WnhMeVJpMHVRR2VLeXVFcVFGdjla?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA9565E025CA04783A6E7B9F488EEF5@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 036ce762-ea50-4c9a-5f15-08db0e5bcea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 07:19:27.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KeEbSHDW8u1pUyxSDiH7hSPiYuy+T/M/tLq5kGhTIRyucgBKiiiUNAGtlsaG51dRHgC5I3wBHa2jZYfUR1gE1H6xZMuzsLyC3vD5Tk2fxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3058
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE0LzAyLzIwMjMgw6AgMDg6MDUsIEpvc2ggUG9pbWJvZXVmIGEgw6ljcml0wqA6DQo+
IHN0YXJ0X3NlY29uZGFyeV9yZXN1bWUoKSBkb2Vzbid0IHJldHVybi4gIEFubm90YXRlIGl0IGFz
IHN1Y2guICBCeQ0KPiBleHRlbnNpb24gdGhpcyBhbHNvIG1ha2VzIGFyY2hfY3B1X2lkbGVfZGVh
ZCgpIG5vcmV0dXJuLg0KPiANCj4gQWNrZWQtYnk6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxl
cm1hbi5pZC5hdT4gKHBvd2VycGMpDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2ggUG9pbWJvZXVmIDxq
cG9pbWJvZUBrZXJuZWwub3JnPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hy
aXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9zbXAuaCB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9h
c20vc21wLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc21wLmgNCj4gaW5kZXggZjYzNTA1
ZDc0OTMyLi5jZmQ0MmNhODc2NWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRl
L2FzbS9zbXAuaA0KPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc21wLmgNCj4gQEAg
LTY2LDcgKzY2LDcgQEAgdm9pZCBzdGFydF9zZWNvbmRhcnkodm9pZCAqdW51c2VkKTsNCj4gICBl
eHRlcm4gaW50IHNtcF9zZW5kX25taV9pcGkoaW50IGNwdSwgdm9pZCAoKmZuKShzdHJ1Y3QgcHRf
cmVncyAqKSwgdTY0IGRlbGF5X3VzKTsNCj4gICBleHRlcm4gaW50IHNtcF9zZW5kX3NhZmVfbm1p
X2lwaShpbnQgY3B1LCB2b2lkICgqZm4pKHN0cnVjdCBwdF9yZWdzICopLCB1NjQgZGVsYXlfdXMp
Ow0KPiAgIGV4dGVybiB2b2lkIHNtcF9zZW5kX2RlYnVnZ2VyX2JyZWFrKHZvaWQpOw0KPiAtZXh0
ZXJuIHZvaWQgc3RhcnRfc2Vjb25kYXJ5X3Jlc3VtZSh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIF9f
bm9yZXR1cm4gc3RhcnRfc2Vjb25kYXJ5X3Jlc3VtZSh2b2lkKTsNCg0KV291bGQgaGF2ZSBiZWVu
IGEgZ29vZCBvcHBvcnR1bml0eSB0byBkcm9wIHRoZSBwb2ludGxlc3MgJ2V4dGVybicga2V5d29y
ZC4NCg0KQ2hlY2twYXRjaCByZXBvcnRzOg0KDQpDSEVDSzogZXh0ZXJuIHByb3RvdHlwZXMgc2hv
dWxkIGJlIGF2b2lkZWQgaW4gLmggZmlsZXMNCiMxOTogRklMRTogYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL3NtcC5oOjY5Og0KK2V4dGVybiB2b2lkIF9fbm9yZXR1cm4gc3RhcnRfc2Vjb25kYXJ5
X3Jlc3VtZSh2b2lkKTsNCg0KDQo+ICAgZXh0ZXJuIHZvaWQgc21wX2dlbmVyaWNfZ2l2ZV90aW1l
YmFzZSh2b2lkKTsNCj4gICBleHRlcm4gdm9pZCBzbXBfZ2VuZXJpY190YWtlX3RpbWViYXNlKHZv
aWQpOw0KPiAgIA0K
