Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4985BD7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiISXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiISXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:02:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996CE43E50
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:01:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c11so609716qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=xixo44lTcERHPiUV64xTDRqasHw9DlQyVVg8mpJU9es=;
        b=AgcVBHh0Hw9LMN3EKAyNefT6Y8I8kX0c8Hih+eW5gYpAM+bvvfQMe4A3kV5CH89Fzq
         0gQQDRzPET7tFaAMhsDE9ZzQA5NhHbKpj7bed/yRGTBX0hETdK9Gf9pHdAZknnFA9yRj
         SHnp0B0Us1AUQUod4cBI4+D316FWpO/dKexSTqaQPCZiiEpYhLekHLbITzKvDzNJl4Bx
         lo1nvff+zjopDK3RHPeWBq/xC+Q/nZIt05shBR2esadkg7leu8eUMq695diDosIWpat5
         jHEP4W3/hXbE0dfpXOGP/EYHzY8r18TZS+El7G3hVR3IxIxIjOC8B0XkVV9Qvt/Gwyy0
         52DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xixo44lTcERHPiUV64xTDRqasHw9DlQyVVg8mpJU9es=;
        b=DAkHhUpIS8nmGLRk0hlg21ARVUCQUaDP1nht4QUiKyA01//pneh42lf6JfCPZ9bcOd
         qMu7fF2EhMnOpqfcGHSvNUOKSw3wE7TV6YkOF6k9ipprOuC74ae7k36Z/FnY8r/mc5ov
         bP8LcvoY3ptTLUTkI8mBjPn18DF8RtuoMZpcrQEQGfL6qj3rTB12wcjzKslJ/HWa4+ch
         IgnF/ItWnWBicAqKW3n5YW5kn7Ml/igJfU9XvYtofRuq4m6L07cdq+oOovWy6EnYtCk1
         WtoXt73g2ytGk7pF7ugGwBLi7a4j9uOSClX3Qr7q1wZK6EipsSJSE9c6LvJCiUTKmTmI
         yv9A==
X-Gm-Message-State: ACrzQf3yU0RX2xfbz3KXNrXY7VFIzWGSHc0G1sOfcqaR6cGK4XQ8hF8d
        /T8xWY9UJSRgxsuLSR6BjIBX2g==
X-Google-Smtp-Source: AMsMyM4ouUmlUEH1L7eYlmBEN7b4vAmMYcNn5lPDnA9AHYvbCCciVxwIStA540FoBADTcmr54usBmg==
X-Received: by 2002:a05:622a:1015:b0:35c:e915:3b61 with SMTP id d21-20020a05622a101500b0035ce9153b61mr6086559qte.572.1663628518654;
        Mon, 19 Sep 2022 16:01:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cc19-20020a05622a411300b0031e9ab4e4cesm8099175qtb.26.2022.09.19.16.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:01:57 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:01:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Keith Busch <kbusch@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <YyjdiKC0YYUkI+AI@kbusch-mbp>
Message-ID: <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022, Keith Busch wrote:
> On Sun, Sep 18, 2022 at 02:10:51PM -0700, Hugh Dickins wrote:
> > I have almost no grasp of all the possible sbitmap races, and their
> > consequences: but using the same !waitqueue_active() check as used
> > elsewhere, fixes the lockup and shows no adverse consequence for me.
> 
>  
> > Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > 
> >  lib/sbitmap.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
> >  		 * function again to wakeup a new batch on a different 'ws'.
> >  		 */
> >  		if (cur == 0)
> > -			return true;
> > +			return !waitqueue_active(&ws->wait);
> 
> If it's 0, that is supposed to mean another thread is about to make it not zero
> as well as increment the wakestate index. That should be happening after patch
> 48c033314f37 was included, at least.

I believe that the thread about to make wait_cnt not zero (and increment the
wakestate index) is precisely this interrupted thread: the backtrace shows
that it had just done its wakeups, so has not yet reached making wait_cnt
not zero; and I suppose that either its wakeups did not empty the waitqueue
completely, or another waiter got added as soon as it dropped the spinlock.

> 
> Prior to 4acb83417cad, the code would also return 'true' if the count was
> already zero, and this batched code wasn't supposed to behave any different in
> that condition.

In principle yes, but in practice no.  Prior to 4acb83417cad, the swapping
load would run okayish for a few minutes, before freezing up mysteriously
(presumably due to missed wakeups).  The "ish" in "okayish" because the
system time was abnormally high, and occasionally there was an odd message
from systemd about killing its journal or something - 4acb83417cad saved
me from having to investigate that further.

Prior to 4acb83417cad, it never locked up looping on wait_cnt < 0;
after 4acb83417cad, it would lock up on wait_cnt 0 in a few seconds.

But in writing that, and remembering the abnormal systime, I begin to
suspect that it might have often been in a tight loop on wait_cnt < 0,
but the batch accounting sufficiently wrong that it always got rescued
by an unrelated wakeup (shifting wakestate index), before any lockup
ever got observed and reported.  Or something like that.

(And I'm trying to avoid making a fool of myself with the arithmetic:
how quickly would wait_cnt 0 have got decremented to positive before?)

I won't mind Jens deleting that "Fixes: 4acb83417cad" if it's unfair.

> 
> Anyway, I don't think the waitqueue_active criteria of the current waitstate is
> correct either. The next waitstate may have waiters too, so we still may need
> to account for this batch's count in order to wake them.

I cannot usefully comment on that, it's all rather too subtle for me.

But I did wonder if each of those !waitqueue_active()s would be better
replaced just by "false"s: we only get that far into __sbq_wake_up() if
waitqueue_active(), so the !waitqueue_active() case reflects a race:
a possible race, yes, but a race that wants precise accounting at a
few imprecise locations?

Hugh
