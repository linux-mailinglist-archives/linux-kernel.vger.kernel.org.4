Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87EE5E7904
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiIWLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiIWLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:03:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6ABAF4B6;
        Fri, 23 Sep 2022 04:03:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0982F21A58;
        Fri, 23 Sep 2022 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663931035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GU8qV+B2ZKvUdTAXMobiB6JH0oB4dT1GnLJpPgO8j64=;
        b=Zy0kQhA9dNgG4p5J0GwslHwxTpOi46lHulcx3VTmQ3u3fif2Nxpl1F/7eGW8y3ND/hfc0j
        9YaPTK5lH4Zd+YyHhrFgtioymOHSbgiODEAbM6JvohZuDEt2v5IlucDMoQaKVB+3Lbraht
        Wyc4ayvbXmJEhKMVKe2DRlIiT53+En0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663931035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GU8qV+B2ZKvUdTAXMobiB6JH0oB4dT1GnLJpPgO8j64=;
        b=S1tgiVO89dhDZmOvNBH246l5lGk4b4mL1cQQarAoo830ItGFZXQD4MgRTpOO1Fa42ZX/bV
        xraaLnNuQsmATMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA19913AA5;
        Fri, 23 Sep 2022 11:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mDvFOJqSLWPaTgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 11:03:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6D239A0685; Fri, 23 Sep 2022 13:03:54 +0200 (CEST)
Date:   Fri, 23 Sep 2022 13:03:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v3 3/5] block, bfq: don't disable wbt if
 CONFIG_BFQ_GROUP_IOSCHED is disabled
Message-ID: <20220923110354.czvzm6rjm7mtqyh3@quack3>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-4-yukuai3@huawei.com>
 <Yy10vjnxAvca8Ee1@infradead.org>
 <988a86f2-e960-ba59-4d41-f4c8a6345ee9@huaweicloud.com>
 <20220923100659.a3atdanlvygffuxt@quack3>
 <95998ae6-8bbf-b438-801b-7033ceaf9c36@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95998ae6-8bbf-b438-801b-7033ceaf9c36@huaweicloud.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuai!

On Fri 23-09-22 18:23:03, Yu Kuai wrote:
> 在 2022/09/23 18:06, Jan Kara 写道:
> > On Fri 23-09-22 17:50:49, Yu Kuai wrote:
> > > Hi, Christoph
> > > 
> > > 在 2022/09/23 16:56, Christoph Hellwig 写道:
> > > > On Thu, Sep 22, 2022 at 07:35:56PM +0800, Yu Kuai wrote:
> > > > > wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED is disabled.
> > > > 
> > > > Umm, wouldn't this be something decided at runtime, that is not
> > > > if CONFIG_BFQ_GROUP_IOSCHED is enable/disable in the kernel build
> > > > if the hierarchical cgroup based scheduling is actually used for a
> > > > given device?
> > > > .
> > > > 
> > > 
> > > That's a good point,
> > > 
> > > Before this patch wbt is simply disabled if elevator is bfq.
> > > 
> > > With this patch, if elevator is bfq while bfq doesn't throttle
> > > any IO yet, wbt still is disabled unnecessarily.
> > 
> > It is not really disabled unnecessarily. Have you actually tested the
> > performance of the combination? I did once and the results were just
> > horrible (which is I made BFQ just disable wbt by default). The problem is
> > that blk-wbt assumes certain model of underlying storage stack and hardware
> > behavior and BFQ just does not fit in that model. For example BFQ wants to
> > see as many requests as possible so that it can heavily reorder them,
> > estimate think times of applications, etc. On the other hand blk-wbt
> > assumes that if request latency gets higher, it means there is too much IO
> > going on and we need to allow less of "lower priority" IO types to be
> > submitted. These two go directly against one another and I was easily
> > observing blk-wbt spiraling down to allowing only very small number of
> > requests submitted while BFQ was idling waiting for more IO from the
> > process that was currently scheduled.
> > 
> 
> Thanks for your explanation, I understand that bfq and wbt should not
> work together.
> 
> However, I wonder if CONFIG_BFQ_GROUP_IOSCHED is disabled, or service
> guarantee is not needed, does the above phenomenon still exist? I find
> it hard to understand... Perhaps I need to do some test.

Well, BFQ implements for example idling on sync IO queues which is one of
the features that upsets blk-wbt. That does not depend on
CONFIG_BFQ_GROUP_IOSCHED in any way. Also generally the idea that BFQ
assigns storage *time slots* to different processes and IO from other
processes is just queued at those times increases IO completion
latency (for IOs of processes that are not currently scheduled) and this
tends to confuse blk-wbt.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
