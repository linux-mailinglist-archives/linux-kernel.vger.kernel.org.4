Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B31A674BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjATFLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjATFLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7FC4E9E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27FCFB8262B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A15C433D2;
        Thu, 19 Jan 2023 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146939;
        bh=ay0Zt/DVdmWEpoJIkbEHkl5DZpvrjQjuK8WtoM45jMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CG5RdnFqmkh/QFUyNL9Mv2Bx/eu+txGvUPxeOZjd+W7zzpbUMoLGYwaTFHeRsUYIq
         b1V0JdztzFFYGGWrTTTFssCj4AIjnTNG3jT+WRjRuokV4rb1ViWIK+kkHm3zQFhCV5
         KrqtROjEoAmeSieRs87dKrQRrwpHjsX0Q92ishdFQkzeBfsJqDmv+R7viYtOTiuyDJ
         9EtQ51C3c/vc7CRAlsb6XF7dOO60lklFruJQxzw8Ya11qbM6fXsLMVe7h3PZEuTB70
         d5X5rqzCnRLDPRbKOkrvaQtERmScNffkh9qSkmHSTb/c9Yp4KuhnO5VA00Kgno/QYB
         fZ0BzHKeQlj9A==
Date:   Thu, 19 Jan 2023 09:48:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y8l0ePagRXDHQByr@kbusch-mbp>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117063735.GA14468@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:37:35AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > Good morning Christoph,
> > 
> > Yep, the above works.
> 
> Context for the newly added: This is dropping the newly added
> PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> other boot tests) to fail.  Any idea what could be going wrong there
> probably in userspace?

Prior to 6.2, the driver would do it's own async_schedule, and that
async probe function would flush the first scan work.
wait_for_device_probe() was then forced to wait for the scan_work to
complete, which brings up the root device.

We're not flushing the scan_work anymore from our probe, so this should
fix it for 6.2:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b294b41a149a7..ff97426749976 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3046,6 +3046,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)

        nvme_start_ctrl(&dev->ctrl);
        nvme_put_ctrl(&dev->ctrl);
+       flush_work(&dev->ctrl.scan_work);
        return 0;

 out_disable:
--
