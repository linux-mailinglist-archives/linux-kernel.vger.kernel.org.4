Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73BA646855
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLHEwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHEwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:52:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1159895C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670475130; x=1702011130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LjoGZ7kyx0JeudJ5adElwIU+LvGxz/c5TRkhEqk6heE=;
  b=kjt6OMbS5EJ8kAPvuyblFHbShbEw8b6fzu9SjpCO3jsEMSq+irmda30B
   umGDsgBnfe4egDIPEY9O7MDEYUghOGj9IhmWewHzx8fEouBHp58Kye0UQ
   3SJbaizLnmWIvlY4oRnXrnMoXhDtZkYfvjcS6vSgbsTip/Fa3XNIFNRki
   rkQaJO4kmXmZhR7Du5IbEgd07NzrlLgmublsf2qV1TqtnAbiuZhXqba/u
   ZZQNeb0API8gxkVtRHRY1zuMc3NLv6cHYeKzayI8y9wsd66FcOkqVt1hN
   Ge5EJm95zOeyvXZs5WRfpGpbhybnXU0GdmiM0KMrI7LIeKq75bS/ZbihN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="296766338"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="296766338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 20:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="735649207"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="735649207"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2022 20:52:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 20:52:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 20:52:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 20:52:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 20:52:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYYCKCi3LIh9teXswnL4JSAOOv4J5yCYPBZXihzX4ggnAIpuYXzK8Z4dYY/NSgvZMzUJ3Q4hItekSc6f1cmgSumMElUczaIw+J9b4zqOqnlNZrGINzJRkhiNB4aXuAg5m9ACfwtPW026GAR0AXbtHJWalUsqRi5E33iddFl1yzuDf3oK8TtcSksx5vvAiHFUTejtM8+3633Iw2J9Kkl57Z9HA6i4YYtA5WMUXNxXJ2PTaAgu9Fv5dd4eWgBSPqBK0yZDn+fD9+bb8R7TruYxMEdWQ1MpIQHnAU/Z41CDisRGqcWOh7y8qhKmm0KH3fSX/P4BKALGPYLcUyX5akE4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjoGZ7kyx0JeudJ5adElwIU+LvGxz/c5TRkhEqk6heE=;
 b=c6Nr5u8HghLQypemBld6OOx4/UBIInXnGq1xJdJKKXh+v1Znoz9r4NNYgrTuSiwc93NUMaqLBqD6QeaMIAiA7Gx8J5ZhwKFoC+5NjPWjRLOJN0ZrdsgKUo5g5NYZRKyOjWvo2r8ZLe2OsrQI8CxusW4gFCETIftkzulGmIY90FMOmf1CJIvl6cItb1ZWmc8okaQ3JBswhpJUSSyUfw6wKVVCAlhAu2h5WGaQOozzoUMX4quN1iS4yFW116D7QLbDpl1Ask/d0dWVehsMn61M0eidFDkbjL0WN95XtbIzrbvU2Uj4kPzLHn+I9IoLLS9EearRKFEVhYiqC5xD78+mvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1984.namprd11.prod.outlook.com (2603:10b6:300:110::11)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 04:52:07 +0000
Received: from MWHPR11MB1984.namprd11.prod.outlook.com
 ([fe80::a9b8:eda2:3507:4587]) by MWHPR11MB1984.namprd11.prod.outlook.com
 ([fe80::a9b8:eda2:3507:4587%12]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 04:52:07 +0000
From:   "Hall, Christopher S" <christopher.s.hall@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "N, Pandith" <pandith.n@intel.com>, Johan Hovold <johan@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: Intel timed i/o driver in HTE
Thread-Topic: Intel timed i/o driver in HTE
Thread-Index: Adj6qih2Gsi7knz7SkKtEKSdboc8IwBFScgAAOFR9zAAD0o4gAE6XjGAAGMv55AAQSdKAADoSnFg
Date:   Thu, 8 Dec 2022 04:52:07 +0000
Message-ID: <MWHPR11MB1984A17A2263E5EBAB8B9853C21D9@MWHPR11MB1984.namprd11.prod.outlook.com>
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
 <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
 <34baa0b1-72c3-e4b3-3eaf-9b07fe86c3df@nvidia.com>
 <BYAPR11MB324034C53D14D8F7E332A3C5E1179@BYAPR11MB3240.namprd11.prod.outlook.com>
 <CACRpkdaTaDNB12vkmUVdmk0yBH-YW07RfcDO97q7d+ppLHj_iQ@mail.gmail.com>
In-Reply-To: <CACRpkdaTaDNB12vkmUVdmk0yBH-YW07RfcDO97q7d+ppLHj_iQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1984:EE_|CY5PR11MB6233:EE_
x-ms-office365-filtering-correlation-id: 9187132d-0c6b-4986-afc5-08dad8d7f571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EXlXulYzBs8b0Hr7i98jXFQQ8ag9xuUUZC2Ff59kSAusysJASnRbV30AhTxOsq5/1Cmi/1dkuw8g8ncU2lY7oteIohQk9TP/k3IWvvBcpRpjpXCtNo0AMpfVJacDC7hBVh/+3AJ5Ehy7OcHB27nm++ofCmQNuNsCXsFPM1GsX+NsRdup3kZNNJ6OtB6Fo9xebzI0ClhwMKOwWcOluneDQVe3ggJMSpkVBhOV9i3EGDkfMhHfgFkjuI9nFg8JmoQH7xUSqQnbz+pBKIFbM8QnRBVIse8lazB0oCnaWJyGLiQumaeGaSX452CDl7rgGSPbTTCHwEhe3O+CAJ0b2UxGT+FTb9Ke6l76TURm/7gu+GRh0q+wVFiZ0nPcXc4lTkooQCdw6BdIF145oQMvZFfHAU/LyBGk2NWuzsk9gG9NZkVCYtg2G9e5vccJXgC0CqSuTjVOOGISk1XvPpGBFoTkRPjTE5nyjNb51dNrE5XuTKDqvXp0sit03zAeELMmoDKE28WbihMNRkCBM+KxQm5sSUUwaMKMEh1GWvWJ8g9xoXINdmZvQbvGNBdRaKQWF63wkvUws8JIXfA8ZPv1bmq7BoLQyS8l9LaRCHLHLYyYXsxtQ7MTHz1i9R5WiNWiGB/LOpDTk5+2u3TsVLZ7rYPQqL+rpqEHN/+gOcioAWcJehn66xDe+NiGR1XW3QLhqsvYKrQ35PUWcusNjN1+ndTJvFRZxRt++0r+rKG9D+GvXAbiZrMSIg+sb2RXFnfDEri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(5930299009)(110136005)(38070700005)(478600001)(86362001)(54906003)(316002)(33656002)(82960400001)(122000001)(2906002)(38100700002)(71200400001)(186003)(53546011)(9686003)(6506007)(7696005)(26005)(5660300002)(41300700001)(83380400001)(64756008)(66476007)(8676002)(966005)(66446008)(52536014)(8936002)(4326008)(55016003)(76116006)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzhFckdLbGJBTmprRlNQMmd5bzUxOXN4RFFEeG4yMWVobzVIclducFo0cjJn?=
 =?utf-8?B?QlNCbjRUYWUvY1lDNzNFNkhSdGEzekl0dmZQOWhJUUhIYWthNnNSVlFqb1Fp?=
 =?utf-8?B?NFcyYlZvMkgxMkNkL1dKMnEzTzNsa1BFR3gyNDF5TWxEY1ozQmZJeXlzRHpv?=
 =?utf-8?B?M2NEVVRBUTdkWXdWNVBjckVkQ2V5ZUJuUnRRSldVa1JvMm1ZcWpZeml5L0tv?=
 =?utf-8?B?YTRUT0xkWGFCNkQ3Zlo2RjZiSCtpZmNQdVpLeHNFaVF6OHBQM3hsZkJWMThC?=
 =?utf-8?B?L1lYYlJwY21Qb3JsVkswRVF0VjA0Rk9ncDZDN3NHYWI5K3ZzZXVxUUt0T2VZ?=
 =?utf-8?B?M2RnMzFHYkRJd3FPcnFoeGJLaU1yR28rMFhqa2Y4MVVJSW1qY3NFcTRKdVpT?=
 =?utf-8?B?UnlQV3ZoUnhFaGdiY3dRMTVjamJXUTBDSUNvRmNYNUFsQjFNWkxrKzM5ekpy?=
 =?utf-8?B?MTNKbS9OMExFcUZSSExqaHgyVUpkTHdyMkhhcHhERlZjcVRzcXpRbEJMMGRz?=
 =?utf-8?B?RjJ4eU9XeUp3TUdDNVhTT1dxWk9rc0JSYUVnZzZyMG95UFQxZDZLaGNtMFBY?=
 =?utf-8?B?QnFMY1RYRDM2cThXUlV1RVppQXVBY0tRWk9hdlRmMWZGUDMwV0c2UEhlQVov?=
 =?utf-8?B?YXRVeTVxdlZiRXRNaEg2V2FENDdzUHhsbVR1TXdHdk9HdHBzdUo5VC85OElY?=
 =?utf-8?B?emN1blN1NVZaL1NudzdBeTJBUlRybUhQVVFWamdTTi8vMEhrK3puTDRjZFBV?=
 =?utf-8?B?WUo3SHNPRmlKY1Rna09GT09RTjBha2xJM2d5YmpGSUpncXkwZ3FCWjdqTFN5?=
 =?utf-8?B?TXJ0emgwSTBMNkR1QXl3cHhtdWh5aEJ2TG9LZmhvSHRsc0t5ZDUrWE5rbURv?=
 =?utf-8?B?L3QzOXEwVms1dEpDZ3Vxcm56Vi9ReHpIU0pYT3Y5ekU1T3B5cUhQL2VDQVox?=
 =?utf-8?B?dGpXWVR2NDh6R2s0NFlIbUpqWlVJWmxtVlZkTTFabHBBeHQ1STZVR21WU1p1?=
 =?utf-8?B?ZlFjMXdLZGEwNGJKUC9qcGlHTjJwdm1Qd1F2ekgwbEk5dUlQbVBMbkNpZjNB?=
 =?utf-8?B?Yy9TK2E4OU1FRHg3ejdLdGRCcks1RVE2eEFLZ0xLTHlhM1Q3dEE4dUxDbUR3?=
 =?utf-8?B?MXgxWFU5R1dzWjNRZDBXK2RiOFlFd2hrNDFwMFdTTkh5eWdlNDV5eXdvNGZU?=
 =?utf-8?B?ZXhYeWRIS0JYRnU1eWJ1WXd1R3hsUmsydXVWMzNiMTFQK1AyRFpwS0Q0NXov?=
 =?utf-8?B?aVNUcmJBb0JqODBRSmdkUXhJUkpoR2tGZ0Nsa3A3SUNYVWZRTkFRTWZFcThl?=
 =?utf-8?B?RVBSY3M1R0xRNmcwT2kvZDNCZDFjZTdxdHM2bUN2OUhDY0hZSnc1WXErZlZp?=
 =?utf-8?B?SUgzcW1nRWtOK3E2OFk4TGdLWFBCbWhmUWUxbHViMjBiWDBvdHhmNVFwdHE3?=
 =?utf-8?B?RHAwVmg1WXNJZndlUC9VU1NsNEdyN1JrRldzNnptREZLdEYyOHA0ZFJBS2Rh?=
 =?utf-8?B?NFcxazFmRm1sYVlENWtpenZuMVZ5UWcza3J2MjQwN1pqeEZkNFlrcVFzc0dt?=
 =?utf-8?B?Mk84bTdsM1F3VkZJZ2I1MERySjQ5TnM0OFgyQVo1UkdYdlFXaXl4OWhFL0M5?=
 =?utf-8?B?Mm5zOHZCbU16Vit1UEIrZm9aU1JEc28wV1dRUytJTmhUN2duV005R0lRcC9s?=
 =?utf-8?B?TWN5YytKNzNiTUJubTNOdHhERGEySFRObXZXd2FMNkUzMEFSRDVzVDNDc1Jz?=
 =?utf-8?B?VFR6ckdoZDFPZUJxM08wWnpGSWJpbEJlbEE5N0d0ckNNb3JGbjNBQkREZ3pE?=
 =?utf-8?B?SVplelRTL0MzdGt3ZmlKeWZUd21VbzE4SXdCblBOUDNPd01VZWtqVnZ2N2U4?=
 =?utf-8?B?N3pTanJNSW8rNnZJaG8wYVdCR0tId2IyRWl5YndLcVErQ01INnpSa2RUb0h1?=
 =?utf-8?B?L1RPSE9vSmdLSVRVaGNvNUV3d2FpWXl4YThLQyt5WWdXaXlMR1I3RTBISXJE?=
 =?utf-8?B?eWZ3aThRNkZGZWQ0MWE3UTd3THFabE56d1I4ZlI3TVcrQTZNcXN4SmlGbHF3?=
 =?utf-8?B?cWVIMWk4bFdWS1VSYzQ2MzZNVTAwQlBqaG1Ta0E3MkZ5dzBYYnNqdEtmUmhJ?=
 =?utf-8?B?RzRFdzhmSW9yTWpEQjR5UHhEeEtmNnlMNkVhalJTTjdubjAzSWRtUFluV3ps?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9187132d-0c6b-4986-afc5-08dad8d7f571
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 04:52:07.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25jlQbjLoDMhqdBsHHNvmX6embXo7wRMQqM86/P8ZTdidHzoVscFy8I/uZc/jj0Qxwbfj+m/lkINaS+KEswNbLIehZyvrV0OsAaNwUT+bEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgeW91ciByZXNwb25zZS4NCg0KT24gU2F0dXJkYXksIERl
Y2VtYmVyIDAzLCAyMDIyIDE6NTAgQU0gTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPiB3cm90ZToNCj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBpbnRlbC5jb20+OyBK
b2hhbiBIb3ZvbGQgPGpvaGFuQGtlcm5lbC5vcmc+DQoNCj4gU3ViamVjdDogUmU6IEludGVsIHRp
bWVkIGkvbyBkcml2ZXIgaW4gSFRFDQo+IA0KPiBPbiBGcmksIERlYyAyLCAyMDIyIGF0IDQ6MDAg
QU0gTiwgUGFuZGl0aCA8cGFuZGl0aC5uQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gMS4g
RG9lcyB0aW1lZCBpbyBvbmx5IG1lYW50IGZvciBHUElPIG9yIG90aGVyIHNpZ25hbHM/IGlmIG90
aGVyIHNpZ25hbHMsIHdoYXQNCj4gPiA+IHR5cGUgb2Ygc2lnbmFscz8NCj4gPiBUaGlzIGNvdWxk
IGJlIHRpbWUgc3luYyBzaWduYWxzIG9yIHBlcmlvZGljL3NpbmdsZSBwdWxzZSBpbnB1dCBmb3Ig
dGltZXN0YW1wIHN1cHBvcnQNCj4gKC4uLikNCj4gPiBiLiBjaGFyIGRldmljZSBjcmVhdGlvbiBm
b3IgdGltZXN0YW1waW5nIGhhcmR3YXJlLiBTb21ldGhpbmcgbGlrZSAvZGV2L2h0ZVgNCj4gDQo+
IE5vIHdheSB0aGlzIGdvZXMgdG8gdXNlcnNwYWNlIGlmIHRoZSB1c2VjYXNlIGlzIHN5bmNocm9u
aXppbmcgR1BTIHRpbWUuDQoNClRoZSBUaW1lZCBJL08gZGV2aWNlIGlzIGZvciB0aW1lc3RhbXBl
ZCBpbnB1dCBhbmQgb3V0cHV0IG9ubHkuIFRoZXJlIGFyZQ0KY3VycmVudGx5IHR3byBkZWRpY2F0
ZWQgc2luZ2xlLWVuZGVkIHNpZ25hbHMgb24gcmVjZW50IEludGVsIHBsYXRmb3Jtcy4NCkl0IGlz
IG5vdCBhIEdQUyBkZXZpY2UuIEl0IGRvZXMgbm90IGJlbG9uZyBpbiB0aGUgR05TUyBzdWJzeXN0
ZW0uIFdlIHVzZQ0KdGhhdCBhcyBhbiBleGFtcGxlIGFwcGxpY2F0aW9uIHRoYXQgeW91IGhhZCBh
c2tlZCBmb3IuIFdlIHByb3Bvc2UgYW55DQpkZXZpY2UgdGhhdCBwcm92aWRlcyBhIFBQUyBzaWdu
YWwgb3V0IGNhbiBiZSB1c2VkIHRvIHNldCB0aGUgc3lzdGVtDQpjbG9jayB1c2luZyBUaW1lZCBJ
L08uDQoNCkZvciBQUFMgaW5wdXQsIHdlIHBsYW4gdG8gdXNlIHRoZSBQUFMgc3Vic3lzdGVtLg0K
DQpBdCBhIGhpZ2gtbGV2ZWw6DQoNClRoZSBhcHBsaWNhdGlvbiBjb25maWd1cmVzIHRoZSBwaW4g
Zm9yIFBQUyBpbnB1dA0KQSBkZXZpY2UgaW4gY3JlYXRlZCAvZGV2L3Bwc1gNCndoaWxlIDE6DQoJ
VGhlIHRpbWVkIEkvTyBkZXZpY2UgY2FwdHVyZXMgLyB0aW1lc3RhbXBzIGEgcHVsc2UgZnJvbSBh
bg0KCQlleHRlcm5hbCBQUFMgcHJvdmlkZXINCglUaGUgdGltZXN0YW1wIGlzIHRyYW5zbGF0ZWQg
dG8gc3lzdGVtIHRpbWUoVE4pDQoJQSBQUFMgZXZlbnQgaXMgZ2VuZXJhdGVkIHVzaW5nIHBwc19l
dmVudChUTikNCg0KQW5vdGhlciBhcHBsaWNhdGlvbiBsaWtlIFBIQzJTWVMgb3IgQ2hyb255IGNv
bnN1bWVzIHRoZSB0aW1lc3RhbXBzIGZyb20NCnRoZSBQUFMgZGV2aWNlIGFuZCBkaXNjaXBsaW5l
cyB0aGUgc3lzdGVtIGNsb2NrLg0KDQpDdXJyZW50bHksIG1vc3QgLSBtYXliZSBhbGwgLSBQUFMg
Y2xpZW50cyAoZHJpdmVycy9wcHMvY2xpZW50cykgY2FwdHVyZQ0KdGltZXN0YW1wcyBpbiBzb2Z0
d2FyZSAocHBzX2dldF90cygpKS4gV2UgY2FuIGRvIGF0IGxlYXN0IDUweCBiZXR0ZXINCnRpbWVz
dGFtcGluZyB1c2luZyBoYXJkd2FyZS4gVGhlIHRpbWVzdGFtcCBhY2N1cmFjeSBpcyBpbiB0aGUg
cmFuZ2Ugb2YNCmEgZmV3IDEwcyBvZiBuYW5vc2Vjb25kcy4gSSB0aGluayB0aGlzIGlzIGEgZ29v
ZCB0aGluZy4NCg0KPiBJdCBzaG91bGQgYmUgaW4gdGhlIGtlcm5lbCwgd2hlcmUgdGhlIHRpbWVi
YXNlIG9mIHRoZSBzeXN0ZW0gaXMuDQoNCkl0IGlzLg0KDQo+IFdlIGFscmVhZHkgY3JlYXRlZCBk
cml2ZXJzL2duc3MgYmVjYXVzZSBwb3dlciwgY2xvY2sgZXRjIG1hbmFnZW1lbnQNCj4gbmVlZCB0
byBiZSBjbG9zZSB0byB0aGUgaGFyZHdhcmUsIGluIHRoZSBrZXJuZWwuIERvbid0IHRyeSB0byBw
dXNoIHRoaXMNCj4gdXAgdG8gdXNlcnNwYWNlLCBncm91cCBpdCB3aXRoIHRoZSByZXN0IG9mIHRo
ZSBrZXJuZWwgR1BTIGhhbmRsaW5nLg0KDQoNCj4gVGhlIEdQUyB2ZW5kb3JzIGhhdmUgYWxyZWFk
eSBjcmVhdGVkIGVub3VnaCBvZiBhIG1lc3MgYnkgbm90IGhhdmluZw0KPiBvcGVuIGRvY3VtZW50
YXRpb24gZm9yIHRoZWlyIGhhcmR3YXJlLCBpZiB0aGlzIGlzIGFuIGluY2VudGl2ZSBmb3IgdGhl
bSB0bw0KPiBiZSBtb3JlIG9wZW4gaWYgdGhleSB3YW50IHByb3BlciB0aW1lIHN5bmMgdGhhdCBp
cyAqZ29vZCouDQoNCkFnYWluIHdlIHByb3ZpZGVkIGFuIGV4YW1wbGUgYXBwbGljYXRpb24uIExl
dCdzIG5vdCBnZXQgImh1bmcgdXAiIG9uIEdQUy4NClRoZXJlIGFyZSBtYW55IEdQUyByZWNlaXZl
cnMgdGhhdCBwcm9kdWNlIGEgUFBTIG91dHB1dC4gVGhlcmUgaXMgc29tZQ0KZGlzY3Vzc2lvbiBv
ZiB0aGUgaW50ZXJmYWNlIGhlcmUgaWYgdGhlcmUgaXMgZG91YnQgc3VjaCBhIHRoaW5nIGV4aXN0
czoNCg0KaHR0cHM6Ly9lbGVjdHJvbmljcy5zdGFja2V4Y2hhbmdlLmNvbS9xdWVzdGlvbnMvMzA3
NTAvd2h5LWRvLWdwcy1yZWNlaXZlcnMtaGF2ZS1hLTEtcHBzLW91dHB1dA0KDQpJZiBJIG1heSwg
SSB3b3VsZCBsaWtlIHRvIHJlLWZvY3VzIHRoZSBkaXNjdXNzaW9uLiBUaGUgcXVlc3Rpb24gd2Ug
d2FudA0KdG8gYW5zd2VyIGluIHRoaXMgdGhyZWFkIGlzIHdoZXRoZXIgaXQgbWFrZXMgc2Vuc2Ug
dG8gbW9kaWZ5IHRoZSBIVEUNCnN1YnN5c3RlbSB0byBhY2NvbW1vZGF0ZSBvdXIgZGV2aWNlIGFu
ZCB3aGV0aGVyIGl0ICJiZWxvbmdzIiB0aGVyZS4NCg0KRm9yIHNvbWUgYmFja2dyb3VuZCwgSSBw
cm9wb3NlZCBjcmVhdGluZyBhIG5ldyBUaW1lZCBJTyBkZXZpY2UgdHlwZSBhdA0KTFBDOg0KDQpo
dHRwczovL2xwYy5ldmVudHMvZXZlbnQvMTYvY29udHJpYnV0aW9ucy8xMzg3Lw0KDQpUaGUgZmVl
ZGJhY2sgd2FzIC0gdG8gcGFyYXBocmFzZTogIldlIGNhbm5vdCBzdXBwb3J0IGEgbmV3IGRldmlj
ZSB0eXBlDQpmb3IgYSBzaW5nbGUgdmVuZG9yLiBDYW4geW91IHVzZSB0aGUgSFRFIHN1YnN5c3Rl
bT8iDQoNClRoaXMgaXMgYSByZWFzb25hYmxlIHF1ZXN0aW9uLiBIVEUgZGV2aWNlcyBpbXBsZW1l
bnQgYSBzaW1pbGFyDQpmdW5jdGlvbiAtIGhhcmR3YXJlIHRpbWVzdGFtcGluZyAtIHRvIG91ciBU
aW1lZCBJTyBkZXZpY2UuIEl0IGlzIHRoZQ0Kb25seSBzaW1pbGFyIGRldmljZSB0aW1lIHRoYXQg
SSBhbSBhd2FyZSBvZi4gSG93ZXZlciwgbGFyZ2UgY2hhbmdlcyB0bw0KdGhlIHN1YnN5c3RlbSB3
b3VsZCBiZSByZXF1aXJlZCB0byBzdXBwb3J0IG91dHB1dCwgZm9yIGV4YW1wbGUuDQoNClRvIHN1
bW1hcml6ZSB0aGlzIGFuZCBwcmV2aW91cyB0aHJlYWRzIHRoZSBUaW1lZCBJTyB1c2UgY2FzZSBp
cw0KaW1wb3J0aW5nIGFuZCBleHBvcnRpbmcgc3lzdGVtIHRpbWUgd2l0aCBhYm91dCBuYW5vc2Vj
b25kIHByZWNpc2lvbi4NCldlIGFyZSBhYmxlIHRvIGRvIHRoaXMgYmVjYXVzZSB0aGUgY2xvY2sg
d2UgdXNlIHRvIGdlbmVyYXRlIG9yDQp0aW1lc3RhbXAgZXZlbnRzIHVzaW5nIFRTQyB3aGljaCBk
cml2ZXMgdGhlIHN5c3RlbSBjbG9jayBvbiBJbnRlbC4NClRvIHNlZSBob3cgVFNDIC0+IFN5c3Rl
bSBUaW1lIGNvbnZlcnNpb24gd29ya3Mgb24gaW5wdXQ6DQoJa2VybmVsL3RpbWUvdGltZWtlZXBp
bmcuYzpnZXRfZGV2aWNlX3N5c3RlbV9jcm9zc3RzdGFtcCgpDQoNCk1vcmUgc3BlY2lmaWMgdXNl
IGNhc2VzIGFyZToNCg0KLSBHUFMgLyBQUFMgaW5wdXQgdG8gZGlzY2lwbGluZSB0aGUgc3lzdGVt
IGNsb2NrDQotIDEgSHogdG8gMSBrSHogb3V0IHNpZ25hbCBzeW5jaHJvbml6ZWQgd2l0aCB0aGUg
c3lzdGVtIGNsb2NrIGZvcg0KCWRpYWdub3N0aWMgb3V0cHV0LiBUaGlzIGlzIGZvciBzYWZldHkg
Y3JpdGljYWwgc3lzdGVtcyB3aGVyZQ0KCXVuc3luY2hyb25pemVkIGNsb2NrcyBhcmUgZGFuZ2Vy
b3VzLg0KDQpJIGhhdmUgYWxzbyB1c2VkIFBQUyBvdXRwdXQgdG8gbWVhc3VyZSBzeW5jaHJvbml6
YXRpb24gYmV0d2Vlbg0KZGV2aWNlcyBjb25uZWN0ZWQgdG8gdGhlIHBsYXRmb3JtOg0KDQpodHRw
czovL2RyaXZlLmdvb2dsZS5jb20vZmlsZS9kLzFPS0FPalJ6WkhsYU5vSEU3VVNYcE95SUJVMF8x
RXl0VS92aWV3DQoNClRoaXMgbWVhc3VyZXMgUFRNIHBlcmZvcm1hbmNlLCBidXQgVEdQSU8gY2Fu
IGFsc28gYmUgdXNlZCB0byBhcyBhDQpzdWJzdGl0dXRlIGZvciBQVE0gdG8gc3luY2hyb25pemUg
dGhlIHN5c3RlbSBjbG9jayB3aXRoIHRoZSBOSUMuIFRoZQ0Kc2Vjb25kIChQVE0gc3Vic3RpdHV0
ZSkgaXMgc2ltaWxhciB0byB0aGUgUFBTIGlucHV0IHVzZS4NCg0KVG8gc3VwcG9ydCB0aGlzLCB3
ZSBuZWVkIFBQUyBJbiAvIE91dCBmdW5jdGlvbnMgYW5kIHVwIHRvIDEga0h6IG91dHB1dC4NClRo
ZXNlIGFsbCBtdXN0IGJlIGFsaWduZWQgd2l0aCB0aGUgQ0xPQ0tfUkVBTFRJTUUuDQoNClRvICJm
dXR1cmUgcHJvb2YiIG91ciBkZXZpY2Ugd2UgYWxzbyB3YW50IHRvIHVzZSB0aGUgcGVyaW9kaWMg
b3V0cHV0DQpmdW5jdGlvbiBvZiB0aGUgVGltZWQgSU8gZGV2aWNlLiBVc2luZyB0aGlzLCB3ZSBj
YW4gb3V0cHV0IHVwIHRvIGFib3V0DQo0IE1IeiBidXQgcmF0aGVyIHRoYW4gc2NoZWR1bGluZyBl
YWNoIG91dHB1dCBldmVudCBhcyBpbiB0aGUgcHJldmlvdXMNCnVzZSBjYXNlcyB3ZSBzdGFydCBh
IHNpZ25hbCB0aGF0IGlzIGFsaWduZWQgdG8gdGhlIHN5c3RlbSBjbG9jaywgYnV0DQpzaW5jZSB0
aGUgZnJlcXVlbmN5IGlzIHRoYXQgb2YgdGhlIFRTQywgbm90IENMT0NLX1JFQUxUSU1FLCB0aGVy
ZSBpcw0KZHJpZnQgYW5kIHdlIHVzZSBhIFBJIGNvbnRyb2xsZXIgdG8gbWFpbnRhaW4gemVybyBv
ZmZzZXQgd2l0aA0KQ0xPQ0tfUkVBTFRJTUUuDQoNCldlIGFsc28gd2FudCB0byBiZSBhYmxlIHRv
IHRpbWVzdGFtcCAvIGdlbmVyYXRlIHNpbmdsZSBldmVudHMuIA0KRXhpc3RpbmcgSFRFIGFscmVh
ZHkgZG8gdGhlIGZpcnN0Lg0KDQpBcmUgdGhlc2UgdXNlIGNhc2VzIHRoYXQgeW91IGFyZSB3aWxs
aW5nIHRvIHN1cHBvcnQgaW4gdGhlIEhURQ0Kc3Vic3lzdGVtPyBXZSBzZWVtIHRvIGJlIHVuYWJs
ZSB0byBkaWcgaW50byB0aGUgaW1wbGVtZW50YXRpb24NCndpdGhvdXQgY2lyY2xpbmcgYmFjayB0
byB0aGUgdXNlIGNhc2VzIHdoaWNoIEkgYmVsaWV2ZSBhcmUNCmNsZWFybHkgZGVmaW5lZC4NCg0K
VGhhbmtzLA0KQ2hyaXN0b3BoZXIgSGFsbA0KDQoNCg==
