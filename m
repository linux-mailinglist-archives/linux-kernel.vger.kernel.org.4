Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB36559C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 11:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLXKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 05:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLXKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 05:19:51 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85ADB7FC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 02:19:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id o17so618572qvn.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJvpfRX2tbFtq+ubTBg2ndy7utW61VdVDpl6vlz73bY=;
        b=PWGgmKyPL3Uk6FAntsHlLJMP/dbDLVk9k4YlNWSNMsPXD+AjwlbME3lRPHmUUt/uvo
         FYHY6BZ41AB1372hFGt7Tf0PB1aijjhUWvFV6+1u5cu6gDmWLxFLI8wOqwgvbeyLveJS
         hndZQhl3BIj0beM29p7ALfgnv8prJMrx+FWkjODS9cPaU//nfJOMIM3u3hRdMNcCwuXg
         WFfYx2UlP0HBWaMHCjdMgn/Vc25sG17gK/p5CPFU5Pk6UgZwLN4ysocPosyhOOR7ibU+
         socQDMyglbeUH6CbrF1dH1oSxjSfLdwDTYJVYAaR2AYZuppBEm0BBm4vrM5An8zEq6hd
         rxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJvpfRX2tbFtq+ubTBg2ndy7utW61VdVDpl6vlz73bY=;
        b=ohsp2fzoK9DOAw6HMmC2B5gAeWtxVB60fsHZdf3uxXlT1TDPmUkYxsvI/c1atwYlxU
         1kFSVB4nbaux0aMi/+sv46RI4aGtSb8DEBRgFIrxo2U0uYD8FbwdaaxtxUAtdvOCHr8W
         bASTC3g8mKkdZuvok6nsK67qkHH2AM3ee1chxd941AacNMNr4lLhYZdn3ldGpbAKpuSd
         kJw9NAddDz0e9Rx1r9kQBJM1nzL4abj5YFDkbAL7f/qH3nxDbgYU2Adr259l/+kn7O1y
         UN3IxqFJdz+n4o5cIBqcwWzuehqMCmzrNAFjLWCHHYmCh3MhG9ur3K0bCSlnLqyWFl7g
         4hPw==
X-Gm-Message-State: AFqh2kpXYje8eVpdQUWNtpLwMo6yLS4e7r7GopBdXfGfhB4LtbDOf0J6
        qGUhytAaOEbtafKE62g5q9hJSg==
X-Google-Smtp-Source: AMrXdXuCRtN0lCn4Wy8/udbHBgrRkQKIQCfv9E6k+b6rheJIsOH43Iccppqy0TG6XpeUFQgvm+baSA==
X-Received: by 2002:a05:6214:3512:b0:4c7:a29:6495 with SMTP id nk18-20020a056214351200b004c70a296495mr15977018qvb.3.1671877185757;
        Sat, 24 Dec 2022 02:19:45 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cx15-20020a05620a51cf00b006f8665f483fsm3793869qkb.85.2022.12.24.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 02:19:44 -0800 (PST)
Date:   Sat, 24 Dec 2022 02:19:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christoph Hellwig <hch@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: 6.2 nvme-pci: something wrong
In-Reply-To: <Y6amzxU7choHAXWi@infradead.org>
Message-ID: <c67eba0-fc5a-4ad0-971-cf80bc1c6e5a@google.com>
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com> <Y6amzxU7choHAXWi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 09:24:56PM -0800, Hugh Dickins wrote:
> > Hi Christoph,
> > 
> > There's something wrong with the nvme-pci heading for 6.2-rc1:
> > no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
> > but under load...
> > 
> > nvme nvme0: I/O 0 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: I/O 1 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: I/O 2 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: I/O 3 (I/O Cmd) QID 2 timeout, aborting
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: Abort status: 0x0
> > nvme nvme0: I/O 0 QID 2 timeout, reset controller
> > 
> > ...and more, until I just have to poweroff and reboot.
> > 
> > Bisection points to your
> > 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> > And that does revert cleanly, giving a kernel which shows no problem.
> > 
> > I've spent a while comparing old nvme_pci_alloc_tag_set() and new
> > nvme_alloc_io_tag_set(), I do not know my way around there at all
> > and may be talking nonsense, but it did look as if there might now
> > be a difference in the queue_depth, sqsize, q_depth conversions.
> > 
> > I'm running load successfully with the patch below, but I strongly
> > suspect that the right patch will be somewhere else: over to you!
> 
> Thanks for the report!  The patch is definitively wrong, ->sqsize
> hold one of the awful so called 'zeroes based values' in NVMe,
> where 0 means 1, and thus have a built-in one off.  We should
> probably convert it to a sane value at read time, but that's a
> separate discussion.
> 
> I suspect your controller is one of those where we quirk the size,
> and the commit you bisected fails to reflects that in the common
> sqsizse value.  The patch below should be the minimum fix, and in
> the long term, the duplicate bookkeeping for it in the PCI driver
> should go away:

Thanks for the rapid response.  No, I've just tried your patch below,
and it does not help.  And I don't see any message about "queue size"
in dmesg, so don't think mine is quirked.

cat /sys/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/nvme/nvme0/sqsize
tells me 511 (and that looked like the only relevant file under /sys).

Regarding the awful 0's based queue depth: yes, it just looked to me
as if the way that got handled in pci.c before differed from the way
it gets handled in pci.c and core.c now, one too many "+ 1"s or "- 1"s
somewhere.

> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f0f8027644bbf8..a73c0ee7bd1892 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2536,7 +2536,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  
>  	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>  				io_queue_depth);
> -	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>  	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  	dev->dbs = dev->bar + 4096;
>  
> @@ -2577,7 +2576,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
>  			 dev->q_depth);
>  	}
> -
> +	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>  
>  	nvme_map_cmb(dev);
>  
