Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6725B9509
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIOHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:04:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202742496F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:04:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lc7so40011628ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=j1kUyC7iu7utgqoAK7z0cHTVQDX1FbVpPDJtzATRa4o=;
        b=Iez3F4ny0K6PpWmDBOSMQpbDuzfCADZhrp1YpHOXKkp/NiDvMxlJeVXB96ecamwre2
         FyIRB5rP4WVl5xU4V0tzQWN6lC+cKAL08qs8a6w60BmdJYVkpopuwtB7ZLdiMNo8jSC/
         XpLk3NyQMfVWxuNA9EmU5mjC0ShrCM4+SfNlp5gb+nwMcXrZaMoJXtSfyMO11wAp+kb5
         j0cUyj4dazPMOz5N0TxpSlK3Hwn2rCpoND3KYEiJkXWnTodKBJQe5fDLnnlkpke8XYZy
         22iw42Oe/fnllewQPulvMNQSGGmUf4c5720R//ncnERcdY8c3E2X7Mud0OcKB/yZkoEe
         PAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j1kUyC7iu7utgqoAK7z0cHTVQDX1FbVpPDJtzATRa4o=;
        b=BBvswqNXFK7adkwlVlYiwCFI+7vx04bgznQCAimkXHKkdI5JrtpyYS0GN7wSDA1bF0
         DRik4jHlJ3Ttv+0o7SS4OYrXaVm1jNjtduXDKTVqSjftmf/mbil01HjQoizmJsgkHuDz
         XwDxeObd6zQj9KvmlkShVQypIKYqtTFddXKq5IcptLQATmuCs475bCIA4qFS0m0TMN/n
         HkWyuf22qCEhGRJTRGG4e5TmHCISmpn6mkVaoNMgG8fZgSSpaESpDM3dApNK34u9uih2
         ea+tFmrYT8sS5UBywIaCew5dPf/fb61Wb3VOCdp2Ll7RFUeoW6/MCG5uMRooOd5ykyhO
         Tx8g==
X-Gm-Message-State: ACgBeo1MA830duC0lWzrnYv9qCvHDunqVrk8kX0G3vw1jtd9f20UUFow
        h1LSvefjhZwZpVtWTs2WyEWs2HdC0VL5ZkPy58Y=
X-Google-Smtp-Source: AA6agR77sNVzxW+BGLqa5pM1RPn6qh0iNwfP9k3D0wQ9CUl7BE7ItbHGLd47AaB4d+aF0Pc59jQV4ke+6K0LxKg/sak=
X-Received: by 2002:a17:906:ef90:b0:77f:8f0d:e925 with SMTP id
 ze16-20020a170906ef9000b0077f8f0de925mr9804761ejb.622.1663225494621; Thu, 15
 Sep 2022 00:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220902155820.34755-1-liq3ea@163.com> <20220909220746.a7826cb2fb9da02171b38237@kernel.org>
In-Reply-To: <20220909220746.a7826cb2fb9da02171b38237@kernel.org>
From:   Li Qiang <liq3ea@gmail.com>
Date:   Thu, 15 Sep 2022 15:04:17 +0800
Message-ID: <CAKXe6SLNaWknvTdqPb0aGWtbQgp0mJz28KpRMZgwbdXV1DQ=wQ@mail.gmail.com>
Subject: Re: [PATCH] kprobe: reverse kp->flags when arm_kprobe failed
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Li Qiang <liq3ea@163.com>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 21:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri,  2 Sep 2022 08:58:20 -0700
> Li Qiang <liq3ea@163.com> wrote:
>
> > In aggregate kprobe case, when arm_kprobe failed,
> > we need set the kp->flags with KPROBE_FLAG_DISABLED again.
> > If not, the 'kp' kprobe will been considered as enabled
> > but it actually not enabled.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
>
> Looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Hello Masami,

Who should merge this,  you? This issue will crash the kernel before:

0bc11ed5ab60c135aa764a62c02cd5ea68289de4 commit ("kprobes: Allow
kprobes coexist with
livepatch") and
8094029330a2f03fb406ecff80671cf27ce28d42 commit("libbpf: Cleanup the
legacy kprobe_event on failed add/attach_event()")

Thanks,
Li Qiang

>
> Thanks!
>
> > ---
> >  kernel/kprobes.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 08350e35a..333454df5 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2424,8 +2424,11 @@ int enable_kprobe(struct kprobe *kp)
> >       if (!kprobes_all_disarmed && kprobe_disabled(p)) {
> >               p->flags &=3D ~KPROBE_FLAG_DISABLED;
> >               ret =3D arm_kprobe(p);
> > -             if (ret)
> > +             if (ret) {
> >                       p->flags |=3D KPROBE_FLAG_DISABLED;
> > +                     if (p !=3D kp)
> > +                             kp->flags |=3D KPROBE_FLAG_DISABLED;
> > +             }
> >       }
> >  out:
> >       mutex_unlock(&kprobe_mutex);
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
