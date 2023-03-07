Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10F6AF759
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCGVQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCGVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:16:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111697FF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:16:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 16so8412469pge.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678223789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq4KUb4AQDQDZAJfCHW99QkUDmJEUq6txcnU3C+LjQ4=;
        b=gMSwBZTgJBJQ4w9QChpBrXq27XNV+GbgdQgzvZrW+Bz1Bps+xs/O1d1UVxqBcZDt+s
         tljQnKT+33xxQWHlmGk5rCRrJ5eUoAuPvBW/hAdGFZs88ItPmGx9/cUpiKkwCt8n1K/5
         avqg9h81nUgqFwMLraXM6fDRZ6o+CnIK7Tl1MP+/C89UvOnldPp5RpHTFDYne7TDr2dW
         mOuiK8t8KZsXD6u4JSvudLe+VUIfV2FOi+6FhPpporVijAHYV+lY2mTkiViUY9/5tz0K
         YBniOLB863c04B/w5VAWznk1GX7lm+Eb+AI6vVryRESFzcnBGRORMaR4J69T7g9YuARz
         yQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq4KUb4AQDQDZAJfCHW99QkUDmJEUq6txcnU3C+LjQ4=;
        b=zodi5CyGjK8nEVt/47iyAzR0ZxLIZ5RqgwGu2NlQFFbMAFd76tDxrG6d6wrWujhNxe
         iwLA7bjX8Yke2Pwmst9TOIyXLW4S1qDMqVD2HLJ1kA9bbnxJnvNs+vQIYQcB8Rvopeha
         YXfvx7xsSCBN+d9wLIgfHCrrVR9J8Wh/Da6JWmYxjf9O1cw7vhEVSwMxuzmKu2m250XL
         GWJ+jkX6K2LMTtgaxQrAc8nsLjCZze2ohpiewC9ByzhLNPe5ms9SzTzYOTLkDzeiUPvj
         ULLtC+yMVLC3QkiYxYKwz9Auqheg4trvsjHCiqEniyzrB9i/S1sBghmfFHQSdvV8cQpf
         oouA==
X-Gm-Message-State: AO0yUKWyOV/O5DrsdNypDRB6fi+Bz07RzCItpXt6CPorGN+eDiu+1Aqw
        G8U+1OzLSkx7gSqqxq5m0tl0RnUT16oQHz6iHY8UXQ==
X-Google-Smtp-Source: AK7set9swkPIU3+FmVnffWCutWKaDjtCc2F5Qzk3K1MmlefOTTgZZaa8Ns3PAoAD3GqD1PlRCrTqynicTSvsvXaeG0I=
X-Received: by 2002:a63:d809:0:b0:503:354c:41ad with SMTP id
 b9-20020a63d809000000b00503354c41admr5317120pgh.11.1678223789186; Tue, 07 Mar
 2023 13:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com> <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Mar 2023 13:16:17 -0800
Message-ID: <CAKwvOdna5NZ0ZTv0pXVVz15=4FLkw7pfFgr6KsRtXRmi2o1uEw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 7, 2023 at 1:11=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> > (a) it shouldn't define and declare a static function in a header file
> >
> >  (b) the resctrl_sched_in() inline function is midesigned to begin with
>
> Fixing "b" would seem to be to just pass "next_p" to the function to
> use instead of "current".

```
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.=
h
index 52788f79786f..f46c0b97334d 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -49,7 +49,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  *   simple as possible.
  * Must be called with preemption disabled.
  */
-static void __resctrl_sched_in(void)
+static void __resctrl_sched_in(struct task_struct *next)
 {
  struct resctrl_pqr_state *state =3D this_cpu_ptr(&pqr_state);
  u32 closid =3D state->default_closid;
@@ -61,13 +61,13 @@ static void __resctrl_sched_in(void)
  * Else use the closid/rmid assigned to this cpu.
  */
  if (static_branch_likely(&rdt_alloc_enable_key)) {
- tmp =3D READ_ONCE(current->closid);
+ tmp =3D READ_ONCE(next->closid);
  if (tmp)
  closid =3D tmp;
  }

  if (static_branch_likely(&rdt_mon_enable_key)) {
- tmp =3D READ_ONCE(current->rmid);
+ tmp =3D READ_ONCE(next->rmid);
  if (tmp)
  rmid =3D tmp;
  }
@@ -88,17 +88,17 @@ static inline unsigned int
resctrl_arch_round_mon_val(unsigned int val)
  return val * scale;
 }

-static inline void resctrl_sched_in(void)
+static inline void resctrl_sched_in(struct task_struct *next)
 {
  if (static_branch_likely(&rdt_enable_key))
- __resctrl_sched_in();
+ __resctrl_sched_in(next);
 }

 void resctrl_cpu_detect(struct cpuinfo_x86 *c);

 #else

-static inline void resctrl_sched_in(void) {}
+static inline void resctrl_sched_in(struct task_struct *next) {}
 static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}

 #endif /* CONFIG_X86_CPU_RESCTRL */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e2c1599d1b37..d970347838a4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -314,7 +314,7 @@ static void update_cpu_closid_rmid(void *info)
  * executing task might have its own closid selected. Just reuse
  * the context switch code.
  */
- resctrl_sched_in();
+ resctrl_sched_in(current);
 }

 /*
@@ -530,7 +530,7 @@ static void _update_task_closid_rmid(void *task)
  * Otherwise, the MSR is updated when the task is scheduled in.
  */
  if (task =3D=3D current)
- resctrl_sched_in();
+ resctrl_sched_in(current);
 }

 static void update_task_closid_rmid(struct task_struct *t)
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 470c128759ea..708c87b88cc1 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -212,7 +212,7 @@ __switch_to(struct task_struct *prev_p, struct
task_struct *next_p)
  switch_fpu_finish();

  /* Load the Intel cache allocation PQR MSR. */
- resctrl_sched_in();
+ resctrl_sched_in(next_p);

  return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4e34b3b68ebd..bb65a68b4b49 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -656,7 +656,7 @@ __switch_to(struct task_struct *prev_p, struct
task_struct *next_p)
  }

  /* Load the Intel cache allocation PQR MSR. */
- resctrl_sched_in();
+ resctrl_sched_in(next_p);

  return prev_p;
 }

```
?

>
> Can you expand about part "a" ... Linux has zillions of static inline fun=
ctions
> in header files to handle CONFIG options. One version is the real McCoy
> while the other is just a stub for the CONFIG=3Dn case.

Right, I had the same question.

Perhaps it's more so that no one calls __resctrl_sched_in, only
resctrl_sched_in, therefor they should be folded into one function?

>
> What's different about this one?
>
> -Tony



--=20
Thanks,
~Nick Desaulniers
