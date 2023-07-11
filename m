Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93474E749
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGKG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:26:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E04E73
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:26:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so60835085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689056801; x=1691648801;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aW5+rXuaq7TJXCcRzo6xDmek0tWPICmc1aRt4r1oLPg=;
        b=SlUO/Mwxym9ydWKE/vvQ1EA0ONlJhRL4g8AyqssMYmCHKOof2daEbgK4J+7J6dFIsz
         L0EzJYn2MKzJ2qtLzuMHfz25clYpkKQUkG7rUjcmOnH3WJqogCl2K2D25oPWdSvTQGZM
         fYbXr1z5AamgOSMHL4EjeD+Li49NwjeHS7jxhayQEhDpIllV5Rld+HyvmyMc224f72ds
         5E1MvqieWtb1ori16wYYI2iHHFVISSTlkkX4xccyD7EoVIlmNzZXVHfdsfwW8wJSQv8g
         UexWfuGfqWhZe4w2YJiHLalJ4es68+1WSR8owV2ACNLzTD1P7g2unRZq2u/bC50h1QGU
         bSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689056801; x=1691648801;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW5+rXuaq7TJXCcRzo6xDmek0tWPICmc1aRt4r1oLPg=;
        b=YLN6JSGtieFFPx/O69n2vf47/ft99v9zxClKQHdFUX40uM1owO8T+5xr8H0tMEynUT
         G9RqLLQrqHgbS0PMaHvIZJqYau254ZK9GNIQlnIfo5r0TVdCN8ipiSstO4q9cQ+rfoo4
         vdJfso8FP8YfVy8VNkOnDNu9EwsYyG/M2DcgN0CshQOV+2a3aIL1iMs0GY/i6W+c4wua
         h7QPhI1+mYRSpk184TjoImCsijzQhyBcPRDNCJqmH+62r5BxuVP0eVtHiwuqMaDgOwsp
         PeSQlXzPTYqBXGeks4xlW6MCj8uevr2sjjT9NHXZ0K2PTsns00s4aBGq1o2kSvk+5WjH
         HRGg==
X-Gm-Message-State: ABy/qLbP9p+AwYQbeH+yFzbDfvgIl2ZbHGhzQh1c7Zu0h5v1UCrUnQRH
        uvK7xgnsctyK0YhNw06whhXoimVwx3Nk/AOj+i0=
X-Google-Smtp-Source: APBJJlFcygAOFYB5s3BZMDOQA2sdkTpuyxBJ7bP/LLurgp0PUce22pucUbk//Hrnd5VYzgW7/omiSQ==
X-Received: by 2002:a05:6000:370:b0:313:f9a0:c530 with SMTP id f16-20020a056000037000b00313f9a0c530mr16037477wrf.52.1689056801434;
        Mon, 10 Jul 2023 23:26:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l6-20020adffe86000000b0031435731dfasm1305600wrr.35.2023.07.10.23.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 23:26:40 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:26:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Hsia-Jun Li <randy.li@synaptics.com>,
        linux-media@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, ayaka@soulik.info,
        hans.verkuil@cisco.com, tfiga@chromium.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        nicolas@ndufresne.ca, "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
Message-ID: <396eb32d-5016-4eb7-aea2-b6e824aecadf@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704040044.681850-3-randy.li@synaptics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsia-Jun,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hsia-Jun-Li/media-v4l2-mem2mem-allow-device-run-without-buf/20230704-120308
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230704040044.681850-3-randy.li%40synaptics.com
patch subject: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
config: arm64-randconfig-m041-20230710 (https://download.01.org/0day-ci/archive/20230711/202307110324.A5LMPHou-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307110324.A5LMPHou-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307110324.A5LMPHou-lkp@intel.com/

smatch warnings:
drivers/media/v4l2-core/v4l2-mem2mem.c:343 __v4l2_m2m_try_queue() error: uninitialized symbol 'src'.
drivers/media/v4l2-core/v4l2-mem2mem.c:343 __v4l2_m2m_try_queue() error: uninitialized symbol 'dst'.

vim +/src +343 drivers/media/v4l2-core/v4l2-mem2mem.c

9db3bbf58be59a drivers/media/v4l2-core/v4l2-mem2mem.c Ezequiel Garcia    2018-07-25  296  static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
9db3bbf58be59a drivers/media/v4l2-core/v4l2-mem2mem.c Ezequiel Garcia    2018-07-25  297  				 struct v4l2_m2m_ctx *m2m_ctx)
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  298  {
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  299  	unsigned long flags_job;
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  300  	struct vb2_v4l2_buffer *dst, *src;
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  301  
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  302  	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  303  
f3e1a4c9d7a02d drivers/media/v4l2-core/v4l2-mem2mem.c Randy Li           2023-07-04  304  	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
f3e1a4c9d7a02d drivers/media/v4l2-core/v4l2-mem2mem.c Randy Li           2023-07-04  305  	    || !(m2m_ctx->cap_q_ctx.q.streaming
f3e1a4c9d7a02d drivers/media/v4l2-core/v4l2-mem2mem.c Randy Li           2023-07-04  306  		 || m2m_ctx->cap_q_ctx.buffered)) {
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  307  		dprintk("Streaming needs to be on for both queues\n");
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  308  		return;
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  309  	}
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  310  
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  311  	spin_lock_irqsave(&m2m_dev->job_spinlock, flags_job);
2ad5389b341282 drivers/media/v4l2-core/v4l2-mem2mem.c Shaik Ameer Basha  2013-09-20  312  
2ad5389b341282 drivers/media/v4l2-core/v4l2-mem2mem.c Shaik Ameer Basha  2013-09-20  313  	/* If the context is aborted then don't schedule it */
2ad5389b341282 drivers/media/v4l2-core/v4l2-mem2mem.c Shaik Ameer Basha  2013-09-20  314  	if (m2m_ctx->job_flags & TRANS_ABORT) {
2ad5389b341282 drivers/media/v4l2-core/v4l2-mem2mem.c Shaik Ameer Basha  2013-09-20  315  		dprintk("Aborted context\n");
cbec2836f8be61 drivers/media/v4l2-core/v4l2-mem2mem.c Sakari Ailus       2018-10-18  316  		goto job_unlock;
2ad5389b341282 drivers/media/v4l2-core/v4l2-mem2mem.c Shaik Ameer Basha  2013-09-20  317  	}
2ad5389b341282 drivers/media/v4l2-core/v4l2-mem2mem.c Shaik Ameer Basha  2013-09-20  318  
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  319  	if (m2m_ctx->job_flags & TRANS_QUEUED) {
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  320  		dprintk("On job queue already\n");
cbec2836f8be61 drivers/media/v4l2-core/v4l2-mem2mem.c Sakari Ailus       2018-10-18  321  		goto job_unlock;
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  322  	}
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  323  
cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  324) 	if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  325  		src = v4l2_m2m_next_src_buf(m2m_ctx);
cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  326) 
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  327  		if (!src && !m2m_ctx->out_q_ctx.buffered) {
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  328  			dprintk("No input buffers available\n");
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  329  			goto job_unlock;
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  330  		}
cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  331) 	}

src uninitialized on else path.

cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  332) 
cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  333) 	if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  334) 		dst = v4l2_m2m_next_dst_buf(m2m_ctx);
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  335  		if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
7f98639def42a6 drivers/media/video/v4l2-mem2mem.c     Pawel Osciak       2010-04-23  336  			dprintk("No output buffers available\n");
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  337  			goto job_unlock;
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  338  		}
cafbe530b02613 drivers/media/v4l2-core/v4l2-mem2mem.c Hsia-Jun(Randy  Li 2023-07-04  339) 	}

dst not initialized if !list_empty()

f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  340  
f07602ac388723 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  341  	m2m_ctx->new_frame = true;
f07602ac388723 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  342  
f07602ac388723 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11 @343  	if (src && dst && dst->is_held &&

Uninitialized.

f07602ac388723 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  344  	    dst->vb2_buf.copied_timestamp &&
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  345  	    dst->vb2_buf.timestamp != src->vb2_buf.timestamp) {
86ef61ad686c17 drivers/media/v4l2-core/v4l2-mem2mem.c Nicolas Dufresne   2022-04-26  346  		dprintk("Timestamp mismatch, returning held capture buffer\n");
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  347  		dst->is_held = false;
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  348  		v4l2_m2m_dst_buf_remove(m2m_ctx);
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  349  		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_DONE);
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  350  		dst = v4l2_m2m_next_dst_buf(m2m_ctx);
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  351  
f8cca8c97a63d7 drivers/media/v4l2-core/v4l2-mem2mem.c Hans Verkuil       2019-10-11  352  		if (!dst && !m2m_ctx->cap_q_ctx.buffered) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

