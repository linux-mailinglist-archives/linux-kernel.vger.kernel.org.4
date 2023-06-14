Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727672F411
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbjFNFRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbjFNFRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22710EC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686719795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcLO5Brc+F9RY3h/Vkhh4dPuhU1v5kJgJ/964zE6Pnw=;
        b=FL468Xu4pItE9mCVElOJdYdKTXSW6WDrRZehtjaCHGf3csnqjrcrDP2H7Z0bKFJeEA9jjr
        z32oeFeMM7/9iJqoQDchtk+F8ZHOdgh/kdVlV+Ttg6woyLexmwjirsdf2NEcXSmbjkROW+
        AAkhPJ/HuuVE6I6ALttwvcpl29Z1CkM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-RufbEmWuNSOTgOVbuaQzcg-1; Wed, 14 Jun 2023 01:16:33 -0400
X-MC-Unique: RufbEmWuNSOTgOVbuaQzcg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f9a629fdebso24554891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686719793; x=1689311793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcLO5Brc+F9RY3h/Vkhh4dPuhU1v5kJgJ/964zE6Pnw=;
        b=T+9WSwZ5UvTPszKxEZf+Ab/JbvgraGGXaBxhmu39YZzToL3VRHOI7xeA057OtcOudp
         8dXW8wYbi5PSgCYkU34W28o5/4jGYMG76YlYui+RInArVYkOXcxcNlksvC0FPOY0dIGL
         jb/GxNCAnXXNewVNs+GdZtZunyU43vaAqJyy0StnaC6YcNXe04R0quhubRbjw7Ifvviz
         W+ui5/iI23ZcBU2yPhVa9n4tHqzn041km63Cb7MUkAlpdovndl4qbOBH1v7bltqCRs43
         WId40W594UwLTCwwHu5GehfKn8TbR45hMS3Rc5mGdbr8nFWVZi2BOtLdELsXNjjwzhyU
         eTqA==
X-Gm-Message-State: AC+VfDyr1IvcXUeYizEmWI5bgDy5dvVJEWpEn17jegEprqbVwhPVu1Wd
        ApMx/NXxm9fSb6iqYgpIyilLlfFhXgP+AfqiTsNnJJA7c6bxpj5hPLjduV2IVfKRnIzkCYtqUZO
        RDNpo4loYQX2PrgbNlImuisf4wyb95jRcXXJXOPrQ
X-Received: by 2002:a05:622a:19a0:b0:3f6:a92e:7f47 with SMTP id u32-20020a05622a19a000b003f6a92e7f47mr1172801qtc.13.1686719793419;
        Tue, 13 Jun 2023 22:16:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NYJjDE8hS3pJhq0es58Qm4gSXAfnpvHmwRDM0CuYvFfly4ak9JYLZs3X7Pycw+nqlEkLPoVMh8vlZjxBVWqY=
X-Received: by 2002:a05:622a:19a0:b0:3f6:a92e:7f47 with SMTP id
 u32-20020a05622a19a000b003f6a92e7f47mr1172789qtc.13.1686719793248; Tue, 13
 Jun 2023 22:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230515183045.654199-1-leobras@redhat.com> <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
 <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
In-Reply-To: <CAJ6HWG7sXLiY76truiyKDwfNCEhy-ZqNAOn_oi0vccTm7At1Vw@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 14 Jun 2023 02:16:22 -0300
Message-ID: <CAJ6HWG4sRHCTtkxe8G2csjBhJxeJZcO=cQ9Reb1cJrN2VA1nzg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 1:14=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Tue, May 30, 2023 at 7:36=E2=80=AFAM Valentin Schneider <vschneid@redh=
at.com> wrote:
> >
> > On 15/05/23 15:30, Leonardo Bras wrote:
> > > Changes since RFCv3:
> > > - Split the patch in 2: entry/exit and queue
> > > - Fix 'struct __call_single_data' & call_single_data_t alignment issu=
e
> > > - Made all TP_printk follow the same pattern
> > >
> >
> > One bikeshedding nit I have is I'd prefer to see the csd_* events in a =
csd
> > trace system, to have a sane nomenclature.
>
> Oh, here you mean the file name? (ie: trace/events/smp.h -> trace/events/=
csd.h)

Or just
-#define TRACE_SYSTEM smp
+#define TRACE_SYSTEM csd
?

>
> >
> > Other than that and the other comment on csd_do_func(), this LGTM.
> >
>
> Thanks!
> Other than the above question, it should be fast for me to send a v5.
>
> Best regards,
> Leo
>
>
> > > Changes since RFCv2:
> > > - Fixed some spacing issues and trace calls
> > >
> > > Changes since RFCv1:
> > > - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneide=
r
> > > - Using EVENT_CLASS in order to avoid duplication
> > > - Introduced new helper: csd_do_func()
> > > - Name change from smp_call_function_* to csd_function_*
> > > - Rebased on top of torvalds/master
> > >
> > > Leonardo Bras (2):
> > >   trace,smp: Add tracepoints around remotelly called functions
> > >   trace,smp: Add tracepoints for scheduling remotelly called function=
s
> > >
> > >  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++=
++
> > >  kernel/smp.c               | 41 +++++++++++++---------
> > >  2 files changed, 96 insertions(+), 17 deletions(-)
> > >  create mode 100644 include/trace/events/smp.h
> > >
> > > --
> > > 2.40.1
> >

