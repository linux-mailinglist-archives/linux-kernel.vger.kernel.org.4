Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22125E735B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIWF2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIWF17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:27:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1611BCE5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663910875; x=1695446875;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YU3fUxKyKwN42P9KA7MdO6QtwVx7YcPiq3fu0NTVQ9k=;
  b=YTSMgUFYkb4VSSVe1hjyjKu1kyf2RlklVVbpf6b2V2Gb0K+WL3D09Rcb
   WoQ9xdsezDQhTtN/LcYqc/VyO5HKB6flBETGyD3aySD5mOXVbnQYAr6SW
   Hstg+QctjBzjJslA2JGynpxs6jigUC8NRDNxguzXrxXjcM89yI3+DbVAD
   TDhZMYcWT2fDefUX6frZsaZoZVJtlhF5WbfBxUnZtWeLhC2D5llZkVuYU
   gKa5E0NRe2CQFOD/DYqnAhruhX7+rRUwkPZNXi2teYbJk5q8hw0U4G47q
   w6O/4ASEjWMi8PoxX86ev27C0tyM6fTPdcn6lcyFd75UOXch5dwHsZyCb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301394604"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301394604"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 22:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622397327"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2022 22:27:54 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 22:27:53 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 22:27:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 22:27:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 22:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PorvLLW6gDMxoNIg0VHnhMJo0lAD7BiSO8DmBZTSyLPGBrTWQSMXMM5yRVR/ON1BHDb2wgsBdH6HWFb49/ZPM1PtXl0G24PrDHUeb66D82TeS6CYqolnmzZTFkg8dbMj4pL1Jq+9RTZ0K/zv62rxc1iXvwXT7t/NwqnHiDYpu+boLg99QwN6ogOOojaEVD5V3Ov1VVqCZsT9JoVv4/b8A8fRXKMs6oU6IHI6Qh/7kLqgyZfAgAttLQx0rD/njJkU+YrGaTPDyg5KJIkRIb3CK6BUlYEV6E5bUUTVAwMV7aaTWhTFPx27cByqZV4fHcSj/I7FsRiCGmMNBveHzJctWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z34Z8B0wNUsGwITyrW+Afm5j2BiSg96aOlfingFnoUc=;
 b=I+8CHPWdvstqJaEOkW8lCNZsNAthD4VJoNOHhv+rcKKr2kUKFbCHMD5LhPBbn/hOHvEAL/RJcTHhcTS/u6rlUCqycNRPS795pF+UdL/gpiCGJF4ec1tc39S/tLfe2fPW25f7jav0fGdXsB8l1aaTmaqy8kBx1PtYwxECDE43I5iDKFYGBWK6Z8ie2BeNJDUIFlU83gl9MKJtxE5Ke/Uy9DhlIXshw9ItbHdz7UZok95wjKRe7udlpBiFHVbkzThxpLdY563yBWJoDnLsLTYOdVw44TnNXPK4JCnTcc0Yw5SGoBYXdmRsxAClB7BiIeBmZCvl4iLspRc6sxoviNRwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 05:27:48 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac%5]) with mapi id 15.20.5654.014; Fri, 23 Sep 2022
 05:27:48 +0000
Date:   Thu, 22 Sep 2022 22:27:45 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
References: <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: e780d0ca-43aa-489d-639e-08da9d2459f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Jd9rnhKb5GNBfPu9eDTNT6o6iJZC8YlyFV6kCCedxKFFy1cqI9G/ZJwnQ9+rF/K7oXoBZ1sWC0d2g4bq3ZJEHSyAnw/QOYidw2ndTRO98GC7lkVd4Y5NFis6G3fHYkQbvHjGpPOAkauV0wJDXwienNezyss1hUJjP6Ko/gfAr2R+nUWyeqxwVfyKVGNS8aRnmcrv53ecwhf+5Rv8GBgF7T1arlsaciZoJGyR8ax1x9P00y1ro+J2OBubiP70Y6JRQccnvm3uvfFLtZFuPcPlorFSxfiqK+gly+ioGH9fDbrkW+qHiDvTBaohySw2QIdj8Bmb1yYSaDuk4DNxwzwaMkrZxlTV1M6hToXvrBCHqjwrH+R4L6fGad5FFyY4cHDQt2geJnLy9fwQ1MIchvWUUZaWuz+QMclkw1Lpzh23GH0FGfx6bOuQeLRYlE09ljODapoi1fHuQzhxUIk4B/aEHSdY85dKUZ+zg9cKpNzJtkSeeC3FTc6HQJ8Cgj0ZXQvQaLae9pTy2gHZ5y0VLvI6M+D8mQR6tmuj0DuchDDTX15zT5Fm9nNXR/4szxGk2wBFYXRpxj/7xCWyA1/trwxaY/k94FElmTX8foocXKalEGGqox8anG3U34oGpj5LnfzmW5uJppBmCfu8IBO6Mdna1sNqYJRxI6PDkNpPFSc6nmtZ4kZE6a1q5/sqHzC8+4au0OZ+KQxY2e/Tyn+44ZAnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(4326008)(8936002)(82960400001)(66476007)(66556008)(66946007)(38100700002)(86362001)(7416002)(44832011)(5660300002)(2906002)(6512007)(26005)(83380400001)(6506007)(186003)(478600001)(6486002)(6666004)(8676002)(41300700001)(54906003)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tXpjBmXR9SWr5NIhdKyQFvbWsRk8P45s4g7hJyFEwZ6MvZxA544R0VPLoEx?=
 =?us-ascii?Q?naJEY7rJA48bSQUCmyXFScpMwQ3Jq8Mn1PT+ELs1B3TfWQGrUeaoxUVcZMcU?=
 =?us-ascii?Q?qrN4eUhs5cYliBTtuZtxsS+4VLWiE0RbE36JXC+BrsEU/VlbLlrsvG6TBta/?=
 =?us-ascii?Q?+667S5hwWtKWeuP5xhOZw8NUUHR2gWwNfZN9rbi0tKO1bci6Cfvt3I4Wp4y6?=
 =?us-ascii?Q?+8I8L45wbuCuRkjv7fKD4mwEtvzAlaguBde+ffHk9SkS8Tzgk1VZ9l5Sa2Vp?=
 =?us-ascii?Q?J9onew86/562djFjMy6YXe2mrmYL2J4VjpuHZ3um7t99ry7084vWY9n/Xa1h?=
 =?us-ascii?Q?10hXGmLE+ilXnrk+Tu9mnudYPnRmwDgArOAW+VK8umoMKHA8y3IDIewF6+Mg?=
 =?us-ascii?Q?/OqrUIkUg5B9dH6AoOowD9GlutlsdU5EtwWrFdMErYRi9ezsZUyTy7SxVAdb?=
 =?us-ascii?Q?bkmHwBf/GtQnw7Ldo9ZIu8bYW9L6itY09qW/CP+xtBZHHJDxhM7u5KPnngTq?=
 =?us-ascii?Q?HJJlICeATnlNSBNmL9ilDHw2J/s4mOAvepz0vO+3U4+zOg/bNZTvJpucp9sw?=
 =?us-ascii?Q?MfeUlXJL6G7FBZmGxrjS8Pi96xb35DHfl0nL53AL5f3zI4rulUoBD4Dgy5a1?=
 =?us-ascii?Q?kQtUK9aG5i1U5PC5idrA0OXPtNUTZhwoVq1/EkBveilfemvpMqkaScDlWWWV?=
 =?us-ascii?Q?ZVIcMciwqYb9Se0wI3WSALiUFjePOfD2pyhpO33jXsCGuIi0/6jIWVW6RqsY?=
 =?us-ascii?Q?7Cs2GbEObHKUrXGq89vTxeaYgK33ZUlJLzFW51G9HSCpd79EYHPwHeJNotXv?=
 =?us-ascii?Q?BlMHecIedW3rW1r3/RvPsm9mMLMOy3Ul7J53jAW22Xd4aPE7nA/+BL8WIjSU?=
 =?us-ascii?Q?tz+AUdWVCjuqsfxrpgUbizTp1DrTaU9vOsCIbEcJQsjt2fe1sUGqXlBpye8B?=
 =?us-ascii?Q?sJaonvJXXPH6SsoPOPxFt6b8rtsXyfloLW/jjMKCmPBIEiGEx1MXfJOImhpy?=
 =?us-ascii?Q?gLCa9h15DOCj6dBrovUIijW6F6KKadt6byLTK8ODg1tzI4jJDiDZxiHAefS7?=
 =?us-ascii?Q?yZ5uANL/8vZtl12RKlIAm+UPmkDg5+oB/Pf2kZu7N7d0iAWeok2PhLP3PfDm?=
 =?us-ascii?Q?V233v2tjmnEDKMEWyikklIDq3hoei+sd6vjP5cD0DjhPxg9Uligd0PMki1SH?=
 =?us-ascii?Q?0K4v4hhIiDeqCxW141imb85iTnElUA1+eMDCC1aizR6WXIAxR/6fKbighYZT?=
 =?us-ascii?Q?QtITQ/lK0dezmHp6dJfLo0exAjO93PXnxIOhihtEXopOjjkC2mYU2ST24iWv?=
 =?us-ascii?Q?pkSTLBdaeHgOo5enf6mq6gG9h/z71ARrsf4T7oVxVCfZv+iUKFpFSJnKeIHe?=
 =?us-ascii?Q?LtMdj0+28AF4to7awV67FCOFIvj4EXl+C50Kihc0NIDQM2TN6KudinpIYwh7?=
 =?us-ascii?Q?jyinRJ7dKGoQfYse/ic8+cnnLzC9L4fBa4ngpCT6BPKeByRCp5MejCcGFSR1?=
 =?us-ascii?Q?pthUxuWnqu980G5kKxskxbh8Kx/W+2tFbFDtMYF+vUF9Nn8f65lBKWMcnrfC?=
 =?us-ascii?Q?hi/FFuLPSwfNjLb+K0QBH4SlMaRE+R2QY87b3A8X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e780d0ca-43aa-489d-639e-08da9d2459f5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 05:27:48.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7PUAD80e1AX56IYYk6TjLFyQcM/MFxwEvAfqsc8Xwh4VF2sV8wviOScnDZ1jUrOr+U6sWCrXFdXPtnKAIxYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
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

On Fri, Sep 23, 2022 at 03:42:39AM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 21, 2022 at 03:11:34PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 21, 2022 at 10:11:46AM -0700, Dave Hansen wrote:
> > 
> > > Are you saying that any device compatibility with an mm is solely
> > > determined by the IOMMU in play, so the IOMMU code should host the mm
> > > compatibility checks?
> > 
> > Yes, exactly. Only the HW entity that walks the page tables needs to
> > understand their parsing rules and in this case that is only the IOMMU
> > block.
> 
> But device has to know what bits of the virtual address are significant to
> handle device TLB lookup/store correctly, no?

For a device that also cares about tagging, yes. But in the current
world we don't have such devices. IOMMU only knows about the shared cr3
we placed in the PASID table entries to walk page-tables. I hope the
page-tables don't factor the meta-data bits correct? So I would assume
an untagged pointer should just be fine for the IOMMU to walk. IOMMU
currently wants canonical addresses for VA. 
