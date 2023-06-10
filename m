Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43F72A702
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 02:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjFJA0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 20:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFJA0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 20:26:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDD3A81;
        Fri,  9 Jun 2023 17:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686356798; x=1717892798;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VoFbBa2cwbsjPZCxqacHQ8wprCxMVpZ4ai09IdrOvFA=;
  b=EvAoiZO+UhWVFQQS7Oe1foXc88PY/F8TrWOHeZXF9u7EJzE/2VyiZQoi
   etRJ4YpguSt03PbPddYYFbqSn5HAZNxRV6vz5vx7I5lzn0xEuJMW5A5dl
   PN3yJZfBMbgTBr2IIVMWtL9ItL/99NzWZyGYjLH3j0eQr/IMzaHGsCmID
   v0gIae/qkQC1FJkwcnfkKalnO/eQBpSSg7i9sqUS5JuwjlBGmk+B9B4GT
   rJlrqw5htr0B1g/0fjw05z7F3Mi2L05iAVj7oDpn339UbBI74aKdA4qWJ
   Rs8n38P8FA1BIfNTxNk4G2FfG6J1tZFU57UiWfR8sZFUQ7A2pv8hgSYuV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="356605649"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="356605649"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 17:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="713697842"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="713697842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 17:26:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 17:26:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 17:26:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 17:26:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 17:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwbRhBFuwNKu+Wi1kYaiOInw8QN/MgDDoccv5vl093+Osa3Q6T7kufOYA75cIX+3UFBanWBS7A0cGqmjCgaFX4Kyns38Yj846ue1yS4ereFWqTF+HKa+g2MTbUjfF9W6z7Zg2acH/WJ/8apcyC6t0x2CBLk7wPyYrcqKHNnvPVS7rOvZXZQt/ffRg1KF0uqvbn8voq6is4Gm/fgYdsGqnHxAElBqtkWqYiARww1ZIbfZYxcnpmKr6t5KaHu+b76pZqvz4HYP6+t1WpNugrCj0BBPu1WNZFgWV/BsQDb+l6TSs54S1oPDiI+og1cnnNVSPoCDCKQ5ZJFPpUtCs6RL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcjtYnV+arbk58PNbS1yGE19mstEoZyTExrjyynO+R4=;
 b=flmyPHuB3bq3gYsmJHMY/hC41EIXmBHvPso5JHtdYYW8AK+GPR/7whbjvhkWdA+NmU1lIH3rropaET6waAaxsz/onAbyTDJu2Yj+m8h9yR0sUe65ubFAbbO7EGNUYHdL/e9m4zSCwt1NJ9T5QA61UIMA35g0mEivBPJqi/Mw/afQySfYiOHiHzGY9qiw9Zl0PYhEOVAcnMD+DU63xGycGsqZG85F3mk9XNUhs1p3drezhe8pu6lT3CQeJ1NAJXbKPatSlAk0kn4uCFI77R3PZqyH1ZyB14ipoTjlUX/NYadhsfUy5xX/YvM0KMGwtUAqxWMe/wX6GJge1Db1ciQrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Sat, 10 Jun 2023 00:26:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 00:26:29 +0000
Date:   Fri, 9 Jun 2023 17:26:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 10/26] cxl/mem: Prepare for early RCH dport component
 register setup
Message-ID: <6483c33023319_e067a294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-11-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-11-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 92da3256-1bfd-40bd-8ea3-08db69495554
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVTD4i4lJmsMbJXY+uHxHPLOHjGFxQLmqPRcX2pC35iV0K1EVdEGAL91FLKncF/26eHHodK3V3Lyz+kxSvwGLrTxo+scbzIyr9IH3fJ19C3ju67VRvyqbMcLrrxeKNcINUlD/iMMiVGp63U+QDNKfIHuOCPKJKSiUX31DOos+L7fQiyb/j1cUSw+6nMlmRr9cIszyA3ghsLjDG7NKaYfGU3CRzu76TFixHwl5/L4hedzAmDj/KPsETd42k5ng2c+AiCBqMGWNQBJBZXPKHwLGdV2rJx1WEk0LriA65wCge08shLmGo8mZb+qcA1AVDAp+5l34ufiU73dE2/7L76d3I5dkZ8293a0k1/4hu3aVMxOCCQqOZJfc4hXese8W2H2ovDgOGw8oa/SDv2+9iSIqyyS/Ht5OjboKmiUmBLovLHhmxb5rbYCYuKUKuUlHa2kmOTetfnu1SMPOr32R1QR3h3DxHxnoLxFdbBWgB/YQc2XDM75LW0/PAiDL+Rgmu8wsKw4iHjtOAaYCYA0ccQI46wYRmzYbzWF9LJNJ/YZTVxiyflYpWpiSguh/cunL9lq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(83380400001)(4744005)(2906002)(86362001)(82960400001)(38100700002)(316002)(6486002)(41300700001)(6666004)(5660300002)(8936002)(186003)(8676002)(478600001)(66946007)(6506007)(6512007)(66476007)(9686003)(4326008)(26005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yh2/mM1yXIP1SAC7gDiVWnwP7QlTCwiKloNibgP5FU+MAtq7H9w1MXr/Dt+d?=
 =?us-ascii?Q?6SOrSWgy/JK/Xh6bARxsc8ZSHN3qu6IVJrwRmhHS6Wd30rOrOpLCKzzb088z?=
 =?us-ascii?Q?fYKVT7u3Zj1RNCbj/0O8goMtPyVauO3TcEuaE86m+Hl+xjIWubXFAJx55vEd?=
 =?us-ascii?Q?GhPUBbgAH3T801Zj+OXOdX7jbw8VKKOPDyX3DUKzoyxGFRAUARlcghsuQ3PI?=
 =?us-ascii?Q?JXVRn17AMcQpIqSq+K7LX2zgUVXU5iFhPqma+BI7MoPMjI1foEiW0h4PWJNX?=
 =?us-ascii?Q?mA/JlOoWnJdI1pUmpJW054YURKTOq90kC5+JICuN814YucgUoEKHjWNXgldB?=
 =?us-ascii?Q?GFPHlHkp14dvw3K3W0ojsuIAk+fd+euz7S4zGCaCH9wDmA9bfr+NWe7V714C?=
 =?us-ascii?Q?BhPGogmyfWn3VgUstC6o5KnhzjdXN91cBhiSmHLnKdw3Pqw0V394KdnwC1Cu?=
 =?us-ascii?Q?K+BFH5ischtuvwkB8wG87hL0Jhjb2o6+sSZw3Z/IF/l5b7uUw3qKzBzpRZF9?=
 =?us-ascii?Q?wOFqR1RwgCK4/3VofB1ubnJuTxVk6kgMwM4rcEYHQ3Xr9VmZ/Rrf0fTFxVSi?=
 =?us-ascii?Q?/ltVn80UnebHz6+/aczX83QAyymms2sh0DjlddhF72AFvn1MYd7zJXk1ccJz?=
 =?us-ascii?Q?fFNEeOOHc9ELOp2bMa5LoWA+/94bDOZhJy+QO3Qdid/GFZuz/rpGkc2VGJUh?=
 =?us-ascii?Q?4BrIxIKjdTzx/lg2BrIiczX2TjOjIeMj1y0PFVLo8VZxtM3lRWAkQ6gDG9aZ?=
 =?us-ascii?Q?eZxP+FeJ6lMqHxRJLZiRFzxuBakGPhnxZ4Sd6noaXy96dOMBYEdBPxWFBXLm?=
 =?us-ascii?Q?4vVTakibZoM1niElRJol2MC+pA26HnG5WBXlPDZElfvxa4YdHUvkEJTUCtaV?=
 =?us-ascii?Q?g9Y20GmtHIA/ZLVIsKwUurnlNs6rAmewGOPUO8mtA58jNyKON4mGZ0mjUCaY?=
 =?us-ascii?Q?l1a6gZnvNvSq18GurE38LviUNsxZxOBTtrwqT2j5Vsjc1RsjzBd4s+o0MiUR?=
 =?us-ascii?Q?APHiA/KRV4x7wmSz4+NVoLNmR2zNVWob9pLelWxhkFg9PDfPb4px11CEcYjd?=
 =?us-ascii?Q?CQX1Tbyc0WqXU8fgkQxqAN2ebax2N84a6wosbUzsxhuUrPvcBJ248L1v3zWu?=
 =?us-ascii?Q?9Lqy66RW2IBfdcGLbzGkhChikAltRHDqM4J69h4RN842ce+1CLZbeUZl3Wya?=
 =?us-ascii?Q?8dZrR9iO+kXCGDIs/iTVRpZ8mui7k2I1arLgmtkpOLLKgqscZiZgBIALB0nq?=
 =?us-ascii?Q?NNHRTyMgjRRc/ImMfvzL0cweCxvPOurBE8U4lLKJEVtflrUqsNLkcESalhVM?=
 =?us-ascii?Q?YBN4s2BpMQ0/ei4uD5kXPsBT/Kv6MvBLuCd4Gb6UPXgnNYL2aOv/II1rLexx?=
 =?us-ascii?Q?IRfEOYIJSXkE6rhLM3iJFd0sBCsbquv7PuSmpeq4+dEmVk7fYdet5wrT8UkU?=
 =?us-ascii?Q?Zf0wcN94CwrwQ7nps7WiT0+8JPvvfjROOubQJ14R7a+QUxNzKYqSFNMAlouH?=
 =?us-ascii?Q?MgNFPV2PS8+4ZF3wFKODiviyY18DlrfQKbmg6FeKhelqthNv31ZxRQxOGE3B?=
 =?us-ascii?Q?i2nK1hE1mcNzHidlxFxENBwf1E/SDrCtf2QjOXQ5EiFEkRyMj4NY0MADX5Bf?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92da3256-1bfd-40bd-8ea3-08db69495554
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 00:26:29.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG5FOFi+J2L3U6uv4F1C0m+3FwPD3a3Ntv2VojaBOIDK5+IDxq3EC3pYyfxf9edZIYc8jlHeX844xXGYwq94l+KNuAHUOFHB0pDE/egM0YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> In order to move the RCH dport component register setup to cxl_pci the
> base address must be stored in CXL device state (cxlds) for both
> modes, RCH and VH. Store it in cxlds->component_reg_phys and use it
> for endpoint creation.

Looks good, I just needed to rebase it to use
cxl_rcd_component_reg_phys().
