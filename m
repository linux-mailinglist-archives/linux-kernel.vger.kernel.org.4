Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0811A687089
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjBAVmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBAVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:42:33 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C912745887
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:42:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h12so30522wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30qk0RU0MvsiqwMFMefnc8fN8q/orSmoi3b87mF+B7I=;
        b=TqujU6QJV3Q6RI0QBxvFMrVN+rq5PSlx/gkHywLHW6mztC0btitvmO0MaRQQIkj9PA
         J3Yh4u3X9/LaZOlzKUbeOylRvYOWfL0r45cDiHBoB1wrrhbTKHM8TE/w0OGbIlu6d5h/
         cfO3Em6kWYVJxI4OgAtMOAwXstf/dGotDj8/oRYooXxbCuDZWTwxe3vePdEz7elAnzAs
         8VERN/oPDX+dPhfkXHLfTDptUegpFo6LPu3umNdjdfnmt3pgMjq67gk75VuchLJD5Lza
         JvQ1QPxLMqsT3/dqJSpB1/yv+9llrEQlILtlqIDyGfJcyeTAD4VhBj+waresLrJ9BANF
         A/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30qk0RU0MvsiqwMFMefnc8fN8q/orSmoi3b87mF+B7I=;
        b=XV0JnzxDNop+kkVmwmORc6y4g+B11XC4AON8pTXwEBRhgy9KNZLpq9rZICD3vZRtmx
         qgzgXY9QoDjReJ4U/Ikt6wGdt14pmsGMCpx9ohJuOcDKvwFH5q2nioLOMqOsGKQiSJK0
         phxKz14Wrl1txykKsKxs4vVj0rl3nbqcdOQkKDmyuX11MxnGNNv1vBeLDILd/lTYCjKc
         ec07S4tRdh2oVZ9Df7JbS+AS8VRtv9om8X1Fo+9DhRSieqGK8Lbd8Adv0Cy7c+eb0P2K
         O5RKEoFz0qFvZC4NkIndesRleab3W/QjEVUknP0G6UHKKSTfTLVTkXUR/RpV6A0K1xzQ
         Owiw==
X-Gm-Message-State: AO0yUKU12mMlr/pthrLOK5/Y2aaDhYRzso2bEM0Mksguqu/LEqY35Y90
        RfB3yAaIRoXNcMIEjSd752mJydm3Fr57veMK34lIWQ==
X-Google-Smtp-Source: AK7set990dQpApFXmEHc5yh1diX+ApafimPeF/PLgIGcGFwZnqhDQmUhZWz4/zrYnmCZEjFDmf9lVQ6kONIxlzAoDuk=
X-Received: by 2002:a5d:6a09:0:b0:2c3:b765:76ed with SMTP id
 m9-20020a5d6a09000000b002c3b76576edmr85975wru.608.1675287750063; Wed, 01 Feb
 2023 13:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20230201015015.359535-1-irogers@google.com> <Y9o4H61YmbOSCDOG@krava>
 <Y9pCY5IcYEqfNgBX@krava> <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
 <Y9rQnu6KPj1t8Rog@krava> <Y9rXzIm3UY7lzYFt@dev-arch.thelio-3990X>
In-Reply-To: <Y9rXzIm3UY7lzYFt@dev-arch.thelio-3990X>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Feb 2023 13:42:17 -0800
Message-ID: <CAP-5=fVpLhV8F+P+tB97zSuY-v_HAv4UYH+5Eo00OM6Lkx5sEQ@mail.gmail.com>
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Feb 1, 2023 at 1:21 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Feb 01, 2023 at 09:50:38PM +0100, Jiri Olsa wrote:
> > On Wed, Feb 01, 2023 at 10:57:40AM -0800, Ian Rogers wrote:
> > > On Wed, Feb 1, 2023 at 2:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 01, 2023 at 11:00:02AM +0100, Jiri Olsa wrote:
> > > > > On Tue, Jan 31, 2023 at 05:50:15PM -0800, Ian Rogers wrote:
> > > > > > Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
> > > > > > HOSTCFLAGS for submake builds. This fixes problems with cross
> > > > > > compilation.
> > > > > >
> > > > > > Tidy to not unnecessarily modify/export CFLAGS, make the override for
> > > > > > prepare and build clearer.
> > > > > >
> > > > > > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > > > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > hum, that seems to build just the fixdep and skip the resolve_btfids binary
> > > > >
> > > > > make[1]: Entering directory '/home/jolsa/kernel/linux-qemu/build'
> > > > >   GEN     Makefile
> > > > >   CALL    ../scripts/checksyscalls.sh
> > > > >   DESCEND bpf/resolve_btfids
> > > > >   HOSTCC  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep.o
> > > > >   HOSTLD  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep-in.o
> > > > >   LINK    /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep
> > > > >   UPD     include/generated/utsversion.h
> > > > >   CC      init/version-timestamp.o
> > > > >   LD      .tmp_vmlinux.btf
> > > > >   BTF     .btf.vmlinux.bin.o
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0x4f0d4> not handled!
> > > > >
> > > > >   ...
> > > > >
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0xaf91cc3> not handled!
> > > > > die__process_unit: DW_TAG_label (0xa) @ <0xb032fa7> not handled!
> > > > >   LD      .tmp_vmlinux.kallsyms1
> > > > >   NM      .tmp_vmlinux.kallsyms1.syms
> > > > >   KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > >   AS      .tmp_vmlinux.kallsyms1.S
> > > > >   LD      .tmp_vmlinux.kallsyms2
> > > > >   NM      .tmp_vmlinux.kallsyms2.syms
> > > > >   KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > >   AS      .tmp_vmlinux.kallsyms2.S
> > > > >   LD      .tmp_vmlinux.kallsyms3
> > > > >   NM      .tmp_vmlinux.kallsyms3.syms
> > > > >   KSYMS   .tmp_vmlinux.kallsyms3.S
> > > > >   AS      .tmp_vmlinux.kallsyms3.S
> > > > >   LD      vmlinux
> > > > >   BTFIDS  vmlinux
> > > > > ../scripts/link-vmlinux.sh: line 277: ./tools/bpf/resolve_btfids/resolve_btfids: No such file or directory
> > > > > make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 127
> > > > > make[2]: *** Deleting file 'vmlinux'
> > > > > make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1264: vmlinux] Error 2
> > > > > make[1]: Leaving directory '/home/jolsa/kernel/linux-qemu/build'
> > > > > make: *** [Makefile:242: __sub-make] Error 2
> > > > >
> > > > > we actually have the hostprogs support in tools/build and we use it for
> > > > > fixdep, I think we should use it also here, I'll check
> > > >
> > > > it doesn't look that bad.. the change below fixes the build for me,
> > > > perhaps we should do that for all the host tools
> > > >
> > > > jirka
> > >
> > > I don't mind this. The fixdep vs all thing is just cause by the
> > > ordering in the Makefile, you can fix by specifying the target or add
> > > this patch:
> > > ```
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -58,11 +58,11 @@ HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \
> > >
> > > LIBS = $(LIBELF_LIBS) -lz
> > >
> > > +all: $(BINARY)
> > > +
> > > export srctree OUTPUT Q
> > > include $(srctree)/tools/build/Makefile.include
> > >
> > > -all: $(BINARY)
> > > -
> > > prepare: $(BPFOBJ) $(SUBCMDOBJ)
> > >
> > > $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> > > ```
> > >
> > > Should we do this and the hostprogs migration as a follow up? There
> > > isn't that much use of hostprogs in tools, but I like that your change
> > > will show HOSTCC rather than CC during compilation. If we use
> > > hostprogs can we just avoid the overrides altogether?
> >
> > right, I think so.. we can now remove it for the BINARY target and
> > then for the rest of 'prepare' once they are converted to hostprogs..
> > not sure how 'hostprogs' will work for library, will need to check
> >
> > I'll try to send the format patch with the fix below tomorrow
> >
> > Nathan, any chance you could test it?
>
>
> Sure thing, would you happen to have a single patch file of what I
> should test? I am a little confused from reading the thread (unless what
> you want tested has not been sent yet).
>
> Cheers,
> Nathan

I resent the change with the 'all' target moved first:
https://lore.kernel.org/lkml/20230201213743.44674-1-irogers@google.com/
but I think Jiri's fix is better.

Thanks,
Ian

> > > > ---
> > > > diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> > > > index ae82da03f9bf..077de3829c72 100644
> > > > --- a/tools/bpf/resolve_btfids/Build
> > > > +++ b/tools/bpf/resolve_btfids/Build
> > > > @@ -1,3 +1,5 @@
> > > > +hostprogs := resolve_btfids
> > > > +
> > > >  resolve_btfids-y += main.o
> > > >  resolve_btfids-y += rbtree.o
> > > >  resolve_btfids-y += zalloc.o
> > > > @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
> > > >
> > > >  $(OUTPUT)%.o: ../../lib/%.c FORCE
> > > >         $(call rule_mkdir)
> > > > -       $(call if_changed_dep,cc_o_c)
> > > > +       $(call if_changed_dep,host_cc_o_c)
> > > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > > index daed388aa5d7..de513fd08535 100644
> > > > --- a/tools/bpf/resolve_btfids/Makefile
> > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
> > > >                   EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > >
> > > >  RM      ?= rm
> > > > +HOSTCC  ?= gcc
> > > > +HOSTLD  ?= ld
> > > > +HOSTAR  ?= ar
> > > >  CROSS_COMPILE =
> > > >
> > > >  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> > > > @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
> > > >  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> > > >  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> > > >
> > > > -CFLAGS += -g \
> > > > +HOSTCFLAGS += -g \
> > > >            -I$(srctree)/tools/include \
> > > >            -I$(srctree)/tools/include/uapi \
> > > >            -I$(LIBBPF_INCLUDE) \
> > > > @@ -73,7 +76,7 @@ CFLAGS += -g \
> > > >
> > > >  LIBS = $(LIBELF_LIBS) -lz
> > > >
> > > > -export srctree OUTPUT CFLAGS Q
> > > > +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
> > > >  include $(srctree)/tools/build/Makefile.include
> > > >
> > > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
