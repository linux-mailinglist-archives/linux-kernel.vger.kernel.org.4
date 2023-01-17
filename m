Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C766E70F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjAQTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjAQT1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:27:32 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E66F689E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:34:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id i70so6078910ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQstPUbztcQ3oNJU/jnXWE9GGqVn0CTYXvJ///cN2gs=;
        b=poslRgebD7N051xL0dlQ/s+Ezqw18K2i/MiyhjW69tD8Q8EWVF96k5wFPqBT68fIx4
         UW+FBcvboauGVEVYcGOYlMCrKMALhEZA6FzdBO7hQ/yy98POithKQbpUgSoBLfCQX/0/
         mJFhqGlui74HddUG5gvjSzhjV1UFMflKwN3ojHD7sq+Of/9IGSYd4RX0Bny2aHq9T6kz
         t/LR7AstaK1J+f+cW7PCcQlb6SZ7W7jpqeEYhVrnXFbSmdgrsuHVjXiM0XSUrm5lu0IF
         OLrxwCiYBNX5chzmqbr8AiRTqv2U25IqwvgeRrbnbHsVx3+eSncfTAhX20VyHDelBId/
         G6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQstPUbztcQ3oNJU/jnXWE9GGqVn0CTYXvJ///cN2gs=;
        b=MLQF/vUb3NoGEXIZL2ZoTb+l2U5UCKyYuFHMMxTE5vflt5ZjpcvCxHsHnkgtQJZ1df
         3VPLGtNIs8eZyAPV5zy2+QTSdXE64tTuADXuqcA39KciTW1O4frxNHd3ye88f4dDH517
         NUwyqt2fuNT1so4RmYg/MbwceqXThvcrOZu7SvPLeXCzclgt3XqXF3UsBlfSSXmwlEb1
         qD56DCqcg4knb789Xvu8DTPFtDWhg3ElEw0T7nFaGaJVXU8PGogqUcAshJO/yYAe4SP1
         iX2Vboptuh+aGbIKN773zn63K4oOhGiSey2kzFrt0fwew4IGq+tSQntqsVIEksTgCbEE
         vUBA==
X-Gm-Message-State: AFqh2kqNnzFtADN/TzwR2TkSKOOwHQdq6UgCcCQD9Cpgjis7+wUqGrPv
        twwTQJHZuT91tSwCixYA+K2CGsVyy0a2AZ4y/bUWuw==
X-Google-Smtp-Source: AMrXdXvKN7wlexSy7gop1ACSgNR8UjrskPXnJONDdTkzOd0szS0kK6a+OFW7XqVKezwp7mdwKsCdCkJZHIHSfB+9s1E=
X-Received: by 2002:a02:aa99:0:b0:38a:49b8:bc49 with SMTP id
 u25-20020a02aa99000000b0038a49b8bc49mr335554jai.66.1673980475940; Tue, 17 Jan
 2023 10:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-41-surenb@google.com>
In-Reply-To: <20230109205336.3665937-41-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Jan 2023 19:33:59 +0100
Message-ID: <CAG48ez1=-tY8nrsX+T=AJBmW05E8sAvZNj80Wev9sGwR9NZysQ@mail.gmail.com>
Subject: Re: [PATCH 40/41] mm: separate vma->lock from vm_area_struct
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Mon, Jan 9, 2023 at 9:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
> vma->lock being part of the vm_area_struct causes performance regression
> during page faults because during contention its count and owner fields
> are constantly updated and having other parts of vm_area_struct used
> during page fault handling next to them causes constant cache line
> bouncing. Fix that by moving the lock outside of the vm_area_struct.
> All attempts to keep vma->lock inside vm_area_struct in a separate
> cache line still produce performance regression especially on NUMA
> machines. Smallest regression was achieved when lock is placed in the
> fourth cache line but that bloats vm_area_struct to 256 bytes.

Just checking: When you tested putting the lock in different cache
lines, did you force the slab allocator to actually store the
vm_area_struct with cacheline alignment (by setting SLAB_HWCACHE_ALIGN
on the slab or with a ____cacheline_aligned_in_smp on the struct
definition)?
