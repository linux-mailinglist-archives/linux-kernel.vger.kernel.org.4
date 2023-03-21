Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978E76C2AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCUGpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCUGps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C44C08;
        Mon, 20 Mar 2023 23:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C2CB8128D;
        Tue, 21 Mar 2023 06:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA22C433EF;
        Tue, 21 Mar 2023 06:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679381140;
        bh=czxHhCfaCVdk9soB0/1dxDDvx9mGKnnmBacpenJG4GE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bsy9un/KUVIh+FL+0DCyEvXrAwxKeanVhnNUdBHhTTBIGbuElztGmMda9LELDf6Mk
         D2wjNUEP7DN42KbIUPxE5FS/HgmBmDUgRxQW9QhWxlNeHGlvvTZKy1LMkyx+jworv6
         heVsOJCXF0NSV7HEv3UQbWIezNWarm9PLm8NPqPvYvTFH2J7hu6yrxg3IxFzCrxkdU
         K3s1LlVEJa4O/t3apDng/4FJdznuLfQ2kByDbHz+6I5jBHF106WbRKyWHg4Aq5rkMh
         au54085OJYiGOrtbN0qQ3D29P1jZCy37caxb8cRu1UAAeotMYhUUoM9zp7WdI26oQX
         1QOJg3c180cqg==
Received: by mail-oi1-f180.google.com with SMTP id bm2so1538724oib.4;
        Mon, 20 Mar 2023 23:45:40 -0700 (PDT)
X-Gm-Message-State: AO0yUKXlE0phmQq/Twq6R8recVdk7onAj2FuZZmBR4PZSiyp4blTbr/o
        dCASglg608DJOPixBGX6kvoitv5fR7nwoktcbSI=
X-Google-Smtp-Source: AK7set8kH3ZLXzYFMaT+HHhOIGloSFQWWkZyR3X+iunWo9f+nF2DHd/2dTCpy3cRgXqMzsAFGw5VRGZT3adpvR08VIE=
X-Received: by 2002:aca:a857:0:b0:384:33df:4dfc with SMTP id
 r84-20020acaa857000000b0038433df4dfcmr298033oie.11.1679381139427; Mon, 20 Mar
 2023 23:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
 <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com> <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
In-Reply-To: <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Mar 2023 15:45:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGL4oBPO6s27Zp15-TvD=y4BuqD24YHzLMJxcbk_Ff3w@mail.gmail.com>
Message-ID: <CAK7LNATGL4oBPO6s27Zp15-TvD=y4BuqD24YHzLMJxcbk_Ff3w@mail.gmail.com>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in /proc/dynamic_debug/control
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 5:00=E2=80=AFAM <jim.cromie@gmail.com> wrote:
>
> On Mon, Mar 20, 2023 at 12:35=E2=80=AFPM Jason Baron <jbaron@akamai.com> =
wrote:
> >
> >
> >
> > On 3/20/23 1:05 AM, jim.cromie@gmail.com wrote:
> > > dynamic-debug METADATA uses KBUILD_MODNAME as:
> > >
> > > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > >          static struct _ddebug  __aligned(8)                     \
> > >          __section("__dyndbg") name =3D {                          \
> > >                  .modname =3D KBUILD_MODNAME,                      \
> > >
> > > This is going amiss for some builtins, ie those enabled here, by:
> > >
> > >      echo module main +pmf > /proc/dynamic_debug_control
> > >      grep =3Dpmf /proc/dynamic_debug/control
> > >
> > > init/main.c:1187 [main]initcall_blacklist =3Dpmf "blacklisting initca=
ll %s\n"
> > > init/main.c:1226 [main]initcall_blacklisted =3Dpmf "initcall %s black=
listed\n"
> > > init/main.c:1432 [main]run_init_process =3Dpmf "  with arguments:\n"
> > > init/main.c:1434 [main]run_init_process =3Dpmf "    %s\n"
> > > init/main.c:1435 [main]run_init_process =3Dpmf "  with environment:\n=
"
> > > init/main.c:1437 [main]run_init_process =3Dpmf "    %s\n"
> >
> >
> > Hi Jim,
> >
> > So if I'm following correctly, this is not a new issue, the 'module'
> > name for dynamic debug has always been this way for builtin.
>
> It is not a new issue - both PM and init-main have been in [main] for som=
e time.
>
> I believe that with
> cfc1d277891e module: Move all into module/
>
> module's module-name joined them, changing from [module] to [main]

Maybe more.

We have almost 100 'main.c' files.

$ find . -name main.c | wc
     97      97    3473





> We could do
> > something simple and just normalize it when we initially create the
> > table, but setting the 'module name' to 'core' or 'builtin' or somethin=
g
> > for all these?
>
> core and builtin would both lump all those separate modules together,
> making it less meaningful.
>
> having stable names independent of M vs Y config choices is imperative, I=
STM.


I do not understand what you mean.


KBUILD_MODNAME is not affected by the y/m configuration.




If an object is a member of a composite object, which
does not necessarily be a real module, KBUILD_MODNAME
refers to the name of the composite.
Otherwise, the basename of the source file.


Examples:


obj-y +=3D alias-name.o
alias-name-objs :=3D foo.o

  -->  KBUILD_MODNAME is "alias-name"



obj-y +=3D foo.o

  -->  KBUILD_MODNAME is "foo"



This is about how you write Makefile code.
CONFIG options are unrelated.







> Also, I dont think "only builtins are affected" captures the whole proble=
m.
> I dont recall amdgpu or other modules changing when built with =3Dy
>
> Theres some subtlety in how KBUILD_MODNAME is set,
> and probably many current users who like its current behavior.
> A new var ?
>
> 1st, I think that anything tristate gets a sensible value,
> but at least some of the builtin-only "modules" get basenames, by default=
.
>
> arch/x86/events/amd/ibs.c:1398 [ibs]force_ibs_eilvt_setup =3D_ "No EILVT
> entry available\n"
> arch/x86/events/intel/pt.c:797 [pt]pt_topa_dump =3D_ "# table @%p, off
> %llx size %zx\n"w=3D%16llx\n"
>
> kvm gets a solid name, because tristate ?
>
> arch/x86/kvm/mmu/mmu.c:6661 [kvm]kvm_mmu_invalidate_mmio_sptes =3D_
> "kvm: kvm [%i]: zapping shadow pages for mmio generation wraparound\n"
> arch/x86/kvm/hyperv.c:1402 [kvm]kvm_hv_set_msr_pw =3D_ "kvm [%i]: vcpu%i
> hv crash (0x%llx 0x%llx 0x%llx 0x%llx 0x%llx)\n"
>
> kvm-intel and kvm-amd get their names elsewhere.
>
> arch/x86/kvm/vmx/nested.c:207 [kvm_intel]nested_vmx_abort =3D_
> "kvm_intel: nested vmx abort, indicator %d\n"
> arch/x86/kvm/vmx/nested.c:913 [kvm_intel]nested_vmx_load_msr =3D_
> "kvm_intel: %s cannot read MSR entry (%u, 0x%08llx)\n"
>
> arch/x86/kvm/svm/avic.c:860 [kvm_amd]get_pi_vcpu_info =3D_ "SVM: %s: use
> GA mode for irq %u\n"
> arch/x86/kvm/svm/avic.c:889 [kvm_amd]avic_pi_update_irte =3D_ "SVM: %s:
> host_irq=3D%#x, guest_irq=3D%#x, set=3D%#x\n"
>
> iow, I dont know..
>
> >
> > Thanks,
> >
> > -Jason



--=20
Best Regards
Masahiro Yamada
