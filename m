Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57974660C58
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 04:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjAGDzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 22:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 22:55:34 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433494D730;
        Fri,  6 Jan 2023 19:55:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9so3728169pll.9;
        Fri, 06 Jan 2023 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io9JV291pxD3lEyIZIhO/R7JWlvh5Do6VoY1gpyqZj0=;
        b=CgtI0SnEE6qOT2lbitacGUfbZ9jO6TghWCNGKN0DHkb9hjJJYfx/9JALIpYeGNIII8
         ++T2oBRCT74f9VeUpn9nAatJWR9xD8GNGY06E6/sEJpr+dtRrYq9aPLMJJOsuT36eiuE
         RjQlqgzrxGEWLT5uTWEBO7+0YbNTy0DnVQPJs7WVALHkgmBQDsC0UCZ+AxA7uHlUEbHc
         jXa9dB5fzVZqrgXzaznN7pGMF40RYDjgZZEjbQ+tzav0RS5rlHZxOSWZA9pLNFGFmuZu
         FcuUtMpVUSF03BTxWaUOr5xt59UFBw1gx2/SppfjmnYThpiPw/B1A7oVi1DL80r41US+
         rS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io9JV291pxD3lEyIZIhO/R7JWlvh5Do6VoY1gpyqZj0=;
        b=qf64QkCdEcNN+Hj85G+5/nB044ETjwkgJZjfLEs6sXtwOcrW9Jz+FNgg3QKo0q+Krk
         gmnC18u3Vgx0xK6ITJpwImbkQG9JI0nYDtuQbJEaQxWck9H6hCK/Imgbx+bXw4ntiHGw
         Qw2yJqUpD1rBdOjnZvImeACBB5LcVjDL6bEA7xdIHAo9EgeXwNsWVQAbkgWLYwHRIzLz
         XrKitcjqilW35/bTmj5T9t+zJUJrkfnE3KzlkQ4jUmDQs0SNiBuuzhm7cpxG+e5Op/VG
         IAPH00dVv40RGy7NtUyD+esO1HQgt3erwf3oCVK/aBnaZDZ0C905gM2m1qW6G7UVszfJ
         89/g==
X-Gm-Message-State: AFqh2koLItjzBETM5UGoGXzX3LRG7GGjIU3yl118MPt4y6lIeG1rA9GP
        THxHZeE55q0LK22tmO3BSkM=
X-Google-Smtp-Source: AMrXdXsLxMilmYx4W0Ui2dbRrEANhbvyboNwyJ4krBoAF3tXUaciJDBTR+vYZaXAwJQWWdea2olW0Q==
X-Received: by 2002:a17:902:c401:b0:189:ba1f:b168 with SMTP id k1-20020a170902c40100b00189ba1fb168mr89754778plk.1.1673063731416;
        Fri, 06 Jan 2023 19:55:31 -0800 (PST)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b0018f6900a183sm1687448ple.140.2023.01.06.19.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 19:55:30 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 565AF104F52; Sat,  7 Jan 2023 10:55:27 +0700 (WIB)
Date:   Sat, 7 Jan 2023 10:55:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y7jtLoPrj71tOWwY@debian.me>
References: <20230101094523.1522109-1-rppt@kernel.org>
 <20230101094523.1522109-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4/vQIDFuqyuXOkFi"
Content-Disposition: inline
In-Reply-To: <20230101094523.1522109-3-rppt@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4/vQIDFuqyuXOkFi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 01, 2023 at 11:45:23AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>=20

No patch description really?

> +Each node may be divided up into a number of blocks called zones which
> +represent ranges within memory. These ranges are usually determined by
> +architectural constraints for accessing the physical memory. A zone is
> +described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each=
 zone
> +has one of the types described below.
> +
> +`ZONE_DMA` and `ZONE_DMA32`
> +  represent memory suitable for DMA by peripheral devices that cannot
> +  access all of the addressable memory. Depending on the architecture,
> +  either of these zone types or even they both can be disabled at build
> +  time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32`` configuration
> +  options. Some 64-bit platforms may need both zones as they support
> +  peripherals with different DMA addressing limitations.
> +
> +`ZONE_NORMAL`
> +  is for normal memory that can be accessed by the kernel all the time. =
DMA
> +  operations can be performed on pages in this zone if the DMA devices s=
upport
> +  transfers to all addressable memory. ZONE_NORMAL is always enabled.
> +
> +`ZONE_HIGHMEM`
> +  is the part of the physical memory that is not covered by a permanent =
mapping
> +  in the kernel page tables. The memory in this zone is only accessible =
to the
> +  kernel using temporary mappings. This zone is available only some 32-b=
it
> +  architectures and is enabled with ``CONFIG_HIGHMEM``.
> +
> +`ZONE_MOVABLE`
> +  is for normal accessible memory, just like ZONE_NORMAL. The difference=
 is
> +  that most pages in ZONE_MOVABLE are movable. That means that while vir=
tual
> +  addresses of these pages do not change, their content may move between
> +  different physical pages. ZONE_MOVABLE is only enabled when one of
> +  `kernelcore`, `movablecore` and `movable_node` parameters is present i=
n the
> +  kernel command line. See :ref:`Page migration <page_migration>` for
> +  additional details.
> +
> +`ZONE_DEVICE`
> +  represents memory residing on devices such as PMEM and GPU. It has dif=
ferent
> +  characteristics than RAM zone types and it exists to provide :ref:`str=
uct
> +  page <Pages>` and memory map services for device driver identified phy=
sical
> +  address ranges. ZONE_DEVICE is enabled with configuration option
> +  ``CONFIG_ZONE_DEVICE``.

I think bullet lists should do the job better, since the zone names are
connected directly to their representations:

---- >8 ----

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physic=
al_memory.rst
index fcf52f1db16b71..d308b11cfcf7f0 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -35,40 +35,36 @@ architectural constraints for accessing the physical me=
mory. A zone is
 described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each z=
one
 has one of the types described below.
=20
-`ZONE_DMA` and `ZONE_DMA32`
-  represent memory suitable for DMA by peripheral devices that cannot
-  access all of the addressable memory. Depending on the architecture,
-  either of these zone types or even they both can be disabled at build
-  time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32`` configuration
-  options. Some 64-bit platforms may need both zones as they support
-  peripherals with different DMA addressing limitations.
+* `ZONE_DMA` and `ZONE_DMA32` represent memory suitable for DMA by periphe=
ral
+  devices that cannot access all of the addressable memory. Depending on t=
he
+  architecture, either of these zone types or even they both can be disabl=
ed
+  at build time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32``
+  configuration options. Some 64-bit platforms may need both zones as they
+  support peripherals with different DMA addressing limitations.
=20
-`ZONE_NORMAL`
-  is for normal memory that can be accessed by the kernel all the time. DMA
-  operations can be performed on pages in this zone if the DMA devices sup=
port
-  transfers to all addressable memory. ZONE_NORMAL is always enabled.
+* `ZONE_NORMAL` is for normal memory that can be accessed by the kernel all
+  the time. DMA operations can be performed on pages in this zone if the D=
MA
+  devices support transfers to all addressable memory. ZONE_NORMAL is alwa=
ys
+  enabled.
=20
-`ZONE_HIGHMEM`
-  is the part of the physical memory that is not covered by a permanent ma=
pping
-  in the kernel page tables. The memory in this zone is only accessible to=
 the
-  kernel using temporary mappings. This zone is available only some 32-bit
-  architectures and is enabled with ``CONFIG_HIGHMEM``.
+* `ZONE_HIGHMEM` is the part of the physical memory that is not covered by=
 a
+  permanent mapping in the kernel page tables. The memory in this zone is =
only
+  accessible to the kernel using temporary mappings. This zone is available
+  only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM``.
=20
-`ZONE_MOVABLE`
-  is for normal accessible memory, just like ZONE_NORMAL. The difference is
-  that most pages in ZONE_MOVABLE are movable. That means that while virtu=
al
-  addresses of these pages do not change, their content may move between
-  different physical pages. ZONE_MOVABLE is only enabled when one of
+* `ZONE_MOVABLE` is for normal accessible memory, just like ZONE_NORMAL. T=
he
+  difference is that most pages in ZONE_MOVABLE are movable. That means th=
at
+  while virtual addresses of these pages do not change, their content may =
move
+  between different physical pages. ZONE_MOVABLE is only enabled when one =
of
   `kernelcore`, `movablecore` and `movable_node` parameters is present in =
the
   kernel command line. See :ref:`Page migration <page_migration>` for
   additional details.
=20
-`ZONE_DEVICE`
-  represents memory residing on devices such as PMEM and GPU. It has diffe=
rent
-  characteristics than RAM zone types and it exists to provide :ref:`struct
-  page <Pages>` and memory map services for device driver identified physi=
cal
-  address ranges. ZONE_DEVICE is enabled with configuration option
-  ``CONFIG_ZONE_DEVICE``.
+* `ZONE_DEVICE` represents memory residing on devices such as PMEM and GPU.
+  It has different characteristics than RAM zone types and it exists to pr=
ovide
+  :ref:`struct page <Pages>` and memory map services for device driver
+  identified physical address ranges. ZONE_DEVICE is enabled with configur=
ation
+  option ``CONFIG_ZONE_DEVICE``.
=20
 It is important to note that many kernel operations can only take place us=
ing
 ZONE_NORMAL so it is the most performance critical zone. Zones are discuss=
ed

> +For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of R=
AM the
> +entire memory will be on node 0 and there will be three zones: ZONE_DMA,
> +ZONE_NORMAL and ZONE_HIGHMEM::
> +
> +  0                                                            2G
> +  +-------------------------------------------------------------+
> +  |                            node 0                           |
> +  +-------------------------------------------------------------+
> +
> +  0         16M                    896M                        2G
> +  +----------+-----------------------+--------------------------+
> +  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
> +  +----------+-----------------------+--------------------------+
> +
> +
> +With a kernel built with ZONE_DMA disabled and ZONE_DMA32 enabled and bo=
oted
> +with `movablecore=3D80%` parameter on an arm64 machine with 16 Gbytes of=
 RAM
> +equally split between two nodes, there will be ZONE_DMA32, ZONE_NORMAL a=
nd
> +ZONE_MOVABLE on node 0, and ZONE_NORMAL and ZONE_MOVABLE on node 1::
> +
> +
> +  1G                                9G                         17G
> +  +--------------------------------+ +--------------------------+
> +  |              node 0            | |          node 1          |
> +  +--------------------------------+ +--------------------------+
> +
> +  1G       4G        4200M          9G          9320M          17G
> +  +---------+----------+-----------+ +------------+-------------+
> +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> +  +---------+----------+-----------+ +------------+-------------+

I see inconsistency of formatting keywords: some are in inline code and some
are not. I'm leaning towards inlining them all:

---- >8 ----

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physic=
al_memory.rst
index d308b11cfcf7f0..83e13166508a20 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -19,14 +19,14 @@ a bank of memory very suitable for DMA near peripheral =
devices.
=20
 Each bank is called a node and the concept is represented under Linux by a
 ``struct pglist_data`` even if the architecture is UMA. This structure is
-always referenced to by it's typedef ``pg_data_t``. A pg_data_t structure
+always referenced to by it's typedef ``pg_data_t``. ``A pg_data_t`` struct=
ure
 for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
 ``nid`` is the ID of that node.
=20
 For NUMA architectures, the node structures are allocated by the architect=
ure
 specific code early during boot. Usually, these structures are allocated
 locally on the memory bank they represent. For UMA architectures, only one
-static pg_data_t structure called ``contig_page_data`` is used. Nodes will
+static ``pg_data_t`` structure called ``contig_page_data`` is used. Nodes =
will
 be discussed further in Section :ref:`Nodes <nodes>`
=20
 Each node may be divided up into a number of blocks called zones which
@@ -35,48 +35,49 @@ architectural constraints for accessing the physical me=
mory. A zone is
 described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each z=
one
 has one of the types described below.
=20
-* `ZONE_DMA` and `ZONE_DMA32` represent memory suitable for DMA by periphe=
ral
-  devices that cannot access all of the addressable memory. Depending on t=
he
-  architecture, either of these zone types or even they both can be disabl=
ed
-  at build time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32``
-  configuration options. Some 64-bit platforms may need both zones as they
-  support peripherals with different DMA addressing limitations.
+* ``ZONE_DMA` and ``ZONE_DMA32`` represent memory suitable for DMA by
+  peripheral devices that cannot access all of the addressable memory.
+  Depending on the architecture, either of these zone types or even they b=
oth
+  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
+  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may n=
eed
+  both zones as they support peripherals with different DMA addressing
+  limitations.
=20
-* `ZONE_NORMAL` is for normal memory that can be accessed by the kernel all
+* ``ZONE_NORMAL`` is for normal memory that can be accessed by the kernel =
all
   the time. DMA operations can be performed on pages in this zone if the D=
MA
-  devices support transfers to all addressable memory. ZONE_NORMAL is alwa=
ys
-  enabled.
+  devices support transfers to all addressable memory. ``ZONE_NORMAL`` is
+  always enabled.
=20
-* `ZONE_HIGHMEM` is the part of the physical memory that is not covered by=
 a
+* ``ZONE_HIGHMEM`` is the part of the physical memory that is not covered =
by a
   permanent mapping in the kernel page tables. The memory in this zone is =
only
   accessible to the kernel using temporary mappings. This zone is available
   only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM``.
=20
-* `ZONE_MOVABLE` is for normal accessible memory, just like ZONE_NORMAL. T=
he
-  difference is that most pages in ZONE_MOVABLE are movable. That means th=
at
-  while virtual addresses of these pages do not change, their content may =
move
-  between different physical pages. ZONE_MOVABLE is only enabled when one =
of
-  `kernelcore`, `movablecore` and `movable_node` parameters is present in =
the
-  kernel command line. See :ref:`Page migration <page_migration>` for
-  additional details.
+* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMA=
L``.
+  The difference is that most pages in ``ZONE_MOVABLE`` are movable. That =
means
+  that while virtual addresses of these pages do not change, their content=
 may
+  move between different physical pages. ``ZONE_MOVABLE`` is only enabled =
when
+  one of ``kernelcore``, ``movablecore`` and ``movable_node`` parameters is
+  present in the kernel command line. See :ref:`Page migration
+  <page_migration>` for additional details.
=20
-* `ZONE_DEVICE` represents memory residing on devices such as PMEM and GPU.
+* ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and G=
PU.
   It has different characteristics than RAM zone types and it exists to pr=
ovide
   :ref:`struct page <Pages>` and memory map services for device driver
-  identified physical address ranges. ZONE_DEVICE is enabled with configur=
ation
-  option ``CONFIG_ZONE_DEVICE``.
+  identified physical address ranges. ``ZONE_DEVICE`` is enabled with
+  configuration option ``CONFIG_ZONE_DEVICE``.
=20
 It is important to note that many kernel operations can only take place us=
ing
-ZONE_NORMAL so it is the most performance critical zone. Zones are discuss=
ed
-further in Section :ref:`Zones <zones>`.
+``ZONE_NORMAL`` so it is the most performance critical zone. Zones are
+discussed further in Section :ref:`Zones <zones>`.
=20
 The relation between node and zone extents is determined by the physical m=
emory
 map reported by the firmware, architectural constraints for memory address=
ing
 and certain parameters in the kernel command line.
=20
 For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of RAM=
 the
-entire memory will be on node 0 and there will be three zones: ZONE_DMA,
-ZONE_NORMAL and ZONE_HIGHMEM::
+entire memory will be on node 0 and there will be three zones: ``ZONE_DMA`=
`,
+``ZONE_NORMAL`` and ``ZONE_HIGHMEM``::
=20
   0                                                            2G
   +-------------------------------------------------------------+
@@ -89,10 +90,11 @@ ZONE_NORMAL and ZONE_HIGHMEM::
   +----------+-----------------------+--------------------------+
=20
=20
-With a kernel built with ZONE_DMA disabled and ZONE_DMA32 enabled and boot=
ed
-with `movablecore=3D80%` parameter on an arm64 machine with 16 Gbytes of R=
AM
-equally split between two nodes, there will be ZONE_DMA32, ZONE_NORMAL and
-ZONE_MOVABLE on node 0, and ZONE_NORMAL and ZONE_MOVABLE on node 1::
+With a kernel built with ``ZONE_DMA`` disabled and ``ZONE_DMA32`` enabled =
and
+booted with ``movablecore=3D80%`` parameter on an arm64 machine with 16 Gb=
ytes of
+RAM equally split between two nodes, there will be ``ZONE_DMA32``,
+``ZONE_NORMAL`` and ``ZONE_MOVABLE`` on node 0, and ``ZONE_NORMAL`` and
+``ZONE_MOVABLE`` on node 1::
=20
=20
   1G                                9G                         17G
@@ -116,7 +118,7 @@ Linux uses a node-local allocation policy to allocate m=
emory from the node
 closest to the running CPU. As processes tend to run on the same CPU, it is
 likely the memory from the current node will be used. The allocation polic=
y can
 be controlled by users as described in
-`Documentation/admin-guide/mm/numa_memory_policy.rst`.
+Documentation/admin-guide/mm/numa_memory_policy.rst.
=20
 Most NUMA architectures maintain an array of pointers to the node
 structures. The actual structures are allocated early during boot when
@@ -127,21 +129,21 @@ boot process by free_area_init() function, described =
later in Section
=20
=20
 Along with the node structures, kernel maintains an array of ``nodemask_t``
-bitmasks called `node_states`. Each bitmask in this array represents a set=
 of
-nodes with particular properties as defined by `enum node_states`:
+bitmasks called ``node_states``. Each bitmask in this array represents a s=
et of
+nodes with particular properties as defined by ``enum node_states``:
=20
-`N_POSSIBLE`
+``N_POSSIBLE``
   The node could become online at some point.
-`N_ONLINE`
+``N_ONLINE``
   The node is online.
-`N_NORMAL_MEMORY`
+``N_NORMAL_MEMORY``
   The node has regular memory.
-`N_HIGH_MEMORY`
+``N_HIGH_MEMORY``
   The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
-  aliased to `N_NORMAL_MEMORY`.
-`N_MEMORY`
+  aliased to ``N_NORMAL_MEMORY``.
+``N_MEMORY``
   The node has memory(regular, high, movable)
-`N_CPU`
+``N_CPU``
   The node has one or more CPUs
=20
 For each node that has a property described above, the bit corresponding t=
o the
@@ -160,7 +162,7 @@ For various operations possible with nodemasks please r=
efer to
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/nodemask.h>`_.
=20
 Among other things, nodemasks are used to provide macros for node traversa=
l,
-namely `for_each_node()` and `for_each_online_node()`.
+namely ``for_each_node()`` and ``for_each_online_node()``.
=20
 For instance, to call a function foo() for each online node::
=20
@@ -180,126 +182,130 @@ Here we briefly describe fields of this structure:
 General
 ~~~~~~~
=20
-`node_zones`
+``node_zones``
   The zones for this node.  Not all of the zones may be populated, but it =
is
   the full list. It is referenced by this node's node_zonelists as well as
   other node's node_zonelists.
=20
-`node_zonelists` The list of all zones in all nodes. This list defines the
-  order of zones that allocations are preferred from. The `node_zonelists`=
 is
-  set up by build_zonelists() in mm/page_alloc.c during the initialization=
 of
+``node_zonelists``
+  The list of all zones in all nodes. This list defines the order of zones
+  that allocations are preferred from. The ``node_zonelists`` is set up by
+  ``build_zonelists()`` in ``mm/page_alloc.c`` during the initialization of
   core memory management structures.
=20
-`nr_zones`
+``nr_zones``
   Number of populated zones in this node.
=20
-`node_mem_map`
+``node_mem_map``
   For UMA systems that use FLATMEM memory model the 0's node (and the only)
-  `node_mem_map` is array of struct pages representing each physical frame.
+  ``node_mem_map`` is array of struct pages representing each physical fra=
me.
=20
-`node_page_ext`
+``node_page_ext``
   For UMA systems that use FLATMEM memory model the 0's (and the only) node
-  `node_mem_map` is array of extensions of struct pages. Available only in=
 the
+  ``node_mem_map`` is array of extensions of struct pages. Available only =
in the
   kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
=20
-`node_start_pfn`
+``node_start_pfn``
   The page frame number of the starting page frame in this node.
=20
-`node_present_pages`
+``node_present_pages``
   Total number of physical pages present in this node.
=20
-`node_spanned_pages`
+``node_spanned_pages``
   Total size of physical page range, including holes.
=20
-`node_size_lock`
+``node_size_lock``
   A lock that protects the fields defining the node extents. Only defined =
when
   at least one of ``CONFIG_MEMORY_HOTPLUG`` or
   ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` configuration options are enabled.
+  ``pgdat_resize_lock()`` and ``pgdat_resize_unlock()`` are provided to
+  manipulate ``node_size_lock`` without checking for ``CONFIG_MEMORY_HOTPL=
UG``
+  or ``CONFIG_DEFERRED_STRUCT_PAGE_INIT``.
=20
-  pgdat_resize_lock() and pgdat_resize_unlock() are provided to manipulate
-  node_size_lock without checking for CONFIG_MEMORY_HOTPLUG or
-  CONFIG_DEFERRED_STRUCT_PAGE_INIT.
-
-`node_id`
+``node_id``
   The Node ID (NID) of the node, starts at 0.
=20
-`totalreserve_pages`
+``totalreserve_pages``
   This is a per~node reserve of pages that are not available to userspace
   allocations.
=20
-`first_deferred_pfn`
+``first_deferred_pfn``
   If memory initialization on large machines is deferred then this is the =
first
   PFN that needs to be initialized. Defined only when
   ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` is enabled
=20
-`deferred_split_queue`
+``deferred_split_queue``
   Per-node queue of huge pages that their split was deferred. Defined only=
 when ``CONFIG_TRANSPARENT_HUGEPAGE`` is enabled.
=20
-`__lruvec`
-  Per-node lruvec holding LRU lists and related parameters. Used only when=
 memory cgroups are disabled. Should not be accessed directly, use mem_cgro=
up_lruvec() to look up lruvecs instead.
+``__lruvec``
+  Per-node lruvec holding LRU lists and related parameters. Used only when
+  memory cgroups are disabled. It should not be accessed directly, use
+  ``mem_cgroup_lruvec()`` to look up lruvecs instead.
=20
 Reclaim control
 ~~~~~~~~~~~~~~~
=20
 See also :ref:`Page Reclaim <page_reclaim>`.
=20
-`kswapd`
+``kswapd``
   Per-node instance of kswapd kernel thread.
=20
-`kswapd_wait`, `pfmemalloc_wait`, `reclaim_wait`
+``kswapd_wait``, ``pfmemalloc_wait``, ``reclaim_wait``
   Workqueues used to synchronize memory reclaim tasks
=20
-`nr_writeback_throttled`
+``nr_writeback_throttled``
   Number of tasks that are throttled waiting on dirty pages to clean.
=20
-`nr_reclaim_start`
+``nr_reclaim_start``
   Number of pages written while reclaim is throttled waiting for writeback.
=20
-`kswapd_order`
+``kswapd_order``
   Controls the order kswapd tries to reclaim
=20
-`kswapd_highest_zoneidx`
+``kswapd_highest_zoneidx``
   The highest zone index to be reclaimed by kswapd
=20
-`kswapd_failures`
+``kswapd_failures``
   Number of runs kswapd was unable to reclaim any pages
=20
-`min_unmapped_pages`
-  Minimal number of unmapped file backed pages that cannot be reclaimed. D=
etermined by vm.min_unmapped_ratio sysctl.
-  Only defined when ``CONFIG_NUMA`` is enabled.
+``min_unmapped_pages``
+  Minimal number of unmapped file backed pages that cannot be reclaimed.
+  Determined by ``vm.min_unmapped_ratio`` sysctl. Only defined when
+  ``CONFIG_NUMA`` is enabled.
=20
-`min_slab_pages`
-  Minimal number of SLAB pages that cannot be reclaimed. Determined by vm.=
min_slab_ratio sysctl.
-  Only defined when ``CONFIG_NUMA`` is enabled
+``min_slab_pages``
+  Minimal number of SLAB pages that cannot be reclaimed. Determined by
+  ``vm.min_slab_ratio sysctl``. Only defined when ``CONFIG_NUMA`` is enabl=
ed
=20
-`flags`
+``flags``
   Flags controlling reclaim behavior.
=20
 Compaction control
 ~~~~~~~~~~~~~~~~~~
=20
-`kcompactd_max_order`
+``kcompactd_max_order``
   Page order that kcompactd should try to achieve.
=20
-`kcompactd_highest_zoneidx`
+``kcompactd_highest_zoneidx``
   The highest zone index to be compacted by kcompactd.
=20
-`kcompactd_wait`
+``kcompactd_wait``
   Workqueue used to synchronizes memory compaction tasks.
=20
-`kcompactd`
+``kcompactd``
   Per-node instance of kcompactd kernel thread.
=20
-`proactive_compact_trigger`
-  Determines if proactive compaction is enabled. Controlled by vm.compacti=
on_proactiveness sysctl.
+``proactive_compact_trigger``
+  Determines if proactive compaction is enabled. Controlled by
+  ``vm.compaction_proactiveness`` sysctl.
=20
 Statistics
 ~~~~~~~~~~
=20
-`per_cpu_nodestats`
+``per_cpu_nodestats``
   Per-CPU VM statistics for the node
=20
-`vm_stat`
+``vm_stat``
   VM statistics for the node.
=20
 .. _zones:

> +For various operations possible with nodemasks please refer to
> +`include/linux/nodemask.h
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/linux/nodemask.h>`_.

Instead of linking to Linus's tree, just inline the source path:

---- >8 ----

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physic=
al_memory.rst
index 83e13166508a20..130880e5c369de 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -158,8 +158,7 @@ For example, for node 2 with normal memory and CPUs, bi=
t 2 will be set in ::
   node_states[N_CPU]
=20
 For various operations possible with nodemasks please refer to
-`include/linux/nodemask.h
-<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/nodemask.h>`_.
+``include/linux/nodemask.h``.
=20
 Among other things, nodemasks are used to provide macros for node traversa=
l,
 namely ``for_each_node()`` and ``for_each_online_node()``.
@@ -175,9 +174,8 @@ For instance, to call a function foo() for each online =
node::
 Node structure
 --------------
=20
-The struct pglist_data is declared in `include/linux/mmzone.h
-<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/mmzone.h>`_.
-Here we briefly describe fields of this structure:
+The struct pglist_data is declared in ``include/linux/mmzone.h``. Here we
+briefly describe fields of this structure:
=20
 General
 ~~~~~~~

> +.. _zones:
> +
> +Zones
> +=3D=3D=3D=3D=3D
> +
> +.. _pages:
> +
> +Pages
> +=3D=3D=3D=3D=3D
> +
> +.. _folios:
> +
> +Folios
> +=3D=3D=3D=3D=3D=3D
> +
> +.. _initialization:
> +
> +Initialization
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Are these sections stubs (no fields list for each types)? If so, add
admonitions to inform readers:

---- >8 ----

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physic=
al_memory.rst
index 130880e5c369de..cf61725d93b229 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -311,17 +311,33 @@ Statistics
 Zones
 =3D=3D=3D=3D=3D
=20
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fi=
elds.
+
 .. _pages:
=20
 Pages
 =3D=3D=3D=3D=3D
=20
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fi=
elds.
+
 .. _folios:
=20
 Folios
 =3D=3D=3D=3D=3D=3D
=20
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fi=
elds.
+
 .. _initialization:
=20
 Initialization
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fi=
elds.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4/vQIDFuqyuXOkFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7jtJwAKCRD2uYlJVVFO
o9QTAQDbBGodyBP5HP2nmRJkZPAFx271nHvGVnAVDjsAVWJ3GgD/RwnTB5Jh9L1h
J03PG3rNO47DCo3XvjX7SaZGH4FzRwk=
=jc5d
-----END PGP SIGNATURE-----

--4/vQIDFuqyuXOkFi--
