Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336F4742A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjF2QJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF2QJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:09:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA429E;
        Thu, 29 Jun 2023 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688054969; x=1719590969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w60ZQIqwkubfUgjZNaUWpIjcuI/aSpX9DlE9mVEYAU4=;
  b=Nme//5vIIH3PI4uPcBOjkzxq/Y+pHsnFwHL2SdzYNcw0uIiUQzicyYEJ
   bMB6Oub7EQHx1GbkiCgNciM4ZDzxDd9XgpoYUEQ1Rf+8UPFx0mKliX6Wz
   A4sn2RFt04Wzs5lniEruZ6j3zEtWK5mg6zOWaK7lFl0UXMzulHaC0GPYe
   3TcfnYv4me6GLGuD28GH/h/Y7r2XLhWHgA9szaPCtqZgPFIjcNpI5UDXb
   uCgnIbgP4BOx8ok+nmM3P7g+FjDWjpglysVBtGZ8tHI0UnK3GDji001Z9
   b33CCHPOS18Ojp6UJIAAu4jz9lClWoymddap9ktvG8tBG+6jVhxk2QTor
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="362188883"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362188883"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 09:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="782717607"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="782717607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2023 09:05:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 09:05:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 09:05:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 09:05:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 09:05:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd71GjicLtBPg8SePPczj2m2EBhpxpppJEY/qbwz+sHGil1Gyihu0TBUGF58pu/134pZ6+9vUDkpyDZP8sBfkssWIY+AtVlj2Ji20MQlv0Rc/t3tFJENnGqoSszMEUJHagchdjyhlCqYFRIgNnLNqBdJFA0es1i2d2ZCY1ogurSrYSwAAmaFx+7T5vLqlQ8hjyBxjG/WmJ6qER0FURKm4YQdJjUApmEsCqGvqa9T6T/FBYPPKAIx0iTc1PfmxDjLLkurj3Gj2UeU/eJxVifKNLlqtbb7Prgt5h3UDwVJjZ7nL7mexhFt2fn/BZ4HyAq2MPU3se0l8SVPKNMEK0qFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w60ZQIqwkubfUgjZNaUWpIjcuI/aSpX9DlE9mVEYAU4=;
 b=WQuvI6bikWeHOoI7cq2fNVDG+OXqCaDrITz9ZWSX9ulTcMFLbgweQlD45elRWS7wus65oV68bqZtGVTq+dQOdeOkp8RFvK2rG96qiPbgJSz+HFdXxAC7HhpnkmaKcpDWudLfWYhzzxaeNl2KL0FTE4Yd1LCed+IgrAR5ZPr+vvyWFP4JaK+/2m5OF5Yw+pcMlJLcPBFZzXIgUqj0GO33p4s+l4jN8L1JonQBsSJ3CAJ8fjA3l65oPbpf6i+hI/nnc+iSntmMw0isuJR9aaLAQlQgYv2gcTta/i3zq+DK38llnTXtM3wY9rOtH3p8hqU44zJ8TR8ZYgRMUO/98jWtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 16:05:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 16:05:45 +0000
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
Subject: RE: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Thread-Topic: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Thread-Index: AQHZpGd4opVYQG8LVkKVNIWhOE3q1q+henYAgACBwNA=
Date:   Thu, 29 Jun 2023 16:05:45 +0000
Message-ID: <SJ1PR11MB608331B7F85320DD4CD93448FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-29T08:08:47Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=b73e44bf-f1e5-48f7-90bc-39d98fdc2335;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6948:EE_
x-ms-office365-filtering-correlation-id: dd1961c6-8082-47e0-abc2-08db78bab254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqLY7P4cE/N5KyHZB8UtqLm285TpXQEFHHAm+fSiWrA2q9/GiUOFXepGhO3M2g/KeKcS6hBtE7EZIni5vzSF8NIyc8dHrNRPh5atBg4AxQU6tan/EUFuv/iSsD2STxwn9Vn0GLGUAL3inAH5pRvI63yUBIxxoJUY33JVLHG6RUUMMuVU0TFwVFbQT75XnSPnT2ZGIPXnEPmnK7j63gtLdR5r2T/nYRB0l3Is4PdDxMFmZtgwfoDTkytn9TRvTxqeUz9zNbdiYZzp19E7ePGUQulXcleEQdhF4wfcLgrzmH4sjjso+iiocPJqzvQolZs0Fj4vueNDRJqpfH4Uj/K/5Julv6uJTH7hSZDTipJadpxHg3i+sHQrkOEBjWT/7retn2xsSOt3KkEBozBfAm8TD+FJX/0cgWhKZBgBX1b8kwtXGQV2VdFmdMIB9i71l6n0czIdOm+eNtQaAc3sS1tYDw3w5z1KrI4RDuZFmO+dQ4mS8Scyg76cjJAKeaDFGfveZIspTFMuAffHnXGbnughdQgREjQSJhdPmOFZMz9W3C9+w0HG2+KQanAShTROyUA4saTVT80RCwYABOMhRgB9g7RsbTEIXkZy5Qnmf8LW7KFvY8Sy2/ubXvjwCl5lxbiV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(66446008)(33656002)(52536014)(38070700005)(5660300002)(64756008)(66476007)(86362001)(66556008)(7416002)(41300700001)(122000001)(8676002)(8936002)(76116006)(55016003)(316002)(4326008)(38100700002)(66946007)(82960400001)(9686003)(2906002)(186003)(478600001)(6506007)(26005)(7696005)(110136005)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tVGM47S9b6RgEkHQbkhThuudq6xGN9dXpRv3v38p6Or5YOQw6tgegJqsiuJY?=
 =?us-ascii?Q?1R2mkNFP1R+LWygC4nYeQS9U3TeAtCsDhxpfq8yTtz5sbidMWfFjCJxWf1Df?=
 =?us-ascii?Q?VGkB5NSTIe25TJHZvRWaXL5kqypP213YoGgwhdR3wEghAkJ0eijhDfvK2ERU?=
 =?us-ascii?Q?A7MTz2TDYji/0wWVFfE9aUYwaAomTCmsBguty5KFQteum8ZEUT8xUm28UIks?=
 =?us-ascii?Q?tAzh80rMucowPvSaRRMx/9a3El8zVzbc4bo1hJ0EGsFaH6CB1KeH1VoDM0uC?=
 =?us-ascii?Q?bdl2mrqncfA7NsxIqs4UFh/qaqOWfsfX0JVsi7dEz56+zNxwjXK1BwD02CUf?=
 =?us-ascii?Q?npffoj5Z8jIuNtY040rDZdxJiD+VwrWTrn9aIg4vCzEi0dKnR5+BL7hvYSEZ?=
 =?us-ascii?Q?FGUgYBZaf2FB3a1K94Zm3Fhrr2l3uSygBcL/KS//TlndwZ2t+p8TU68aAKFZ?=
 =?us-ascii?Q?wgV8pzxWqjmZNT2G3Wb53QXaiV05/BLO6fBSWdSoGm+9uCGexCnp0BirvUK/?=
 =?us-ascii?Q?/1rNWelaLnSE1igDP2EnYl2tZALiselGH8vQxpf+hGC75u79jKMUrl4bE3fY?=
 =?us-ascii?Q?PeU3JMsImxDG2inXjPLCZPyU/6RUCxLTscGkGBM9J0Qd0BFiwCyJ3dXgNaKF?=
 =?us-ascii?Q?Fq9Ari6zWiec0d0YzMhYX2iTR9iUPZ8fpoOeV9SO7mMg1VEsJqzwlpLvpdFY?=
 =?us-ascii?Q?0Vhyh46RCqh4zHZMHGW4mSqwsasb1ahZscdcg9+5dERrhb9b0GYS7quPYfb1?=
 =?us-ascii?Q?uBxxQdUE/7JDMKwKfOYqWMg4gb3Kw1E3nvN7FZTlUB1MKeaf5FsIbxE+8/dN?=
 =?us-ascii?Q?4nNQ0WXxZu+gfO4D3ZqDpEoVE818LAMP7L/kT8iDOilLMi7A9/m7exu3EwfW?=
 =?us-ascii?Q?bBXGnKh68ZTdmNFpUscU87ERJWpwDyogLlkaomRJawrHSmm+bzBGaGQ4+7CM?=
 =?us-ascii?Q?CgYhFXpr47uteHt1IdpivXZ9vv8D2yOt6ExaMsDGEuiKW69BUrX5kM7iI+/T?=
 =?us-ascii?Q?vA0il0GW27Sy96gFVgIn9C7WpbkJRfYrOdioKKE8VemgSpcHmPDUL7DQham1?=
 =?us-ascii?Q?vVvuaphmyu13vfNrb6TPF7rlUru+lqNDdO3gQenPPFKQyY8JHME+lUW3hBfV?=
 =?us-ascii?Q?toIwKsH3YC6pHtUgickXgZw5DtImZE9lqwpeLSJ2MUzIzbe3a8Y3mPJUEckA?=
 =?us-ascii?Q?zV6wacVJjyGtdS5PUqG6o2iuFbalWCBOhdnVp1hH7LaxddPIVIyGSCjh4shk?=
 =?us-ascii?Q?1uVLvX/53duvMvEUOJ/I4zim56ijx+dWoNPWGltAY2GJXjJks4mgQwsBWy2N?=
 =?us-ascii?Q?NwaVgAYWUP/55AcCd7l/fSToW+qJ1g4pCjmnuQZN4j71Ri0VbgzGNCdA7RJH?=
 =?us-ascii?Q?+lRljWoyHgGt7frmvajQjSL8IwKMf0eW3qUDpSLwibzohp+JKl/8H0q5nhUO?=
 =?us-ascii?Q?eMhubqJCBSqwdXoXKjws2X/wObdRwo1QMGzZOoEDyu9UoSxbohbYHbf4aPac?=
 =?us-ascii?Q?sVUTFmFNhswgaeHAIyWp34P2TX525y9RsedntTwYo2NqeKcFGJGUBHffC5xt?=
 =?us-ascii?Q?exJyewb6xNNQsq7z7x0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1961c6-8082-47e0-abc2-08db78bab254
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 16:05:45.4068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDXbFGqwQXKfPSVc3Sw6zK1BcQSldrWsR87OSZpCg/AHo5DUXC9tLswj4x5kYvaPHY9cgovQCn9cPglSIPouGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948
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

> I ran selftest/resctrl in my environment,
> CMT test failed when I enabled Sub-NUMA Cluster.
>
> I don't know why it failed yet,
> I paste the test results below.
>
> Processer in my environment:
> Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz
>
> $ sudo make -C tools/testing/selftests/resctrl run_tests
> # # Starting CMT test ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Cache size :25952256
> # # Benchmark PID: 8638
> # # Writing benchmark parameters to resctrl FS
> # # Checking for pass/fail
> # # Fail: Check cache miss rate within 15%
> # # Percent diff=3D21
> # # Number of bits: 5
> # # Average LLC val: 9216000
> # # Cache span (bytes): 11796480
> # not ok 3 CMT: test

This is expected. When SNC is enabled, CAT still supports the same number o=
f
bits in the allocation cache mask. But each bit represents half as much cac=
he.

Think of the cache as a 2-D matrix with the cache-ways (bits in the CAT mas=
k)
as the columns, and the rows are the hashed index of the physical address.
When SNC is turned on the hash function for physical addresses from one
of the SNC number nodes will only pick half of those rows (and the other
SNC node gets the other half of the rows).

-Tony
