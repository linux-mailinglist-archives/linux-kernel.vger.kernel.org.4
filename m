Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B7692BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBKAGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKAGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:06:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88EC7CCBC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676073976; x=1707609976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tlw5tCGKnRoFWUa6lLpeOMNvh2gROtLlu2dGKJldSh8=;
  b=dCIa6WzGYpAkkX0Mp6/qwzDVk+e++CeXI04/EY9Ihe+6IOdAOgqK/wTt
   RynOB+pFoKckgqYV4G/uScssccN8YUSX5O9AIPXAEhEEc9yRFLexTTNb5
   EfzN2MvYomUvl3BN2bh7dLxVsYc0HSAbtfw5krUrFNY81d6/+XeAfX6Jz
   SqPV1bKe/f45rs9xgSclHarxMrPn8hHoOyTbN7RybQSmPHwAfYwHXUT5P
   7ljYT19akJOu0hyLOFjUCQjY8gWAlKiQaplp+2JodL4P1mrvnf4nwPn45
   I99yuutHaF7ONV40EV2YkHEkDCHH6lp2rf2+xNfYPdmTxSi6KwPduhC4F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331863654"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331863654"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756956880"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756956880"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 16:06:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:06:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:06:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:06:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:06:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF6goHXAtJeHcXlvPdWGnKKdj+AOmvbTuRhM7JSXntWEj4bn/xfJJpKH3AiG9ovSGT+mzKSHFte1H4YOHrnfiO8Mhbe5P4ikibzuEsmrsGPee6e/ESz/yXtqE2Ytpd/Lt4AYrT69Dp1WTNzd2KyNrZYqQI8O/yKDezu0MOp3/Bb3u7oFbajlVzZ/TaCotsCao9DYjJ+Te6Naqgrt0tWSc4yBTfPzn8maUy2miN4o9fNiLXR6r9+4SzD5fQDCWkr9ldnMOyWiSiaMqJzBzCAatzwmRepv3o7NPAYYwG4ojP5s202XBTba5RgEhGoOE/ODkUdi5bVCN3UWeTcusBT97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlw5tCGKnRoFWUa6lLpeOMNvh2gROtLlu2dGKJldSh8=;
 b=mf5zdHo4PUJp2V9DYj5Pmj8KVjtWm24tbHLThNUHk2DwlmkfaPJpW/s0i9rDW1R+mqFgkY3pmqDr4Fkz/bGzsIzQYy3uuMBunZWqPhSUZxtlGLouYKNMR3Zl1pAe9gpG79vaaCVpPP+oBKVVBt6WiXSaEzQb0BxUsS0qbamuWsVliE88A5ksDNaP9WEc6XLed/u0KBWDBxO/vdMUBqwHxN8NVfKznzd9s2F9W+h/RpLK+lJaCKur+S3z//RBnqdZLOYLTnjgoDizbRxfhDfvgFGbKekjaDsRYL3GMI79fGGMywbwiBs2y/A5fcASgShz9rOKIlTlRwTMKqMYcSCh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 00:06:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.019; Sat, 11 Feb 2023
 00:06:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
Subject: Re: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Topic: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Index: AQHZPayiMrUL2vEOhEu4fW2AdzHA3w==
Date:   Sat, 11 Feb 2023 00:06:05 +0000
Message-ID: <92a63877e054775884d9c7a7d15ed613cc3059bc.camel@intel.com>
References: <20230209072220.6836-1-jgross@suse.com>
         <20230209072220.6836-8-jgross@suse.com>
In-Reply-To: <20230209072220.6836-8-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: d9f6d468-f207-4f2d-a65c-08db0bc3c502
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6a1m3Qnma48zM5qvmk9nIxaSZDmPlMW5IZWRRUnzBoeqijhwPbF2Pb6/131ojG8XTsylImcpbBHUrBUpVSlUC06HZ885Y+m/KKPc8cewwtRuRdal5k53H9MnrSFPDJ6hU9Km2ISyjfs5QEqrr+NXitC6E2eoj0GNTa1wRtXgVKFeKtnwSALRld8xfanCNBBB91Br2WIKe/w5BkaXpOl1Yf2sZC/wkHTJgCqVwQuq+UfByYSu7RydOpokmfs1pYwm9m4jOmFZMLXT0JpCJJdwwfg7MC24Rzwn/nwurYuPPhhtUgSP/D6bHoH8WQL87YcVg7d3qf+0tYDw7m8DJJFwC+kWLQNM3H7RW8Nr1ImvyshxQtiIWhctSKL/Sjs6iUxmGLuBa/V0y+YrNnOsDqPBOfK4h8eculQKFIxNejOPxzZ/6yO/WtDcP+aHaR773McFXd2jz1/eRNmlOA215aFozFQEYzMwRcoYBellJPLbSRyTw74m6i6ArtNTbpt8R1DCb9KXasVQc6/WY3HmL3rAQDhg0uZX/xHn59SnGa8RJ/Eoy9tacRZNtXn1baB5j7Vh2V+MruAYY0qRwFJy/QNeJKCp6OWza/t4zNgrg74tCZX1lGwMKuyRPPl0B0VcfUFlknT0OsSCslUCyUFRxY3IZMl3S1hmkHjx/YeCZjxngEQSNWmyj6py5D9pIpgeBS/ghY3ED82ZDVg5V4W74x/T73oh1tCPG7qIxz7TZINnS0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(36756003)(38070700005)(122000001)(38100700002)(82960400001)(26005)(86362001)(6512007)(2616005)(71200400001)(186003)(6506007)(478600001)(6486002)(7416002)(91956017)(316002)(110136005)(8936002)(41300700001)(66476007)(5660300002)(54906003)(2906002)(64756008)(4744005)(66446008)(76116006)(4326008)(66946007)(8676002)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aldBSThTbWhHSktHRVRRUitoQWYwMlFFSzlSditmM09JQ3lBK2xwZFhmMm1V?=
 =?utf-8?B?R0xnbGFoa0FDd0daRGpkYTU2ZDBKNFpsSTQxaVUyYzhUcnBkOWJhc2s0M29U?=
 =?utf-8?B?ODdPeUFhOFY0V3g3ZXYrb2I2OVhER0FOYXhrQm9TOEVScStGVE9ybG9VUkZu?=
 =?utf-8?B?bXN3aTVZaEVtV2sySnUwRGJld1pZNVB5ajlFNkdtRXEzbEZKbDBSaDNPTHZo?=
 =?utf-8?B?UHZEUkd2cjFvekVEQWlCZzVFOWFZRnZKRnlseGxZM0Jrdk9WVzFERWtNR0F2?=
 =?utf-8?B?WUxyVUdybEZ1Sk9kTFpadllBOXZucDE1NWJrMU4wVUttVXp6MmhaWG1tei8r?=
 =?utf-8?B?YXg0SlFIbjk0RzNrZEVUUVVtT21NRExyQlBuRnFzTXJWalFpRUtYRktGL0kr?=
 =?utf-8?B?eWlwSTlPVXh1ZC84Q1lRL3FYVm1lOGxnOGpZV2VjSFdDU0FRM2tnY3owdm42?=
 =?utf-8?B?VTdPRFF3ekl2MGJzUG8rejFyejgyNVpjYmlsZ25oYzVWcUVrT3V3di9WL09T?=
 =?utf-8?B?MXhRZG52ek41QkV5RnFLY0NPM0Y3Qk9rTG16bzVXSmtTSjBWN3QxTkRHbjFK?=
 =?utf-8?B?SlQxK3lGYS9ua01sWVZNOU96ekpaWkFXM3BiMG5wUEdkSWxPWW1FWXBWdGNP?=
 =?utf-8?B?K09PZWtLdVlHcTd1dzNUMUhoenFwMEtUTTZ0SnB0VytmNnBrREJ4VC93YkpY?=
 =?utf-8?B?dkFMdlBwYUhQWi9Sck9tL2E3V0hHYWJ1OCtmRk9OTzZjbG80VHBXWkwxV1ZK?=
 =?utf-8?B?VHN0aGZsenBqTHA2Y29WYkM2Mm1TbHF1UU9wcG01NE1PUS9ycjhOZStIMjYz?=
 =?utf-8?B?dmZhd2Z0UGVkcXpGNnhKSHB2cFo4b1Q4eTJRZGtGcGdjNmpwV0UwbnBkZWNn?=
 =?utf-8?B?RUtrV0NmTFduVWVSdTFLK1c4ekFObHkzUDQ0eFQrWjdodjNLU1VSWDNDaDdo?=
 =?utf-8?B?M0hhTmhMSTBtQ2hlMHZvZkVkdVFvaThrZi94NER3QjNkdDBqbjFDSDdWZ3l3?=
 =?utf-8?B?ZHV3VzREeHJEdEpibjc1cmFDSFhaRCtjRHZTYTJhb3BwSmMxbFFsaEdqeDZ0?=
 =?utf-8?B?MkJBZ1YyUzFyblhLQ1RSbWovUitORzZscTBHN0Zqc0pEd1Q2NnFQb1Z0OUZJ?=
 =?utf-8?B?VnJ2VmRvOGpJUkdBVWxHU2VGaHpBclJ6d2JMQkpzSlExWm5JTVB5eUt2Ym1j?=
 =?utf-8?B?VjFiemNqdnFHMGdMSVhGdFR6ZFAyL2NFaXVMOGFXWkZOUkROcXBsR3lWQ0Vx?=
 =?utf-8?B?Z2tnTmF3bTgzbFc0NURQZW9HblJqWElGNUVYL1ovbEs2ZjgzZ29jVThReFBJ?=
 =?utf-8?B?SVRNYVRNMzNiOHZVdU9CbUhBejl2MGRZWUlINW9HaEwxL3JMQW13VG9hREhq?=
 =?utf-8?B?MTFub0xNSnFTRDJROFdsZFI2Q2dJTkR5eElkSjdhS3N6RHFnVVRRUFhQb2lF?=
 =?utf-8?B?SXBLa3oxbVZITzhpbHlSdytkK1pjMXBzaFFZdlBBa2syTm5jYTR6clJabjVt?=
 =?utf-8?B?VnQrNUV0eUh2UElkZXRVVDBsaStwTXQzQXVGUVU3dnBSR0RMa1NzU2dyWkY5?=
 =?utf-8?B?MkxLT3hRM2o2c1hTNnVjSFFaQUhuRmZXVUJuSUR6MnhRaUVveFd2TnpvSm1u?=
 =?utf-8?B?NHo2ZDAvTDVMaVVyTnZFNWZYL3ZaVDZSTVdHTHBQeTUrTWRDOHdzOUQ0eEFt?=
 =?utf-8?B?OHorSDhaVEFjSVYzdXJ1cGIzYW1IKzhTZmlvblZGcWJFSlNBOWRQWVdBbVdJ?=
 =?utf-8?B?bTF5Z1Uyc2plenRzeU1jYUpDOVdDQlpFcVlaaks1ZHNHSnJqVVFKTDFKK1R5?=
 =?utf-8?B?YUtaVEFhd0ZCMjNkQ1FtQlpkQmE1SElOc1hFK3VwZnYyQXF3M2NUU3hjVU1D?=
 =?utf-8?B?amU3RWlQTytCNnpXZzdJYk5MTnNQTzMrTDhYazBuVGlqR0pJaFRucC9CV3hN?=
 =?utf-8?B?Q2RtWmt6WlpoZjFnRWtUSlY3eDZlN2FMSndqbnNrb1ZES3ZBVDdSK2xqT05S?=
 =?utf-8?B?ZDNicW0wRzhQVXlRQjZvTWY3enBNM2NxNm9ueUE0c3RSVHpYeFgzOHU1MHNY?=
 =?utf-8?B?QTVibGZIMUZ2UFNlZVlZOEVHeXdTWlJneHptWlZTMU5WcnlXSmQwMmxWM2dC?=
 =?utf-8?B?WVdlay9WTUlQcGF1STlYU2xhaXlJMGtmOUYwV2hWY1FLVkdUZlo2TlFMNXQz?=
 =?utf-8?Q?mx15y1LpeZ0xick4/4Ck/hg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5271E9F1C98C534D880834FB85C46516@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f6d468-f207-4f2d-a65c-08db0bc3c502
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 00:06:05.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1v/Hvd6gNZ0SO9mmqL63LKVcyJQ8lBBnG6EU0Y2ocyvSOZzj8w6TQYq1g1P2MZn/pW+Lg6s/Gr1Vb1Sh4bfuPEzpHickNLbngyu8XpUmuzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDA4OjIyICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJs
ZS5jDQo+IGluZGV4IGU0ZjQ5OWViMGYyOS4uN2I5YzU0NDNkMTc2IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9tbS9wZ3RhYmxlLmMNCj4gKysrIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jDQo+IEBA
IC03MjEsOCArNzIxLDcgQEAgaW50IHB1ZF9zZXRfaHVnZShwdWRfdCAqcHVkLCBwaHlzX2FkZHJf
dCBhZGRyLA0KPiBwZ3Byb3RfdCBwcm90KQ0KPiAgICAgICAgIHU4IG10cnIsIHVuaWZvcm07DQoN
CidtdHJyJyBpcyBub3cgdW51c2VkLiBDYW4gaXQgYmUgZHJvcHBlZD8gU2FtZSBmb3IgdGhlIHBt
ZF9zZXRfaHVnZSgpLg0KDQo+ICANCj4gICAgICAgICBtdHJyID0gbXRycl90eXBlX2xvb2t1cChh
ZGRyLCBhZGRyICsgUFVEX1NJWkUsICZ1bmlmb3JtKTsNCj4gLSAgICAgICBpZiAoKG10cnIgIT0g
TVRSUl9UWVBFX0lOVkFMSUQpICYmICghdW5pZm9ybSkgJiYNCj4gLSAgICAgICAgICAgKG10cnIg
IT0gTVRSUl9UWVBFX1dSQkFDSykpDQo+ICsgICAgICAgaWYgKCF1bmlmb3JtKQ0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQoNCg==
