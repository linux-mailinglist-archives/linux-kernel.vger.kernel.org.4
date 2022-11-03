Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B0617907
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:47:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B50D115;
        Thu,  3 Nov 2022 01:47:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 645A81F900;
        Thu,  3 Nov 2022 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667465265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UFonw8deFLmtRHNYH88DPQPqP/PgWsObLPhXUH/f0A=;
        b=R96pGX9gZDxTVYt1z/U805Y6gh5WdSMcAqF6csDart8vuTnWVlopmGmqNfpV6SsdtEIAVu
        H5oJ4LIXzCa/QRcNJY6OVU+0UquwfCPeFmLpsUVkoNVg8vrsyt4XEGdE6n5ApGMRimf1Sk
        hJHHl+JWv3WpXmoxkOPD8TRDL28yK/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667465265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UFonw8deFLmtRHNYH88DPQPqP/PgWsObLPhXUH/f0A=;
        b=zvqPxzF2hrdvtsfA/r9PYM+HWJqahq54o2e9Zq4/3dXU50jFf37w74Ez5nboCyEk0H8TQJ
        odW/TWDs7lW6zDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5247D13480;
        Thu,  3 Nov 2022 08:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B/MJFDGAY2NXRAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Nov 2022 08:47:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7C0DA0700; Thu,  3 Nov 2022 09:47:44 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:47:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Khazhy Kumykov <khazhy@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
Message-ID: <20221103084744.xsvoul3hjgz7yyo7@quack3>
References: <20221103013937.603626-1-khazhy@google.com>
 <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
 <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
 <f83404b4-84a4-de4e-fa4d-9ce38900d91c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f83404b4-84a4-de4e-fa4d-9ce38900d91c@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-11-22 11:51:15, Yu Kuai wrote:
> Hi,
> 
> 在 2022/11/03 11:05, Khazhy Kumykov 写道:
> > On Wed, Nov 2, 2022 at 7:56 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > > 
> > > Hi,
> > > 
> > > 在 2022/11/03 9:39, Khazhismel Kumykov 写道:
> > > > This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> > > > but woken_list_node still being hashed. This would happen when
> > > > bfq_init_rq() expects a brand new allocated queue to be returned from
> > > 
> > >   From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() only if
> > > 'new_queue' is false, but if 'new_queue' is false, the returned 'bfqq'
> > > from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm confused
> > > here...
> > There's two calls for bfq_get_bfqq_handle_split in this function - the
> > second one is after the check you mentioned, and is the problematic
> > one.
> Yes, thanks for the explanation. Now I understand how the problem
> triggers.
> 
> > > 
> > > > bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> > > > without resetting woken_list_node. Since we can always return oom_bfqq
> > > > when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
> > > > We must either reset woken_list_node, or avoid setting woken_list at all
> > > > for oom_bfqq - opt to do the former.
> > > 
> > > Once oom_bfqq is used, I think the io is treated as issued from root
> > > group. Hence I don't think it's necessary to set woken_list or
> > > waker_bfqq for oom_bfqq.
> > Ack, I was wondering what's right here since, evidently, *someone* had
> > already set oom_bfqq->waker_bfqq to *something* (although... maybe it
> > was an earlier init_rq). But maybe it's better to do nothing if we
> > *know* it's oom_bfqq.
> 
> I need to have a check how oom_bfqq get involved with waker_bfqq, and
> then see if it's reasonable.
> 
> Probably Jan and Paolo will have better view on this.

Thanks for the CC Kuai and thanks to Khazy for spotting the bug. The
oom_bfqq is just a fallback bfqq and as such it should be extempted from
all special handling like waker detection etc. All this stuff is just for
optimizing performance and when we are OOM, we have far larger troubles
than to optimize performance.

So how I think we should really fix this is that we extempt oom_bfqq from
waker detection in bfq_check_waker() by adding:

	bfqq == bfqd->oom_bfqq ||
 	bfqd->last_completed_rq_bfq == bfqd->oom_bfqq)

to the initial check and then also if bfq_get_bfqq_handle_split() returns
oom_bfqq we should just skip carrying over the waker information.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
