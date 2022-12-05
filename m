Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCD642CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiLEQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLEQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:25:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99F11DDC4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670257555; x=1701793555;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qsaDwc1B2ic2cfVgHuZV3ShLB7mLfhWqSmOSIOnkO6s=;
  b=RBhWFzscuuiCkya5SOLJ4cW8cTeSYQ3kjYDv0kb2gkmqmafZOYv4K8xK
   zDBOzy3q0hz+3IXzjkx5oPEJCe8kwUqfPFnfKwMe13woO2ZxTHHlTkoRB
   6zxOF4ejlldSf9LuPGRdCcnLyh9YUJXmk0KN9lScojXhju76N6LnbPM0t
   4/AosZU62/Ok1RWLjwBat8ugcEoXVGcHWs1XroOQcdvGY6JsPAClzxQ2w
   i4ZVlH/3IuUjLxt3ug4gKbSYcwzn1FGjOIld8KbOby/6GgI0JavUcdMls
   o9NuI5xxGFPQijikKU3+Wzh8b6o6+aXriHCTpdHyCt29qX7hdVAv0HGkw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="299821214"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="299821214"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:25:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="709311569"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="709311569"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:25:53 -0800
Date:   Mon, 5 Dec 2022 08:29:48 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix buggy QAT device mask
Message-ID: <20221205082948.3cb53a8c@jacob-builder>
In-Reply-To: <Y4qpPxpXO9XQ2NEL@a4bf019067fa.jf.intel.com>
References: <20221203005610.2927487-1-jacob.jun.pan@linux.intel.com>
        <Y4qpPxpXO9XQ2NEL@a4bf019067fa.jf.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On Fri, 2 Dec 2022 17:41:19 -0800, Ashok Raj <ashok.raj@intel.com> wrote:

> On Fri, Dec 02, 2022 at 04:56:10PM -0800, Jacob Pan wrote:
> > Impacted QAT device IDs that need extra dtlb flush quirk is ranging
> > from 0x4940 to 0x4943. After bitwise AND device ID with 0xfffc the
> > result should be 0x4940 instead of 0x494c to identify these devices.  
> 
> Can you add the lore link for the original post here just for reference.
> 
> as a Link: tag, since this depends on the other patch.
yes, Looks like Baolu  has already taken care of it.

Thank you both!

Jacob
