Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F756344C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiKVTlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiKVTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:41:19 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B756F372
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:41:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so25048814lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huY5awniuetQkBJOXy/Pee5GMfNTDh3mJcwr+bXp+Ig=;
        b=LPmVmfLhqIn4AbzQZEOyBt7rAY8obFeVGkTt2bTrzabJ0g8lJRilGYPCCd7kUN9Ey6
         4TIjQJTZ12jvQvp66xIekrdcr5PsvfLsLQIqNpZrhwTvIz7I1vVmFtz20lQobSgbq28f
         iO3m+9K8KUIQw0Tw41mhrvi9RDgYO6//RlyyA342j9LCNhCEmtQiEm+zZnlwaqfLvdca
         7kANZKE8x/ZR86W+3tHifaK2u94043GSaco9Za3Gj46FbgYVz6C07T48Fwk+BI+VMhHx
         g2WWlncLBI3/NR+oncWs3WdDUgnbWeA4Mn7pf9JJCS+tCmvKlMxBgUAb4fgzJpwau8xN
         74Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huY5awniuetQkBJOXy/Pee5GMfNTDh3mJcwr+bXp+Ig=;
        b=Qr/8ZQ4oOW9lBldpszFwM53VuDsHqSzNHREtIwYdkOymlK2GpfGyx/qdYJcoW50YyN
         4vYUuK8awckL042PhXA4rEXaDAAwc6YxhRHrOuyhUo9L4kmESlW/YprEacFXEz87/KRh
         RDPSQ0NKhOY8tGwXHlEqtU/yc+FOMm8/UJ3eMzJdfDXUWIxg3x6qAASvcjoL5nUKHfv0
         igQuipDuEbi1GJy8ajgPjSlLobk6nVa6uWtXC7E3VSpObUgQ+NKn8y7TpMYtXx9HWVQk
         LvRyGbEiCx0xenRSHpleC4yOVqz4bmg30aGP82RXt27SinhZInDibPX5+tOLnCriVden
         1k+g==
X-Gm-Message-State: ANoB5pmDwh0+4LD4eFpA2acu3cTHDoOaRdssA35g6UiqN+ExQjMLl/wp
        Vgi6Mb1zGzuyWFhnpQDvecpx4HdKDfSEEf0MLaiCYg==
X-Google-Smtp-Source: AA0mqf77CixhRcTrkQdMHjss4HgMHMkDg1v7maUZZTBbimolP+j7dQhSvpU0PE0XS3V8HV9afm1X5lkXB2dbIZL8QqI=
X-Received: by 2002:a19:7107:0:b0:4a8:e955:77e7 with SMTP id
 m7-20020a197107000000b004a8e95577e7mr2308741lfc.573.1669146076359; Tue, 22
 Nov 2022 11:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20221117005418.3499691-1-joshdon@google.com> <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com> <Y3xnUhjSb56ex9XX@ziqianlu-desk2>
In-Reply-To: <Y3xnUhjSb56ex9XX@ziqianlu-desk2>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 22 Nov 2022 11:41:04 -0800
Message-ID: <CABk29Ntdztkv4jT87vFgTtC99d49iUu9CcHPruh9MxDazaAW7A@mail.gmail.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
To:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
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

> > +        */
> > +       if (local_unthrottle) {
> > +               rq = cpu_rq(this_cpu);
> > +               rq_lock_irqsave(rq, &rf);
>
> Should we add:
>                 if (cfs_rq_throttled(local_unthrottle))
>
> before calling into unthrottle_cfs_rq_async(local_unthrottle) to avoid a
> potential WARN?
>
> As for whether the local cfs_rq can be unthrottled now after rq lock is
> re-acquired, I suppose it can be. e.g. another user sets a new quota to
> this task group during the window of rq lock gets dropped in the above
> loop and re-acquired here IIUC.
>
> > +               unthrottle_cfs_rq_async(local_unthrottle);
> > +               rq_unlock_irqrestore(rq, &rf);
> > +       }
> > +
> >         return throttled;
> >  }

Yes, we should add that check due to the case you described with a
user concurrently configuring bandwidth. And as long as we're doing
that, we might as well make this unthrottle_cfs_rq() instead and snip
the comment. Peter, would you mind adding that delta?
