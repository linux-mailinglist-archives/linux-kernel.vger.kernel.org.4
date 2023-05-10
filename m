Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369EC6FE46C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjEJTQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjEJTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:16:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512D4EE8;
        Wed, 10 May 2023 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0Z07kJM8D8m5d5kKwLUHNNFE7+72EIHO1gqBnUjzXog=;
        t=1683746172; x=1684955772; b=QplBH4kyZn2y5tVuthkVAzha52SVEDfrgYu4eN8qGOrLSTw
        iZupeyF9iSJlb1cKx+sevHT0N82zI+j8/JgkEwWByBk5cJBywKviybwOpNkNELlvxGLOkRdJfYNah
        Hcv4MoMVOzK/JuaAe4ec6iBmgHyHvcivW5b5qKBrInB08CsV9Ks2raZqhSmSMwB4xd/kHP1ABi21f
        vrl8YCbSM+/ZZcIHQV+3JgtT7VdiIGC3Xn437imOcjBcISaZMS0Qh2ZafByFg65uw9fEyvZ12N9Lm
        PAqDnyQnMysBeM2QBGjMVksEBPrbu188FOZofjdSvLytkpOmon+wtHTCk9SzxxHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwpII-005Z6D-1q;
        Wed, 10 May 2023 21:16:10 +0200
Message-ID: <0c44265eae421eff49e19be3ebfe20d1fb5e6f9a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/4] workqueue: support holding a mutex for each work
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 10 May 2023 21:16:09 +0200
In-Reply-To: <ZFvjoUtg2ax11UlC@slm.duckdns.org>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
         <20230510175846.cc21c84b0e6b.I9d3df459c43a78530d9c2046724bb45626402d5f@changeid>
         <ZFvjoUtg2ax11UlC@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-10 at 08:34 -1000, Tejun Heo wrote:
> On Wed, May 10, 2023 at 06:04:26PM +0200, Johannes Berg wrote:
> > @@ -2387,7 +2389,13 @@ __acquires(&pool->lock)
> >  	 */
> >  	lockdep_invariant_state(true);
> >  	trace_workqueue_execute_start(work);
> > -	worker->current_func(work);
> > +	if (unlikely(pwq->wq->work_mutex)) {
> > +		mutex_lock(pwq->wq->work_mutex);
> > +		worker->current_func(work);
> > +		mutex_unlock(pwq->wq->work_mutex);
> > +	} else {
> > +		worker->current_func(work);
> > +	}
>=20
> Ah, I don't know about this. This can't be that difficult to do from the
> callee side, right?
>=20

Yeah I thought you'd say that :)

It isn't difficult, the issue is just that in the case I'm envisioning,
you can't just call wiphy_lock() since that would attempt to pause the
workqueue, which can't work from on the workqueue itself. So you need
wiphy_lock_from_work()/wiphy_unlock_from_work() or remember to use the
mutex directly there, which all seemed more error-prone and harder to
maintain.

But anyway I could easily implement _both_ of these in cfg80211
directly, with just a linked list of works and a single struct
work_struct to execute things on the list, with the right locking. That
might be easier overall, just at the expense of more churn while
converting, but that's not even necessarily _bad_, it would really
guarantee that we can tell immediately the work is properly done...

I'll play with that idea some, I guess. Would you still want the
pause/resume patch anyway, even if I end up not using it then?

johannes
