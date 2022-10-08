Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598FE5F8325
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJHFkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJHFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:40:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC97FD13
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665207630; x=1696743630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fntf7H6ME6Qqe0ypysjYJIh01cUoPitjTG9YSm1fGU4=;
  b=PiaCibdKI/CFSzeSAsSw64H+PrjVNPxP5qV3Dtm0x0g+0M2P7yHfTjkZ
   +rzZaw+niKhsT1niGokfsD56dV7XShV76a+tMTPklM1+1VIDsQzNqzpt9
   71Knc0hKJWOg6QV/PaDKqf/klEzXHdxSwVX4zqqbDyMkIM6AOh7PXYBUf
   Pr4mPLD5TK3ZWEie54ggb++jyMdCTFHiY55rXVs/QDw8dwe3MDRULuCt0
   E1p474ZnvDDSqSdERDstAWAactAELeZ/ipw/Hpu3dpR6QO6aupgTEZKZ2
   bRNQJtqvvnWWs/0CGEWsvYX3zSRTpM/MRZzsu7Z9BPnfN9C36gR120czL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="302622882"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="302622882"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 22:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="688158882"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="688158882"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2022 22:40:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 22:40:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 22:40:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 22:40:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 22:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mODMnUO+3H9mpgd+zHLlQPK2SkAHnoDIgiyvZDMc6IeKKewIJ8W+pZEE3Toe0Lw9ehKAaoH+KXd6O9VWU1nGk2bwWv7RUzuub3WMHjzy/FLaTW8S1U1CsCJJ+IIFBNbOZzN9DDEaLUjZCcnf88lSgvmCqobIkKjmLh+l411r3x12O3Dglz0vJIM38PeKCy3Cn/VifiMHosFXwWSC4tVPq6Sx3XJV5maP2EI1ccV5U8d5CpXRvMQT/EAToXiFI5xKSY51XsVey+XR9p4SGlsmxyfFQRXMlIaGt/BhMRg8Z/x47LoYg1/wMcP/7gNfZmSNJZcmAtnpEkap5POvQIseRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fntf7H6ME6Qqe0ypysjYJIh01cUoPitjTG9YSm1fGU4=;
 b=P0r2UuEkPrs7A5QeSnmPmrjBgswQ7mhBTL5lPCYKSTYKqEWktNpHG9MGn1/DNQm7OBvQWzXJrc/CvDE3wNjYQvA6anOncnnEyh3Wr8JqvV9CYqDOKyba/lE7BQ2mkngYDJoFNAKc9the5EmUdhlCkAkx+4jMxJKqdz8ZAQDSS589n+p/6ul6wYSV6YHaFkrR/JykjnZNHYDk55DorJbI3h1UXSF5w84Rbkrah7akym+jyAN2TPcSvwq+KjOafvqyKOfwGsnUX0Syy/3GTvdAyQDeFGHTC14/BF9Xh/MKFD3DMdxHQQ9f6TIt4wxpjIJ++oikbGCfceAHEfOf/li5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by IA1PR11MB7176.namprd11.prod.outlook.com
 (2603:10b6:208:418::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 05:40:22 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 05:40:21 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Brian Gerst <brgerst@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DHbeAgADe43A=
Date:   Sat, 8 Oct 2022 05:40:21 +0000
Message-ID: <BN6PR1101MB2161E1191DF1BD0135DC3947A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com>
In-Reply-To: <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|IA1PR11MB7176:EE_
x-ms-office365-filtering-correlation-id: 9dc763ae-9d56-4afa-9d8b-08daa8ef975d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +bLiEjauMuuPgSGMeJpoLjFftzVIUc35/25yjYbZWfgoal3YAIDja/G6241d+hzel7QTK9YkiNoLJG7DRCvcSaYwccZvZO4BhMnQatjoVmEI0OWYw2U6Y2CfGs9LP6FVCSX0uO6snAmoNolNIJvXZYU9h8xUg6bU7j4VX4SRtS/I1QBKrSCgfUExQBPgliHqr52BOm2oXMmgdqUMi3VsxYSvXh6vhOwFAJcNL8so+AskNCt5x2JjvWOf22clttq5z5mnt/m1XrVOYRl4hvRIvTztk4oQzbuQkAQExaBBf6gowx4zWT9ZJelBROhO2p45XKZdPSUN7KAtsVEj8cF+WPEdQj1Qf5ctvf37YVMSW3+7xeSk2aXpgb+JaX52lk33rHnQ2iKuptd0uelECjttxrbfCqxGolOSqAsZ6q9d8YPeWrsB1YKEQXA5fJTurauanIfBct7ayprB4RRdUmbBaESpuq2Gh5fEMY75gvIo7h69UpHjYT6KDnG3ACkEhEr+jdSv4HX4dUAE7MfWKrwz1dPS5v2hjN99jdES1gtCRE9vgmgvjGL2FzOjWqDcxWC6+3eSpmyjNiw53CHihibtK/ufuPeeZ1kNn5glfIndDFqAPRHW5ffw6bwyDqplDCstIPK3UG2+z+eWklkDDYVUEaGRce7tj9hjcV59cDgm7/Jr8vI6NLYFJuiU9RfuZs1C4+Bdci4YQJA85kl8jj+XajMDodvmYKH/key6hpas73Q3PdoJ5WZkzGDpoAY5MfeCeub8ztm1BKtV2paONOYhXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(2906002)(7696005)(54906003)(4326008)(8676002)(6916009)(66946007)(66446008)(66556008)(4744005)(66476007)(316002)(41300700001)(33656002)(71200400001)(52536014)(86362001)(76116006)(478600001)(5660300002)(64756008)(8936002)(6506007)(186003)(82960400001)(38070700005)(122000001)(9686003)(38100700002)(55016003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0x1OGxUL0QzS0JCMUcyVFpoTTZ2bG9SSllWL0ZVdWY1YnI0Tm16aFkwMERG?=
 =?utf-8?B?Uk4wSXRzSDRVZ3hvQ3NsQUZWcWFoL3ZHaWJoWmRUbkpWM0EwRSswTjRjTTM5?=
 =?utf-8?B?dzgzWDdEenp2aWlkN2NES0ltakNLdzBNbTNnYVNFL2ZEeXF6NXRCTnJzZDZx?=
 =?utf-8?B?UHB4TzZyOTFSUDkxYmRlMWpkMmhnMTdlR1RTNnVSSGhBMDhBNW5oY2ordFlO?=
 =?utf-8?B?K3hnSmtOa05IR240TWh6bkZvWG9xT0x1dUZxZU9mcHFWTExsVExQZjZOWXhQ?=
 =?utf-8?B?UUljdjc0eGVJVlFSN3FUajBCWUZlSmROYXZnb052R0FNSGp6Smx3WUFQZXRF?=
 =?utf-8?B?RlhmN2RibndVN2pIOWhNTEoxc1IwK1kvMXoxbG02RVlvbXJJayt0b205YUFw?=
 =?utf-8?B?UGM4RUsyanAxdmhHbWtxT0syWlQ0aUhLTklOd1RQcS96OWFVOEF1QjA4OSti?=
 =?utf-8?B?L2JMOUdkbTV5Z2RkdE9MWE1leko2TUZoenRMdnhMTGF1NnhLSWhUcUZvU1lj?=
 =?utf-8?B?d3dNeUU4VWZveGxsK2VzNmczS3NLblhhUUhXbFVObUdIVm1qRHJJQ3dwODlV?=
 =?utf-8?B?bGo3Z0xxcmlWQ2dGTUVyYVhBQVJaT0MwTFR3UjdjQVBpWHVJdFBpdDFtL0ZU?=
 =?utf-8?B?bHdPUlppY1JxWkJvWGFjZjZDdTdVL0tBQW5qTXFvUUV3M0RYc1ZKWEpZVmEr?=
 =?utf-8?B?aURQZVl0YWpVczBhSjJNaWpvNjExVnljK0Qxektra2YrblRxUDk0UU9LbURN?=
 =?utf-8?B?YXBMOEpRb3dESTcyVCtHSzdJZTBpcVQxV1BJOHJOdHNocGdyUktEOWZnMUt1?=
 =?utf-8?B?eTZtT2s2QXNZRTZPNklpakR3UmFpQld3QThSdkE1dEJ3QzJrV2N5OEIzTm1y?=
 =?utf-8?B?aHhQbnFWOG9hNkxMOVJtbkdpRnliL1YvbHQ4bUx3NGI4bDNSa3YzK0Z3OHp6?=
 =?utf-8?B?d3BjeWxjRDFqUVVaaER2a0kzRzJlc3hPZmgwcytIeGVyZVJTWkdMdDZrRitI?=
 =?utf-8?B?czNzK3Z4VzVGVHltVjNKNEhSa2p2TCtaV0FwQ094cUVhYUwrK3NuL0g3WkJK?=
 =?utf-8?B?SU8wNVpLOWdqdDROUmFBK21JT1A2cFc1TnJsQW5XZGowMUZBN0lFZWl3Q01u?=
 =?utf-8?B?bDlUWlNualNGTmhDcEJMLzZoeHZYcDZpOW4xeGlOMWdBU2RUbzZzWm1yNWg5?=
 =?utf-8?B?U0hFdlVyVW1TdkJsTGNyZk9LNkw5R0gwVzkwSDFVQ3MzVmRPSGsxemNZdUR1?=
 =?utf-8?B?RXhFdGNrYjVCT1BoUlJnczRUWDFEMGNJR2VER0prcXp4bVVuRnNjemdoVit1?=
 =?utf-8?B?L1RGdWkrSEZNQzBnQWo1RWR4S1M4amI0K2RvRUt2UmYxNGZsb3laamZhNXB5?=
 =?utf-8?B?bklNa0dhZFhUUERLYVdMMlhKSnNwN2RZNmU3ZnMvSi9McERZY3ZYWTNDSTdy?=
 =?utf-8?B?OVdNZFVRQ2RLb1JZM0dxSStIeUttTkN2VVdCS3Y3TEtjRnIxZlJuNjcrQnM2?=
 =?utf-8?B?UDZqTExoa0ZUZkZzSnRUY2FZYS9UQitCbHFzV0hSTlh0UUdXbDNaU3ZPbzFN?=
 =?utf-8?B?dldnN0VlNnVKY2hGcUZpQXNhaTREQlhyOWtHVy8ydFhIajRQQVhBeTM0LzZ2?=
 =?utf-8?B?aXA5MnBDbWl1alFUNjF4SG9OSUo2NzNITHpqNkR3WHlwc0p0TS9PWThVVXBC?=
 =?utf-8?B?cWJObzlwMk41cm1MQy92NTlTbkJIUDFXV05RMmFvNXlxTEZwYXFudWYrMWhD?=
 =?utf-8?B?OEtyd1pjTjZ2WGhnOHVjdWtQejRndjlBbnY3eXJGUmlaQ0l5cTJ3ZDBoeFIr?=
 =?utf-8?B?bklyYUE2Z2ptMXpDOE9wRi83cXVDNXJpaEFoSERTb3NlOU83WTNRZ1NWYVRE?=
 =?utf-8?B?K0VKc1B1dHVWTWtOZTk5UzZLWEhJa1hKanhIcjJRTERRQmlnUXFOblFTcmln?=
 =?utf-8?B?Z1dhTVFlTnpOdGM5OVhsVjBzQjRGUGhnOS9Yd1BEZmdNRTJ2cCtndGdMZ3dw?=
 =?utf-8?B?QkZhUlI5QjhsbXp2b3hSSGNIRjVrK01nMjYzRXpJall5ZmNQZWNTTlNKM2E3?=
 =?utf-8?B?OEdaNWRRWFRMM1NjbXhUZiswMkFVUVFmSGxxZEM4SFQwWFRKbDRjSDVpaG03?=
 =?utf-8?Q?gFjA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc763ae-9d56-4afa-9d8b-08daa8ef975d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 05:40:21.5866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F16zHj9PqDLFHH5H7z/bDR6pB4c2EuEANLA4i6i+qC88gLghBjGIGUWcdqXeXglyTWb+tQMocdFoD92LlKuL2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsgICAgICAgYWx0ZXJuYXRpdmVfaW8oIjE6IGNhbGwgYXNtX2xvYWRfZ3NfaW5kZXhcbiIN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICIucHVzaHNlY3Rpb24gXCIuZml4dXBcIixcImF4
XCJcbiINCj4gPiArICAgICAgICAgICAgICAgICAgICAgICIyOiAgICAgIHhvcmwgJWtbc2VsXSwg
JWtbc2VsXVxuIg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIiAgICAgICAgam1wIDFiXG4i
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAiLnBvcHNlY3Rpb25cbiINCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgIF9BU01fRVhUQUJMRSgxYiwgMmIpLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgX0FTTV9CWVRFUygweDNlKSBMS0dTX0RJLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgWDg2X0ZFQVRVUkVfTEtHUywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIEFTTV9P
VVRQVVQyKFtzZWxdICIrRCIgKHNlbCksIEFTTV9DQUxMX0NPTlNUUkFJTlQpLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgQVNNX05PX0lOUFVUX0NMT0JCRVIoX0FTTV9BWCkpOw0KPiA+ICB9
DQo+ID4NCj4gPiAgI2VuZGlmIC8qIENPTkZJR19YODZfNjQgKi8NCj4gPiAtLQ0KPiA+IDIuMzQu
MQ0KPiANCj4gVGhlcmUgYXJlIG5vdCB0aGF0IG1hbnkgY2FsbCBzaXRlcywgc28gdXNpbmcgc29t
ZXRoaW5nIGxpa2UgdGhpcyAoaW5jb3Jwb3JhdGluZw0KPiBQZXRlciBaJ3Mgc3VnZ2VzdGlvbiBm
b3IgdGhlIGV4Y2VwdGlvbiBoYW5kbGVyKSB3b3VsZCBiZSBiZXR0ZXIgZnJvbSBhIGNvZGUNCj4g
cmVhZGFiaWxpdHkgcGVyc3BlY3RpdmUgdnMuIGEgdGlueSBpbmNyZWFzZSBpbiBjb2RlIHNpemUu
DQoNClRoZSBleGlzdGluZyBhcHByb2FjaCBwYXRjaGVzIHRoZSBiaW5hcnkgY29kZSB0aHVzIHdl
IGRvbid0IG5lZWQgdG8gY2hlY2sgaXQgYXQgcnVudGltZS4NCg0KPiANCj4gICAgICAgICBpZiAo
c3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfTEtHUykpDQo+ICAgICAgICAgICAgICAgICBhc20g
dm9sYXRpbGUoIjE6ICIgTEtHU19ESQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9B
U01fRVhUQUJMRV9UWVBFX1JFRygxYiwgMWIsIEVYX1RZUEVfWkVST19SRUcsDQo+ICVrW3NlbF0p
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBbc2VsXSAiK0QiIChzZWwpIDogOiAi
bWVtb3J5Iik7DQo+ICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgYXNtX2xvYWRfZ3Nf
aW5kZXgoc2VsKTsNCg0K
