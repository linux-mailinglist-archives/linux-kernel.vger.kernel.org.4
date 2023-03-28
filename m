Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF26CC904
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjC1RTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjC1RTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB01EB46A;
        Tue, 28 Mar 2023 10:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F85161888;
        Tue, 28 Mar 2023 17:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A10AC433A8;
        Tue, 28 Mar 2023 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680023942;
        bh=MTHqJiTmds1G9uf2/qzpku7XNdtoFTX7QHjbbVmJhXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iwpGrev1ibRl1dXAsJEadL7zC+ALyIoNwF26eKsb9zLY04PhWyoaNsvhEBhNFXO6j
         n0eGxaKAnKiBndtza8c9PucnSvNZhukPQTXYReFQcNh1SOLPMoQOovPnOsnW5ALYy0
         ejQ6u1k1X001PcR9vjqbo4swlXn7zjFFn7wa4h2ibc2xQqIFY5FJz0BwFTogJZdkfG
         14/VvXTY1JR3AcZiViJac7BCqT/LSMDsf3LgEMbb0Jnt8EaBpQQU5B4OYmzgfQRLt9
         /H6lWLpJge6OXRjPi18q3j3nz+eJ95O5AkgQupbUdVQUF6GBQlPOIO3z/UUsUI82DZ
         lh5OnXa0EMAow==
Received: by mail-vs1-f41.google.com with SMTP id z17so4376709vsf.4;
        Tue, 28 Mar 2023 10:19:02 -0700 (PDT)
X-Gm-Message-State: AAQBX9d7ENPbCeAr56lk4ScmrgAATTcaj9fbDLaNRjZm027/E5A1Se7E
        ONIRvajFJJ8oSScEza8gxTKKph0tEi7VN7cL33s=
X-Google-Smtp-Source: AKy350YAjBcIjw0gNJYv3x5fk8l/xNgxIbF6ywykp9t6eB0H+emyrVy6JBpfJ+yPh36PvoUpgQsSkg39kLwJqqbwdc0=
X-Received: by 2002:a67:e1c5:0:b0:402:999f:51dd with SMTP id
 p5-20020a67e1c5000000b00402999f51ddmr8709601vsl.3.1680023941287; Tue, 28 Mar
 2023 10:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230308094106.227365-1-rppt@kernel.org> <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz> <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz> <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz> <ZCMDmHSqOeCj1EIo@kernel.org>
In-Reply-To: <ZCMDmHSqOeCj1EIo@kernel.org>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 28 Mar 2023 10:18:50 -0700
X-Gmail-Original-Message-ID: <CAB=NE6UTC4VkNM57GGJ3XkG_PWLkMfXv2e2=yQJhtM6Fc-uMsQ@mail.gmail.com>
Message-ID: <CAB=NE6UTC4VkNM57GGJ3XkG_PWLkMfXv2e2=yQJhtM6Fc-uMsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-modules@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike, please Cc linux-modules if you want modules folks' input as well ;)

On Tue, Mar 28, 2023 at 8:11=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
> On Tue, Mar 28, 2023 at 09:39:37AM +0200, Michal Hocko wrote:
> > OK, so you want to reduce that direct map fragmentation?
>
> Yes.
>
> > Is that a real problem?
>
> A while ago Intel folks published report [1] that showed better performan=
ce
> with large pages in the direct map for majority of benchmarks.
>
> > My impression is that modules are mostly static thing. BPF
> > might be a different thing though. I have a recollection that BPF guys
> > were dealing with direct map fragmention as well.
>
> Modules are indeed static, but module_alloc() used by anything that
> allocates code pages, e.g. kprobes, ftrace and BPF. Besides, Thomas
> mentioned that having code in 2M pages reduces iTLB pressure [2], but
> that's not only about avoiding the splits in the direct map but also abou=
t
> using large mappings in the modules address space.

It is easily overlooked why such things create direct fragmentation --
it's because of the special permission stuff done, module_alloc()
targets memory which can be executed somehow.

> BPF guys suggested an allocator for executable memory [3] mainly because
> they've seen performance improvement of 0.6% - 0.9% in their setups [4].

The performance metrics were completely opaque to some synthetic
environment and our goal is to showcase real value with reproducible
performance benchmarks. Since now Song is convinced that modules need
to be a first class citizen in order to generalize a special allocator
we may sooner rather than later real reproducible performance data to
show the benefit of such a special allocator. One of the big
differences with eBPF programs is that modules *can* be rather large
in size. What is the average size of modules? Well let's take a look:

mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko| wc -l
9173
mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | awk 'BEGIN {sum=3D0} {sum+=3D$1}
END {print sum/NR/1024}'
175.1

175 MiB is pretty large.

Ignoring the top 5 piggies:

mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r |head -5
58315248 - ./drivers/gpu/drm/amd/amdgpu/amdgpu.ko
29605592 - ./drivers/gpu/drm/i915/i915.ko
18591256 - ./drivers/gpu/drm/nouveau/nouveau.ko
16867048 - ./fs/xfs/xfs.ko
14209440 - ./fs/btrfs/btrfs.ko

mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-5)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print sum/NR/1024}'
160.54

Ignoring the top 10 largest modules:

mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-10)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print sum/NR/1024}'
154.656

Ignoring the top 20 piggies:
mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-20)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print sum/NR/1024}'
146.384

Ignoring the top 100 bloated modules:
mcgrof@bigtwin mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-100)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print sum/NR/1024}'
117.97

Ignoring the top 1000 bloated modules:
mcgrof@bigtwin mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-1000)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
64.4686

Ignoring the top 2000 bloated modules:
mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-2000)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
48.7869

Ignoring top 3000
mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-3000)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
39.6037

Ignoring top 4000
mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-4000)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
33.106

Ignoring top 5000
mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
-name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
-$((9173-5000)) | awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
28.0925

But at least on the driver front we know we won't always have loaded
*all* GPU drivers, but *one*. So the math needs to consider what
module sizes are for modules actually used.

Let's see what the average module size is on on a big system:

mcgrof@bigtwin ~ $ lsmod | grep -v Module| awk '{print $1}' | xargs
sudo modinfo --field filename |  xargs stat -c "%s - %n" | awk 'BEGIN
{sum=3D0} {sum+=3D$1} END {print sum/NR/1024}'
313.432

On a small desktop:
mcgrof@desktop ~ $ lsmod | grep -v Module| awk '{print $1}' | xargs
sudo modinfo --field filename |  xargs stat -c "%s - %n" | awk 'BEGIN
{sum=3D0} {sum+=3D$1} END {print sum/NR/1024}'
292.786

For each finit_module we also do a vmalloc twice actually, one for the
kernel_read_*() which lets us read the file from userspace, and then a
second set of allocations where we copy data over, each step either
using vzalloc() or module_alloc() (vmalloc() with special
permissions), this is more easily reflected and visible now on
linux-next with Song's new module_memory_alloc().

However -- for the context of *this* effort, we're only talking about
the executable sections, the areas we'd use module_alloc() for.

On a big system:

mcgrof@bigtwin ~ $ lsmod | grep -v Module| awk '{print $1}' | xargs
sudo modinfo --field filename | xargs size --radix=3D10 | awk '{print
$1}'| grep -v text| awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
88.7964

On a small desktop:
mcgrof@desktop ~ $ lsmod | grep -v Module| awk '{print $1}' | xargs
sudo modinfo --field filename | xargs size --radix=3D10 | awk '{print
$1}'| grep -v text| awk 'BEGIN {sum=3D0} {sum+=3D$1} END {print
sum/NR/1024}'
92.1473

Regardless, the amount of memory allocated is pretty significant, to
the point a 400 CPU system easily run out of vmap space (yes the
kernel does some stupid stuff, which we're correcting over time):

https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com

To help with this we have some recent efforts to help with this
pressure on vmap space:

https://lkml.kernel.org/r/20230311051712.4095040-1-mcgrof@kernel.org

> > > If we were to use unmapped_pages_alloc() in modules_alloc(), we would=
 have
> > > to implement the part of vmalloc() that reserves the virtual addresse=
s and
> > > maps the allocated memory there in module_alloc().
> >
> > Another option would be to provide an allocator for the backing pages t=
o
> > vmalloc. But I do agree that a gfp flag is a less laborous way to
> > achieve the same. So the primary question really is whether we really
> > need vmalloc support for unmapped memory.
>
> I'm not sure I follow here. module_alloc() is essentially an alias to
> vmalloc(), so to reduce direct map fragmentation caused by code allocatio=
ns
> the most sensible way IMO is to support unmapped memory in vmalloc().

The big win also would be to use huge pages from a performance point
of view, specially reducing iTLB pressure, however that is *slightly*
orthogonal to your goal of reducing direct map fragmentation. However,
we should not ignore that strategy as it is a special use case which
*could* be leveraged in other ways too. And so I'd prefer to see that
over just a flag to hide those allocations. It would not only reduce
that fragmentation, but reduce iTLB pressure which I think *is* what
experimentation revealed to show more gains.

> I also think vmalloc with unmmapped pages can provide backing pages for
> execmem_alloc() Song proposed.

Only if you consider huge pages. I don't see that here.

  Luis
