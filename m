Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B0742A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjF2P5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjF2P4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:56:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0410FB;
        Thu, 29 Jun 2023 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688054213; x=1719590213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=81iMmDKNPrDFlMN/ZrqVGDxKGZz676Ql8hQuqi89uYQ=;
  b=kSrZT3NnUZdZ+0q0XPuTEhjWLnBfMDpdvcjFXokj+u7B1WpgI+9lUEPN
   xggL4gvgcp/5brrcm4Ji5xwLuKDcUt64wKxxO4BHs11BVD9ohK1AnIIqU
   tE4Zmt5S0O900Ud143xb2vG+M7K8gi4fgVwivY8wV+O+axqzh8bxHcdj5
   tUSE/pU6thJUzxMdzqe2TTq5AG1DxsZGuBA0bpjB6hWvPrtFY1cVBr5FH
   T/dsB2Xgm2C5qXJrZtkGTnNVDZ023HkjgZ24yuwVFhhWKi4ksxYy4dPAG
   ziF3OlmUEkcqPaNO52DCi3MDZ//1Edht53LCXqCISCQeKwWkK1d8qGhYi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342486316"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="342486316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 08:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="711479876"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="711479876"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2023 08:56:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 08:56:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 08:56:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 08:56:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 08:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIIhBqSQ8VETEb9q+0MKR8DO4wBhbdXH5/y5GZ6lv8Ka6SfKZJkia/ado+W8W5XrJHmx0mrsx6Zz7vcZhh30U6CyGA+s1ou9zOLijT3a269vNOIDowWDcvFvuFilQ30yKR44K8Ov27CHUoqi9Fxg2njvb3FXRtvdc7XRDBtmEOswA7t7H0MPiU53BZFRI3oLj98tMYi8DwKMqg/b1dxJ6b4Cd448tk/7078LmmV4XI/xnt8WzMPcx1uwuAcuMPZptpPpoeCPmCBMJrQNbA767Xq9Pzx/0e5PFR/YtXLAcMqGcYDUZzOExWbu9tOwTc+0Xm8OeCQeFgZ7QeydNJo8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHpW8uYoanQ5DEIfOdpgbRO6/+8fDaI4ZLYjo1+5OOE=;
 b=nj8C5JdEKhp8cQJr0VJe4H0Qgr+h4kydkhdSIbb9LOuudnDy7445dsAruZfadt9X1Wt/MZe/QxD0ynrS8/lQnhhsSo5Qo4iMtrNyLrgIEidchR55rLveewFw3KsBZtBWm9KkgrVju/IsJsbko6TJoqVlGOCPnlGymV2NfITLfzZjxNcG6Jc6iDNYawhHMDiP8nezeBn6EgPdIVGmArV201Ckaykn05ULzg6p9nbH2lmx/KSrhlsK2JWJui42CuSykRydllrR8qexO85RMmCVHFZ9BpJh9TogaYF1M0mv9qUYatTUfjeLBDYIF+uHxG6Jmnt6SfG3S5fE1TUDm8DcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 29 Jun
 2023 15:56:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 15:56:28 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Topic: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZpGd48oRuL5v3EUiLea9/WFe4Sq+hb2oAgACLkBA=
Date:   Thu, 29 Jun 2023 15:56:28 +0000
Message-ID: <SJ1PR11MB60839D1A523095BAF855C8B7FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-8-tony.luck@intel.com>
 <TYAPR01MB633095B17B82098E65D3B4238B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB633095B17B82098E65D3B4238B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-29T07:32:07Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=cd5a3d33-f56e-4471-a554-9d26d979798e;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: f3fcd634-2c8c-4ea5-394f-08db78b96678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CpsPOCI7XLbhXvLlqXEfg0DyEgZEkvNquOolcX20kVhQSzJz7jXUdl2fkSnmdgxRMwZGJqTj9dSl32eI3iv0FF22vhu/9KkvgdoCmJG2ePtnGqtLq4J13mRX+Mjyhsv9BJnamQvTu1rvLpWXWAurf5LpStR6QmgZ60rfUNyfoPImNCb3foPvLujzQk1mkYG7j8LgbaZtA9l2+FmPUiyHch8H4bjt6BllPPiRf8QdDswcp1Jwnef4OzuJwZUj3Hf4qs85kwoPdSHLH7XRY/+BqNiHgghshBnkaiPGkagJ6idvkPxLXX/BCWIHkM3RFZIwJGYBlvoJ3OgG+grkxvQT+UFTAIGWdhcksVgE+6kfXvjYxr28SLbWy1Su6Gg8ZLs4zLFZFISw9QIRKASGDvgQLF0H7qYupd9ANNz7cAS3xVDPPhYYfi30tlBcvtlka0m7/6AHfQYXwrQW2Q4AJ7tUoyJB7cxHlQ7irVuL6u4n7yrqIaSvXGDKe1iHq//VUegjWyWhfRlQU+ROTHiS4+WQc+nwFYNx5SqH5yl++pE+drJN8dBU9oiqYO5zwxSoZNep8gc+5v5R7D2lb7mBmbKHjJU2Uwemk/cP61bKftQ49k3JViiKenXaZxVQiEBl9Kcl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(7416002)(5660300002)(52536014)(66946007)(76116006)(66556008)(66446008)(4326008)(33656002)(64756008)(66476007)(478600001)(316002)(8936002)(8676002)(2906002)(110136005)(41300700001)(54906003)(38070700005)(71200400001)(55016003)(7696005)(186003)(6506007)(26005)(4744005)(86362001)(9686003)(122000001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3xF6ekg25EpHxznM08HzJewbYyI1urUDuePr6qFxY6KxWWY53SJUmM4+x6te?=
 =?us-ascii?Q?EXpw2eSX6YCkSaeiEstcRY/oP6Tw3p0HNorHuCS3pzGHBYPKAkL8AA1h9VGV?=
 =?us-ascii?Q?vgoR/tZ8F3TbjJpYR1PniAcelqLx/VPvfiptSVHLKjeSfCckaDrTV9QFEdgy?=
 =?us-ascii?Q?v72fNfprdC2GlwmqkfRS7DzpAUCuLiGDvubAOm/zQD6cbbCHBkQar5TqdVpj?=
 =?us-ascii?Q?xYQs4UvxegCNQ/9Zfw4t3Ww2a9wxcabYlQULtCI5aQdPMDwkr0vuCQHC3qLM?=
 =?us-ascii?Q?lhXPfv5VSqx2QJAvGVvxhJlNm3ijLdnJuKzodPvzDSs3Lyd/G6K0OHwekEdj?=
 =?us-ascii?Q?LguZBD5M+ToFY9AP581TX8/8xVFJwdjkZ5hTJtQuwHtF3ZtDBpI9sgIDVnP2?=
 =?us-ascii?Q?vSd9R3RxJiAlMGoEqyFBMch73p1umRHvM0UtsFSH3H7Jd+I5Kfu5GEdc3+wY?=
 =?us-ascii?Q?33Rl0QHy3NsvD5rSEB69iIfWK+N9qh+nBYhWXIUOnWRN3H6FFMPyJInj2Tbg?=
 =?us-ascii?Q?pKmlzs9jGBV0y8spupRRH9qXsg7YUn05/tKpJcsmUNwC+KHNwJVUzFlGxaqK?=
 =?us-ascii?Q?rfUJc3RuQxScMuBzi+m1MJJvwJrJMbMGAGZJsKVnQiUPwG8U30+fiaJP33Ee?=
 =?us-ascii?Q?wMKHcxFDG6enzoAOkA51zeZGhdiatwXuiTtf2oWhdZvX/vkXOt4lfox6RjO5?=
 =?us-ascii?Q?1SvSp6/HFsvg86gAOcjIKs44B5udPPTjtH6hHx7rr6C37qZ+R6ZZHu1baWEZ?=
 =?us-ascii?Q?ewSnfCdwRLXFh4RfFUnXPvmS2pGLmTdikQeeMvXGwAM0myQkFEPglKwWxJwI?=
 =?us-ascii?Q?edT+eCGOUvBangCwB/kS1wHmKQ2PUfsXF0ca6zVQjgBUg2XCzB7O5s2Yz87c?=
 =?us-ascii?Q?VukE68Hpx1zJLhi3KaH4I9mb7y8OS1EvwItfCEpyl6af+8Vg8Nl1KwTANofs?=
 =?us-ascii?Q?Ics6oKdgyGglgD3ftDL7lUbJ5mr4mJk7FkcDP3BYrWEsNb9C5es/ZcjfFs4E?=
 =?us-ascii?Q?sn8bymJba4emJlgCkt5kEE1zM1Ry2MzZ2VANc1yc1NKoqb6WAyKRDDMG2pc5?=
 =?us-ascii?Q?RZC0YZaq4Lgz1BvHMhBp4uLYd48ogbUUOclRXgqus6hdxerFsCkZBHe94Nh+?=
 =?us-ascii?Q?a7DH1PJ/uAO2ECnAcy8ZcttBKSyh3pL+1NXVwwaDIrPBNDfd+9R4DsKzdnxI?=
 =?us-ascii?Q?asH8UsuVb/sWKNVILZD595mJnvF7xWJHOcMBuaAavdShGNkEhvNuVBRM8Y46?=
 =?us-ascii?Q?z0yhQoo+/HPOxJxBmXhzVsYottkupZEUfeHG322ueL7+f47az4Eclhlhn8Ft?=
 =?us-ascii?Q?IwVkIoVQ/cj6biBpOAtPekbiljQFrf7erx3UdslvTvKmNG9Rz8Lf/wnjGBvu?=
 =?us-ascii?Q?yLzNvRCHamEfjYdt5M0wJzvDWNnnj/r954svgQZbV0l1OcnAyLhNEq60FnuT?=
 =?us-ascii?Q?+8ZPDQc0i+3pfdLVsPI6tvMkFdGOmQipJeaOUganWZeO8tEPFFq/uT8QpvrQ?=
 =?us-ascii?Q?+c75R7caDsQ857xHrnBf/FqP1ynLyQc4efxM16fHQOljfLbNIG3ehyiFGHO4?=
 =?us-ascii?Q?wJ9KjMB25eDiBXeRRMs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fcd634-2c8c-4ea5-394f-08db78b96678
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 15:56:28.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2e0rhXUlAx3OTFYHwrVCWYkFqbI0idFY6iE0oobfntyNAsq1lHAaKN0A5Kg7eSaz9YfXbs08yCqXhwvWbnGxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static const struct x86_cpu_id snc_cpu_ids[] __initconst =3D {
>> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
>> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
>> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
>> +	{}
>> +};
>
> Cascade Lake and Skylake also seem to support Sub-NUMA cluster.
> At least in my environment(Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz),
> Sub-NUMA cluster is supported.

Shaopeng TAN,

This is true. But MSR_RMID_SNC_CONFIG  (0xCA0) is not implemented
for CPUs before ICELAKE.

-Tony
