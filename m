Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1F6E5896
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjDRFah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDRFae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:30:34 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF75589
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:30:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fbee98814so195582517b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795802; x=1684387802;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+D5UP/13o4cYOkwXpINRdFlXLQ0G5MF9jQgRmeO+Kk=;
        b=6DmLIFxk6N4hyG9u/W0g9Ak1/kgGeuLS8GfsWeDeqYxlHWm2I2Yt0JqhZ29Dbc8odt
         Z3+7POIK2+3wBVMCHzPOrvLgyGviqLstRb3Ocp11fAC7oUFkHffvZ2NChRib5gXWd1xD
         CVx4q0PA01/ZG1197T8E/u0p5a5+ocZXEwUcBO/qihB1RjtLCj+ss0X4cTifvOP+gFs3
         vA073FrKzICaAw1Uun4CZhivamWpT/fG3kg/rQdFY3m0gHPD8XUNlVQ6xyjdfXWAbDY+
         gOQf1QO8R/UKJzEbNn/nPrSyNrCOjaO2iIhKdN16RnNHgRqCDLhMEA+GSmHMV/h1JJ81
         XpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795802; x=1684387802;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+D5UP/13o4cYOkwXpINRdFlXLQ0G5MF9jQgRmeO+Kk=;
        b=NWnYfgJB6xgmsq2PCHL3ndWyMc1awP7HQ3f+3CJn+nRNHLM2zLvNSICnITz5gCAiov
         x/V89kLN7ZmWFkFeU2oeLe6EN42GDX/pLMPJ7Y4WSM8BFjZts8Bhg71z5fCT1V8ignVV
         CkC4vMXCBxtx0YqrzJ+tTWgs0xLVyLov2trLzvrG2Rbu53nihS0EV6/8tf1g+M+UvYPx
         +RfyVVOaB+dw/4ApfIvN5U3To1G9GjhCu0eTM/Se4kSk2AMQSfLAaw2xkzqRQbuS9X6d
         Yi1sSpqevIAOWNrsUdjVUDjxfh2n/3m/5NB6lrHtiG5RebVKxdXAs10ZDLEey5cZLAAH
         KZUg==
X-Gm-Message-State: AAQBX9eThW8vnGoULc7lyaxtzZlcRBXNwcS/Zy1s2mfb0HGN1cx7pchy
        CaddhsdWanSU9xC0deSuIpUF+g==
X-Google-Smtp-Source: AKy350azH/DscIsEsxNzaPwTyJ8Cxf7IWzTPkRANWFvihJI3Fq3OcrnvJZYiCP0nF5gRkYYr+Kt1Ww==
X-Received: by 2002:a0d:d882:0:b0:552:1182:47dc with SMTP id a124-20020a0dd882000000b00552118247dcmr13161175ywe.6.1681795801636;
        Mon, 17 Apr 2023 22:30:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id db15-20020a05690c0dcf00b00545a08184b8sm3587038ywb.72.2023.04.17.22.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 22:30:01 -0700 (PDT)
Date:   Mon, 17 Apr 2023 22:29:59 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Luis Chamberlain <mcgrof@kernel.org>
cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 5/6] shmem: update documentation
In-Reply-To: <20230309230545.2930737-6-mcgrof@kernel.org>
Message-ID: <a4afef5c-27e4-5e67-9771-374132db61f8@google.com>
References: <20230309230545.2930737-1-mcgrof@kernel.org> <20230309230545.2930737-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023, Luis Chamberlain wrote:

> Update the docs to reflect a bit better why some folks prefer tmpfs
> over ramfs and clarify a bit more about the difference between brd
> ramdisks.
> 
> While at it, add THP docs for tmpfs, both the mount options and the
> sysfs file.

Okay: the original canonical reference for THP options on tmpfs has
been Documentation/admin-guide/mm/transhuge.rst.  You're right that
they would be helpful here too: IIRC (but I might well be confusing
with our Google tree) we used to have them documented in both places,
but grew tired of keeping the two in synch.  You're volunteering to
do so! so please check now that they tell the same story.

But nowadays, "man 5 tmpfs" is much more important (and that might
give you a hint for what needs to be done after this series goes into
6.4-rc - and I wonder if there are tmpfs manpage updates needed from
Christian for idmapped too? or already taken care of?).

There's a little detail we do need you to remove, indicated below.

> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Documentation/filesystems/tmpfs.rst | 57 +++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 0408c245785e..1ec9a9f8196b 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -13,14 +13,25 @@ everything stored therein is lost.
>  
>  tmpfs puts everything into the kernel internal caches and grows and
>  shrinks to accommodate the files it contains and is able to swap
> -unneeded pages out to swap space. It has maximum size limits which can
> -be adjusted on the fly via 'mount -o remount ...'
> -
> -If you compare it to ramfs (which was the template to create tmpfs)
> -you gain swapping and limit checking. Another similar thing is the RAM
> -disk (/dev/ram*), which simulates a fixed size hard disk in physical
> -RAM, where you have to create an ordinary filesystem on top. Ramdisks
> -cannot swap and you do not have the possibility to resize them.
> +unneeded pages out to swap space, and supports THP.
> +
> +tmpfs extends ramfs with a few userspace configurable options listed and
> +explained further below, some of which can be reconfigured dynamically on the
> +fly using a remount ('mount -o remount ...') of the filesystem. A tmpfs
> +filesystem can be resized but it cannot be resized to a size below its current
> +usage. tmpfs also supports POSIX ACLs, and extended attributes for the
> +trusted.* and security.* namespaces. ramfs does not use swap and you cannot
> +modify any parameter for a ramfs filesystem. The size limit of a ramfs
> +filesystem is how much memory you have available, and so care must be taken if
> +used so to not run out of memory.
> +
> +An alternative to tmpfs and ramfs is to use brd to create RAM disks
> +(/dev/ram*), which allows you to simulate a block device disk in physical RAM.
> +To write data you would just then need to create an regular filesystem on top
> +this ramdisk. As with ramfs, brd ramdisks cannot swap. brd ramdisks are also
> +configured in size at initialization and you cannot dynamically resize them.
> +Contrary to brd ramdisks, tmpfs has its own filesystem, it does not rely on the
> +block layer at all.
>  
>  Since tmpfs lives completely in the page cache and on swap, all tmpfs
>  pages will be shown as "Shmem" in /proc/meminfo and "Shared" in
> @@ -85,6 +96,36 @@ mount with such options, since it allows any user with write access to
>  use up all the memory on the machine; but enhances the scalability of
>  that instance in a system with many CPUs making intensive use of it.
>  
> +tmpfs also supports Transparent Huge Pages which requires a kernel
> +configured with CONFIG_TRANSPARENT_HUGEPAGE and with huge supported for
> +your system (has_transparent_hugepage(), which is architecture specific).
> +The mount options for this are:
> +
> +======  ============================================================
> +huge=0  never: disables huge pages for the mount
> +huge=1  always: enables huge pages for the mount
> +huge=2  within_size: only allocate huge pages if the page will be
> +        fully within i_size, also respect fadvise()/madvise() hints.
> +huge=3  advise: only allocate huge pages if requested with
> +        fadvise()/madvise()

You're taking the source too literally there.  Minor point is that there
is no fadvise() for this, to date anyway.  Major point is: have you tried
mounting tmpfs with huge=0 etc?  I did propose "huge=0" and "huge=1" years
ago, but those "never" went in, it's "always" been the named options.
Please remove those misleading numbers, it's "huge=never" etc.

(Old Google internal trees excepted: and trying to wean people off
"huge=1" internally makes me a bit touchy when seeing those numbers above!)

> +======  ============================================================
> +
> +There is a sysfs file which you can also use to control system wide THP
> +configuration for all tmpfs mounts, the file is:
> +
> +/sys/kernel/mm/transparent_hugepage/shmem_enabled
> +
> +This sysfs file is placed on top of THP sysfs directory and so is registered
> +by THP code. It is however only used to control all tmpfs mounts with one
> +single knob. Since it controls all tmpfs mounts it should only be used either
> +for emergency or testing purposes. The values you can set for shmem_enabled are:
> +
> +==  ============================================================
> +-1  deny: disables huge on shm_mnt and all mounts, for
> +    emergency use
> +-2  force: enables huge on shm_mnt and all mounts, w/o needing
> +    option, for testing

Likewise here, please delete the invalid "-1" and "-2" notations,
-1 and -2 are just #defines for use in the kernel source.

And the description above is not quite accurate: it is very hard to
describe shmem_enabled, partly because it combines two different things.
It's partly the "huge=" mount option for any "internal mount", those
things like SysV SHM and memfd and i915 and shared-anonymous: the shmem
which has no user-visible mount to hold the option.  But also these
"deny" and "force" overrides affecting *all* internal and visible mounts.

Hugh

> +==  ============================================================
>  
>  tmpfs has a mount option to set the NUMA memory allocation policy for
>  all files in that instance (if CONFIG_NUMA is enabled) - which can be
> -- 
> 2.39.1
