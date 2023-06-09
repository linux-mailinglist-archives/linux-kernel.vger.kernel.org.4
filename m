Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4072A294
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjFISuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFISuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:50:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59435B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:50:43 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bacf5b89da7so2115000276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686336643; x=1688928643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls8ASbqVf+OxfQ28gdwv86E0CDvCxuQPRXvTmaU1qZ8=;
        b=BgYnhkcmYneC2cgdqH9vPsforrcVpoamZZpxmNymi1HhYM867JQFIqyJMfLNj1OA0o
         NQxhNdWVWw2kpK9b9QIWfhosCBBZ4B2bkqiX3unz2elF0Yd6Y71kqEXDGCrefkPDUai/
         dL+4UFs1CvOYimCjF5ECs0h3MPk89VlOj5i/TOhmz6QNh2pBmaW8i1UBqwlHkr5IGdwN
         ti//h4UPqPvcuA73LNPEPpM9GamOEJanilhV7k6zGc5LCLAMSpm82jA5I0MhGgYoXeyI
         y5wrk3ovnGstX9TU8PWz96LMy/xbUqzEGZhyp49j1fZNXcd0fWa/NJ5jwrkNQ28f/Jfd
         sWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336643; x=1688928643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls8ASbqVf+OxfQ28gdwv86E0CDvCxuQPRXvTmaU1qZ8=;
        b=NIx0guK3STpWoXtwdOlN46oblwvI0ExIfwrvGzVSrBxmaNOidfHZQp+pj3EH0lqakj
         3bXqJsUE/xgo4ijoDi7NMs/i+NvRpeNT3GLIPQpF/YKttEhhjmyxSJsGKfEGyW1XndGL
         qk6RDYyAVQoEMVbB6qji/rwsjynrpstEyNnFV57Aok4i7+DBQV6c+OHPIgaZVZTFzMem
         6+iekdN7SPgST5HpcRkdWQS9sFrolV5Ha+w1y/atBJNBGsnCZNxooDhN1zIETfYr2JI0
         oOBxak/mme2LnnV3m6I7SRaQsEru/sdOiadsxWb2avZg1Ta6B6aUrizEq2VYZD5I49t2
         TQgg==
X-Gm-Message-State: AC+VfDxd9MpTWNccF90wULZklbWwGmkHz7KZLMyr3ForV2/w7rnyYt+7
        8GP63cdPE+mYAlq8P7a8zJ2cv4FGeT5dZDXqeB4AXw==
X-Google-Smtp-Source: ACHHUZ5mlzEP6duFB2RPppaJytP0jp8FV90GwtBIyaVVZeY0WsEB4K2kSrmJb1pVmexp2PI1D8rfhTnQWfgDoQCZK5c=
X-Received: by 2002:a5b:712:0:b0:bac:a43e:88e9 with SMTP id
 g18-20020a5b0712000000b00baca43e88e9mr1736212ybq.44.1686336642462; Fri, 09
 Jun 2023 11:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-2-surenb@google.com>
 <877csdpfcq.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAFj5m9K-Kyu-NV1q3eGeA8MOcC1XYgYyENnti-Qd8Mj-A6=Q5Q@mail.gmail.com>
In-Reply-To: <CAFj5m9K-Kyu-NV1q3eGeA8MOcC1XYgYyENnti-Qd8Mj-A6=Q5Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 11:50:31 -0700
Message-ID: <CAJuCfpECOWgKx+PTsygNM9mryEf_So9QwCrPyBrS-tjbzCWjDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] swap: remove remnants of polling from read_swap_cache_async
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, david@redhat.com, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 8:14=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Fri, Jun 9, 2023 at 9:58=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > + Ming Lei for confirmation.
>
> Good catch, it isn't necessary to pass the polling parameter now.

Thanks folks for reviewing and confirming!

>
> Thanks,
>
