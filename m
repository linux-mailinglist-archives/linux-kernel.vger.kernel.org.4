Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A3690ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBIRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBIRHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:07:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A6E31E3D;
        Thu,  9 Feb 2023 09:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675962451; x=1707498451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A2kX4f/Ppj9T75oH0ao6EHJVd4Fh7DtV3EwJt+CHoLo=;
  b=k7O/T7pN7FEeCPvIEsGnpcS3YG/0kxcfBaZEqigMUzoaM+TQoBPIqX51
   YKQ8yzpsGauMIib8+bpeO3OKn70Jm7SZ2fwVNcVP4ZCtdEkWZwKrHVSoK
   a5MQ0yXbV1fzAvTmHBh4nTW9h6OuOGlFnshgUqJhfadDpQtnAw33+Moms
   M3gfvHBnm2iaeevZhGev3GQzYGoK7x5F+YGWt/prkvHITdeB5Yg7RVgPM
   Pst3cyItCLZtvPNedE0jQ4y3yjv4WGjrXrjpGW8NKjwG5pdhCkYu0QMWz
   f+l0NZ1069WdWJiVRfYXcX6+dcF/fpovb73M5X0WKJzQakqSFhy9MwoXO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="332308984"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="332308984"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 09:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="791678175"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="791678175"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2023 09:07:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 09:07:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 09:07:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 09:07:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 09:07:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PK2NXEL2qndV22LqsNPkQi2hFMsu0JB3uBD2Trz+yn7+Ch5eIcN6XiEds4/y1LFjIpELuCx4EcKqe7rJVckcRoSNYH2qfBrWrAMVlDGZC06TKbWpvLWe18oRq07v9xcgh0lEOM/lSZM67IqOt3nOtCZK2/JNULq8zClJNfq2s2DbhKpM201akVro1RMl3m7GvAX/poVKwwjmZqXSMSNUcSA2RomMiOtQWsbfq3plhlxJVO9BjoY0NJrsmU2LVin8fgVvpteMIud1gAM6gUy4SMk1w1eXzQFP3q/XD0FwnA6djOJWkz973nnlX8xtsNsr7R5RcXMWa3PNKZHexNocEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uq/xlxWYs/G9baXUHAKFE/xKSLEMInmOky2KRrBxHE=;
 b=HdOxkkSOJjfPoezzaqBM8vW5kr6VdVL6DGuoJRoEEALoPhaUHNqmyZpDCqwXRY29HgGmW9IQCoRIQpO+D1VIg6YGpYjqYJW89EQKGBi6Lad4vdsOj6fwLFHTUZ65oKJZPlSgnK/XuLQ3Ik0lfZA0Y6dTO5YH9Jd85EBCbihAEMF34/WngROK7bdKPE2seO/FACaXDQ74czrAOROaoSqvMwyOsR8GlYUK8K0nK5Svsy5jG0+PL84mRyu1VLfcTMFzdHuz2PFpLrQ+QF3F413rRPucr99Fae595URYHkTUUZODUZtiGNvh0IIWgIFuuZYp2ziIzIvZWrErvY/W/kvSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 17:07:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 17:07:20 +0000
Date:   Thu, 9 Feb 2023 09:07:18 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/port: Disable decoder setup for endpoints in RCD mode
Message-ID: <63e52846175ae_36c729428@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230208071758.658652-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208071758.658652-1-rrichter@amd.com>
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: f32fc2e4-ef58-4d4a-3650-08db0ac01aba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/74yno/SSIU71fJ/BApd5XrGYipYS/ht7yZYKM9cZDSb+X1Ia/aZ5hu4SnFMENRlxjXoKBqIYegt8eRTMboBd1+xysQHg9clKLpxsdCC0Dj9lPPctZCYojG0Nft6SFc/XXvViXS+GlTB5rS65+FcZ8RHm9Y0vB2YPZM+X4/GuiQcJqlv0tQgU2RoCJjR3UY+elJln+VXYENKpL3fhMwzky+G9JOtEtnqWlo14Nj9FNe3OTXCXgql6oA8Km5a5OTkN4urQ0BUX9XXrdaJKQAo4hidID9PV+1XDDN8XN4xvem2z/FWJG1AQ9A4T5vFvUVz+LSjEMNGAEBy1DTIIHni+C8ygL9KNMiPmQ/mwOfu6goWOMVsuMEwQRVk8X6fj79OMRCzaKhaFbcZ/T0ImD2dx2ryXpZswk3dqaAIG/VMbv7J06W1ILH5gD2snCCfEiAPC8Pz6RE1z9d4gdFr8qBEKFcbSu0YN3k1MCwNByWcyartyO+xZySHLctygldGdhKIXej2p+qzVS66IU/Ls6XX96N0JYFXbCmII/znp06G/rJZ/FglebKuPQx7BD4J5gNHtyTd5xRSxOaeAobU8MZGhUpYtrBJa3ZyMEAhn2DywpHyqRDSQERPxqYmxyf1yJkmi5T1aBQ8o+yQbozA4Q+ltbs8CzrZnDdLP0GtacBPhGG76kw0sThZ8bqsncB0pE6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199018)(66476007)(8936002)(5660300002)(82960400001)(2906002)(66556008)(6512007)(41300700001)(4326008)(54906003)(8676002)(66946007)(9686003)(478600001)(26005)(6506007)(110136005)(316002)(186003)(86362001)(38100700002)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n3OgCecefNgO3XAPInmXjE3zxA9cpUowhOfuLJAfTkUvQRWyY1PGLNuYhrGa?=
 =?us-ascii?Q?pLf+ZIIRzeK9mNAZ9pF92V3WYfKMRzpeXsqWmesk3BCzcZQCdQfDgEXJFwIk?=
 =?us-ascii?Q?QSwG8CHRzKIkYd1AFezZsRedN+A4fYDnYcsZKx1oQkgJ3SJmtAGA+Gp9c8eL?=
 =?us-ascii?Q?6Oj/hUrwtuEBz2ShNF/kElVfWpD2fno0fRdW0wmecMCJi14he8DdybWxOvFC?=
 =?us-ascii?Q?bUAr4J+tEqPE7HlWwPgQMS8W3WxixraUyEExHJAjeOZYyX/LD1V5gY3olbv9?=
 =?us-ascii?Q?r4AshpW7MFDwPcf9YzfLcMfUdygJPAjocQJ0CocFS/uc9E29+hpFAiFBHvb3?=
 =?us-ascii?Q?2zl3a5/aNL4TM0+lhfCgRhho9sVY25amujZM/5UbNuMS7GxhTSFGUawTHMur?=
 =?us-ascii?Q?38JLezt7M0QRXKcL04rMhntKq1oe5NO+/i6UWoi4B1bwhlLjxCUl00ZWe9ep?=
 =?us-ascii?Q?NSnNo+/8tL3YP6JRrU6woAOHXX5waDIp5gZ32GmKcYrzTQncSog8nIGicL1y?=
 =?us-ascii?Q?vcstATS5+uNEOKue+XwXFrD7X/2faSpw+2OHMUIXO3/uERRoF1RhnVq6QC9j?=
 =?us-ascii?Q?KMKMN541vEi5Qe9O67Rn7tWJuIQYbXS73s5dr4Dlgw0PKYgS0CdTEFtPoTg2?=
 =?us-ascii?Q?E8k7Lh+kNua9HSVw8MvlFa8/nPBABMWVxD3HO+2OO8EEmlmzBo/LD6sg//Wc?=
 =?us-ascii?Q?Gc7gkFf1pgasfxlmYhhniE2WpbgCL45X2tfSuLrI2tgim9TK78Vemov44Nub?=
 =?us-ascii?Q?2HKxvd+1X1eUCn7RHYpE+Gp8ZiDlcydMdO2//35buhedFauXVPzE8bn4mEts?=
 =?us-ascii?Q?FhLqQysuPE3CFUgT39ZyvNPykOO6sfFLmRUQXbK7sCLONMU3J0qA4ty9rkZ0?=
 =?us-ascii?Q?v/e9I+nHaQ1Ne8e/GFQ/EtJKiFAYF1/txadC004nnzAzY+mRzzhfIIIpBzXX?=
 =?us-ascii?Q?hUbvgoxGO+5OkkaeYt/S+46v6LbSMBGWyTFGMEvm7wiw9ZQpM36ekfsWZcvO?=
 =?us-ascii?Q?DufdC4d9xDx8xvvoXn9fTD9epOm8MTAWr+LwqewUmS1WsZrZ+Uxr2h3NlWjA?=
 =?us-ascii?Q?X2RaLjQQXoKdkUCv19HrDHJtqpU6Naxg1XP/2SU2eSXShWgvZoCL5NdRziak?=
 =?us-ascii?Q?UXQq1cQbur3wJTRmWl9I8X6DGWJsKmidRbNObIiqlfeiEZAvrVsZqR41bkgq?=
 =?us-ascii?Q?WJivZbRwlDhToeQPGlh50ppFz5mnswg0b+lr/ErVXr0ObGfjyYv0UT9hpk6I?=
 =?us-ascii?Q?jC6PPtReGdr/eVtAWO3ZWmw1Dpdo8Nlz74ALfOVw5HQ/V7+HU4weNdiY9zen?=
 =?us-ascii?Q?3L97shA6Xuo7MGMWDQe2SDUyQJ0mQBiiaead6WGjrb9w2Ik3Qe+W273VDKGJ?=
 =?us-ascii?Q?Wv9YS+h/rXQSu4yASiAutKM0oLM0/OIAKFdZ9rZVxFqArHsvrYZG18yKn7XB?=
 =?us-ascii?Q?sbMuYudhkuc+8oCq5Clv+rkdcCCi012nWcQr6IiyuMK+g5wA8TDrKubE7sVK?=
 =?us-ascii?Q?u/opHBRL/EygMJc9Fvwc9YyFZfiSvH5D8sDm2c8ETeNjHPEUTnBe36jVRvPI?=
 =?us-ascii?Q?tiA6L4Dhe9DtAvV9GmD3+o4zh+6M+FH50dTMzR7MpHYVsESXlih6NmYii/c3?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f32fc2e4-ef58-4d4a-3650-08db0ac01aba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 17:07:20.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNR22jGg2NPzpVwUmx6oUNrB4IyaDDem/o0hZqOwpMkHNLSCWdXAuLD/UH61gIfcVdSlIK/WGQGrOCXxoSExsuP3dtgL6dawkh4a/5z/E18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> In RCD mode the HDM decoder capability is optional for endpoints and
> may not exist. The HDM range registers are used instead. Since the
> driver relies on the existence of an HDM decoder capability, its
> absence will cause the initialization of a memory card to fail.
> 
> Moreover, the driver also tries to enable or reuse enabled memory
> ranges. In the worst case this may lead to a system hang due to
> disabling system memory that was previously provided and setup by
> system firmware.
> 
> To solve the issues described, disable decoder setup for RCD endpoints
> and instead rely exclusively on system firmware to enable those memory
> ranges. Decoders are used by the kernel to setup and configure CXL
> memory regions, esp. to enable and disable them. Since Hot-plug is not
> supported for devices in RCD mode, the ability to disable that memory
> by the kernel using a decoder is not a necessarily requirement,
> decoders are not needed then.
> 
> Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> Signed-off-by: Robert Richter <rrichter@amd.com>

Does Dave's series address this problem?

https://lore.kernel.org/linux-cxl/167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local/

...that is arranging for the driver to carry-on in the absence of the
HDM Decoder Capability.
