Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37B05EAB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiIZPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiIZPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:35:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2052BD5;
        Mon, 26 Sep 2022 07:22:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86AD621DE7;
        Mon, 26 Sep 2022 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664202163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJkZDjy/KJG4g79nuq4rNvIMTooiCGdK5D6wYt+vH6M=;
        b=lFW6m7fDWwkDlsc8p3+YE8ZER9ICzyao0BJsIYNgpBlerDjeu3//ld0lz3tp01uUTbaqnE
        M1/5EUxAkuEWUSnU0p+JcBlNgRt+Foq7jzAlE8WkbJ+7vfGb+rfndb1qn9zJTLXjhpUqro
        ljMR9XSEYk9alGcrjxDDM+TvZHAJvgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664202163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJkZDjy/KJG4g79nuq4rNvIMTooiCGdK5D6wYt+vH6M=;
        b=OehuH9lA4EzqkbhclJAYY9irT6NtjjWBVo1V8RodKvIirhYLJ23leFn7FG0UwGCPksmLfl
        y+G/zrf8jCduaqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76B84139BD;
        Mon, 26 Sep 2022 14:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RQfuHLO1MWMkCAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 14:22:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06585A0685; Mon, 26 Sep 2022 16:22:43 +0200 (CEST)
Date:   Mon, 26 Sep 2022 16:22:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v3 3/5] block, bfq: don't disable wbt if
 CONFIG_BFQ_GROUP_IOSCHED is disabled
Message-ID: <20220926142242.mxrkbs63ynmhulib@quack3>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-4-yukuai3@huawei.com>
 <Yy10vjnxAvca8Ee1@infradead.org>
 <988a86f2-e960-ba59-4d41-f4c8a6345ee9@huaweicloud.com>
 <20220923100659.a3atdanlvygffuxt@quack3>
 <95998ae6-8bbf-b438-801b-7033ceaf9c36@huaweicloud.com>
 <20220923110354.czvzm6rjm7mtqyh3@quack3>
 <5a2dba26-529d-295f-2e88-601475ff67bf@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2dba26-529d-295f-2e88-601475ff67bf@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuai!

On Mon 26-09-22 21:00:48, Yu Kuai wrote:
> 在 2022/09/23 19:03, Jan Kara 写道:
> > Hi Kuai!
> > 
> > On Fri 23-09-22 18:23:03, Yu Kuai wrote:
> > > 在 2022/09/23 18:06, Jan Kara 写道:
> > > > On Fri 23-09-22 17:50:49, Yu Kuai wrote:
> > > > > Hi, Christoph
> > > > > 
> > > > > 在 2022/09/23 16:56, Christoph Hellwig 写道:
> > > > > > On Thu, Sep 22, 2022 at 07:35:56PM +0800, Yu Kuai wrote:
> > > > > > > wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED is disabled.
> > > > > > 
> > > > > > Umm, wouldn't this be something decided at runtime, that is not
> > > > > > if CONFIG_BFQ_GROUP_IOSCHED is enable/disable in the kernel build
> > > > > > if the hierarchical cgroup based scheduling is actually used for a
> > > > > > given device?
> > > > > > .
> > > > > > 
> > > > > 
> > > > > That's a good point,
> > > > > 
> > > > > Before this patch wbt is simply disabled if elevator is bfq.
> > > > > 
> > > > > With this patch, if elevator is bfq while bfq doesn't throttle
> > > > > any IO yet, wbt still is disabled unnecessarily.
> > > > 
> > > > It is not really disabled unnecessarily. Have you actually tested the
> > > > performance of the combination? I did once and the results were just
> > > > horrible (which is I made BFQ just disable wbt by default). The problem is
> > > > that blk-wbt assumes certain model of underlying storage stack and hardware
> > > > behavior and BFQ just does not fit in that model. For example BFQ wants to
> > > > see as many requests as possible so that it can heavily reorder them,
> > > > estimate think times of applications, etc. On the other hand blk-wbt
> > > > assumes that if request latency gets higher, it means there is too much IO
> > > > going on and we need to allow less of "lower priority" IO types to be
> > > > submitted. These two go directly against one another and I was easily
> > > > observing blk-wbt spiraling down to allowing only very small number of
> > > > requests submitted while BFQ was idling waiting for more IO from the
> > > > process that was currently scheduled.
> > > > 
> > > 
> > > Thanks for your explanation, I understand that bfq and wbt should not
> > > work together.
> > > 
> > > However, I wonder if CONFIG_BFQ_GROUP_IOSCHED is disabled, or service
> > > guarantee is not needed, does the above phenomenon still exist? I find
> > > it hard to understand... Perhaps I need to do some test.
> > 
> > Well, BFQ implements for example idling on sync IO queues which is one of
> > the features that upsets blk-wbt. That does not depend on
> > CONFIG_BFQ_GROUP_IOSCHED in any way. Also generally the idea that BFQ
> > assigns storage *time slots* to different processes and IO from other
> > processes is just queued at those times increases IO completion
> > latency (for IOs of processes that are not currently scheduled) and this
> > tends to confuse blk-wbt.
> > 
> Hi, Jan
> 
> Just to be curious, have you ever think about or tested wbt with
> io-cost? And even more, how bfq work with io-cost?
> 
> I haven't tested yet, but it seems to me some of them can work well
> together.

No, I didn't test these combinations. I actually expect there would be
troubles in both cases under high IO load but you can try :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
