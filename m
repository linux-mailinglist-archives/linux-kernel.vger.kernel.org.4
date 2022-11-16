Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295DC62CCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiKPVpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKPVpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:45:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E813DDD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:45:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g12so31791726lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwbDYoWggCopBBuTSq6VaQowU8is6PoXgXYL4Y8gLWg=;
        b=c10/3GfACFFJD16rXSQxqWquhSKoCgWsrJ80bqbsD9M5pdSRFavbGK+uWam1DWWNId
         RdmYrp0bOwkP17L0UJt8TbC58BkWsnqJmNX0RvLGZuDvgKYSqHA+NYnauZOv/GxkNHWM
         aAedjK/524gncwJnb/kKA+oGng5TmNipvvEsuzUUaU3tsa+gLFi9jrJA5Kj/qcsvYfZP
         CEWU1MbTZc5LN0eOr1BdHHCTg3BjVJ6T/iJgpsjg9J5LsaKZi6nnojcADKiDR7k15JJI
         PenojtM7GF4YQso0bmrDug87IPSxmewpvbhHEVF8nq4jvOWkthjKU50pl00UjqlOm+7n
         3hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwbDYoWggCopBBuTSq6VaQowU8is6PoXgXYL4Y8gLWg=;
        b=TFycY9ixmsrUP8bR7HI3b6YudsPVcePrl0L+XUYfHegx3wn4hXopVUhEwYxSZPcK8K
         M9A3u6+IJt0V4hUqE5eqg+VwzLR+rwfiJ2ebh58rWWgJHrA60idDHzg/v0YOgSTfBYHp
         vO5iRzCAR7asXehLcEmd/P5lRPBiQpvpxaa5vr25RwxYvWCI/jpm5B2I3Cc/tfU9MSoW
         73TJksI3+CbxScUaf/Li2mompAiyho8Xur+fVqRNN1mTdQr1Puc/11CB+DuWx3vV4E9o
         w9fTBcmFtUOQMiAwnxyVnyPpI7o57jD7VUKgIT40LgftPNw+psaQeWf2I1xp1h06B/Ui
         NNCg==
X-Gm-Message-State: ANoB5pnWnkDunRQLYTDSLd/MbxkERwNIGt6CXbjGpH2M6vXsxVwA6Ci4
        HQnsKWajWXb9GXZXviprW+qCtTj7BOxJSm/CJYhxcQ==
X-Google-Smtp-Source: AA0mqf6NNtW92evCT66KPNN2FpFyakWsPczHiopGr3Ls+clKwkr7Ddp1alryox8XWn43OhW3WD2PAawS7DYvUP8pitc=
X-Received: by 2002:a05:6512:1597:b0:4a2:676e:cf68 with SMTP id
 bp23-20020a056512159700b004a2676ecf68mr7693565lfb.546.1668635143174; Wed, 16
 Nov 2022 13:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <20221102165922.GA31833@blackbody.suse.cz>
 <CABk29Nvw8XMrc2_9CAUZb=rO_vddGjsfZ1s3mRQyShANDhtZnw@mail.gmail.com> <20221116095740.GA29859@blackbody.suse.cz>
In-Reply-To: <20221116095740.GA29859@blackbody.suse.cz>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 16 Nov 2022 13:45:31 -0800
Message-ID: <CABk29Nu0-oKggR3MyfzJotznvrvFL-wpiSqBKyG1jhqy-wRXEw@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 1:57 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> What does it mean for SCHED_WARN_ON in __unthrottle_cfs_rq_async()?
>
> IIUC, if the concurrency of cfs_b->throttled_cfs_rq list is
> expected (hence I'm not sure about the SCHED_WARN_ON), then it may
> happen that __unthrottle_cfs_rq_async is called on cfs_rq that's already
> on rq->cfsb_csd_list (there's still rq lock but it's only help inside
> cfs_b->throttled_cfs_rq iteration).

It catches a case where we call unthrottle_cfs_rq_async() on a given
cfs_rq again before we have a chance to process the previous call.
This should never happen, because currently we only call this from the
distribution handler, and we skip entities already queued for
unthrottle (this is the check for if
(!list_empty(&cfs_rq->throttled_csd_list))).

>
> Thanks,
> Michal
