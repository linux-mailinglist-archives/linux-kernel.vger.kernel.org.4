Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC258663C80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAJJPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjAJJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:15:22 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C4517FD
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:15:21 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4c24993965eso140020327b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZjVbZGCjv7A5kNPkNeLdv+wkjoamsJDXs8YegeL2T4=;
        b=G4FXz9plsObMOuxdew9aUiYd8kNDrKlLcRdPP0D4TPErxFg5Flg+a0CragCj2tHf8J
         zBNc7Oz6wYgNDUlcVyMzvQV7VlzjvYaonI/LqykEnEQyLSCqWK44PmIDDdv3ftmLz4Kv
         hDHT9AS1cruTEgyD04PVuKT3yio0GXSlVlQeLXqZ2IdcLzS5sfs14/lHHQOc7L0SdV/+
         DJYM2kYGgW6wZUPBfZDBUUvX0VpbAARkvO0WZqpkGMjQNssw+V+giAL3Z2atEAyyJTax
         96mKg67KtxKOw3MV5aWOI8O8nGxJvEFPfn0aB2fycCC2ocv33CnczJf0AmLRlY0hyIIW
         Qo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZjVbZGCjv7A5kNPkNeLdv+wkjoamsJDXs8YegeL2T4=;
        b=jOYKCZvn2srRGnHvp98hCL07RlMVvmWTXT7nzwa0K9/5fU3RlPlOAl/dyE3lxuUHPF
         sQPV0eZGsGOEF8YpQwNuSeVdgkPyV6H0mJsrYzKctBz5QiUXAJrKgWhByvqa6Ipwaw9f
         nAHZzovvq5J+J0Y/bEJCbmjzYytDGSvM/yGDfHQJHFNNEuOg9gV6sZJBJxAzmCblIFQQ
         bNpgN9bVM4tYgMphXV3fWoQsAysTmAdC9zuTOGVpfk0KJiXIXEQH6J5JivthtfRs4SWR
         QKAcTdKowdPW8tDocvO6Dr8HgG0+PBS0geS/J1wTw2wvuapLu9zeMWwPF9yy/08dj+R8
         3s3g==
X-Gm-Message-State: AFqh2krjf8/wWMYPCIprDyW2TV6rU0kdOypqEWTj7aec6j6ixlhyfS01
        A4lMQjRBgldukH+46uimk8YasEcUlC0LuamlxPUlpQ==
X-Google-Smtp-Source: AMrXdXuNPz/lCT5Ip3Oax+2WkTY37IIgve1Hzt4zhUh6P2VQYSyLmFnP5+brN3G4ZEtHtE3MwKPgx6/T59bVb0mGefk=
X-Received: by 2002:a0d:f084:0:b0:4c2:51b:796c with SMTP id
 z126-20020a0df084000000b004c2051b796cmr1329440ywe.144.1673342120546; Tue, 10
 Jan 2023 01:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
 <CAG_fn=W2EUjS8AX1Odunq1==dV178s_-w3hQpyrFBr=Auo-Q-A@mail.gmail.com>
 <63b74a6e6a909_c81f0294a5@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=WjrzaHLfgw7ByFvguHA8z0MA-ZB3Kd0d6CYwmZWVEgjA@mail.gmail.com>
 <63bc8fec4744a_5178e29467@dwillia2-xfh.jf.intel.com.notmuch>
 <Y7z99mf1M5edxV4A@kroah.com> <63bd0be8945a0_5178e29414@dwillia2-xfh.jf.intel.com.notmuch>
 <CAG_fn=X9jBwAvz9gph-02WcLhv3MQkBpvkZAsZRMwEYyT8zVeQ@mail.gmail.com> <CANn89iJRXSb-xK_VxkHqm8NLGhfH1Q_HW_p=ygAH7QocyVh+DQ@mail.gmail.com>
In-Reply-To: <CANn89iJRXSb-xK_VxkHqm8NLGhfH1Q_HW_p=ygAH7QocyVh+DQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Jan 2023 10:14:44 +0100
Message-ID: <CAG_fn=W36J9FNtkdFN6Ygua+hZKd3cUg9akJvx6rJknr9T--rA@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Eric Dumazet <edumazet@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

> > > Unfortunately, it can not be dynamically enabled because the size of
> > > 'struct page' is unfortunately recorded in the metadata of the device.
> > > Recall this is for supporting platform configurations where the capacity
> > > of the persistent memory exceeds or consumes too much of System RAM.
> > > Consider 4TB of PMEM consumes 64GB of space just for 'struct page'. So,
> > > NVDIMM subsystem has a mode to store that page array in a reservation on
> > > the PMEM device itself.
> >
> > Sorry, I might be missing something, but why cannot we have
> >
> > #ifdef CONFIG_KMSAN
> > #define MAX_STRUCT_PAGE_SIZE 128
> > #else
> > #define MAX_STRUCT_PAGE_SIZE 64
> > #endif
> >
>
> Possibly because this needs to be a fixed size on permanent storage
> (like an inode on a disk file system)
>

Ah, thank you, that makes sense.
Then I'm assuming some contents of struct pages are also stored in the
persistent memory. What happens if sizeof(struct page) stays below
MAX_STRUCT_PAGE_SIZE, but the layout changes?
E.g. doesn't it cause problems if the user enables/disables CONFIG_MEMCG?
