Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C206AE4AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCGP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCGP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:28:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583341BB;
        Tue,  7 Mar 2023 07:28:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y11so14502946plg.1;
        Tue, 07 Mar 2023 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678202918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+V4Z/ZreKFcCZIKkBCL/hI7NjrVggrsNI+bBQV2tKug=;
        b=E5ezbPcHpNCv8XzebMiopBUEe/sd7oIEyIHqzDqEnmjpEboE4TQpa5LJvD7ykfSh6G
         bxKh1D4VqiUr9fJLTmw4g98uWyBwgSUIrjR6WvM2tAHIMIwmmLYPsGmyxArvSSOetzzE
         bdb+3kbtrJX/cVybAL11ab7dp6mM9sxKmnuIfRbXyougeUZ7ym1Wji/VhUaB/UkohXgN
         3ZZ95YKfgGDgU86VwFyQ9ZFINJ7F53WghiyDW7DLOTL100wxGTMtDFNi5tmdGNBOQEhH
         aPl5vBMHNFnc/TMeWKZ/EbeqYsRFcJDtPXiVlVsAgGj350OeyxyU6Stm9xkPpsYzDgpR
         nTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V4Z/ZreKFcCZIKkBCL/hI7NjrVggrsNI+bBQV2tKug=;
        b=4r9eAUFl/Wl1m4jNaO9S0NIe51BzZr+uEsVcnSwPCDg2p4JcaSYUnX7omdhM8SP0DE
         m4tyRjLHW+dENnsBJRQlZ46dcKi5j+n5Peqz5mXDuahYc30myhP6KR8ocXqENZUBRPKe
         /rbeaxMJWVoSeCwVxRm1Uf7m1CvM8I+pMLaYcuMzNJJa6/x0YxZFpElYXbiFFkBXiSTR
         GBmLbrPvSJfzHCsd9VIO2mjBFczaGjFsNPjl2oYLY6UqPjAgMpAhwIBh/OEaCDGrYwDJ
         amiJuarEoUV7+KIHJvy7HJmH/QyZMaayhIBuG57Si5dC+V+ha8ATPx81zSmgSy7gmw/0
         sUTg==
X-Gm-Message-State: AO0yUKVnQLBiApScKJ6B5mYmj54wLgL1Kj+9lbnJU/PbchzGHjDn09of
        sjz5Fz9xdjOKNd/srAbfgmQ=
X-Google-Smtp-Source: AK7set8C6+vqxbmq6GrDX3ecbAGC+nkVDruQMWqB8IPc4KWD01Bl9aSXFYGbUx0wVK3RcXcNOKBskQ==
X-Received: by 2002:a05:6a20:429e:b0:cc:af12:44ea with SMTP id o30-20020a056a20429e00b000ccaf1244eamr16684925pzj.51.1678202917837;
        Tue, 07 Mar 2023 07:28:37 -0800 (PST)
Received: from nvrarch ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id n5-20020a62e505000000b0059072daa002sm7980840pff.192.2023.03.07.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:28:37 -0800 (PST)
Date:   Tue, 7 Mar 2023 23:28:32 +0800
From:   Vinay Varma <varmavinaym@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     alicef@alicef.me, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
Message-ID: <ZAdYIMYAwsOwErIl@nvrarch>
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
 <20230121052507.885734-1-varmavinaym@gmail.com>
 <CAK7LNAT1p=ykc1yruvzRiYthCAuXNcLq9461Mdgz95Z39_MYxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT1p=ykc1yruvzRiYthCAuXNcLq9461Mdgz95Z39_MYxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, got caught up with another project and lost track of this thread.
I have updated the patch and replied to some of the threads inline.
On Sat, Jan 21, 2023 at 06:18:01PM +0900, Masahiro Yamada wrote:
> On Sat, Jan 21, 2023 at 2:25 PM Vinay Varma <varmavinaym@gmail.com> wrote:
> >
> > Adds support for out-of-tree rust modules to use the `rust-analyzer`
> > make target to generate the rust-project.json file.
> >
> > The change involves adding an optional parameter `external_src` to the
> > `generate_rust_analyzer.py` which expects the path to the out-of-tree
> > module's source directory. When this parameter is passed, I have chosen
> > not to add the non-core modules (samples and drivers) into the result
> > since these are not expected to be used in third party modules. Related
> > changes are also made to the Makefile and rust/Makefile allowing the
> > `rust-analyzer` target to be used for out-of-tree modules as well.
> >
> > Link: https://github.com/Rust-for-Linux/linux/pull/914
> > Link: https://github.com/Rust-for-Linux/rust-out-of-tree-module/pull/2
> >
> > Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
> > ---
> >  Makefile                          | 12 +++++++-----
> >  rust/Makefile                     |  6 ++++--
> >  scripts/generate_rust_analyzer.py | 31 ++++++++++++++++++-------------
> >  3 files changed, 29 insertions(+), 20 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f41ec8c8426b..a055a316d2a4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1831,11 +1831,6 @@ rustfmt:
> >  rustfmtcheck: rustfmt_flags = --check
> >  rustfmtcheck: rustfmt
> >
> > -# IDE support targets
> > -PHONY += rust-analyzer
> > -rust-analyzer:
> > -       $(Q)$(MAKE) $(build)=rust $@
> > -
> >  # Misc
> >  # ---------------------------------------------------------------------------
> >
> > @@ -1888,6 +1883,7 @@ help:
> >         @echo  '  modules         - default target, build the module(s)'
> >         @echo  '  modules_install - install the module'
> >         @echo  '  clean           - remove generated files in module directory only'
> > +       @echo  '  rust-analyzer   - generate rust-project.json rust-analyzer support file'
> >         @echo  ''
> >
> >  endif # KBUILD_EXTMOD
> > @@ -2022,6 +2018,12 @@ quiet_cmd_tags = GEN     $@
> >  tags TAGS cscope gtags: FORCE
> >         $(call cmd,tags)
> >
> > +# IDE support targets
> > +PHONY += rust-analyzer
> > +rust-analyzer:
> > +       $(Q)$(MAKE) $(build)=rust $@
> > +
> > +
> 
> 
> Extra empty line.
> 
> 
> >  # Script to generate missing namespace dependencies
> >  # ---------------------------------------------------------------------------
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 8f598a904f38..41c1435cd8d4 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -389,8 +389,10 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
> >         $(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
> >
> >  rust-analyzer:
> > -       $(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
> > -               $(RUST_LIB_SRC) > $(objtree)/rust-project.json
> > +       $(Q)$(srctree)/scripts/generate_rust_analyzer.py \
> > +               $(abs_srctree) $(abs_objtree) \
> > +               $(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
> > +               $(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
> 
> 
> 
> This is equivalent to:
> 
>   >  $(extmod_prefix)/rust-project.json
> 
> 
> 
> See the rule of 'compile_commands.json'.
> 
> 
> 
> 
> 
> 
> 
> >  $(obj)/core.o: private skip_clippy = 1
> >  $(obj)/core.o: private skip_flags = -Dunreachable_pub
> > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> > index ecc7ea9a4dcf..1792f379ee4e 100755
> > --- a/scripts/generate_rust_analyzer.py
> > +++ b/scripts/generate_rust_analyzer.py
> > @@ -6,10 +6,11 @@
> >  import argparse
> >  import json
> >  import logging
> > +import os
> >  import pathlib
> >  import sys
> >
> > -def generate_crates(srctree, objtree, sysroot_src):
> > +def generate_crates(srctree, objtree, sysroot_src, external_src):
> >      # Generate the configuration list.
> >      cfg = []
> >      with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
> > @@ -65,7 +66,7 @@ def generate_crates(srctree, objtree, sysroot_src):
> >          [],
> >          is_proc_macro=True,
> >      )
> > -    crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
> > +    crates[-1]["proc_macro_dylib_path"] = f"{objtree}/rust/libmacros.so"
> >
> >      append_crate(
> >          "build_error",
> > @@ -95,25 +96,28 @@ def generate_crates(srctree, objtree, sysroot_src):
> >          "exclude_dirs": [],
> >      }
> >
> > +    def is_root_crate(build_file, target):
> > +        return os.path.exists(build_file) and target in open(build_file).read()
> > +
> >      # Then, the rest outside of `rust/`.
> >      #
> >      # We explicitly mention the top-level folders we want to cover.
> 
> 
> Huh, not maintainable, unfortunately.
> 
> 
> 
> 
> 
> > -    for folder in ("samples", "drivers"):
> > +    for folder in ("samples", "drivers") if external_src is None else [external_src]:
> >          for path in (srctree / folder).rglob("*.rs"):
> 
> 
> 
> It is odd to add 'srctree' prefix to external module sources.
For external module sources, external_src is an absolute path and hence
srctree is ignored in this call.
> 
> 
> 
> I think rust-project.json is a similar concept to
> compile_commands.json, but it was implemented
> in a different way.
> 
I have not included the changes mentioned to refactor the rust-analyzer
target along the lines of how compile_commands.json has been solved
since it was beyond the scope of this changeset. However, I can take
this up as a follow up changeset.
> 
> 
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
