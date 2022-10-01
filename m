Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF65F1D68
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJAP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJAP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:58:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456476BD45
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 08:58:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j71so325901pge.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sORIprprumrQdw87b2v0hejMbW9aJuCvibbgd7mO4L0=;
        b=auZgrgGUYrJIFTDtQnnydIjKiQOb2o1UWYm9ILCisU6D1oejfOnpkMC6kLWeNhb9nF
         CrW+YR+mXAIPtmpQGJb96/vu06o4n5DKYTRVuy3BIP1+2eIBaYnf0KTPqfYT8WUfLXqk
         sOE0z2ls3v+OM+C57o1h7paDaGX8lmb8hckmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sORIprprumrQdw87b2v0hejMbW9aJuCvibbgd7mO4L0=;
        b=ArHmq5BrKkqQc05As/5vEuDwucnQ65I/L8io33QLazRJgUKeFViSzeLLYnBcvNK7rH
         YWbA8pqGLwLbb/hPIy5tKEjUSwOKHPhn2f57hQx5yI2gn9bPc/y7NFiCyzkcH1PE9AZD
         OAFM77ms2z3K/owfTM766oL1cDpRqY/lKlP4vkfjOvpHiOIkAF4Xbec1bwK8j+PXsLul
         XkdYRQViA7W0OEkpQd/aKh9gtfdVxTjm9AAaKmn89gIbBUnEhpp+RWiNcfdyrIYcPx1Z
         IUp/l9RGtBRYfYneSqrVGO6mPet6+zOOr+2ZSPTSMsb5i/AhYRKnLVeRN5cx5tRVoW9m
         IMvw==
X-Gm-Message-State: ACrzQf0TEORTlzdSCMxKnsOBQ3e/NJVoVRc73KS7KOQT6X37RBThyj5P
        1sslnGqT0Z2Q1CRLrRlkdLocPw==
X-Google-Smtp-Source: AMsMyM4ZGiO+UdlzmqdRNkrfEi2sQeRL4fOxBFufTE3GL7bIZxWOn5DnPiN7TRR3nQHe0M5/DWJk7g==
X-Received: by 2002:a63:5a41:0:b0:430:673e:1e13 with SMTP id k1-20020a635a41000000b00430673e1e13mr12368758pgm.435.1664639929378;
        Sat, 01 Oct 2022 08:58:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a62d105000000b0053bf1f90188sm4027347pfg.176.2022.10.01.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:58:48 -0700 (PDT)
Date:   Sat, 1 Oct 2022 08:58:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Fox Chen <foxhlchen@gmail.com>, Gary Guo <gary@garyguo.net>,
        Geert Stappers <stappers@stappers.nl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Julian Merkle <me@jvmerkle.de>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Matthew Bakhtiari <dev@mtbk.me>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        =?iso-8859-1?Q?N=E1ndor_Istv=E1n_Kr=E1cser?= <bonifaido@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Petr Mladek <pmladek@suse.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Subject: [GIT PULL] Rust introduction for v6.1-rc1
Message-ID: <202210010816.1317F2C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the initial Rust support for v6.1-rc1. The tree has a recent
base, but has fundamentally been in linux-next for a year and a half[1].
It's been updated based on feedback from the Kernel Maintainer's Summit,
and to gain recent Reviewed-by: tags. Miguel is the primary maintainer,
with me helping where needed/wanted. Our plan is for the tree to switch to
the standard non-rebasing practice once this initial infrastructure series
lands. The contents are the absolute minimum to get Rust code building
in the kernel, with many more interfaces[2] (and drivers[3]) on the way.

Expected conflicts are minimal:
- docs-next: https://lore.kernel.org/lkml/87czbegets.fsf@meer.lwn.net/

Thanks!

-Kees

[1] https://lwn.net/Articles/849849/
[2] https://github.com/Rust-for-Linux/linux/commits/rust
[3] NVMe:   https://github.com/metaspace/rust-linux/commit/d88c3744d6cbdf11767e08bad56cbfb67c4c96d0
    9p:     https://github.com/wedsonaf/linux/commit/9367032607f7670de0ba1537cf09ab0f4365a338
    M1 GPU: https://github.com/AsahiLinux/linux/commits/gpu/rust-wip

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/rust-v6.1-rc1

for you to fetch changes up to 615131b8e9bcd88e2d3ef78a4954ff4abfbb1fb7:

  MAINTAINERS: Rust (2022-09-28 09:05:20 +0200)

----------------------------------------------------------------
Rust introduction for v6.1-rc1

The initial support of Rust-for-Linux comes in roughly 4 areas:

- Kernel internals (kallsyms expansion for Rust symbols, %pA format)

- Kbuild infrastructure (Rust build rules and support scripts)

- Rust crates and bindings for initial minimum viable build

- Rust kernel documentation and samples

Rust support has been in linux-next for a year and a half now, and the
short log doesn't do justice to the number of people who have contributed
both to the Linux kernel side but also to the upstream Rust side to
support the kernel's needs. Thanks to these 173 people, and many more,
who have been involved in all kinds of ways:

Miguel Ojeda, Wedson Almeida Filho, Alex Gaynor, Boqun Feng, Gary Guo,
Björn Roy Baron, Andreas Hindborg, Adam Bratschi-Kaye, Benno Lossin,
Maciej Falkowski, Finn Behrens, Sven Van Asbroeck, Asahi Lina, FUJITA
Tomonori, John Baublitz, Wei Liu, Geoffrey Thomas, Philip Herron,
Arthur Cohen, David Faust, Antoni Boucher, Philip Li, Yujie Liu,
Jonathan Corbet, Greg Kroah-Hartman, Paul E. McKenney, Josh Triplett,
Kent Overstreet, David Gow, Alice Ryhl, Robin Randhawa, Kees Cook,
Nick Desaulniers, Matthew Wilcox, Linus Walleij, Joe Perches, Michael
Ellerman, Petr Mladek, Masahiro Yamada, Arnaldo Carvalho de Melo,
Andrii Nakryiko, Konstantin Shelekhin, Rasmus Villemoes, Konstantin
Ryabitsev, Stephen Rothwell, Andy Shevchenko, Sergey Senozhatsky, John
Paul Adrian Glaubitz, David Laight, Nathan Chancellor, Jonathan
Cameron, Daniel Latypov, Shuah Khan, Brendan Higgins, Julia Lawall,
Laurent Pinchart, Geert Uytterhoeven, Akira Yokosawa, Pavel Machek,
David S. Miller, John Hawley, James Bottomley, Arnd Bergmann,
Christian Brauner, Dan Robertson, Nicholas Piggin, Zhouyi Zhou, Elena
Zannoni, Jose E. Marchesi, Leon Romanovsky, Will Deacon, Richard
Weinberger, Randy Dunlap, Paolo Bonzini, Roland Dreier, Mark Brown,
Sasha Levin, Ted Ts'o, Steven Rostedt, Jarkko Sakkinen, Michal
Kubecek, Marco Elver, Al Viro, Keith Busch, Johannes Berg, Jan Kara,
David Sterba, Connor Kuehl, Andy Lutomirski, Andrew Lunn, Alexandre
Belloni, Peter Zijlstra, Russell King, Eric W. Biederman, Willy
Tarreau, Christoph Hellwig, Emilio Cobos Álvarez, Christian Poveda,
Mark Rousskov, John Ericson, TennyZhuang, Xuanwo, Daniel Paoliello,
Manish Goregaokar, comex, Josh Stone, Stephan Sokolow, Philipp Krones,
Guillaume Gomez, Joshua Nelson, Mats Larsen, Marc Poulhiès, Samantha
Miller, Esteban Blanc, Martin Schmidt, Martin Rodriguez Reboredo,
Daniel Xu, Viresh Kumar, Bartosz Golaszewski, Vegard Nossum, Milan
Landaverde, Dariusz Sosnowski, Yuki Okushi, Matthew Bakhtiari, Wu
XiangCheng, Tiago Lam, Boris-Chengbiao Zhou, Sumera Priyadarsini,
Viktor Garske, Niklas Mohrin, Nándor István Krácser, Morgan Bartlett,
Miguel Cano, Léo Lanteri Thauvin, Julian Merkle, Andreas Reindl,
Jiapeng Chong, Fox Chen, Douglas Su, Antonio Terceiro, SeongJae Park,
Sergio González Collado, Ngo Iok Ui (Wu Yu Wei), Joshua Abraham,
Milan, Daniel Kolsoi, ahomescu, Manas, Luis Gerhorst, Li Hongyu,
Philipp Gesang, Russell Currey, Jalil David Salamé Messina, Jon Olson,
Raghvender, Angelos, Kaviraj Kanagaraj, Paul Römer, Sladyn Nunes,
Mauro Baladés, Hsiang-Cheng Yang, Abhik Jain, Hongyu Li, Sean Nash,
Yuheng Su, Peng Hao, Anhad Singh, Roel Kluin, Sara Saa, Geert
Stappers, Garrett LeSage, IFo Hancroft, and Linus Torvalds.

----------------------------------------------------------------
Boqun Feng (2):
      kallsyms: use `ARRAY_SIZE` instead of hardcoded size
      kallsyms: avoid hardcoding buffer size

Daniel Xu (1):
      scripts: add `is_rust_module.sh`

Gary Guo (1):
      vsprintf: add new `%pA` format specifier

Miguel Ojeda (22):
      kallsyms: add static relationship between `KSYM_NAME_LEN{,_BUFFER}`
      kallsyms: support "big" kernel symbols
      kallsyms: increase maximum kernel symbol length to 512
      rust: add C helpers
      rust: import upstream `alloc` crate
      rust: adapt `alloc` crate to the kernel
      rust: add `compiler_builtins` crate
      rust: add `macros` crate
      rust: add `bindings` crate
      rust: export generated symbols
      scripts: checkpatch: diagnose uses of `%pA` in the C side as errors
      scripts: checkpatch: enable language-independent checks for Rust
      scripts: decode_stacktrace: demangle Rust symbols
      scripts: add `generate_rust_analyzer.py`
      scripts: add `generate_rust_target.rs`
      scripts: add `rust_is_available.sh`
      rust: add `.rustfmt.toml`
      Kbuild: add Rust support
      docs: add Rust documentation
      x86: enable initial Rust support
      samples: add first Rust examples
      MAINTAINERS: Rust

Wedson Almeida Filho (1):
      rust: add `kernel` crate

 .gitignore                                   |    6 +
 .rustfmt.toml                                |   12 +
 Documentation/core-api/printk-formats.rst    |   10 +
 Documentation/doc-guide/kernel-doc.rst       |    3 +
 Documentation/index.rst                      |    1 +
 Documentation/kbuild/kbuild.rst              |   17 +
 Documentation/kbuild/makefiles.rst           |   50 +-
 Documentation/process/changes.rst            |   41 +
 Documentation/rust/arch-support.rst          |   19 +
 Documentation/rust/coding-guidelines.rst     |  216 ++
 Documentation/rust/general-information.rst   |   79 +
 Documentation/rust/index.rst                 |   22 +
 Documentation/rust/quick-start.rst           |  232 ++
 MAINTAINERS                                  |   18 +
 Makefile                                     |  172 +-
 arch/Kconfig                                 |    6 +
 arch/x86/Kconfig                             |    1 +
 arch/x86/Makefile                            |   10 +
 include/linux/compiler_types.h               |    6 +-
 include/linux/kallsyms.h                     |    2 +-
 init/Kconfig                                 |   46 +-
 kernel/configs/rust.config                   |    1 +
 kernel/kallsyms.c                            |   26 +-
 kernel/livepatch/core.c                      |    4 +-
 lib/Kconfig.debug                            |   34 +
 lib/vsprintf.c                               |   13 +
 rust/.gitignore                              |    8 +
 rust/Makefile                                |  381 ++++
 rust/alloc/README.md                         |   33 +
 rust/alloc/alloc.rs                          |  440 ++++
 rust/alloc/borrow.rs                         |  498 ++++
 rust/alloc/boxed.rs                          | 2028 +++++++++++++++++
 rust/alloc/collections/mod.rs                |  156 ++
 rust/alloc/lib.rs                            |  244 ++
 rust/alloc/raw_vec.rs                        |  527 +++++
 rust/alloc/slice.rs                          | 1204 ++++++++++
 rust/alloc/vec/drain.rs                      |  186 ++
 rust/alloc/vec/drain_filter.rs               |  145 ++
 rust/alloc/vec/into_iter.rs                  |  366 +++
 rust/alloc/vec/is_zero.rs                    |  120 +
 rust/alloc/vec/mod.rs                        | 3140 ++++++++++++++++++++++++++
 rust/alloc/vec/partial_eq.rs                 |   49 +
 rust/bindgen_parameters                      |   21 +
 rust/bindings/bindings_helper.h              |   13 +
 rust/bindings/lib.rs                         |   53 +
 rust/compiler_builtins.rs                    |   63 +
 rust/exports.c                               |   21 +
 rust/helpers.c                               |   51 +
 rust/kernel/allocator.rs                     |   64 +
 rust/kernel/error.rs                         |   59 +
 rust/kernel/lib.rs                           |   78 +
 rust/kernel/prelude.rs                       |   20 +
 rust/kernel/print.rs                         |  198 ++
 rust/kernel/str.rs                           |   72 +
 rust/macros/helpers.rs                       |   51 +
 rust/macros/lib.rs                           |   72 +
 rust/macros/module.rs                        |  282 +++
 samples/Kconfig                              |    2 +
 samples/Makefile                             |    1 +
 samples/rust/Kconfig                         |   30 +
 samples/rust/Makefile                        |    5 +
 samples/rust/hostprogs/.gitignore            |    3 +
 samples/rust/hostprogs/Makefile              |    5 +
 samples/rust/hostprogs/a.rs                  |    7 +
 samples/rust/hostprogs/b.rs                  |    5 +
 samples/rust/hostprogs/single.rs             |   12 +
 samples/rust/rust_minimal.rs                 |   38 +
 scripts/.gitignore                           |    1 +
 scripts/Kconfig.include                      |    6 +-
 scripts/Makefile                             |    3 +
 scripts/Makefile.build                       |   60 +
 scripts/Makefile.debug                       |    8 +
 scripts/Makefile.host                        |   34 +-
 scripts/Makefile.lib                         |   12 +
 scripts/Makefile.modfinal                    |    8 +-
 scripts/cc-version.sh                        |   12 +-
 scripts/checkpatch.pl                        |   12 +-
 scripts/decode_stacktrace.sh                 |   14 +
 scripts/generate_rust_analyzer.py            |  135 ++
 scripts/generate_rust_target.rs              |  182 ++
 scripts/is_rust_module.sh                    |   16 +
 scripts/kallsyms.c                           |   53 +-
 scripts/kconfig/confdata.c                   |   75 +
 scripts/min-tool-version.sh                  |    6 +
 scripts/rust_is_available.sh                 |  160 ++
 scripts/rust_is_available_bindgen_libclang.h |    2 +
 tools/include/linux/kallsyms.h               |    2 +-
 tools/lib/perf/include/perf/event.h          |    2 +-
 tools/lib/symbol/kallsyms.h                  |    2 +-
 89 files changed, 12552 insertions(+), 51 deletions(-)
 create mode 100644 .rustfmt.toml
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/coding-guidelines.rst
 create mode 100644 Documentation/rust/general-information.rst
 create mode 100644 Documentation/rust/index.rst
 create mode 100644 Documentation/rust/quick-start.rst
 create mode 100644 kernel/configs/rust.config
 create mode 100644 rust/.gitignore
 create mode 100644 rust/Makefile
 create mode 100644 rust/alloc/README.md
 create mode 100644 rust/alloc/alloc.rs
 create mode 100644 rust/alloc/borrow.rs
 create mode 100644 rust/alloc/boxed.rs
 create mode 100644 rust/alloc/collections/mod.rs
 create mode 100644 rust/alloc/lib.rs
 create mode 100644 rust/alloc/raw_vec.rs
 create mode 100644 rust/alloc/slice.rs
 create mode 100644 rust/alloc/vec/drain.rs
 create mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/into_iter.rs
 create mode 100644 rust/alloc/vec/is_zero.rs
 create mode 100644 rust/alloc/vec/mod.rs
 create mode 100644 rust/alloc/vec/partial_eq.rs
 create mode 100644 rust/bindgen_parameters
 create mode 100644 rust/bindings/bindings_helper.h
 create mode 100644 rust/bindings/lib.rs
 create mode 100644 rust/compiler_builtins.rs
 create mode 100644 rust/exports.c
 create mode 100644 rust/helpers.c
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/str.rs
 create mode 100644 rust/macros/helpers.rs
 create mode 100644 rust/macros/lib.rs
 create mode 100644 rust/macros/module.rs
 create mode 100644 samples/rust/Kconfig
 create mode 100644 samples/rust/Makefile
 create mode 100644 samples/rust/hostprogs/.gitignore
 create mode 100644 samples/rust/hostprogs/Makefile
 create mode 100644 samples/rust/hostprogs/a.rs
 create mode 100644 samples/rust/hostprogs/b.rs
 create mode 100644 samples/rust/hostprogs/single.rs
 create mode 100644 samples/rust/rust_minimal.rs
 create mode 100755 scripts/generate_rust_analyzer.py
 create mode 100644 scripts/generate_rust_target.rs
 create mode 100755 scripts/is_rust_module.sh
 create mode 100755 scripts/rust_is_available.sh
 create mode 100644 scripts/rust_is_available_bindgen_libclang.h

-- 
Kees Cook
