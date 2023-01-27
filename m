Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC567EFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjA0U4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjA0U4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:56:17 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878118A82
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:56:14 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-50660e2d2ffso83589447b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+UKvH7+Fs0UBN0fQYs2fra7FelxOXxsOOmTjKmz4Bk=;
        b=E8yJ7N9znM0aToa4LxzQHUBZn3b5x2U1d1NWdDmLWflzMnqSetaFDiht0QQJTSjCnC
         Qo//IGO3iJS8K8gckFQUA70aGC+vZyFuRK7+B8r0GjHNLP4D+jqM1fUl4SekM6in6Nxy
         Z+JZ9RL15W8p9FW0FWiNA2c46yBUvHDyUz7Lhupci++hv++YjjBtACUE1uhQEgZQ0bVj
         rP0UZcpjzu3430SG0pn9W++pmGI1vQhgwerQo1eS6B/AzBF3agvhUSbve89Tno9r4IYs
         LgamG4aw4/mVOctaL0ruQYNGIiV5K8BbfAW0+byriKBV+7Q7dXAHF0FDTt8tkGXljW3C
         h8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+UKvH7+Fs0UBN0fQYs2fra7FelxOXxsOOmTjKmz4Bk=;
        b=doPRvII9umD02L/TLu5+uzj+VJQukerzPWWXJwNoaNqft/xmIhNCSJjKnuv49R7SmI
         GpD4iTda8OQ/l7wA/cEeSvejx8SoAxrBk2Ja/evZSVX+Xo8NUjOMjaH3HAPKErbRrO6A
         g3GOiT1TuciR25ITm9kurWxyjpUUCzqEnA58g90VsJSffhJ8FgasQQeqM5mw/us5nLRy
         BVlhS5hgEitj3uk8wMOLDPdIHcYzv1aOBvfMmhfyO+ljjSSzSK+5+n/4Q4vCjFL82Qma
         5E0lAUnXmPAJcW51D6dxGf6XPwyA4MMSyr3h7BYPlFGe5bHCXzodLu9RawnTok+zPz5a
         fgoA==
X-Gm-Message-State: AO0yUKW7+XrDdgm5LXBrib1W3hMe2JQ60Ox0r+FQce/dJ5B8Y6f+rkMe
        SeobMwEuN7oFsjMcost1FzDt1iBjsmaAPurBnpP9tA==
X-Google-Smtp-Source: AK7set9X+MemZwETKZc4IHg1twC+Il9/CFR1bpn9h2wXhLc2t6gCqLQVfqsQTiQzJwwYAUMtSxNAvjWnDd7kQbg6W74=
X-Received: by 2002:a81:1e46:0:b0:509:115b:a39b with SMTP id
 e67-20020a811e46000000b00509115ba39bmr859277ywe.263.1674852973662; Fri, 27
 Jan 2023 12:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com> <20230126193752.297968-4-surenb@google.com>
 <20230127174530.sws4xg3qjsx3agh4@offworld>
In-Reply-To: <20230127174530.sws4xg3qjsx3agh4@offworld>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 27 Jan 2023 12:56:02 -0800
Message-ID: <CAJuCfpGfbP=HcZMRzqvvWSk7+EZEwrQMhE2VhDYXNgX-HRrvLA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] mm: replace VM_LOCKED_CLEAR_MASK with VM_LOCKED_MASK
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Fri, Jan 27, 2023 at 10:12 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Thu, 26 Jan 2023, Suren Baghdasaryan wrote:
>
> >To simplify the usage of VM_LOCKED_CLEAR_MASK in vm_flags_clear(),
> >replace it with VM_LOCKED_MASK bitmask and convert all users.
>
> Might be good to mention explicitly no change in semantics, but
> otherwise lgtm

Thanks! I'll add that if a new version is cut in the future.

>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
