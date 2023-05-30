Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5A716433
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjE3ObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjE3Oao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:30:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DEFB2;
        Tue, 30 May 2023 07:30:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD43668BEB; Tue, 30 May 2023 16:29:45 +0200 (CEST)
Date:   Tue, 30 May 2023 16:29:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next] block: fix blktrace debugfs entries leak
Message-ID: <20230530142945.GA9553@lst.de>
References: <20230511065633.710045-1-yukuai1@huaweicloud.com> <20230511152808.GA8641@lst.de> <18db3894-d128-7857-4c11-25b59d82ff54@huaweicloud.com> <e26d37bc-0f09-426a-ef25-57bdbd716ae9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26d37bc-0f09-426a-ef25-57bdbd716ae9@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:07:54AM +0800, Yu Kuai wrote:
>> If we don't care about blktrace for passthrough io after del_gendisk(),
>> and /dev/sg* has separate handling, I think it's better just to check
>> QUEUE_FLAG_REGISTERED in blk_trace_setup(), and don't enable blktrace
>> in the first place.
>
> Any suggestions about this problem? Should we use separate handling for
> /dev/sd? Or just free blktrace in blk_free_queue().

I'd be fine with trying to either remove the /dev/sg blktrace handling
and / or splitting it up so that it doesn't interact with the main disk
based one.  I can look into this if you want, or leave it to you.
