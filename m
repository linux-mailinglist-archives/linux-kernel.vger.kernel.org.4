Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035E6B4FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCJSJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCJSJl (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:09:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB711F639
        for <Linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:09:38 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32A7P3U6012513
        for <Linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:09:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=hJNK4YjGIkZh/xBt1SCaPXWRkuG/zx4tHLB3rknhD90=;
 b=EFRT3QvIhaeCurT9hImIzONGBF5FFYilYWBQR2ZB2MMQ1HlzkHsk3lKKk1cZ/l5XlZdb
 giXiS7O47RS16FXzs7sd24uzTX80HEmx+x2w8DU5dEOzpbI1dXEWMXtNaq2u0TCAr1gq
 h/xfoikt/6VexpangmeyIY2bWNT90dyGqZ1nz2I3psrg+4NpQc4nmYV756wus1pvfkJx
 86sfyd5JaoZSgeZLIZGRkca5+Qo1SCDbKnxHlWB/UeeT3CnfCYvyA+EgVp+Jj0LS+/HJ
 nf15o0cd7ZSmDWlNULw5GZqLvNd6cN9dmpVYmqsVUfuMjfJbCUZ2nJ5nMzDUCNCHp/aY rw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p7k7kgesm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:09:37 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 10:09:37 -0800
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 10:09:37 -0800
Received: by devvm11876.prn0.facebook.com (Postfix, from userid 343873)
        id 16390A7D446E; Fri, 10 Mar 2023 10:09:31 -0800 (PST)
From:   Sreevani Sreejith <ssreevani@meta.com>
To:     <void@manifault.com>, <psreep@gmail.com>, <bpf@vger.kernel.org>,
        <Linux-kernel@vger.kernel.org>, <andrii@kernel.org>,
        <mykola@meta.com>
CC:     <linux-doc@vger.kernel.org>, Sreevani <ssreevani@meta.com>
Subject: [PATCH V3 bpf-next] BPF, docs: libbpf Overview Document
Date:   Fri, 10 Mar 2023 10:09:28 -0800
Message-ID: <20230310180928.2462527-1-ssreevani@meta.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: P-DHt8ML3dmXVjbF5S1-DUFAo_bhQsew
X-Proofpoint-ORIG-GUID: P-DHt8ML3dmXVjbF5S1-DUFAo_bhQsew
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_09,2023-03-10_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sreevani <ssreevani@meta.com>

Summary: Document that provides an overview of libbpf features for BPF
application development.

Signed-off-by: Sreevani <ssreevani@meta.com>
---
V2->V3: Fixed heading style format throughout the document.

 Documentation/bpf/libbpf/index.rst           |  27 ++-
 Documentation/bpf/libbpf/libbpf_overview.rst | 228 +++++++++++++++++++
 2 files changed, 246 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/bpf/libbpf/libbpf_overview.rst

diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/=
index.rst
index f9b3b252e28f..3ac8c06fb8f4 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -2,23 +2,32 @@
=20
 .. _libbpf:
=20
+######
 libbpf
-=3D=3D=3D=3D=3D=3D
+######
+
+If you are looking to develop BPF applications using the libbpf library, t=
his
+directory contains important documentation that you should read.
+
+To get started, it is recommended to begin with the :doc:`libbpf Overview
+<libbpf_overview>` document, which provides a high-level understanding of =
the
+libbpf APIs and their usage. This will give you a solid foundation to start
+exploring and utilizing the various features of libbpf to develop your BPF
+applications.
=20
 .. toctree::
    :maxdepth: 1
=20
+   libbpf_overview
    API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
    program_types
    libbpf_naming_convention
    libbpf_build
=20
-This is documentation for libbpf, a userspace library for loading and
-interacting with bpf programs.
=20
-All general BPF questions, including kernel functionality, libbpf APIs and
-their application, should be sent to bpf@vger.kernel.org mailing list.
-You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
-mailing list search its `archive <https://lore.kernel.org/bpf/>`_.
-Please search the archive before asking new questions. It very well might
-be that this was already addressed or answered before.
+All general BPF questions, including kernel functionality, libbpf APIs and=
 their
+application, should be sent to bpf@vger.kernel.org mailing list.  You can
+`subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the mailing l=
ist
+search its `archive <https://lore.kernel.org/bpf/>`_.  Please search the a=
rchive
+before asking new questions. It may be that this was already addressed or
+answered before.
diff --git a/Documentation/bpf/libbpf/libbpf_overview.rst b/Documentation/b=
pf/libbpf/libbpf_overview.rst
new file mode 100644
index 000000000000..59ed1c8ce215
--- /dev/null
+++ b/Documentation/bpf/libbpf/libbpf_overview.rst
@@ -0,0 +1,228 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+***************
+libbpf Overview
+***************
+
+libbpf is a C-based library containing a BPF loader that takes compiled BPF
+object files and prepares and loads them into the Linux kernel. libbpf tak=
es the
+heavy lifting of loading, verifying, and attaching BPF programs to various
+kernel hooks, allowing BPF application developers to focus only on BPF pro=
gram
+correctness and performance.
+
+The following are the high-level features supported by libbpf:
+
+* Provides high-level and low-level APIs for user space programs to intera=
ct
+  with BPF programs. The low-level APIs wrap all the bpf system call
+  functionality, which is useful when users need more fine-grained control
+  over the interactions between user space and BPF programs.
+* Provides overall support for the BPF object skeleton generated by bpftoo=
l.
+  The skeleton file simplifies the process for the user space programs to =
access
+  global variables and work with BPF programs.
+* Provides BPF-side APIS, including BPF helper definitions, BPF maps suppo=
rt,
+  and tracing helpers, allowing developers to simplify BPF code writing.
+* Supports BPF CO-RE mechanism, enabling BPF developers to write portable
+  BPF programs that can be compiled once and run across different kernel
+  versions.
+
+This document will delve into the above concepts in detail, providing a de=
eper
+understanding of the capabilities and advantages of libbpf and how it can =
help
+you develop BPF applications efficiently.
+
+BPF App Lifecycle and libbpf APIs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A BPF application consists of one or more BPF programs (either cooperating=
 or
+completely independent), BPF maps, and global variables. The global
+variables are shared between all BPF programs, which allows them to cooper=
ate on
+a common set of data. libbpf provides APIs that user space programs can us=
e to
+manipulate the BPF programs by triggering different phases of a BPF applic=
ation
+lifecycle.
+
+The following section provides a brief overview of each phase in the BPF l=
ife
+cycle:
+
+* **Open phase**. In this phase, libbpf parses the BPF
+  object file and discovers BPF maps, BPF programs, and global variables. =
After
+  a BPF app is opened, user space apps can make additional adjustments
+  (setting BPF program types, if necessary; pre-setting initial values for
+  global variables, etc.) before all the entities are created and loaded.
+
+* **Load phase**. In the load phase, libbpf creates BPF
+  maps, resolves various relocations, and verifies and loads BPF programs =
into
+  the kernel. At this point, libbpf validates all the parts of a BPF appli=
cation
+  and loads the BPF program into the kernel, but no BPF program has yet be=
en
+  executed. After the load phase, it=E2=80=99s possible to set up the init=
ial BPF map
+  state without racing with the BPF program code execution.
+
+* **Attachment phase**. In this phase, libbpf
+  attaches BPF programs to various BPF hook points (e.g., tracepoints, kpr=
obes,
+  cgroup hooks, network packet processing pipeline, etc.). During this
+  phase, BPF programs perform useful work such as processing
+  packets, or updating BPF maps and global variables that can be read from=
 user
+  space.
+
+* **Tear down phase**. In the tear down phase,
+  libbpf detaches BPF programs and unloads them from the kernel. BPF maps =
are
+  destroyed, and all the resources used by the BPF app are freed.
+
+BPF Object Skeleton File
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+BPF skeleton is an alternative interface to libbpf APIs for working with B=
PF
+objects. Skeleton code abstract away generic libbpf APIs to significantly
+simplify code for manipulating BPF programs from user space. Skeleton code
+includes a bytecode representation of the BPF object file, simplifying the
+process of distributing your BPF code. With BPF bytecode embedded, there a=
re no
+extra files to deploy along with your application binary.
+
+You can generate the skeleton header file ``(.skel.h)`` for a specific obj=
ect
+file by passing the BPF object to the bpftool. The generated BPF skeleton
+provides the following custom functions that correspond to the BPF lifecyc=
le,
+each of them prefixed with the specific object name:
+
+* ``<name>__open()`` =E2=80=93 creates and opens BPF application (``<name>=
`` stands for
+  the specific bpf object name)
+* ``<name>__load()`` =E2=80=93 instantiates, loads,and verifies BPF applic=
ation parts
+* ``<name>__attach()`` =E2=80=93 attaches all auto-attachable BPF programs=
 (it=E2=80=99s
+  optional, you can have more control by using libbpf APIs directly)
+* ``<name>__destroy()`` =E2=80=93 detaches all BPF programs and
+  frees up all used resources
+
+Using the skeleton code is the recommended way to work with bpf programs. =
Keep
+in mind, BPF skeleton provides access to the underlying BPF object, so wha=
tever
+was possible to do with generic libbpf APIs is still possible even when th=
e BPF
+skeleton is used. It's an additive convenience feature, with no syscalls, =
and no
+cumbersome code.
+
+Other Advantages of Using Skeleton File
+---------------------------------------
+
+* BPF skeleton provides an interface for user space programs to work with =
BPF
+  global variables. The skeleton code memory maps global variables as a st=
ruct
+  into user space. The struct interface allows user space programs to init=
ialize
+  BPF programs before the BPF load phase and fetch and update data from us=
er
+  space afterward.
+
+* The ``skel.h`` file reflects the object file structure by listing out the
+  available maps, programs, etc. BPF skeleton provides direct access to al=
l the
+  BPF maps and BPF programs as struct fields. This eliminates the need for
+  string-based lookups with ``bpf_object_find_map_by_name()`` and
+  ``bpf_object_find_program_by_name()`` APIs, reducing errors due to BPF s=
ource
+  code and user-space code getting out of sync.
+
+* The embedded bytecode representation of the object file ensures that the
+  skeleton and the BPF object file are always in sync.
+
+BPF Helpers
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+libbpf provides BPF-side APIs that BPF programs can use to interact with t=
he
+system. The BPF helpers definition allows developers to use them in BPF co=
de as
+any other plain C function. For example, there are helper functions to pri=
nt
+debugging messages, get the time since the system was booted, interact wit=
h BPF
+maps, manipulate network packets, etc.
+
+For a complete description of what the helpers do, the arguments they take=
, and
+the return value, see the `bpf-helpers
+<https://man7.org/linux/man-pages/man7/bpf-helpers.7.html>`_ man page.
+
+BPF CO-RE (Compile Once =E2=80=93 Run Everywhere)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+BPF programs work in the kernel space and have access to kernel memory and=
 data
+structures. One limitation that BPF applications come across is the lack of
+portability across different kernel versions and configurations. `BCC
+<https://github.com/iovisor/bcc/>`_ is one of the solutions for BPF
+portability. However, it comes with runtime overhead and a large binary si=
ze
+from embedding the compiler with the application.
+
+libbpf steps up the BPF program portability by supporting the BPF CO-RE co=
ncept.
+BPF CO-RE brings together BTF type information, libbpf, and the compiler to
+produce a single executable binary that you can run on multiple kernel ver=
sions
+and configurations.
+
+To make BPF programs portable libbpf relies on the BTF type information of=
 the
+running kernel. Kernel also exposes this self-describing authoritative BTF
+information through ``sysfs`` at ``/sys/kernel/btf/vmlinux``.
+
+You can generate the BTF information for the running kernel with the follo=
wing
+command:
+
+::
+
+  $ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
+
+The command generates a ``vmlinux.h`` header file with all kernel types
+(:doc:`BTF types </bpf/btf>`) that the running kernel uses. Including
+``vmlinux.h`` in your BPF program eliminates dependency on system-wide ker=
nel
+headers.
+
+libbpf enables portability of BPF programs by looking at the BPF program=
=E2=80=99s
+recorded BTF type and relocation information and matching them to BTF
+information (vmlinux) provided by the running kernel. libbpf then resolves=
 and
+matches all the types and fields, and updates necessary offsets and other
+relocatable data to ensure that BPF program=E2=80=99s logic functions corr=
ectly for a
+specific kernel on the host. BPF CO-RE concept thus eliminates overhead
+associated with BPF development and allows developers to write portable BPF
+applications without modifications and runtime source code compilation on =
the
+target machine.
+
+The following code snippet shows how to read the parent field of a kernel
+``task_struct`` using BPF CO-RE and libbf. The basic helper to read a fiel=
d in a
+CO-RE relocatable manner is ``bpf_core_read(dst, sz, src)``, which will re=
ad
+``sz`` bytes from the field referenced by ``src`` into the memory pointed =
to by
+``dst``.
+
+  .. code-block:: C
+    :emphasize-lines: 6
+
+    //...
+    struct task_struct *task =3D (void *)bpf_get_current_task();
+    struct task_struct *parent_task;
+    int err;
+
+    err =3D bpf_core_read(&parent_task, sizeof(void *), &task->parent);
+    if (err) {
+      /* handle error */
+    }
+
+    /* parent_task contains the value of task->parent pointer */
+
+In the code snippet, we first get a pointer to the current ``task_struct``=
 using
+``bpf_get_current_task()``.  We then use ``bpf_core_read()`` to read the p=
arent
+field of task struct into the ``parent_task`` variable. ``bpf_core_read()`=
` is
+just like ``bpf_probe_read_kernel()`` BPF helper, except it records inform=
ation
+about the field that should be relocated on the target kernel. i.e, if the
+``parent`` field gets shifted to a different offset within struct
+``task_struct`` due to some new field added in front of it, libbpf will
+automatically adjust the actual offset to the proper value.
+
+Getting Started with libbpf
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+Check out the `libbpf-bootstrap <https://github.com/libbpf/libbpf-bootstra=
p>`_
+repository with simple examples of using libbpf to build various BPF
+applications.
+
+Also, find the libbpf API documentation `here
+<https://libbpf.readthedocs.io/en/latest/api.html>`_
+
+libbpf and Rust
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+If you are building BPF applications in Rust, it is recommended to use the
+`Libbpf-rs <https://github.com/libbpf/libbpf-rs>`_ library instead of bind=
gen
+bindings directly to libbpf. Libbpf-rs wraps libbpf functionality in
+Rust-idiomatic interfaces and provides libbpf-cargo plugin to handle BPF c=
ode
+compilation and skeleton generation. Using Libbpf-rs will make building us=
er
+space part of the BPF application easier. Note that the BPF program themse=
lves
+must still be written in plain C.
+
+Additional Documentation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+* `Program types and ELF Sections <https://libbpf.readthedocs.io/en/latest=
/program_types.html>`_
+* `API naming convention <https://libbpf.readthedocs.io/en/latest/libbpf_n=
aming_convention.html>`_
+* `Building libbpf <https://libbpf.readthedocs.io/en/latest/libbpf_build.h=
tml>`_
+* `API documentation Convention <https://libbpf.readthedocs.io/en/latest/l=
ibbpf_naming_convention.html#api-documentation-convention>`_
--=20
2.34.1

