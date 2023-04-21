Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0155A6EA70D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjDUJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDUJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4DA279
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682069635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJhAG7KLrQIyCIYtC4H5+v+ahAQygO0tBJ1SJ1pUhIo=;
        b=NfAc81Y1nn0QZizpAKsaYXUB4amq9IPV9QB1E1UdMgHbRWqKcZt4g5BBk9eAGsILZRItsO
        eBk4F5w42KHgwrK70mF+ue3yaNRt3bZAXNArbUEwrRBcmf8ux1k2tanznP+4vPZB20oJEx
        JBf1NYCkfTiSQG0BVpG6Pg+d9kpMlIM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-AaDduvgWMf-Xp34siBtRtQ-1; Fri, 21 Apr 2023 05:33:54 -0400
X-MC-Unique: AaDduvgWMf-Xp34siBtRtQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f17352d605so2483815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682069632; x=1684661632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJhAG7KLrQIyCIYtC4H5+v+ahAQygO0tBJ1SJ1pUhIo=;
        b=aWg/ovivxUV/6cetWaPiwQ31TMGfvYYI0o52ZtQI5oPZhKgBGgXBcYMfCCMHETh1nM
         2tiAfOm1JWsQ/0Ake5i0/DPoxDVsOAIgKvZsO5uV/gelkBmhhthvchuSsF4Q+YzUIMyz
         tVgPXo1ThGvUL1ckPzblm0TSlJE5psyCIidip2FeSjBcPE9KDH/ycH76lXRY/aZNl7/9
         SUlpm4hsDH/wJacolMZN0gV+6r/5Xg52QZbOHuwTjL7AQ5ki5wf02kUczYC1d4zurVKQ
         PzRl45rfTUuFRMCRsNW8lT9kW/xhXcBKsdLxTM0PeQY/MZwPLED3kKNiLc1B/FYrG/G5
         UtWQ==
X-Gm-Message-State: AAQBX9caDrJFIKKMt/UcEwJkkppJe7nGvAvd1yy6J87K4vT57Qd5TPep
        EBazJFvmEN6WXZP3Qt3CAcpQVPayk3NARzR3caDW/vZgoFPTktQjQ5O6qTQWW6YCtnuy+PdGS6f
        F9IMMPXWCnaumzlScM6Sxq9QH
X-Received: by 2002:a5d:4fcd:0:b0:2f8:dbb3:2d0c with SMTP id h13-20020a5d4fcd000000b002f8dbb32d0cmr2932429wrw.3.1682069632297;
        Fri, 21 Apr 2023 02:33:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350bngVI6k35Y1erEbkmqF5ImHBPhkwg8z+stDsUh6EEPcNxQXbo8aVwOHndloK9X2IEypbGfpw==
X-Received: by 2002:a5d:4fcd:0:b0:2f8:dbb3:2d0c with SMTP id h13-20020a5d4fcd000000b002f8dbb32d0cmr2932414wrw.3.1682069632003;
        Fri, 21 Apr 2023 02:33:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-170.dyn.eolo.it. [146.241.230.170])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b002e51195a3e2sm3994446wrw.79.2023.04.21.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:33:51 -0700 (PDT)
Message-ID: <140f61e2e1fcb8cf53619709046e312e343b53ca.camel@redhat.com>
Subject: Re: [PATCH 0/3] softirq: uncontroversial change
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, peterz@infradead.org,
        tglx@linutronix.de, jstultz@google.com, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Apr 2023 11:33:50 +0200
In-Reply-To: <CAL+tcoBU+UD_8aXkJy95zNzFeOBMQvQE6jj9syiKvOh_wcLrcw@mail.gmail.com>
References: <20221222221244.1290833-1-kuba@kernel.org>
         <305d7742212cbe98621b16be782b0562f1012cb6.camel@redhat.com>
         <CAL+tcoBU+UD_8aXkJy95zNzFeOBMQvQE6jj9syiKvOh_wcLrcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-21 at 10:48 +0800, Jason Xing wrote:
>=20
> > My understanding is that we want to avoid adding more heuristics here,
> > preferring a consistent refactor.
> >=20
> > I would like to propose a revert of:
> >=20
> > 4cd13c21b207 softirq: Let ksoftirqd do its job
> >=20
> > the its follow-ups:
> >=20
> > 3c53776e29f8 Mark HI and TASKLET softirq synchronous
> > 0f50524789fc softirq: Don't skip softirq execution when softirq thread =
is parking
>=20
> More than this, I list some related patches mentioned in the above
> commit 3c53776e29f8:
> 1ff688209e2e ("watchdog: core: make sure the watchdog_worker is not defer=
red")
> 8d5755b3f77b ("watchdog: softdog: fire watchdog even if softirqs do
> not get to run")
> 217f69743681 ("net: busy-poll: allow preemption in sk_busy_loop()")

The first 2 changes replace plain timers with HR ones, could possibly
be reverted, too, but it should not be a big deal either way.

I think instead we want to keep the third commit above, as it should be
useful when napi threaded is enabled.

Generally speaking I would keep the initial revert to the bare minimum.

> > The problem originally addressed by 4cd13c21b207 can now be tackled
> > with the threaded napi, available since:
> >=20
> > 29863d41bb6e net: implement threaded-able napi poll loop support
> >=20
> > Reverting the mentioned commit should address the latency issues
> > mentioned by Jakub - I verified it solves a somewhat related problem in
> > my setup - and reduces the layering of heuristics in this area.
>=20
> Sure, it is. I also can verify its usefulness in the real workload.
> Some days ago I also sent a heuristics patch [1] that can bypass the
> ksoftirqd if the user chooses to mask some type of softirq. Let the
> user decide it.
>=20
> But I observed that if we mask some softirqs, or we can say,
> completely revert the commit 4cd13c21b207, the load would go higher
> and the kernel itself may occupy/consume more time than before. They
> were tested under the similar workload launched by our applications.
>=20
> [1]: https://lore.kernel.org/all/20230410023041.49857-1-kerneljasonxing@g=
mail.com/

Thanks for the reference, I would have missed that patch otherwise.

My understanding is that adding more knobs here is in the opposite
direction of what Thomas is suggesting, and IMHO the 'now mask' should
not be exposed to user-space.

>=20
Thanks for the feedback,

Paolo

