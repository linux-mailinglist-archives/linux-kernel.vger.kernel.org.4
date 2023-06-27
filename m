Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406C74015F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjF0Qf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjF0QfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:35:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D331FD8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687883695; x=1719419695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l+oqPMIow0IgEZYwyqxwTUXTmljyghShmhMh6eSU5+Q=;
  b=jmxCJEBe83oCzrG78wf2MEOwDR2NlRjkoIRkAs2wz4UNUHqa1qbqzPuX
   pgS29x1F6/u+ncaO8+zDj87L+A635OtwECwtl7VEzdOesGsDC2s0dF8e5
   MLbzTi/OZTrn0fZN3sBl6mDQ6uTRfyhDKqUWTIM4ooUZK22oChiGZ1hce
   8saxkWZOI+6MCst/jk3YCjrAq4PBMmRCJXdAywj+IIrGy6jj0kPbQSRtz
   O/ZVbt/53s/rfBahPVtZ1hm8nTtBBJqkgnF77Ni7IIbtJtdu7I3DARRF9
   eVy0K7O1wMP0Gyq5TY1wjR5puNA7eFi1Q6rp0BIjK5pK8mGzAyyBGv3ch
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392208620"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="392208620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 09:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806570589"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="806570589"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2023 09:34:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 09:34:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 09:34:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 09:34:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 09:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwSNQtsORiaAH2u3c8CXMHsFBPgb1tOqnpuQ2RNY/UmRVTXBDWM/VPvm06rdDs7XXTzEkhrfPdr50kBHo/k1PoyJrS/rFIi2iW8QXd7AnecADBDGxACddsfuxSRzqoJ/exSPAdq24U7r8dgPvM2QJDmp8FXsVi904H2OzFM6tXCIKa3L2C0i/VS0xA9hMz/SjvpLedlJc/h6CnTTNn0u28lg4XokNDCCRwCBVOHTdJI524jy39jrzvIouLt8m8Cij/JUKutFwrAVRMQb7PPWJhCxWZVhdaVVxVl8OECamQT4leqfRkx5c1oOrrfe5InUsehBeasyyKveoNHyy4swhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7NRFg9oO+oSaomNqEXIXSYAK4MTLAC/gKKqnwWz0Vc=;
 b=oYuI0UgHQpywrfo3P2ybFnOVMgrzvo2e9Z5Qo1n3NgQ8//ve0h8QA5ieTSq3SFcOqNMlHoAPyaesVkCrjxOS6X96f2CLBaLRqf+EyZgP9C3b1FxHPCdtOhekiey3XZAoddxhvFSCz65drn8u7RSSzDHPjsVHjb43VSnvyZKQgtJq9Qv+1PpI2djBVxAfWbLxuv2tW6r0K6Ao5ZIxXjnwFS+7pKLBHq4x1M4HBlf2/FVnNfBk5KxRkS2HSFjNpHq80jgzV0sniuYDnxOrE/PkFlDHEXUb6CXuwUDknlgyNea7d2Iy4dd5Yl/7d4tOaAFUPHGNcZmqF1sdqfUvtmXm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM8PR11MB5701.namprd11.prod.outlook.com (2603:10b6:8:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 16:33:53 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 16:33:52 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Drew Fustini <dfustini@baylibre.com>
CC:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Thread-Topic: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Thread-Index: AQHZoyiDuZCsHP7U1EeCATLJj0kK+q+eYGiAgACAUgA=
Date:   Tue, 27 Jun 2023 16:33:52 +0000
Message-ID: <SJ1PR11MB60832BA425B43CA19C778100FC27A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230620033702.33344-1-tony.luck@intel.com> <ZJqhDYLG+/Kr44sp@x1>
In-Reply-To: <ZJqhDYLG+/Kr44sp@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM8PR11MB5701:EE_
x-ms-office365-filtering-correlation-id: 1388164a-7dcb-4f54-b0b0-08db772c4b4d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4C1ej5G/nzxIFN0M1yccVa3y8GebwZ3tH0El2aSuJ4QNj/N75+XLeyNgDEs+7E/dNPKHILQ6EWUdDOXRvsOskGZgIOOXTISGNeWda7VGa2ucFWZo0pxZ98NQY60y5HnGhGcQebugWOe1b1stLD6EBRCZcDTxWAunXP8B90WchH0CFOHLJaxaIyShRsbbPe+6cRlKXPGT+qK3t/Or1CsWCDnZwF3CMx324f8N2zI+iLxnIDqI+oz5+4yRRP7PfRQ8gWq7L8kL0t6LswjEkTfAVJviBNaGWfKDVHMPqqDgeQI9rvpufJdClpGIAzJDfxAJgAxmM4/QshE0QJix3RSPZykNNj6Gioqc86RuBorwbjuz0QyDHO+UMtXFrH2bv2XqDK1DUHNjrDA+NpEnwTpJ+HLN0oyRWNQm2thvzt54LPzehsH0y7qemAHenbjdcZjXLkreM8lUAr4VZ5TYczMnDK8ZrtRaM1uNLMKvBbRd6bElDbKuTDW+dYR3H/hte3A4+6MoopGlZrPKLWxpBWvC/ocDF+zTkL5MX28zx9Qcx8NpuoHIP0mzud7xNWwCiMozUAlMJvBDk/pjFxWxuu6oWGKrjhMj9crAVK4dIUpyNJp1AIQc0RXvyUUzetYG3SCV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(83380400001)(7696005)(54906003)(478600001)(9686003)(33656002)(66556008)(2906002)(66946007)(26005)(186003)(71200400001)(66476007)(64756008)(66446008)(6506007)(316002)(7416002)(41300700001)(76116006)(38100700002)(8676002)(5660300002)(52536014)(8936002)(4326008)(6916009)(122000001)(55016003)(86362001)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LsI2BdvRdStb9F5GnTaIbz1mm0NegYl1AfXtYJ42izCSfviwHLDAQ2OOkzxs?=
 =?us-ascii?Q?qH0mkbTDh3Ab0xhsMxpeOvL9sEjQ+25p2N4CuejCEhWak40BsimS1oaqXJYz?=
 =?us-ascii?Q?z19uPrvQiEoaax2x7BD//eGSFeC61mduACB8j4r/kfe+rggfF/XK4mqGPtHR?=
 =?us-ascii?Q?CvQjj5KMjlDRvpXOJK6nsZqmyqWGpH95TSgFxq72jRS9Gjq/4L3Esdr72hog?=
 =?us-ascii?Q?jfksbsNrNrwd5T8zNwT/A/o/bZRps+GAZQdI/Uf6JTrKHUAOEGFoFY7p/Ndg?=
 =?us-ascii?Q?MQcgnkIv0+4G1EspYpDSxe03fZUdxLiE7DvJTej3RaciHe41lxfxvM8XnsNw?=
 =?us-ascii?Q?mQJXTZ44cqVJCq4EHYzbtlGNqoCT7w8VWBjawW2ftzUnp8ba03Wt6nScE1kC?=
 =?us-ascii?Q?gDyl+MYv4TnZjxTfsHUvWlVaPaqxYTpTTOYzA8eSRRIasDyan8xFeO7dgcu0?=
 =?us-ascii?Q?XGpzXBFIaj3UWpOIr+o+dNxyeAq7n1bqxotUl3Xwt93U6DOpPxasQItvaPIz?=
 =?us-ascii?Q?GHltApEe8qllSJ4ZvxQUrv9y9qvYdXt82cxRjgKeLZZz24hvbEyER0Vo+3ze?=
 =?us-ascii?Q?H7C48JsAidwUY6Zj86cJUWdnh6vNvTt6Urostb78dQOR8TlPwiy7+QGGhYnb?=
 =?us-ascii?Q?na5alDqdzBfTxnPflWGfBx/b+W5vQO3FOwNHguejtncLwrlDSktH+y9oenhF?=
 =?us-ascii?Q?GooqtU7Fh5kFUREySSRElSsKP/tBtx0WSZMykyEbM1XwqUrDxjHhb+MAbUTe?=
 =?us-ascii?Q?1uYPe2ySN7jq04twLIffuWKG14kBM5hxx2/+Q+hX0nTnVVSXIhIMSh9XN6j1?=
 =?us-ascii?Q?LnzKGOmkJkrmjCIPWfXFs1rspWBQZpdxp1KMmPdVlUaxhWh2lhDzcEThCK5T?=
 =?us-ascii?Q?taoG7E70+oxgjVuuCjgqCpV6EagCemGxPK8pGa8dyVRGB4OMklHT57F3KfPD?=
 =?us-ascii?Q?CpxU5CV5kFTRiSBCVUJdMoVyah7nwS94DKyrhNKmRXPxUXZiDreQ6CnEiX3k?=
 =?us-ascii?Q?bfhISQgDIPbedyBCP6C+X1MSkesSJLt7gaSMe2VsfH166cRX/JKE/ZCeLvtr?=
 =?us-ascii?Q?ULR3TpIrb+MS/dCGnYnpP3B5YloBcorVhUUFxSDH3Y+Su6bDZ86E/p11ocB2?=
 =?us-ascii?Q?KPqpgm1fX6UB5+YeOBcTgZOpOB32J5gL45orLnKJ+f8h+RkQ+f3+PDtdABXM?=
 =?us-ascii?Q?kxbX4bJVIhiZFlP/OjKYHqcXaEA3bs6LxuPounLYKGjcKTTYtzI3keGa/xo8?=
 =?us-ascii?Q?5hHiBRnOqkZCOm4foyR/FbnUrFWsh4SPjtyeuK0/dLCmEX/Ja6GDJFL1vIV6?=
 =?us-ascii?Q?RC0ooC1Owe1SD8VYpFMit7rPdhD93f9ZosPkrGdS0R7l50RWGyyyT5w1wrAF?=
 =?us-ascii?Q?6njVB171+5iNdjlqk2ZvcuHBc216rvSRZZLxfsoxbhs/il1ECte59NvV3vgw?=
 =?us-ascii?Q?LAwGzsNyH7X3/9P9MC5mFuXXmMXttEG27Izjoj2YiPH4uKgDUkwcPyjWS6gT?=
 =?us-ascii?Q?vGxYduGzsyt/CPCFNebL7btYckzVAxQZjWCH6sCN8v7BpYTs1ZLZAESvPKxe?=
 =?us-ascii?Q?1jy6lRw1XHXxbp7o/yk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1388164a-7dcb-4f54-b0b0-08db772c4b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 16:33:52.8645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GiDNvEjyN0ItfCMb+HcVJJRkmrouIngUGKjIB8WLhyd1ZPmPmk2j4ztUvBND4e//R8O5cmbtDUNmA/Mq7pffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> By itself the core code is useless. Cannot even be built as the
>> controlling Kconfig option "CONFIG_RESCTRL2_FS" must be invoked by
>> a "select" request from architecture specific code that provides
>> the necessary "arch_*()" functions to make everything work.
>
> I would like to try to rebase the RISC-V CBQRI resctrl RFC [1] on top of
> this patch series instead of the mpam snapshot branch [2].

Thanks. That should help shake out any places where I've left in Intel-isms=
, or
my abstraction is insufficient to handle your architecture.

I've made some significant changes since I posted those patches. I pushed
the latest version to:

git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git    resctrl2_v6=
4

> I had a patch in my RFC that added config option RISCV_ISA_SSQOSID which
> selects ARCH_HAS_CPU_RESCTRL and RESCTRL_FS [3]. It seems I would need
> to change that to select CONFIG_RESCTRL2_FS ?

Yes. Just have your architecture CONFIG option select RESCTRL2_FS

> A patch [4] in that RFC adds the "arch_*()" functions in
> arch/riscv/kernel/qos/qos_resctrl.c

Yes. This is an area that may need some tweaking to get the prototypes
for the arch_*() functions right.

I put all the x86 architecture code under fs/resctrl2/arch/x86/ .... mostly
so I can do quick test builds of both the common code and architecture
code with "make fs/resctrl2/" ... maybe in the end-game they should be
under arch/x86 rather than adding arch specific subdirs under generic
top-level directories (though I see a smattering of "x86" directories in
several places.

-Tony
