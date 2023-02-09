Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9169057D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBIKpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBIKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:45:11 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C53BD92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:44:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o20so2596981lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI6fqWlX5YUhT5J0Rtyo4N3gfV1eJtvT1+AvPfJcUdg=;
        b=UGzZPXcJHS29rOdecNpdCu8227vfftyizM08yDHuc/zLsoryhaf/CPSLodR88q5A8Y
         EMLWmk4A5ULM1RMufZtqTNCVHsQWfTLPxezlEwiv40z9J05ZoOmE0T11Ty+63mI0ixxL
         u9pyF20+KQ95NN7QiJ7gkoW/Lx+xt1daospxWzofnVXRWYdLMEPUzXooGYSBteIe39ag
         IqeMFeUGPWQnGmSE78ATed8ae5AEvLomc5NptvirwkEsWjdFVglb1inQYHnWSLe/Sbid
         u5Q/mhyTqAYRPhFupdOzV+VUjKBpaxrAKPBJUQE0WxTPfmASxex85xazhbpT/ih0G1kC
         Zjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI6fqWlX5YUhT5J0Rtyo4N3gfV1eJtvT1+AvPfJcUdg=;
        b=kL0G0kngYORZCc9WQqZpPQurxiXDo+c5ST7bLV8J968SBYCnIeny2USh1DzMVwsi9q
         dtrqt+IqkGqQtuv1LxOygAz+JXoiO9lBZEEOA6OJe/BVXgcBKP1/cN+Dc2jhcYegy+sD
         o82/D01dpnCQe04Sv/EAjXP53h9VkRvoWNZ5/tYnL/k5fpcjCZ2cH8f8K8bREaH+EsC2
         nQ5kf0P8g0VNZOSbtBZa0LRDNshw+e5lupkh66XQ8ylcb2kSnpN7Sofj/1WUTFUuF21k
         /M6pXygdmBeWHv5zUAjK3fq+gsvVc3Bc3qaSdpDJPe8QGBB5FT8vWT1eKmf/BO0tyWdY
         jYrQ==
X-Gm-Message-State: AO0yUKU0zLpCGNpiKFgn+wjnBGGn6srg3NVobaa0+9eCZy/xNlkRXgZU
        T+bCt9pv6mg7v3XH2SP6vsjAEVb7L9yODLddin8jeA==
X-Google-Smtp-Source: AK7set/IL3KZ2ryl3z+zFJVJW3xTr6d5d31gg8oq+FIeq//YmyBoBdEEanDRagXl6fEJo6UDt/EEATB3RFfBgRjQd4M=
X-Received: by 2002:ac2:51c7:0:b0:4d5:86a8:55d1 with SMTP id
 u7-20020ac251c7000000b004d586a855d1mr1805227lfm.155.1675939482991; Thu, 09
 Feb 2023 02:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
 <CACT4Y+Zrz4KOU82jjEperYOM0sEp6TCmgse4XVMPkwAkS+dXrA@mail.gmail.com> <93b94f59016145adbb1e01311a1103f8@zeku.com>
In-Reply-To: <93b94f59016145adbb1e01311a1103f8@zeku.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Feb 2023 11:44:30 +0100
Message-ID: <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
To:     =?UTF-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>
Cc:     =?UTF-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?UTF-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>
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

 aOn Thu, 9 Feb 2023 at 10:19, =E8=A2=81=E5=B8=85(Shuai Yuan) <yuanshuai@ze=
ku.com> wrote:
>
> Hi Dmitry Vyukov
>
> Thanks, I see that your means.
>
> Currently, report_suppressed() seem not work in Kasan-HW mode, it always =
return false.
> Do you think should change the report_suppressed function?
> I don't know why CONFIG_KASAN_HW_TAGS was blocked separately before.

That logic was added by Andrey in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dc068664c97c7cf

Andrey, can we make report_enabled() check current->kasan_depth and
remove report_suppressed()?

Then we can also remove the comment in kasan_report_invalid_free().

It looks like kasan_disable_current() in kmemleak needs to affect
HW_TAGS mode as well:
https://elixir.bootlin.com/linux/v6.2-rc7/source/mm/kmemleak.c#L301

So overall it looks like simplifications and it will fix what Shuai reporte=
d.




> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Dmitry Vyukov <dvyukov@google.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B42=E6=9C=889=E6=97=A5 1=
6:56
> =E6=94=B6=E4=BB=B6=E4=BA=BA: =E6=AC=A7=E9=98=B3=E7=82=9C=E9=92=8A(Weizhao=
 Ouyang) <ouyangweizhao@zeku.com>
> =E6=8A=84=E9=80=81: Andrey Ryabinin <ryabinin.a.a@gmail.com>; Alexander P=
otapenko <glider@google.com>; Andrey Konovalov <andreyknvl@gmail.com>; Vinc=
enzo Frascino <vincenzo.frascino@arm.com>; Andrew Morton <akpm@linux-founda=
tion.org>; kasan-dev@googlegroups.com; linux-mm@kvack.org; linux-kernel@vge=
r.kernel.org; Weizhao Ouyang <o451686892@gmail.com>; =E8=A2=81=E5=B8=85(Shu=
ai Yuan) <yuanshuai@zeku.com>; =E4=BB=BB=E7=AB=8B=E9=B9=8F(Peng Ren) <renli=
peng@zeku.com>
> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] kasan: fix deadlock in start_report()
>
> On Thu, 9 Feb 2023 at 04:27, Weizhao Ouyang <ouyangweizhao@zeku.com> wrot=
e:
> >
> > From: Weizhao Ouyang <o451686892@gmail.com>
> >
> > From: Shuai Yuan <yuanshuai@zeku.com>
> >
> > Calling start_report() again between start_report() and end_report()
> > will result in a race issue for the report_lock. In extreme cases this
> > problem arose in Kunit tests in the hardware tag-based Kasan mode.
> >
> > For example, when an invalid memory release problem is found,
> > kasan_report_invalid_free() will print error log, but if an MTE
> > exception is raised during the output log, the kasan_report() is
> > called, resulting in a deadlock problem. The kasan_depth not protect
> > it in hardware tag-based Kasan mode.
>
> I think checking report_suppressed() would be cleaner and simpler than ig=
noring all trylock failures. If trylock fails, it does not mean that the cu=
rrent thread is holding it. We of course could do a custom lock which store=
s current->tid in the lock word, but it looks effectively equivalent to che=
cking report_suppressed().
>
>
>
> > Signed-off-by: Shuai Yuan <yuanshuai@zeku.com>
> > Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> > Reviewed-by: Peng Ren <renlipeng@zeku.com>
> > ---
> > Changes in v2:
> > -- remove redundant log
> >
> >  mm/kasan/report.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c index
> > 22598b20c7b7..aa39aa8b1855 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -166,7 +166,7 @@ static inline void fail_non_kasan_kunit_test(void)
> > { }
> >
> >  static DEFINE_SPINLOCK(report_lock);
> >
> > -static void start_report(unsigned long *flags, bool sync)
> > +static bool start_report(unsigned long *flags, bool sync)
> >  {
> >         fail_non_kasan_kunit_test();
> >         /* Respect the /proc/sys/kernel/traceoff_on_warning interface.
> > */ @@ -175,8 +175,13 @@ static void start_report(unsigned long *flags, =
bool sync)
> >         lockdep_off();
> >         /* Make sure we don't end up in loop. */
> >         kasan_disable_current();
> > -       spin_lock_irqsave(&report_lock, *flags);
> > +       if (!spin_trylock_irqsave(&report_lock, *flags)) {
> > +               lockdep_on();
> > +               kasan_enable_current();
> > +               return false;
> > +       }
> >
> > pr_err("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D\n");
> > +       return true;
> >  }
> >
> >  static void end_report(unsigned long *flags, void *addr) @@ -468,7
> > +473,10 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, =
enum kasan_report_ty
> >         if (unlikely(!report_enabled()))
> >                 return;
> >
> > -       start_report(&flags, true);
> > +       if (!start_report(&flags, true)) {
> > +               pr_err("%s: report ignore\n", __func__);
> > +               return;
> > +       }
> >
> >         memset(&info, 0, sizeof(info));
> >         info.type =3D type;
> > @@ -503,7 +511,11 @@ bool kasan_report(unsigned long addr, size_t size,=
 bool is_write,
> >                 goto out;
> >         }
> >
> > -       start_report(&irq_flags, true);
> > +       if (!start_report(&irq_flags, true)) {
> > +               ret =3D false;
> > +               pr_err("%s: report ignore\n", __func__);
> > +               goto out;
> > +       }
> >
> >         memset(&info, 0, sizeof(info));
> >         info.type =3D KASAN_REPORT_ACCESS; @@ -536,7 +548,10 @@ void
> > kasan_report_async(void)
> >         if (unlikely(!report_enabled()))
> >                 return;
> >
> > -       start_report(&flags, false);
> > +       if (!start_report(&flags, false)) {
> > +               pr_err("%s: report ignore\n", __func__);
> > +               return;
> > +       }
> >         pr_err("BUG: KASAN: invalid-access\n");
> >         pr_err("Asynchronous fault: no details available\n");
> >         pr_err("\n");
> > --
> > 2.25.1
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/kasan-dev/20230209031159.2337445-1-ouyangweizhao%40zeku.com.
> ZEKU
> =E4=BF=A1=E6=81=AF=E5=AE=89=E5=85=A8=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=BD=92=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E6=89=80=E5=9C=A8=E7=BB=84=E7=BB=87ZEKU=E6=89=80=E6=9C=89=
=E3=80=82 =E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=
=E7=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=
=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=B8=
=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E6=8A=AB=
=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E4=BC=A0=E6=92=AD=EF=BC=89=E4=
=BD=BF=E7=94=A8=E5=8C=85=E5=90=AB=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E8=8B=
=A5=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=
=E8=AF=B7=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=
=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=B6=E5=88=A0=E9=99=
=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E9=99=84=E4=BB=B6=E3=80=82
> Information Security Notice: The information contained in this mail is so=
lely property of the sender's organization ZEKU. Any use of the information=
 contained herein in any way (including, but not limited to, total or parti=
al disclosure, reproduction, or dissemination) by persons other than the in=
tended recipient(s) is prohibited. If you receive this email in error, plea=
se notify the sender by phone or email immediately and delete it.
