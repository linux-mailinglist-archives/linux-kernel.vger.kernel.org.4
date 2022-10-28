Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C204611B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJ1UFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJ1UFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:05:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6AE1FC;
        Fri, 28 Oct 2022 13:05:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ud5so15509188ejc.4;
        Fri, 28 Oct 2022 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98ZH6bxaeHTtNqFE8fsLgZCssjQAnRpbtSPQxMvUivw=;
        b=NI0fAVJsuMZeFCF9mP1Btmeodw0bx5/GurFR3ZGfZwj+c8L8qWLm6BtbNpe5ZoU/HN
         JxyXTMnQF5wQMHh2jotO4/KDsmiid4v18utEf8Mwr4IqNu1Xo0An9hRJxf3cbngzLZ2D
         jXznW7OaViSYXnVSadr6+nz2bKdMk5ySJ++NhC2sKhEUVUl5TPSyvAKk0f5ppK5SW3p+
         ZJWxydxIXm6mBkJqXvGE7Wm1YA5+SQsdcDOhr42s4tFRCAqhDW1Q9qivfRuGhdX8Fehw
         zHI+ULDBZdg+ZyOxoXro2G4xGV7n8tsitxKUa8KEvLaaapRPgzDwFJyJwB/VNairnQzQ
         wvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98ZH6bxaeHTtNqFE8fsLgZCssjQAnRpbtSPQxMvUivw=;
        b=DwPrNNonSnr1L6MaOdMK2UjQ3pP4CMjL0aNeM9PLoSUGJS/P3fuu/okjZnYMvTe3wk
         /0wWux34pN78i25MXaveNcXy9uTUsGRSw7huQ0bZAufC7Z56RDr6Pz20AlCdQCQVJhWh
         TbQcY462dFEE1qb0MtCvOclRV8s4ZwWO0Vz4Z4t5wCHglgskIYnllUcEF28j2ZvlWFms
         HuZh8f3IRYH76fguvyquaXx7i1wW/l7Wh5sXyjaQTer3HKbYGqyPxj9DpsL+BlXU4kjj
         yXhPyMptq4EYqJQVUeSnoGLcObCjiL/l3fVwrICDRsgSkZSub5Rk2tlEnozsIcpy+luk
         rXKw==
X-Gm-Message-State: ACrzQf21y4Kwu5+q/qzj9tBa7E6y9LTD+u/ju6IcghtG6aaElC8lXKzB
        ksaoKrJMQPCQIxch2Y+yfamgYeVyhhOMPxNrorY=
X-Google-Smtp-Source: AMsMyM7Fa0dwCZTDURB0YKKa8I7Z1YN1AzqEzF8KXo81jw3NWsY3RtR8pIGQDFEo+3ESMObflkOkF9Xf6RMz5Oc1+KI=
X-Received: by 2002:a17:907:c208:b0:7ad:a0df:d4c7 with SMTP id
 ti8-20020a170907c20800b007ada0dfd4c7mr942244ejc.312.1666987498608; Fri, 28
 Oct 2022 13:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <Y1vZKg6UHjdUZt1W@debian> <202210280940.D7A7330@keescook>
In-Reply-To: <202210280940.D7A7330@keescook>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 28 Oct 2022 21:04:22 +0100
Message-ID: <CADVatmNwZUtR5qoWEvSuM6mH1v8PPYePLZKC2Wx2UGZrDNiFRA@mail.gmail.com>
Subject: Re: boot failure of linux-next due to 1248fb6a8201 ("x86/mm:
 Randomize per-cpu entry area")
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 5:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Oct 28, 2022 at 02:29:14PM +0100, Sudip Mukherjee (Codethink) wro=
te:
> > Hi All,
> >
> > Our qemu boots were failing since next-20221024, and a git bisect of
> > next-20221028 showed the bad commit as 1248fb6a8201 ("x86/mm: Randomize=
 per-cpu entry area")
> >
> > After reverting the commit I could boot qemu again with next-20221028.
> >
> > This is my config:
> >
> > make defconfig
> > make kvm_guest.config
> > scripts/config -e KCOV -e KCOV_INSTRUMENT_ALL -e KCOV_ENABLE_COMPARISON=
S -e DEBUG_FS -e DEBUG_KMEMLEAK -e DEBUG_INFO -e KALLSYMS -e KALLSYMS_ALL -=
e NAMESPACES -e UTS_NS -e IPC_NS -e PID_NS -e NET_NS -e CGROUP_PIDS -e MEMC=
G -e USER_NS -e CONFIGFS_FS -e SECURITYFS -e KASAN -e KASAN_INLINE -e FAULT=
_INJECTION -e FAULT_INJECTION_DEBUG_FS -e FAULT_INJECTION_USERCOPY -e FAILS=
LAB -e FAIL_PAGE_ALLOC -e FAIL_MAKE_REQUEST -e FAIL_IO_TIMEOUT -e FAIL_FUTE=
X -e LOCKDEP -e PROVE_LOCKING -e DEBUG_ATOMIC_SLEEP -e PROVE_RCU -e DEBUG_V=
M -e REFCOUNT_FULL -e FORTIFY_SOURCE -e HARDENED_USERCOPY -e LOCKUP_DETECTO=
R -e SOFTLOCKUP_DETECTOR -e HARDLOCKUP_DETECTOR -e BOOTPARAM_HARDLOCKUP_PAN=
IC -e DETECT_HUNG_TASK -e WQ_WATCHDOG -e USB_GADGET -e USB_RAW_GADGET -e TU=
N -e KCSAN -d RANDOMIZE_BASE -e MAC80211_HWSIM -e IEEE802154 -e MAC802154 -=
e IEEE802154_DRIVERS -e IEEE802154_HWSIM -e BT -e BT_HCIVHCI
> > echo "CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D140" >> .config
> > echo "CONFIG_RCU_CPU_STALL_TIMEOUT=3D100" >> .config
> >
> > I will be happy to test any patch or provide any extra log if needed.
> > Though I am not sure how I will collect extra logs (if needed) as there
> > was no output from qemu.
>
> I see KASAN in your config, does this fix it?
>
> https://lore.kernel.org/lkml/166693938482.29415.7034851115705424459.tip-b=
ot2@tip-bot2/

Yes, it does. Thanks.
I can see qemu booting up again. Also, looks like thats already merged
to x86/mm, so I am not sending a Tested-by in reply to that patch.

--=20
Regards
Sudip
