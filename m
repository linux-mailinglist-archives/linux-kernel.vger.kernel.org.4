Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9F6608CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjAFVVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjAFVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:21:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A084610
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673040042; x=1704576042;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MUvLUQc9fL/9BPncgymkrQIffM0nOhD3en3B8C1eP38=;
  b=DmzTh1R/tLqVSTLJ9Cm6m7qUWJHzO5tt4S6O8hvbcNfivfBSwa+YTPOn
   cuCWJXqqOuOTYi6VYcWWJYBF27u//1E+i/ndJJpccb3zxN2o194wC7c7F
   D6Jia+OGD5LaFjR6LC7ZZPtasRplOHR3S4KpfQKgCd/Z1YAg1cp8AhpG5
   pleFUZr5c75JlPsw5xq8XKfIEfCTwO2xWE7q2TO1DNeupVQQPFX7Gqr7h
   CXnKiIgOHjrKEMZfrSZPuCIMu4mP/Mwrdw1yzsqD/mWWuUhgViMqWW8e9
   AaYHvjTb3Jb7D8z3DPen16+UlBkFGT6nCbEfhx9D7slx5MiEUVCyR6Ldu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="310360055"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="310360055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 13:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="798406618"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="798406618"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2023 13:20:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 13:20:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 13:20:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 13:20:40 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 13:20:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDBqqqn0Ey/UlYl3V4xVWA6mcr1mUYPJmCFlVeC2XhzasliKMA2gjyCya0bvYbezqlYTooGc5cTGbz8uFoh54T6d2ov+SPkFXrdZipmnDX/kuXld59Nl0ghNfeJ9Gi/9UAr73+LlCH5nNpnoqTMXT7IjGRdgPGZoXL3wDYUhshJTDFQwOBa4RKU2gGXBG6OuIPyFZ2SzMsuhS/lI74TSGxppCqVh3Y4MoH0EAzswVkFl59sQdmBKzctAirPbsslK5iUMBxxX6HaQXLcM2nTAQYw1YCbYReJmSLp8XzBk6LIR/LQoapS6KrmWmPoGydLv7ca7Y1vJxKtxT0g7mEjzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPW7Kzcsv5DgZScFmbgJLDZ8RnfMJMMWqdP12NS2v0k=;
 b=TOUAUZVBEhvJ2Bf8BN5MzPMHvCYuLFueKM61JmU8+brWFJpD2Is5uhFtrz1qAlvg2/wNujfEfwZYfApUkmH9oriNTcKDKj/Pz2FA+186OqT2r8x4KSGyP9ZlUV7MMQ6hJDWZ07P9inLWfElf41vT/oiOzkUsrQYW8ERtQ3PJ65sPO4pEe9pgd+BrJLogwCGL7uGJwtrV09Tgj6ylMNU+Fpzfvg9CngYlpejB6jfWUtiUZnrd05kiZDP0ZX1FdCmexWr1Vxj0g8DlpIix06z7OpM3hMvgvucDh64lJrsetiqs+lKxMsSjaxphLPpm37Q/E5vE5f1FpiQJVexrefkddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 21:20:36 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 21:20:36 +0000
Date:   Fri, 6 Jan 2023 13:20:29 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7iQndueq9Cdmlke@a4bf019067fa.jf.intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
 <Y7h8dpIQHnL93RdC@zn.tnic>
 <Y7iEjDrXLRlwoz0W@a4bf019067fa.jf.intel.com>
 <Y7iIZHa0fuJkHHjz@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7iIZHa0fuJkHHjz@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MN2PR11MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fed754e-860f-4337-0157-08daf02bda55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAZKiajSzLcsLMzoSIR0yB+jqC8mtPOIARaXlM4IFY+VVuFP7051h39nra9GzimKL5z4SLDUuhK7Vj+0TJr4RdhPDrpXEeGFgzcanDHc+qiGH9RAsk7H9oa7a3m9dVycRZ+p6J19i0gxeJH4dnDZxcRo4QiX6Sl/xIltNwRmftxEWmPyA6NdfyBeDFBPEJ4K4DAqqIN3fWU/iiLYbX1ETMeMzggM5FLKJW3CtEg51bhrCvHZ/NHVVJ5T/yhh+8gjX9qf7Vzm1pnRJJ2j1+ywQfPhnLL8AUw17Uv1QJRDi3ahG5AIFp5F2aFjELw0kCtMtaAxEzLNnJ8RS4mIcTcn573nPNA4IKYfyIS4coVjHr/7SOyJ+lQP25st0pRCe8m2yDT5unDFbGHPXHnwiXqESRoAqIrTFFGYv4oVKBwHWvkgFbfqQ/JJ0PsntImHb2NCN4kF/qQgpnPwTr7Zh5sGh6PTvb3WFNfPyBSrWmrjkmBnbv5t2SfEZslPhHOoBoAMQggoGK34kzwsneXQ5NectunLCVDgegUOzKyV8Q5me9um0qFPuHOCheck/HT4CdqO+1YxvnafJGK8jjRLdKJAtgCAi+IdFb3X7HbfpBRtl3G6TNF6Zlq/b+rhGEWA3P4xWlyqQelfamHJAsk/pThKEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(86362001)(38100700002)(44832011)(8936002)(5660300002)(41300700001)(4744005)(107886003)(6666004)(478600001)(8676002)(6512007)(316002)(6506007)(4326008)(66476007)(186003)(26005)(6916009)(66946007)(6486002)(66556008)(2906002)(82960400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fb2CFJ3ahXh8XPa0rjY1CQlnD55cdcGEy6a4Dwrli9W5vqSzx2AN2Mm/j7aC?=
 =?us-ascii?Q?jJv0RXNPoI7cnPxKS6TBmfCK575U+7LCIWchF9EOsE8R6iRrUoyELmTNnDo7?=
 =?us-ascii?Q?d+C9u54qYe/nNoyEv58j5iFKBQ2XGUX6LRFAlbtSk0NWXJ6UdioKGsGjorY/?=
 =?us-ascii?Q?mcAtIYTNM/azQyjc0gRR8HY1T04YklY0oojSGSo287+UFbwGp7XT1gaimgS4?=
 =?us-ascii?Q?PQhTLbfC96eNwdei3HeJiZGyKriP36ubER+obtLWhA08bclAlk8SJguov5NW?=
 =?us-ascii?Q?1PkAxTJYcMIkRltlaK03COaSfHPjMKPifg9VyPk5ommwTdiwRIL+HcvPOfSb?=
 =?us-ascii?Q?TC1Yr/18wI1pAS099+llrlhp89wYQElamemz7hltGBHd8jKF3/ko9xcrmpJR?=
 =?us-ascii?Q?PqsgP5zJnvmCAwj+9OxnDkUFjd3mBJcEWBbncPp+l/noYcOozE5GCwJi/4FG?=
 =?us-ascii?Q?9i24dhGS4l6vqCFsIC0Dlek8V45Fj4TXkuskimzivpxyn719iv3RjTqVd5p2?=
 =?us-ascii?Q?70d6uqu+jrhFvJMXJL7KIWlZVhF1Cjdd60UjIrGdN6n0+x2kUBAlXCuk3mrZ?=
 =?us-ascii?Q?zmiRQShyykpPnNPxHSwWeK9y8tGKRysNzdNd79xlOX0FoLmN4kMV4E2HFmRi?=
 =?us-ascii?Q?bgck8zcIBK8E9tqkgllxx/GK+CjAVHU45pJ5jYD6PahUuWaHwPHEb4nP2OvR?=
 =?us-ascii?Q?4E2oWbhA9LcW9s3P2urPqHf4FYisCxa+yK4ZsZB1LHS5ni3sn4vbxOEgR6hR?=
 =?us-ascii?Q?9YX25SO2IrllFnMUlIeiWhkmstxu4n2H4CGUfCf/1GXQUaxozMcTjvDcTutT?=
 =?us-ascii?Q?Gp0AgnVEt6BnOdWDlSivs0lUwLeG4K7W/4nKaKvfOUIxlyxtZjJkQ1C2bVQh?=
 =?us-ascii?Q?6ASa/bpRIncNZdLt4ZXpMd+fTZk7M5gYaA8S9fCvRlD+XYEfGFYtEhHtWC06?=
 =?us-ascii?Q?XCPoseq6J7oQjuWqjTFs4orSLkePWY8gY83Ek897C8RHaPK3Nu2pgV6ElNwK?=
 =?us-ascii?Q?4UDMEf4kXBnw6eteyVjL7R9POdjjgCz1LhNOLtIktU84iEmCYzlAQANs4T1v?=
 =?us-ascii?Q?CbehU5BS9fIYaiUBsuBzYvNRVM1czHqSOvjjLFlUwADGbov/8omwfiw1AkmU?=
 =?us-ascii?Q?5rpa+5VckBZLlXDxbdLk0Q34xiqhT9idKvf8OojmhMFjMkqu2yxs5Ng130St?=
 =?us-ascii?Q?POjjJMYvPjXDB1XRdNjgM5dupEtaSObPCBB18HSUsA/vF0jAqMGtJN7tvRbr?=
 =?us-ascii?Q?zpiKS2TGCQyzwpxsnz9wmZel9sE2D2+7fLlQCWdD8ZnorNs4YTR0bYFpwQWX?=
 =?us-ascii?Q?R4OVHIw2SOztz6bYapNSHuunydSt3zTaU4EO+dGGRYG3+tmUSMC9cz1USGsM?=
 =?us-ascii?Q?ukNHZExtRhf6FNqHUUC287fZjDXIbfaFIAjmnp8Zef8WPtSpPWaneqMnuVTh?=
 =?us-ascii?Q?iPwmSDabmYbBa7W8gp7B4/wAQk/GGd9gfUzRdg4G6rjWp6INhdcRc4aKa+kd?=
 =?us-ascii?Q?rwwxSsfjUU7HMWPfpaJFa3Vl1UJsX+8rlaeeR7Kw8q8Obm2qh3SBtOef81HH?=
 =?us-ascii?Q?duqk/DA588oY3HcN78sd+F+5URfE8O/i67S9nhnbXljpeRi04z+0u4baZFJR?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fed754e-860f-4337-0157-08daf02bda55
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 21:20:36.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWG2MD6w0sqfkOqV16Q77tbHF3ttlFSck64Cucugeh600TVtThMtYOIAQorMg/tsM1LM0rwkEY+Ka0ReV2NTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
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

On Fri, Jan 06, 2023 at 09:45:24PM +0100, Borislav Petkov wrote:
> On Fri, Jan 06, 2023 at 12:29:00PM -0800, Ashok Raj wrote:
> > Yes, that makes sense, Do you think we can add a note that the loading
> > failed? since the old -> new, new is coming from new microcode rev.
> 
> It has failed when
> 
> old == new.
> 
> I.e.,
> 
> 	"microcode revision: 0x1a -> 0x1a"
> 
> when the current revision on the CPU is 0x1a.

That's fine too. I'll drop the patch.
