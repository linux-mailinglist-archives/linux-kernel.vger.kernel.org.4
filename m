Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609BD7164A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjE3OpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjE3OpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:45:23 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A409C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:45:21 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f804665702so471121cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685457921; x=1688049921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e87+GoeLqhaa8unVAxPgavJ7v9maVdtg7IMA/NaO2w=;
        b=nYqYGF4VmEviE/FRNNKsX9vhE2Gds4LTsUsWCRSSdUDel6GUHG2Iwx6vWMoPKdGb6h
         UQx0jCHSu4McoS+Xv7qjfWCoeTE6QhRG3evxqHjU23tJCv5649g4L8BtrTfAyVMUpsLS
         7riDDcXhLgDw2xIojkBO0XAsWaf9EncupMSSJo2lvtrSIiwSnMzvQwCq8gWmXLp59sT/
         Y7piek8T5EBzXY4nW49V/EJ2WBVD9NX+r5GorObBdGHcsavo+iuMSYPHhVuLWJCLUpt9
         ZNnlx83G62nJxpj4Tp9hRIsHFcZCBI6YjDSNXFP7PvSOcyBKwZNaNZqlt9m2IRRkQfxd
         8pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457921; x=1688049921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e87+GoeLqhaa8unVAxPgavJ7v9maVdtg7IMA/NaO2w=;
        b=JEFeFof/djVlquTJTzqdYEgsU7x6CGY+5irZXNB5Qs1C/M1lz0uD/LLrLlAKiQ7UaC
         L2/CccxmfQBVCLhIL5gfxON0TVaAyp8aY4JdGh3B6LqLSOil+56AYy7hr76ZZlO+2umX
         0HPzUsfF4KE3plZYVpe2lknlaaQNvTH25Lpcw91CkeiYMu6JFCcuuPkmW/YpaNDcnRmj
         on+TO5w+BT0vkgkOKqwjxrFbVf0xQnb7l2w9uuWqzprXr13vIlONSwXwblYmtRx/kiao
         cFx0pzhob1BU0A0wnDLpLih/CH0VzNgEQ39nskA/+XqwJUO8JOfr1icL1i3IE09XFIoW
         S6vA==
X-Gm-Message-State: AC+VfDxDWltK7RAa23Ugr87wiMnyXJTKJgs0+ueAVxbCHvXC0kHAplHd
        IAMw8Su6oEKMHasOHz3cmK5hsh1JINYWOZlJe2aBRg==
X-Google-Smtp-Source: ACHHUZ4RaRDP68G+JY6UO+woYpKioOkPNB/HvGSiqmLiLo3ig82Z/M3tw0ZG5Npw2sUz/YXn8qOzr4ZQW10DY31gfdU=
X-Received: by 2002:ac8:5c13:0:b0:3e3:8c75:461 with SMTP id
 i19-20020ac85c13000000b003e38c750461mr165716qti.6.1685457920769; Tue, 30 May
 2023 07:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com> <ZHWCPXKo2fFJmtlT@tassilo>
 <CAP-5=fXXykcwjXjd+W=8Eez79JhmuKhf1Z-1R_8+AD4XdY4a8A@mail.gmail.com> <ZHWs4o9SBqfspNds@tassilo>
In-Reply-To: <ZHWs4o9SBqfspNds@tassilo>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 May 2023 07:45:09 -0700
Message-ID: <CAP-5=fU0o1iKL2c35sNN9XNvzdufQhSAYn0DiE3hnvft4aAsmQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Address some perf memory/data size issues
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:59=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> > BSS won't count toward file size, which the patches were primarily
> > going after - but checking the size numbers I have miscalculated from
> > reading size's output that I'm not familiar with. The numbers are
> > still improved, but I just see a 37kb saving, with 5kb more in
> > .rodata. Something but not much. .data.rel.ro is larger, which imo is
> > good, but those pages will still be dirtied so a mute point wrt file
> > size and memory overhead.
>
> The way perf is written (lots of separate code depending on a single high=
 level
> switch) most pages probably won't be dirtied.

For data everything is relocated when perf is loaded. Setting a
breakpoint on main and then dumping smaps (edited for brevity) I see:
```
555555554000-5555555f8000 r--p 00000000 fe:01 32936368
  /tmp/perf/perf
Size:                656 kB
Pss:                 656 kB
Pss_Dirty:             0 kB
5555555f8000-555555828000 r-xp 000a4000 fe:01 32936368
  /tmp/perf/perf
Size:               2240 kB
Pss:                  32 kB
Pss_Dirty:             8 kB
555555828000-555555f23000 r--p 002d4000 fe:01 32936368
  /tmp/perf/perf
Size:               7148 kB
Pss:                  64 kB
Pss_Dirty:             0 kB
555555f23000-555555f6d000 r--p 009cf000 fe:01 32936368
  /tmp/perf/perf
Size:                296 kB
Pss:                 288 kB
Pss_Dirty:           288 kB
555555f6d000-555555f87000 rw-p 00a19000 fe:01 32936368
  /tmp/perf/perf
Size:                104 kB
Pss:                 104 kB
Pss_Dirty:           104 kB
```
These are roughly header, text, .rodata, .data.rel.ro, .data. So at
the point we enter main we have 392kB of dirty pages in .data.rel.ro
and .data.

For x86 a large contributor to the relocations comes from the insn-x86.c te=
st:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/arch/x86/tests/insn-x86.c?h=3Dperf-tools-next#n21
The test_data_32 and test_data_64 arrays are 75,024 bytes and 93,600
bytes respectively and are in .data.rel.ro, they account for nearly
40% of it.

In gdb at main entry:
```
(gdb) p test_data_32[0]
$1 =3D {data =3D "\017\061", '\000' <repeats 12 times>, expected_length =3D
2, expected_rel =3D 0,
 expected_op_str =3D 0x555555866adc "", expected_branch_str =3D 0x555555866=
adc "",
 asm_rep =3D 0x55555586fa2a "0f 31", ' ' <repeats 16 times>, "\trdtsc  "}
```
you can see that all the strings in test_data_32 have been relocated
(even though we haven't run any part of perf yet) and are pointing to
data in .rodata. To avoid these relocations for the output of
jevents.py (pmu-events.c) all the strings are merged into a big string
and then the offsets within the string are stored - no relocations
means everything goes in the nice non-dirty .rodata. As the data in
the insn-x86.c test is also generated then a similar trick could be
performed. There is also the possibility to separate all the perf
builtins into libraries...

Thanks,
Ian

> >
> > For huge pages I thought it was correct that things are aligned by max
> > page size which I thought on x86-64 was 2MB, so I tried:
> > EXTRA_LDFLAGS=3D"-z max-page-size=3D4096"
> > but it made no difference to anything, and with:
> > EXTRA_CFLAGS=3D"-Wl,-z,max-page-size=3D4096"
> > EXTRA_CXXFLAGS=3D"-Wl,-z,max-page-size=3D4096"
> > file size just got worse.
>
> The default alignment to 2MB was dropped in the GNU toolchain in 2018 or
> so.
>
> -Andi
