Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D50562EA34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKRA0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbiKRAZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:25:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC60720BE;
        Thu, 17 Nov 2022 16:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668731144; x=1700267144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9B40smY1h+h4BJT6WLqT4yujrExof4e1Tv6RQssiLRs=;
  b=oHEZZHlkKLBUYeX0zS+TjlGZcAdn4beVA9Ihy9AVRNV1TU6ZtJ3CQAzU
   fBF4E3bPusFIQjcdFztL4BL0CXpaa6Y7gd/cGx3Ai47j68vfICH8lMIfx
   F8n85Z0R96lMH9ncbOKsSOvcXR2htmdSOHTUOhppHyghF8rZGJXxJgQCF
   WqaYjbjsD/Y9OFD+Xt/DMuBBk20dB1PD5Ov0dXjqbSGM2cSTnIMOP2gwF
   sLsOBz71WO7Gkv5JgDgV2GaBt2Aw5uIWYWwvHGONpiHdWGpF8cUTeXTvB
   cbYcKVmUf8mLf1U4OmFVUuHI8KbSV/ov33Mjvvyewud4rP8ggm4uOz+xu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314165334"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314165334"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:25:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703539258"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="703539258"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.84.12])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:25:42 -0800
Date:   Thu, 17 Nov 2022 16:25:40 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] tools/testing/cxl: Mock the max err records field
 of Identify cmd
Message-ID: <Y3bRBGTAKutMgfo0@aschofie-mobl2>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <14b883bd220ff388cc3a287cf104d83d53a2f520.1668115235.git.alison.schofield@intel.com>
 <20221116125145.000009c2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116125145.000009c2@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:51:45PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 19:12:43 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL mbox command Identify reports the maximum media error
> > records that a device will report. Mock it here for testing
> > the GET POISON LIST mbox command.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  tools/testing/cxl/test/mem.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index aa2df3a15051..f0704d090073 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -111,6 +111,10 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> >  			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
> >  	};
> >  
> > +	__le32 val = cpu_to_le32(SZ_64);
> > +
> > +	memcpy(id.poison_list_max_mer, &val, 3);
> As in other direction, can we do this with a buffer of the right size if
> we can't do a put_unaligned_le24() directly.
> 
Yes. Got it, thanks!

> > +
> >  	if (cmd->size_out < sizeof(id))
> >  		return -EINVAL;
> >  
> 
