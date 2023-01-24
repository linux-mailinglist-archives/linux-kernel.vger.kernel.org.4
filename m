Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECAB679FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjAXRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjAXRMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:12:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459FAF765
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674580351; x=1706116351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5yPOhR33/JIDVjameyM+yo/GB3/87AUyw8nkj/3xylk=;
  b=llBQht6FsDcncl8aFnNeYmklsavm7x16tmYF3SaXl5xx08CRNiaZTG0a
   d6VJuCAdDnsUKddMOYwRTK9SVS2gFGHPDYDVtg+5doYnRx03OxJbFDwJm
   WIp/gjeQHfm0/wyXaMIdTpTMe9AYeVz+S8a+5iYIFtSDh0swRxyvhH1qa
   48XjTCYcd/SQaXOmq3ql4LVbkCSrMI+wizlwHPfuMYfJ226j4wuItlXYJ
   nOOi9s/jC0SJ4YTkOBtpwGzC1uwOSUkj+P/wjxEvI3wjwv/eWfDOpNcMc
   4SRGpkU9ShUWVc6qXFvKxZjARr76eNSxl7YQW4WCJO29MyImUgTXGxakO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306700480"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306700480"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907585740"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="907585740"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga006.fm.intel.com with SMTP; 24 Jan 2023 09:12:21 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 19:12:20 +0200
Date:   Tue, 24 Jan 2023 19:12:20 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount
 regression
Message-ID: <Y9ARdPA4vckTQ4GP@intel.com>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
 <20230124062140.GA29175@lst.de>
 <Y8+bP2Oqy3B2XyuJ@intel.com>
 <20230124134134.GC25796@lst.de>
 <Y8//roUT5byp59UP@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8//roUT5byp59UP@kbusch-mbp.dhcp.thefacebook.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:56:30AM -0700, Keith Busch wrote:
> On Tue, Jan 24, 2023 at 02:41:34PM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 24, 2023 at 10:47:59AM +0200, Ville Syrjälä wrote:
> > > On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> > > > Err, no.  We're not going to randomly revert things.  If you want
> > > > to be productive check the one liner Keith reported in reply to the
> > > > last report.
> > > 
> > > No idea what that previous report is. Care to share a link?
> > 
> > https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#m759092f541ea29fcb41911890307e70868636a45
> > 
> > Patch to test:
> > 
> > https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#md13c22b29cd81bd0ce9167c271c582005ba30550
> 
> I'll post the official patch if someone can let me know if it's
> successful. Or I can potentially setup a VM to verify myself, but I
> probably won't be able to get to that till next week.

Appears to work here. I threw a tested-by to the original thread.

-- 
Ville Syrjälä
Intel
