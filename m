Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F717295D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbjFIJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241963AbjFIJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6FE61B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686303736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xx5w6ckiNjaVKwtCwEkoI8dGhSmph0xBLrLV+yuOs30=;
        b=bMHy8DtmMLrsyO2OfsHwVbi0gdC3zV2EQ+ArKsXqPAXuniYqoqPjUvHsi41tjyisgdkdVu
        R/6c5QtKdVqrON7aSAk7AT2NAunLVGVQM4fjwLA+DHo8onzYvUkA8drByxkfxumz6iAWWQ
        i8i05y6+BxDI2NYJHMutMsyL6H+mHvE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-pcPRSGpnMxyDL77BYAG0pQ-1; Fri, 09 Jun 2023 05:42:15 -0400
X-MC-Unique: pcPRSGpnMxyDL77BYAG0pQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30ae9958ff6so673567f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303733; x=1688895733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx5w6ckiNjaVKwtCwEkoI8dGhSmph0xBLrLV+yuOs30=;
        b=DXOxWNjcd6xfV+sDihJTyNBnoSSOtYirtuB51A4cNxsfKg2u7kuGsZbYE78F44wtLt
         F8kjAS2M+aeFHLti0ylf3Y+S3Fkz/OdTXBGSjDEKkJM0QibCYchkM72W8v0NA7xk/QQv
         IuYe80i4wG0UTLgrTln7/r0jv5DQldrLFgyUZ4i2UJFxdGoztoHCngw+/CLxTuUXiVyD
         0+2mOT7gUG5/4wAjtBKSJO7mPw/EZwSg2Yl3OKRS6Y1gP0l4IpYXcA/nlTg3egtJHOzl
         CfN6z4KykFh2LgazbsTLQsEyinZCFX7O6kk7w4UoyWNIFOCPv32Eumaqp5dx/AL17Iua
         zAhA==
X-Gm-Message-State: AC+VfDxG0kokw58aSTjNhVSJGlqhuLP+ZuqGluYb6DaRup9hZNk1PvZB
        DLSH/mYSKTA0Y+qiL+CpLmL3K6qfYCauWZGF05k1z6sM0iR7LmyJUsiU9E/Jtc7W/SAchuU1C0S
        KU7d8SXRC48DrZHwvuxRU9N2x
X-Received: by 2002:adf:fe05:0:b0:307:8c47:a266 with SMTP id n5-20020adffe05000000b003078c47a266mr458557wrr.61.1686303732943;
        Fri, 09 Jun 2023 02:42:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PPw1vXh/FEb46aw49JQLXBVZlrIgtTrMV15/sO9XiqueH21CLWlE9kKvt8QU8ZBi7rKwtzA==
X-Received: by 2002:adf:fe05:0:b0:307:8c47:a266 with SMTP id n5-20020adffe05000000b003078c47a266mr458543wrr.61.1686303732551;
        Fri, 09 Jun 2023 02:42:12 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b002ff2c39d072sm3934842wrx.104.2023.06.09.02.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:42:11 -0700 (PDT)
Date:   Fri, 9 Jun 2023 05:42:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Roberts, Martin" <martin.roberts@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>, Suwan Kim <suwan.kim027@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <20230609054122-mutt-send-email-mst@kernel.org>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB53547AEE6DAB355D5C04BFE98351A@BN9PR11MB5354.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:34:40AM +0000, Roberts, Martin wrote:
> I think, at some point,  vbr->status, got changed to virtblk_vbr_status(vbr).
> If I use the version of virtblk_poll() from the patch, but substitute virtblk_vbr_status(vbr), then it (patched 6.3.3) compiles OK.

Hmm v2 does not have vbr->status anymore. Are you referring to v1?

> Note, my setup never causes virtblk_poll() to be called, so its influence on the issue is unknown - but maybe it also shouldn't be running in batch mode.
> 
> With the patch, I've not (yet) managed to hang it - I will let it run a bit longer.
> Martin

Want to post the patch that works for you?

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com> 
> Sent: Friday, June 9, 2023 8:27 AM
> To: linux-kernel@vger.kernel.org
> Cc: lkp <lkp@intel.com>; Suwan Kim <suwan.kim027@gmail.com>; Roberts, Martin <martin.roberts@intel.com>; Jason Wang <jasowang@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Stefan Hajnoczi <stefanha@redhat.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>; Jens Axboe <axboe@kernel.dk>; virtualization@lists.linux-foundation.org; linux-block@vger.kernel.org
> Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the IRQ path"
> 
> This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
> 
> This change appears to have broken things...
> We now see applications hanging during disk accesses.
> e.g.
> multi-port virtio-blk device running in h/w (FPGA)
> Host running a simple 'fio' test.
> [global]
> thread=1
> direct=1
> ioengine=libaio
> norandommap=1
> group_reporting=1
> bs=4K
> rw=read
> iodepth=128
> runtime=1
> numjobs=4
> time_based
> [job0]
> filename=/dev/vda
> [job1]
> filename=/dev/vdb
> [job2]
> filename=/dev/vdc
> ...
> [job15]
> filename=/dev/vdp
> 
> i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
> This is repeatedly run in a loop.
> 
> After a few, normally <10 seconds, fio hangs.
> With 64 queues (16 disks), failure occurs within a few seconds; with 8 queues (2 disks) it may take ~hour before hanging.
> Last message:
> fio-3.19
> Starting 8 threads
> Jobs: 1 (f=1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
> I think this means at the end of the run 1 queue was left incomplete.
> 
> 'diskstats' (run while fio is hung) shows no outstanding transactions.
> e.g.
> $ cat /proc/diskstats
> ...
> 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568645 0 0 0 0 0 0
> 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905623 0 0 0 0 0 0
> ...
> 
> Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and show every request had a completion, and that virtblk_request_done() never gets called.
> e.g.
> PF= 0                         vq=0           1           2           3
> [a]request_count     -   839416590   813148916   105586179    84988123
> [b]completion1_count -   839416590   813148916   105586179    84988123
> [c]completion2_count -           0           0           0           0
> 
> PF= 1                         vq=0           1           2           3
> [a]request_count     -   823335887   812516140   104582672    75856549
> [b]completion1_count -   823335887   812516140   104582672    75856549
> [c]completion2_count -           0           0           0           0
> 
> i.e. the issue is after the virtio-blk driver.
> 
> This change was introduced in kernel 6.3.0.
> I am seeing this using 6.3.3.
> If I run with an earlier kernel (5.15), it does not occur.
> If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq_add_to_batch()call, it does not fail.
> e.g.
> kernel 5.15 - this is OK
> virtio_blk.c,virtblk_done() [irq handler]
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>                           blk_mq_complete_request(req);
>                  }
> 
> kernel 6.3.3 - this fails
> virtio_blk.c,virtblk_handle_req() [irq handler]
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>                           if (!blk_mq_complete_request_remote(req)) {
>                                   if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
>                                            virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
>                                    }
>                           }
>                  }
> 
> If I do, kernel 6.3.3 - this is OK
> virtio_blk.c,virtblk_handle_req() [irq handler]
>                  if (likely(!blk_should_fake_timeout(req->q))) {
>                           if (!blk_mq_complete_request_remote(req)) {
>                                    virtblk_request_done(req); //force this here...
>                                   if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
>                                            virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
>                                    }
>                           }
>                  }
> 
> Perhaps you might like to fix/test/revert this change...
> Martin
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@intel.com/
> Cc: Suwan Kim <suwan.kim027@gmail.com>
> Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Since v1:
> 	fix build error
> 
> Still completely untested as I'm traveling.
> Martin, Suwan, could you please test and report?
> Suwan if you have a better revert in mind pls post and
> I will be happy to drop this.
> 
> Thanks!
> 
> 
>  drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2b918e28acaa..b47358da92a2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct request *req)
>  	blk_mq_end_request(req, status);
>  }
>  
> -static void virtblk_complete_batch(struct io_comp_batch *iob)
> -{
> -	struct request *req;
> -
> -	rq_list_for_each(&iob->req_list, req) {
> -		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> -		virtblk_cleanup_cmd(req);
> -	}
> -	blk_mq_end_request_batch(iob);
> -}
> -
> -static int virtblk_handle_req(struct virtio_blk_vq *vq,
> -			      struct io_comp_batch *iob)
> -{
> -	struct virtblk_req *vbr;
> -	int req_done = 0;
> -	unsigned int len;
> -
> -	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> -		struct request *req = blk_mq_rq_from_pdu(vbr);
> -
> -		if (likely(!blk_should_fake_timeout(req->q)) &&
> -		    !blk_mq_complete_request_remote(req) &&
> -		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
> -					 virtblk_complete_batch))
> -			virtblk_request_done(req);
> -		req_done++;
> -	}
> -
> -	return req_done;
> -}
> -
>  static void virtblk_done(struct virtqueue *vq)
>  {
>  	struct virtio_blk *vblk = vq->vdev->priv;
> -	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
> -	int req_done = 0;
> +	bool req_done = false;
> +	int qid = vq->index;
> +	struct virtblk_req *vbr;
>  	unsigned long flags;
> -	DEFINE_IO_COMP_BATCH(iob);
> +	unsigned int len;
>  
> -	spin_lock_irqsave(&vblk_vq->lock, flags);
> +	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
>  	do {
>  		virtqueue_disable_cb(vq);
> -		req_done += virtblk_handle_req(vblk_vq, &iob);
> +		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
> +			struct request *req = blk_mq_rq_from_pdu(vbr);
>  
> +			if (likely(!blk_should_fake_timeout(req->q)))
> +				blk_mq_complete_request(req);
> +			req_done = true;
> +		}
>  		if (unlikely(virtqueue_is_broken(vq)))
>  			break;
>  	} while (!virtqueue_enable_cb(vq));
>  
> -	if (req_done) {
> -		if (!rq_list_empty(iob.req_list))
> -			iob.complete(&iob);
> -
> -		/* In case queue is stopped waiting for more buffers. */
> +	/* In case queue is stopped waiting for more buffers. */
> +	if (req_done)
>  		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> -	}
> -	spin_unlock_irqrestore(&vblk_vq->lock, flags);
> +	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  }
>  
>  static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> @@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
>  	}
>  }
>  
> +static void virtblk_complete_batch(struct io_comp_batch *iob)
> +{
> +	struct request *req;
> +
> +	rq_list_for_each(&iob->req_list, req) {
> +		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
> +		virtblk_cleanup_cmd(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
>  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
>  	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> +	struct virtblk_req *vbr;
>  	unsigned long flags;
> +	unsigned int len;
>  	int found = 0;
>  
>  	spin_lock_irqsave(&vq->lock, flags);
> -	found = virtblk_handle_req(vq, iob);
> +
> +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> +		struct request *req = blk_mq_rq_from_pdu(vbr);
> +
> +		found++;
> +		if (!blk_mq_complete_request_remote(req) &&
> +		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
> +						virtblk_complete_batch))
> +			virtblk_request_done(req);
> +	}
>  
>  	if (found)
>  		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> -- 
> MST

