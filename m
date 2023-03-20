Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CFF6C2219
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCTUAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCTUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:00:05 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFFC23A4D;
        Mon, 20 Mar 2023 12:59:57 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id m5so8755017uae.11;
        Mon, 20 Mar 2023 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679342396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m268vwb6IaI3qBMpS+7PChbpVqUmmxk80Jug+90O9CQ=;
        b=nZNN4R8Miq9/MYS8QBKHgu/h6SpYTKBf1vmLjZNtTI/ZF/JuqRehg7vnfJnvRG3053
         tCbEuJMyw7+qg4ovYVB3SOGggNqfn9ThHd+FtBjXsW3DLHWFi6zjFGDTncB9JHczF/Fg
         bibN5YsH15Q6uiRwRPtFOvKpF1KDo+ygA+oFUxZHI5R9ACSLt4r/7Z5XjxHnD4Q3DR0U
         TNwiGezVrgWDYMWqwmkFBAn1RtMj6NdG8CfLVFhEa75aF9scfhn0bQLTLhz7+no2L2RH
         tK+tHmkw+0IbWC0YIwxIMvdspdHAzKZI2sOz1mnCcBH3x0tiemrGVWJtVCnzUmx+uKBS
         TmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m268vwb6IaI3qBMpS+7PChbpVqUmmxk80Jug+90O9CQ=;
        b=GHVIyBZqPEAhq+TJybslVYoHpOcleqWMfWitT8cqNYUNkYGnHgU+3mP2PFKH53ulC1
         Zetgb+e5VCqt9wMeg2+ZQ6ya7o4F4zrRrUYT+TJdmtwdBM/LscfQbLB8kWEPJgBQQafD
         7+ylwS5aYTDZePRXmfKYjhVRNzXy9xHix8tj1PGW+6BnvNhK/voXm6tzhocrU2yvX4rO
         8/byuhMilKZEvG0fzKREtiB5GOOfoimlRhvPPXRorIAAE6OhDA1GXNyF73FuCiLMIYxY
         zNmFJYvwnA8HIMtlf3bM6nNIwndEuIJjLjsnCe7KT/tkMWaXiepv/rq9qByMYTxHfyiS
         wBog==
X-Gm-Message-State: AO0yUKXYBDnGep7xKn6x1IBFcJojQ/kAUkgzBtSoagjtgfq2XbiQCg8Z
        T0v8a7UQ4wKVfpVLpyV0b7LXjZ4gjpY1229V2QE=
X-Google-Smtp-Source: AK7set8/Ce+FNEu9yXXd72gGd87EtZWexme2N1mtw1BEBfcXxjWoDLv1OlA6rhYnzlavcw1KYnr/Vqsd4r4cqYUoj6g=
X-Received: by 2002:a05:6130:304:b0:68b:8665:a73b with SMTP id
 ay4-20020a056130030400b0068b8665a73bmr6485927uab.1.1679342394843; Mon, 20 Mar
 2023 12:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
 <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com>
In-Reply-To: <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com>
From:   jim.cromie@gmail.com
Date:   Mon, 20 Mar 2023 13:59:28 -0600
Message-ID: <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in /proc/dynamic_debug/control
To:     Jason Baron <jbaron@akamai.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:35=E2=80=AFPM Jason Baron <jbaron@akamai.com> wr=
ote:
>
>
>
> On 3/20/23 1:05 AM, jim.cromie@gmail.com wrote:
> > dynamic-debug METADATA uses KBUILD_MODNAME as:
> >
> > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> >          static struct _ddebug  __aligned(8)                     \
> >          __section("__dyndbg") name =3D {                          \
> >                  .modname =3D KBUILD_MODNAME,                      \
> >
> > This is going amiss for some builtins, ie those enabled here, by:
> >
> >      echo module main +pmf > /proc/dynamic_debug_control
> >      grep =3Dpmf /proc/dynamic_debug/control
> >
> > init/main.c:1187 [main]initcall_blacklist =3Dpmf "blacklisting initcall=
 %s\n"
> > init/main.c:1226 [main]initcall_blacklisted =3Dpmf "initcall %s blackli=
sted\n"
> > init/main.c:1432 [main]run_init_process =3Dpmf "  with arguments:\n"
> > init/main.c:1434 [main]run_init_process =3Dpmf "    %s\n"
> > init/main.c:1435 [main]run_init_process =3Dpmf "  with environment:\n"
> > init/main.c:1437 [main]run_init_process =3Dpmf "    %s\n"
>
>
> Hi Jim,
>
> So if I'm following correctly, this is not a new issue, the 'module'
> name for dynamic debug has always been this way for builtin.

It is not a new issue - both PM and init-main have been in [main] for some =
time.

I believe that with
cfc1d277891e module: Move all into module/

module's module-name joined them, changing from [module] to [main]


We could do
> something simple and just normalize it when we initially create the
> table, but setting the 'module name' to 'core' or 'builtin' or something
> for all these?

core and builtin would both lump all those separate modules together,
making it less meaningful.

having stable names independent of M vs Y config choices is imperative, IST=
M.

Also, I dont think "only builtins are affected" captures the whole problem.
I dont recall amdgpu or other modules changing when built with =3Dy

Theres some subtlety in how KBUILD_MODNAME is set,
and probably many current users who like its current behavior.
A new var ?

1st, I think that anything tristate gets a sensible value,
but at least some of the builtin-only "modules" get basenames, by default.

arch/x86/events/amd/ibs.c:1398 [ibs]force_ibs_eilvt_setup =3D_ "No EILVT
entry available\n"
arch/x86/events/intel/pt.c:797 [pt]pt_topa_dump =3D_ "# table @%p, off
%llx size %zx\n"w=3D%16llx\n"

kvm gets a solid name, because tristate ?

arch/x86/kvm/mmu/mmu.c:6661 [kvm]kvm_mmu_invalidate_mmio_sptes =3D_
"kvm: kvm [%i]: zapping shadow pages for mmio generation wraparound\n"
arch/x86/kvm/hyperv.c:1402 [kvm]kvm_hv_set_msr_pw =3D_ "kvm [%i]: vcpu%i
hv crash (0x%llx 0x%llx 0x%llx 0x%llx 0x%llx)\n"

kvm-intel and kvm-amd get their names elsewhere.

arch/x86/kvm/vmx/nested.c:207 [kvm_intel]nested_vmx_abort =3D_
"kvm_intel: nested vmx abort, indicator %d\n"
arch/x86/kvm/vmx/nested.c:913 [kvm_intel]nested_vmx_load_msr =3D_
"kvm_intel: %s cannot read MSR entry (%u, 0x%08llx)\n"

arch/x86/kvm/svm/avic.c:860 [kvm_amd]get_pi_vcpu_info =3D_ "SVM: %s: use
GA mode for irq %u\n"
arch/x86/kvm/svm/avic.c:889 [kvm_amd]avic_pi_update_irte =3D_ "SVM: %s:
host_irq=3D%#x, guest_irq=3D%#x, set=3D%#x\n"

iow, I dont know..

>
> Thanks,
>
> -Jason
