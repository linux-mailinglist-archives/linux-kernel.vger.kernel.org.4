Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE86FE41A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjEJSkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:40:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857104201;
        Wed, 10 May 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vBdg4zxYUrbXCFCRshyT5+tUR96jSZjDJZ3sV6u94yQ=;
        t=1683744037; x=1684953637; b=nfyJLZs/a1PasazzH0IcJPClPaf94KGVsemZYlHBmh7s4jS
        vhDTw8BFZer8aq6a8pzVUYKQ8RJWjXaHmZm7fkFRPPJ4+I0Sl7QYBf6MvTP2BarVBeRjN2wstXOgE
        QJqpxOa9yBRFEtGmgAeNabd/eokwlJWWI7YHdM6ofbHPG3ZtspMDz2z4ErJPSYbHYREC1L5rSmmRJ
        H8QkRA5SMASogPSgr2pEqLVrIFW96lmLil3+j8GaZ7kS26vwCUb9jd4A5Jw7QGuRqj1+NX3yuVc6/
        h/FZ/Tm9bw2+eY7L5gZiwlI7YYNTYT61mh1i77/mPyk9d0bi/77GmkqjLFawI6Aw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwojq-005YQp-0u;
        Wed, 10 May 2023 20:40:34 +0200
Message-ID: <f8bfe27a4eed789f97143246fb7d1c0756c2cd35.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/4] workqueue: support pausing ordered workqueues
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 10 May 2023 20:40:33 +0200
In-Reply-To: <ZFvjahvVPqWH0XBR@slm.duckdns.org>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
         <20230510175846.85cb30389c22.Ia49f779e11c2814294ea7f8bb29f825fb840be51@changeid>
         <ZFvjahvVPqWH0XBR@slm.duckdns.org>
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

Hi,

> > -	/* for @wq->saved_max_active */
> > +	/* for @wq->saved_max_active and @wq->flags */
> >  	lockdep_assert_held(&wq->mutex);
> > =20
> > +	if (wq->flags & __WQ_PAUSED)
> > +		new_max_active =3D 0;
> > +	else
> > +		new_max_active =3D wq->saved_max_active;
>=20
> Nothing is using new_max_active and I think we can probably combine this
> with the freezing test.

Err, yikes. Of course this was meant to be used in the remainder of the
code, oops.

Regarding the freezing test, yeah, maybe. It seemed harder to follow,
but I'll take another look.

> > +void __workqueue_pause_resume(struct workqueue_struct *wq, bool pause)
> > +{
> > +	struct pool_workqueue *pwq;
> > +
> > +	mutex_lock(&wq->mutex);
> > +	if (pause)
> > +		wq->flags |=3D __WQ_PAUSED;
> > +	else
> > +		wq->flags &=3D ~__WQ_PAUSED;
> > +
> > +	for_each_pwq(pwq, wq)
> > +		pwq_adjust_max_active(pwq);
> > +	mutex_unlock(&wq->mutex);
> > +
> > +	if (pause)
> > +		flush_workqueue(wq);
> > +}
> > +EXPORT_SYMBOL_GPL(__workqueue_pause_resume);
>=20
> I'd just make pause and resume separate functions. The sharing ratio does=
n't
> seem that high.
>=20

Yeah, I wasn't really sure about that either. I keep thinking the
EXPORT_SYMBOL_GPL() itself is really big, but I'm not even sure about
that, and it's probably not a great reason anyway.

johannes
