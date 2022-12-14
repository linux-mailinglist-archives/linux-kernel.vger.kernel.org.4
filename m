Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6299664D0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLNUGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLNUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:04:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F5303D0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FCkmKp6qRdzY4218z4Qz5n+H1gb6si/dZrIGWhAOD+4=; b=XJFCP3G4532SsqnxWYSLuQzarv
        t1bZPK+0E3nbXA1g+EMo22YjF4fORvKqH49lpnkiYB7oN3NuLQsWewuKPz8+UKxv2fBvOC9sCsEa8
        oQS64dKZSIYL3xyKqviULqT3LAppShx3A1JJ8hr0Gx3BqxhcVZcVztjXV7V+hOvnoYoM6INWIzART
        ClENptA9GIrKA++8nbfYDnLQnLxEkW1ltLCUkiQI7S9Jjo326tU/4nh9Up6AMzkyoBfg1RBcKn1C1
        8Z6VVZ0G6XP3sRObNfH186VUAL3KJx8y76oiPzK8DK/WG6OOCuFUtZdA7SQw76Dj2f1A3b/BnlR9L
        Mko8w2Fg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5Xup-002P2m-O8; Wed, 14 Dec 2022 19:59:43 +0000
Date:   Wed, 14 Dec 2022 11:59:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com,
        syzbot+c92c6a251d49ceceb625@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] umh: fix out of scope usage when the process is being
 killed
Message-ID: <Y5orL90JpH6LUd4D@bombadil.infradead.org>
References: <20221214134656.21228-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214134656.21228-1-schspa@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 09:46:56PM +0800, Schspa Shi wrote:
> When the process is killed, wait_for_completion_state will return with
> -ERESTARTSYS, and the completion variable in the stack will be unavailable,
> even freed. If the user-mode thread is complete at the same time, there
> will be a race to use a unavailable variable.
> 
> Please refer to the following scenarios.
>             T1                                  T2
> ------------------------------------------------------------------
> call_usermodehelper_exec
>                                    call_usermodehelper_exec_async
>                                    << do something >>
>                                    umh_complete(sub_info);
>                                    comp = xchg(&sub_info->complete, NULL);
>                                    /* we got the completion */
>                                    << context switch >>
> 
>     << Being killed >>
> 	retval = wait_for_completion_state(sub_info->complete, state);
> 	if (!retval)
> 		goto wait_done;
> 
> 	if (wait & UMH_KILLABLE) {
> 		/* umh_complete() will see NULL and free sub_info */
> 		if (xchg(&sub_info->complete, NULL))
> 			goto unlock;
>         << we can't got the completion, because T2 take it already >>
> 	}
> 	....
> 	return retval;
> }
> 
> /**
>  * the completion variable in stack is end of life cycle.
>  * and maybe freed due to process is recycled.
>  */
>                                    -------- BUG here----------
>                                    if (comp)
>                                        complete(comp);
> 
> To fix it, we can add an additional wait_for_completion to ensure the
> completion object is completely unused. And this is what
> kthread_create_on_node does to handle this race.
> 
> Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
> Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
> Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
> Reported-by: syzbot+c92c6a251d49ceceb625@syzkaller.appspotmail.com
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---

Please fix the commit log a bit more with the cotext I provided, *if*
on the other thread the community agrees with the approach to be
compartamentalized. I am still not sure why this would fix the
UAF after thinking about it some more, and the issue would mean
there likely could be a generic fix / issue to consider.

So for now I'd like more review of this race and the proposed fix
as I mentioned in the follow-up threaad in your v1 patch. Let's
follow up there and see how that discussion goes.

  Luis
