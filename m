Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49DF62639B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKKV3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiKKV31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:29:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3674FCDB;
        Fri, 11 Nov 2022 13:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668202165; x=1699738165;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9X4F+0MstuPDbuSnIOWlOLxRZHaaIfKwodkuGVUVWgg=;
  b=lutBkkbynyaCqHm3t0ZNn9lkwSJMSD0Pzmq0cUW3LxSEO758EPDK0NHn
   elSoMChgTu0CFT1jKMnAE1DJoDecg++VyBpFwFHKW8eegCSsIZD6/1j4x
   2glBCOIMKlSej1ROH8hae5vm+9tkFmGRWvsvefvcTcd0B3aha7Wyvqt0E
   3KZtTkqJo2i6hZIxecnbfBAS9BgmnjUTBQXYSqIvYM259JGf/oKTjGlDx
   D6phepWL23GwZBErnkIpEEA0QqcDKDdfFrBSi0md5yub6ZBo6cdiPqBGW
   9hwdJOxyLha6JdS16CX2EMFQ4qMrQMw0pS+0sgKCDGMbpXLLegTvSypln
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="311672460"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="311672460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 13:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="743402314"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="743402314"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 11 Nov 2022 13:29:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 13:29:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 13:29:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 13:29:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 13:29:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUIqnMuwAk/qp6Eit6RlsqxRyZGOWrop0xb4+QpSYTzrsLb9bSGNHXU7uADmQz6ejaEXdy5U3e0RQx/iEld76IbuZxiEACZPYgvh5R2i4p616YzkdHA2lMSoJoJYqljjU2vzcdGRjyKOPL/9eBp40+AV7IJIm0UUQhMU7GSIKhGVCQV7TUIycYgJYLBJZdzyl/42RBbGsOd3f2yUy7Ga9miBAukcuyqveoekhjU5sismkCvIDiqSuYZ4/uXRkRieL+jWvjBBxs/qBf94HWoYyM/dvkekV2JaJyIAThM8zZbMujZPhn0+Bym01zukPf9U48u9PenLJCLO5qEbvGYcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zTVOQ+bfe6ODbiVvHLDMWmd2QqnqzLnsf1nUxZusBs=;
 b=Wde9RjX4/K6PLg3KoeYZ6lcDixHDLHMKwdJ4yfqwvkniQHziaSMf2FxVDRvIrdCK8m17Tc8QEvyoqmwWJBqXN7a0ykkYP0Sg7dYDsPVqaloQLFqtHVEVlgCjB5fTzc5pHsmHhU+8mVklD1MHzES65x0alp2DTQS2T8dNfduYrNSdQdQcXUEfXrB1qCwfFlHQpG8TktC4WBMQmqRHg3CWNcbaKvuryn0lzkyierYJsMPsmacF0tCxUG0EwYtwyc1cz/xaSNTKVZGTqqWN35bh4qwJxuLUDyU/9ZedlN6A7w5ml+QbTTtRTp0UoN9xTi7cSkNfU21KkAHtm5b2VMUPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 21:29:19 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 21:29:19 +0000
Date:   Fri, 11 Nov 2022 13:29:13 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 10/14] platform/x86/intel/ifs: Add metadata validation
Message-ID: <Y26+qclls38ugbub@a4bf019067fa.jf.intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-11-jithu.joseph@intel.com>
 <Y26W+emSSL5Xik0G@zn.tnic>
 <82d6137f-4183-d994-f8b1-56b4be3d620f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82d6137f-4183-d994-f8b1-56b4be3d620f@intel.com>
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9f567a-9ce8-4598-7a21-08dac42bcaea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+VLA3VsPayP5NQaJV58rEKI49odPKarM+XNtiB1hGwBw4tjOAjj6gWF7Xrj28fSqnKWM1vLR0yw8T3xIFrP0ARwRokWmNQB7UAAOHrTyQUB4V7Hx1td5RxaJB/fEu3Qs9w4lFm7glifAbpN0/LKJB8QdIRGB9kN8+qYaQL7d+P1lcQLk0K2apgrc6JzQqrIqYZ61Sy+1keXA2s0pMueDwffPydz8gjXv/EkcW7z+gH/C/GDkG29cZI9mVpZug3RFXUEV1QcrFQX5yYXZ+cTGg9X3ie1IB4qC/7oTATD5z+qnJY51/eH7kjmDh7xwu+2O8SylgWFMx9bGdfDtoAAgopM4ergr/ErDhOoLbHiaMt6uUinBuiP60iCzUHBW7PYDocUQtKni8+jgypP01euWy0eksc3mwiDHTwyIO4A++3E4F7MBHq4WlcZdVdkTVuzzAFMt3WMXRqeRPejPYhs1jK4HIHBJZpR5X4LUtw0eBu81RMAhn5dTVHkDUfiFD9aO2RTpnneSMjJYf1Wd09Y4AK4yhXPjYBAh4ECg+LazAdlXAdD69mfyYOFOO8BdN0mL5uPb+G7Kem1evYs408rlp+slG6QsbyE8hhlcgn/uZB9GmZrJsTdIZ7C0iCcNtom2APvAeQh98CYnvaNSgGuz+JYL/wCwX0WGNlZagHbOBMt7k/SGFE5r66LPXooRy3WVt9DfwGLamtjpNQR8eHDkpmeUtyQYbn5Hwbt/y8pASyHMcoQvTo/zOqO+a4dCkQqMIk4eJr68MfrTKP3PHpt7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(6486002)(478600001)(82960400001)(6636002)(2906002)(6666004)(7416002)(6506007)(8676002)(53546011)(5660300002)(54906003)(66556008)(38100700002)(41300700001)(66476007)(83380400001)(66946007)(316002)(6862004)(186003)(4326008)(6512007)(86362001)(8936002)(44832011)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xcPpPMQAyY4Z0h/O88nccx/L3Bfj9ZOoTXB+JG8+a3V0obMG6xz2N+zuMaII?=
 =?us-ascii?Q?KdzIv1uI1vTtYlqZxUYboimfug6JRSTwqUnmyRYYtlr/e5f8nVFjtstybw1m?=
 =?us-ascii?Q?sQTRdp8++PAWCcSPm+n8d5S0fOqjrQVN1twR3DiFCmjKeKUPRNPgeYYdFMe5?=
 =?us-ascii?Q?uwdHpu27vcHmOSv4OwYPEMc46shaT0lVGSLaVioID/cq/kKz+46zWxynPqfA?=
 =?us-ascii?Q?iCwShyOqX6EOYzxISWHX+z/a2m6if08NIuoinutNHTM57yUmN5skH2nWIHM4?=
 =?us-ascii?Q?7LmwCn519M5EJ2x61r2XOMpZoYtCBZXpW3SVa6b+6TIFEd3VKilAXqg5DKPf?=
 =?us-ascii?Q?ZmeIGSDgrBty2+fVEQUSB+T7y8sO1zseULrGDBFc8KTgEVFoBLTO2so4a2X2?=
 =?us-ascii?Q?zTEa7EoX6jyA0LEPrUduiQGDVR4/YyXCEIoyuul+2UkMR/uq0bUIjvCCNk4a?=
 =?us-ascii?Q?WnmcrKi8SKpycLwUoDhZRDVyfkMzr6JiR7rYbc7W8iWYH3Hyej6H36Wttg6M?=
 =?us-ascii?Q?FgU+Lc3FfrznOj47VlC3BQAW3NrQgMrntBsHLyya3zxNVVgrn5OCLzjXYQpn?=
 =?us-ascii?Q?WrfUcbAUsqjSwwIF0h0PCJbJDiMkYY6Mb3g3aaNtjfRA73jPs5jYIq6wqjwt?=
 =?us-ascii?Q?7hBmAqCLE7chc7GfKhilOyGmYRSOmfYu6vwTlh6sao1XKcGh6TK+TJvGQVcO?=
 =?us-ascii?Q?f4UtyRg2OuZwIZdIzXHq2gTVsSdq5uHC7fSMLetE/wqhWbDC+dq3kajVTdgE?=
 =?us-ascii?Q?jvEBYiLCKuepZOAFZyV04LASGJ8M3/aB7gI1121svZWo6i2I8QCvIYlEE6P4?=
 =?us-ascii?Q?ce7iVSqBm4MftZnhhe5OyJLel786b+xSiGzXsD9ZT8LUoHIFcStEcEmEgD3F?=
 =?us-ascii?Q?v5Eom1ccwU/zDnXlfQcwzIFE6OAASbcZYN5lBZSDGmq8ekFc9klcssRN9Jot?=
 =?us-ascii?Q?Ob/VPOlN6WNx/d67JRV8oYjkdP3Nr2x1Q9do5xAplES1G2goiJBa7eS9Lqir?=
 =?us-ascii?Q?pT1P8ZTS9xw81vj3YfTyN6zhkh36z+rwuwtTGsQlEZNJRQFal3WF4goBJIpG?=
 =?us-ascii?Q?Gwk12oZVVFq+ye3gTM8yikJ6J2+D/DOZ8GPrWpGglIgJXsVMuEYhs7j4Qrp/?=
 =?us-ascii?Q?PbUoSc9guAnrZCQi9K5NvCQYR4y8HIoOi/tkS8kagQ0gzYXei2jFK5MzHg7K?=
 =?us-ascii?Q?oXc+p2AYgmLKM8Gz9XIuZnyP9M/OJnP754sl36E8X3DNS2N7FXWpZcu+bQzU?=
 =?us-ascii?Q?8mA1Ae09h650/NlmY/kd2RQrsTaBde+8tOOPDbXsaq+IhHXvl+TI+Hi4kOZv?=
 =?us-ascii?Q?nuK4D+7ysDRW/2EOvh2Y9HgR+VNf7nV1s8OnseFEZS0x3LkLocGfF8a/Vqrr?=
 =?us-ascii?Q?8iuBLMF/XkY99nzZwFF446uHwODMjoRkKJbIP6nMi+x7kXO0xXDaoEykZ9bw?=
 =?us-ascii?Q?fn+XLmB03v067tFpCyqc0xEbdd9WE8IrxLW9Gr1Scr+NRgG/aArWGSXSq9bP?=
 =?us-ascii?Q?oJwUyUuwLkDEsdgVwJ5hhnoeVfsg6nk1pIimtITja/6PANEaL5eKQrXUV/S/?=
 =?us-ascii?Q?luxO5aJQaIjrybXq3edvoe1tZhFRvSOWhHr/Nkiv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9f567a-9ce8-4598-7a21-08dac42bcaea
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 21:29:19.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xb+uXfRGFf/nHj90DcmoOaMmMME8jD/J73PkK70YyHVgKKugJI4vgQm6NXu2UIBMkEvMQ/GcaQfYlzi/AAc7mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:48:49AM -0800, Dave Hansen wrote:
> On 11/11/22 10:39, Borislav Petkov wrote:
> >> +struct meta_data {
> >> +	unsigned int meta_type;		// metadata type
> >> +	unsigned int meta_size;		// size of this entire struct including hdrs.
> >> +	unsigned int test_type;		// IFS test type
> >> +	unsigned int fusa_info;		// Fusa info
> >> +	unsigned int total_images;	// Total number of images
> >> +	unsigned int current_image;	// Current Image #
> >> +	unsigned int total_chunks;	// Total number of chunks in this image
> >> +	unsigned int starting_chunk;	// Starting chunk number in this image
> >> +	unsigned int size_per_chunk;	// size of each chunk
> >> +	unsigned int chunks_per_stride;	// number of chunks in a stride
> >> +	unsigned int reserved[54];	// Align to 256 bytes for chunk alignment.
> > That looks weird.
> > 
> > __packed and __aligned doesn't work?
> 
> ... and don't we try to use fixed-size typed in hardware structures,
> like u32?

Maybe should we do a cleanup patch to move struct microcode_header_intel
also to u32 format then add meta_data to follow the same style?

When we defined struct meta_data followed the format and style that was
already in place.

The suggestion below is a lot nicer, let the compiler do te job.

> 
> There are also much nicer ways to do this:
> 
> union meta_data {
> 	struct {
> 		u32 meta_type;		// metadata type
> 		u32 meta_size;		// size of ...
> 	};
> 	u8 padding[IFS_CHUNK_ALIGNMENT];
> }
> 
> That doesn't have any magic linkage between the magic "54" (times 4) and
> IFS_CHUNK_ALIGNMENT.  It makes the compiler do the hard work for you.
> 
> Voila, you have a union that's always IFS_CHUNK_ALIGNMENT in size,  No
> magic 54's necessary.
