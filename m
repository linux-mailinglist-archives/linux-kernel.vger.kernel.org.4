Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53170496B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjEPJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjEPJgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:36:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B3E52;
        Tue, 16 May 2023 02:36:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso25581094a12.2;
        Tue, 16 May 2023 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684229762; x=1686821762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOYuwaGvQzB6W1rRJXfWsnaF3BnBS5m8MDev8mfwpl4=;
        b=ZaH64FzpUsamyNTy1bzxrK/9Vm1lyGjs2o2RRvLTujZ6vLXLHQIBdR3aev7k/gnamy
         hGo0+GakQd+1bNYbAo9jCS6xl8Rf68Ba1ZdpN5oXZT8Y6SyXg8Uo/Ez+Cggb6kageRT1
         tcVMBuulkSRTW1PcKMR1q4EFNILYNPfAyeiMW2rgTj2WkRqLghUiPm+jdUPniKA8LbHQ
         qTxqOSsVftohC24wAtnZ3ZZ+1GfWs3XyPm2y+VkSZN2h5TVrP5diR5+fa28FetVHL14n
         4em+bxnRBM9A6yYq1vj0MZ++tJcS0LwiBx2CZhqG6KTyj1i6fOxoSAd/Lg8r+Eh8PZA+
         s2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229762; x=1686821762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOYuwaGvQzB6W1rRJXfWsnaF3BnBS5m8MDev8mfwpl4=;
        b=MYsE4wqgoXSuq1q9+BbRDsnTSYIT86q3+PwQcHLIJkbax5t9HMXfFFO8UWYINe/v7q
         CBxjYimy+G5yUo6jIImx70ZdPtzC+y4Xm264P9Y7k8TXJ5daN0b0Y4TgssDklrOsGIBw
         stzuRvsYp6Aqz/i0Yfzox7nNuQv8WiPgfgTZAlJ6vR6Yp3/OYRr5nfRldWxdX/Vx3bA0
         ss4hG10FPdUAgelPlokx2WjllIOItzgBscKEge7IflOg35k9Gu2eR8XRnrNRp9K2JHnk
         8W5oKmT2Ycj8Bw3WM7cASv4BepOfCgMxIWeUsU33MOa/2lzYXp1cOz28oMs+b5w/yG5R
         wYUA==
X-Gm-Message-State: AC+VfDzzYs3kPkflx/SZYKUiw1gA2dDI0wqUVgArbZujqxJgPsl6+hxW
        218NZVIaAdtd+VvcPdbLk4d2oxRmHLh4Nl4duuU=
X-Google-Smtp-Source: ACHHUZ4TQCLryFERufS4j2G73LLn7fsBTUzB8Mn6JiQURp0dHneoZNIl/npAe/4hhhahWai8tAT6/j9WCU1Z7fyGQUc=
X-Received: by 2002:aa7:db90:0:b0:50d:9a30:f305 with SMTP id
 u16-20020aa7db90000000b0050d9a30f305mr21453968edt.24.1684229761619; Tue, 16
 May 2023 02:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091548.GA2587705@hirez.programming.kicks-ass.net>
In-Reply-To: <20230516091548.GA2587705@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 16 May 2023 17:35:50 +0800
Message-ID: <CAD8CoPCen5Vx33Q1hYJ4T7Q9xhZa63OA52B606omkBttRWpkFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for pointing this out,  I'll get it all fixed ASAP.

Regards,
Ze

On Tue, May 16, 2023 at 5:16=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, May 16, 2023 at 03:18:28PM +0800, Ze Gao wrote:
>
> > +static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > +             struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +{
> > +     struct fprobe *fp;
> > +     int bit;
> > +
> > +     fp =3D container_of(ops, struct fprobe, ops);
> > +     if (fprobe_disabled(fp))
> > +             return;
> > +
> > +     /* recursion detection has to go before any traceable function an=
d
> > +      * all functions before this point should be marked as notrace
> > +      */
> > +     bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +     if (bit < 0) {
> > +             fp->nmissed++;
> > +             return;
> > +     }
> > +     __fprobe_handler(ip, parent_ip, ops, fregs);
> >       ftrace_test_recursion_unlock(bit);
> > +
> >  }
> >  NOKPROBE_SYMBOL(fprobe_handler);
> >
> >  static void fprobe_kprobe_handler(unsigned long ip, unsigned long pare=
nt_ip,
> >                                 struct ftrace_ops *ops, struct ftrace_r=
egs *fregs)
> >  {
> > -     struct fprobe *fp =3D container_of(ops, struct fprobe, ops);
> > +     struct fprobe *fp;
> > +     int bit;
> > +
> > +     fp =3D container_of(ops, struct fprobe, ops);
> > +     if (fprobe_disabled(fp))
> > +             return;
> > +
> > +     /* recursion detection has to go before any traceable function an=
d
> > +      * all functions called before this point should be marked as not=
race
> > +      */
> > +     bit =3D ftrace_test_recursion_trylock(ip, parent_ip);
> > +     if (bit < 0) {
> > +             fp->nmissed++;
> > +             return;
> > +     }
>
> Please don't use this comment style; multi line comments go like:
>
>         /*
>          * Multi line comment ...
>          *                    ... is symmetric.
>          */
>
> Same for your next patch.
