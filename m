Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8E679FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjAXRLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjAXRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:11:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185D4C2C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674580307; x=1706116307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5rPRxziFRlIVlHQ3JuhXOuLds1hFr2+bLman/mjKsh8=;
  b=ZXVo6QpTZ89VHVPWQHEnCb5wyIUjupznilV9GBghxm4Gv3e1mirwvjxD
   Sq8VuFk4qVFQBHFTNOgV4oJ1oPqPiKhswgIcyaRp2fqerY3rS3VQ/IhQm
   63tTcZu4AineSA3ilCtmdJY7QhB6YjuQxrvUqGM0T9yuJHBdsYmK9Z4rZ
   +yQar6FUG6EtjYFOJaLwiOrQOYiTN4OptNDIT7Y1tiJyDja3ptBJfCoz3
   o0VMTRpAB2uomVFc858kJ3YVo1xAJb7KTe7EAXZn/z0L7+2tU5PRdpNgP
   vs2rNiJ9XFPFesHvqsVPseF098jD02tue4366803towOHHTKuLKm5FU8a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306700300"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306700300"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907585507"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="907585507"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga006.fm.intel.com with SMTP; 24 Jan 2023 09:11:40 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 19:11:39 +0200
Date:   Tue, 24 Jan 2023 19:11:39 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y9ARS0qwEXz/bhPc@intel.com>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
 <Y8l0ePagRXDHQByr@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8l0ePagRXDHQByr@kbusch-mbp>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:48:56AM -0700, Keith Busch wrote:
> On Tue, Jan 17, 2023 at 07:37:35AM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > > Good morning Christoph,
> > > 
> > > Yep, the above works.
> > 
> > Context for the newly added: This is dropping the newly added
> > PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> > other boot tests) to fail.  Any idea what could be going wrong there
> > probably in userspace?
> 
> Prior to 6.2, the driver would do it's own async_schedule, and that
> async probe function would flush the first scan work.
> wait_for_device_probe() was then forced to wait for the scan_work to
> complete, which brings up the root device.
> 
> We're not flushing the scan_work anymore from our probe, so this should
> fix it for 6.2:

Appears to fix my Tigerlake Thinkpad T14 gen2.

Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b294b41a149a7..ff97426749976 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3046,6 +3046,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
>         nvme_start_ctrl(&dev->ctrl);
>         nvme_put_ctrl(&dev->ctrl);
> +       flush_work(&dev->ctrl.scan_work);
>         return 0;
> 
>  out_disable:
> --
> 

-- 
Ville Syrjälä
Intel
