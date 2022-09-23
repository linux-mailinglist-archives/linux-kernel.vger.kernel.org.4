Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA735E77EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiIWKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiIWKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:07:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17305130BFA;
        Fri, 23 Sep 2022 03:07:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4096218E8;
        Fri, 23 Sep 2022 10:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663927619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMdcdOsH5eC9P7+pCY0O8BDD90h3b612fG2OlMOgXMQ=;
        b=v2A7XK0l1t/WR+9qbMgG757E3WEq3VcPJUpiNVSzeZJqF6VLorMQfkabqLVLJfBEPR33H6
        KtaO93opn9aeeGX0bpkohQ5Rm9e7CIhzRkaOIG+bkyQARl0nvu0MYmEVHRAXvIxf5Rq22p
        YWSnRz71kCNcvEIEtmBWLOKNepmrft4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663927619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMdcdOsH5eC9P7+pCY0O8BDD90h3b612fG2OlMOgXMQ=;
        b=jvNopTvNpZpAY3T0srw1fBkYWITj5MqZV98EhjkrNUek5bVlMghvt/CZYpO4JZoXpBBjMH
        7HZe/caLBG1jMPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9442013A00;
        Fri, 23 Sep 2022 10:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOYvJEOFLWPpNQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 10:06:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 211A1A0685; Fri, 23 Sep 2022 12:06:59 +0200 (CEST)
Date:   Fri, 23 Sep 2022 12:06:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, jack@suse.cz,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v3 3/5] block, bfq: don't disable wbt if
 CONFIG_BFQ_GROUP_IOSCHED is disabled
Message-ID: <20220923100659.a3atdanlvygffuxt@quack3>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-4-yukuai3@huawei.com>
 <Yy10vjnxAvca8Ee1@infradead.org>
 <988a86f2-e960-ba59-4d41-f4c8a6345ee9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <988a86f2-e960-ba59-4d41-f4c8a6345ee9@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-09-22 17:50:49, Yu Kuai wrote:
> Hi, Christoph
> 
> 在 2022/09/23 16:56, Christoph Hellwig 写道:
> > On Thu, Sep 22, 2022 at 07:35:56PM +0800, Yu Kuai wrote:
> > > wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED is disabled.
> > 
> > Umm, wouldn't this be something decided at runtime, that is not
> > if CONFIG_BFQ_GROUP_IOSCHED is enable/disable in the kernel build
> > if the hierarchical cgroup based scheduling is actually used for a
> > given device?
> > .
> > 
> 
> That's a good point,
> 
> Before this patch wbt is simply disabled if elevator is bfq.
> 
> With this patch, if elevator is bfq while bfq doesn't throttle
> any IO yet, wbt still is disabled unnecessarily.

It is not really disabled unnecessarily. Have you actually tested the
performance of the combination? I did once and the results were just
horrible (which is I made BFQ just disable wbt by default). The problem is
that blk-wbt assumes certain model of underlying storage stack and hardware
behavior and BFQ just does not fit in that model. For example BFQ wants to
see as many requests as possible so that it can heavily reorder them,
estimate think times of applications, etc. On the other hand blk-wbt
assumes that if request latency gets higher, it means there is too much IO
going on and we need to allow less of "lower priority" IO types to be
submitted. These two go directly against one another and I was easily
observing blk-wbt spiraling down to allowing only very small number of
requests submitted while BFQ was idling waiting for more IO from the
process that was currently scheduled.

So I'm kind of wondering why you'd like to use blk-wbt and BFQ together...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
