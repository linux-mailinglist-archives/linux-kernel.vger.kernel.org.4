Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58EC5BB1D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiIPSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIPSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:04:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089E309;
        Fri, 16 Sep 2022 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663351467; x=1694887467;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GuuRbRtDpNheL0nTQBEk/Fq4HSKqT5XOvLHgbbQAUzE=;
  b=oE9n12emsQ5NdqLNNHLf72zklrx9B2QTHw45fbW0pyUpy8Ve62s15fYV
   QQt/auC2VPJryGsfg+MaXqe8sPnGo7fieYXa9fqWsoFf3wKffUulFCt8f
   sb5DQlfs/YBQAE1BN4QWBIWb3MjA//cwKJqJfb7pV3RDZPsRZez2R8Ppo
   MrG9kJgoAFRMlkyHWrCclu/9yhoNBKd8UCXNxC91Yy/Fb9sz3gWbgqDnG
   lvoKp9r3CJsMll6VfRURnzNBHtoeiQTwe+Mc1d0JeukPtqAIgRhWlNcg3
   oYM0Ji5rNN9Ln6BWBKvZkzrXmZpxx8GEIfrg2hpNjadgG1nEKVO3WZNlA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279428512"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="279428512"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 11:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="568912982"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2022 11:04:09 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:04:08 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 11:04:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 11:04:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 11:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaFrmMCLh4ui5fTvBItlx83bTqW1yC9IMncK1AlwYs3kfmytHhNaYtPJReq7tnxhm5XDTxN167PMIWIjCkVnv/MgiLmpq3ez1Wc34+KlVGFb4sSOvlm9GjTT1yPcvrUG5m0z+kVOBvJxoHpN2alnRqoDVBfuVgV/Yixqb7Ox5Nr724UhuQlSiZ4ipExmqXR+6zs9gq4f7n0RkI3MBM+brBjnhLo7s9xXdkDyQUW8/Yi1RoVA6kKchB+3kp1tqUhudGQVCilaZ2CsA7Id7Ra5k7edT8D24l16kO1bfzYXQSr37w2qsDVQJNdIjAzo377GthRGrarw2b450RWsbb8Xug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfBjzvmwtCEQQxEJGjwjNkSbixaZIsjDBc0/rOFnXho=;
 b=RcfFkF50f/lu6igbh4ltMBdjE6jQbGEHM4MHz+EPBRmuKvuNcxe5ZiexGcvAxFwPiDiVDCBA1x99y1QhPQkmoINhrYNbhE99a9ipt5vhMY7E5ZcTgEGqWcp+YdIBvoDEFV5oSQbOJPxkQsHAhs1iLga0xU6DVMynOESSp3hCUAiAaXfhhDrpimdzvtyxvjTG7JoGLc11RA6g8aLAeTrAUAxjlLp00iozIu595JBUb8aJRpiv6gE8LsZtQbnviGjT98R5VIaLPygmUfQ3cIXRkxIadOZudByC+YCAFu1+bebogDLuXm7CQqKipc/fwOcUqqy+Bsom6NdMDH7JnYqU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ1PR11MB6228.namprd11.prod.outlook.com
 (2603:10b6:a03:459::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 16 Sep
 2022 18:04:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 18:04:04 +0000
Date:   Fri, 16 Sep 2022 11:04:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 02/15] cxl/core: Check physical address before mapping it
 in devm_cxl_iomap_block()
Message-ID: <6324ba91a05cb_2a6ded29457@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-3-rrichter@amd.com>
 <6319824968fa7_580162946f@dwillia2-xfh.jf.intel.com.notmuch>
 <YxsvPwzxoYBMnN2y@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxsvPwzxoYBMnN2y@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ1PR11MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd79824-e755-45e5-56e2-08da980dd734
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gZvKu41/CJu+N+XFVeNXtGd8fl59iirYNXGGEHguZb7HmS9qGzapP5OwR5TrjerZfwFhAtxO9LJqynfffVYITFczXAvIc9ikFJKjH/En7+hlDN5kbKV3oD7UF/HW+cilWQEe2ngqqzDSwnusU1gfXqMoo+hTOUjl+JtLxiB36xu2yo2R330omAJxfUgjkc5BXOhw4F301kOkDAzmflZ9an9NBwuGSWVnjxoZtaOCSPaFJYGnHdLdrnCSaTBlfkjFNCBDxZwLhNgWcxNJ8KLSJMBUM6Bxg20loqbDxAYdc3Bp2AVZD5axDytD7eiodat7craC3SPemq8tE0IUE3ftUeWm9R/yhXmaA1+edvSJGscxMjjqPMOJt1j2ERDgDKIcjqjfIiHL+23Oiu0SSjKU0se8bs+btAVZXqceeClYYaHxXzTcAhbO1G2UtvU6LzBMBk6pyoW2rg4O955KozbUQ1i1BX/gACSq4guSofWU3hSIUeiz7q+G8RQ2kuNUmY83F3LN4tPL8o8ASnyj2iTsTBDe79qVCgPhuQO7EUyf7m07iVUW4yHqINAeA8z7rs5rPWqtuBsYQA7d75PR2KCX/6BV6QLHwgWuvVDZno7FaCdNtcIdLLrfHmA7ipdNY9KP9fQgDcpDCjA4KWLiIT59YlNEhBxJe+qEC+voHL2YnSKpHzPmZGbrdh071rkAL0jgU+21ZHLONNhJaq+W8SSQ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6506007)(6666004)(6512007)(66556008)(53546011)(8676002)(4326008)(54906003)(66476007)(6486002)(110136005)(66946007)(9686003)(38100700002)(83380400001)(82960400001)(86362001)(186003)(8936002)(478600001)(316002)(26005)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ai8uvC7D9ActblvMOMXvYiSQd9DxR0UnLxfftobiD8GCGeRzHVbajjSnsz5?=
 =?us-ascii?Q?FVtqPC74uc9kbWR0ZRO3u8rcQqgQ4bTs686Dz5BCkqgiqh1vqpeBHwD5sQJK?=
 =?us-ascii?Q?RrMrZ6u4Sy4PaQnzv5tRZYE5V9b5trZ7t827631vU/Zgv4PiIMhVGnZIhXXk?=
 =?us-ascii?Q?peypcfmIS/d2C4RlnLi4e0C65xq8WNKxf2ViZeKXcYjMplVBnRUFZ7vZ4Miz?=
 =?us-ascii?Q?MQvc0iiSbWTgK4fFOqWGx323KDNp3ChIWM+Z6Ip+nQdZApW1QWuChxo6Kgf9?=
 =?us-ascii?Q?P9V9sgy3y1PKq1cvJj+XRvLeKkMU+0SEXUYOpxtX9ZV2Dt7tj528ZXnpymbi?=
 =?us-ascii?Q?F+R7XoYBxLX3++5kOAEHqac5ME81ehV5vw5fRMeamB6HlxOHx+7zTR3DXq3e?=
 =?us-ascii?Q?3Q3KACf+2N2dexGKmKLFcWrksyGJWCncxxu2N3zB6WH8C7d7TDV5t0u0T5oN?=
 =?us-ascii?Q?liVcGfuNnqUoH2nr3jdW5nNJPsAx+kLLwty7blF8rYy3skQ2OVxzsQ2mERl7?=
 =?us-ascii?Q?2PlAFfchpSgz2MKT9vg2AYywCDt+Wn2Dy0Kh5nFBXcXh6jliLLlSAEhJvrox?=
 =?us-ascii?Q?pOE+48HWACkZwKEhYNpn1dJlhWuBFkwa3lcOOKzYhRVhPj5x/CqqeipH2cs7?=
 =?us-ascii?Q?Ic55t91pCOKsRdZ2w/pwJqWruVbk7FxkP2m+ojb0mnHXjh80DJY7JNqEB3yk?=
 =?us-ascii?Q?7T7iWYywNkVuUN8cvmqhibgcSeApu7R15xA/f3sAcOFhEUzWFRMHGCK1Jzz5?=
 =?us-ascii?Q?cMqlXK8DnMk0dLI8iqrfY/rnAEDVfGdKzJRJ+374Cha5tjLcjYvvTl+8XN2R?=
 =?us-ascii?Q?Es0ihtwelxyHlZz3LEPLyGOOR40kc2FBMhayqAU52ZZciEmSrMwCidYNfGju?=
 =?us-ascii?Q?G/lHrJHAY90PLakVwMyFRM7cFJYf8NJ2LCcIHCIkZFRDmGPGqgXYfeJIS7ef?=
 =?us-ascii?Q?qe8/h6puFP3Ra3DbcwwXoZmYWROGK36OBDMfj9sMkAtTJhmFOeyGfCeWZxWY?=
 =?us-ascii?Q?nvywl8AZGZSqzjB2VwDTw6gyFLZ/PU0Yd5hNjhM5aGvQW6Igf6vVyUK7ikkc?=
 =?us-ascii?Q?vZTGsVXeXGvEYKryowEDN762F09zoLT40AKsGh8qJfV2W/mnLsH1o/EkAIE/?=
 =?us-ascii?Q?u9aXvZ5XYtvla27V0lsL7JKwCUpHuI0cB6YNBiWjWNZHQupEVlYgOoiBi5Hd?=
 =?us-ascii?Q?Fm9LcjjA+oxKLGnXqL0thSd14mitavkdQybi4x5dhZTfmYxF7B85I7qrkjnq?=
 =?us-ascii?Q?ae3lCLxQfRlc4KN6vaGZ0B+evm3DEBm62gCCQkRO4Om+bSg19JVXnCXoGTaI?=
 =?us-ascii?Q?W7Fe8aEoztAVAh7zaU2oC20Ot/26J1ibUWy/xzItJGR+ZSrlOYVZgdpfzc5q?=
 =?us-ascii?Q?S0+elbm18x7mQtA0VS7OUn0ZBXgYuZlRQktV1QaJfmCEYK+m2ANQ75mXLXOz?=
 =?us-ascii?Q?kcCr80TDaZEJGfH12yxt07xM5pVW70QDod+6iD38UiYjPw/vj0+rKQOcgBiA?=
 =?us-ascii?Q?YBwIqWYBTQAGo3453YH6FXfx08FPZwnkTzVqEIoU48rHkUxPIXTzjxs9fRXc?=
 =?us-ascii?Q?kAuv6UTbQx5SKBe4q+qkIUD06VRxk9dmC+OStEt5dh5jNOAVKi5gyOz0GQlv?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd79824-e755-45e5-56e2-08da980dd734
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:04:04.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LietZGQoqsovSo1F40jg3FaTPiUTx7gAHKZaw2/kF8bizleyFPq7XuyK/Skaf3nS+F9sQMiswCRuyiXAf9X3BVG3Wxd319KCNrM13hTSDOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
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
> On 07.09.22 22:48:57, Dan Williams wrote:
> > Robert Richter wrote:
> > > The physical base address of a CXL range can be invalid and is then
> > > set to CXL_RESOURCE_NONE. Early check this case before mapping a
> > > memory block in devm_cxl_iomap_block().
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/core/regs.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > index 39a129c57d40..f216c017a474 100644
> > > --- a/drivers/cxl/core/regs.c
> > > +++ b/drivers/cxl/core/regs.c
> > > @@ -165,6 +165,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > >  	void __iomem *ret_val;
> > >  	struct resource *res;
> > >  
> > > +	if (addr == CXL_RESOURCE_NONE)
> > > +		return NULL;
> > > +
> > >  	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
> > >  	if (!res) {
> > >  		resource_size_t end = addr + length - 1;
> > > -- 
> > > 2.30.2
> > > 
> > 
> > devm_request_mem_region() succeeds for you when this happens? More
> > details about the failure scenario please.
> 
> No, CXL_RESOURCE_NONE (all FFs) is used as address. A broken range is
> calculated that even overflows. I only vaguely remember the exact
> error message.
> 
> This may happen e.g. if the Component Register Block is missing in the
> DVSEC. cxl_find_regblock() may fail then and returns
> CXL_RESOURCE_NONE. There are a couple of code paths there
> component_reg_phys is set to CXL_RESOURCE_NONE without exiting
> immediately.
> 
> I saw it during code development, when I pre-inititalized a port with
> component_reg_phys set to CXL_RESOURCE_NONE. Since that case can
> generally happen, I think it must be checked.

I think Jonathan had it right when we posited that the code should
probably have failed before getting to this point. For example, the
scenarios where the driver looks for a component register block via the
register locator DVSEC are not valid for RCDs in the first instance.
