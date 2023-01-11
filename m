Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741D666342
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjAKTG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbjAKTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:06:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085EBE3C;
        Wed, 11 Jan 2023 11:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673464008; x=1705000008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zmPDC7F2DS3GqW2R9P/jC+TZyc4I8Qf8xAFKBIkwQlA=;
  b=R3CDQYGHqBESUXtYXiFISxRz5hhxfbrqYSPKOyukQjDDt0g/C5o5CbTG
   vvG7kli4fdicNrptiFbnXTrZE5MT8b5oh3/IzG5AS6QvRGpQYCXTYvvdT
   i24XTDhyVOh2pKLInGwLhmQs+mrO/D223lY70d91tYGBWOIjg0yZG0uXA
   9uTOC1eDGBY4/NhvQj/7fdkR7cacCOysM1U61hv8Ue1fg2o4EEHinFzF6
   2/bNpNFuK11CL3zRqq7uY8G40QQJor5FmeOus0JE/S0WKBraQvjkPc1pB
   ErHzAdDRQ+AHP1R1Qt23LlKhvD4mA2h5HI5cv65/WBxaVxt37radZMOSL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307032209"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="307032209"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 11:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746279155"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="746279155"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2023 11:06:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 11:06:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 11:06:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 11:06:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 11:06:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7ecr8x0lbeMxut94WwT5E6NHJANRaCN8PEIQTn21s+pwJAVsBc0u70izzwSodov63xnASEn8OpLu9chL2IetJO+l8PIKrlObE/g1h7rHbiiD4RGAasYKMwSMd7S5/J3OavhkYaf/xenAz59fgiNRFSCPhIfmE7dAB5dnuaJ/Yjksn43srYYVdS27W0kQdCBDOnT+68fy8nf0jnma2GdFGv2mdBfEnaXD3CUfqPU/0OpCSGZVS57OqMv+UoQyb4T4K+SaqONAe1Yyab8J4SfeH/Xme9RtVNHGyL0ool+iX8S1R2pNz6fOxE6Idch5DgFmeLRJG4eqV7xcRNRpHkOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY34tMrcPOY3Kn96OxrEpoRJuChIdptSfg2pT5YDNlc=;
 b=GfsA6wUwmHS0M20Wg3ADv5H4KH7EAlamWrwwfmIDvT1uSinskfJml79miq/sekNG1++e19y8M+rPHK6ygMlC2C1ezw8/WXSugZfqMZSR2mnGTJ24vCIEjrRGSYBm5pnOzeaky5JuVDUoqm6b0qYg3bm4e0dyYpI/KZzb9NDV8NCAleafA/VnqSizWI5SiqSvUE/5W28wj+TBfur/PJP1BSqvJ0VvPeZIoSWSoW2WuXWWAQjmxtZziDazxSmYZIHHSANVys0z/e2g3pNj4DD8uaHue6b2ZO8q//NYa2ou5JmJS/y/NlcVheJ5w2NkwNkAzpiYnh5EsIILCzgJRVVp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 19:05:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 19:05:48 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
CC:     "Moger, Babu" <Babu.Moger@amd.com>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Topic: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Index: AQHZJEmwi0Q/9mo+9USczeuBgpw/V66WuyYAgAAxMQCAATbhoIABOvWAgAA4AmA=
Date:   Wed, 11 Jan 2023 19:05:48 +0000
Message-ID: <SJ1PR11MB6083AA5292C11145BEEBAF6FFCFC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-2-babu.moger@amd.com> <Y7yiwOerGiEKAF9i@araj-dh-work>
 <MW3PR12MB4553FFAA412FB741A73009A195FF9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <DS7PR11MB60772F09B9749307CFA0ED0DFCFF9@DS7PR11MB6077.namprd11.prod.outlook.com>
 <Y77ZAfhc48W41FGp@a4bf019067fa.jf.intel.com>
In-Reply-To: <Y77ZAfhc48W41FGp@a4bf019067fa.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4971:EE_
x-ms-office365-filtering-correlation-id: a036aa6a-955b-4d87-aad4-08daf406d9b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5liJz6aDKmpmreA99DFg3z2Zx8SDEzPHfwyK7HxgCgw/QpxPXtR1b8zTENP6ayyAU9QK7UZuW+lUVC8heoTmEXE6jYyDo9p+bQault3rauizybjcJ5WA4Z/s0p1AXTl5f+NhQtlhNxpr1d9P2T6Wp5j9PQtA9xCOnGhnuCzxxaGEU5of8RZa8PqqC0Exa0LvESEI1glQ8HaJStWzE2Bw5GtQB+/GmIp01Jyglwvs12Es0AdywAt6ruAtseIwlB252MTZXT452XpVcEa0jasR94uCs1H+zZhRH4IJ5J00uhXiG6IjHb4e3BFO87UZh1FAqWEPkX0CKA+7zDVP5lEuHnt4axyxBw36Z7Hsg7Ap8OUlSRQLSgTjir612vMYq722l6lVRQfR5lqGr4C0VnyBUwaswDj/v2KwA9piN0HtoKhEynNstvktPs7sCK0KTjzMEwYzvgLeASL6evAex1US7u7RgOJvExUi1CUwOJz/X3A8o7XF6KUwxYyiIDo4U79eqYeaNhP6GW8lNl8wJCmqN3Md4w+8KeSRc37k6/s4CHeUcxjwf9LZZ4btwIbVq2Be+5csBAlLP0Ab8XigiAn93IXDrADPcVqrnYKMXtHjstCXINN0t7UpLollOzv+PWOu9OWTEnWuvU/GcEBs2jk1wDJEdubbZy7G41vUgy6p7TDcQ65WodeYhdrYIwp7CabnuzRaXFIOF0Rud+qquUj0PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(6506007)(7406005)(7416002)(2906002)(8676002)(4326008)(66446008)(64756008)(5660300002)(83380400001)(52536014)(8936002)(122000001)(4744005)(6862004)(9686003)(38100700002)(82960400001)(33656002)(41300700001)(478600001)(38070700005)(66946007)(26005)(66556008)(186003)(76116006)(7696005)(66476007)(55016003)(86362001)(71200400001)(6636002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4Y4C/bzLihobgouejdEwMvN4snk99L0UzFvwNQbwQ3zZUxXXxxKjottUdYn?=
 =?us-ascii?Q?TTEKxLfGJ70BOYy37zZNcgnkDgyKr8F3z43TzX+qXafAkphZqj1NYX6BYHbn?=
 =?us-ascii?Q?qq6nzMfSkeXDuMtjPfo8PV1okBFoG3xYsMIjDPZsn+gyAxpwflETgBkY1pMM?=
 =?us-ascii?Q?mjySvjDYrTbbp5mSHfS2Y6EgUWphhdOoMaz4B0wUBlRmxzTpBOvvN0QQ9YAw?=
 =?us-ascii?Q?sVI4Wqbq8KxI8TVSHBoIlUZvJvi9fIZvWKuqGXR7ZQWUVpHXbS7LHDSTaq7P?=
 =?us-ascii?Q?vwY85ls3otdXKZYsttmx66mRZixLm2/YhBn782fYHdvXZx8vjZV0oGNdJU2/?=
 =?us-ascii?Q?Qxx80Y+TAsm72CUenrGefU6j1kPrC7+ICwUa1BsDLE+pWqtGkdwBNU9JdvIG?=
 =?us-ascii?Q?iV8J/CLdviy5fidkxUootGgQZjbXsvWiBFVJeDBPGhJ3h9sFZipkvYNARKce?=
 =?us-ascii?Q?gF78Ex+QwMozKhYMhHPUZyudY7e3QRm25Sky6zhVYVG7d2GjbeFs5+0zbWcK?=
 =?us-ascii?Q?bG4DOCIN5tOd4+7TUzZjWkBIny3kIXqWiX0V/PywC72j14HiFZ1pg3APLAGY?=
 =?us-ascii?Q?O4bp/rs8Tcr8pSH1Xw75nRce08Zz9sxgSr3EIku4ZCB2BFjSmu3CdEWebxuE?=
 =?us-ascii?Q?eno+p2pZ3j58qRCjjhbeAF8q3z61aLI5ryVzCgy0MOjxqxWyaBEUXm7QzMxY?=
 =?us-ascii?Q?3ohUCxtzBoDrDQZOC1HKLxGUovBNoB8lhzKIjtDrgmJPN+ghmxIK6+0DOPSe?=
 =?us-ascii?Q?uTBENyTWwNnFx2r1PE++ItcrH5HJnLPs5GibrQ7OrCJFQCSTbYpXgD3mfru8?=
 =?us-ascii?Q?WAqL/a27abtDnxyObdLAYeaozLnDjYj7LdWlCdb0H5lDY9fh0mMazOszJrvd?=
 =?us-ascii?Q?hK5TMRLSLp+p9MuVdO9ZcF3iJjIK/m1OhTn6803Nlda/0xCxS0kV6810CY3A?=
 =?us-ascii?Q?tWkwqiFu8x3eaE91QirYWfoJUPqaPawG0dYqqLU9B8UrZowtIqzUkJCyT3U4?=
 =?us-ascii?Q?kPVlx6OpRdRx/E9pR9F1kHxmclx5yUbbhLUM3rreZ8mYTb8k/MAfYjGhppab?=
 =?us-ascii?Q?plyGr1Xg9/QvyBhki92nf39CD39XCaWVmDmzrT/KFmVpNZlXUMwZ3V/NmWjv?=
 =?us-ascii?Q?eX5ZZS8IGuUCm32Tew4QrnRWT70O7GgsGyXk2stX5Jb/PrO0VSjnxBnDjTpg?=
 =?us-ascii?Q?9A7Qqqc1zJvfwJTXbIBAknkgNUakShAwfrfEVoqUZebWebp7jTd8w4bn/4EZ?=
 =?us-ascii?Q?Zaj3UNiGZdJxTnUnBArdlUwnPvkS9RZBKrVli6YgBsQcAfHKGRxbgHhbxUeW?=
 =?us-ascii?Q?eHZUZgCgbmHxdLbRZ7K5vf8mvEkgFXndiqdeQ/DKY+AiNQSV8RGSncDtXBWD?=
 =?us-ascii?Q?K0x0ftLEgKKuLfrRvnecfpwwADm9EzbDSyjtdG18li+myssb2th4nG8TfiMT?=
 =?us-ascii?Q?QJi1SHfNJGAks1XYClgildDTgoQScEyVloWX1RfEaP+FUR4gifUS9OTrNTlq?=
 =?us-ascii?Q?p6lroKgRZCHNZGP9b3XjacD7KStTrFWvY8eealrphtqZALoqnVtFknkozTe1?=
 =?us-ascii?Q?queuPG2A4kehpxb1gIIBnN550O/BM0ms9+Z0O+jg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a036aa6a-955b-4d87-aad4-08daf406d9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 19:05:48.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pu/XtGpJhFYa+vvMn0kORnQixyuiusu5WQRdPGSXIKPg9G5BILZbKV4Dsh6K/NdMOOY5jnphh0faOKjfQFlug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I wasn't sure if the few ms difference is going to make much material
> difference for that process. IPI's does shake things up and introduces
> other overheads not related to this process.

Is it just a few milli-seconds? What is the scheduler priority of the kerne=
l
thread you wake to perform this action? How does that compare to the
priority of a RT thread?  I may be wrong here, but I think an RT thread can
block a kernel thread from running indefinitely.

-Tony
