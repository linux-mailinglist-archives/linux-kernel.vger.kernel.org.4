Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C06A0C82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjBWPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjBWPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:06:34 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20A4BEB4;
        Thu, 23 Feb 2023 07:06:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB17368AA6; Thu, 23 Feb 2023 16:06:24 +0100 (CET)
Date:   Thu, 23 Feb 2023 16:06:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Xiongfeng Wang <wangxiongfeng@huaweicloud.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com,
        liwei391@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] blk-mq: avoid housekeeping CPUs scheduling a
 worker on a non-housekeeping CPU
Message-ID: <20230223150624.GA29739@lst.de>
References: <20230223074826.3782643-1-wangxiongfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223074826.3782643-1-wangxiongfeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 03:48:26PM +0800, Xiongfeng Wang wrote:
> From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 
> When NOHZ_FULL is enabled, such as in HPC situation, CPUs are divided
> into housekeeping CPUs and non-housekeeping CPUs. Non-housekeeping CPUs
> are NOHZ_FULL CPUs and are often monopolized by the userspace process,
> such HPC application process. Any sort of interruption is not expected.
> 
> blk_mq_hctx_next_cpu() selects each cpu in 'hctx->cpumask' alternately
> to schedule the work thread blk_mq_run_work_fn(). When 'hctx->cpumask'
> contains housekeeping CPU and non-housekeeping CPU at the same time, a
> housekeeping CPU, which want to request a IO, may schedule a worker on a
> non-housekeeping CPU. This may affect the performance of the userspace
> application running on non-housekeeping CPUs.
> 
> So let's just schedule the worker thread on the current CPU when the
> current CPU is housekeeping CPU.

This looks like an odd non-systemic bandaid.  Shouldn't we have a more
generic way nothing ever gets onto these non-housekeeping CPUs by making
sure they never show up in the cpumask, and never get completion IPIs?
