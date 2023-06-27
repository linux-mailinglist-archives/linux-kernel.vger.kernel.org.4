Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B7B73F2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjF0Dl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjF0DlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:41:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8213C02
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687837038; x=1719373038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j0mtguVr2giBa+kB3s1/l7HGRQlKZOiNTirmtn1pFL4=;
  b=MKGvlOM9NwIARU7BhXuLXMH2Q6ortHymY8b2hiSNIr+L8jD4uTtwOAej
   sBYZdZT2Hx/8lggR67422CG2MPOwRn8E3e+1mEoTajBqE2kRGT+gd1bZz
   A5yG8/lT1+sBfzhyXGUs6BW9h+xRKGmOF6fqFWa4Yzjk+O87wHVMf1Jt+
   DLysZvZmixkzfjcBNQ8FeykTvY+aATVsRXEruF2gFqy0QZsYnGk1bnjRm
   dDqlnv8aCSLC0jzaD1nOQTiILokTm4LeTxpB6Z/cQrPepG86fngTYyQ5P
   Yvgg4FERHQLUSTtGrb+WCvy1alKX8JoVkdQlsWc7dpt0RnfotnvB21tCK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364007956"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="364007956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 20:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716386728"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="716386728"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 20:37:15 -0700
Date:   Tue, 27 Jun 2023 11:36:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Jim Wylder <jwylder@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH 1/1] regmap: spi-avmm: Fix regmap_bus max_raw_write
Message-ID: <ZJpZJhostb4G1UMt@yilunxu-OptiPlex-7050>
References: <20230620202824.380313-1-russell.h.weight@intel.com>
 <ZJfB9zXhizbqmIrm@yilunxu-OptiPlex-7050>
 <c5c95368-eac3-4250-b50a-50f0a526b753@sirena.org.uk>
 <CAEP57O-EsrW0KgSDDnDDEYrvL-SEtO-Ji6oShNzvP3y0o9AqCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEP57O-EsrW0KgSDDnDDEYrvL-SEtO-Ji6oShNzvP3y0o9AqCw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 at 15:23:45 -0500, Jim Wylder wrote:
> On Mon, Jun 26, 2023 at 2:47 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Sun, Jun 25, 2023 at 12:26:31PM +0800, Xu Yilun wrote:
> >
> > > IIUC, max_raw_write/read is the max batch *DATA* size that could be
> > > handled by the receiver. reg addr bytes are not counted in. I'm not 100%
> > > sure this is obeyed by all drivers. But see several examples:
> >
> > There's clearly been some confusion in a bunch of drivers, those you've
> > identified below need fixing too for the new code from the looks of it.
> > I'm frankly unclear why some of the drivers you're pointing at are even
> > implementing raw buses.
> >
> > > So I'm not sure if commit 3981514180c9 is actually necessary.
> >
> > That's "regmap: Account for register length when chunking".  It's

Yes, will try to be as readable next time.

> > certainly a bit unclear now I go do another survey, though it's also
> > clear that things like the handling of padding are intermittent at best.

Handling of padding is good.

> > We probably would be safe reverting that.
> >
> > Jim, where were you seeing the issue here?
> 
> Hope I am answering your question.
> 
> The issue I experienced is that if a bus (in my case a limited i2c controller)
> defines a quirk with max_raw_write, then the chunking algorithm would
> divide the data into max_raw_write chunks.  The i2c bus would then
> prepend the address values to the chunk which would
> always get rejected because it was at least one byte too large.
> 
> My original fix, that I posted was to add a special flag (reg_in_write)
> that a bus could set to choose the to have the register accounted
> for in the chunking algorithm.  This was admittedly inelegant.
> 
> After reviews, we thought using the reg_bytes would be a better
> solution and that padding should be accounted for.
> 
> I had not seen an issue with padding for this algorithm.  Only
> the case specified above with i2c with prepending the address.
> 
> Would it be possible to reconsider adding a flag or argument to
> regmap_bus to guard this chunking behavior?

I think this is just software definition difference whether to
include reg addr in max_raw_read/write or not, so no need to branch
the regmap implementation by a flag.

I'm a bit prefer to exclude the reg addr, as it is in stable tree now
and doesn't see strong reason to change it. And suggest regmap-i2c does
the same as spi do, that is to reserve space for reg addr/padding by
reducing the max_raw_read/write value, see:

https://lore.kernel.org/all/20220818104851.429479-1-cristian.ciocaltea@collabora.com/

Thanks,
Yilun

> 
> >
> > Please include human readable descriptions of things like commits and
> > issues being discussed in e-mail in your mails, this makes them much
> > easier for humans to read especially when they have no internet access.
> > I do frequently catch up on my mail on flights or while otherwise
> > travelling so this is even more pressing for me than just being about
> > making things a bit easier to read.
