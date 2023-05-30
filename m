Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9671579F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjE3Hxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjE3Hx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164CA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685433159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86u6sl78DgICJcHuIIcJ+/0V6IX2eqyEz7eI/a5g6zI=;
        b=MFVFHII9Pz9/ODg3AU6HwXCR8SVrqbgYwGyrLg/4FewL/RrujmYUHDpzdj0YBfmr5LaYr4
        eRFQfm8JD9igmVw09FevVhWQB1Id0b1CSmh9jGIp/tgiROh6v1nTvhHvKJlU4OiHzpf+x9
        bcXVD5hV+x/ocUPgZadiPiLP83fKKZo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-YglmQXZFMvWS9ojKNmir4A-1; Tue, 30 May 2023 03:52:38 -0400
X-MC-Unique: YglmQXZFMvWS9ojKNmir4A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b05714a774so18215981fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433156; x=1688025156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86u6sl78DgICJcHuIIcJ+/0V6IX2eqyEz7eI/a5g6zI=;
        b=CJ679scnRl7F45E8lQPq29SCnereexmWm9SHNwWCAsDFrG1deeTw9CwoAUS0qHvmju
         gLKb1vs1rtYbILEzELMKIXU0aOTRw1IXJ+rmYl4kYHZE30jdaMubMcdY70/7rfG3O9bZ
         07tyuHIcFoRjst9QcKi8A2JM1XLqa49CzQtUwP2yjM5srocAPt3/jkx8c9QSs2BAdpxA
         6bcS+3rVTIdym+szU/lbFCJxUS6Lf0zdqxKHMgsB3NTtuXOa78yK9vtOuzNZeqvpwYED
         FcO7hXkETme1LyudMNCZ9nYeSWPstJL2vtMnJB9hM9qeBkhUHOluRU6IO4nX7Ebnbi8x
         NGnA==
X-Gm-Message-State: AC+VfDzkLBNNkfjQdkFtK0YVPRQ5mM/RByCw3BoIroJayMcepVXxVwOP
        n0QOKimp9O9VS51apberftzV8inH3NnMKmi0Quqc3+j6vR0wofKdh/nYYMkM0xc1Az1SkxXazgJ
        TK6RLIEoYm7RtHGZ7Nu2lmT6w+jjIvCQK7aewrXLKHQuRd8YQSWw=
X-Received: by 2002:a2e:7e12:0:b0:2b0:2f2f:4943 with SMTP id z18-20020a2e7e12000000b002b02f2f4943mr439719ljc.38.1685433156023;
        Tue, 30 May 2023 00:52:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HCDbjg3tHbwujINIa9ssRiWa5okIh6mQTQ5zy88tNEV561CpVWLrbxgEKPfuWdALD13YhdQYJXue+siT/p0U=
X-Received: by 2002:a2e:7e12:0:b0:2b0:2f2f:4943 with SMTP id
 z18-20020a2e7e12000000b002b02f2f4943mr439704ljc.38.1685433155643; Tue, 30 May
 2023 00:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com> <CANiq72=vTLT1PnbWu4pwNNyMO0S413G3O+_TLcCGLiDGr5fH7Q@mail.gmail.com>
 <CACT4ouf2M1k7SaMgqv1Fj33Wen7UKuUyKp-Y9oer+THiWEebNg@mail.gmail.com> <CANiq72njUr2wv7CA7W9ziRUf8mrVQPFEQfS7=it3zTVhJFvf3A@mail.gmail.com>
In-Reply-To: <CANiq72njUr2wv7CA7W9ziRUf8mrVQPFEQfS7=it3zTVhJFvf3A@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Tue, 30 May 2023 09:52:24 +0200
Message-ID: <CACT4oueo817fw31Wk7UXv7bpdSAZfUCVet4JUK1hZ-X6J6m_wQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, danny@kdrag0n.dev, linux-kernel@vger.kernel.org,
        corbet@lwn.net, joe@perches.com, linux@rasmusvillemoes.dk,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:16=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, May 8, 2023 at 10:59=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@r=
edhat.com> wrote:
> >
> > Originally I sampled manually, but I have crafted a script to collect
> > more data. It's not 100% reliable, but good to get an idea. It reads
> > the leading whitespaces and if >80% of the lines have one kind of
> > indentation, it considers that it's the one used in that file. The
> > results, filtered to show only the relevant ones, are pasted at the
> > end.
>
> This is useful -- thanks a lot for working on collecting it!
>
> > These are some personal conclusions from the script's results:
> > - .py: although the official and most widely used style in the
> > community is 4-space indentation, in Linux tree many files use tabs.
> > What should we do here? 4-space is the clear standard for python...
>
> Yeah, this is the kind of thing that worries me and why I asked --
> what do editors do when they have the config saying it is 4-spaces,
> but the file is tabs? Do they adjust, do they convert the entire file,
> or do they simply start mixing indentation styles? Does the
> `.editorconfig` spec say anything about it? For instance, here is an
> issue about this sort of problem:
>
>     https://github.com/editorconfig/editorconfig-vscode/issues/329
>
> If the rule could be applied only to new files, then it would be
> fairly easy to decide, given the majority uses 4-spaces and it nicely
> aligns with PEP 8, Black, etc. But unless we are quite sure we are not
> annoying developers, I would avoid specifying anything in these cases.

I don't think it's possible to apply only to new files, and if it were
possible, it would be up to each editor plugin, not editorconfig
"core".

What we can do is differentiate some directories, see below.

> In some cases (e.g. few files), you may be able to propose to
> normalize the indentation style treewide for that extension.
>
> > - .rb: only one file in the whole tree
> > - .pm: only 3 files in the whole tree
>
> I guess you could also ignore extensions without many matches in order
> to simplify -- they can always be added later, ideally by their
> maintainers.

Agree

> > - Files with many different indentations, better not to specify them:
> > rst, cocci, tc, xsl, manual pages
> > - Files that we should specify, tab indented: awk, dts, dtsi, dtso, s, =
S
> > - Files that we might specify, with preference for tab indenting but
> > not 100% clear: sh, bash, pl

Not sure what to do with these 3 (sh, bash, pl): a big majority are
tab indented, but there are some files with inconsistent indentations
within the same file (i.e. scripts/get_maintainer.pl). Honestly I
would be tempted of adding them too.

> > - Files in tools/perf/scripts/*/bin/*: there is no clear formatting
> > for any file type, only for .py files that are tab-indented. To get
> > these results I've run my script from tools/perf/scripts directory.
>
> If all Python tab-indented files are in a given folder, then would it
> be possible to provide an `.editorconfig` for that folder, and then
> 4-spaces for the global one? i.e. splitting the problem across folders
> may be a solution (within reason, of course, i.e. as long as we don't
> fill the kernel with `.editorconfig` files... :)

We don't need to create different .editorconfig files. A single
.editorconfig must be read from top to bottom, with the last setting
that matched taking precedence, per the spec.
At the end of this message there is the list of all python files in
the source tree with their indentation style. According to that, we
could use this config:

[*.py]
indent_style =3D space
indent_size =3D 4

[tools/{perf,power,rcu,testing/kunit}/**.py,]
indent_style =3D tab
indent_size =3D 8

> > I'm only aware of Clang and Rust formatter configs in Linux tree, and
> > I think this complies with them. Do you know about any other?
>
> There is `scripts/checkpatch.pl`, which I guess may be counted as one
> since one can fix what it complains about manually (and I think it has
> some "fix in place" support too).

Checkpatch has many rules, but they mostly affect to C files where we
have already set the official style, right?

> There is also `Documentation/devicetree/bindings/.yamllint`.

Indentation is 2 spaces so it's OK, but it has the rule
"trailing-spaces: false". According to yamllint docs: "Use this rule
to forbid trailing spaces at the end of lines". So, setting it to
false should mean that trailing spaces are ALLOWED, correct?

> In addition, some may be using formatters in a default config? e.g.
> Black for some of the Python scripts.

But this is not something we can really support. If someone is using 2
different formatters in the same project, conflicts are expected to
happen. They will need to disable one of them.


These are the type of indentation for each of the python files in the tree:
4spa: ./Documentation/conf.py
tabs: ./Documentation/networking/device_drivers/atm/cxacru-cf.py
2spa: ./Documentation/sphinx/automarkup.py
4spa: ./Documentation/sphinx/cdomain.py
4spa: ./Documentation/sphinx/kernel_abi.py
4spa: ./Documentation/sphinx/kernel_feat.py
4spa: ./Documentation/sphinx/kernel_include.py
4spa: ./Documentation/sphinx/kerneldoc.py
4spa: ./Documentation/sphinx/kernellog.py
4spa: ./Documentation/sphinx/kfigure.py
4spa: ./Documentation/sphinx/load_config.py
4spa: ./Documentation/sphinx/maintainers_include.py
4spa: ./Documentation/sphinx/rstFlatTable.py
tabs: ./Documentation/target/tcm_mod_builder.py
tabs: ./Documentation/trace/postprocess/decode_msr.py
4spa: ./Documentation/userspace-api/media/conf_nitpick.py
4spa: ./arch/ia64/scripts/unwcheck.py
2spa: ./drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
2spa: ./drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
2spa: ./drivers/comedi/drivers/ni_routing/tools/csv_collection.py
2spa: ./drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py
2spa: ./drivers/comedi/drivers/ni_routing/tools/ni_names.py
tabs: ./drivers/staging/greybus/tools/lbtest
4spa: ./scripts/bloat-o-meter
4spa: ./scripts/bpf_doc.py
4spa: ./scripts/checkkconfigsymbols.py
4spa: ./scripts/clang-tools/gen_compile_commands.py
4spa: ./scripts/clang-tools/run-clang-tools.py
4spa: ./scripts/diffconfig
tabs: ./scripts/dtc/dt-extract-compatibles
unknown-0: ./scripts/gdb/linux/__init__.py
4spa: ./scripts/gdb/linux/clk.py
4spa: ./scripts/gdb/linux/config.py
4spa: ./scripts/gdb/linux/cpus.py
4spa: ./scripts/gdb/linux/device.py
4spa: ./scripts/gdb/linux/dmesg.py
4spa: ./scripts/gdb/linux/genpd.py
2spa: ./scripts/gdb/linux/lists.py
4spa: ./scripts/gdb/linux/mm.py
4spa: ./scripts/gdb/linux/modules.py
4spa: ./scripts/gdb/linux/proc.py
4spa: ./scripts/gdb/linux/rbtree.py
4spa: ./scripts/gdb/linux/symbols.py
4spa: ./scripts/gdb/linux/tasks.py
4spa: ./scripts/gdb/linux/timerlist.py
4spa: ./scripts/gdb/linux/utils.py
4spa: ./scripts/gdb/vmlinux-gdb.py
4spa: ./scripts/generate_rust_analyzer.py
tabs: ./scripts/jobserver-exec
4spa: ./scripts/kconfig/tests/auto_submenu/__init__.py
4spa: ./scripts/kconfig/tests/choice/__init__.py
4spa: ./scripts/kconfig/tests/choice_value_with_m_dep/__init__.py
4spa: ./scripts/kconfig/tests/conftest.py
4spa: ./scripts/kconfig/tests/err_recursive_dep/__init__.py
4spa: ./scripts/kconfig/tests/err_recursive_inc/__init__.py
4spa: ./scripts/kconfig/tests/inter_choice/__init__.py
4spa: ./scripts/kconfig/tests/new_choice_with_dep/__init__.py
4spa: ./scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py
4spa: ./scripts/kconfig/tests/preprocess/builtin_func/__init__.py
4spa: ./scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
4spa: ./scripts/kconfig/tests/preprocess/escape/__init__.py
4spa: ./scripts/kconfig/tests/preprocess/variable/__init__.py
tabs: ./scripts/show_delta
4spa: ./scripts/spdxcheck.py
tabs: ./scripts/tracing/draw_functrace.py
4spa: ./tools/cgroup/iocost_coef_gen.py
4spa: ./tools/cgroup/iocost_monitor.py
4spa: ./tools/cgroup/memcg_shrinker.py
4spa: ./tools/cgroup/memcg_slabinfo.py
tabs: ./tools/hv/lsvmbus
8spa: ./tools/hv/vmbus_testing
4spa: ./tools/kvm/kvm_stat/kvm_stat
4spa: ./tools/net/ynl/cli.py
unknown-mix: ./tools/net/ynl/lib/__init__.py
4spa: ./tools/net/ynl/lib/nlspec.py
4spa: ./tools/net/ynl/lib/ynl.py
4spa: ./tools/net/ynl/ynl-gen-c.py
2spa: ./tools/perf/pmu-events/jevents.py
2spa: ./tools/perf/pmu-events/metric.py
4spa: ./tools/perf/pmu-events/metric_test.py
unknown-mix: ./tools/perf/python/tracepoint.py
tabs: ./tools/perf/python/twatch.py
unknown-mix: ./tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Cor=
e.py
8spa: ./tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass=
.py
tabs: ./tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.p=
y
unknown-mix: ./tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Uti=
l.py
tabs: ./tools/perf/scripts/python/arm-cs-trace-disasm.py
tabs: ./tools/perf/scripts/python/check-perf-trace.py
tabs: ./tools/perf/scripts/python/compaction-times.py
8spa: ./tools/perf/scripts/python/event_analyzing_sample.py
tabs: ./tools/perf/scripts/python/export-to-postgresql.py
tabs: ./tools/perf/scripts/python/export-to-sqlite.py
tabs: ./tools/perf/scripts/python/exported-sql-viewer.py
tabs: ./tools/perf/scripts/python/failed-syscalls-by-pid.py
4spa: ./tools/perf/scripts/python/flamegraph.py
4spa: ./tools/perf/scripts/python/futex-contention.py
tabs: ./tools/perf/scripts/python/intel-pt-events.py
tabs: ./tools/perf/scripts/python/libxed.py
tabs: ./tools/perf/scripts/python/mem-phys-addr.py
tabs: ./tools/perf/scripts/python/net_dropmonitor.py
tabs: ./tools/perf/scripts/python/netdev-times.py
tabs: ./tools/perf/scripts/python/powerpc-hcalls.py
tabs: ./tools/perf/scripts/python/sched-migration.py
tabs: ./tools/perf/scripts/python/sctop.py
4spa: ./tools/perf/scripts/python/stackcollapse.py
4spa: ./tools/perf/scripts/python/stat-cpi.py
tabs: ./tools/perf/scripts/python/syscall-counts-by-pid.py
tabs: ./tools/perf/scripts/python/syscall-counts.py
4spa: ./tools/perf/scripts/python/task-analyzer.py
4spa: ./tools/perf/tests/attr.py
2spa: ./tools/perf/tests/shell/lib/perf_json_output_lint.py
2spa: ./tools/perf/util/setup.py
tabs: ./tools/power/pm-graph/bootgraph.py
tabs: ./tools/power/pm-graph/sleepgraph.py
4spa: ./tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
4spa: ./tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
tabs: ./tools/rcu/rcu-cbs.py
tabs: ./tools/testing/kunit/kunit.py
tabs: ./tools/testing/kunit/kunit_config.py
tabs: ./tools/testing/kunit/kunit_json.py
tabs: ./tools/testing/kunit/kunit_kernel.py
tabs: ./tools/testing/kunit/kunit_parser.py
tabs: ./tools/testing/kunit/kunit_printer.py
tabs: ./tools/testing/kunit/kunit_tool_test.py
2spa: ./tools/testing/kunit/qemu_config.py
tabs: ./tools/testing/kunit/qemu_configs/alpha.py
tabs: ./tools/testing/kunit/qemu_configs/arm.py
tabs: ./tools/testing/kunit/qemu_configs/arm64.py
tabs: ./tools/testing/kunit/qemu_configs/i386.py
tabs: ./tools/testing/kunit/qemu_configs/powerpc.py
tabs: ./tools/testing/kunit/qemu_configs/riscv.py
tabs: ./tools/testing/kunit/qemu_configs/s390.py
tabs: ./tools/testing/kunit/qemu_configs/sparc.py
tabs: ./tools/testing/kunit/qemu_configs/x86_64.py
tabs: ./tools/testing/kunit/run_checks.py
4spa: ./tools/testing/selftests/bpf/test_bpftool.py
4spa: ./tools/testing/selftests/bpf/test_bpftool_synctypes.py
4spa: ./tools/testing/selftests/bpf/test_offload.py
4spa: ./tools/testing/selftests/drivers/net/mlxsw/sharedbuffer_configuratio=
n.py
4spa: ./tools/testing/selftests/drivers/sdsi/sdsi_test.py
2spa: ./tools/testing/selftests/exec/binfmt_script.py
4spa: ./tools/testing/selftests/net/devlink_port_split.py
4spa: ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
4spa: ./tools/testing/selftests/tc-testing/TdcPlugin.py
4spa: ./tools/testing/selftests/tc-testing/TdcResults.py
4spa: ./tools/testing/selftests/tc-testing/plugin-lib/buildebpfPlugin.py
4spa: ./tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
4spa: ./tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py
4spa: ./tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
4spa: ./tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py
4spa: ./tools/testing/selftests/tc-testing/tdc.py
4spa: ./tools/testing/selftests/tc-testing/tdc_batch.py
2spa: ./tools/testing/selftests/tc-testing/tdc_config.py
unknown-0: ./tools/testing/selftests/tc-testing/tdc_config_local_template.p=
y
4spa: ./tools/testing/selftests/tc-testing/tdc_helper.py
4spa: ./tools/testing/selftests/tc-testing/tdc_multibatch.py
4spa: ./tools/testing/selftests/tpm2/tpm2.py
4spa: ./tools/testing/selftests/tpm2/tpm2_tests.py
4spa: ./tools/verification/dot2/automata.py
4spa: ./tools/verification/dot2/dot2c
4spa: ./tools/verification/dot2/dot2c.py
4spa: ./tools/verification/dot2/dot2k
4spa: ./tools/verification/dot2/dot2k.py

>
> Cheers,
> Miguel
>


--=20
=C3=8D=C3=B1igo Huguet

