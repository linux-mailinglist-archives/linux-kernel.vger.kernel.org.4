Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7870B797
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjEVI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:28:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641F0D2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:28:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30789a4c537so3677282f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684744099; x=1687336099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQPKp4ylIrhBgcqRpAt3qUDuu8+hY7keqcoakv7RGXY=;
        b=UuoRc85nqWStGpANB5zweRVQyMFOYQmNJs1Hx80dqdxxWuHFfaKqQLiCaRr+/V49EI
         jjr2Ao7NM7DsLdV0Ppzr2YybTYqTrZKRz1N0J11S3WbBgM0nskqf77+6fAYrIzMURDfu
         qmbIi24/nCIOC6OH1+u844UnXMNFqWIExb+FJ5R2ul5tGTTELUY6+v9aPt44M4wtrl90
         kfxD5e5FUMfcXmZQlS2/j3TLUui43knC9KnhaXsMN4TPk5bJhdjzR3wvmH9CD17wq0Il
         PwBsqHxhsuhc7YB+2YuuBoggSlKZHp4MBK1O9TaBxPf/WONfDrn5Yk8yWN5mJ1F7yZqI
         XV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684744099; x=1687336099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQPKp4ylIrhBgcqRpAt3qUDuu8+hY7keqcoakv7RGXY=;
        b=MxTTJM3V+2s2fivTwthIPCJ48CP/QS60YyAzvzmQ0OMYfEbclPQpELxp2S07HYhWGG
         DikcsygwSyMZwtyjYzXU9BtmjFVBRi0S9VfPUbE0eaoMptf0oYZVgYgcF82aQtOsD1AG
         hr84vi7V49uaJYWX1zj6y9tu8SRgtxW0iZsMTuHlCVz5WxPz+xlSDquCTzQqVSW2EYqh
         HjR7tuHj9A52wLRaOMK+6GN3pzM6hq3iLi6Ewisy2eSCjAjsyt2vpv2XNmNR5zlEyNEn
         5oLsYvnvzPsN+oCXAn9smcN61YNcwXEHI0W0XgaGnp/q0TGHK7UvN997V1T9UH38Nr0S
         x/aA==
X-Gm-Message-State: AC+VfDzMBqHjs3ue92pr4wDeTV/VHitpADW+MKZUxl3pqMJOEgvP6KE4
        eBAH1ula4GBjMyw9E7oohLiD5B4IYLtP0dhV3Pf/i/knaGwrzdcosNQ=
X-Google-Smtp-Source: ACHHUZ6xF2ggBqR3M3Zan56q0SstCxZYMrC939CqChGjb0uLHhCkkPmT+WP0oLS6Qznmq3LfvoQZgBjgpDRsWOaIvlk=
X-Received: by 2002:adf:e60b:0:b0:309:a4e:52d3 with SMTP id
 p11-20020adfe60b000000b003090a4e52d3mr7866449wrm.5.1684744098765; Mon, 22 May
 2023 01:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230516182537.3139-1-osalvador@suse.de> <20230516182537.3139-3-osalvador@suse.de>
In-Reply-To: <20230516182537.3139-3-osalvador@suse.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 22 May 2023 10:27:41 +0200
Message-ID: <CAG_fn=VxR47e3jfKYteivtEZXWDtUqZb_i8=gxGxBj71FKw=sQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counte
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 8:25=E2=80=AFPM Oscar Salvador <osalvador@suse.de> =
wrote:

I am still hesitant about adding this functionality to stackdepot,
because page_owner is the only user of the stack counters that look
orthogonal to the rest of stackdepot.
One indicator of that is the fact that you keep adding dependencies on
page_owner to stackdepot code.

> We might be only interested in knowing about stacks <-> count
> relationship, so instead of having to fiddle with page_owner
> output and screen through pfns, let us add a new file called
> 'page_owner_stacks' that does just that.
> By cating such file, we will get all the stacktraces followed by

"cating"?

> +#ifdef CONFIG_PAGE_OWNER
> +void *stack_start(struct seq_file *m, loff_t *ppos);
> +void *stack_next(struct seq_file *m, void *v, loff_t *ppos);
> +int stack_print(struct seq_file *m, void *v);
> +#endif

Code depending on CONFIG_PAGE_OWNER should not belong here.
It is fine to have generic iterators to traverse the stack depot in
stackdepot.h without #ifdefs.
Perhaps they don't need to implement the whole interface of seq_file.


> @@ -486,6 +487,77 @@ static struct stack_record *stack_depot_getstack(dep=
ot_stack_handle_t handle)
>         return stack;
>  }
>
> +#ifdef CONFIG_PAGE_OWNER

Ditto - no CONFIG_PAGE_OWNER, please


> +
> +int stack_print(struct seq_file *m, void *v)
> +{
> +       char *buf;
> +       int ret =3D 0;
> +       struct stack_record *stack =3D v;
> +
> +       if (!stack->size || stack->size < 0 ||
> +           stack->size > PAGE_SIZE || stack->handle.valid !=3D 1 ||
> +           refcount_read(&stack->count) < 1)
> +               return 0;
> +
> +       buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> +       ret +=3D stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stac=
k->size, 0);
> +       scnprintf(buf + ret, PAGE_SIZE - ret, "stack count: %d\n\n",
> +                 refcount_read(&stack->count));
> +       seq_printf(m, buf);
> +       seq_puts(m, "\n\n");
> +       kfree(buf);
> +
> +       return 0;
> +}

Maybe stack_print() should be in mm/page_owner.c instead?



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
