Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24964C188
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbiLNAyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiLNAyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:54:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FACF66;
        Tue, 13 Dec 2022 16:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670979283; x=1702515283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yl/XfJki3Zuoragfo/MZSeW/GJUbHvUPvLuAE9ikqFM=;
  b=A5QQoI6BBC8isj5vUx/REWMhnH9auOJNYlphbSuLO25qwtNWH1QlpRJ9
   yl6uN7zIwZXgKg5L9e9mHSEH8ZqB+8SEgDSoBCUZNQLqNoAXz0focWens
   P4PXSpc7eAwLBgAfRHDYnwGwXJrfIQC1AkyRzl9s1Jai3z/Lc24QQcj9m
   d+x1yd+uJRI1t7WIR9zXB9hSyVDFZRTA6ARHF0Dh04rLIO4A0eO3lyz4c
   E5XDnA4vWiRfKzHtgkqeq5nDxOgO8EcMOsvd8fMqeZlswhhBRdKJcwCLD
   MRDhEVY8d/9blPBSavI8wZ+/VOYA83s1IoHFlwIt+vFlwkJXHgwlt8nv1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="382578889"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="382578889"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="681345436"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="681345436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2022 16:54:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 16:54:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 16:54:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 16:54:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 16:54:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAAo4Q90cpzWfRVHCTaOIzZQLYj012LV0UU4S/6jq7TG+GrBCMeOunX5ON8QjMOZZq/zH5lafHme1jdnuFqQHnFYVf/NGCauGEniWRWq5DwPC7Ojzl5FR5UezUj86OGeYgp0ZbybI4AhQQzZFmGcEpHBcuagUDJZZ+qJL5s1RO/fg6ArznXt2xTMfNrSicuofSy2ezc5ELc+7RpRqiOHzfOPwodC/1yuGep+YoqYj9Iwn0qPaD6k9T5ZnEWnABCUMDqDSRjgLwh+rhHygcQ6kIJMImHHu2c6vQVZkLn2FlF0vpCUY4p0nZPqY9D5Qnv90A8eKtWwx9T5bdWNErP+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pnryQkfYpiE8E4izstJa1dSZBZMpNh/qBFRfAV3SyY=;
 b=YLjuCP+iEZSnwl2qi16Dn4ZrATTRK+pAgEfnJvgL6R2s3MIpEng7VmlsyAtnC73e8STqa/UHrtbGGFvwowGJKBBiv+PQL/RfQwhfMkRkb9FA3A+oUytKExIHtgpftAKwBZ43hj+hYFGDos2z/UMLpuxrQxnsvIP4ZzvXPj3RXHD1b4D9pobYjl5o63m0ev9Z9cb6YTmlikiRmfP05uMaMfkZJP1r8N4FBxE6xQ8gq13cbkmL/33Bc7XVchhS/joC4E7+aSwsgh5dJXEOW0cn7ih/jBKLF8csHi98oetDU5hepTdlZlbudk+ZeVIpSbqFxU2nj3SonqZpF9oBLiW1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB4917.namprd11.prod.outlook.com
 (2603:10b6:510:32::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:54:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:54:36 +0000
Date:   Tue, 13 Dec 2022 16:54:32 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <63991ec886e85_b05d1294a6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
 <63937afd72956_579c1294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <6393a3a9d2882_579c1294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y5kAt3WRgncTj26x@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5kAt3WRgncTj26x@bombadil.infradead.org>
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH0PR11MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: cd831227-0bff-4059-9f02-08dadd6dc566
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bhE+h6j+XBN1EYf+Ve5NK0s/Y05PXNtVEPnXQXbsphK/0awnqu8l0STdgH7Ogc7pOy5WI+LISi0Qx/YcGU4nHZrNDMFCzPFvNhAl5LSeNLt16XNodcOlqjhlNt9PCxVGP5c1foNalN/H4ldddVlLdj0ttDFfpO3jSCZVwqNWhIjaTTr1e/cYvuePXa78MDS46Fq/u3UPRos5rHKSwLgKaRVD7ORPaGjWTMKBu7aRvnZxsSZyMpRiOXCr4TSK4eATsa0ZOSOpoRkKPXxbxVTXy7uG0ag3qdJzZlRf9rlwTm8M0OgF2jFVhL5XYfRq86oPGlQ/pvpbS2FeVTST/+b65Fxq6knJZJv6EVdteOFso/dk0GH7YfA7qkvxWOa+SEHGR/panaVcT7fGEGdITm41vKS5Eui7CNF1DMVxTcJJlUVmxPiH9E4aurOslDVf/i30IdI6dPXBYIMt6iOlN4V1SAeDpan34KsUz/TBdVA6BpbMkecsPdL8iZaG+wNZTFBNaJnS3hty1xIWzmGcGgXLqXTbyFfItu0GD2N1+EqfdWdLZkWMhQUsAFHtG8aVNzX4aJ68qc6QPzW4VcYqdtADCNlAOBatQJwmKd9dVrq2vAxHnCBNBWmEkFPygcjLuSSX4wJNcuiE7IEqqbOrow2+JIIhM0dGM0VHzEjFN1r9ffJ3bqmJrmBMkc726kMlhev+jY0h6onJ4ARvO9sMxXzyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(966005)(6486002)(478600001)(6506007)(2906002)(86362001)(6666004)(53546011)(82960400001)(186003)(6512007)(26005)(9686003)(38100700002)(110136005)(41300700001)(83380400001)(8936002)(5660300002)(66476007)(66946007)(66556008)(8676002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8ohXandfc7B/GjS19J/J2l2/B7ZDDU+SnWkiHy1UXTiJtRoCJkXX5XjK7C+?=
 =?us-ascii?Q?FwxJXkiq7ZJYjOLZK/O1BFmJQfAYSnahG2hqRz18maSVmqcxdWuJebpEPFih?=
 =?us-ascii?Q?qdz3oWmWog20eRon4NKtC+aldw/h+cVq1kX7qh/mYSOp564hFZUPimPj5HQQ?=
 =?us-ascii?Q?+dQtxItHaesTHyRqdfQf9gPja8s73UNVt+v/sB0s9c7T9TR6AhTwzFPk2rUV?=
 =?us-ascii?Q?FHwK6ZnzF+Do4XbAw9S8xmJYlnSfHkHQtF5atQuEtvdhco5I4JzhDBJryNW9?=
 =?us-ascii?Q?nbC1SdZEXDx18Np4IZz/Gc+VSxQvHtM9oentANfEHRHhu90V0fMOroB9TZAc?=
 =?us-ascii?Q?Nbr3WR3D0wQwBIFJARebHx7U2yFA9AbejG6my0MaLQYxxKwhTzycEqjaCZ/+?=
 =?us-ascii?Q?jHV4A/dkuUZe9fxGzIx+OHE5/w2VtVeqs01cadKEiGjinRaNLuF503JNHHCq?=
 =?us-ascii?Q?oIl7acZW0coEr0L7oAS2DYvA/Jilpf7qLjWbbi2Jco8ZvF0+TWdtqqIsh+mU?=
 =?us-ascii?Q?J4t75Sz06EyRzoTGYRNOl1ymxYzDrG7Q6LE85xSkamkMJ0zuYg2enAECPUhQ?=
 =?us-ascii?Q?52L+76nvjbscVTJxk83dq/9v0jO+zLJnjy88wCgpj5qLivTZ3BiMJLGZnAXB?=
 =?us-ascii?Q?oH1K8oZkacj6jLoYXMTm+/wmzjC8f8k3czIiSPBdMRNiylL+SgPT6xqEC2XG?=
 =?us-ascii?Q?IQuiuaZu5cx78pWzcvO5b6VYnrN7PNkZSwcyKqsCo9/rkfKUUByw+86ssWIT?=
 =?us-ascii?Q?McYcgJb4R/sKhPh3Ti3jJDN/5/A5VvHnkPUP/Ck7sMJjvVv/Y4y9l2F6rXUq?=
 =?us-ascii?Q?L8DDyUDwVq8yiQPTQvGeCSWZuAy16wbATNM8D6onLgwxaxTN4n2hTTUP/jeX?=
 =?us-ascii?Q?N1JpmFqTC0R98OFdY1qYvHzmleJEryWV/44nsjPxyfJImPp/Wp0vkvfPB+HE?=
 =?us-ascii?Q?3KHWOHyiLGHeRuPX0XcdsuujWWac15n5F1RA9y8EncDhLkXCCA9Pt/X1VHKH?=
 =?us-ascii?Q?82H4CxV4j8JtSbt9Eo3z6mNx6lUQllGPXo2mUop2Z7jj/Mzsfwew+bLSfw1I?=
 =?us-ascii?Q?zbn+KTZX7Zm79LMZwQgFLyDS8jg4S+UH3KPrHutMHSbHLioTLrjvcKE8he9u?=
 =?us-ascii?Q?pCdHM9XuD3rI8v1STn4YIVmhT+4GOC2mFxtO+vU+6XZ7RQOD1GLWlUshsRIE?=
 =?us-ascii?Q?caX54da443cBx4SfLZlnBUIOZTIYFPsp5MKGM4mXObNvQwiiBoppdTYLeC1c?=
 =?us-ascii?Q?AsaoK6prlXo1nruK94OydQAShi+Ga6WvXSAyZAL7dUUfO1ijuCt+2PZueG6S?=
 =?us-ascii?Q?LoD9ukuiOFuugFJb1gIuL7bVT3Q4C8YBojzve1mDlcPMEcG1yxMIK1l3tLB9?=
 =?us-ascii?Q?IoPYFlRMBEo3bqCEqXGVeQss/9uEB3gdivjJEJXycaQ+WL8uUVTur6uAt4i4?=
 =?us-ascii?Q?WIry/GiMEYoACPAwmRC1ioyJxxE1JNPfoet59PPXbnISnFbvpUsmzG5VuOwF?=
 =?us-ascii?Q?QUEqrrFYvzivrq1q18klN0d9D2Xek4IHcsSoQPKG8ESFl1kJdpchvXQtqeg8?=
 =?us-ascii?Q?d6PdBUuncWXpvqi72GCbREM80gjAi0/fS+eTB+7OYJ3KvkWRjL9PF56koUxY?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd831227-0bff-4059-9f02-08dadd6dc566
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:54:36.1544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYMPEDmxXQYnbXFTYb6aWwYDJOjZGDdjj7aCw5N5IIyRL9322BqjX23UQjtlFmR/Xk0lcokBJMr2jMlJeU5QB7VrCN1XODXKnb4RJjyXO9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4917
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote:
> On Fri, Dec 09, 2022 at 01:07:53PM -0800, Dan Williams wrote:
> > Dan Williams wrote:
> > > Luis Chamberlain wrote:
> > > > Simply loading cxl_test ends up triggering a null pointer dereference
> > > > on next-20221207, 
> >
> > Ok, my 6.1.0-rc8-next-20221208 build passed.
> > 
> > # meson test -C build --suite cxl
> > ninja: Entering directory `/root/git/ndctl/build'
> > [109/109] Linking target ndctl/ndctl
> > 1/5 ndctl:cxl / cxl-topology.sh             OK              11.84s
> > 2/5 ndctl:cxl / cxl-region-sysfs.sh         OK               6.82s
> > 3/5 ndctl:cxl / cxl-labels.sh               OK              10.14s
> > 4/5 ndctl:cxl / cxl-create-region.sh        OK              18.32s
> > 5/5 ndctl:cxl / security-cxl.sh             OK               3.35s
> 
> What branch of ndctl do you use?

Yeah, somewhat unfair of me to say "works for me" with patches that had
not yet been posted to the list. That's fixed now with this posting:

http://lore.kernel.org/r/167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com

...and this one that is now on the pending branch:

http://lore.kernel.org/r/167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com

> 
> > So, what I suspect is happening is
> 
> <-- snip -->
> 
> Yes you're right.
> 
> > From 93bf2c04cd3a708c73c0e4ad7a4121505a0698da Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Fri, 9 Dec 2022 13:04:26 -0800
> > Subject: [PATCH] tools/testing/cxl: Prevent cxl_test from confusing production
> >  modules
> > 
> > The cxl_test machinery builds modified versions of the modules in
> > drivers/cxl/ and intercepts some of their calls to allow cxl_test to
> > inject mock CXL topologies for test.
> > 
> > However, if cxl_test attempts the same with production modules,
> > fireworks ensue as Luis discovered [1]. Prevent that scenario by
> > arranging for cxl_test to check for a "watermark" symbol in each of the
> > modules it expects to be modified before the test can run. This turns
> > undefined runtime behavior or crashes into a safer failure to load the
> > cxl_test module.
> > 
> > Link: http://lore.kernel.org/r/20221209062919.1096779-1-mcgrof@kernel.org [1]
> > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Indeed that fixes the same crash. However that highlights a few other
> issues.
> 
> 1) ndcl unit tests still fail once you do get the right driver loaded:
>    a) pending branch fails on the first test and stops there
>    b) main branch fails at the first test and continues and passes on
>    the rest of the tests. What is with the discrepancy?
> 
> 2) The instructions on ndctl to use an external module are easily
> misguiding folks on how to use external replacement modules, I'd like
> to suggest a fix below.
> 
> Details below.
[..]
> 
> Anyway I think we should simplify the ndctl README.md to just use
> INSTALL_MOD_DIR follows, thoughts?

Hmm, but scripts/Makefile.modinst already has this:

INSTALL_MOD_DIR ?= extra

...are you not getting these modules deployed in the "$modules/extra"
directory, or is your distro not priortizing modules in that directory
over the others? Fedora seems to have this policy by default, but it
seems at least Ubuntu does not. That's what led to the discussion of a
modprobe "override" policy in the Troubleshooting section of the README. 

My concern with changing the INSTALL_MOD_PATH recommendation is whether
having modules in "$modules/updates" is guaranteed to work in all
distros. Otherwise we're just shuffling which distros need a custom
override workaround.

> But this also raises the question of *if* using ndctl and linux-next
> shoudl one use the main branch or the pending branch? Can there be
> issues with synchronizing ? Or should the main branch always work,
> and the pending should just have the latest and greatest and *can*
> fail?

This falls into the category of a "good problem to have" in the sense
that I never had to worry before about others wanting to reproduce unit
test results this early in the dev cycle, so I appreciate the nudge
here.

As to what to do about it, I am open to suggestions. The typical flow
has some lag between upstream tools/testing/cxl/ changes and when the
corresponding ndctl/cxl changes land. This is because the tool enabling
does not start until after it is clear that the kernel changes are going
to land. After that it's another round of review to settle on the tool
changes. The ndctl/pending branch should usually be up to date by the
time -rc1 arrives. Is that sufficient?
