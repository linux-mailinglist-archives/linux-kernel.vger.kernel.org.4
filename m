Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6067AA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjAYGmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjAYGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:42:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CD460A2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:41:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w2so12742529pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EutzME1gmYQhz6ovub7W2ycot/2b6fy/5oe75qx4sME=;
        b=pXb1luo2cYcB6JcDbDcH+qu7H7sh+hgpJCP2u9vIKG09SI+ihgLPRCMu9jj6HCefMV
         kTkBy6X4OlARi2cxMqSOu+7qvB4jxUVcNO1w8g2dD/mO5/orctrmTXKmbzoI7ONZD/e9
         D9EEMhsI8r4H0VbuNE2TOgpshPGS9sG976WGWBDdKSab9aQdxaz+OIzq49aGqdrfMnCL
         O83T3Ydt8afsYE9Mz/i9Rzw1ppZaY2+T7s2nQemLfn4MGkdyA5ax+tu4suVZjtZZlj1S
         c49tMk4t4n7nudKMU1ybAk06Ib5v814gt/ZhdaTFFjAVmJDX2ECkrhfZFgiPsEUQv7lM
         4Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EutzME1gmYQhz6ovub7W2ycot/2b6fy/5oe75qx4sME=;
        b=tIREzUF3jzZ/Dn+JcX2FL3K14iOA3shEdRiwypcN0i7fPCDLaUAhdPCgwJwCiBDzd5
         OnK8Dv1K5awBHQZAKmeDNMJrmCXYJboql2ku9Cm9JGEf6WIPvy1nn8urnnsxiDxCydpq
         Qy5Iamo9gRMregPFLOlgJYtrWL9AnPffScNg878M21cThb7Za8RGrhM54pWaZaMDr7c2
         3Ska7zAK09M0IzG2v0GmS3Lrpejvn/lNA7MY3BoK4Kg2PlzOYxuX46gtFZjXgWkhOAhM
         26EP9CUTECAO880LwM2GIGp6Yozu0X6l70IZsYMinjBA67XlJ0MKMMGMN3VCEQZDaYRe
         jnyA==
X-Gm-Message-State: AFqh2koosJENsOsV0bMHmF4wuAR9D8MM0yUYIKKTOssg5r77+1KdeJUc
        rbHQPeK78hO5JUpbDsRQa2byTRWD8qRx0g==
X-Google-Smtp-Source: AMrXdXs6vy5mmZcyccmSExp7//5zfipOWoEatDgh0y1EC0Xaa78dUcatWswBvQL5A49GUS+P7QHPjA==
X-Received: by 2002:a05:6a00:2ba:b0:576:7fb9:85cc with SMTP id q26-20020a056a0002ba00b005767fb985ccmr29084006pfs.14.1674628903964;
        Tue, 24 Jan 2023 22:41:43 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a00078c00b0058837da69edsm2711319pfu.128.2023.01.24.22.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 22:41:42 -0800 (PST)
Date:   Thu, 26 Jan 2023 00:41:15 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <Y9FNm50H+w1B26yR@hyeyoo>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
 <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
 <Y8vSZ+gOFXWDKC8Z@hyeyoo>
 <Y85MNmZDc5czMRUJ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oudKfyDVtxiFA6ja"
Content-Disposition: inline
In-Reply-To: <Y85MNmZDc5czMRUJ@dhcp22.suse.cz>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oudKfyDVtxiFA6ja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Bcc: 
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Reply-To: 
In-Reply-To: <Y85MNmZDc5czMRUJ@dhcp22.suse.cz>

On Mon, Jan 23, 2023 at 09:58:30AM +0100, Michal Hocko wrote:
> On Sat 21-01-23 20:54:15, Hyeonggon Yoo wrote:
> > On Sat, Jan 21, 2023 at 12:29:44PM +0100, Vlastimil Babka wrote:
> > > On 1/21/23 04:39, Hyeonggon Yoo wrote:
> > > > In workloads where this_cpu operations are frequently performed,
> > > > enabling DEBUG_PREEMPT may result in significant increase in
> > > > runtime overhead due to frequent invocation of
> > > > __this_cpu_preempt_check() function.
> > > > 
> > > > This can be demonstrated through benchmarks such as hackbench where this
> > > > configuration results in a 10% reduction in performance, primarily due to
> > > > the added overhead within memcg charging path.
> > > > 
> > > > Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
> > > > of its potential impact on performance in some workloads.
> > > > 
> > > > hackbench-process-sockets
> > > > 		      debug_preempt	 no_debug_preempt
> > > > Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
> > > > Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
> > > > Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
> > > > Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
> > > > Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
> > > > Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
> > > > Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
> > > > Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
> > > > Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*

Hello Michal, thanks for looking at this.

> Do you happen to have any perf data collected during those runs? I
> would be interested in the memcg side of things. Maybe we can do
> something better there.

Yes, below is performance data I've collected.

6.1.8-debug-preempt-dirty
=========================
  Overhead  Command       Shared Object     Symbol
+    9.14%  hackbench        [kernel.vmlinux]  [k] check_preemption_disabled
+    7.33%  hackbench        [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
+    7.32%  hackbench        [kernel.vmlinux]  [k] mod_objcg_state
     3.55%  hackbench        [kernel.vmlinux]  [k] refill_obj_stock
     3.39%  hackbench        [kernel.vmlinux]  [k] debug_smp_processor_id
     2.97%  hackbench        [kernel.vmlinux]  [k] memset_erms
     2.55%  hackbench        [kernel.vmlinux]  [k] __check_object_size
+    2.36%  hackbench        [kernel.vmlinux]  [k] native_queued_spin_lock_slowpath
     1.76%  hackbench        [kernel.vmlinux]  [k] unix_stream_read_generic
     1.64%  hackbench        [kernel.vmlinux]  [k] __slab_free
     1.58%  hackbench        [kernel.vmlinux]  [k] unix_stream_sendmsg
     1.46%  hackbench        [kernel.vmlinux]  [k] memcg_slab_post_alloc_hook
     1.35%  hackbench        [kernel.vmlinux]  [k] vfs_write
     1.33%  hackbench        [kernel.vmlinux]  [k] vfs_read
     1.28%  hackbench        [kernel.vmlinux]  [k] __alloc_skb
     1.18%  hackbench        [kernel.vmlinux]  [k] sock_read_iter
     1.16%  hackbench        [kernel.vmlinux]  [k] obj_cgroup_charge
     1.16%  hackbench        [kernel.vmlinux]  [k] entry_SYSCALL_64
     1.14%  hackbench        [kernel.vmlinux]  [k] sock_write_iter
     1.12%  hackbench        [kernel.vmlinux]  [k] skb_release_data
     1.08%  hackbench        [kernel.vmlinux]  [k] sock_wfree
     1.07%  hackbench        [kernel.vmlinux]  [k] cache_from_obj
     0.96%  hackbench        [kernel.vmlinux]  [k] unix_destruct_scm
     0.95%  hackbench        [kernel.vmlinux]  [k] kmem_cache_free
     0.94%  hackbench        [kernel.vmlinux]  [k] __kmem_cache_alloc_node
     0.92%  hackbench        [kernel.vmlinux]  [k] kmem_cache_alloc_node
     0.89%  hackbench        [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
     0.84%  hackbench        [kernel.vmlinux]  [k] __x86_indirect_thunk_array
     0.84%  hackbench        libc.so.6         [.] write
     0.81%  hackbench        [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.76%  hackbench        libc.so.6         [.] read
     0.75%  hackbench        [kernel.vmlinux]  [k] syscall_trace_enter.constprop.0
     0.75%  hackbench        [kernel.vmlinux]  [k] preempt_count_add
     0.74%  hackbench        [kernel.vmlinux]  [k] cmpxchg_double_slab.constprop.0.isra.0
     0.69%  hackbench        [kernel.vmlinux]  [k] get_partial_node
     0.69%  hackbench        [kernel.vmlinux]  [k] __virt_addr_valid
     0.69%  hackbench        [kernel.vmlinux]  [k] __rcu_read_unlock
     0.65%  hackbench        [kernel.vmlinux]  [k] get_obj_cgroup_from_current
     0.63%  hackbench        [kernel.vmlinux]  [k] __kmem_cache_free
     0.62%  hackbench        [kernel.vmlinux]  [k] entry_SYSRETQ_unsafe_stack
     0.60%  hackbench        [kernel.vmlinux]  [k] __rcu_read_lock
     0.59%  hackbench        [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.54%  hackbench        [kernel.vmlinux]  [k] __unfreeze_partials
     0.53%  hackbench        [kernel.vmlinux]  [k] check_stack_object
     0.52%  hackbench        [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     0.51%  hackbench        [kernel.vmlinux]  [k] security_file_permission
     0.50%  hackbench        [kernel.vmlinux]  [k] __x64_sys_write
     0.49%  hackbench        [kernel.vmlinux]  [k] bpf_lsm_file_permission
     0.48%  hackbench        [kernel.vmlinux]  [k] ___slab_alloc
     0.46%  hackbench        [kernel.vmlinux]  [k] __check_heap_object

and attached flamegraph-6.1.8-debug-preempt-dirty.svg.

6.1.8 (no debug preempt)
========================
  Overhead  Command       Shared Object     Symbol
+   10.96%  hackbench     [kernel.vmlinux]  [k] mod_objcg_state
+    8.16%  hackbench     [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
     3.29%  hackbench     [kernel.vmlinux]  [k] memset_erms
     3.07%  hackbench     [kernel.vmlinux]  [k] __slab_free
     2.89%  hackbench     [kernel.vmlinux]  [k] refill_obj_stock
     2.82%  hackbench     [kernel.vmlinux]  [k] __check_object_size
+    2.72%  hackbench     [kernel.vmlinux]  [k] native_queued_spin_lock_slowpath
     1.96%  hackbench     [kernel.vmlinux]  [k] __x86_indirect_thunk_rax
     1.88%  hackbench     [kernel.vmlinux]  [k] memcg_slab_post_alloc_hook
     1.69%  hackbench     [kernel.vmlinux]  [k] __rcu_read_unlock
     1.54%  hackbench     [kernel.vmlinux]  [k] __alloc_skb
     1.53%  hackbench     [kernel.vmlinux]  [k] unix_stream_sendmsg
     1.46%  hackbench     [kernel.vmlinux]  [k] kmem_cache_free
     1.44%  hackbench     [kernel.vmlinux]  [k] vfs_write
     1.43%  hackbench     [kernel.vmlinux]  [k] vfs_read
     1.33%  hackbench     [kernel.vmlinux]  [k] unix_stream_read_generic
     1.31%  hackbench     [kernel.vmlinux]  [k] sock_write_iter
     1.27%  hackbench     [kernel.vmlinux]  [k] kmalloc_slab
     1.22%  hackbench     [kernel.vmlinux]  [k] __rcu_read_lock
     1.20%  hackbench     [kernel.vmlinux]  [k] sock_read_iter
     1.18%  hackbench     [kernel.vmlinux]  [k] __entry_text_start
     1.15%  hackbench     [kernel.vmlinux]  [k] kmem_cache_alloc_node
     1.12%  hackbench     [kernel.vmlinux]  [k] unix_stream_recvmsg
     1.10%  hackbench     [kernel.vmlinux]  [k] obj_cgroup_charge
     0.98%  hackbench     [kernel.vmlinux]  [k] __kmem_cache_alloc_node
     0.97%  hackbench     libc.so.6         [.] write
     0.91%  hackbench     [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.88%  hackbench     [kernel.vmlinux]  [k] __kmem_cache_free
     0.87%  hackbench     [kernel.vmlinux]  [k] syscall_trace_enter.constprop.0
     0.86%  hackbench     [kernel.vmlinux]  [k] __kmalloc_node_track_caller
     0.84%  hackbench     libc.so.6         [.] read
     0.81%  hackbench     [kernel.vmlinux]  [k] __lock_text_start
     0.80%  hackbench     [kernel.vmlinux]  [k] cache_from_obj
     0.74%  hackbench     [kernel.vmlinux]  [k] get_obj_cgroup_from_current
     0.73%  hackbench     [kernel.vmlinux]  [k] entry_SYSRETQ_unsafe_stack
     0.72%  hackbench     [kernel.vmlinux]  [k] unix_destruct_scm
     0.70%  hackbench     [kernel.vmlinux]  [k] get_partial_node
     0.69%  hackbench     [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.65%  hackbench     [kernel.vmlinux]  [k] kfree
     0.63%  hackbench     [kernel.vmlinux]  [k] __unfreeze_partials
     0.60%  hackbench     [kernel.vmlinux]  [k] cmpxchg_double_slab.constprop.0.isra.0
     0.58%  hackbench     [kernel.vmlinux]  [k] skb_release_data
     0.56%  hackbench     [kernel.vmlinux]  [k] __virt_addr_valid
     0.56%  hackbench     [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     0.56%  hackbench     [kernel.vmlinux]  [k] __check_heap_object
     0.55%  hackbench     [kernel.vmlinux]  [k] sock_wfree
     0.54%  hackbench     [kernel.vmlinux]  [k] __audit_syscall_entry
     0.53%  hackbench     [kernel.vmlinux]  [k] ___slab_alloc
     0.53%  hackbench     [kernel.vmlinux]  [k] check_stack_object
     0.52%  hackbench     [kernel.vmlinux]  [k] bpf_lsm_file_permission

and attached flamegraph-6.1.8.svg.

If you need more information, feel free to ask.

--
Thanks,
Hyeonggon

> -- 
> Michal Hocko
> SUSE Labs

--oudKfyDVtxiFA6ja
Content-Type: image/svg+xml
Content-Disposition: attachment;
	filename="flamegraph-6.1.8-debug-preempt-dirty.svg"
Content-Transfer-Encoding: quoted-printable

<?xml version=3D"1.0" standalone=3D"no"?>=0A<!DOCTYPE svg PUBLIC "-//W3C//D=
TD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">=0A<svg =
version=3D"1.1" width=3D"1200" height=3D"470" onload=3D"init(evt)" viewBox=
=3D"0 0 1200 470" xmlns=3D"http://www.w3.org/2000/svg" xmlns:xlink=3D"http:=
//www.w3.org/1999/xlink">=0A<!-- Flame graph stack visualization. See https=
://github.com/brendangregg/FlameGraph for latest version, and http://www.br=
endangregg.com/flamegraphs.html for examples. -->=0A<!-- NOTES:  -->=0A<def=
s>=0A	<linearGradient id=3D"background" y1=3D"0" y2=3D"1" x1=3D"0" x2=3D"0"=
 >=0A		<stop stop-color=3D"#eeeeee" offset=3D"5%" />=0A		<stop stop-color=
=3D"#eeeeb0" offset=3D"95%" />=0A	</linearGradient>=0A</defs>=0A<style type=
=3D"text/css">=0A	text { font-family:Verdana; font-size:12px; fill:rgb(0,0,=
0); }=0A	#search, #ignorecase { opacity:0.1; cursor:pointer; }=0A	#search:h=
over, #search.show, #ignorecase:hover, #ignorecase.show { opacity:1; }=0A	#=
subtitle { text-anchor:middle; font-color:rgb(160,160,160); }=0A	#title { t=
ext-anchor:middle; font-size:17px}=0A	#unzoom { cursor:pointer; }=0A	#frame=
s > *:hover { stroke:black; stroke-width:0.5; cursor:pointer; }=0A	.hide { =
display:none; }=0A	.parent { opacity:0.5; }=0A</style>=0A<script type=3D"te=
xt/ecmascript">=0A<![CDATA[=0A	"use strict";=0A	var details, searchbtn, unz=
oombtn, matchedtxt, svg, searching, currentSearchTerm, ignorecase, ignoreca=
seBtn;=0A	function init(evt) {=0A		details =3D document.getElementById("det=
ails").firstChild;=0A		searchbtn =3D document.getElementById("search");=0A	=
	ignorecaseBtn =3D document.getElementById("ignorecase");=0A		unzoombtn =3D=
 document.getElementById("unzoom");=0A		matchedtxt =3D document.getElementB=
yId("matched");=0A		svg =3D document.getElementsByTagName("svg")[0];=0A		se=
arching =3D 0;=0A		currentSearchTerm =3D null;=0A=0A		// use GET parameters=
 to restore a flamegraphs state.=0A		var params =3D get_params();=0A		if (p=
arams.x && params.y)=0A			zoom(find_group(document.querySelector('[x=3D"' +=
 params.x + '"][y=3D"' + params.y + '"]')));=0A                if (params.s=
) search(params.s);=0A	}=0A=0A	// event listeners=0A	window.addEventListene=
r("click", function(e) {=0A		var target =3D find_group(e.target);=0A		if (t=
arget) {=0A			if (target.nodeName =3D=3D "a") {=0A				if (e.ctrlKey =3D=3D=
=3D false) return;=0A				e.preventDefault();=0A			}=0A			if (target.classLi=
st.contains("parent")) unzoom(true);=0A			zoom(target);=0A			if (!document.=
querySelector('.parent')) {=0A				// we have basically done a clearzoom so =
clear the url=0A				var params =3D get_params();=0A				if (params.x) delete=
 params.x;=0A				if (params.y) delete params.y;=0A				history.replaceState(=
null, null, parse_params(params));=0A				unzoombtn.classList.add("hide");=
=0A				return;=0A			}=0A=0A			// set parameters for zoom state=0A			var el =
=3D target.querySelector("rect");=0A			if (el && el.attributes && el.attrib=
utes.y && el.attributes._orig_x) {=0A				var params =3D get_params()=0A				=
params.x =3D el.attributes._orig_x.value;=0A				params.y =3D el.attributes.=
y.value;=0A				history.replaceState(null, null, parse_params(params));=0A		=
	}=0A		}=0A		else if (e.target.id =3D=3D "unzoom") clearzoom();=0A		else if=
 (e.target.id =3D=3D "search") search_prompt();=0A		else if (e.target.id =
=3D=3D "ignorecase") toggle_ignorecase();=0A	}, false)=0A=0A	// mouse-over =
for info=0A	// show=0A	window.addEventListener("mouseover", function(e) {=
=0A		var target =3D find_group(e.target);=0A		if (target) details.nodeValue=
 =3D "Function: " + g_to_text(target);=0A	}, false)=0A=0A	// clear=0A	windo=
w.addEventListener("mouseout", function(e) {=0A		var target =3D find_group(=
e.target);=0A		if (target) details.nodeValue =3D ' ';=0A	}, false)=0A=0A	//=
 ctrl-F for search=0A	// ctrl-I to toggle case-sensitive search=0A	window.a=
ddEventListener("keydown",function (e) {=0A		if (e.keyCode =3D=3D=3D 114 ||=
 (e.ctrlKey && e.keyCode =3D=3D=3D 70)) {=0A			e.preventDefault();=0A			sea=
rch_prompt();=0A		}=0A		else if (e.ctrlKey && e.keyCode =3D=3D=3D 73) {=0A	=
		e.preventDefault();=0A			toggle_ignorecase();=0A		}=0A	}, false)=0A=0A	//=
 functions=0A	function get_params() {=0A		var params =3D {};=0A		var params=
arr =3D window.location.search.substr(1).split('&');=0A		for (var i =3D 0; =
i < paramsarr.length; ++i) {=0A			var tmp =3D paramsarr[i].split("=3D");=0A=
			if (!tmp[0] || !tmp[1]) continue;=0A			params[tmp[0]]  =3D decodeURIComp=
onent(tmp[1]);=0A		}=0A		return params;=0A	}=0A	function parse_params(param=
s) {=0A		var uri =3D "?";=0A		for (var key in params) {=0A			uri +=3D key +=
 '=3D' + encodeURIComponent(params[key]) + '&';=0A		}=0A		if (uri.slice(-1)=
 =3D=3D "&")=0A			uri =3D uri.substring(0, uri.length - 1);=0A		if (uri =3D=
=3D '?')=0A			uri =3D window.location.href.split('?')[0];=0A		return uri;=
=0A	}=0A	function find_child(node, selector) {=0A		var children =3D node.qu=
erySelectorAll(selector);=0A		if (children.length) return children[0];=0A	}=
=0A	function find_group(node) {=0A		var parent =3D node.parentElement;=0A		=
if (!parent) return;=0A		if (parent.id =3D=3D "frames") return node;=0A		re=
turn find_group(parent);=0A	}=0A	function orig_save(e, attr, val) {=0A		if =
(e.attributes["_orig_" + attr] !=3D undefined) return;=0A		if (e.attributes=
[attr] =3D=3D undefined) return;=0A		if (val =3D=3D undefined) val =3D e.at=
tributes[attr].value;=0A		e.setAttribute("_orig_" + attr, val);=0A	}=0A	fun=
ction orig_load(e, attr) {=0A		if (e.attributes["_orig_"+attr] =3D=3D undef=
ined) return;=0A		e.attributes[attr].value =3D e.attributes["_orig_" + attr=
].value;=0A		e.removeAttribute("_orig_"+attr);=0A	}=0A	function g_to_text(e=
) {=0A		var text =3D find_child(e, "title").firstChild.nodeValue;=0A		retur=
n (text)=0A	}=0A	function g_to_func(e) {=0A		var func =3D g_to_text(e);=0A	=
	// if there's any manipulation we want to do to the function=0A		// name b=
efore it's searched, do it here before returning.=0A		return (func);=0A	}=
=0A	function update_text(e) {=0A		var r =3D find_child(e, "rect");=0A		var =
t =3D find_child(e, "text");=0A		var w =3D parseFloat(r.attributes.width.va=
lue) -3;=0A		var txt =3D find_child(e, "title").textContent.replace(/\([^(]=
*\)$/,"");=0A		t.attributes.x.value =3D parseFloat(r.attributes.x.value) + =
3;=0A=0A		// Smaller than this size won't fit anything=0A		if (w < 2 * 12 *=
 0.59) {=0A			t.textContent =3D "";=0A			return;=0A		}=0A=0A		t.textContent=
 =3D txt;=0A		var sl =3D t.getSubStringLength(0, txt.length);=0A		// check =
if only whitespace or if we can fit the entire string into width w=0A		if (=
/^ *$/.test(txt) || sl < w)=0A			return;=0A=0A		// this isn't perfect, but =
gives a good starting point=0A		// and avoids calling getSubStringLength to=
o often=0A		var start =3D Math.floor((w/sl) * txt.length);=0A		for (var x =
=3D start; x > 0; x =3D x-2) {=0A			if (t.getSubStringLength(0, x + 2) <=3D=
 w) {=0A				t.textContent =3D txt.substring(0, x) + "..";=0A				return;=0A	=
		}=0A		}=0A		t.textContent =3D "";=0A	}=0A=0A	// zoom=0A	function zoom_res=
et(e) {=0A		if (e.attributes !=3D undefined) {=0A			orig_load(e, "x");=0A		=
	orig_load(e, "width");=0A		}=0A		if (e.childNodes =3D=3D undefined) return=
;=0A		for (var i =3D 0, c =3D e.childNodes; i < c.length; i++) {=0A			zoom_=
reset(c[i]);=0A		}=0A	}=0A	function zoom_child(e, x, ratio) {=0A		if (e.att=
ributes !=3D undefined) {=0A			if (e.attributes.x !=3D undefined) {=0A				o=
rig_save(e, "x");=0A				e.attributes.x.value =3D (parseFloat(e.attributes.x=
=2Evalue) - x - 10) * ratio + 10;=0A				if (e.tagName =3D=3D "text")=0A				=
	e.attributes.x.value =3D find_child(e.parentNode, "rect[x]").attributes.x.=
value + 3;=0A			}=0A			if (e.attributes.width !=3D undefined) {=0A				orig_=
save(e, "width");=0A				e.attributes.width.value =3D parseFloat(e.attribute=
s.width.value) * ratio;=0A			}=0A		}=0A=0A		if (e.childNodes =3D=3D undefin=
ed) return;=0A		for (var i =3D 0, c =3D e.childNodes; i < c.length; i++) {=
=0A			zoom_child(c[i], x - 10, ratio);=0A		}=0A	}=0A	function zoom_parent(e=
) {=0A		if (e.attributes) {=0A			if (e.attributes.x !=3D undefined) {=0A			=
	orig_save(e, "x");=0A				e.attributes.x.value =3D 10;=0A			}=0A			if (e.at=
tributes.width !=3D undefined) {=0A				orig_save(e, "width");=0A				e.attri=
butes.width.value =3D parseInt(svg.width.baseVal.value) - (10 * 2);=0A			}=
=0A		}=0A		if (e.childNodes =3D=3D undefined) return;=0A		for (var i =3D 0,=
 c =3D e.childNodes; i < c.length; i++) {=0A			zoom_parent(c[i]);=0A		}=0A	=
}=0A	function zoom(node) {=0A		var attr =3D find_child(node, "rect").attrib=
utes;=0A		var width =3D parseFloat(attr.width.value);=0A		var xmin =3D pars=
eFloat(attr.x.value);=0A		var xmax =3D parseFloat(xmin + width);=0A		var ym=
in =3D parseFloat(attr.y.value);=0A		var ratio =3D (svg.width.baseVal.value=
 - 2 * 10) / width;=0A=0A		// XXX: Workaround for JavaScript float issues (=
fix me)=0A		var fudge =3D 0.0001;=0A=0A		unzoombtn.classList.remove("hide")=
;=0A=0A		var el =3D document.getElementById("frames").children;=0A		for (va=
r i =3D 0; i < el.length; i++) {=0A			var e =3D el[i];=0A			var a =3D find_=
child(e, "rect").attributes;=0A			var ex =3D parseFloat(a.x.value);=0A			va=
r ew =3D parseFloat(a.width.value);=0A			var upstack;=0A			// Is it an ance=
stor=0A			if (0 =3D=3D 0) {=0A				upstack =3D parseFloat(a.y.value) > ymin;=
=0A			} else {=0A				upstack =3D parseFloat(a.y.value) < ymin;=0A			}=0A			=
if (upstack) {=0A				// Direct ancestor=0A				if (ex <=3D xmin && (ex+ew+fu=
dge) >=3D xmax) {=0A					e.classList.add("parent");=0A					zoom_parent(e);=
=0A					update_text(e);=0A				}=0A				// not in current path=0A				else=0A	=
				e.classList.add("hide");=0A			}=0A			// Children maybe=0A			else {=0A		=
		// no common path=0A				if (ex < xmin || ex + fudge >=3D xmax) {=0A					e=
=2EclassList.add("hide");=0A				}=0A				else {=0A					zoom_child(e, xmin, r=
atio);=0A					update_text(e);=0A				}=0A			}=0A		}=0A		search();=0A	}=0A	fu=
nction unzoom(dont_update_text) {=0A		unzoombtn.classList.add("hide");=0A		=
var el =3D document.getElementById("frames").children;=0A		for(var i =3D 0;=
 i < el.length; i++) {=0A			el[i].classList.remove("parent");=0A			el[i].cl=
assList.remove("hide");=0A			zoom_reset(el[i]);=0A			if(!dont_update_text) =
update_text(el[i]);=0A		}=0A		search();=0A	}=0A	function clearzoom() {=0A		=
unzoom();=0A=0A		// remove zoom state=0A		var params =3D get_params();=0A		=
if (params.x) delete params.x;=0A		if (params.y) delete params.y;=0A		histo=
ry.replaceState(null, null, parse_params(params));=0A	}=0A=0A	// search=0A	=
function toggle_ignorecase() {=0A		ignorecase =3D !ignorecase;=0A		if (igno=
recase) {=0A			ignorecaseBtn.classList.add("show");=0A		} else {=0A			ignor=
ecaseBtn.classList.remove("show");=0A		}=0A		reset_search();=0A		search();=
=0A	}=0A	function reset_search() {=0A		var el =3D document.querySelectorAll=
("#frames rect");=0A		for (var i =3D 0; i < el.length; i++) {=0A			orig_loa=
d(el[i], "fill")=0A		}=0A		var params =3D get_params();=0A		delete params.s=
;=0A		history.replaceState(null, null, parse_params(params));=0A	}=0A	funct=
ion search_prompt() {=0A		if (!searching) {=0A			var term =3D prompt("Enter=
 a search term (regexp " +=0A			    "allowed, eg: ^ext4_)"=0A			    + (igno=
recase ? ", ignoring case" : "")=0A			    + "\nPress Ctrl-i to toggle case =
sensitivity", "");=0A			if (term !=3D null) search(term);=0A		} else {=0A		=
	reset_search();=0A			searching =3D 0;=0A			currentSearchTerm =3D null;=0A	=
		searchbtn.classList.remove("show");=0A			searchbtn.firstChild.nodeValue =
=3D "Search"=0A			matchedtxt.classList.add("hide");=0A			matchedtxt.firstCh=
ild.nodeValue =3D ""=0A		}=0A	}=0A	function search(term) {=0A		if (term) cu=
rrentSearchTerm =3D term;=0A=0A		var re =3D new RegExp(currentSearchTerm, i=
gnorecase ? 'i' : '');=0A		var el =3D document.getElementById("frames").chi=
ldren;=0A		var matches =3D new Object();=0A		var maxwidth =3D 0;=0A		for (v=
ar i =3D 0; i < el.length; i++) {=0A			var e =3D el[i];=0A			var func =3D g=
_to_func(e);=0A			var rect =3D find_child(e, "rect");=0A			if (func =3D=3D =
null || rect =3D=3D null)=0A				continue;=0A=0A			// Save max width. Only w=
orks as we have a root frame=0A			var w =3D parseFloat(rect.attributes.widt=
h.value);=0A			if (w > maxwidth)=0A				maxwidth =3D w;=0A=0A			if (func.mat=
ch(re)) {=0A				// highlight=0A				var x =3D parseFloat(rect.attributes.x.v=
alue);=0A				orig_save(rect, "fill");=0A				rect.attributes.fill.value =3D =
"rgb(230,0,230)";=0A=0A				// remember matches=0A				if (matches[x] =3D=3D =
undefined) {=0A					matches[x] =3D w;=0A				} else {=0A					if (w > matches=
[x]) {=0A						// overwrite with parent=0A						matches[x] =3D w;=0A					}=
=0A				}=0A				searching =3D 1;=0A			}=0A		}=0A		if (!searching)=0A			retur=
n;=0A		var params =3D get_params();=0A		params.s =3D currentSearchTerm;=0A	=
	history.replaceState(null, null, parse_params(params));=0A=0A		searchbtn.c=
lassList.add("show");=0A		searchbtn.firstChild.nodeValue =3D "Reset Search"=
;=0A=0A		// calculate percent matched, excluding vertical overlap=0A		var c=
ount =3D 0;=0A		var lastx =3D -1;=0A		var lastw =3D 0;=0A		var keys =3D Arr=
ay();=0A		for (k in matches) {=0A			if (matches.hasOwnProperty(k))=0A				ke=
ys.push(k);=0A		}=0A		// sort the matched frames by their x location=0A		//=
 ascending, then width descending=0A		keys.sort(function(a, b){=0A			return=
 a - b;=0A		});=0A		// Step through frames saving only the biggest bottom-u=
p frames=0A		// thanks to the sort order. This relies on the tree property=
=0A		// where children are always smaller than their parents.=0A		var fudge=
 =3D 0.0001;	// JavaScript floating point=0A		for (var k in keys) {=0A			va=
r x =3D parseFloat(keys[k]);=0A			var w =3D matches[keys[k]];=0A			if (x >=
=3D lastx + lastw - fudge) {=0A				count +=3D w;=0A				lastx =3D x;=0A				l=
astw =3D w;=0A			}=0A		}=0A		// display matched percent=0A		matchedtxt.clas=
sList.remove("hide");=0A		var pct =3D 100 * count / maxwidth;=0A		if (pct !=
=3D 100) pct =3D pct.toFixed(1)=0A		matchedtxt.firstChild.nodeValue =3D "Ma=
tched: " + pct + "%";=0A	}=0A]]>=0A</script>=0A<rect x=3D"0.0" y=3D"0" widt=
h=3D"1200.0" height=3D"470.0" fill=3D"url(#background)"  />=0A<text id=3D"t=
itle" x=3D"600.00" y=3D"24" >Flame Graph</text>=0A<text id=3D"details" x=3D=
"10.00" y=3D"453" > </text>=0A<text id=3D"unzoom" x=3D"10.00" y=3D"24" clas=
s=3D"hide">Reset Zoom</text>=0A<text id=3D"search" x=3D"1090.00" y=3D"24" >=
Search</text>=0A<text id=3D"ignorecase" x=3D"1174.00" y=3D"24" >ic</text>=
=0A<text id=3D"matched" x=3D"1090.00" y=3D"453" > </text>=0A<g id=3D"frames=
">=0A<g >=0A<title>is_vmalloc_addr (2,555,888,062 samples, 0.03%)</title><r=
ect x=3D"760.9" y=3D"197" width=3D"0.4" height=3D"15.0" fill=3D"rgb(226,129=
,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"763.88" y=3D"207.5" ></text>=0A</g=
>=0A<g >=0A<title>update_min_vruntime (955,744,637 samples, 0.01%)</title><=
rect x=3D"1143.1" y=3D"85" width=3D"0.2" height=3D"15.0" fill=3D"rgb(216,38=
,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1146.14" y=3D"95.5" ></text>=0A</g>=
=0A<g >=0A<title>cpu_startup_entry (2,065,092,133 samples, 0.03%)</title><r=
ect x=3D"1189.7" y=3D"357" width=3D"0.3" height=3D"15.0" fill=3D"rgb(211,13=
8,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.70" y=3D"367.5" ></text>=0A<=
/g>=0A<g >=0A<title>enqueue_task_fair (9,035,036,369 samples, 0.11%)</title=
><rect x=3D"349.5" y=3D"69" width=3D"1.3" height=3D"15.0" fill=3D"rgb(205,9=
3,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"352.50" y=3D"79.5" ></text>=0A</g>=
=0A<g >=0A<title>syscall_trace_enter.constprop.0 (48,841,017,392 samples, 0=
=2E61%)</title><rect x=3D"608.9" y=3D"309" width=3D"7.2" height=3D"15.0" fi=
ll=3D"rgb(246,147,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"611.93" y=3D"319.=
5" ></text>=0A</g>=0A<g >=0A<title>memcg_account_kmem (6,473,173,522 sample=
s, 0.08%)</title><rect x=3D"434.2" y=3D"197" width=3D"0.9" height=3D"15.0" =
fill=3D"rgb(244,224,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"437.16" y=3D"20=
7.5" ></text>=0A</g>=0A<g >=0A<title>preempt_count_add (27,996,205,794 samp=
les, 0.35%)</title><rect x=3D"482.1" y=3D"197" width=3D"4.1" height=3D"15.0=
" fill=3D"rgb(223,143,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"485.08" y=3D"=
207.5" ></text>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (40=
,194,461,063 samples, 0.50%)</title><rect x=3D"837.7" y=3D"85" width=3D"5.9=
" height=3D"15.0" fill=3D"rgb(222,203,46)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"840.65" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>put_prev_entity (1,6=
82,751,372 samples, 0.02%)</title><rect x=3D"603.2" y=3D"229" width=3D"0.3"=
 height=3D"15.0" fill=3D"rgb(250,121,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"606.23" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>in_lock_functions (3,0=
33,569,367 samples, 0.04%)</title><rect x=3D"730.3" y=3D"197" width=3D"0.5"=
 height=3D"15.0" fill=3D"rgb(234,42,46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"733.35" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disab=
led (7,524,135,171 samples, 0.09%)</title><rect x=3D"979.2" y=3D"117" width=
=3D"1.1" height=3D"15.0" fill=3D"rgb(206,222,22)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"982.22" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>update_load_a=
vg (11,526,056,705 samples, 0.14%)</title><rect x=3D"1144.1" y=3D"117" widt=
h=3D"1.7" height=3D"15.0" fill=3D"rgb(238,219,34)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1147.08" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>mod_memcg_s=
tate (14,687,780,676 samples, 0.18%)</title><rect x=3D"256.0" y=3D"149" wid=
th=3D"2.1" height=3D"15.0" fill=3D"rgb(240,177,7)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"258.97" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>reweight_ent=
ity (6,478,310,064 samples, 0.08%)</title><rect x=3D"456.8" y=3D"165" width=
=3D"0.9" height=3D"15.0" fill=3D"rgb(238,171,19)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"459.76" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__x86_indirec=
t_thunk_array (1,371,350,829 samples, 0.02%)</title><rect x=3D"1183.0" y=3D=
"325" width=3D"0.2" height=3D"15.0" fill=3D"rgb(249,135,14)" rx=3D"2" ry=3D=
"2" />=0A<text  x=3D"1186.00" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>p=
ut_cpu_partial (7,814,070,901 samples, 0.10%)</title><rect x=3D"449.0" y=3D=
"229" width=3D"1.2" height=3D"15.0" fill=3D"rgb(237,35,0)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"452.01" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>audi=
t_reset_context (6,218,584,912 samples, 0.08%)</title><rect x=3D"1170.4" y=
=3D"277" width=3D"1.0" height=3D"15.0" fill=3D"rgb(211,166,6)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1173.44" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<titl=
e>native_queued_spin_lock_slowpath (42,041,164,671 samples, 0.52%)</title><=
rect x=3D"302.5" y=3D"165" width=3D"6.2" height=3D"15.0" fill=3D"rgb(247,20=
2,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"305.55" y=3D"175.5" ></text>=0A</=
g>=0A<g >=0A<title>_raw_spin_lock_irqsave (41,921,796,386 samples, 0.52%)</=
title><rect x=3D"837.4" y=3D"101" width=3D"6.2" height=3D"15.0" fill=3D"rgb=
(242,7,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"840.40" y=3D"111.5" ></text>=
=0A</g>=0A<g >=0A<title>security_socket_sendmsg (33,386,955,777 samples, 0.=
42%)</title><rect x=3D"696.7" y=3D"245" width=3D"4.9" height=3D"15.0" fill=
=3D"rgb(238,75,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"699.71" y=3D"255.5" =
></text>=0A</g>=0A<g >=0A<title>native_sched_clock (1,139,921,226 samples, =
0.01%)</title><rect x=3D"1148.6" y=3D"101" width=3D"0.1" height=3D"15.0" fi=
ll=3D"rgb(214,70,5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1151.57" y=3D"111.5=
" ></text>=0A</g>=0A<g >=0A<title>__switch_to (4,307,960,392 samples, 0.05%=
)</title><rect x=3D"1183.5" y=3D"373" width=3D"0.7" height=3D"15.0" fill=3D=
"rgb(221,33,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1186.53" y=3D"383.5" ><=
/text>=0A</g>=0A<g >=0A<title>__cond_resched (4,667,068,899 samples, 0.06%)=
</title><rect x=3D"446.6" y=3D"213" width=3D"0.7" height=3D"15.0" fill=3D"r=
gb(242,222,50)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"449.65" y=3D"223.5" ></t=
ext>=0A</g>=0A<g >=0A<title>__schedule (127,211,555,886 samples, 1.58%)</ti=
tle><rect x=3D"451.0" y=3D"197" width=3D"18.7" height=3D"15.0" fill=3D"rgb(=
228,153,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"454.02" y=3D"207.5" ></text=
>=0A</g>=0A<g >=0A<title>entry_SYSCALL_64 (60,869,941,458 samples, 0.76%)</=
title><rect x=3D"628.5" y=3D"341" width=3D"8.9" height=3D"15.0" fill=3D"rgb=
(214,42,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"631.49" y=3D"351.5" ></text>=
=0A</g>=0A<g >=0A<title>psi_flags_change (951,811,362 samples, 0.01%)</titl=
e><rect x=3D"1135.4" y=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(22=
6,31,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1138.43" y=3D"111.5" ></text>=
=0A</g>=0A<g >=0A<title>set_next_entity (858,816,675 samples, 0.01%)</title=
><rect x=3D"1167.3" y=3D"229" width=3D"0.1" height=3D"15.0" fill=3D"rgb(248=
,1,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1170.31" y=3D"239.5" ></text>=0A=
</g>=0A<g >=0A<title>check_preemption_disabled (1,806,096,608 samples, 0.02=
%)</title><rect x=3D"435.5" y=3D"181" width=3D"0.3" height=3D"15.0" fill=3D=
"rgb(253,10,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"438.49" y=3D"191.5" ></=
text>=0A</g>=0A<g >=0A<title>psi_task_switch (20,346,271,862 samples, 0.25%=
)</title><rect x=3D"464.8" y=3D"181" width=3D"2.9" height=3D"15.0" fill=3D"=
rgb(222,227,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"467.76" y=3D"191.5" ></=
text>=0A</g>=0A<g >=0A<title>sock_read_iter (9,381,663,380 samples, 0.12%)<=
/title><rect x=3D"1185.7" y=3D"309" width=3D"1.3" height=3D"15.0" fill=3D"r=
gb(209,194,42)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.66" y=3D"319.5" ></=
text>=0A</g>=0A<g >=0A<title>refill_stock (13,907,472,692 samples, 0.17%)</=
title><rect x=3D"258.1" y=3D"165" width=3D"2.1" height=3D"15.0" fill=3D"rgb=
(222,199,49)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"261.12" y=3D"175.5" ></tex=
t>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (3,220,431,968 samples, 0.04%)<=
/title><rect x=3D"1048.6" y=3D"149" width=3D"0.5" height=3D"15.0" fill=3D"r=
gb(231,85,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1051.62" y=3D"159.5" ></t=
ext>=0A</g>=0A<g >=0A<title>do_syscall_64 (10,564,427,086 samples, 0.13%)</=
title><rect x=3D"1185.7" y=3D"357" width=3D"1.5" height=3D"15.0" fill=3D"rg=
b(213,98,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.66" y=3D"367.5" ></te=
xt>=0A</g>=0A<g >=0A<title>__rcu_read_lock (8,504,159,876 samples, 0.11%)</=
title><rect x=3D"1127.3" y=3D"213" width=3D"1.2" height=3D"15.0" fill=3D"rg=
b(251,153,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1130.26" y=3D"223.5" ></t=
ext>=0A</g>=0A<g >=0A<title>cgroup_rstat_updated (3,086,579,915 samples, 0.=
04%)</title><rect x=3D"257.1" y=3D"117" width=3D"0.5" height=3D"15.0" fill=
=3D"rgb(246,105,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"260.13" y=3D"127.5"=
 ></text>=0A</g>=0A<g >=0A<title>ksize (11,056,308,238 samples, 0.14%)</tit=
le><rect x=3D"1113.2" y=3D"181" width=3D"1.6" height=3D"15.0" fill=3D"rgb(2=
24,199,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1116.16" y=3D"191.5" ></text=
>=0A</g>=0A<g >=0A<title>set_next_entity (1,275,877,772 samples, 0.02%)</ti=
tle><rect x=3D"603.5" y=3D"229" width=3D"0.2" height=3D"15.0" fill=3D"rgb(2=
19,227,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"606.48" y=3D"239.5" ></text>=
=0A</g>=0A<g >=0A<title>preempt_count_add (28,644,311,422 samples, 0.36%)</=
title><rect x=3D"167.5" y=3D"213" width=3D"4.2" height=3D"15.0" fill=3D"rgb=
(246,53,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"170.50" y=3D"223.5" ></text=
>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (17,894,643,308 s=
amples, 0.22%)</title><rect x=3D"1130.2" y=3D"133" width=3D"2.6" height=3D"=
15.0" fill=3D"rgb(253,180,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1133.18" =
y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__cond_resched (3,736,231,672 s=
amples, 0.05%)</title><rect x=3D"822.1" y=3D"149" width=3D"0.6" height=3D"1=
5.0" fill=3D"rgb(237,72,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"825.10" y=
=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__get_obj_cgroup_from_memcg (23,=
963,365,797 samples, 0.30%)</title><rect x=3D"1024.7" y=3D"149" width=3D"3.=
6" height=3D"15.0" fill=3D"rgb(212,173,24)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1027.74" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>native_queued_spin=
_lock_slowpath (1,228,674,349 samples, 0.02%)</title><rect x=3D"602.7" y=3D=
"229" width=3D"0.2" height=3D"15.0" fill=3D"rgb(213,66,11)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"605.68" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__r=
cu_read_lock (859,726,907 samples, 0.01%)</title><rect x=3D"433.9" y=3D"197=
" width=3D"0.1" height=3D"15.0" fill=3D"rgb(227,132,39)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"436.92" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>memcg_=
account_kmem (6,664,014,504 samples, 0.08%)</title><rect x=3D"1110.2" y=3D"=
149" width=3D"0.9" height=3D"15.0" fill=3D"rgb(217,221,40)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"1113.17" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>sk=
b_copy_datagram_iter (660,151,626,090 samples, 8.22%)</title><rect x=3D"488=
=2E2" y=3D"213" width=3D"97.0" height=3D"15.0" fill=3D"rgb(209,158,32)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"491.23" y=3D"223.5" >skb_copy_da..</text>=
=0A</g>=0A<g >=0A<title>__update_load_avg_cfs_rq (2,905,616,105 samples, 0.=
04%)</title><rect x=3D"460.1" y=3D"149" width=3D"0.4" height=3D"15.0" fill=
=3D"rgb(227,47,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"463.11" y=3D"159.5" =
></text>=0A</g>=0A<g >=0A<title>psi_group_change (3,558,755,440 samples, 0.=
04%)</title><rect x=3D"1118.2" y=3D"149" width=3D"0.5" height=3D"15.0" fill=
=3D"rgb(229,85,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1121.20" y=3D"159.5"=
 ></text>=0A</g>=0A<g >=0A<title>unix_stream_recvmsg (950,674,222 samples, =
0.01%)</title><rect x=3D"620.5" y=3D"341" width=3D"0.1" height=3D"15.0" fil=
l=3D"rgb(228,223,50)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"623.48" y=3D"351.5=
" ></text>=0A</g>=0A<g >=0A<title>__check_heap_object (11,522,205,239 sampl=
es, 0.14%)</title><rect x=3D"747.2" y=3D"197" width=3D"1.7" height=3D"15.0"=
 fill=3D"rgb(228,6,44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"750.18" y=3D"207=
=2E5" ></text>=0A</g>=0A<g >=0A<title>ttwu_queue_wakelist (1,954,771,857 sa=
mples, 0.02%)</title><rect x=3D"1147.4" y=3D"149" width=3D"0.3" height=3D"1=
5.0" fill=3D"rgb(206,103,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1150.37" y=
=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>debug_smp_processor_id (1,871,26=
3,899 samples, 0.02%)</title><rect x=3D"431.5" y=3D"197" width=3D"0.2" heig=
ht=3D"15.0" fill=3D"rgb(242,220,46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"434=
=2E45" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_=
slowpath (4,044,966,659 samples, 0.05%)</title><rect x=3D"452.9" y=3D"165" =
width=3D"0.6" height=3D"15.0" fill=3D"rgb(228,206,44)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"455.90" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>preempt_=
count_add (31,040,837,496 samples, 0.39%)</title><rect x=3D"726.2" y=3D"213=
" width=3D"4.6" height=3D"15.0" fill=3D"rgb(229,118,4)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"729.24" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>check_p=
reemption_disabled (6,673,240,695 samples, 0.08%)</title><rect x=3D"977.0" =
y=3D"117" width=3D"1.0" height=3D"15.0" fill=3D"rgb(250,68,29)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"980.03" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title=
>cpuidle_enter (974,711,438 samples, 0.01%)</title><rect x=3D"1189.7" y=3D"=
325" width=3D"0.1" height=3D"15.0" fill=3D"rgb(216,141,31)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"1192.70" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>__=
cgroup_account_cputime (1,316,255,068 samples, 0.02%)</title><rect x=3D"455=
=2E6" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(249,46,6)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"458.60" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<=
title>__wake_up_common_lock (21,096,902,510 samples, 0.26%)</title><rect x=
=3D"348.1" y=3D"149" width=3D"3.1" height=3D"15.0" fill=3D"rgb(253,111,12)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"351.07" y=3D"159.5" ></text>=0A</g>=0A<=
g >=0A<title>__wake_up_common (138,092,024,653 samples, 1.72%)</title><rect=
 x=3D"1128.7" y=3D"197" width=3D"20.3" height=3D"15.0" fill=3D"rgb(231,179,=
54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1131.72" y=3D"207.5" ></text>=0A</g=
>=0A<g >=0A<title>set_next_buddy (7,080,757,350 samples, 0.09%)</title><rec=
t x=3D"457.7" y=3D"165" width=3D"1.1" height=3D"15.0" fill=3D"rgb(247,26,49=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"460.71" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>should_failslab (1,681,651,698 samples, 0.02%)</title><rec=
t x=3D"1112.9" y=3D"165" width=3D"0.3" height=3D"15.0" fill=3D"rgb(236,203,=
30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1115.91" y=3D"175.5" ></text>=0A</g=
>=0A<g >=0A<title>skb_unlink (93,918,460,829 samples, 1.17%)</title><rect x=
=3D"472.4" y=3D"229" width=3D"13.8" height=3D"15.0" fill=3D"rgb(215,84,14)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"475.40" y=3D"239.5" ></text>=0A</g>=0A<=
g >=0A<title>__x86_indirect_thunk_array (944,619,323 samples, 0.01%)</title=
><rect x=3D"620.3" y=3D"325" width=3D"0.2" height=3D"15.0" fill=3D"rgb(232,=
169,36)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"623.33" y=3D"335.5" ></text>=0A=
</g>=0A<g >=0A<title>unix_stream_read_actor (674,033,739,860 samples, 8.39%=
)</title><rect x=3D"486.2" y=3D"229" width=3D"99.0" height=3D"15.0" fill=3D=
"rgb(252,25,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"489.19" y=3D"239.5" >un=
ix_stream..</text>=0A</g>=0A<g >=0A<title>__update_load_avg_se (3,359,446,5=
52 samples, 0.04%)</title><rect x=3D"460.5" y=3D"149" width=3D"0.5" height=
=3D"15.0" fill=3D"rgb(211,187,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"463.5=
4" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (1,498,110,5=
11 samples, 0.02%)</title><rect x=3D"966.6" y=3D"133" width=3D"0.2" height=
=3D"15.0" fill=3D"rgb(231,15,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"969.58=
" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>debug_smp_processor_id (3,083=
,501,118 samples, 0.04%)</title><rect x=3D"444.3" y=3D"197" width=3D"0.4" h=
eight=3D"15.0" fill=3D"rgb(229,105,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
447.25" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>native_sched_clock (1,2=
62,190,916 samples, 0.02%)</title><rect x=3D"467.5" y=3D"149" width=3D"0.2"=
 height=3D"15.0" fill=3D"rgb(207,73,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"470.54" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>cgroup_rstat_updated (=
2,632,806,932 samples, 0.03%)</title><rect x=3D"252.9" y=3D"133" width=3D"0=
=2E4" height=3D"15.0" fill=3D"rgb(215,226,36)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"255.88" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>psi_task_switch =
(681,999,493 samples, 0.01%)</title><rect x=3D"1167.4" y=3D"245" width=3D"0=
=2E1" height=3D"15.0" fill=3D"rgb(249,116,16)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1170.45" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlo=
ck (709,800,478 samples, 0.01%)</title><rect x=3D"434.0" y=3D"197" width=3D=
"0.2" height=3D"15.0" fill=3D"rgb(214,201,32)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"437.05" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>enqueue_entity (=
21,518,879,781 samples, 0.27%)</title><rect x=3D"1138.9" y=3D"117" width=3D=
"3.1" height=3D"15.0" fill=3D"rgb(227,6,44)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"1141.86" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_lruve=
c_state (10,804,295,697 samples, 0.13%)</title><rect x=3D"937.7" y=3D"101" =
width=3D"1.6" height=3D"15.0" fill=3D"rgb(245,58,26)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"940.72" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__x64_sy=
s_write (23,093,725,583 samples, 0.29%)</title><rect x=3D"642.2" y=3D"309" =
width=3D"3.3" height=3D"15.0" fill=3D"rgb(221,164,26)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"645.16" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>schedule=
_timeout (9,337,210,204 samples, 0.12%)</title><rect x=3D"1185.7" y=3D"261"=
 width=3D"1.3" height=3D"15.0" fill=3D"rgb(252,219,5)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1188.67" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__list_=
del_entry_valid (16,417,995,853 samples, 0.20%)</title><rect x=3D"835.0" y=
=3D"101" width=3D"2.4" height=3D"15.0" fill=3D"rgb(229,59,27)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"837.99" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title=
>_raw_spin_lock (41,192,803,823 samples, 0.51%)</title><rect x=3D"165.7" y=
=3D"229" width=3D"6.0" height=3D"15.0" fill=3D"rgb(239,208,37)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"168.65" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title=
>write (10,191,428,030 samples, 0.13%)</title><rect x=3D"1188.2" y=3D"389" =
width=3D"1.4" height=3D"15.0" fill=3D"rgb(237,176,1)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1191.15" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>mod_obj=
cg_state (277,664,214,311 samples, 3.46%)</title><rect x=3D"1049.1" y=3D"14=
9" width=3D"40.8" height=3D"15.0" fill=3D"rgb(233,65,13)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1052.13" y=3D"159.5" >mod..</text>=0A</g>=0A<g >=0A<title=
>hackbench (8,032,762,204,759 samples, 99.97%)</title><rect x=3D"10.0" y=3D=
"405" width=3D"1179.6" height=3D"15.0" fill=3D"rgb(231,126,23)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"13.00" y=3D"415.5" >hackbench</text>=0A</g>=0A<g >=
=0A<title>debug_smp_processor_id (2,532,667,971 samples, 0.03%)</title><rec=
t x=3D"1109.8" y=3D"149" width=3D"0.4" height=3D"15.0" fill=3D"rgb(206,157,=
26)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1112.80" y=3D"159.5" ></text>=0A</g=
>=0A<g >=0A<title>_raw_spin_unlock_irqrestore (13,171,614,961 samples, 0.16=
%)</title><rect x=3D"173.9" y=3D"229" width=3D"1.9" height=3D"15.0" fill=3D=
"rgb(216,78,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"176.89" y=3D"239.5" ></=
text>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (7,775,871,40=
1 samples, 0.10%)</title><rect x=3D"1149.2" y=3D"181" width=3D"1.1" height=
=3D"15.0" fill=3D"rgb(250,224,10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1152.=
18" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>restore_fpregs_from_fpstate=
 (4,221,007,268 samples, 0.05%)</title><rect x=3D"1165.8" y=3D"261" width=
=3D"0.7" height=3D"15.0" fill=3D"rgb(214,71,27)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1168.84" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>sched_clock_c=
pu (1,872,312,434 samples, 0.02%)</title><rect x=3D"469.4" y=3D"165" width=
=3D"0.3" height=3D"15.0" fill=3D"rgb(222,206,16)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"472.42" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__wrgsbase_in=
active (2,550,377,784 samples, 0.03%)</title><rect x=3D"1185.2" y=3D"373" w=
idth=3D"0.4" height=3D"15.0" fill=3D"rgb(229,156,22)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1188.22" y=3D"383.5" ></text>=0A</g>=0A<g >=0A<title>drain_s=
tock (1,730,116,865 samples, 0.02%)</title><rect x=3D"259.9" y=3D"149" widt=
h=3D"0.3" height=3D"15.0" fill=3D"rgb(218,195,7)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"262.91" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>put_pid (2,89=
6,892,291 samples, 0.04%)</title><rect x=3D"322.2" y=3D"181" width=3D"0.4" =
height=3D"15.0" fill=3D"rgb(228,42,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
325.18" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>memcg_account_kmem (14,=
916,534,675 samples, 0.19%)</title><rect x=3D"255.9" y=3D"165" width=3D"2.2=
" height=3D"15.0" fill=3D"rgb(246,213,8)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"258.93" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>switch_mm_irqs_off =
(1,091,242,659 samples, 0.01%)</title><rect x=3D"1187.0" y=3D"277" width=3D=
"0.2" height=3D"15.0" fill=3D"rgb(245,129,30)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1190.05" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>check_preemptio=
n_disabled (32,182,388,884 samples, 0.40%)</title><rect x=3D"439.5" y=3D"19=
7" width=3D"4.8" height=3D"15.0" fill=3D"rgb(247,87,18)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"442.53" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>cgroup=
_rstat_updated (1,362,967,806 samples, 0.02%)</title><rect x=3D"1110.7" y=
=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(244,15,8)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1113.67" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<titl=
e>mod_memcg_lruvec_state (9,209,880,357 samples, 0.11%)</title><rect x=3D"4=
31.7" y=3D"197" width=3D"1.4" height=3D"15.0" fill=3D"rgb(210,3,7)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"434.73" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<t=
itle>__fget_light (36,343,960,086 samples, 0.45%)</title><rect x=3D"47.2" y=
=3D"277" width=3D"5.4" height=3D"15.0" fill=3D"rgb(238,125,6)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"50.24" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>=
exit_to_user_mode_prepare (70,799,612,639 samples, 0.88%)</title><rect x=3D=
"1157.2" y=3D"293" width=3D"10.4" height=3D"15.0" fill=3D"rgb(229,26,42)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"1160.24" y=3D"303.5" ></text>=0A</g>=0A<g=
 >=0A<title>__get_obj_cgroup_from_memcg (15,877,151,318 samples, 0.20%)</ti=
tle><rect x=3D"848.7" y=3D"133" width=3D"2.4" height=3D"15.0" fill=3D"rgb(2=
40,139,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"851.72" y=3D"143.5" ></text>=
=0A</g>=0A<g >=0A<title>_raw_spin_lock (18,939,679,051 samples, 0.24%)</tit=
le><rect x=3D"1130.1" y=3D"149" width=3D"2.8" height=3D"15.0" fill=3D"rgb(2=
48,56,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1133.10" y=3D"159.5" ></text>=
=0A</g>=0A<g >=0A<title>__build_skb_around (23,394,531,135 samples, 0.29%)<=
/title><rect x=3D"805.6" y=3D"181" width=3D"3.4" height=3D"15.0" fill=3D"rg=
b(251,41,47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"808.59" y=3D"191.5" ></tex=
t>=0A</g>=0A<g >=0A<title>__kmalloc_node_track_caller (1,188,543,555,175 sa=
mples, 14.79%)</title><rect x=3D"809.0" y=3D"181" width=3D"174.6" height=3D=
"15.0" fill=3D"rgb(250,63,47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"812.02" y=
=3D"191.5" >__kmalloc_node_track_c..</text>=0A</g>=0A<g >=0A<title>update_l=
oad_avg (2,318,347,306 samples, 0.03%)</title><rect x=3D"350.5" y=3D"53" wi=
dth=3D"0.3" height=3D"15.0" fill=3D"rgb(234,197,19)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"353.49" y=3D"63.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin=
_unlock_irqrestore (1,587,280,514 samples, 0.02%)</title><rect x=3D"843.6" =
y=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(230,110,37)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"846.55" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__rcu_read_lock (2,643,929,430 samples, 0.03%)</title><rect x=3D"1028.3" =
y=3D"149" width=3D"0.3" height=3D"15.0" fill=3D"rgb(213,142,51)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"1031.26" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<tit=
le>sock_read_iter (4,431,218,261 samples, 0.06%)</title><rect x=3D"617.4" y=
=3D"341" width=3D"0.6" height=3D"15.0" fill=3D"rgb(238,119,50)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"620.38" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title=
>sched_clock_cpu (1,366,721,393 samples, 0.02%)</title><rect x=3D"469.2" y=
=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(229,53,54)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"472.22" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title=
>__rcu_read_unlock (4,453,170,565 samples, 0.06%)</title><rect x=3D"1000.0"=
 y=3D"165" width=3D"0.6" height=3D"15.0" fill=3D"rgb(223,162,46)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"1002.97" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>load_new_mm_cr3 (1,039,380,845 samples, 0.01%)</title><rect x=3D"1189.3=
" y=3D"261" width=3D"0.1" height=3D"15.0" fill=3D"rgb(206,212,34)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"1192.25" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<t=
itle>__rcu_read_unlock (3,681,587,107 samples, 0.05%)</title><rect x=3D"851=
=2E4" y=3D"133" width=3D"0.5" height=3D"15.0" fill=3D"rgb(217,148,8)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"854.37" y=3D"143.5" ></text>=0A</g>=0A<g >=0A=
<title>audit_reset_context (5,262,532,452 samples, 0.07%)</title><rect x=3D=
"608.2" y=3D"277" width=3D"0.7" height=3D"15.0" fill=3D"rgb(225,229,13)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"611.16" y=3D"287.5" ></text>=0A</g>=0A<g >=
=0A<title>check_preemption_disabled (1,171,289,354 samples, 0.01%)</title><=
rect x=3D"1134.7" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(250,7=
6,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1137.71" y=3D"143.5" ></text>=0A</=
g>=0A<g >=0A<title>skb_copy_datagram_from_iter (258,913,193,957 samples, 3.=
22%)</title><rect x=3D"740.8" y=3D"229" width=3D"38.1" height=3D"15.0" fill=
=3D"rgb(231,119,17)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"743.85" y=3D"239.5"=
 >skb..</text>=0A</g>=0A<g >=0A<title>__virt_addr_valid (72,405,559,531 sam=
ples, 0.90%)</title><rect x=3D"748.9" y=3D"197" width=3D"10.6" height=3D"15=
=2E0" fill=3D"rgb(209,45,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"751.87" y=
=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (7,526,188,941 s=
amples, 0.09%)</title><rect x=3D"347.0" y=3D"149" width=3D"1.1" height=3D"1=
5.0" fill=3D"rgb(242,186,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"349.96" y=
=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__x64_sys_read (13,137,359,344 s=
amples, 0.16%)</title><rect x=3D"42.0" y=3D"309" width=3D"2.0" height=3D"15=
=2E0" fill=3D"rgb(213,48,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"45.05" y=
=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>__check_heap_object (20,765,636,=
821 samples, 0.26%)</title><rect x=3D"571.0" y=3D"149" width=3D"3.0" height=
=3D"15.0" fill=3D"rgb(227,123,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"573.9=
7" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (3,627,697=
,809 samples, 0.05%)</title><rect x=3D"231.0" y=3D"181" width=3D"0.5" heigh=
t=3D"15.0" fill=3D"rgb(241,110,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"233.9=
7" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>mod_memcg_lruvec_state (12,3=
11,054,902 samples, 0.15%)</title><rect x=3D"937.5" y=3D"117" width=3D"1.8"=
 height=3D"15.0" fill=3D"rgb(213,97,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
940.50" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_unlock_irqres=
tore (2,229,812,162 samples, 0.03%)</title><rect x=3D"1019.2" y=3D"117" wid=
th=3D"0.3" height=3D"15.0" fill=3D"rgb(240,177,32)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"1022.21" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>load_new_m=
m_cr3 (1,045,692,610 samples, 0.01%)</title><rect x=3D"1187.1" y=3D"261" wi=
dth=3D"0.1" height=3D"15.0" fill=3D"rgb(208,115,52)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1190.06" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>cache_f=
rom_obj (164,952,753,744 samples, 2.05%)</title><rect x=3D"389.3" y=3D"213"=
 width=3D"24.3" height=3D"15.0" fill=3D"rgb(230,129,17)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"392.33" y=3D"223.5" >c..</text>=0A</g>=0A<g >=0A<title>ent=
ry_SYSCALL_64_after_hwframe (10,564,427,086 samples, 0.13%)</title><rect x=
=3D"1185.7" y=3D"373" width=3D"1.5" height=3D"15.0" fill=3D"rgb(221,5,3)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"1188.66" y=3D"383.5" ></text>=0A</g>=0A<g=
 >=0A<title>update_curr (6,944,467,534 samples, 0.09%)</title><rect x=3D"11=
40.5" y=3D"101" width=3D"1.0" height=3D"15.0" fill=3D"rgb(248,138,16)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1143.53" y=3D"111.5" ></text>=0A</g>=0A<g =
>=0A<title>__get_task_ioprio (17,096,909,652 samples, 0.21%)</title><rect x=
=3D"672.9" y=3D"277" width=3D"2.5" height=3D"15.0" fill=3D"rgb(241,35,0)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"675.90" y=3D"287.5" ></text>=0A</g>=0A<g =
>=0A<title>check_preemption_disabled (45,181,291,017 samples, 0.56%)</title=
><rect x=3D"967.0" y=3D"133" width=3D"6.7" height=3D"15.0" fill=3D"rgb(252,=
170,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"970.05" y=3D"143.5" ></text>=0A=
</g>=0A<g >=0A<title>_raw_spin_lock (59,226,294,544 samples, 0.74%)</title>=
<rect x=3D"722.1" y=3D"229" width=3D"8.7" height=3D"15.0" fill=3D"rgb(224,6=
6,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"725.10" y=3D"239.5" ></text>=0A</=
g>=0A<g >=0A<title>syscall_exit_to_user_mode (1,267,202,789 samples, 0.02%)=
</title><rect x=3D"1189.2" y=3D"341" width=3D"0.2" height=3D"15.0" fill=3D"=
rgb(245,147,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.22" y=3D"351.5" ><=
/text>=0A</g>=0A<g >=0A<title>mod_memcg_state (6,437,074,561 samples, 0.08%=
)</title><rect x=3D"1110.2" y=3D"133" width=3D"0.9" height=3D"15.0" fill=3D=
"rgb(223,134,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1113.20" y=3D"143.5" >=
</text>=0A</g>=0A<g >=0A<title>update_rq_clock (9,148,268,975 samples, 0.11=
%)</title><rect x=3D"1147.7" y=3D"149" width=3D"1.3" height=3D"15.0" fill=
=3D"rgb(234,39,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1150.65" y=3D"159.5"=
 ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (3,320,993,719 samples, =
0.04%)</title><rect x=3D"1028.6" y=3D"149" width=3D"0.5" height=3D"15.0" fi=
ll=3D"rgb(246,184,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1031.65" y=3D"159=
=2E5" ></text>=0A</g>=0A<g >=0A<title>syscall_enter_from_user_mode (10,981,=
268,969 samples, 0.14%)</title><rect x=3D"585.2" y=3D"309" width=3D"1.6" he=
ight=3D"15.0" fill=3D"rgb(211,81,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"58=
8.18" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>rb_insert_color (951,142,=
906 samples, 0.01%)</title><rect x=3D"1140.4" y=3D"101" width=3D"0.1" heigh=
t=3D"15.0" fill=3D"rgb(205,202,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1143=
=2E35" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>place_entity (1,140,176,=
432 samples, 0.01%)</title><rect x=3D"1140.2" y=3D"101" width=3D"0.2" heigh=
t=3D"15.0" fill=3D"rgb(243,61,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1143.=
19" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__wake_up_common_lock (151,=
896,058,775 samples, 1.89%)</title><rect x=3D"1128.5" y=3D"213" width=3D"22=
=2E3" height=3D"15.0" fill=3D"rgb(232,1,13)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"1131.51" y=3D"223.5" >_..</text>=0A</g>=0A<g >=0A<title>schedule_timeo=
ut (26,958,348,922 samples, 0.34%)</title><rect x=3D"1115.2" y=3D"213" widt=
h=3D"3.9" height=3D"15.0" fill=3D"rgb(220,116,28)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1118.18" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>check_preem=
ption_disabled (768,923,043 samples, 0.01%)</title><rect x=3D"844.1" y=3D"1=
33" width=3D"0.1" height=3D"15.0" fill=3D"rgb(208,129,9)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"847.08" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>debug=
_smp_processor_id (3,090,230,228 samples, 0.04%)</title><rect x=3D"270.4" y=
=3D"165" width=3D"0.5" height=3D"15.0" fill=3D"rgb(208,8,19)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"273.45" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title=
>__rseq_handle_notify_resume (2,905,857,609 samples, 0.04%)</title><rect x=
=3D"1165.3" y=3D"277" width=3D"0.4" height=3D"15.0" fill=3D"rgb(249,0,21)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"1168.28" y=3D"287.5" ></text>=0A</g>=0A<=
g >=0A<title>_raw_spin_lock_irqsave (2,352,452,725 samples, 0.03%)</title><=
rect x=3D"1132.9" y=3D"149" width=3D"0.3" height=3D"15.0" fill=3D"rgb(222,8=
5,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1135.88" y=3D"159.5" ></text>=0A<=
/g>=0A<g >=0A<title>bpf_lsm_socket_sendmsg (15,017,530,236 samples, 0.19%)<=
/title><rect x=3D"699.4" y=3D"229" width=3D"2.2" height=3D"15.0" fill=3D"rg=
b(235,221,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"702.40" y=3D"239.5" ></te=
xt>=0A</g>=0A<g >=0A<title>ksys_read (3,685,250,785,901 samples, 45.86%)</t=
itle><rect x=3D"44.0" y=3D"309" width=3D"541.2" height=3D"15.0" fill=3D"rgb=
(252,47,44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"46.98" y=3D"319.5" >ksys_re=
ad</text>=0A</g>=0A<g >=0A<title>memcg_slab_post_alloc_hook (595,107,598,47=
9 samples, 7.41%)</title><rect x=3D"851.9" y=3D"149" width=3D"87.4" height=
=3D"15.0" fill=3D"rgb(238,229,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"854.9=
1" y=3D"159.5" >memcg_slab..</text>=0A</g>=0A<g >=0A<title>cmpxchg_double_s=
lab.constprop.0.isra.0 (47,165,464,315 samples, 0.59%)</title><rect x=3D"29=
1.8" y=3D"181" width=3D"6.9" height=3D"15.0" fill=3D"rgb(252,100,8)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"294.76" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<=
title>rb_next (907,797,985 samples, 0.01%)</title><rect x=3D"463.9" y=3D"14=
9" width=3D"0.2" height=3D"15.0" fill=3D"rgb(237,156,9)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"466.94" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__upda=
te_load_avg_cfs_rq (1,321,144,892 samples, 0.02%)</title><rect x=3D"1141.7"=
 y=3D"85" width=3D"0.2" height=3D"15.0" fill=3D"rgb(238,34,40)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1144.70" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title=
>exit_to_user_mode_prepare (104,452,028,612 samples, 1.30%)</title><rect x=
=3D"588.6" y=3D"293" width=3D"15.4" height=3D"15.0" fill=3D"rgb(217,131,41)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"591.64" y=3D"303.5" ></text>=0A</g>=0A=
<g >=0A<title>vfs_write (3,400,268,660,418 samples, 42.32%)</title><rect x=
=3D"654.8" y=3D"293" width=3D"499.4" height=3D"15.0" fill=3D"rgb(237,34,46)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"657.82" y=3D"303.5" >vfs_write</text>=
=0A</g>=0A<g >=0A<title>native_sched_clock (1,714,179,920 samples, 0.02%)</=
title><rect x=3D"1148.7" y=3D"117" width=3D"0.3" height=3D"15.0" fill=3D"rg=
b(222,14,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1151.75" y=3D"127.5" ></te=
xt>=0A</g>=0A<g >=0A<title>select_task_rq_fair (10,292,074,048 samples, 0.1=
3%)</title><rect x=3D"1133.5" y=3D"149" width=3D"1.5" height=3D"15.0" fill=
=3D"rgb(217,173,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1136.52" y=3D"159.5=
" ></text>=0A</g>=0A<g >=0A<title>psi_account_irqtime (819,355,430 samples,=
 0.01%)</title><rect x=3D"1118.9" y=3D"149" width=3D"0.1" height=3D"15.0" f=
ill=3D"rgb(229,107,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1121.91" y=3D"15=
9.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (4,427,395,7=
01 samples, 0.06%)</title><rect x=3D"259.2" y=3D"149" width=3D"0.7" height=
=3D"15.0" fill=3D"rgb(207,80,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"262.21=
" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowp=
ath (35,960,220,566 samples, 0.45%)</title><rect x=3D"1013.9" y=3D"101" wid=
th=3D"5.3" height=3D"15.0" fill=3D"rgb(240,52,37)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1016.93" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>update_load=
_avg (1,134,771,902 samples, 0.01%)</title><rect x=3D"350.1" y=3D"37" width=
=3D"0.1" height=3D"15.0" fill=3D"rgb(221,144,38)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"353.05" y=3D"47.5" ></text>=0A</g>=0A<g >=0A<title>__schedule (1,=
267,202,789 samples, 0.02%)</title><rect x=3D"1189.2" y=3D"293" width=3D"0.=
2" height=3D"15.0" fill=3D"rgb(205,48,10)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1192.22" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (1=
,772,065,049 samples, 0.02%)</title><rect x=3D"850.6" y=3D"117" width=3D"0.=
2" height=3D"15.0" fill=3D"rgb(241,82,28)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"853.57" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_sendmsg=
 (2,084,751,145 samples, 0.03%)</title><rect x=3D"1188.9" y=3D"277" width=
=3D"0.3" height=3D"15.0" fill=3D"rgb(239,82,37)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1191.91" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>sock_write_it=
er (2,084,751,145 samples, 0.03%)</title><rect x=3D"1188.9" y=3D"309" width=
=3D"0.3" height=3D"15.0" fill=3D"rgb(248,76,20)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1191.91" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>set_next_enti=
ty (8,380,857,548 samples, 0.10%)</title><rect x=3D"463.3" y=3D"165" width=
=3D"1.3" height=3D"15.0" fill=3D"rgb(234,205,37)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"466.34" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>schedule_time=
out (134,071,637,942 samples, 1.67%)</title><rect x=3D"450.2" y=3D"229" wid=
th=3D"19.7" height=3D"15.0" fill=3D"rgb(251,9,2)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"453.16" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>mod_memcg_lru=
vec_state (10,123,593,493 samples, 0.13%)</title><rect x=3D"1088.4" y=3D"13=
3" width=3D"1.5" height=3D"15.0" fill=3D"rgb(247,105,40)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1091.42" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__sw=
itch_to (2,858,149,411 samples, 0.04%)</title><rect x=3D"452.3" y=3D"181" w=
idth=3D"0.5" height=3D"15.0" fill=3D"rgb(243,193,43)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"455.34" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>cmpxchg_=
double_slab.constprop.0.isra.0 (61,435,484,802 samples, 0.76%)</title><rect=
 x=3D"147.2" y=3D"213" width=3D"9.0" height=3D"15.0" fill=3D"rgb(220,19,10)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"150.17" y=3D"223.5" ></text>=0A</g>=0A=
<g >=0A<title>mod_memcg_state (13,931,140,744 samples, 0.17%)</title><rect =
x=3D"974.3" y=3D"117" width=3D"2.0" height=3D"15.0" fill=3D"rgb(245,34,38)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"977.26" y=3D"127.5" ></text>=0A</g>=0A<=
g >=0A<title>check_preemption_disabled (3,846,421,435 samples, 0.05%)</titl=
e><rect x=3D"975.7" y=3D"85" width=3D"0.6" height=3D"15.0" fill=3D"rgb(239,=
128,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"978.75" y=3D"95.5" ></text>=0A<=
/g>=0A<g >=0A<title>update_cfs_group (5,399,432,769 samples, 0.07%)</title>=
<rect x=3D"458.8" y=3D"165" width=3D"0.7" height=3D"15.0" fill=3D"rgb(219,2=
21,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"461.75" y=3D"175.5" ></text>=0A<=
/g>=0A<g >=0A<title>sock_sendmsg (2,084,751,145 samples, 0.03%)</title><rec=
t x=3D"1188.9" y=3D"293" width=3D"0.3" height=3D"15.0" fill=3D"rgb(224,48,1=
1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.91" y=3D"303.5" ></text>=0A</g>=
=0A<g >=0A<title>_raw_spin_unlock (9,086,161,335 samples, 0.11%)</title><re=
ct x=3D"730.8" y=3D"229" width=3D"1.3" height=3D"15.0" fill=3D"rgb(252,130,=
9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"733.79" y=3D"239.5" ></text>=0A</g>=
=0A<g >=0A<title>cgroup_rstat_updated (2,417,584,869 samples, 0.03%)</title=
><rect x=3D"432.3" y=3D"165" width=3D"0.4" height=3D"15.0" fill=3D"rgb(242,=
58,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"435.31" y=3D"175.5" ></text>=0A</=
g>=0A<g >=0A<title>put_prev_entity (1,677,384,557 samples, 0.02%)</title><r=
ect x=3D"463.1" y=3D"165" width=3D"0.2" height=3D"15.0" fill=3D"rgb(205,168=
,36)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"466.09" y=3D"175.5" ></text>=0A</g=
>=0A<g >=0A<title>__update_load_avg_se (864,875,202 samples, 0.01%)</title>=
<rect x=3D"1141.9" y=3D"85" width=3D"0.1" height=3D"15.0" fill=3D"rgb(232,1=
74,50)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1144.89" y=3D"95.5" ></text>=0A<=
/g>=0A<g >=0A<title>__audit_syscall_entry (20,943,804,675 samples, 0.26%)</=
title><rect x=3D"1173.6" y=3D"293" width=3D"3.0" height=3D"15.0" fill=3D"rg=
b(231,48,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1176.57" y=3D"303.5" ></tex=
t>=0A</g>=0A<g >=0A<title>fsnotify_perm (19,389,502,384 samples, 0.24%)</ti=
tle><rect x=3D"69.3" y=3D"277" width=3D"2.8" height=3D"15.0" fill=3D"rgb(23=
1,145,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"72.29" y=3D"287.5" ></text>=
=0A</g>=0A<g >=0A<title>memset_erms (60,260,172,310 samples, 0.75%)</title>=
<rect x=3D"1089.9" y=3D"165" width=3D"8.9" height=3D"15.0" fill=3D"rgb(233,=
14,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1092.90" y=3D"175.5" ></text>=0A=
</g>=0A<g >=0A<title>pick_next_task_fair (4,969,280,000 samples, 0.06%)</ti=
tle><rect x=3D"1117.4" y=3D"165" width=3D"0.7" height=3D"15.0" fill=3D"rgb(=
219,208,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1120.39" y=3D"175.5" ></tex=
t>=0A</g>=0A<g >=0A<title>psi_account_irqtime (6,511,676,312 samples, 0.08%=
)</title><rect x=3D"468.5" y=3D"165" width=3D"0.9" height=3D"15.0" fill=3D"=
rgb(247,119,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"471.46" y=3D"175.5" ></=
text>=0A</g>=0A<g >=0A<title>__update_load_avg_se (682,477,754 samples, 0.0=
1%)</title><rect x=3D"1118.0" y=3D"117" width=3D"0.1" height=3D"15.0" fill=
=3D"rgb(235,106,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1120.98" y=3D"127.5=
" ></text>=0A</g>=0A<g >=0A<title>[hackbench] (7,988,769,433,745 samples, 9=
9.42%)</title><rect x=3D"10.0" y=3D"373" width=3D"1173.2" height=3D"15.0" f=
ill=3D"rgb(248,123,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"13.01" y=3D"383.=
5" >[hackbench]</text>=0A</g>=0A<g >=0A<title>skb_release_head_state (260,2=
08,882,064 samples, 3.24%)</title><rect x=3D"313.0" y=3D"213" width=3D"38.2=
" height=3D"15.0" fill=3D"rgb(234,48,39)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"315.96" y=3D"223.5" >skb..</text>=0A</g>=0A<g >=0A<title>__mod_memcg_st=
ate (10,619,897,548 samples, 0.13%)</title><rect x=3D"974.8" y=3D"101" widt=
h=3D"1.5" height=3D"15.0" fill=3D"rgb(223,84,47)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"977.75" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>kmalloc_slab =
(19,381,732,693 samples, 0.24%)</title><rect x=3D"980.7" y=3D"165" width=3D=
"2.9" height=3D"15.0" fill=3D"rgb(214,192,21)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"983.72" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>update_load_avg =
(2,092,189,756 samples, 0.03%)</title><rect x=3D"1117.0" y=3D"149" width=3D=
"0.3" height=3D"15.0" fill=3D"rgb(224,139,47)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1120.00" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>bpf_lsm_file_pe=
rmission (11,110,409,935 samples, 0.14%)</title><rect x=3D"678.5" y=3D"261"=
 width=3D"1.6" height=3D"15.0" fill=3D"rgb(254,77,19)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"681.47" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__schedu=
le (25,369,054,238 samples, 0.32%)</title><rect x=3D"1115.4" y=3D"181" widt=
h=3D"3.7" height=3D"15.0" fill=3D"rgb(214,220,36)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1118.39" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__slab_allo=
c.constprop.0 (134,189,341,529 samples, 1.67%)</title><rect x=3D"1000.6" y=
=3D"165" width=3D"19.7" height=3D"15.0" fill=3D"rgb(246,64,9)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1003.63" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__slab_free (137,122,157,296 samples, 1.71%)</title><rect x=3D"136.1" y=
=3D"229" width=3D"20.1" height=3D"15.0" fill=3D"rgb(209,43,32)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"139.07" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title=
>in_lock_functions (3,369,838,722 samples, 0.04%)</title><rect x=3D"485.7" =
y=3D"181" width=3D"0.5" height=3D"15.0" fill=3D"rgb(216,51,25)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"488.70" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title=
>__switch_to_asm (2,536,882,862 samples, 0.03%)</title><rect x=3D"1188.4" y=
=3D"373" width=3D"0.3" height=3D"15.0" fill=3D"rgb(219,204,34)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1191.37" y=3D"383.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__mod_memcg_lruvec_state (9,748,513,825 samples, 0.12%)</title><rect x=3D=
"252.3" y=3D"149" width=3D"1.5" height=3D"15.0" fill=3D"rgb(225,184,52)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"255.35" y=3D"159.5" ></text>=0A</g>=0A<g >=
=0A<title>__unfreeze_partials (69,270,507,632 samples, 0.86%)</title><rect =
x=3D"298.7" y=3D"197" width=3D"10.2" height=3D"15.0" fill=3D"rgb(251,99,38)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"301.70" y=3D"207.5" ></text>=0A</g>=0A=
<g >=0A<title>_raw_spin_unlock (14,911,225,739 samples, 0.19%)</title><rect=
 x=3D"171.7" y=3D"229" width=3D"2.2" height=3D"15.0" fill=3D"rgb(220,210,18=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"174.70" y=3D"239.5" ></text>=0A</g>=
=0A<g >=0A<title>security_file_permission (28,279,509,873 samples, 0.35%)</=
title><rect x=3D"676.0" y=3D"277" width=3D"4.1" height=3D"15.0" fill=3D"rgb=
(248,99,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"678.95" y=3D"287.5" ></text=
>=0A</g>=0A<g >=0A<title>check_preemption_disabled (39,773,359,875 samples,=
 0.49%)</title><rect x=3D"264.6" y=3D"165" width=3D"5.8" height=3D"15.0" fi=
ll=3D"rgb(211,6,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"267.61" y=3D"175.5"=
 ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock (5,301,710,599 samples, 0.0=
7%)</title><rect x=3D"452.8" y=3D"181" width=3D"0.7" height=3D"15.0" fill=
=3D"rgb(251,9,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"455.76" y=3D"191.5" >=
</text>=0A</g>=0A<g >=0A<title>__x86_indirect_thunk_array (1,353,041,250 sa=
mples, 0.02%)</title><rect x=3D"701.4" y=3D"213" width=3D"0.2" height=3D"15=
=2E0" fill=3D"rgb(223,14,10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"704.41" y=
=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>syscall_exit_to_user_mode_prepar=
e (33,747,966,165 samples, 0.42%)</title><rect x=3D"604.0" y=3D"293" width=
=3D"4.9" height=3D"15.0" fill=3D"rgb(210,75,9)" rx=3D"2" ry=3D"2" />=0A<tex=
t  x=3D"606.98" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>___slab_alloc (=
128,689,130,198 samples, 1.60%)</title><rect x=3D"1001.0" y=3D"149" width=
=3D"18.9" height=3D"15.0" fill=3D"rgb(250,160,9)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"1003.98" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__audit_sysc=
all_entry (22,406,466,942 samples, 0.28%)</title><rect x=3D"610.9" y=3D"293=
" width=3D"3.3" height=3D"15.0" fill=3D"rgb(248,47,53)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"613.91" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>put_pid=
 (1,581,086,567 samples, 0.02%)</title><rect x=3D"735.9" y=3D"229" width=3D=
"0.2" height=3D"15.0" fill=3D"rgb(224,184,23)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"738.85" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>sock_wfree (194,=
533,689,027 samples, 2.42%)</title><rect x=3D"322.6" y=3D"181" width=3D"28.=
6" height=3D"15.0" fill=3D"rgb(225,54,28)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"325.60" y=3D"191.5" >so..</text>=0A</g>=0A<g >=0A<title>unix_destruct_s=
cm (944,619,323 samples, 0.01%)</title><rect x=3D"620.3" y=3D"341" width=3D=
"0.2" height=3D"15.0" fill=3D"rgb(223,137,15)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"623.33" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>native_sched_clo=
ck (1,736,123,610 samples, 0.02%)</title><rect x=3D"469.4" y=3D"149" width=
=3D"0.3" height=3D"15.0" fill=3D"rgb(228,140,32)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"472.43" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>dequeue_task_=
fair (50,680,702,063 samples, 0.63%)</title><rect x=3D"453.6" y=3D"181" wid=
th=3D"7.5" height=3D"15.0" fill=3D"rgb(242,189,5)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"456.64" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>load_balance=
 (1,458,389,774 samples, 0.02%)</title><rect x=3D"462.4" y=3D"149" width=3D=
"0.2" height=3D"15.0" fill=3D"rgb(249,144,9)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"465.37" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__unfreeze_partia=
ls (64,345,504,856 samples, 0.80%)</title><rect x=3D"156.2" y=3D"229" width=
=3D"9.5" height=3D"15.0" fill=3D"rgb(227,218,24)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"159.20" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>vfs_write (2,=
084,751,145 samples, 0.03%)</title><rect x=3D"1188.9" y=3D"325" width=3D"0.=
3" height=3D"15.0" fill=3D"rgb(207,154,5)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1191.91" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>bpf_lsm_socket_rec=
vmsg (12,803,797,626 samples, 0.16%)</title><rect x=3D"96.1" y=3D"229" widt=
h=3D"1.9" height=3D"15.0" fill=3D"rgb(237,219,7)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"99.11" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>check_preempti=
on_disabled (3,271,747,727 samples, 0.04%)</title><rect x=3D"830.7" y=3D"11=
7" width=3D"0.4" height=3D"15.0" fill=3D"rgb(239,152,34)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"833.66" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>avail=
able_idle_cpu (1,083,923,656 samples, 0.01%)</title><rect x=3D"1134.6" y=3D=
"133" width=3D"0.1" height=3D"15.0" fill=3D"rgb(251,35,47)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"1137.55" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__=
rcu_read_unlock (1,536,816,092 samples, 0.02%)</title><rect x=3D"966.8" y=
=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(250,131,54)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"969.80" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title=
>refill_obj_stock (11,936,127,983 samples, 0.15%)</title><rect x=3D"976.3" =
y=3D"133" width=3D"1.8" height=3D"15.0" fill=3D"rgb(254,54,16)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"979.31" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title=
>check_preemption_disabled (51,996,623,575 samples, 0.65%)</title><rect x=
=3D"244.3" y=3D"165" width=3D"7.6" height=3D"15.0" fill=3D"rgb(250,116,42)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"247.31" y=3D"175.5" ></text>=0A</g>=0A<=
g >=0A<title>native_queued_spin_lock_slowpath (1,906,362,015 samples, 0.02%=
)</title><rect x=3D"1114.9" y=3D"181" width=3D"0.3" height=3D"15.0" fill=3D=
"rgb(242,199,47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1117.88" y=3D"191.5" >=
</text>=0A</g>=0A<g >=0A<title>syscall_exit_to_user_mode_prepare (25,305,26=
7,281 samples, 0.31%)</title><rect x=3D"1167.6" y=3D"293" width=3D"3.8" hei=
ght=3D"15.0" fill=3D"rgb(250,172,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
70.64" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>check_stack_object (8,72=
6,848,937 samples, 0.11%)</title><rect x=3D"582.9" y=3D"149" width=3D"1.3" =
height=3D"15.0" fill=3D"rgb(213,74,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
585.88" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock_irqsave =
(2,479,420,102 samples, 0.03%)</title><rect x=3D"448.6" y=3D"213" width=3D"=
0.4" height=3D"15.0" fill=3D"rgb(205,40,19)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"451.64" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>debug_smp_processo=
r_id (1,043,467,383 samples, 0.01%)</title><rect x=3D"937.3" y=3D"117" widt=
h=3D"0.2" height=3D"15.0" fill=3D"rgb(233,23,12)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"940.34" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_un=
lock (5,292,787,751 samples, 0.07%)</title><rect x=3D"343.1" y=3D"165" widt=
h=3D"0.8" height=3D"15.0" fill=3D"rgb(230,166,12)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"346.11" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>psi_group_ch=
ange (13,325,115,801 samples, 0.17%)</title><rect x=3D"1135.6" y=3D"101" wi=
dth=3D"1.9" height=3D"15.0" fill=3D"rgb(216,75,34)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"1138.57" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>ksys_write=
 (3,463,371,165,270 samples, 43.10%)</title><rect x=3D"645.6" y=3D"309" wid=
th=3D"508.6" height=3D"15.0" fill=3D"rgb(245,213,14)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"648.55" y=3D"319.5" >ksys_write</text>=0A</g>=0A<g >=0A<titl=
e>refill_obj_stock (60,263,873,672 samples, 0.75%)</title><rect x=3D"435.9"=
 y=3D"213" width=3D"8.8" height=3D"15.0" fill=3D"rgb(223,84,40)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"438.85" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__ksize (29,640,232,024 samples, 0.37%)</title><rect x=3D"983.6" y=3D"181=
" width=3D"4.3" height=3D"15.0" fill=3D"rgb(244,65,17)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"986.57" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>entry_S=
YSCALL_64_after_hwframe (3,351,953,934 samples, 0.04%)</title><rect x=3D"11=
88.9" y=3D"373" width=3D"0.5" height=3D"15.0" fill=3D"rgb(216,58,17)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1191.91" y=3D"383.5" ></text>=0A</g>=0A<g >=
=0A<title>pick_next_task_fair (4,216,114,822 samples, 0.05%)</title><rect x=
=3D"1166.8" y=3D"245" width=3D"0.6" height=3D"15.0" fill=3D"rgb(231,194,36)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1169.82" y=3D"255.5" ></text>=0A</g>=
=0A<g >=0A<title>update_curr (7,526,295,840 samples, 0.09%)</title><rect x=
=3D"454.9" y=3D"149" width=3D"1.1" height=3D"15.0" fill=3D"rgb(243,22,21)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"457.93" y=3D"159.5" ></text>=0A</g>=0A<g=
 >=0A<title>rb_erase (907,149,319 samples, 0.01%)</title><rect x=3D"1117.8"=
 y=3D"133" width=3D"0.1" height=3D"15.0" fill=3D"rgb(252,23,35)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"1120.76" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<tit=
le>ktime_get_coarse_real_ts64 (11,810,890,328 samples, 0.15%)</title><rect =
x=3D"1176.6" y=3D"293" width=3D"1.8" height=3D"15.0" fill=3D"rgb(210,110,2)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1179.65" y=3D"303.5" ></text>=0A</g>=
=0A<g >=0A<title>psi_account_irqtime (5,580,141,356 samples, 0.07%)</title>=
<rect x=3D"1147.9" y=3D"133" width=3D"0.8" height=3D"15.0" fill=3D"rgb(219,=
72,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1150.92" y=3D"143.5" ></text>=0A=
</g>=0A<g >=0A<title>task_h_load (817,601,083 samples, 0.01%)</title><rect =
x=3D"1134.9" y=3D"133" width=3D"0.1" height=3D"15.0" fill=3D"rgb(234,45,46)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1137.91" y=3D"143.5" ></text>=0A</g>=
=0A<g >=0A<title>syscall_return_via_sysret (15,675,257,889 samples, 0.20%)<=
/title><rect x=3D"618.0" y=3D"341" width=3D"2.3" height=3D"15.0" fill=3D"rg=
b(217,86,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"621.03" y=3D"351.5" ></text=
>=0A</g>=0A<g >=0A<title>copy_user_enhanced_fast_string (328,770,603,546 sa=
mples, 4.09%)</title><rect x=3D"495.0" y=3D"165" width=3D"48.2" height=3D"1=
5.0" fill=3D"rgb(215,203,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"497.95" y=
=3D"175.5" >copy..</text>=0A</g>=0A<g >=0A<title>__put_user_nocheck_8 (1,61=
9,249,133 samples, 0.02%)</title><rect x=3D"599.3" y=3D"261" width=3D"0.2" =
height=3D"15.0" fill=3D"rgb(211,60,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
602.26" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>ksys_write (2,084,751,1=
45 samples, 0.03%)</title><rect x=3D"1188.9" y=3D"341" width=3D"0.3" height=
=3D"15.0" fill=3D"rgb(248,160,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.=
91" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>ttwu_do_wakeup (10,804,716,=
899 samples, 0.13%)</title><rect x=3D"1145.8" y=3D"149" width=3D"1.6" heigh=
t=3D"15.0" fill=3D"rgb(214,42,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1148.=
78" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>psi_task_switch (862,347,06=
4 samples, 0.01%)</title><rect x=3D"603.7" y=3D"245" width=3D"0.1" height=
=3D"15.0" fill=3D"rgb(247,8,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"606.69"=
 y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_read_generic (9,38=
1,663,380 samples, 0.12%)</title><rect x=3D"1185.7" y=3D"277" width=3D"1.3"=
 height=3D"15.0" fill=3D"rgb(245,139,11)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1188.66" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (1=
7,800,317,655 samples, 0.22%)</title><rect x=3D"1046.0" y=3D"149" width=3D"=
2.6" height=3D"15.0" fill=3D"rgb(214,116,45)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1049.01" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__audit_syscall_=
exit (11,173,465,263 samples, 0.14%)</title><rect x=3D"1168.8" y=3D"277" wi=
dth=3D"1.6" height=3D"15.0" fill=3D"rgb(237,174,9)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"1171.80" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>__x86_indi=
rect_thunk_array (9,720,744,475 samples, 0.12%)</title><rect x=3D"26.6" y=
=3D"341" width=3D"1.4" height=3D"15.0" fill=3D"rgb(221,134,36)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"29.62" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>=
update_curr (1,318,405,797 samples, 0.02%)</title><rect x=3D"1116.1" y=3D"1=
33" width=3D"0.2" height=3D"15.0" fill=3D"rgb(243,35,39)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1119.12" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>sysc=
all_trace_enter.constprop.0 (47,850,754,705 samples, 0.60%)</title><rect x=
=3D"1171.4" y=3D"309" width=3D"7.0" height=3D"15.0" fill=3D"rgb(238,108,27)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1174.36" y=3D"319.5" ></text>=0A</g>=
=0A<g >=0A<title>switch_mm_irqs_off (1,221,655,193 samples, 0.02%)</title><=
rect x=3D"1189.2" y=3D"277" width=3D"0.2" height=3D"15.0" fill=3D"rgb(212,1=
98,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.22" y=3D"287.5" ></text>=0A=
</g>=0A<g >=0A<title>schedule_timeout (2,084,751,145 samples, 0.03%)</title=
><rect x=3D"1188.9" y=3D"245" width=3D"0.3" height=3D"15.0" fill=3D"rgb(247=
,190,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.91" y=3D"255.5" ></text>=
=0A</g>=0A<g >=0A<title>update_rq_clock (1,580,128,169 samples, 0.02%)</tit=
le><rect x=3D"1118.9" y=3D"165" width=3D"0.2" height=3D"15.0" fill=3D"rgb(2=
14,208,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1121.88" y=3D"175.5" ></text>=
=0A</g>=0A<g >=0A<title>read (4,081,989,919,275 samples, 50.80%)</title><re=
ct x=3D"21.2" y=3D"357" width=3D"599.4" height=3D"15.0" fill=3D"rgb(241,38,=
47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"24.16" y=3D"367.5" >read</text>=0A<=
/g>=0A<g >=0A<title>write (3,830,859,582,418 samples, 47.68%)</title><rect =
x=3D"620.6" y=3D"357" width=3D"562.6" height=3D"15.0" fill=3D"rgb(231,188,1=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"623.62" y=3D"367.5" >write</text>=0A<=
/g>=0A<g >=0A<title>unix_stream_sendmsg (1,371,350,829 samples, 0.02%)</tit=
le><rect x=3D"1183.0" y=3D"341" width=3D"0.2" height=3D"15.0" fill=3D"rgb(2=
33,40,47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1186.00" y=3D"351.5" ></text>=
=0A</g>=0A<g >=0A<title>__slab_free (189,271,608,862 samples, 2.36%)</title=
><rect x=3D"270.9" y=3D"197" width=3D"27.8" height=3D"15.0" fill=3D"rgb(242=
,144,35)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"273.90" y=3D"207.5" >_..</text=
>=0A</g>=0A<g >=0A<title>preempt_count_sub (733,139,573 samples, 0.01%)</ti=
tle><rect x=3D"1133.4" y=3D"149" width=3D"0.1" height=3D"15.0" fill=3D"rgb(=
235,145,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1136.41" y=3D"159.5" ></tex=
t>=0A</g>=0A<g >=0A<title>preempt_count_sub (777,389,842 samples, 0.01%)</t=
itle><rect x=3D"469.7" y=3D"197" width=3D"0.2" height=3D"15.0" fill=3D"rgb(=
241,156,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"472.74" y=3D"207.5" ></text=
>=0A</g>=0A<g >=0A<title>check_preemption_disabled (1,959,644,276 samples, =
0.02%)</title><rect x=3D"434.8" y=3D"149" width=3D"0.3" height=3D"15.0" fil=
l=3D"rgb(213,69,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"437.82" y=3D"159.5"=
 ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock (1,502,610,966 samples, 0.0=
2%)</title><rect x=3D"602.6" y=3D"245" width=3D"0.3" height=3D"15.0" fill=
=3D"rgb(230,115,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"605.64" y=3D"255.5"=
 ></text>=0A</g>=0A<g >=0A<title>refill_stock (5,088,783,124 samples, 0.06%=
)</title><rect x=3D"435.1" y=3D"197" width=3D"0.8" height=3D"15.0" fill=3D"=
rgb(251,14,47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"438.11" y=3D"207.5" ></t=
ext>=0A</g>=0A<g >=0A<title>consume_skb (1,193,548,515,408 samples, 14.85%)=
</title><rect x=3D"175.9" y=3D"229" width=3D"175.3" height=3D"15.0" fill=3D=
"rgb(230,171,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"178.89" y=3D"239.5" >c=
onsume_skb</text>=0A</g>=0A<g >=0A<title>syscall_exit_to_user_mode (106,769=
,642,581 samples, 1.33%)</title><rect x=3D"1155.7" y=3D"309" width=3D"15.7"=
 height=3D"15.0" fill=3D"rgb(231,196,40)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1158.68" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>preempt_count_add =
(1,995,588,449 samples, 0.02%)</title><rect x=3D"844.2" y=3D"133" width=3D"=
0.3" height=3D"15.0" fill=3D"rgb(226,106,9)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"847.19" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_d=
isabled (3,692,333,905 samples, 0.05%)</title><rect x=3D"257.6" y=3D"117" w=
idth=3D"0.5" height=3D"15.0" fill=3D"rgb(232,227,37)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"260.58" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>preempt_=
count_sub (3,416,434,669 samples, 0.04%)</title><rect x=3D"175.3" y=3D"213"=
 width=3D"0.5" height=3D"15.0" fill=3D"rgb(210,191,18)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"178.32" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>ktime_g=
et_coarse_real_ts64 (13,012,550,755 samples, 0.16%)</title><rect x=3D"614.2=
" y=3D"293" width=3D"1.9" height=3D"15.0" fill=3D"rgb(243,57,39)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"617.20" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<tit=
le>__schedule (1,182,763,706 samples, 0.01%)</title><rect x=3D"1187.0" y=3D=
"293" width=3D"0.2" height=3D"15.0" fill=3D"rgb(237,96,48)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"1190.04" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>km=
em_cache_alloc_node (852,613,963,376 samples, 10.61%)</title><rect x=3D"987=
=2E9" y=3D"181" width=3D"125.3" height=3D"15.0" fill=3D"rgb(226,161,52)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"990.95" y=3D"191.5" >kmem_cache_allo..</te=
xt>=0A</g>=0A<g >=0A<title>check_preemption_disabled (3,492,520,846 samples=
, 0.04%)</title><rect x=3D"1006.8" y=3D"133" width=3D"0.5" height=3D"15.0" =
fill=3D"rgb(207,130,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1009.80" y=3D"14=
3.5" ></text>=0A</g>=0A<g >=0A<title>dequeue_entity (2,819,498,790 samples,=
 0.04%)</title><rect x=3D"1116.0" y=3D"149" width=3D"0.4" height=3D"15.0" f=
ill=3D"rgb(214,82,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1119.02" y=3D"159=
=2E5" ></text>=0A</g>=0A<g >=0A<title>is_vmalloc_addr (6,945,642,053 sample=
s, 0.09%)</title><rect x=3D"584.2" y=3D"149" width=3D"1.0" height=3D"15.0" =
fill=3D"rgb(248,112,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"587.16" y=3D"15=
9.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (6,050,230,520 samples=
, 0.08%)</title><rect x=3D"387.7" y=3D"213" width=3D"0.9" height=3D"15.0" f=
ill=3D"rgb(231,119,50)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"390.69" y=3D"223=
=2E5" ></text>=0A</g>=0A<g >=0A<title>pick_next_entity (908,639,693 samples=
, 0.01%)</title><rect x=3D"1117.5" y=3D"149" width=3D"0.2" height=3D"15.0" =
fill=3D"rgb(234,88,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1120.55" y=3D"15=
9.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (2,365,193,4=
36 samples, 0.03%)</title><rect x=3D"1112.5" y=3D"133" width=3D"0.3" height=
=3D"15.0" fill=3D"rgb(205,94,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1115.4=
8" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>cgroup_rstat_updated (2,950,=
947,923 samples, 0.04%)</title><rect x=3D"938.4" y=3D"85" width=3D"0.4" hei=
ght=3D"15.0" fill=3D"rgb(219,100,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"941=
=2E35" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>bpf_lsm_file_permission (=
10,442,875,885 samples, 0.13%)</title><rect x=3D"75.2" y=3D"261" width=3D"1=
=2E5" height=3D"15.0" fill=3D"rgb(235,167,25)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"78.18" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock=
 (1,544,744,277 samples, 0.02%)</title><rect x=3D"850.8" y=3D"117" width=3D=
"0.3" height=3D"15.0" fill=3D"rgb(229,180,13)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"853.83" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>mod_objcg_state =
(154,408,776,071 samples, 1.92%)</title><rect x=3D"916.6" y=3D"133" width=
=3D"22.7" height=3D"15.0" fill=3D"rgb(225,2,48)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"919.63" y=3D"143.5" >m..</text>=0A</g>=0A<g >=0A<title>__schedule =
(9,337,210,204 samples, 0.12%)</title><rect x=3D"1185.7" y=3D"229" width=3D=
"1.3" height=3D"15.0" fill=3D"rgb(253,27,19)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1188.67" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>finish_task_swit=
ch.isra.0 (3,275,807,512 samples, 0.04%)</title><rect x=3D"461.1" y=3D"181"=
 width=3D"0.5" height=3D"15.0" fill=3D"rgb(220,59,1)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"464.09" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__alloc_=
skb (2,191,650,448,727 samples, 27.28%)</title><rect x=3D"792.9" y=3D"197" =
width=3D"321.9" height=3D"15.0" fill=3D"rgb(254,99,52)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"795.93" y=3D"207.5" >__alloc_skb</text>=0A</g>=0A<g >=0A<ti=
tle>entry_SYSCALL_64_safe_stack (7,060,222,505 samples, 0.09%)</title><rect=
 x=3D"616.1" y=3D"341" width=3D"1.0" height=3D"15.0" fill=3D"rgb(210,62,9)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"619.11" y=3D"351.5" ></text>=0A</g>=0A<=
g >=0A<title>entry_SYSCALL_64_after_hwframe (3,938,695,573,447 samples, 49.=
02%)</title><rect x=3D"37.7" y=3D"341" width=3D"578.4" height=3D"15.0" fill=
=3D"rgb(242,97,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"40.69" y=3D"351.5" >=
entry_SYSCALL_64_after_hwframe</text>=0A</g>=0A<g >=0A<title>skb_queue_tail=
 (51,037,870,530 samples, 0.64%)</title><rect x=3D"779.8" y=3D"229" width=
=3D"7.5" height=3D"15.0" fill=3D"rgb(245,80,1)" rx=3D"2" ry=3D"2" />=0A<tex=
t  x=3D"782.82" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>[hackbench] (75=
,848,995,062 samples, 0.94%)</title><rect x=3D"10.0" y=3D"357" width=3D"11.=
2" height=3D"15.0" fill=3D"rgb(215,4,14)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"13.01" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>security_socket_getp=
eersec_dgram (32,430,791,106 samples, 0.40%)</title><rect x=3D"736.1" y=3D"=
229" width=3D"4.7" height=3D"15.0" fill=3D"rgb(243,210,52)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"739.08" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>upd=
ate_min_vruntime (862,751,036 samples, 0.01%)</title><rect x=3D"1141.4" y=
=3D"85" width=3D"0.1" height=3D"15.0" fill=3D"rgb(243,96,43)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1144.42" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title=
>update_min_vruntime (1,223,748,767 samples, 0.02%)</title><rect x=3D"455.9=
" y=3D"133" width=3D"0.1" height=3D"15.0" fill=3D"rgb(222,3,33)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"458.86" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<titl=
e>vfs_read (9,381,663,380 samples, 0.12%)</title><rect x=3D"1185.7" y=3D"32=
5" width=3D"1.3" height=3D"15.0" fill=3D"rgb(253,229,36)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1188.66" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>psi_=
group_change (15,505,409,695 samples, 0.19%)</title><rect x=3D"465.2" y=3D"=
165" width=3D"2.3" height=3D"15.0" fill=3D"rgb(211,197,38)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"468.22" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__u=
pdate_load_avg_cfs_rq (722,041,719 samples, 0.01%)</title><rect x=3D"464.2"=
 y=3D"133" width=3D"0.1" height=3D"15.0" fill=3D"rgb(251,104,40)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"467.22" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<tit=
le>__update_load_avg_se (1,226,735,025 samples, 0.02%)</title><rect x=3D"45=
6.5" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(238,113,28)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"459.54" y=3D"143.5" ></text>=0A</g>=0A<g >=0A=
<title>__fdget_pos (40,018,675,457 samples, 0.50%)</title><rect x=3D"46.7" =
y=3D"293" width=3D"5.9" height=3D"15.0" fill=3D"rgb(209,224,5)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"49.70" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>=
__kmem_cache_alloc_node (1,160,523,568,444 samples, 14.44%)</title><rect x=
=3D"810.3" y=3D"165" width=3D"170.4" height=3D"15.0" fill=3D"rgb(239,124,19=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"813.29" y=3D"175.5" >__kmem_cache_all=
oc_node</text>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (775=
,353,305 samples, 0.01%)</title><rect x=3D"1166.7" y=3D"229" width=3D"0.1" =
height=3D"15.0" fill=3D"rgb(253,208,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"1169.67" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>try_charge_memcg (16,=
693,933,457 samples, 0.21%)</title><rect x=3D"978.1" y=3D"133" width=3D"2.4=
" height=3D"15.0" fill=3D"rgb(243,44,34)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"981.07" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>unix_destruct_scm (=
238,997,790,062 samples, 2.97%)</title><rect x=3D"316.1" y=3D"197" width=3D=
"35.1" height=3D"15.0" fill=3D"rgb(248,198,4)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"319.07" y=3D"207.5" >un..</text>=0A</g>=0A<g >=0A<title>psi_flags_ch=
ange (1,046,104,171 samples, 0.01%)</title><rect x=3D"465.1" y=3D"165" widt=
h=3D"0.1" height=3D"15.0" fill=3D"rgb(221,41,19)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"468.07" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>exit_to_user_=
mode_prepare (1,267,202,789 samples, 0.02%)</title><rect x=3D"1189.2" y=3D"=
325" width=3D"0.2" height=3D"15.0" fill=3D"rgb(230,163,5)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"1192.22" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>skb=
_free_head (3,775,544,380 samples, 0.05%)</title><rect x=3D"312.4" y=3D"197=
" width=3D"0.6" height=3D"15.0" fill=3D"rgb(253,90,39)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"315.40" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>prepare=
_to_wait (2,633,684,420 samples, 0.03%)</title><rect x=3D"1114.8" y=3D"213"=
 width=3D"0.4" height=3D"15.0" fill=3D"rgb(209,16,30)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1117.79" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>schedul=
e (10,861,670,265 samples, 0.14%)</title><rect x=3D"602.4" y=3D"277" width=
=3D"1.6" height=3D"15.0" fill=3D"rgb(239,115,19)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"605.38" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>finish_wait (=
1,947,592,399 samples, 0.02%)</title><rect x=3D"351.2" y=3D"229" width=3D"0=
=2E3" height=3D"15.0" fill=3D"rgb(251,32,2)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"354.17" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>refill_obj_stock (=
5,179,173,346 samples, 0.06%)</title><rect x=3D"1111.1" y=3D"149" width=3D"=
0.8" height=3D"15.0" fill=3D"rgb(241,105,26)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1114.15" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>psi_account_irqt=
ime (776,430,758 samples, 0.01%)</title><rect x=3D"351.0" y=3D"69" width=3D=
"0.1" height=3D"15.0" fill=3D"rgb(236,0,48)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"354.00" y=3D"79.5" ></text>=0A</g>=0A<g >=0A<title>dequeue_task_fair (=
9,643,687,523 samples, 0.12%)</title><rect x=3D"1115.9" y=3D"165" width=3D"=
1.4" height=3D"15.0" fill=3D"rgb(234,59,47)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"1118.89" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__kmem_cache_free=
 (520,895,086,388 samples, 6.48%)</title><rect x=3D"194.4" y=3D"197" width=
=3D"76.5" height=3D"15.0" fill=3D"rgb(211,106,25)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"197.41" y=3D"207.5" >__kmem_c..</text>=0A</g>=0A<g >=0A<title>pr=
eempt_count_sub (7,046,187,843 samples, 0.09%)</title><rect x=3D"172.9" y=
=3D"213" width=3D"1.0" height=3D"15.0" fill=3D"rgb(231,100,53)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"175.86" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title=
>__calc_delta (1,994,614,162 samples, 0.02%)</title><rect x=3D"457.3" y=3D"=
133" width=3D"0.3" height=3D"15.0" fill=3D"rgb(221,38,1)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"460.28" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__sch=
edule (10,416,036,137 samples, 0.13%)</title><rect x=3D"602.4" y=3D"261" wi=
dth=3D"1.5" height=3D"15.0" fill=3D"rgb(244,60,2)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"605.42" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>save_fpregs_=
to_fpstate (5,868,293,363 samples, 0.07%)</title><rect x=3D"1187.3" y=3D"37=
3" width=3D"0.9" height=3D"15.0" fill=3D"rgb(209,196,21)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1190.29" y=3D"383.5" ></text>=0A</g>=0A<g >=0A<title>__au=
dit_syscall_exit (15,010,317,759 samples, 0.19%)</title><rect x=3D"606.0" y=
=3D"277" width=3D"2.2" height=3D"15.0" fill=3D"rgb(251,221,46)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"608.95" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title=
>sched_clock_cpu (1,185,703,970 samples, 0.01%)</title><rect x=3D"1148.6" y=
=3D"117" width=3D"0.1" height=3D"15.0" fill=3D"rgb(237,155,11)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1151.56" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<titl=
e>read (33,304,180,258 samples, 0.41%)</title><rect x=3D"1183.3" y=3D"389" =
width=3D"4.9" height=3D"15.0" fill=3D"rgb(218,180,31)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1186.26" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>schedul=
e (1,182,763,706 samples, 0.01%)</title><rect x=3D"1187.0" y=3D"309" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(207,157,3)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1190.04" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>prepare_to_wa=
it (4,885,732,148 samples, 0.06%)</title><rect x=3D"448.3" y=3D"229" width=
=3D"0.7" height=3D"15.0" fill=3D"rgb(232,111,46)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"451.29" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>syscall_exit_=
to_user_mode (1,182,763,706 samples, 0.01%)</title><rect x=3D"1187.0" y=3D"=
341" width=3D"0.2" height=3D"15.0" fill=3D"rgb(247,204,6)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"1190.04" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>che=
ck_preemption_disabled (1,765,017,031 samples, 0.02%)</title><rect x=3D"111=
0.9" y=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(206,14,46)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"1113.88" y=3D"111.5" ></text>=0A</g>=0A<g >=0A=
<title>set_next_entity (2,449,215,471 samples, 0.03%)</title><rect x=3D"111=
7.7" y=3D"149" width=3D"0.4" height=3D"15.0" fill=3D"rgb(244,153,41)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1120.72" y=3D"159.5" ></text>=0A</g>=0A<g >=
=0A<title>__update_load_avg_se (3,949,002,173 samples, 0.05%)</title><rect =
x=3D"1145.2" y=3D"101" width=3D"0.6" height=3D"15.0" fill=3D"rgb(211,208,42=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1148.18" y=3D"111.5" ></text>=0A</g>=
=0A<g >=0A<title>update_cfs_group (1,133,751,031 samples, 0.01%)</title><re=
ct x=3D"1116.8" y=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(229,199=
,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1119.83" y=3D"159.5" ></text>=0A</=
g>=0A<g >=0A<title>__rcu_read_unlock (4,809,956,424 samples, 0.06%)</title>=
<rect x=3D"822.7" y=3D"149" width=3D"0.7" height=3D"15.0" fill=3D"rgb(233,9=
5,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"825.68" y=3D"159.5" ></text>=0A</=
g>=0A<g >=0A<title>__rcu_read_lock (158,120,530,827 samples, 1.97%)</title>=
<rect x=3D"885.8" y=3D"133" width=3D"23.2" height=3D"15.0" fill=3D"rgb(254,=
182,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"888.78" y=3D"143.5" >_..</text>=
=0A</g>=0A<g >=0A<title>check_preemption_disabled (1,590,193,308 samples, 0=
=2E02%)</title><rect x=3D"599.9" y=3D"261" width=3D"0.2" height=3D"15.0" fi=
ll=3D"rgb(236,103,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"602.91" y=3D"271.=
5" ></text>=0A</g>=0A<g >=0A<title>__bitmap_and (1,270,857,665 samples, 0.0=
2%)</title><rect x=3D"1134.3" y=3D"133" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(242,129,26)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1137.34" y=3D"143.5=
" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (1,810,789,231 =
samples, 0.02%)</title><rect x=3D"312.1" y=3D"181" width=3D"0.3" height=3D"=
15.0" fill=3D"rgb(208,26,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"315.12" y=
=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock_irqsave (44,084,4=
93,013 samples, 0.55%)</title><rect x=3D"159.2" y=3D"213" width=3D"6.4" hei=
ght=3D"15.0" fill=3D"rgb(209,6,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"162.=
15" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>schedule (9,337,210,204 sam=
ples, 0.12%)</title><rect x=3D"1185.7" y=3D"245" width=3D"1.3" height=3D"15=
=2E0" fill=3D"rgb(208,129,0)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.67" y=
=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>__x86_indirect_thunk_array (5,62=
9,947,038 samples, 0.07%)</title><rect x=3D"627.6" y=3D"341" width=3D"0.9" =
height=3D"15.0" fill=3D"rgb(250,139,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"630.64" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (724=
,268,679 samples, 0.01%)</title><rect x=3D"255.8" y=3D"165" width=3D"0.1" h=
eight=3D"15.0" fill=3D"rgb(227,181,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
258.82" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__update_load_avg_se (1=
,685,354,941 samples, 0.02%)</title><rect x=3D"464.3" y=3D"133" width=3D"0.=
3" height=3D"15.0" fill=3D"rgb(208,229,44)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"467.32" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>select_task_rq_fair=
 (1,768,616,030 samples, 0.02%)</title><rect x=3D"348.6" y=3D"85" width=3D"=
0.2" height=3D"15.0" fill=3D"rgb(224,177,20)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"351.55" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>skb_release_data (=
865,374,783,418 samples, 10.77%)</title><rect x=3D"185.9" y=3D"213" width=
=3D"127.1" height=3D"15.0" fill=3D"rgb(250,189,26)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"188.87" y=3D"223.5" >skb_release_data</text>=0A</g>=0A<g >=0A<t=
itle>try_to_wake_up (132,920,369,169 samples, 1.65%)</title><rect x=3D"1129=
=2E5" y=3D"165" width=3D"19.5" height=3D"15.0" fill=3D"rgb(205,149,27)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1132.48" y=3D"175.5" ></text>=0A</g>=0A<g =
>=0A<title>cgroup_rstat_updated (1,302,799,412 samples, 0.02%)</title><rect=
 x=3D"434.6" y=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(237,224,37=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"437.63" y=3D"159.5" ></text>=0A</g>=
=0A<g >=0A<title>alloc_skb_with_frags (2,208,306,564,197 samples, 27.48%)</=
title><rect x=3D"790.5" y=3D"213" width=3D"324.3" height=3D"15.0" fill=3D"r=
gb(228,79,10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"793.48" y=3D"223.5" >allo=
c_skb_with_frags</text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (821,912,577=
 samples, 0.01%)</title><rect x=3D"1103.2" y=3D"149" width=3D"0.1" height=
=3D"15.0" fill=3D"rgb(218,51,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1106.18=
" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (3,=
442,148,011 samples, 0.04%)</title><rect x=3D"253.3" y=3D"133" width=3D"0.5=
" height=3D"15.0" fill=3D"rgb(231,90,22)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"256.27" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>preempt_count_sub (=
3,495,386,965 samples, 0.04%)</title><rect x=3D"731.6" y=3D"213" width=3D"0=
=2E5" height=3D"15.0" fill=3D"rgb(205,79,31)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"734.62" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>sock_write_iter (=
3,228,082,928,473 samples, 40.17%)</title><rect x=3D"680.1" y=3D"277" width=
=3D"474.1" height=3D"15.0" fill=3D"rgb(214,75,9)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"683.11" y=3D"287.5" >sock_write_iter</text>=0A</g>=0A<g >=0A<titl=
e>get_obj_cgroup_from_current (59,838,664,328 samples, 0.74%)</title><rect =
x=3D"1020.3" y=3D"165" width=3D"8.8" height=3D"15.0" fill=3D"rgb(253,176,34=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1023.35" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>dequeue_entity (16,103,066,953 samples, 0.20%)</title><rec=
t x=3D"454.4" y=3D"165" width=3D"2.4" height=3D"15.0" fill=3D"rgb(251,39,54=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"457.39" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>schedule (130,567,596,139 samples, 1.62%)</title><rect x=
=3D"450.7" y=3D"213" width=3D"19.2" height=3D"15.0" fill=3D"rgb(233,99,40)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"453.68" y=3D"223.5" ></text>=0A</g>=0A<=
g >=0A<title>__mod_memcg_state (5,160,899,306 samples, 0.06%)</title><rect =
x=3D"434.3" y=3D"165" width=3D"0.8" height=3D"15.0" fill=3D"rgb(250,93,26)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"437.35" y=3D"175.5" ></text>=0A</g>=0A<=
g >=0A<title>put_cpu_partial (2,316,000,923 samples, 0.03%)</title><rect x=
=3D"1019.5" y=3D"117" width=3D"0.4" height=3D"15.0" fill=3D"rgb(213,169,47)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1022.54" y=3D"127.5" ></text>=0A</g>=
=0A<g >=0A<title>_copy_to_iter (342,439,860,310 samples, 4.26%)</title><rec=
t x=3D"492.9" y=3D"181" width=3D"50.3" height=3D"15.0" fill=3D"rgb(210,59,1=
5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"495.95" y=3D"191.5" >_copy..</text>=
=0A</g>=0A<g >=0A<title>psi_task_switch (4,236,867,409 samples, 0.05%)</tit=
le><rect x=3D"1118.1" y=3D"165" width=3D"0.6" height=3D"15.0" fill=3D"rgb(2=
21,47,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1121.12" y=3D"175.5" ></text>=
=0A</g>=0A<g >=0A<title>update_rq_clock (1,413,272,540 samples, 0.02%)</tit=
le><rect x=3D"351.0" y=3D"85" width=3D"0.2" height=3D"15.0" fill=3D"rgb(254=
,162,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"353.95" y=3D"95.5" ></text>=0A=
</g>=0A<g >=0A<title>reweight_entity (8,580,962,070 samples, 0.11%)</title>=
<rect x=3D"1142.0" y=3D"117" width=3D"1.3" height=3D"15.0" fill=3D"rgb(211,=
166,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1145.02" y=3D"127.5" ></text>=
=0A</g>=0A<g >=0A<title>kfree (15,807,796,780 samples, 0.20%)</title><rect =
x=3D"308.9" y=3D"197" width=3D"2.3" height=3D"15.0" fill=3D"rgb(222,149,46)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"311.90" y=3D"207.5" ></text>=0A</g>=0A=
<g >=0A<title>__list_add_valid (4,684,395,869 samples, 0.06%)</title><rect =
x=3D"158.5" y=3D"213" width=3D"0.7" height=3D"15.0" fill=3D"rgb(238,136,51)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"161.46" y=3D"223.5" ></text>=0A</g>=0A=
<g >=0A<title>entry_SYSCALL_64_after_hwframe (3,683,604,316,037 samples, 45=
=2E84%)</title><rect x=3D"637.4" y=3D"341" width=3D"541.0" height=3D"15.0" =
fill=3D"rgb(246,10,35)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"640.43" y=3D"351=
=2E5" >entry_SYSCALL_64_after_hwframe</text>=0A</g>=0A<g >=0A<title>__refil=
l_stock (4,192,857,599 samples, 0.05%)</title><rect x=3D"258.6" y=3D"149" w=
idth=3D"0.6" height=3D"15.0" fill=3D"rgb(214,89,29)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"261.60" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__x86_in=
direct_thunk_array (4,757,201,443 samples, 0.06%)</title><rect x=3D"1179.8"=
 y=3D"325" width=3D"0.7" height=3D"15.0" fill=3D"rgb(234,125,10)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"1182.78" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>native_queued_spin_lock_slowpath (37,475,467,137 samples, 0.47%)</title=
><rect x=3D"160.1" y=3D"197" width=3D"5.5" height=3D"15.0" fill=3D"rgb(247,=
63,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"163.09" y=3D"207.5" ></text>=0A<=
/g>=0A<g >=0A<title>__get_user_8 (6,726,128,625 samples, 0.08%)</title><rec=
t x=3D"598.3" y=3D"261" width=3D"0.9" height=3D"15.0" fill=3D"rgb(213,27,34=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"601.26" y=3D"271.5" ></text>=0A</g>=
=0A<g >=0A<title>obj_cgroup_uncharge_pages (42,027,387,047 samples, 0.52%)<=
/title><rect x=3D"254.0" y=3D"181" width=3D"6.2" height=3D"15.0" fill=3D"rg=
b(243,167,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"256.99" y=3D"191.5" ></te=
xt>=0A</g>=0A<g >=0A<title>update_load_avg (3,234,608,053 samples, 0.04%)</=
title><rect x=3D"1141.5" y=3D"101" width=3D"0.5" height=3D"15.0" fill=3D"rg=
b(244,25,10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1144.55" y=3D"111.5" ></te=
xt>=0A</g>=0A<g >=0A<title>__rcu_read_lock (1,406,989,716 samples, 0.02%)</=
title><rect x=3D"929.0" y=3D"117" width=3D"0.2" height=3D"15.0" fill=3D"rgb=
(222,152,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"931.98" y=3D"127.5" ></tex=
t>=0A</g>=0A<g >=0A<title>put_prev_entity (1,497,961,418 samples, 0.02%)</t=
itle><rect x=3D"1167.1" y=3D"229" width=3D"0.2" height=3D"15.0" fill=3D"rgb=
(246,125,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1170.09" y=3D"239.5" ></te=
xt>=0A</g>=0A<g >=0A<title>put_pid (765,959,148 samples, 0.01%)</title><rec=
t x=3D"472.3" y=3D"213" width=3D"0.1" height=3D"15.0" fill=3D"rgb(234,105,8=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"475.29" y=3D"223.5" ></text>=0A</g>=
=0A<g >=0A<title>__virt_addr_valid (59,929,825,348 samples, 0.75%)</title><=
rect x=3D"574.0" y=3D"149" width=3D"8.8" height=3D"15.0" fill=3D"rgb(210,18=
6,42)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"577.02" y=3D"159.5" ></text>=0A</=
g>=0A<g >=0A<title>switch_mm_irqs_off (8,653,788,457 samples, 0.11%)</title=
><rect x=3D"1185.8" y=3D"213" width=3D"1.2" height=3D"15.0" fill=3D"rgb(244=
,119,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.77" y=3D"223.5" ></text>=
=0A</g>=0A<g >=0A<title>__rcu_read_lock (5,402,187,534 samples, 0.07%)</tit=
le><rect x=3D"230.2" y=3D"181" width=3D"0.8" height=3D"15.0" fill=3D"rgb(23=
7,216,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"233.18" y=3D"191.5" ></text>=
=0A</g>=0A<g >=0A<title>update_load_avg (10,490,156,147 samples, 0.13%)</ti=
tle><rect x=3D"459.5" y=3D"165" width=3D"1.6" height=3D"15.0" fill=3D"rgb(2=
18,32,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"462.54" y=3D"175.5" ></text>=
=0A</g>=0A<g >=0A<title>unix_passcred_enabled (11,254,641,975 samples, 0.14=
%)</title><rect x=3D"734.2" y=3D"213" width=3D"1.7" height=3D"15.0" fill=3D=
"rgb(229,98,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"737.20" y=3D"223.5" ></t=
ext>=0A</g>=0A<g >=0A<title>__schedule (2,084,751,145 samples, 0.03%)</titl=
e><rect x=3D"1188.9" y=3D"213" width=3D"0.3" height=3D"15.0" fill=3D"rgb(21=
0,165,49)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.91" y=3D"223.5" ></text>=
=0A</g>=0A<g >=0A<title>update_load_avg (956,547,723 samples, 0.01%)</title=
><rect x=3D"1117.9" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(206=
,84,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1120.94" y=3D"143.5" ></text>=
=0A</g>=0A<g >=0A<title>__skb_datagram_iter (652,092,580,339 samples, 8.12%=
)</title><rect x=3D"489.4" y=3D"197" width=3D"95.8" height=3D"15.0" fill=3D=
"rgb(232,160,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"492.42" y=3D"207.5" >_=
_skb_datag..</text>=0A</g>=0A<g >=0A<title>__cgroup_account_cputime (1,860,=
022,887 samples, 0.02%)</title><rect x=3D"1141.1" y=3D"85" width=3D"0.3" he=
ight=3D"15.0" fill=3D"rgb(213,186,35)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1=
144.10" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>cgroup_rstat_updated (2,=
130,704,587 samples, 0.03%)</title><rect x=3D"1089.2" y=3D"101" width=3D"0.=
3" height=3D"15.0" fill=3D"rgb(229,93,39)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1092.24" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgroup_uncharg=
e (956,644,392 samples, 0.01%)</title><rect x=3D"433.1" y=3D"213" width=3D"=
0.1" height=3D"15.0" fill=3D"rgb(207,178,2)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"436.08" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_lruvec=
_state (8,214,886,990 samples, 0.10%)</title><rect x=3D"431.9" y=3D"181" wi=
dth=3D"1.2" height=3D"15.0" fill=3D"rgb(239,25,34)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"434.87" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__slab_allo=
c.constprop.0 (144,058,262,371 samples, 1.79%)</title><rect x=3D"823.4" y=
=3D"149" width=3D"21.1" height=3D"15.0" fill=3D"rgb(237,183,33)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"826.38" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<titl=
e>unix_stream_recvmsg (3,317,523,455,341 samples, 41.29%)</title><rect x=3D=
"98.0" y=3D"261" width=3D"487.2" height=3D"15.0" fill=3D"rgb(207,224,22)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"100.99" y=3D"271.5" >unix_stream_recvmsg<=
/text>=0A</g>=0A<g >=0A<title>__refill_stock (1,412,670,780 samples, 0.02%)=
</title><rect x=3D"435.3" y=3D"181" width=3D"0.2" height=3D"15.0" fill=3D"r=
gb(241,86,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"438.28" y=3D"191.5" ></te=
xt>=0A</g>=0A<g >=0A<title>rw_verify_area (2,908,666,692 samples, 0.04%)</t=
itle><rect x=3D"72.1" y=3D"277" width=3D"0.5" height=3D"15.0" fill=3D"rgb(2=
23,204,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"75.14" y=3D"287.5" ></text>=
=0A</g>=0A<g >=0A<title>entry_SYSCALL_64_safe_stack (7,762,890,581 samples,=
 0.10%)</title><rect x=3D"1178.4" y=3D"341" width=3D"1.1" height=3D"15.0" f=
ill=3D"rgb(251,87,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1181.38" y=3D"351=
=2E5" ></text>=0A</g>=0A<g >=0A<title>put_cpu_partial (7,990,309,191 sample=
s, 0.10%)</title><rect x=3D"311.2" y=3D"197" width=3D"1.2" height=3D"15.0" =
fill=3D"rgb(235,228,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"314.22" y=3D"207=
=2E5" ></text>=0A</g>=0A<g >=0A<title>psi_task_change (4,213,739,829 sample=
s, 0.05%)</title><rect x=3D"348.9" y=3D"53" width=3D"0.6" height=3D"15.0" f=
ill=3D"rgb(210,7,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"351.89" y=3D"63.5"=
 ></text>=0A</g>=0A<g >=0A<title>sock_alloc_send_pskb (2,286,336,182,442 sa=
mples, 28.45%)</title><rect x=3D"787.3" y=3D"229" width=3D"335.8" height=3D=
"15.0" fill=3D"rgb(245,19,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"790.31" y=
=3D"239.5" >sock_alloc_send_pskb</text>=0A</g>=0A<g >=0A<title>default_send=
_IPI_single_phys (3,352,159,982 samples, 0.04%)</title><rect x=3D"1146.7" y=
=3D"101" width=3D"0.5" height=3D"15.0" fill=3D"rgb(228,128,51)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1149.66" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<titl=
e>mem_cgroup_handle_over_high (722,885,690 samples, 0.01%)</title><rect x=
=3D"602.3" y=3D"277" width=3D"0.1" height=3D"15.0" fill=3D"rgb(239,174,36)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"605.27" y=3D"287.5" ></text>=0A</g>=0A<=
g >=0A<title>get_partial_node (87,724,874,522 samples, 1.09%)</title><rect =
x=3D"831.2" y=3D"117" width=3D"12.9" height=3D"15.0" fill=3D"rgb(229,97,25)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"834.20" y=3D"127.5" ></text>=0A</g>=0A=
<g >=0A<title>__list_del_entry_valid (18,778,212,582 samples, 0.23%)</title=
><rect x=3D"1011.0" y=3D"117" width=3D"2.7" height=3D"15.0" fill=3D"rgb(231=
,110,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1013.97" y=3D"127.5" ></text>=
=0A</g>=0A<g >=0A<title>restore_fpregs_from_fpstate (14,397,588,225 samples=
, 0.18%)</title><rect x=3D"600.2" y=3D"261" width=3D"2.1" height=3D"15.0" f=
ill=3D"rgb(221,181,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"603.16" y=3D"271=
=2E5" ></text>=0A</g>=0A<g >=0A<title>___slab_alloc (138,397,098,733 sample=
s, 1.72%)</title><rect x=3D"823.8" y=3D"133" width=3D"20.3" height=3D"15.0"=
 fill=3D"rgb(213,191,32)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"826.76" y=3D"1=
43.5" ></text>=0A</g>=0A<g >=0A<title>sock_recvmsg (56,282,588,913 samples,=
 0.70%)</title><rect x=3D"89.7" y=3D"261" width=3D"8.3" height=3D"15.0" fil=
l=3D"rgb(223,86,44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"92.72" y=3D"271.5" =
></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (43,300,200,378 s=
amples, 0.54%)</title><rect x=3D"1103.4" y=3D"149" width=3D"6.4" height=3D"=
15.0" fill=3D"rgb(214,225,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1106.44" =
y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock_irqsave (2,316,9=
29,349 samples, 0.03%)</title><rect x=3D"1114.8" y=3D"197" width=3D"0.4" he=
ight=3D"15.0" fill=3D"rgb(222,181,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1=
117.84" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>sock_write_iter (4,757,=
201,443 samples, 0.06%)</title><rect x=3D"1179.8" y=3D"341" width=3D"0.7" h=
eight=3D"15.0" fill=3D"rgb(229,193,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
1182.78" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgroup_charge (128=
,545,714,789 samples, 1.60%)</title><rect x=3D"961.6" y=3D"149" width=3D"18=
=2E9" height=3D"15.0" fill=3D"rgb(217,226,37)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"964.64" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>rw_verify_area (=
1,818,154,066 samples, 0.02%)</title><rect x=3D"675.7" y=3D"277" width=3D"0=
=2E3" height=3D"15.0" fill=3D"rgb(244,152,27)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"678.69" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>sched_clock_cpu =
(1,362,807,789 samples, 0.02%)</title><rect x=3D"1137.5" y=3D"101" width=3D=
"0.2" height=3D"15.0" fill=3D"rgb(218,188,52)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1140.53" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>schedule (2,084=
,751,145 samples, 0.03%)</title><rect x=3D"1188.9" y=3D"229" width=3D"0.3" =
height=3D"15.0" fill=3D"rgb(218,170,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
1191.91" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgroup_charge (96,=
394,860,913 samples, 1.20%)</title><rect x=3D"1098.8" y=3D"165" width=3D"14=
=2E1" height=3D"15.0" fill=3D"rgb(218,198,37)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1101.75" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>ksys_read (9,38=
1,663,380 samples, 0.12%)</title><rect x=3D"1185.7" y=3D"341" width=3D"1.3"=
 height=3D"15.0" fill=3D"rgb(237,93,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"1188.66" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>debug_smp_processor_i=
d (1,051,544,834 samples, 0.01%)</title><rect x=3D"251.9" y=3D"165" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(214,25,16)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"254.95" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>debug_smp_proc=
essor_id (3,321,156,308 samples, 0.04%)</title><rect x=3D"973.7" y=3D"133" =
width=3D"0.5" height=3D"15.0" fill=3D"rgb(254,101,33)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"976.68" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>memcg_sl=
ab_post_alloc_hook (413,808,127,727 samples, 5.15%)</title><rect x=3D"1029.=
1" y=3D"165" width=3D"60.8" height=3D"15.0" fill=3D"rgb(220,99,45)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"1032.13" y=3D"175.5" >memcg_..</text>=0A</g>=0A=
<g >=0A<title>do_idle (1,573,727,053 samples, 0.02%)</title><rect x=3D"1189=
=2E7" y=3D"341" width=3D"0.2" height=3D"15.0" fill=3D"rgb(240,164,40)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1192.70" y=3D"351.5" ></text>=0A</g>=0A<g =
>=0A<title>mod_memcg_state (6,386,839,573 samples, 0.08%)</title><rect x=3D=
"434.2" y=3D"181" width=3D"0.9" height=3D"15.0" fill=3D"rgb(221,94,33)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"437.17" y=3D"191.5" ></text>=0A</g>=0A<g >=
=0A<title>syscall_exit_to_user_mode (150,777,110,986 samples, 1.88%)</title=
><rect x=3D"586.8" y=3D"309" width=3D"22.1" height=3D"15.0" fill=3D"rgb(210=
,101,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"589.79" y=3D"319.5" >s..</text>=
=0A</g>=0A<g >=0A<title>mod_objcg_state (132,926,227,202 samples, 1.65%)</t=
itle><rect x=3D"413.6" y=3D"213" width=3D"19.5" height=3D"15.0" fill=3D"rgb=
(209,122,50)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"416.56" y=3D"223.5" ></tex=
t>=0A</g>=0A<g >=0A<title>_raw_spin_lock_irqsave (9,497,996,404 samples, 0.=
12%)</title><rect x=3D"1149.0" y=3D"197" width=3D"1.4" height=3D"15.0" fill=
=3D"rgb(235,205,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1152.00" y=3D"207.5=
" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (3,003,810,576 =
samples, 0.04%)</title><rect x=3D"1111.4" y=3D"133" width=3D"0.5" height=3D=
"15.0" fill=3D"rgb(224,195,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1114.44"=
 y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__wake_up_common (21,051,263,6=
27 samples, 0.26%)</title><rect x=3D"348.1" y=3D"133" width=3D"3.1" height=
=3D"15.0" fill=3D"rgb(216,46,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"351.07"=
 y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>ttwu_do_activate (73,110,046,6=
25 samples, 0.91%)</title><rect x=3D"1135.0" y=3D"149" width=3D"10.8" heigh=
t=3D"15.0" fill=3D"rgb(216,112,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1138=
=2E04" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (998,6=
45,500 samples, 0.01%)</title><rect x=3D"1028.1" y=3D"133" width=3D"0.2" he=
ight=3D"15.0" fill=3D"rgb(212,62,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"103=
1.10" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>check_stack_object (9,367=
,002,576 samples, 0.12%)</title><rect x=3D"759.5" y=3D"197" width=3D"1.4" h=
eight=3D"15.0" fill=3D"rgb(244,143,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
762.51" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>sock_def_readable (189,=
164,641,644 samples, 2.35%)</title><rect x=3D"1123.1" y=3D"229" width=3D"27=
=2E8" height=3D"15.0" fill=3D"rgb(212,220,21)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1126.07" y=3D"239.5" >s..</text>=0A</g>=0A<g >=0A<title>wait_for_uni=
x_gc (22,562,809,470 samples, 0.28%)</title><rect x=3D"1150.9" y=3D"229" wi=
dth=3D"3.3" height=3D"15.0" fill=3D"rgb(252,219,54)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1153.85" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>kfence_=
ksize (3,366,994,318 samples, 0.04%)</title><rect x=3D"1114.3" y=3D"165" wi=
dth=3D"0.5" height=3D"15.0" fill=3D"rgb(211,223,3)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"1117.29" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>[unknown] =
(7,988,860,595,983 samples, 99.42%)</title><rect x=3D"10.0" y=3D"389" width=
=3D"1173.2" height=3D"15.0" fill=3D"rgb(210,169,29)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"13.01" y=3D"399.5" >[unknown]</text>=0A</g>=0A<g >=0A<title>=
check_preemption_disabled (45,277,941,876 samples, 0.56%)</title><rect x=3D=
"424.8" y=3D"197" width=3D"6.7" height=3D"15.0" fill=3D"rgb(225,199,37)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"427.80" y=3D"207.5" ></text>=0A</g>=0A<g >=
=0A<title>entry_SYSRETQ_unsafe_stack (1,450,607,218 samples, 0.02%)</title>=
<rect x=3D"617.1" y=3D"341" width=3D"0.3" height=3D"15.0" fill=3D"rgb(224,1=
57,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"620.14" y=3D"351.5" ></text>=0A<=
/g>=0A<g >=0A<title>rcu_note_context_switch (1,680,439,033 samples, 0.02%)<=
/title><rect x=3D"467.7" y=3D"181" width=3D"0.3" height=3D"15.0" fill=3D"rg=
b(209,148,5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"470.74" y=3D"191.5" ></tex=
t>=0A</g>=0A<g >=0A<title>_raw_spin_lock_irqsave (1,226,896,911 samples, 0.=
02%)</title><rect x=3D"351.3" y=3D"213" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(226,37,17)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"354.28" y=3D"223.5" =
></text>=0A</g>=0A<g >=0A<title>__switch_to (1,130,733,714 samples, 0.01%)<=
/title><rect x=3D"1188.2" y=3D"373" width=3D"0.2" height=3D"15.0" fill=3D"r=
gb(226,50,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.21" y=3D"383.5" ></t=
ext>=0A</g>=0A<g >=0A<title>pick_next_task_fair (21,407,321,946 samples, 0.=
27%)</title><rect x=3D"461.6" y=3D"181" width=3D"3.1" height=3D"15.0" fill=
=3D"rgb(213,169,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"464.57" y=3D"191.5"=
 ></text>=0A</g>=0A<g >=0A<title>should_failslab (1,353,046,142 samples, 0.=
02%)</title><rect x=3D"980.5" y=3D"149" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(249,182,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"983.52" y=3D"159.5" =
></text>=0A</g>=0A<g >=0A<title>__rdgsbase_inactive (1,855,209,674 samples,=
 0.02%)</title><rect x=3D"1183.3" y=3D"373" width=3D"0.2" height=3D"15.0" f=
ill=3D"rgb(222,193,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1186.26" y=3D"38=
3.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock_irqsave (37,328,439,012=
 samples, 0.46%)</title><rect x=3D"1013.7" y=3D"117" width=3D"5.5" height=
=3D"15.0" fill=3D"rgb(205,228,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1016.=
73" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (=
2,316,553,168 samples, 0.03%)</title><rect x=3D"1089.5" y=3D"101" width=3D"=
0.4" height=3D"15.0" fill=3D"rgb(244,222,53)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1092.55" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgroup_uncha=
rge (1,401,033,290 samples, 0.02%)</title><rect x=3D"253.8" y=3D"181" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(251,83,46)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"256.79" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_loc=
k (1,449,627,992 samples, 0.02%)</title><rect x=3D"1027.9" y=3D"133" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(226,116,15)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"1030.89" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>rb_erase (2,=
399,241,564 samples, 0.03%)</title><rect x=3D"463.6" y=3D"149" width=3D"0.3=
" height=3D"15.0" fill=3D"rgb(240,198,20)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"466.58" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>syscall_enter_from_=
user_mode (10,286,649,514 samples, 0.13%)</title><rect x=3D"1154.2" y=3D"30=
9" width=3D"1.5" height=3D"15.0" fill=3D"rgb(230,30,12)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"1157.17" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>refil=
l_obj_stock (73,101,864,485 samples, 0.91%)</title><rect x=3D"260.2" y=3D"1=
81" width=3D"10.7" height=3D"15.0" fill=3D"rgb(245,24,40)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"263.17" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>memc=
g_account_kmem (14,568,302,455 samples, 0.18%)</title><rect x=3D"974.2" y=
=3D"133" width=3D"2.1" height=3D"15.0" fill=3D"rgb(239,117,28)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"977.17" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title=
>update_rq_clock (9,434,953,901 samples, 0.12%)</title><rect x=3D"468.3" y=
=3D"181" width=3D"1.4" height=3D"15.0" fill=3D"rgb(205,42,22)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"471.31" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title=
>__rcu_read_unlock (6,779,037,100 samples, 0.08%)</title><rect x=3D"721.1" =
y=3D"229" width=3D"1.0" height=3D"15.0" fill=3D"rgb(227,100,48)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"724.10" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<titl=
e>start_secondary (2,065,092,133 samples, 0.03%)</title><rect x=3D"1189.7" =
y=3D"373" width=3D"0.3" height=3D"15.0" fill=3D"rgb(237,210,31)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"1192.70" y=3D"383.5" ></text>=0A</g>=0A<g >=0A<tit=
le>exit_to_user_mode_prepare (1,182,763,706 samples, 0.01%)</title><rect x=
=3D"1187.0" y=3D"325" width=3D"0.2" height=3D"15.0" fill=3D"rgb(247,52,25)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"1190.04" y=3D"335.5" ></text>=0A</g>=0A=
<g >=0A<title>security_file_permission (28,279,941,534 samples, 0.35%)</tit=
le><rect x=3D"72.6" y=3D"277" width=3D"4.1" height=3D"15.0" fill=3D"rgb(212=
,146,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"75.56" y=3D"287.5" ></text>=0A=
</g>=0A<g >=0A<title>update_load_avg (769,767,657 samples, 0.01%)</title><r=
ect x=3D"1116.3" y=3D"133" width=3D"0.1" height=3D"15.0" fill=3D"rgb(219,17=
6,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1119.31" y=3D"143.5" ></text>=0A</=
g>=0A<g >=0A<title>sched_clock_cpu (1,759,822,258 samples, 0.02%)</title><r=
ect x=3D"1148.7" y=3D"133" width=3D"0.3" height=3D"15.0" fill=3D"rgb(254,50=
,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1151.74" y=3D"143.5" ></text>=0A</=
g>=0A<g >=0A<title>bpf_lsm_socket_getpeersec_dgram (10,963,079,165 samples,=
 0.14%)</title><rect x=3D"739.2" y=3D"213" width=3D"1.6" height=3D"15.0" fi=
ll=3D"rgb(228,123,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"742.24" y=3D"223.=
5" ></text>=0A</g>=0A<g >=0A<title>__list_del_entry_valid (726,098,048 samp=
les, 0.01%)</title><rect x=3D"462.2" y=3D"165" width=3D"0.1" height=3D"15.0=
" fill=3D"rgb(249,149,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"465.20" y=3D"=
175.5" ></text>=0A</g>=0A<g >=0A<title>sock_sendmsg (3,141,417,742,191 samp=
les, 39.10%)</title><rect x=3D"692.8" y=3D"261" width=3D"461.4" height=3D"1=
5.0" fill=3D"rgb(214,207,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"695.83" y=
=3D"271.5" >sock_sendmsg</text>=0A</g>=0A<g >=0A<title>security_socket_recv=
msg (33,315,305,467 samples, 0.41%)</title><rect x=3D"93.1" y=3D"245" width=
=3D"4.9" height=3D"15.0" fill=3D"rgb(235,149,4)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"96.09" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>syscall_return_=
via_sysret (17,145,998,962 samples, 0.21%)</title><rect x=3D"1180.5" y=3D"3=
41" width=3D"2.5" height=3D"15.0" fill=3D"rgb(205,160,16)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"1183.48" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>__m=
od_memcg_state (5,389,966,879 samples, 0.07%)</title><rect x=3D"1110.3" y=
=3D"117" width=3D"0.8" height=3D"15.0" fill=3D"rgb(206,195,22)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1113.34" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__fdget_pos (49,699,450,000 samples, 0.62%)</title><rect x=3D"647.5" y=3D=
"293" width=3D"7.3" height=3D"15.0" fill=3D"rgb(237,51,2)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"650.52" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>mod_=
memcg_lruvec_state (11,435,237,574 samples, 0.14%)</title><rect x=3D"252.1"=
 y=3D"165" width=3D"1.7" height=3D"15.0" fill=3D"rgb(237,25,51)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"255.10" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<titl=
e>_raw_spin_unlock_irqrestore (2,862,196,265 samples, 0.04%)</title><rect x=
=3D"1150.4" y=3D"197" width=3D"0.4" height=3D"15.0" fill=3D"rgb(215,159,34)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1153.39" y=3D"207.5" ></text>=0A</g>=
=0A<g >=0A<title>__get_task_ioprio (17,067,836,681 samples, 0.21%)</title><=
rect x=3D"66.8" y=3D"277" width=3D"2.5" height=3D"15.0" fill=3D"rgb(243,156=
,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"69.76" y=3D"287.5" ></text>=0A</g>=
=0A<g >=0A<title>sock_read_iter (3,462,357,602,934 samples, 43.09%)</title>=
<rect x=3D"76.7" y=3D"277" width=3D"508.5" height=3D"15.0" fill=3D"rgb(253,=
38,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"79.72" y=3D"287.5" >sock_read_it=
er</text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (4,889,710,082 samples, =
0.06%)</title><rect x=3D"388.6" y=3D"213" width=3D"0.7" height=3D"15.0" fil=
l=3D"rgb(228,4,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"391.57" y=3D"223.5" =
></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (2,140,548,424 samples, 0.0=
3%)</title><rect x=3D"255.5" y=3D"165" width=3D"0.3" height=3D"15.0" fill=
=3D"rgb(230,224,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"258.51" y=3D"175.5" =
></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled (2,667,105,877 sa=
mples, 0.03%)</title><rect x=3D"432.7" y=3D"165" width=3D"0.4" height=3D"15=
=2E0" fill=3D"rgb(235,114,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"435.67" y=
=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>do_syscall_64 (3,665,861,404,744=
 samples, 45.62%)</title><rect x=3D"640.0" y=3D"325" width=3D"538.4" height=
=3D"15.0" fill=3D"rgb(210,89,26)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"643.03=
" y=3D"335.5" >do_syscall_64</text>=0A</g>=0A<g >=0A<title>enqueue_task (4,=
395,000,992 samples, 0.05%)</title><rect x=3D"348.9" y=3D"69" width=3D"0.6"=
 height=3D"15.0" fill=3D"rgb(234,185,34)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"351.86" y=3D"79.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (2,1=
41,707,748 samples, 0.03%)</title><rect x=3D"851.1" y=3D"133" width=3D"0.3"=
 height=3D"15.0" fill=3D"rgb(210,59,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"854.05" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>secondary_startup_64_n=
o_verify (2,065,092,133 samples, 0.03%)</title><rect x=3D"1189.7" y=3D"389"=
 width=3D"0.3" height=3D"15.0" fill=3D"rgb(240,142,16)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"1192.70" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>maybe_=
add_creds (13,744,692,174 samples, 0.17%)</title><rect x=3D"733.8" y=3D"229=
" width=3D"2.1" height=3D"15.0" fill=3D"rgb(234,48,26)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"736.83" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>newidle=
_balance (1,935,774,463 samples, 0.02%)</title><rect x=3D"462.4" y=3D"165" =
width=3D"0.2" height=3D"15.0" fill=3D"rgb(233,89,51)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"465.36" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>cgroup_r=
stat_updated (2,220,372,679 samples, 0.03%)</title><rect x=3D"975.4" y=3D"8=
5" width=3D"0.3" height=3D"15.0" fill=3D"rgb(212,25,11)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"978.42" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgr=
oup_uncharge_pages (17,951,844,287 samples, 0.22%)</title><rect x=3D"433.2"=
 y=3D"213" width=3D"2.7" height=3D"15.0" fill=3D"rgb(207,106,25)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"436.22" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<tit=
le>__get_user_8 (1,914,018,974 samples, 0.02%)</title><rect x=3D"1165.4" y=
=3D"261" width=3D"0.2" height=3D"15.0" fill=3D"rgb(215,159,26)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1168.35" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<titl=
e>preempt_count_add (8,443,831,331 samples, 0.11%)</title><rect x=3D"786.1"=
 y=3D"197" width=3D"1.2" height=3D"15.0" fill=3D"rgb(228,168,21)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"789.07" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<tit=
le>psi_group_change (3,262,094,103 samples, 0.04%)</title><rect x=3D"349.0"=
 y=3D"37" width=3D"0.5" height=3D"15.0" fill=3D"rgb(231,227,53)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"351.99" y=3D"47.5" ></text>=0A</g>=0A<g >=0A<title=
>__update_load_avg_cfs_rq (2,184,804,238 samples, 0.03%)</title><rect x=3D"=
1144.9" y=3D"101" width=3D"0.3" height=3D"15.0" fill=3D"rgb(213,120,32)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1147.86" y=3D"111.5" ></text>=0A</g>=0A<g =
>=0A<title>switch_mm_irqs_off (2,195,031,131 samples, 0.03%)</title><rect x=
=3D"468.0" y=3D"181" width=3D"0.3" height=3D"15.0" fill=3D"rgb(215,225,12)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"470.99" y=3D"191.5" ></text>=0A</g>=0A<=
g >=0A<title>get_partial_node (85,275,559,709 samples, 1.06%)</title><rect =
x=3D"1007.4" y=3D"133" width=3D"12.5" height=3D"15.0" fill=3D"rgb(227,18,21=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1010.35" y=3D"143.5" ></text>=0A</g>=
=0A<g >=0A<title>__cond_resched (3,232,307,243 samples, 0.04%)</title><rect=
 x=3D"999.4" y=3D"165" width=3D"0.5" height=3D"15.0" fill=3D"rgb(206,157,18=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1002.41" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>__x86_indirect_thunk_array (1,086,324,146 samples, 0.01%)<=
/title><rect x=3D"740.7" y=3D"197" width=3D"0.1" height=3D"15.0" fill=3D"rg=
b(235,224,0)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"743.68" y=3D"207.5" ></tex=
t>=0A</g>=0A<g >=0A<title>schedule (26,234,945,696 samples, 0.33%)</title><=
rect x=3D"1115.3" y=3D"197" width=3D"3.8" height=3D"15.0" fill=3D"rgb(245,2=
25,40)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1118.29" y=3D"207.5" ></text>=0A=
</g>=0A<g >=0A<title>simple_copy_to_iter (285,573,561,935 samples, 3.55%)</=
title><rect x=3D"543.2" y=3D"181" width=3D"42.0" height=3D"15.0" fill=3D"rg=
b(218,18,35)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"546.24" y=3D"191.5" >sim..=
</text>=0A</g>=0A<g >=0A<title>unix_write_space (49,400,352,742 samples, 0.=
61%)</title><rect x=3D"343.9" y=3D"165" width=3D"7.3" height=3D"15.0" fill=
=3D"rgb(244,85,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"346.92" y=3D"175.5" =
></text>=0A</g>=0A<g >=0A<title>set_next_buddy (1,409,918,961 samples, 0.02=
%)</title><rect x=3D"1116.6" y=3D"149" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(251,37,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1119.63" y=3D"159.5"=
 ></text>=0A</g>=0A<g >=0A<title>ttwu_do_activate (13,656,667,117 samples, =
0.17%)</title><rect x=3D"348.8" y=3D"85" width=3D"2.0" height=3D"15.0" fill=
=3D"rgb(218,61,50)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"351.83" y=3D"95.5" >=
</text>=0A</g>=0A<g >=0A<title>native_sched_clock (1,276,525,079 samples, 0=
=2E02%)</title><rect x=3D"469.2" y=3D"133" width=3D"0.2" height=3D"15.0" fi=
ll=3D"rgb(228,128,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"472.23" y=3D"143.=
5" ></text>=0A</g>=0A<g >=0A<title>__switch_to_asm (7,202,763,481 samples, =
0.09%)</title><rect x=3D"1184.2" y=3D"373" width=3D"1.0" height=3D"15.0" fi=
ll=3D"rgb(240,189,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1187.17" y=3D"383=
=2E5" ></text>=0A</g>=0A<g >=0A<title>memset_erms (152,119,556,134 samples,=
 1.89%)</title><rect x=3D"939.3" y=3D"149" width=3D"22.3" height=3D"15.0" f=
ill=3D"rgb(219,229,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"942.30" y=3D"159.=
5" >m..</text>=0A</g>=0A<g >=0A<title>__mod_memcg_lruvec_state (8,573,144,1=
80 samples, 0.11%)</title><rect x=3D"1088.6" y=3D"117" width=3D"1.3" height=
=3D"15.0" fill=3D"rgb(208,96,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1091.64=
" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock (956,343,675 s=
amples, 0.01%)</title><rect x=3D"1166.6" y=3D"245" width=3D"0.2" height=3D"=
15.0" fill=3D"rgb(215,202,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1169.64" =
y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_state (11,920,801,3=
16 samples, 0.15%)</title><rect x=3D"256.4" y=3D"133" width=3D"1.7" height=
=3D"15.0" fill=3D"rgb(223,198,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"259.3=
7" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>kfree_skbmem (4,956,692,932 =
samples, 0.06%)</title><rect x=3D"351.5" y=3D"229" width=3D"0.7" height=3D"=
15.0" fill=3D"rgb(210,117,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"354.46" y=
=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>update_curr (3,263,002,931 sampl=
es, 0.04%)</title><rect x=3D"457.2" y=3D"149" width=3D"0.5" height=3D"15.0"=
 fill=3D"rgb(225,32,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"460.23" y=3D"159=
=2E5" ></text>=0A</g>=0A<g >=0A<title>__calc_delta (2,591,075,388 samples, =
0.03%)</title><rect x=3D"1142.8" y=3D"85" width=3D"0.3" height=3D"15.0" fil=
l=3D"rgb(240,64,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1145.76" y=3D"95.5"=
 ></text>=0A</g>=0A<g >=0A<title>switch_mm_irqs_off (684,862,063 samples, 0=
=2E01%)</title><rect x=3D"1118.8" y=3D"165" width=3D"0.1" height=3D"15.0" f=
ill=3D"rgb(239,93,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1121.78" y=3D"175=
=2E5" ></text>=0A</g>=0A<g >=0A<title>autoremove_wake_function (135,008,262=
,096 samples, 1.68%)</title><rect x=3D"1129.2" y=3D"181" width=3D"19.8" hei=
ght=3D"15.0" fill=3D"rgb(247,179,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"113=
2.17" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>enqueue_task (17,811,815,=
795 samples, 0.22%)</title><rect x=3D"1135.1" y=3D"133" width=3D"2.6" heigh=
t=3D"15.0" fill=3D"rgb(241,193,46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1138=
=2E11" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>cpuidle_enter_state (974=
,711,438 samples, 0.01%)</title><rect x=3D"1189.7" y=3D"309" width=3D"0.1" =
height=3D"15.0" fill=3D"rgb(222,224,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"1192.70" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>check_preempt_wakeup =
(8,439,729,545 samples, 0.11%)</title><rect x=3D"1146.1" y=3D"117" width=3D=
"1.3" height=3D"15.0" fill=3D"rgb(226,224,30)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1149.13" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>check_preemptio=
n_disabled (55,117,352,104 samples, 0.69%)</title><rect x=3D"929.2" y=3D"11=
7" width=3D"8.1" height=3D"15.0" fill=3D"rgb(251,212,37)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"932.25" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>sched=
ule (7,844,035,107 samples, 0.10%)</title><rect x=3D"1166.5" y=3D"277" widt=
h=3D"1.1" height=3D"15.0" fill=3D"rgb(251,118,42)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1169.48" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>__schedule =
(7,440,674,246 samples, 0.09%)</title><rect x=3D"1166.5" y=3D"261" width=3D=
"1.1" height=3D"15.0" fill=3D"rgb(213,40,44)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1169.52" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__check_object_s=
ize (279,856,162,613 samples, 3.48%)</title><rect x=3D"544.1" y=3D"165" wid=
th=3D"41.1" height=3D"15.0" fill=3D"rgb(222,106,27)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"547.08" y=3D"175.5" >__c..</text>=0A</g>=0A<g >=0A<title>__x=
86_indirect_thunk_array (950,674,222 samples, 0.01%)</title><rect x=3D"620.=
5" y=3D"325" width=3D"0.1" height=3D"15.0" fill=3D"rgb(225,182,54)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"623.48" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<t=
itle>load_new_mm_cr3 (1,593,065,578 samples, 0.02%)</title><rect x=3D"1189.=
0" y=3D"181" width=3D"0.2" height=3D"15.0" fill=3D"rgb(208,17,13)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"1191.98" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<t=
itle>_copy_from_iter (119,883,517,499 samples, 1.49%)</title><rect x=3D"761=
=2E3" y=3D"213" width=3D"17.6" height=3D"15.0" fill=3D"rgb(246,18,19)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"764.26" y=3D"223.5" ></text>=0A</g>=0A<g >=
=0A<title>_raw_spin_lock_irqsave (31,249,029,696 samples, 0.39%)</title><re=
ct x=3D"782.7" y=3D"213" width=3D"4.6" height=3D"15.0" fill=3D"rgb(239,8,33=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"785.72" y=3D"223.5" ></text>=0A</g>=
=0A<g >=0A<title>_raw_spin_unlock_irqrestore (11,380,989,517 samples, 0.14%=
)</title><rect x=3D"732.1" y=3D"229" width=3D"1.7" height=3D"15.0" fill=3D"=
rgb(237,93,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"735.13" y=3D"239.5" ></t=
ext>=0A</g>=0A<g >=0A<title>reweight_entity (1,220,821,896 samples, 0.02%)<=
/title><rect x=3D"350.2" y=3D"53" width=3D"0.2" height=3D"15.0" fill=3D"rgb=
(223,226,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"353.22" y=3D"63.5" ></text=
>=0A</g>=0A<g >=0A<title>enqueue_task_fair (54,794,572,680 samples, 0.68%)<=
/title><rect x=3D"1137.7" y=3D"133" width=3D"8.1" height=3D"15.0" fill=3D"r=
gb(221,111,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1140.73" y=3D"143.5" ></=
text>=0A</g>=0A<g >=0A<title>pick_next_task_fair (4,915,810,739 samples, 0.=
06%)</title><rect x=3D"603.0" y=3D"245" width=3D"0.7" height=3D"15.0" fill=
=3D"rgb(251,84,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"605.96" y=3D"255.5" =
></text>=0A</g>=0A<g >=0A<title>page_counter_uncharge (1,593,564,854 sample=
s, 0.02%)</title><rect x=3D"259.9" y=3D"133" width=3D"0.3" height=3D"15.0" =
fill=3D"rgb(251,157,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"262.93" y=3D"14=
3.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (51,837,868,678 samp=
les, 0.65%)</title><rect x=3D"909.0" y=3D"133" width=3D"7.6" height=3D"15.0=
" fill=3D"rgb(218,61,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"912.00" y=3D"1=
43.5" ></text>=0A</g>=0A<g >=0A<title>get_obj_cgroup_from_current (49,872,8=
38,883 samples, 0.62%)</title><rect x=3D"844.6" y=3D"149" width=3D"7.3" hei=
ght=3D"15.0" fill=3D"rgb(216,143,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"84=
7.59" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>autoremove_wake_function =
(20,823,221,209 samples, 0.26%)</title><rect x=3D"348.1" y=3D"117" width=3D=
"3.1" height=3D"15.0" fill=3D"rgb(235,106,2)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"351.10" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>skb_set_owner_w (=
26,788,558,316 samples, 0.33%)</title><rect x=3D"1119.1" y=3D"213" width=3D=
"4.0" height=3D"15.0" fill=3D"rgb(230,15,32)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1122.14" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock_i=
rqsave (49,002,964,916 samples, 0.61%)</title><rect x=3D"301.6" y=3D"181" w=
idth=3D"7.2" height=3D"15.0" fill=3D"rgb(210,123,34)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"304.60" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>in_lock_=
functions (2,996,481,429 samples, 0.04%)</title><rect x=3D"171.3" y=3D"197"=
 width=3D"0.4" height=3D"15.0" fill=3D"rgb(226,94,40)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"174.26" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>enqueue_=
entity (3,189,835,581 samples, 0.04%)</title><rect x=3D"349.7" y=3D"53" wid=
th=3D"0.5" height=3D"15.0" fill=3D"rgb(243,103,51)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"352.75" y=3D"63.5" ></text>=0A</g>=0A<g >=0A<title>check_preemp=
tion_disabled (3,546,177,712 samples, 0.04%)</title><rect x=3D"938.8" y=3D"=
85" width=3D"0.5" height=3D"15.0" fill=3D"rgb(213,125,13)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"941.78" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>blkcg=
_maybe_throttle_current (910,797,653 samples, 0.01%)</title><rect x=3D"599.=
5" y=3D"277" width=3D"0.1" height=3D"15.0" fill=3D"rgb(222,165,51)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"602.50" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<t=
itle>fpregs_restore_userregs (4,991,635,930 samples, 0.06%)</title><rect x=
=3D"1165.7" y=3D"277" width=3D"0.8" height=3D"15.0" fill=3D"rgb(224,78,53)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"1168.73" y=3D"287.5" ></text>=0A</g>=0A=
<g >=0A<title>preempt_count_sub (2,535,880,044 samples, 0.03%)</title><rect=
 x=3D"733.4" y=3D"213" width=3D"0.4" height=3D"15.0" fill=3D"rgb(223,63,4)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"736.43" y=3D"223.5" ></text>=0A</g>=0A<=
g >=0A<title>entry_SYSCALL_64 (65,138,370,861 samples, 0.81%)</title><rect =
x=3D"28.1" y=3D"341" width=3D"9.6" height=3D"15.0" fill=3D"rgb(215,195,52)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"31.13" y=3D"351.5" ></text>=0A</g>=0A<g=
 >=0A<title>preempt_count_sub (998,019,523 samples, 0.01%)</title><rect x=
=3D"843.6" y=3D"85" width=3D"0.2" height=3D"15.0" fill=3D"rgb(254,163,28)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"846.64" y=3D"95.5" ></text>=0A</g>=0A<g =
>=0A<title>page_counter_try_charge (992,697,115 samples, 0.01%)</title><rec=
t x=3D"980.4" y=3D"117" width=3D"0.1" height=3D"15.0" fill=3D"rgb(212,190,3=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"983.37" y=3D"127.5" ></text>=0A</g>=
=0A<g >=0A<title>update_load_avg (3,404,483,732 samples, 0.04%)</title><rec=
t x=3D"464.1" y=3D"149" width=3D"0.5" height=3D"15.0" fill=3D"rgb(217,78,34=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"467.07" y=3D"159.5" ></text>=0A</g>=
=0A<g >=0A<title>load_new_mm_cr3 (7,559,777,714 samples, 0.09%)</title><rec=
t x=3D"1185.9" y=3D"197" width=3D"1.1" height=3D"15.0" fill=3D"rgb(231,177,=
44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.93" y=3D"207.5" ></text>=0A</g=
>=0A<g >=0A<title>save_fpregs_to_fpstate (1,442,250,513 samples, 0.02%)</ti=
tle><rect x=3D"1189.4" y=3D"373" width=3D"0.2" height=3D"15.0" fill=3D"rgb(=
234,160,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.44" y=3D"383.5" ></tex=
t>=0A</g>=0A<g >=0A<title>asm_sysvec_reschedule_ipi (821,334,767 samples, 0=
=2E01%)</title><rect x=3D"461.4" y=3D"165" width=3D"0.1" height=3D"15.0" fi=
ll=3D"rgb(243,69,5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"464.42" y=3D"175.5"=
 ></text>=0A</g>=0A<g >=0A<title>sched_clock_cpu (1,666,945,655 samples, 0.=
02%)</title><rect x=3D"467.5" y=3D"165" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(215,149,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"470.50" y=3D"175.5"=
 ></text>=0A</g>=0A<g >=0A<title>psi_task_change (16,815,062,520 samples, 0=
=2E21%)</title><rect x=3D"1135.3" y=3D"117" width=3D"2.4" height=3D"15.0" f=
ill=3D"rgb(246,215,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1138.26" y=3D"12=
7.5" ></text>=0A</g>=0A<g >=0A<title>update_curr (683,939,724 samples, 0.01=
%)</title><rect x=3D"350.0" y=3D"37" width=3D"0.1" height=3D"15.0" fill=3D"=
rgb(245,173,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"352.95" y=3D"47.5" ></t=
ext>=0A</g>=0A<g >=0A<title>do_syscall_64 (3,920,024,569,824 samples, 48.79=
%)</title><rect x=3D"40.4" y=3D"325" width=3D"575.7" height=3D"15.0" fill=
=3D"rgb(223,94,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"43.43" y=3D"335.5" >=
do_syscall_64</text>=0A</g>=0A<g >=0A<title>schedule (1,267,202,789 samples=
, 0.02%)</title><rect x=3D"1189.2" y=3D"309" width=3D"0.2" height=3D"15.0" =
fill=3D"rgb(245,50,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.22" y=3D"31=
9.5" ></text>=0A</g>=0A<g >=0A<title>update_cfs_group (5,442,047,445 sample=
s, 0.07%)</title><rect x=3D"1143.3" y=3D"117" width=3D"0.8" height=3D"15.0"=
 fill=3D"rgb(231,57,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1146.28" y=3D"1=
27.5" ></text>=0A</g>=0A<g >=0A<title>put_cpu_partial (1,953,357,222 sample=
s, 0.02%)</title><rect x=3D"843.8" y=3D"101" width=3D"0.3" height=3D"15.0" =
fill=3D"rgb(226,144,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"846.79" y=3D"11=
1.5" ></text>=0A</g>=0A<g >=0A<title>__check_object_size (116,933,498,442 s=
amples, 1.46%)</title><rect x=3D"744.1" y=3D"213" width=3D"17.2" height=3D"=
15.0" fill=3D"rgb(222,102,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"747.09" y=
=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>vfs_read (3,626,698,241,156 samp=
les, 45.14%)</title><rect x=3D"52.6" y=3D"293" width=3D"532.6" height=3D"15=
=2E0" fill=3D"rgb(240,216,36)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"55.58" y=
=3D"303.5" >vfs_read</text>=0A</g>=0A<g >=0A<title>check_preempt_curr (10,3=
94,811,503 samples, 0.13%)</title><rect x=3D"1145.8" y=3D"133" width=3D"1.6=
" height=3D"15.0" fill=3D"rgb(239,203,44)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1148.84" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__list_del_entry_v=
alid (767,691,581 samples, 0.01%)</title><rect x=3D"1129.3" y=3D"165" width=
=3D"0.1" height=3D"15.0" fill=3D"rgb(252,176,38)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"1132.32" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>entry_SYSRET=
Q_unsafe_stack (1,546,275,484 samples, 0.02%)</title><rect x=3D"1179.5" y=
=3D"341" width=3D"0.3" height=3D"15.0" fill=3D"rgb(233,75,43)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1182.52" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<titl=
e>kmem_cache_free (630,051,483,527 samples, 7.84%)</title><rect x=3D"352.2"=
 y=3D"229" width=3D"92.5" height=3D"15.0" fill=3D"rgb(228,188,45)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"355.19" y=3D"239.5" >kmem_cache_..</text>=0A</g>=
=0A<g >=0A<title>skb_put (6,458,094,510 samples, 0.08%)</title><rect x=3D"7=
78.9" y=3D"229" width=3D"0.9" height=3D"15.0" fill=3D"rgb(246,56,25)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"781.87" y=3D"239.5" ></text>=0A</g>=0A<g >=0A=
<title>switch_mm_irqs_off (2,003,397,151 samples, 0.02%)</title><rect x=3D"=
1188.9" y=3D"197" width=3D"0.3" height=3D"15.0" fill=3D"rgb(233,108,36)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1191.92" y=3D"207.5" ></text>=0A</g>=0A<g =
>=0A<title>mutex_lock (17,843,014,299 samples, 0.22%)</title><rect x=3D"444=
=2E7" y=3D"229" width=3D"2.6" height=3D"15.0" fill=3D"rgb(250,148,27)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"447.71" y=3D"239.5" ></text>=0A</g>=0A<g >=
=0A<title>mod_objcg_state (151,020,548,576 samples, 1.88%)</title><rect x=
=3D"231.6" y=3D"181" width=3D"22.2" height=3D"15.0" fill=3D"rgb(241,167,54)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"234.61" y=3D"191.5" >m..</text>=0A</g>=
=0A<g >=0A<title>__cond_resched (1,813,653,038 samples, 0.02%)</title><rect=
 x=3D"1153.9" y=3D"213" width=3D"0.3" height=3D"15.0" fill=3D"rgb(232,135,3=
5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1156.90" y=3D"223.5" ></text>=0A</g>=
=0A<g >=0A<title>check_preemption_disabled (127,128,151,962 samples, 1.58%)=
</title><rect x=3D"1065.2" y=3D"133" width=3D"18.7" height=3D"15.0" fill=3D=
"rgb(207,8,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1068.22" y=3D"143.5" ></=
text>=0A</g>=0A<g >=0A<title>all (8,035,154,921,170 samples, 100%)</title><=
rect x=3D"10.0" y=3D"421" width=3D"1180.0" height=3D"15.0" fill=3D"rgb(247,=
9,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"13.00" y=3D"431.5" ></text>=0A</g>=
=0A<g >=0A<title>unix_stream_read_generic (3,287,041,361,138 samples, 40.91=
%)</title><rect x=3D"102.5" y=3D"245" width=3D"482.7" height=3D"15.0" fill=
=3D"rgb(237,193,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"105.46" y=3D"255.5" =
>unix_stream_read_generic</text>=0A</g>=0A<g >=0A<title>try_charge_memcg (6=
,814,489,045 samples, 0.08%)</title><rect x=3D"1111.9" y=3D"149" width=3D"1=
=2E0" height=3D"15.0" fill=3D"rgb(250,122,42)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1114.91" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>update_curr (99=
9,526,547 samples, 0.01%)</title><rect x=3D"464.6" y=3D"165" width=3D"0.1" =
height=3D"15.0" fill=3D"rgb(209,102,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"467.57" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>scm_recv.constprop.0 (=
17,361,525,802 samples, 0.22%)</title><rect x=3D"469.9" y=3D"229" width=3D"=
2.5" height=3D"15.0" fill=3D"rgb(208,212,19)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"472.85" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>mutex_unlock (6,5=
41,456,350 samples, 0.08%)</title><rect x=3D"447.3" y=3D"229" width=3D"1.0"=
 height=3D"15.0" fill=3D"rgb(243,20,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"450.33" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>reweight_entity (1,327=
,929,861 samples, 0.02%)</title><rect x=3D"1116.4" y=3D"149" width=3D"0.2" =
height=3D"15.0" fill=3D"rgb(221,127,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"1119.43" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>update_curr (4,594,95=
4,974 samples, 0.06%)</title><rect x=3D"1142.6" y=3D"101" width=3D"0.7" hei=
ght=3D"15.0" fill=3D"rgb(253,206,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"114=
5.61" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>native_sched_clock (1,225=
,933,983 samples, 0.02%)</title><rect x=3D"1137.5" y=3D"85" width=3D"0.2" h=
eight=3D"15.0" fill=3D"rgb(247,187,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
1140.54" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>preempt_count_sub (1,13=
6,673,172 samples, 0.01%)</title><rect x=3D"1019.4" y=3D"101" width=3D"0.1"=
 height=3D"15.0" fill=3D"rgb(212,229,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"1022.37" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__list_add_valid (3,9=
48,263,227 samples, 0.05%)</title><rect x=3D"301.0" y=3D"181" width=3D"0.6"=
 height=3D"15.0" fill=3D"rgb(217,134,30)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"304.02" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>try_to_wake_up (20,=
101,341,515 samples, 0.25%)</title><rect x=3D"348.2" y=3D"101" width=3D"3.0=
" height=3D"15.0" fill=3D"rgb(254,9,6)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
351.21" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_recvmsg (9,=
381,663,380 samples, 0.12%)</title><rect x=3D"1185.7" y=3D"293" width=3D"1.=
3" height=3D"15.0" fill=3D"rgb(249,111,19)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1188.66" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_sendms=
g (3,081,655,034,672 samples, 38.35%)</title><rect x=3D"701.6" y=3D"245" wi=
dth=3D"452.6" height=3D"15.0" fill=3D"rgb(208,46,50)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"704.61" y=3D"255.5" >unix_stream_sendmsg</text>=0A</g>=0A<g =
>=0A<title>debug_smp_processor_id (30,819,851,611 samples, 0.38%)</title><r=
ect x=3D"1083.9" y=3D"133" width=3D"4.5" height=3D"15.0" fill=3D"rgb(228,13=
6,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1086.89" y=3D"143.5" ></text>=0A</=
g>=0A<g >=0A<title>update_load_avg (4,656,479,186 samples, 0.06%)</title><r=
ect x=3D"456.0" y=3D"149" width=3D"0.7" height=3D"15.0" fill=3D"rgb(240,215=
,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"459.04" y=3D"159.5" ></text>=0A</g=
>=0A<g >=0A<title>copy_user_enhanced_fast_string (100,001,805,980 samples, =
1.24%)</title><rect x=3D"764.2" y=3D"197" width=3D"14.7" height=3D"15.0" fi=
ll=3D"rgb(220,202,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"767.18" y=3D"207.=
5" ></text>=0A</g>=0A<g >=0A<title>update_min_vruntime (906,727,748 samples=
, 0.01%)</title><rect x=3D"457.6" y=3D"133" width=3D"0.1" height=3D"15.0" f=
ill=3D"rgb(220,160,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"460.58" y=3D"143=
=2E5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (869,581,094 sample=
s, 0.01%)</title><rect x=3D"1103.3" y=3D"149" width=3D"0.1" height=3D"15.0"=
 fill=3D"rgb(215,116,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1106.30" y=3D"=
159.5" ></text>=0A</g>=0A<g >=0A<title>__wrgsbase_inactive (912,228,227 sam=
ples, 0.01%)</title><rect x=3D"1188.7" y=3D"373" width=3D"0.2" height=3D"15=
=2E0" fill=3D"rgb(236,47,49)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.74" y=
=3D"383.5" ></text>=0A</g>=0A<g >=0A<title>sock_alloc_send_pskb (2,084,751,=
145 samples, 0.03%)</title><rect x=3D"1188.9" y=3D"261" width=3D"0.3" heigh=
t=3D"15.0" fill=3D"rgb(223,32,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.9=
1" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__x86_indirect_thunk_array (=
4,431,218,261 samples, 0.06%)</title><rect x=3D"617.4" y=3D"325" width=3D"0=
=2E6" height=3D"15.0" fill=3D"rgb(206,1,33)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"620.38" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>fsnotify_perm (1,6=
38,820,941 samples, 0.02%)</title><rect x=3D"675.4" y=3D"277" width=3D"0.3"=
 height=3D"15.0" fill=3D"rgb(249,39,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"678.45" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>do_syscall_64 (3,351,9=
53,934 samples, 0.04%)</title><rect x=3D"1188.9" y=3D"357" width=3D"0.5" he=
ight=3D"15.0" fill=3D"rgb(241,0,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"119=
1.91" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>check_preemption_disabled=
 (2,420,871,527 samples, 0.03%)</title><rect x=3D"258.8" y=3D"133" width=3D=
"0.4" height=3D"15.0" fill=3D"rgb(252,162,20)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"261.82" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>fpregs_restore_u=
serregs (17,983,100,204 samples, 0.22%)</title><rect x=3D"599.6" y=3D"277" =
width=3D"2.7" height=3D"15.0" fill=3D"rgb(212,195,20)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"602.63" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spi=
n_lock_irqsave (64,445,281,001 samples, 0.80%)</title><rect x=3D"476.7" y=
=3D"213" width=3D"9.5" height=3D"15.0" fill=3D"rgb(249,93,16)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"479.73" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title=
>swapper (2,120,594,012 samples, 0.03%)</title><rect x=3D"1189.7" y=3D"405"=
 width=3D"0.3" height=3D"15.0" fill=3D"rgb(211,153,2)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1192.69" y=3D"415.5" ></text>=0A</g>=0A<g >=0A<title>pick_ne=
xt_entity (3,079,602,078 samples, 0.04%)</title><rect x=3D"462.6" y=3D"165"=
 width=3D"0.5" height=3D"15.0" fill=3D"rgb(233,197,33)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"465.64" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__updat=
e_load_avg_cfs_rq (2,082,717,407 samples, 0.03%)</title><rect x=3D"456.2" y=
=3D"133" width=3D"0.3" height=3D"15.0" fill=3D"rgb(237,135,32)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"459.23" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title=
>__default_send_IPI_dest_field (2,850,815,036 samples, 0.04%)</title><rect =
x=3D"1146.7" y=3D"85" width=3D"0.5" height=3D"15.0" fill=3D"rgb(207,228,33)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1149.73" y=3D"95.5" ></text>=0A</g>=0A=
<g >=0A<title>__rseq_handle_notify_resume (12,251,732,366 samples, 0.15%)</=
title><rect x=3D"597.7" y=3D"277" width=3D"1.8" height=3D"15.0" fill=3D"rgb=
(251,81,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"600.70" y=3D"287.5" ></text>=
=0A</g>=0A<g >=0A<title>check_preemption_disabled (1,950,362,911 samples, 0=
=2E02%)</title><rect x=3D"449.9" y=3D"213" width=3D"0.3" height=3D"15.0" fi=
ll=3D"rgb(217,49,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"452.86" y=3D"223.5"=
 ></text>=0A</g>=0A<g >=0A<title>__fget_light (46,743,461,841 samples, 0.58=
%)</title><rect x=3D"647.9" y=3D"277" width=3D"6.9" height=3D"15.0" fill=3D=
"rgb(242,16,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"650.95" y=3D"287.5" ></=
text>=0A</g>=0A<g >=0A<title>preempt_count_add (2,144,908,147 samples, 0.03=
%)</title><rect x=3D"1020.0" y=3D"149" width=3D"0.3" height=3D"15.0" fill=
=3D"rgb(229,99,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1022.98" y=3D"159.5"=
 ></text>=0A</g>=0A</g>=0A</svg>=0A
--oudKfyDVtxiFA6ja
Content-Type: image/svg+xml
Content-Disposition: attachment; filename="flamegraph-6.1.8.svg"
Content-Transfer-Encoding: quoted-printable

<?xml version=3D"1.0" standalone=3D"no"?>=0A<!DOCTYPE svg PUBLIC "-//W3C//D=
TD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">=0A<svg =
version=3D"1.1" width=3D"1200" height=3D"486" onload=3D"init(evt)" viewBox=
=3D"0 0 1200 486" xmlns=3D"http://www.w3.org/2000/svg" xmlns:xlink=3D"http:=
//www.w3.org/1999/xlink">=0A<!-- Flame graph stack visualization. See https=
://github.com/brendangregg/FlameGraph for latest version, and http://www.br=
endangregg.com/flamegraphs.html for examples. -->=0A<!-- NOTES:  -->=0A<def=
s>=0A	<linearGradient id=3D"background" y1=3D"0" y2=3D"1" x1=3D"0" x2=3D"0"=
 >=0A		<stop stop-color=3D"#eeeeee" offset=3D"5%" />=0A		<stop stop-color=
=3D"#eeeeb0" offset=3D"95%" />=0A	</linearGradient>=0A</defs>=0A<style type=
=3D"text/css">=0A	text { font-family:Verdana; font-size:12px; fill:rgb(0,0,=
0); }=0A	#search, #ignorecase { opacity:0.1; cursor:pointer; }=0A	#search:h=
over, #search.show, #ignorecase:hover, #ignorecase.show { opacity:1; }=0A	#=
subtitle { text-anchor:middle; font-color:rgb(160,160,160); }=0A	#title { t=
ext-anchor:middle; font-size:17px}=0A	#unzoom { cursor:pointer; }=0A	#frame=
s > *:hover { stroke:black; stroke-width:0.5; cursor:pointer; }=0A	.hide { =
display:none; }=0A	.parent { opacity:0.5; }=0A</style>=0A<script type=3D"te=
xt/ecmascript">=0A<![CDATA[=0A	"use strict";=0A	var details, searchbtn, unz=
oombtn, matchedtxt, svg, searching, currentSearchTerm, ignorecase, ignoreca=
seBtn;=0A	function init(evt) {=0A		details =3D document.getElementById("det=
ails").firstChild;=0A		searchbtn =3D document.getElementById("search");=0A	=
	ignorecaseBtn =3D document.getElementById("ignorecase");=0A		unzoombtn =3D=
 document.getElementById("unzoom");=0A		matchedtxt =3D document.getElementB=
yId("matched");=0A		svg =3D document.getElementsByTagName("svg")[0];=0A		se=
arching =3D 0;=0A		currentSearchTerm =3D null;=0A=0A		// use GET parameters=
 to restore a flamegraphs state.=0A		var params =3D get_params();=0A		if (p=
arams.x && params.y)=0A			zoom(find_group(document.querySelector('[x=3D"' +=
 params.x + '"][y=3D"' + params.y + '"]')));=0A                if (params.s=
) search(params.s);=0A	}=0A=0A	// event listeners=0A	window.addEventListene=
r("click", function(e) {=0A		var target =3D find_group(e.target);=0A		if (t=
arget) {=0A			if (target.nodeName =3D=3D "a") {=0A				if (e.ctrlKey =3D=3D=
=3D false) return;=0A				e.preventDefault();=0A			}=0A			if (target.classLi=
st.contains("parent")) unzoom(true);=0A			zoom(target);=0A			if (!document.=
querySelector('.parent')) {=0A				// we have basically done a clearzoom so =
clear the url=0A				var params =3D get_params();=0A				if (params.x) delete=
 params.x;=0A				if (params.y) delete params.y;=0A				history.replaceState(=
null, null, parse_params(params));=0A				unzoombtn.classList.add("hide");=
=0A				return;=0A			}=0A=0A			// set parameters for zoom state=0A			var el =
=3D target.querySelector("rect");=0A			if (el && el.attributes && el.attrib=
utes.y && el.attributes._orig_x) {=0A				var params =3D get_params()=0A				=
params.x =3D el.attributes._orig_x.value;=0A				params.y =3D el.attributes.=
y.value;=0A				history.replaceState(null, null, parse_params(params));=0A		=
	}=0A		}=0A		else if (e.target.id =3D=3D "unzoom") clearzoom();=0A		else if=
 (e.target.id =3D=3D "search") search_prompt();=0A		else if (e.target.id =
=3D=3D "ignorecase") toggle_ignorecase();=0A	}, false)=0A=0A	// mouse-over =
for info=0A	// show=0A	window.addEventListener("mouseover", function(e) {=
=0A		var target =3D find_group(e.target);=0A		if (target) details.nodeValue=
 =3D "Function: " + g_to_text(target);=0A	}, false)=0A=0A	// clear=0A	windo=
w.addEventListener("mouseout", function(e) {=0A		var target =3D find_group(=
e.target);=0A		if (target) details.nodeValue =3D ' ';=0A	}, false)=0A=0A	//=
 ctrl-F for search=0A	// ctrl-I to toggle case-sensitive search=0A	window.a=
ddEventListener("keydown",function (e) {=0A		if (e.keyCode =3D=3D=3D 114 ||=
 (e.ctrlKey && e.keyCode =3D=3D=3D 70)) {=0A			e.preventDefault();=0A			sea=
rch_prompt();=0A		}=0A		else if (e.ctrlKey && e.keyCode =3D=3D=3D 73) {=0A	=
		e.preventDefault();=0A			toggle_ignorecase();=0A		}=0A	}, false)=0A=0A	//=
 functions=0A	function get_params() {=0A		var params =3D {};=0A		var params=
arr =3D window.location.search.substr(1).split('&');=0A		for (var i =3D 0; =
i < paramsarr.length; ++i) {=0A			var tmp =3D paramsarr[i].split("=3D");=0A=
			if (!tmp[0] || !tmp[1]) continue;=0A			params[tmp[0]]  =3D decodeURIComp=
onent(tmp[1]);=0A		}=0A		return params;=0A	}=0A	function parse_params(param=
s) {=0A		var uri =3D "?";=0A		for (var key in params) {=0A			uri +=3D key +=
 '=3D' + encodeURIComponent(params[key]) + '&';=0A		}=0A		if (uri.slice(-1)=
 =3D=3D "&")=0A			uri =3D uri.substring(0, uri.length - 1);=0A		if (uri =3D=
=3D '?')=0A			uri =3D window.location.href.split('?')[0];=0A		return uri;=
=0A	}=0A	function find_child(node, selector) {=0A		var children =3D node.qu=
erySelectorAll(selector);=0A		if (children.length) return children[0];=0A	}=
=0A	function find_group(node) {=0A		var parent =3D node.parentElement;=0A		=
if (!parent) return;=0A		if (parent.id =3D=3D "frames") return node;=0A		re=
turn find_group(parent);=0A	}=0A	function orig_save(e, attr, val) {=0A		if =
(e.attributes["_orig_" + attr] !=3D undefined) return;=0A		if (e.attributes=
[attr] =3D=3D undefined) return;=0A		if (val =3D=3D undefined) val =3D e.at=
tributes[attr].value;=0A		e.setAttribute("_orig_" + attr, val);=0A	}=0A	fun=
ction orig_load(e, attr) {=0A		if (e.attributes["_orig_"+attr] =3D=3D undef=
ined) return;=0A		e.attributes[attr].value =3D e.attributes["_orig_" + attr=
].value;=0A		e.removeAttribute("_orig_"+attr);=0A	}=0A	function g_to_text(e=
) {=0A		var text =3D find_child(e, "title").firstChild.nodeValue;=0A		retur=
n (text)=0A	}=0A	function g_to_func(e) {=0A		var func =3D g_to_text(e);=0A	=
	// if there's any manipulation we want to do to the function=0A		// name b=
efore it's searched, do it here before returning.=0A		return (func);=0A	}=
=0A	function update_text(e) {=0A		var r =3D find_child(e, "rect");=0A		var =
t =3D find_child(e, "text");=0A		var w =3D parseFloat(r.attributes.width.va=
lue) -3;=0A		var txt =3D find_child(e, "title").textContent.replace(/\([^(]=
*\)$/,"");=0A		t.attributes.x.value =3D parseFloat(r.attributes.x.value) + =
3;=0A=0A		// Smaller than this size won't fit anything=0A		if (w < 2 * 12 *=
 0.59) {=0A			t.textContent =3D "";=0A			return;=0A		}=0A=0A		t.textContent=
 =3D txt;=0A		var sl =3D t.getSubStringLength(0, txt.length);=0A		// check =
if only whitespace or if we can fit the entire string into width w=0A		if (=
/^ *$/.test(txt) || sl < w)=0A			return;=0A=0A		// this isn't perfect, but =
gives a good starting point=0A		// and avoids calling getSubStringLength to=
o often=0A		var start =3D Math.floor((w/sl) * txt.length);=0A		for (var x =
=3D start; x > 0; x =3D x-2) {=0A			if (t.getSubStringLength(0, x + 2) <=3D=
 w) {=0A				t.textContent =3D txt.substring(0, x) + "..";=0A				return;=0A	=
		}=0A		}=0A		t.textContent =3D "";=0A	}=0A=0A	// zoom=0A	function zoom_res=
et(e) {=0A		if (e.attributes !=3D undefined) {=0A			orig_load(e, "x");=0A		=
	orig_load(e, "width");=0A		}=0A		if (e.childNodes =3D=3D undefined) return=
;=0A		for (var i =3D 0, c =3D e.childNodes; i < c.length; i++) {=0A			zoom_=
reset(c[i]);=0A		}=0A	}=0A	function zoom_child(e, x, ratio) {=0A		if (e.att=
ributes !=3D undefined) {=0A			if (e.attributes.x !=3D undefined) {=0A				o=
rig_save(e, "x");=0A				e.attributes.x.value =3D (parseFloat(e.attributes.x=
=2Evalue) - x - 10) * ratio + 10;=0A				if (e.tagName =3D=3D "text")=0A				=
	e.attributes.x.value =3D find_child(e.parentNode, "rect[x]").attributes.x.=
value + 3;=0A			}=0A			if (e.attributes.width !=3D undefined) {=0A				orig_=
save(e, "width");=0A				e.attributes.width.value =3D parseFloat(e.attribute=
s.width.value) * ratio;=0A			}=0A		}=0A=0A		if (e.childNodes =3D=3D undefin=
ed) return;=0A		for (var i =3D 0, c =3D e.childNodes; i < c.length; i++) {=
=0A			zoom_child(c[i], x - 10, ratio);=0A		}=0A	}=0A	function zoom_parent(e=
) {=0A		if (e.attributes) {=0A			if (e.attributes.x !=3D undefined) {=0A			=
	orig_save(e, "x");=0A				e.attributes.x.value =3D 10;=0A			}=0A			if (e.at=
tributes.width !=3D undefined) {=0A				orig_save(e, "width");=0A				e.attri=
butes.width.value =3D parseInt(svg.width.baseVal.value) - (10 * 2);=0A			}=
=0A		}=0A		if (e.childNodes =3D=3D undefined) return;=0A		for (var i =3D 0,=
 c =3D e.childNodes; i < c.length; i++) {=0A			zoom_parent(c[i]);=0A		}=0A	=
}=0A	function zoom(node) {=0A		var attr =3D find_child(node, "rect").attrib=
utes;=0A		var width =3D parseFloat(attr.width.value);=0A		var xmin =3D pars=
eFloat(attr.x.value);=0A		var xmax =3D parseFloat(xmin + width);=0A		var ym=
in =3D parseFloat(attr.y.value);=0A		var ratio =3D (svg.width.baseVal.value=
 - 2 * 10) / width;=0A=0A		// XXX: Workaround for JavaScript float issues (=
fix me)=0A		var fudge =3D 0.0001;=0A=0A		unzoombtn.classList.remove("hide")=
;=0A=0A		var el =3D document.getElementById("frames").children;=0A		for (va=
r i =3D 0; i < el.length; i++) {=0A			var e =3D el[i];=0A			var a =3D find_=
child(e, "rect").attributes;=0A			var ex =3D parseFloat(a.x.value);=0A			va=
r ew =3D parseFloat(a.width.value);=0A			var upstack;=0A			// Is it an ance=
stor=0A			if (0 =3D=3D 0) {=0A				upstack =3D parseFloat(a.y.value) > ymin;=
=0A			} else {=0A				upstack =3D parseFloat(a.y.value) < ymin;=0A			}=0A			=
if (upstack) {=0A				// Direct ancestor=0A				if (ex <=3D xmin && (ex+ew+fu=
dge) >=3D xmax) {=0A					e.classList.add("parent");=0A					zoom_parent(e);=
=0A					update_text(e);=0A				}=0A				// not in current path=0A				else=0A	=
				e.classList.add("hide");=0A			}=0A			// Children maybe=0A			else {=0A		=
		// no common path=0A				if (ex < xmin || ex + fudge >=3D xmax) {=0A					e=
=2EclassList.add("hide");=0A				}=0A				else {=0A					zoom_child(e, xmin, r=
atio);=0A					update_text(e);=0A				}=0A			}=0A		}=0A		search();=0A	}=0A	fu=
nction unzoom(dont_update_text) {=0A		unzoombtn.classList.add("hide");=0A		=
var el =3D document.getElementById("frames").children;=0A		for(var i =3D 0;=
 i < el.length; i++) {=0A			el[i].classList.remove("parent");=0A			el[i].cl=
assList.remove("hide");=0A			zoom_reset(el[i]);=0A			if(!dont_update_text) =
update_text(el[i]);=0A		}=0A		search();=0A	}=0A	function clearzoom() {=0A		=
unzoom();=0A=0A		// remove zoom state=0A		var params =3D get_params();=0A		=
if (params.x) delete params.x;=0A		if (params.y) delete params.y;=0A		histo=
ry.replaceState(null, null, parse_params(params));=0A	}=0A=0A	// search=0A	=
function toggle_ignorecase() {=0A		ignorecase =3D !ignorecase;=0A		if (igno=
recase) {=0A			ignorecaseBtn.classList.add("show");=0A		} else {=0A			ignor=
ecaseBtn.classList.remove("show");=0A		}=0A		reset_search();=0A		search();=
=0A	}=0A	function reset_search() {=0A		var el =3D document.querySelectorAll=
("#frames rect");=0A		for (var i =3D 0; i < el.length; i++) {=0A			orig_loa=
d(el[i], "fill")=0A		}=0A		var params =3D get_params();=0A		delete params.s=
;=0A		history.replaceState(null, null, parse_params(params));=0A	}=0A	funct=
ion search_prompt() {=0A		if (!searching) {=0A			var term =3D prompt("Enter=
 a search term (regexp " +=0A			    "allowed, eg: ^ext4_)"=0A			    + (igno=
recase ? ", ignoring case" : "")=0A			    + "\nPress Ctrl-i to toggle case =
sensitivity", "");=0A			if (term !=3D null) search(term);=0A		} else {=0A		=
	reset_search();=0A			searching =3D 0;=0A			currentSearchTerm =3D null;=0A	=
		searchbtn.classList.remove("show");=0A			searchbtn.firstChild.nodeValue =
=3D "Search"=0A			matchedtxt.classList.add("hide");=0A			matchedtxt.firstCh=
ild.nodeValue =3D ""=0A		}=0A	}=0A	function search(term) {=0A		if (term) cu=
rrentSearchTerm =3D term;=0A=0A		var re =3D new RegExp(currentSearchTerm, i=
gnorecase ? 'i' : '');=0A		var el =3D document.getElementById("frames").chi=
ldren;=0A		var matches =3D new Object();=0A		var maxwidth =3D 0;=0A		for (v=
ar i =3D 0; i < el.length; i++) {=0A			var e =3D el[i];=0A			var func =3D g=
_to_func(e);=0A			var rect =3D find_child(e, "rect");=0A			if (func =3D=3D =
null || rect =3D=3D null)=0A				continue;=0A=0A			// Save max width. Only w=
orks as we have a root frame=0A			var w =3D parseFloat(rect.attributes.widt=
h.value);=0A			if (w > maxwidth)=0A				maxwidth =3D w;=0A=0A			if (func.mat=
ch(re)) {=0A				// highlight=0A				var x =3D parseFloat(rect.attributes.x.v=
alue);=0A				orig_save(rect, "fill");=0A				rect.attributes.fill.value =3D =
"rgb(230,0,230)";=0A=0A				// remember matches=0A				if (matches[x] =3D=3D =
undefined) {=0A					matches[x] =3D w;=0A				} else {=0A					if (w > matches=
[x]) {=0A						// overwrite with parent=0A						matches[x] =3D w;=0A					}=
=0A				}=0A				searching =3D 1;=0A			}=0A		}=0A		if (!searching)=0A			retur=
n;=0A		var params =3D get_params();=0A		params.s =3D currentSearchTerm;=0A	=
	history.replaceState(null, null, parse_params(params));=0A=0A		searchbtn.c=
lassList.add("show");=0A		searchbtn.firstChild.nodeValue =3D "Reset Search"=
;=0A=0A		// calculate percent matched, excluding vertical overlap=0A		var c=
ount =3D 0;=0A		var lastx =3D -1;=0A		var lastw =3D 0;=0A		var keys =3D Arr=
ay();=0A		for (k in matches) {=0A			if (matches.hasOwnProperty(k))=0A				ke=
ys.push(k);=0A		}=0A		// sort the matched frames by their x location=0A		//=
 ascending, then width descending=0A		keys.sort(function(a, b){=0A			return=
 a - b;=0A		});=0A		// Step through frames saving only the biggest bottom-u=
p frames=0A		// thanks to the sort order. This relies on the tree property=
=0A		// where children are always smaller than their parents.=0A		var fudge=
 =3D 0.0001;	// JavaScript floating point=0A		for (var k in keys) {=0A			va=
r x =3D parseFloat(keys[k]);=0A			var w =3D matches[keys[k]];=0A			if (x >=
=3D lastx + lastw - fudge) {=0A				count +=3D w;=0A				lastx =3D x;=0A				l=
astw =3D w;=0A			}=0A		}=0A		// display matched percent=0A		matchedtxt.clas=
sList.remove("hide");=0A		var pct =3D 100 * count / maxwidth;=0A		if (pct !=
=3D 100) pct =3D pct.toFixed(1)=0A		matchedtxt.firstChild.nodeValue =3D "Ma=
tched: " + pct + "%";=0A	}=0A]]>=0A</script>=0A<rect x=3D"0.0" y=3D"0" widt=
h=3D"1200.0" height=3D"486.0" fill=3D"url(#background)"  />=0A<text id=3D"t=
itle" x=3D"600.00" y=3D"24" >Flame Graph</text>=0A<text id=3D"details" x=3D=
"10.00" y=3D"469" > </text>=0A<text id=3D"unzoom" x=3D"10.00" y=3D"24" clas=
s=3D"hide">Reset Zoom</text>=0A<text id=3D"search" x=3D"1090.00" y=3D"24" >=
Search</text>=0A<text id=3D"ignorecase" x=3D"1174.00" y=3D"24" >ic</text>=
=0A<text id=3D"matched" x=3D"1090.00" y=3D"469" > </text>=0A<g id=3D"frames=
">=0A<g >=0A<title>__check_heap_object (16,861,423,954 samples, 0.23%)</tit=
le><rect x=3D"771.0" y=3D"213" width=3D"2.7" height=3D"15.0" fill=3D"rgb(21=
5,164,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"774.01" y=3D"223.5" ></text>=
=0A</g>=0A<g >=0A<title>update_curr (4,694,758,855 samples, 0.06%)</title><=
rect x=3D"1138.8" y=3D"117" width=3D"0.7" height=3D"15.0" fill=3D"rgb(209,1=
39,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1141.78" y=3D"127.5" ></text>=0A=
</g>=0A<g >=0A<title>maybe_add_creds (13,086,081,124 samples, 0.18%)</title=
><rect x=3D"754.5" y=3D"245" width=3D"2.1" height=3D"15.0" fill=3D"rgb(243,=
58,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"757.52" y=3D"255.5" ></text>=0A<=
/g>=0A<g >=0A<title>obj_cgroup_charge (42,160,385,677 samples, 0.58%)</titl=
e><rect x=3D"1101.4" y=3D"181" width=3D"6.8" height=3D"15.0" fill=3D"rgb(24=
0,121,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1104.42" y=3D"191.5" ></text>=
=0A</g>=0A<g >=0A<title>sshd (687,632,307 samples, 0.01%)</title><rect x=3D=
"1189.5" y=3D"421" width=3D"0.1" height=3D"15.0" fill=3D"rgb(246,183,6)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1192.45" y=3D"431.5" ></text>=0A</g>=0A<g =
>=0A<title>get_obj_cgroup_from_current (62,772,232,714 samples, 0.86%)</tit=
le><rect x=3D"1029.6" y=3D"181" width=3D"10.2" height=3D"15.0" fill=3D"rgb(=
205,129,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1032.65" y=3D"191.5" ></text=
>=0A</g>=0A<g >=0A<title>update_curr (4,446,309,046 samples, 0.06%)</title>=
<rect x=3D"456.6" y=3D"165" width=3D"0.7" height=3D"15.0" fill=3D"rgb(216,8=
,6)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"459.60" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>ksize (8,062,612,641 samples, 0.11%)</title><rect x=3D"110=
8.5" y=3D"197" width=3D"1.3" height=3D"15.0" fill=3D"rgb(236,209,5)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"1111.45" y=3D"207.5" ></text>=0A</g>=0A<g >=0A=
<title>psi_group_change (12,175,620,945 samples, 0.17%)</title><rect x=3D"1=
132.3" y=3D"117" width=3D"2.0" height=3D"15.0" fill=3D"rgb(222,177,52)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1135.34" y=3D"127.5" ></text>=0A</g>=0A<g =
>=0A<title>__rcu_read_lock (1,740,641,125 samples, 0.02%)</title><rect x=3D=
"1038.2" y=3D"149" width=3D"0.3" height=3D"15.0" fill=3D"rgb(250,222,24)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"1041.24" y=3D"159.5" ></text>=0A</g>=0A<g=
 >=0A<title>update_load_avg (1,863,933,101 samples, 0.03%)</title><rect x=
=3D"357.0" y=3D"69" width=3D"0.3" height=3D"15.0" fill=3D"rgb(225,50,30)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"359.95" y=3D"79.5" ></text>=0A</g>=0A<g >=
=0A<title>__entry_text_start (64,617,294,217 samples, 0.89%)</title><rect x=
=3D"29.4" y=3D"357" width=3D"10.5" height=3D"15.0" fill=3D"rgb(220,213,37)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"32.43" y=3D"367.5" ></text>=0A</g>=0A<g=
 >=0A<title>memset_erms (55,457,136,938 samples, 0.76%)</title><rect x=3D"1=
092.5" y=3D"181" width=3D"8.9" height=3D"15.0" fill=3D"rgb(207,22,8)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1095.45" y=3D"191.5" ></text>=0A</g>=0A<g >=
=0A<title>try_charge_memcg (7,214,595,593 samples, 0.10%)</title><rect x=3D=
"989.6" y=3D"149" width=3D"1.2" height=3D"15.0" fill=3D"rgb(212,109,41)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"992.64" y=3D"159.5" ></text>=0A</g>=0A<g >=
=0A<title>dequeue_entity (2,841,778,158 samples, 0.04%)</title><rect x=3D"1=
111.0" y=3D"165" width=3D"0.4" height=3D"15.0" fill=3D"rgb(254,216,9)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1113.98" y=3D"175.5" ></text>=0A</g>=0A<g =
>=0A<title>__fdget_pos (53,513,180,835 samples, 0.73%)</title><rect x=3D"66=
3.0" y=3D"309" width=3D"8.6" height=3D"15.0" fill=3D"rgb(234,42,17)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"665.96" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<=
title>ttwu_queue_wakelist (1,639,654,855 samples, 0.02%)</title><rect x=3D"=
1143.4" y=3D"165" width=3D"0.3" height=3D"15.0" fill=3D"rgb(207,15,54)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1146.42" y=3D"175.5" ></text>=0A</g>=0A<g =
>=0A<title>cpuidle_enter_state (1,296,957,193 samples, 0.02%)</title><rect =
x=3D"1189.6" y=3D"325" width=3D"0.2" height=3D"15.0" fill=3D"rgb(220,27,18)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.60" y=3D"335.5" ></text>=0A</g>=
=0A<g >=0A<title>native_sched_clock (1,914,785,017 samples, 0.03%)</title><=
rect x=3D"470.5" y=3D"165" width=3D"0.3" height=3D"15.0" fill=3D"rgb(205,56=
,49)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"473.53" y=3D"175.5" ></text>=0A</g=
>=0A<g >=0A<title>update_load_avg (2,185,526,597 samples, 0.03%)</title><re=
ct x=3D"1111.9" y=3D"165" width=3D"0.3" height=3D"15.0" fill=3D"rgb(215,229=
,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1114.89" y=3D"175.5" ></text>=0A</g=
>=0A<g >=0A<title>sock_write_iter (3,021,519,057 samples, 0.04%)</title><re=
ct x=3D"1188.6" y=3D"325" width=3D"0.5" height=3D"15.0" fill=3D"rgb(253,220=
,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.60" y=3D"335.5" ></text>=0A</=
g>=0A<g >=0A<title>reweight_entity (1,549,444,087 samples, 0.02%)</title><r=
ect x=3D"356.6" y=3D"69" width=3D"0.2" height=3D"15.0" fill=3D"rgb(240,199,=
11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"359.57" y=3D"79.5" ></text>=0A</g>=
=0A<g >=0A<title>__wake_up_common (18,345,139,328 samples, 0.25%)</title><r=
ect x=3D"354.7" y=3D"149" width=3D"2.9" height=3D"15.0" fill=3D"rgb(213,40,=
46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"357.65" y=3D"159.5" ></text>=0A</g>=
=0A<g >=0A<title>update_min_vruntime (1,037,653,935 samples, 0.01%)</title>=
<rect x=3D"1137.6" y=3D"101" width=3D"0.1" height=3D"15.0" fill=3D"rgb(208,=
138,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1140.56" y=3D"111.5" ></text>=0A=
</g>=0A<g >=0A<title>__update_load_avg_se (1,049,821,593 samples, 0.01%)</t=
itle><rect x=3D"465.6" y=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(=
247,196,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"468.63" y=3D"159.5" ></text=
>=0A</g>=0A<g >=0A<title>__rcu_read_lock (10,309,415,100 samples, 0.14%)</t=
itle><rect x=3D"1122.1" y=3D"229" width=3D"1.7" height=3D"15.0" fill=3D"rgb=
(238,154,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1125.12" y=3D"239.5" ></te=
xt>=0A</g>=0A<g >=0A<title>switch_fpu_return (17,149,046,288 samples, 0.24%=
)</title><rect x=3D"606.8" y=3D"293" width=3D"2.8" height=3D"15.0" fill=3D"=
rgb(237,142,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"609.84" y=3D"303.5" ></=
text>=0A</g>=0A<g >=0A<title>__audit_syscall_entry (21,585,783,699 samples,=
 0.30%)</title><rect x=3D"1172.8" y=3D"309" width=3D"3.5" height=3D"15.0" f=
ill=3D"rgb(254,105,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1175.82" y=3D"31=
9.5" ></text>=0A</g>=0A<g >=0A<title>put_cpu_partial (728,048,512 samples, =
0.01%)</title><rect x=3D"1028.2" y=3D"149" width=3D"0.1" height=3D"15.0" fi=
ll=3D"rgb(213,6,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1031.15" y=3D"159.5"=
 ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (1,042,860,625 samples, =
0.01%)</title><rect x=3D"987.6" y=3D"149" width=3D"0.1" height=3D"15.0" fil=
l=3D"rgb(220,153,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"990.58" y=3D"159.5=
" ></text>=0A</g>=0A<g >=0A<title>check_preempt_curr (8,641,562,746 samples=
, 0.12%)</title><rect x=3D"1142.0" y=3D"149" width=3D"1.4" height=3D"15.0" =
fill=3D"rgb(250,190,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1145.03" y=3D"1=
59.5" ></text>=0A</g>=0A<g >=0A<title>__update_load_avg_cfs_rq (963,131,347=
 samples, 0.01%)</title><rect x=3D"1137.9" y=3D"101" width=3D"0.2" height=
=3D"15.0" fill=3D"rgb(242,87,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1140.9=
1" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__x86_indirect_thunk_rax (1,=
174,322,291 samples, 0.02%)</title><rect x=3D"631.2" y=3D"341" width=3D"0.2=
" height=3D"15.0" fill=3D"rgb(237,14,47)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"634.19" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>write (9,380,860,30=
8 samples, 0.13%)</title><rect x=3D"1187.9" y=3D"405" width=3D"1.5" height=
=3D"15.0" fill=3D"rgb(227,221,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1190.=
93" y=3D"415.5" ></text>=0A</g>=0A<g >=0A<title>psi_group_change (2,473,552=
,422 samples, 0.03%)</title><rect x=3D"355.4" y=3D"53" width=3D"0.4" height=
=3D"15.0" fill=3D"rgb(220,229,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"358.3=
6" y=3D"63.5" ></text>=0A</g>=0A<g >=0A<title>__update_load_avg_se (2,224,6=
46,882 samples, 0.03%)</title><rect x=3D"462.1" y=3D"165" width=3D"0.4" hei=
ght=3D"15.0" fill=3D"rgb(237,132,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"46=
5.13" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>refill_obj_stock (16,521,=
028,780 samples, 0.23%)</title><rect x=3D"444.3" y=3D"229" width=3D"2.7" he=
ight=3D"15.0" fill=3D"rgb(233,161,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"4=
47.32" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>mod_objcg_state (208,577=
,365,883 samples, 2.86%)</title><rect x=3D"1058.6" y=3D"165" width=3D"33.8"=
 height=3D"15.0" fill=3D"rgb(252,208,17)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1061.64" y=3D"175.5" >mo..</text>=0A</g>=0A<g >=0A<title>__get_user_8 (=
1,357,832,605 samples, 0.02%)</title><rect x=3D"1163.5" y=3D"277" width=3D"=
0.2" height=3D"15.0" fill=3D"rgb(252,132,25)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1166.46" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>sock_read_iter (=
3,079,422,260,394 samples, 42.21%)</title><rect x=3D"90.4" y=3D"293" width=
=3D"498.1" height=3D"15.0" fill=3D"rgb(234,136,27)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"93.40" y=3D"303.5" >sock_read_iter</text>=0A</g>=0A<g >=0A<titl=
e>rb_erase (820,846,950 samples, 0.01%)</title><rect x=3D"1112.7" y=3D"149"=
 width=3D"0.1" height=3D"15.0" fill=3D"rgb(238,65,1)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1115.66" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>try_to_=
wake_up (17,630,286,527 samples, 0.24%)</title><rect x=3D"354.8" y=3D"117" =
width=3D"2.8" height=3D"15.0" fill=3D"rgb(236,113,10)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"357.77" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>entry_SY=
SCALL_64_after_hwframe (3,259,932,661,302 samples, 44.69%)</title><rect x=
=3D"650.5" y=3D"357" width=3D"527.3" height=3D"15.0" fill=3D"rgb(219,9,43)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"653.46" y=3D"367.5" >entry_SYSCALL_64_a=
fter_hwframe</text>=0A</g>=0A<g >=0A<title>cmpxchg_double_slab.constprop.0.=
isra.0 (68,789,668,395 samples, 0.94%)</title><rect x=3D"164.5" y=3D"229" w=
idth=3D"11.1" height=3D"15.0" fill=3D"rgb(238,222,19)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"167.48" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_re=
ad_lock (127,841,157,368 samples, 1.75%)</title><rect x=3D"917.7" y=3D"149"=
 width=3D"20.7" height=3D"15.0" fill=3D"rgb(211,102,24)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"920.71" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>set_ne=
xt_entity (1,955,805,230 samples, 0.03%)</title><rect x=3D"1112.6" y=3D"165=
" width=3D"0.3" height=3D"15.0" fill=3D"rgb(215,22,49)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"1115.62" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>exit_t=
o_user_mode_prepare (75,007,118,961 samples, 1.03%)</title><rect x=3D"1153.=
1" y=3D"309" width=3D"12.1" height=3D"15.0" fill=3D"rgb(211,166,46)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"1156.07" y=3D"319.5" ></text>=0A</g>=0A<g >=0A=
<title>syscall_enter_from_user_mode (10,392,239,276 samples, 0.14%)</title>=
<rect x=3D"1149.4" y=3D"325" width=3D"1.7" height=3D"15.0" fill=3D"rgb(221,=
123,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1152.43" y=3D"335.5" ></text>=0A=
</g>=0A<g >=0A<title>sock_wfree (165,685,776,853 samples, 2.27%)</title><re=
ct x=3D"330.8" y=3D"197" width=3D"26.8" height=3D"15.0" fill=3D"rgb(206,222=
,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"333.83" y=3D"207.5" >s..</text>=0A=
</g>=0A<g >=0A<title>__rcu_read_lock (8,043,659,547 samples, 0.11%)</title>=
<rect x=3D"353.3" y=3D"165" width=3D"1.3" height=3D"15.0" fill=3D"rgb(248,1=
03,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"356.34" y=3D"175.5" ></text>=0A<=
/g>=0A<g >=0A<title>obj_cgroup_uncharge (1,143,205,773 samples, 0.02%)</tit=
le><rect x=3D"442.1" y=3D"229" width=3D"0.1" height=3D"15.0" fill=3D"rgb(23=
5,70,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"445.05" y=3D"239.5" ></text>=
=0A</g>=0A<g >=0A<title>skb_set_owner_w (26,610,757,412 samples, 0.36%)</ti=
tle><rect x=3D"1114.0" y=3D"229" width=3D"4.3" height=3D"15.0" fill=3D"rgb(=
220,218,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1116.98" y=3D"239.5" ></tex=
t>=0A</g>=0A<g >=0A<title>memset_erms (131,674,517,735 samples, 1.80%)</tit=
le><rect x=3D"960.2" y=3D"165" width=3D"21.3" height=3D"15.0" fill=3D"rgb(2=
41,212,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"963.22" y=3D"175.5" >m..</te=
xt>=0A</g>=0A<g >=0A<title>memcg_slab_post_alloc_hook (325,048,926,821 samp=
les, 4.46%)</title><rect x=3D"1039.8" y=3D"181" width=3D"52.6" height=3D"15=
=2E0" fill=3D"rgb(210,152,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1042.80" =
y=3D"191.5" >memcg..</text>=0A</g>=0A<g >=0A<title>update_cfs_group (5,338,=
344,381 samples, 0.07%)</title><rect x=3D"460.3" y=3D"181" width=3D"0.9" he=
ight=3D"15.0" fill=3D"rgb(246,81,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"46=
3.33" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>load_new_mm_cr3 (6,246,72=
2,828 samples, 0.09%)</title><rect x=3D"1185.6" y=3D"213" width=3D"1.0" hei=
ght=3D"15.0" fill=3D"rgb(233,99,52)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"118=
8.56" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>memcg_slab_post_alloc_hoo=
k (476,112,917,974 samples, 6.53%)</title><rect x=3D"883.2" y=3D"165" width=
=3D"77.0" height=3D"15.0" fill=3D"rgb(219,86,5)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"886.18" y=3D"175.5" >memcg_sl..</text>=0A</g>=0A<g >=0A<title>rw_v=
erify_area (1,638,208,155 samples, 0.02%)</title><rect x=3D"695.2" y=3D"293=
" width=3D"0.2" height=3D"15.0" fill=3D"rgb(237,206,16)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"698.16" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>update=
_min_vruntime (769,722,758 samples, 0.01%)</title><rect x=3D"457.2" y=3D"14=
9" width=3D"0.1" height=3D"15.0" fill=3D"rgb(228,132,12)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"460.20" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__loc=
k_text_start (2,781,347,198 samples, 0.04%)</title><rect x=3D"1127.2" y=3D"=
165" width=3D"0.5" height=3D"15.0" fill=3D"rgb(233,219,6)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"1130.24" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__c=
heck_object_size (266,825,826,705 samples, 3.66%)</title><rect x=3D"545.3" =
y=3D"181" width=3D"43.2" height=3D"15.0" fill=3D"rgb(242,109,28)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"548.34" y=3D"191.5" >__ch..</text>=0A</g>=0A<g >=
=0A<title>_raw_spin_unlock_irqrestore (9,215,836,296 samples, 0.13%)</title=
><rect x=3D"753.0" y=3D"245" width=3D"1.5" height=3D"15.0" fill=3D"rgb(236,=
14,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"755.98" y=3D"255.5" ></text>=0A<=
/g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (15,241,732,400 sample=
s, 0.21%)</title><rect x=3D"1127.8" y=3D"149" width=3D"2.4" height=3D"15.0"=
 fill=3D"rgb(220,67,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1130.75" y=3D"15=
9.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (4,403,112,150 sampl=
es, 0.06%)</title><rect x=3D"745.5" y=3D"245" width=3D"0.8" height=3D"15.0"=
 fill=3D"rgb(206,113,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"748.55" y=3D"2=
55.5" ></text>=0A</g>=0A<g >=0A<title>should_failslab (1,321,502,383 sample=
s, 0.02%)</title><rect x=3D"1108.2" y=3D"181" width=3D"0.3" height=3D"15.0"=
 fill=3D"rgb(253,196,52)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1111.24" y=3D"=
191.5" ></text>=0A</g>=0A<g >=0A<title>kmem_cache_free (548,281,074,281 sam=
ples, 7.52%)</title><rect x=3D"358.3" y=3D"245" width=3D"88.7" height=3D"15=
=2E0" fill=3D"rgb(234,145,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"361.31" y=
=3D"255.5" >kmem_cache..</text>=0A</g>=0A<g >=0A<title>do_syscall_64 (3,547=
,493,575,945 samples, 48.63%)</title><rect x=3D"48.7" y=3D"341" width=3D"57=
3.8" height=3D"15.0" fill=3D"rgb(224,76,9)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"51.68" y=3D"351.5" >do_syscall_64</text>=0A</g>=0A<g >=0A<title>__switc=
h_to_asm (2,189,752,844 samples, 0.03%)</title><rect x=3D"1188.2" y=3D"389"=
 width=3D"0.3" height=3D"15.0" fill=3D"rgb(217,133,43)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"1191.18" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>memcg_=
account_kmem (11,709,417,993 samples, 0.16%)</title><rect x=3D"262.2" y=3D"=
181" width=3D"1.9" height=3D"15.0" fill=3D"rgb(243,176,29)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"265.23" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>ksy=
s_write (3,021,519,057 samples, 0.04%)</title><rect x=3D"1188.6" y=3D"357" =
width=3D"0.5" height=3D"15.0" fill=3D"rgb(206,15,8)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1191.60" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>__kmem_=
cache_alloc_node (928,597,945,540 samples, 12.73%)</title><rect x=3D"840.8"=
 y=3D"181" width=3D"150.2" height=3D"15.0" fill=3D"rgb(214,142,18)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"843.81" y=3D"191.5" >__kmem_cache_alloc_..</tex=
t>=0A</g>=0A<g >=0A<title>scm_recv.constprop.0 (16,033,273,336 samples, 0.2=
2%)</title><rect x=3D"470.9" y=3D"245" width=3D"2.6" height=3D"15.0" fill=
=3D"rgb(246,201,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"473.88" y=3D"255.5"=
 ></text>=0A</g>=0A<g >=0A<title>fsnotify_perm (2,061,754,738 samples, 0.03=
%)</title><rect x=3D"694.8" y=3D"293" width=3D"0.4" height=3D"15.0" fill=3D=
"rgb(230,179,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"697.83" y=3D"303.5" ><=
/text>=0A</g>=0A<g >=0A<title>newidle_balance (1,373,218,014 samples, 0.02%=
)</title><rect x=3D"463.9" y=3D"181" width=3D"0.2" height=3D"15.0" fill=3D"=
rgb(227,22,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"466.93" y=3D"191.5" ></t=
ext>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (4,415,746,098=
 samples, 0.06%)</title><rect x=3D"454.6" y=3D"181" width=3D"0.7" height=3D=
"15.0" fill=3D"rgb(244,174,35)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"457.57" =
y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (1,145,813,124 =
samples, 0.02%)</title><rect x=3D"440.7" y=3D"213" width=3D"0.2" height=3D"=
15.0" fill=3D"rgb(219,9,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"443.67" y=
=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>dequeue_task_fair (8,959,962,497=
 samples, 0.12%)</title><rect x=3D"1110.8" y=3D"181" width=3D"1.4" height=
=3D"15.0" fill=3D"rgb(242,129,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1113.7=
9" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_state (2,767,718=
,220 samples, 0.04%)</title><rect x=3D"263.7" y=3D"149" width=3D"0.4" heigh=
t=3D"15.0" fill=3D"rgb(216,90,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"266.6=
6" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>schedule (114,501,029,147 sa=
mples, 1.57%)</title><rect x=3D"452.4" y=3D"229" width=3D"18.5" height=3D"1=
5.0" fill=3D"rgb(223,57,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"455.36" y=3D=
"239.5" ></text>=0A</g>=0A<g >=0A<title>psi_group_change (15,540,593,142 sa=
mples, 0.21%)</title><rect x=3D"466.4" y=3D"181" width=3D"2.5" height=3D"15=
=2E0" fill=3D"rgb(219,175,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"469.37" y=
=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>fsnotify_perm (21,673,835,404 sa=
mples, 0.30%)</title><rect x=3D"81.0" y=3D"293" width=3D"3.5" height=3D"15.=
0" fill=3D"rgb(211,214,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"84.02" y=3D"3=
03.5" ></text>=0A</g>=0A<g >=0A<title>__schedule (1,040,414,087 samples, 0.=
01%)</title><rect x=3D"1189.1" y=3D"309" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(208,65,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.09" y=3D"319.5"=
 ></text>=0A</g>=0A<g >=0A<title>reweight_entity (1,329,143,446 samples, 0.=
02%)</title><rect x=3D"1111.4" y=3D"165" width=3D"0.3" height=3D"15.0" fill=
=3D"rgb(245,27,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1114.44" y=3D"175.5"=
 ></text>=0A</g>=0A<g >=0A<title>__schedule (2,975,706,668 samples, 0.04%)<=
/title><rect x=3D"1188.6" y=3D"229" width=3D"0.5" height=3D"15.0" fill=3D"r=
gb(206,102,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.60" y=3D"239.5" ></=
text>=0A</g>=0A<g >=0A<title>__list_del_entry_valid (15,994,004,065 samples=
, 0.22%)</title><rect x=3D"1019.2" y=3D"149" width=3D"2.6" height=3D"15.0" =
fill=3D"rgb(241,31,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1022.23" y=3D"15=
9.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_read_generic (2,915,709,81=
5,523 samples, 39.97%)</title><rect x=3D"116.9" y=3D"261" width=3D"471.6" h=
eight=3D"15.0" fill=3D"rgb(216,32,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
9.88" y=3D"271.5" >unix_stream_read_generic</text>=0A</g>=0A<g >=0A<title>p=
age_counter_try_charge (1,001,848,366 samples, 0.01%)</title><rect x=3D"990=
=2E6" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(247,68,47)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"993.63" y=3D"143.5" ></text>=0A</g>=0A<g >=0A=
<title>bpf_lsm_file_permission (11,433,499,688 samples, 0.16%)</title><rect=
 x=3D"699.1" y=3D"277" width=3D"1.9" height=3D"15.0" fill=3D"rgb(207,19,8)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"702.14" y=3D"287.5" ></text>=0A</g>=0A<=
g >=0A<title>syscall_enter_from_user_mode (10,041,067,127 samples, 0.14%)</=
title><rect x=3D"588.5" y=3D"325" width=3D"1.6" height=3D"15.0" fill=3D"rgb=
(211,98,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"591.49" y=3D"335.5" ></text=
>=0A</g>=0A<g >=0A<title>syscall_exit_to_user_mode (1,410,694,833 samples, =
0.02%)</title><rect x=3D"1186.6" y=3D"357" width=3D"0.2" height=3D"15.0" fi=
ll=3D"rgb(251,76,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1189.57" y=3D"367.=
5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_state (3,696,015,081 samples=
, 0.05%)</title><rect x=3D"988.4" y=3D"117" width=3D"0.6" height=3D"15.0" f=
ill=3D"rgb(218,26,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"991.36" y=3D"127.=
5" ></text>=0A</g>=0A<g >=0A<title>acpi_idle_enter (667,543,974 samples, 0.=
01%)</title><rect x=3D"1189.6" y=3D"309" width=3D"0.1" height=3D"15.0" fill=
=3D"rgb(240,42,17)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.60" y=3D"319.5"=
 ></text>=0A</g>=0A<g >=0A<title>update_curr (3,732,313,540 samples, 0.05%)=
</title><rect x=3D"1137.1" y=3D"117" width=3D"0.6" height=3D"15.0" fill=3D"=
rgb(226,86,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1140.13" y=3D"127.5" ></=
text>=0A</g>=0A<g >=0A<title>__update_load_avg_se (2,462,621,787 samples, 0=
=2E03%)</title><rect x=3D"1141.5" y=3D"117" width=3D"0.4" height=3D"15.0" f=
ill=3D"rgb(222,44,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1144.51" y=3D"127=
=2E5" ></text>=0A</g>=0A<g >=0A<title>__x64_sys_read (17,863,211,331 sample=
s, 0.24%)</title><rect x=3D"51.4" y=3D"325" width=3D"2.9" height=3D"15.0" f=
ill=3D"rgb(254,136,32)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"54.42" y=3D"335.=
5" ></text>=0A</g>=0A<g >=0A<title>__schedule (111,998,030,732 samples, 1.5=
4%)</title><rect x=3D"452.8" y=3D"213" width=3D"18.1" height=3D"15.0" fill=
=3D"rgb(206,175,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"455.76" y=3D"223.5"=
 ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (3,403,563,157 samples, =
0.05%)</title><rect x=3D"875.9" y=3D"165" width=3D"0.5" height=3D"15.0" fil=
l=3D"rgb(223,13,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"878.86" y=3D"175.5"=
 ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_state (1,181,000,326 samples, =
0.02%)</title><rect x=3D"1107.0" y=3D"133" width=3D"0.2" height=3D"15.0" fi=
ll=3D"rgb(210,19,32)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1110.04" y=3D"143.=
5" ></text>=0A</g>=0A<g >=0A<title>mem_cgroup_handle_over_high (1,181,647,0=
38 samples, 0.02%)</title><rect x=3D"604.7" y=3D"293" width=3D"0.2" height=
=3D"15.0" fill=3D"rgb(207,5,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"607.69"=
 y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>[hackbench] (81,838,224,411 sa=
mples, 1.12%)</title><rect x=3D"10.0" y=3D"373" width=3D"13.3" height=3D"15=
=2E0" fill=3D"rgb(224,40,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"13.01" y=
=3D"383.5" ></text>=0A</g>=0A<g >=0A<title>__lock_text_start (22,158,862,17=
4 samples, 0.30%)</title><rect x=3D"478.7" y=3D"229" width=3D"3.6" height=
=3D"15.0" fill=3D"rgb(230,172,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"481.7=
4" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__lock_text_start (9,513,487=
,603 samples, 0.13%)</title><rect x=3D"1123.9" y=3D"213" width=3D"1.6" heig=
ht=3D"15.0" fill=3D"rgb(205,65,46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1126=
=2E94" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>security_file_permission=
 (32,918,061,087 samples, 0.45%)</title><rect x=3D"85.1" y=3D"293" width=3D=
"5.3" height=3D"15.0" fill=3D"rgb(246,174,19)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"88.08" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>read (3,760,212,0=
21,927 samples, 51.54%)</title><rect x=3D"23.3" y=3D"373" width=3D"608.2" h=
eight=3D"15.0" fill=3D"rgb(224,89,44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"2=
6.26" y=3D"383.5" >read</text>=0A</g>=0A<g >=0A<title>__wrgsbase_inactive (=
2,045,259,522 samples, 0.03%)</title><rect x=3D"1184.9" y=3D"389" width=3D"=
0.3" height=3D"15.0" fill=3D"rgb(222,177,3)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"1187.86" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>entry_SYSCALL_64_=
after_hwframe (4,061,933,144 samples, 0.06%)</title><rect x=3D"1188.6" y=3D=
"389" width=3D"0.7" height=3D"15.0" fill=3D"rgb(211,206,4)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"1191.60" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>mo=
d_memcg_lruvec_state (8,141,011,600 samples, 0.11%)</title><rect x=3D"259.2=
" y=3D"181" width=3D"1.4" height=3D"15.0" fill=3D"rgb(242,70,30)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"262.25" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<tit=
le>sched_clock_cpu (2,093,827,353 samples, 0.03%)</title><rect x=3D"470.5" =
y=3D"181" width=3D"0.3" height=3D"15.0" fill=3D"rgb(225,38,8)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"473.50" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title=
>read (28,533,098,271 samples, 0.39%)</title><rect x=3D"1183.3" y=3D"405" w=
idth=3D"4.6" height=3D"15.0" fill=3D"rgb(251,66,44)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1186.31" y=3D"415.5" ></text>=0A</g>=0A<g >=0A<title>__x86_i=
ndirect_thunk_rax (1,051,087,917 samples, 0.01%)</title><rect x=3D"762.1" y=
=3D"213" width=3D"0.1" height=3D"15.0" fill=3D"rgb(214,86,50)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"765.06" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title=
>enqueue_task (15,863,595,673 samples, 0.22%)</title><rect x=3D"1131.9" y=
=3D"149" width=3D"2.6" height=3D"15.0" fill=3D"rgb(209,5,7)" rx=3D"2" ry=3D=
"2" />=0A<text  x=3D"1134.91" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>d=
equeue_entity (12,300,185,646 samples, 0.17%)</title><rect x=3D"456.1" y=3D=
"181" width=3D"2.0" height=3D"15.0" fill=3D"rgb(227,47,9)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"459.07" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>mute=
x_unlock (7,249,446,313 samples, 0.10%)</title><rect x=3D"449.6" y=3D"245" =
width=3D"1.2" height=3D"15.0" fill=3D"rgb(252,20,52)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"452.61" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_re=
ad_unlock (1,283,972,774 samples, 0.02%)</title><rect x=3D"1038.5" y=3D"149=
" width=3D"0.2" height=3D"15.0" fill=3D"rgb(246,166,50)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"1041.52" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__kme=
m_cache_free (384,301,711,548 samples, 5.27%)</title><rect x=3D"205.8" y=3D=
"213" width=3D"62.1" height=3D"15.0" fill=3D"rgb(254,77,24)" rx=3D"2" ry=3D=
"2" />=0A<text  x=3D"208.76" y=3D"223.5" >__kmem..</text>=0A</g>=0A<g >=0A<=
title>wait_for_unix_gc (21,743,875,658 samples, 0.30%)</title><rect x=3D"11=
45.9" y=3D"245" width=3D"3.5" height=3D"15.0" fill=3D"rgb(254,98,14)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1148.91" y=3D"255.5" ></text>=0A</g>=0A<g >=
=0A<title>audit_reset_context (5,054,694,554 samples, 0.07%)</title><rect x=
=3D"614.6" y=3D"293" width=3D"0.9" height=3D"15.0" fill=3D"rgb(234,22,26)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"617.64" y=3D"303.5" ></text>=0A</g>=0A<g=
 >=0A<title>start_secondary (2,535,483,173 samples, 0.03%)</title><rect x=
=3D"1189.6" y=3D"389" width=3D"0.4" height=3D"15.0" fill=3D"rgb(236,122,39)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.58" y=3D"399.5" ></text>=0A</g>=
=0A<g >=0A<title>ksys_read (3,302,566,162,927 samples, 45.27%)</title><rect=
 x=3D"54.3" y=3D"325" width=3D"534.2" height=3D"15.0" fill=3D"rgb(242,182,6=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"57.31" y=3D"335.5" >ksys_read</text>=
=0A</g>=0A<g >=0A<title>psi_task_switch (20,112,032,078 samples, 0.28%)</ti=
tle><rect x=3D"465.9" y=3D"197" width=3D"3.2" height=3D"15.0" fill=3D"rgb(2=
29,7,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"468.89" y=3D"207.5" ></text>=
=0A</g>=0A<g >=0A<title>__x86_indirect_thunk_rax (1,364,289,293 samples, 0.=
02%)</title><rect x=3D"1183.1" y=3D"341" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(206,165,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1186.06" y=3D"351.5=
" ></text>=0A</g>=0A<g >=0A<title>psi_task_switch (4,024,479,491 samples, 0=
=2E06%)</title><rect x=3D"1113.0" y=3D"181" width=3D"0.6" height=3D"15.0" f=
ill=3D"rgb(233,180,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1115.97" y=3D"19=
1.5" ></text>=0A</g>=0A<g >=0A<title>mod_objcg_state (53,771,828,699 sample=
s, 0.74%)</title><rect x=3D"251.9" y=3D"197" width=3D"8.7" height=3D"15.0" =
fill=3D"rgb(221,192,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"254.87" y=3D"20=
7.5" ></text>=0A</g>=0A<g >=0A<title>try_charge_memcg (3,602,033,840 sample=
s, 0.05%)</title><rect x=3D"1107.7" y=3D"165" width=3D"0.5" height=3D"15.0"=
 fill=3D"rgb(225,91,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1110.66" y=3D"1=
75.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock (5,007,633,672 samples=
, 0.07%)</title><rect x=3D"454.5" y=3D"197" width=3D"0.8" height=3D"15.0" f=
ill=3D"rgb(254,130,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"457.48" y=3D"207=
=2E5" ></text>=0A</g>=0A<g >=0A<title>___slab_alloc (119,882,646,733 sample=
s, 1.64%)</title><rect x=3D"1008.9" y=3D"181" width=3D"19.4" height=3D"15.0=
" fill=3D"rgb(241,202,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1011.88" y=3D=
"191.5" ></text>=0A</g>=0A<g >=0A<title>unix_passcred_enabled (9,995,563,23=
0 samples, 0.14%)</title><rect x=3D"755.0" y=3D"229" width=3D"1.6" height=
=3D"15.0" fill=3D"rgb(216,161,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"758.0=
2" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__update_load_avg_se (1,900,=
126,136 samples, 0.03%)</title><rect x=3D"457.7" y=3D"149" width=3D"0.3" he=
ight=3D"15.0" fill=3D"rgb(213,90,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"46=
0.74" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>enqueue_task_fair (9,029,=
578,220 samples, 0.12%)</title><rect x=3D"355.8" y=3D"85" width=3D"1.5" hei=
ght=3D"15.0" fill=3D"rgb(242,2,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"358.=
79" y=3D"95.5" ></text>=0A</g>=0A<g >=0A<title>pick_next_task_fair (4,183,0=
95,199 samples, 0.06%)</title><rect x=3D"1112.3" y=3D"181" width=3D"0.7" he=
ight=3D"15.0" fill=3D"rgb(223,201,17)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1=
115.30" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>update_load_avg (722,07=
4,741 samples, 0.01%)</title><rect x=3D"1112.8" y=3D"149" width=3D"0.1" hei=
ght=3D"15.0" fill=3D"rgb(241,123,26)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
15.82" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__update_load_avg_cfs_rq=
 (687,109,052 samples, 0.01%)</title><rect x=3D"1112.0" y=3D"149" width=3D"=
0.1" height=3D"15.0" fill=3D"rgb(237,142,35)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1115.03" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>exit_to_user_mod=
e_prepare (107,688,408,210 samples, 1.48%)</title><rect x=3D"592.2" y=3D"30=
9" width=3D"17.4" height=3D"15.0" fill=3D"rgb(240,35,54)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"595.20" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>nativ=
e_load_tls (672,664,874 samples, 0.01%)</title><rect x=3D"1186.8" y=3D"389"=
 width=3D"0.1" height=3D"15.0" fill=3D"rgb(245,172,52)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"1189.80" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>psi_ta=
sk_switch (819,796,543 samples, 0.01%)</title><rect x=3D"606.6" y=3D"261" w=
idth=3D"0.1" height=3D"15.0" fill=3D"rgb(240,173,47)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"609.58" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>update_c=
urr (958,630,675 samples, 0.01%)</title><rect x=3D"356.7" y=3D"53" width=3D=
"0.1" height=3D"15.0" fill=3D"rgb(230,146,39)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"359.66" y=3D"63.5" ></text>=0A</g>=0A<g >=0A<title>schedule_timeout =
(23,994,532,021 samples, 0.33%)</title><rect x=3D"1110.1" y=3D"229" width=
=3D"3.9" height=3D"15.0" fill=3D"rgb(249,181,1)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1113.10" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>security_sock=
et_sendmsg (33,535,704,218 samples, 0.46%)</title><rect x=3D"720.9" y=3D"26=
1" width=3D"5.5" height=3D"15.0" fill=3D"rgb(208,16,11)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"723.94" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>update=
_curr (3,545,017,159 samples, 0.05%)</title><rect x=3D"458.7" y=3D"165" wid=
th=3D"0.6" height=3D"15.0" fill=3D"rgb(212,64,51)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"461.69" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__fget_light=
 (35,315,146,510 samples, 0.48%)</title><rect x=3D"58.1" y=3D"293" width=3D=
"5.7" height=3D"15.0" fill=3D"rgb(207,42,44)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"61.12" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>kfence_ksize (2,28=
7,143,012 samples, 0.03%)</title><rect x=3D"1109.4" y=3D"181" width=3D"0.4"=
 height=3D"15.0" fill=3D"rgb(252,136,52)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1112.39" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>ktime_get_coarse_r=
eal_ts64 (8,908,539,205 samples, 0.12%)</title><rect x=3D"1176.3" y=3D"309"=
 width=3D"1.5" height=3D"15.0" fill=3D"rgb(251,168,32)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"1179.31" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>__lock=
_text_start (46,307,590,815 samples, 0.63%)</title><rect x=3D"178.8" y=3D"2=
29" width=3D"7.5" height=3D"15.0" fill=3D"rgb(253,165,0)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"181.82" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>switc=
h_mm_irqs_off (1,140,338,165 samples, 0.02%)</title><rect x=3D"1186.6" y=3D=
"293" width=3D"0.2" height=3D"15.0" fill=3D"rgb(228,16,42)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"1189.62" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>_r=
aw_spin_unlock (1,874,227,211 samples, 0.03%)</title><rect x=3D"752.7" y=3D=
"245" width=3D"0.3" height=3D"15.0" fill=3D"rgb(238,13,14)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"755.68" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>upd=
ate_load_avg (8,231,325,455 samples, 0.11%)</title><rect x=3D"461.2" y=3D"1=
81" width=3D"1.3" height=3D"15.0" fill=3D"rgb(244,73,18)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"464.20" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>do_sy=
scall_64 (3,239,267,618,881 samples, 44.40%)</title><rect x=3D"653.8" y=3D"=
341" width=3D"524.0" height=3D"15.0" fill=3D"rgb(217,202,15)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"656.81" y=3D"351.5" >do_syscall_64</text>=0A</g>=0A=
<g >=0A<title>ksys_write (3,026,080,815,113 samples, 41.48%)</title><rect x=
=3D"660.0" y=3D"325" width=3D"489.4" height=3D"15.0" fill=3D"rgb(234,97,0)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"662.97" y=3D"335.5" >ksys_write</text>=
=0A</g>=0A<g >=0A<title>poll_idle (629,413,219 samples, 0.01%)</title><rect=
 x=3D"1189.7" y=3D"309" width=3D"0.1" height=3D"15.0" fill=3D"rgb(206,179,2=
2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.70" y=3D"319.5" ></text>=0A</g>=
=0A<g >=0A<title>schedule (2,975,706,668 samples, 0.04%)</title><rect x=3D"=
1188.6" y=3D"245" width=3D"0.5" height=3D"15.0" fill=3D"rgb(242,41,4)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1191.60" y=3D"255.5" ></text>=0A</g>=0A<g =
>=0A<title>update_min_vruntime (865,234,962 samples, 0.01%)</title><rect x=
=3D"459.1" y=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(218,182,12)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"462.12" y=3D"159.5" ></text>=0A</g>=0A<=
g >=0A<title>refill_stock (1,922,769,859 samples, 0.03%)</title><rect x=3D"=
444.0" y=3D"213" width=3D"0.3" height=3D"15.0" fill=3D"rgb(234,70,17)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"447.01" y=3D"223.5" ></text>=0A</g>=0A<g >=
=0A<title>__cond_resched (3,566,202,587 samples, 0.05%)</title><rect x=3D"4=
49.0" y=3D"229" width=3D"0.6" height=3D"15.0" fill=3D"rgb(207,62,48)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"452.04" y=3D"239.5" ></text>=0A</g>=0A<g >=0A=
<title>write (3,411,586,774,784 samples, 46.76%)</title><rect x=3D"631.5" y=
=3D"373" width=3D"551.8" height=3D"15.0" fill=3D"rgb(219,90,49)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"634.46" y=3D"383.5" >write</text>=0A</g>=0A<g >=0A=
<title>__get_user_8 (7,610,870,232 samples, 0.10%)</title><rect x=3D"603.1"=
 y=3D"277" width=3D"1.2" height=3D"15.0" fill=3D"rgb(209,107,46)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"606.06" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<tit=
le>sock_def_readable (170,810,244,477 samples, 2.34%)</title><rect x=3D"111=
8.3" y=3D"245" width=3D"27.6" height=3D"15.0" fill=3D"rgb(216,25,7)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"1121.28" y=3D"255.5" >s..</text>=0A</g>=0A<g >=
=0A<title>__lock_text_start (1,971,861,323 samples, 0.03%)</title><rect x=
=3D"451.1" y=3D"229" width=3D"0.3" height=3D"15.0" fill=3D"rgb(230,171,40)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"454.10" y=3D"239.5" ></text>=0A</g>=0A<=
g >=0A<title>acpi_idle_do_entry (667,543,974 samples, 0.01%)</title><rect x=
=3D"1189.6" y=3D"293" width=3D"0.1" height=3D"15.0" fill=3D"rgb(226,90,53)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.60" y=3D"303.5" ></text>=0A</g>=0A=
<g >=0A<title>refill_obj_stock (2,653,792,801 samples, 0.04%)</title><rect =
x=3D"1107.2" y=3D"165" width=3D"0.5" height=3D"15.0" fill=3D"rgb(211,228,28=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1110.23" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>switch_mm_irqs_off (951,220,692 samples, 0.01%)</title><re=
ct x=3D"1189.1" y=3D"293" width=3D"0.2" height=3D"15.0" fill=3D"rgb(208,19,=
31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.10" y=3D"303.5" ></text>=0A</g=
>=0A<g >=0A<title>__list_add_valid (4,524,003,769 samples, 0.06%)</title><r=
ect x=3D"301.8" y=3D"197" width=3D"0.7" height=3D"15.0" fill=3D"rgb(242,53,=
15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"304.80" y=3D"207.5" ></text>=0A</g>=
=0A<g >=0A<title>is_vmalloc_addr (6,989,094,206 samples, 0.10%)</title><rec=
t x=3D"587.4" y=3D"165" width=3D"1.1" height=3D"15.0" fill=3D"rgb(232,149,3=
2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"590.36" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>enqueue_task (3,289,811,520 samples, 0.05%)</title><rect x=
=3D"355.3" y=3D"85" width=3D"0.5" height=3D"15.0" fill=3D"rgb(211,68,9)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"358.26" y=3D"95.5" ></text>=0A</g>=0A<g >=
=0A<title>__update_load_avg_cfs_rq (2,305,269,031 samples, 0.03%)</title><r=
ect x=3D"1141.1" y=3D"117" width=3D"0.4" height=3D"15.0" fill=3D"rgb(235,15=
8,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1144.14" y=3D"127.5" ></text>=0A<=
/g>=0A<g >=0A<title>psi_task_change (3,066,330,737 samples, 0.04%)</title><=
rect x=3D"355.3" y=3D"69" width=3D"0.5" height=3D"15.0" fill=3D"rgb(253,21,=
5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"358.30" y=3D"79.5" ></text>=0A</g>=
=0A<g >=0A<title>unix_destruct_scm (266,578,259,705 samples, 3.65%)</title>=
<rect x=3D"314.5" y=3D"213" width=3D"43.1" height=3D"15.0" fill=3D"rgb(220,=
175,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"317.51" y=3D"223.5" >unix..</tex=
t>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpath (8,154,619,282 s=
amples, 0.11%)</title><rect x=3D"1124.2" y=3D"197" width=3D"1.3" height=3D"=
15.0" fill=3D"rgb(244,140,36)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1127.16" =
y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>__x86_indirect_thunk_rax (3,834=
,275,606 samples, 0.05%)</title><rect x=3D"624.2" y=3D"341" width=3D"0.6" h=
eight=3D"15.0" fill=3D"rgb(247,134,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"6=
27.16" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>pick_next_entity (3,547,=
914,211 samples, 0.05%)</title><rect x=3D"464.1" y=3D"181" width=3D"0.6" he=
ight=3D"15.0" fill=3D"rgb(226,116,6)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"46=
7.15" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>mod_memcg_lruvec_state (4=
,603,060,043 samples, 0.06%)</title><rect x=3D"1091.6" y=3D"149" width=3D"0=
=2E8" height=3D"15.0" fill=3D"rgb(235,15,41)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1094.63" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>set_next_entity =
(1,045,954,378 samples, 0.01%)</title><rect x=3D"606.4" y=3D"245" width=3D"=
0.1" height=3D"15.0" fill=3D"rgb(227,36,8)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"609.38" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>unix_destruct_scm (=
24,775,548,111 samples, 0.34%)</title><rect x=3D"627.2" y=3D"357" width=3D"=
4.0" height=3D"15.0" fill=3D"rgb(247,49,39)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"630.17" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>prepare_to_wait (3=
,887,066,856 samples, 0.05%)</title><rect x=3D"450.8" y=3D"245" width=3D"0.=
6" height=3D"15.0" fill=3D"rgb(214,202,31)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"453.79" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_sendmsg=
 (1,364,289,293 samples, 0.02%)</title><rect x=3D"1183.1" y=3D"357" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(223,7,12)" rx=3D"2" ry=3D"2" />=0A<tex=
t  x=3D"1186.06" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_loc=
k (14,198,390,969 samples, 0.19%)</title><rect x=3D"1055.5" y=3D"165" width=
=3D"2.3" height=3D"15.0" fill=3D"rgb(210,96,21)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1058.50" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>psi_task_chan=
ge (14,815,718,423 samples, 0.20%)</title><rect x=3D"1132.1" y=3D"133" widt=
h=3D"2.4" height=3D"15.0" fill=3D"rgb(246,2,42)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1135.08" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__fdget_pos (=
38,914,632,341 samples, 0.53%)</title><rect x=3D"57.5" y=3D"309" width=3D"6=
=2E3" height=3D"15.0" fill=3D"rgb(251,200,48)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"60.54" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>__get_task_ioprio=
 (17,863,928,319 samples, 0.24%)</title><rect x=3D"78.1" y=3D"293" width=3D=
"2.9" height=3D"15.0" fill=3D"rgb(253,74,16)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"81.10" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>asm_sysvec_call_fu=
nction_single (629,291,869 samples, 0.01%)</title><rect x=3D"462.8" y=3D"18=
1" width=3D"0.1" height=3D"15.0" fill=3D"rgb(235,190,8)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"465.84" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>cmpxch=
g_double_slab.constprop.0.isra.0 (48,789,927,013 samples, 0.67%)</title><re=
ct x=3D"291.7" y=3D"197" width=3D"7.9" height=3D"15.0" fill=3D"rgb(215,146,=
13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"294.66" y=3D"207.5" ></text>=0A</g>=
=0A<g >=0A<title>put_cpu_partial (3,150,420,230 samples, 0.04%)</title><rec=
t x=3D"451.4" y=3D"245" width=3D"0.5" height=3D"15.0" fill=3D"rgb(209,64,39=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"454.41" y=3D"255.5" ></text>=0A</g>=
=0A<g >=0A<title>schedule (1,040,414,087 samples, 0.01%)</title><rect x=3D"=
1189.1" y=3D"325" width=3D"0.2" height=3D"15.0" fill=3D"rgb(246,19,9)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1192.09" y=3D"335.5" ></text>=0A</g>=0A<g =
>=0A<title>___slab_alloc (125,750,436,359 samples, 1.72%)</title><rect x=3D=
"855.0" y=3D"165" width=3D"20.3" height=3D"15.0" fill=3D"rgb(235,17,4)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"857.98" y=3D"175.5" ></text>=0A</g>=0A<g >=
=0A<title>update_rq_clock (1,332,678,314 samples, 0.02%)</title><rect x=3D"=
357.4" y=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(205,160,44)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"360.40" y=3D"111.5" ></text>=0A</g>=0A<g >=
=0A<title>__x86_indirect_thunk_rax (24,775,548,111 samples, 0.34%)</title><=
rect x=3D"627.2" y=3D"341" width=3D"4.0" height=3D"15.0" fill=3D"rgb(222,12=
6,48)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"630.17" y=3D"351.5" ></text>=0A</=
g>=0A<g >=0A<title>update_curr (1,235,436,509 samples, 0.02%)</title><rect =
x=3D"1111.1" y=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(218,186,3)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1114.13" y=3D"159.5" ></text>=0A</g>=
=0A<g >=0A<title>try_to_wake_up (117,865,394,616 samples, 1.62%)</title><re=
ct x=3D"1126.4" y=3D"181" width=3D"19.0" height=3D"15.0" fill=3D"rgb(247,20=
,25)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1129.37" y=3D"191.5" ></text>=0A</=
g>=0A<g >=0A<title>restore_fpregs_from_fpstate (15,067,671,051 samples, 0.2=
1%)</title><rect x=3D"607.2" y=3D"277" width=3D"2.4" height=3D"15.0" fill=
=3D"rgb(232,222,40)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"610.18" y=3D"287.5"=
 ></text>=0A</g>=0A<g >=0A<title>__cond_resched (3,329,897,384 samples, 0.0=
5%)</title><rect x=3D"875.3" y=3D"165" width=3D"0.6" height=3D"15.0" fill=
=3D"rgb(205,98,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"878.32" y=3D"175.5" =
></text>=0A</g>=0A<g >=0A<title>enqueue_entity (17,497,801,382 samples, 0.2=
4%)</title><rect x=3D"1135.5" y=3D"133" width=3D"2.8" height=3D"15.0" fill=
=3D"rgb(219,154,44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1138.50" y=3D"143.5=
" ></text>=0A</g>=0A<g >=0A<title>sock_recvmsg (58,291,605,900 samples, 0.8=
0%)</title><rect x=3D"102.5" y=3D"277" width=3D"9.4" height=3D"15.0" fill=
=3D"rgb(246,113,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"105.45" y=3D"287.5"=
 ></text>=0A</g>=0A<g >=0A<title>ksys_read (8,531,072,837 samples, 0.12%)</=
title><rect x=3D"1185.2" y=3D"357" width=3D"1.4" height=3D"15.0" fill=3D"rg=
b(221,99,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.19" y=3D"367.5" ></te=
xt>=0A</g>=0A<g >=0A<title>put_prev_entity (773,128,550 samples, 0.01%)</ti=
tle><rect x=3D"1164.3" y=3D"245" width=3D"0.1" height=3D"15.0" fill=3D"rgb(=
222,67,46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1167.28" y=3D"255.5" ></text=
>=0A</g>=0A<g >=0A<title>_copy_from_iter (131,972,266,670 samples, 1.81%)</=
title><rect x=3D"785.2" y=3D"229" width=3D"21.3" height=3D"15.0" fill=3D"rg=
b(214,6,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"788.17" y=3D"239.5" >_..</t=
ext>=0A</g>=0A<g >=0A<title>psi_account_irqtime (828,171,379 samples, 0.01%=
)</title><rect x=3D"357.4" y=3D"85" width=3D"0.2" height=3D"15.0" fill=3D"r=
gb(238,7,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"360.44" y=3D"95.5" ></text>=
=0A</g>=0A<g >=0A<title>restore_fpregs_from_fpstate (2,964,756,962 samples,=
 0.04%)</title><rect x=3D"1164.7" y=3D"277" width=3D"0.5" height=3D"15.0" f=
ill=3D"rgb(214,102,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1167.72" y=3D"28=
7.5" ></text>=0A</g>=0A<g >=0A<title>security_socket_recvmsg (34,759,549,24=
4 samples, 0.48%)</title><rect x=3D"106.3" y=3D"261" width=3D"5.6" height=
=3D"15.0" fill=3D"rgb(219,141,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"109.2=
6" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__lock_text_start (38,811,46=
1,803 samples, 0.53%)</title><rect x=3D"1021.8" y=3D"149" width=3D"6.3" hei=
ght=3D"15.0" fill=3D"rgb(206,2,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1024=
=2E82" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>autoremove_wake_function=
 (120,505,342,199 samples, 1.65%)</title><rect x=3D"1125.9" y=3D"197" width=
=3D"19.5" height=3D"15.0" fill=3D"rgb(220,155,46)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1128.95" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>available_i=
dle_cpu (961,117,531 samples, 0.01%)</title><rect x=3D"1131.4" y=3D"149" wi=
dth=3D"0.2" height=3D"15.0" fill=3D"rgb(254,186,17)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1134.44" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>schedul=
e (8,531,072,837 samples, 0.12%)</title><rect x=3D"1185.2" y=3D"261" width=
=3D"1.4" height=3D"15.0" fill=3D"rgb(245,176,2)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1188.19" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>__bitmap_and =
(821,165,108 samples, 0.01%)</title><rect x=3D"1131.3" y=3D"149" width=3D"0=
=2E1" height=3D"15.0" fill=3D"rgb(236,13,12)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"1134.28" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>native_queued_sp=
in_lock_slowpath (42,536,635,103 samples, 0.58%)</title><rect x=3D"868.3" y=
=3D"117" width=3D"6.8" height=3D"15.0" fill=3D"rgb(227,101,41)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"871.25" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title=
>native_sched_clock (1,373,818,429 samples, 0.02%)</title><rect x=3D"1145.2=
" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(221,85,35)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"1148.19" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>unix_stream_sendmsg (3,021,519,057 samples, 0.04%)</title><rect x=3D"11=
88.6" y=3D"293" width=3D"0.5" height=3D"15.0" fill=3D"rgb(225,128,17)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1191.60" y=3D"303.5" ></text>=0A</g>=0A<g =
>=0A<title>__schedule (1,410,694,833 samples, 0.02%)</title><rect x=3D"1186=
=2E6" y=3D"309" width=3D"0.2" height=3D"15.0" fill=3D"rgb(217,81,16)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1189.57" y=3D"319.5" ></text>=0A</g>=0A<g >=
=0A<title>__switch_to (3,320,463,074 samples, 0.05%)</title><rect x=3D"1183=
=2E5" y=3D"389" width=3D"0.6" height=3D"15.0" fill=3D"rgb(213,176,46)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1186.54" y=3D"399.5" ></text>=0A</g>=0A<g =
>=0A<title>native_queued_spin_lock_slowpath (41,985,927,734 samples, 0.58%)=
</title><rect x=3D"303.7" y=3D"181" width=3D"6.8" height=3D"15.0" fill=3D"r=
gb(220,150,17)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"306.68" y=3D"191.5" ></t=
ext>=0A</g>=0A<g >=0A<title>obj_cgroup_charge (57,400,063,904 samples, 0.79=
%)</title><rect x=3D"981.5" y=3D"165" width=3D"9.3" height=3D"15.0" fill=3D=
"rgb(223,137,36)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"984.52" y=3D"175.5" ><=
/text>=0A</g>=0A<g >=0A<title>__switch_to (1,600,595,668 samples, 0.02%)</t=
itle><rect x=3D"454.2" y=3D"197" width=3D"0.3" height=3D"15.0" fill=3D"rgb(=
220,133,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"457.22" y=3D"207.5" ></text=
>=0A</g>=0A<g >=0A<title>entry_SYSCALL_64_after_hwframe (3,566,294,815,946 =
samples, 48.88%)</title><rect x=3D"45.6" y=3D"357" width=3D"576.9" height=
=3D"15.0" fill=3D"rgb(237,26,52)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"48.64"=
 y=3D"367.5" >entry_SYSCALL_64_after_hwframe</text>=0A</g>=0A<g >=0A<title>=
__unfreeze_partials (66,374,245,914 samples, 0.91%)</title><rect x=3D"175.6=
" y=3D"245" width=3D"10.7" height=3D"15.0" fill=3D"rgb(208,162,4)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"178.60" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>cgroup_rstat_updated (1,325,165,724 samples, 0.02%)</title><rect x=3D"2=
60.3" y=3D"149" width=3D"0.3" height=3D"15.0" fill=3D"rgb(205,149,12)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"263.35" y=3D"159.5" ></text>=0A</g>=0A<g >=
=0A<title>cgroup_rstat_updated (912,952,072 samples, 0.01%)</title><rect x=
=3D"1092.2" y=3D"117" width=3D"0.2" height=3D"15.0" fill=3D"rgb(239,56,54)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"1095.23" y=3D"127.5" ></text>=0A</g>=0A=
<g >=0A<title>rb_erase (1,589,476,888 samples, 0.02%)</title><rect x=3D"465=
=2E1" y=3D"165" width=3D"0.2" height=3D"15.0" fill=3D"rgb(228,151,19)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"468.07" y=3D"175.5" ></text>=0A</g>=0A<g >=
=0A<title>__build_skb_around (23,695,867,872 samples, 0.32%)</title><rect x=
=3D"835.6" y=3D"197" width=3D"3.9" height=3D"15.0" fill=3D"rgb(226,50,21)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"838.64" y=3D"207.5" ></text>=0A</g>=0A<g=
 >=0A<title>__rcu_read_unlock (6,308,210,554 samples, 0.09%)</title><rect x=
=3D"349.4" y=3D"181" width=3D"1.0" height=3D"15.0" fill=3D"rgb(227,54,11)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"352.37" y=3D"191.5" ></text>=0A</g>=0A<g=
 >=0A<title>mod_memcg_state (6,591,977,014 samples, 0.09%)</title><rect x=
=3D"442.9" y=3D"197" width=3D"1.1" height=3D"15.0" fill=3D"rgb(213,75,38)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"445.94" y=3D"207.5" ></text>=0A</g>=0A<g=
 >=0A<title>alloc_skb_with_frags (1,805,952,299,514 samples, 24.76%)</title=
><rect x=3D"817.7" y=3D"229" width=3D"292.1" height=3D"15.0" fill=3D"rgb(24=
0,22,8)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"820.66" y=3D"239.5" >alloc_skb_=
with_frags</text>=0A</g>=0A<g >=0A<title>load_new_mm_cr3 (1,003,212,432 sam=
ples, 0.01%)</title><rect x=3D"1186.6" y=3D"277" width=3D"0.2" height=3D"15=
=2E0" fill=3D"rgb(252,142,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1189.64" =
y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>__refill_stock (1,229,734,148 s=
amples, 0.02%)</title><rect x=3D"264.6" y=3D"165" width=3D"0.2" height=3D"1=
5.0" fill=3D"rgb(229,1,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"267.63" y=3D=
"175.5" ></text>=0A</g>=0A<g >=0A<title>[hackbench] (7,253,674,025,354 samp=
les, 99.43%)</title><rect x=3D"10.0" y=3D"389" width=3D"1173.3" height=3D"1=
5.0" fill=3D"rgb(221,169,10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"13.01" y=
=3D"399.5" >[hackbench]</text>=0A</g>=0A<g >=0A<title>obj_cgroup_uncharge (=
1,181,267,462 samples, 0.02%)</title><rect x=3D"260.6" y=3D"197" width=3D"0=
=2E2" height=3D"15.0" fill=3D"rgb(226,182,44)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"263.56" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>refill_obj_stock=
 (18,395,070,913 samples, 0.25%)</title><rect x=3D"264.9" y=3D"197" width=
=3D"3.0" height=3D"15.0" fill=3D"rgb(220,212,53)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"267.95" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>ttwu_do_wakeu=
p (8,948,632,408 samples, 0.12%)</title><rect x=3D"1142.0" y=3D"165" width=
=3D"1.4" height=3D"15.0" fill=3D"rgb(209,28,29)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1144.98" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>get_partial_n=
ode (86,722,624,767 samples, 1.19%)</title><rect x=3D"861.3" y=3D"149" widt=
h=3D"14.0" height=3D"15.0" fill=3D"rgb(224,200,23)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"864.30" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_=
lock (1,955,981,407 samples, 0.03%)</title><rect x=3D"987.3" y=3D"149" widt=
h=3D"0.3" height=3D"15.0" fill=3D"rgb(210,161,17)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"990.26" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>cache_from_o=
bj (167,732,925,312 samples, 2.30%)</title><rect x=3D"406.9" y=3D"229" widt=
h=3D"27.2" height=3D"15.0" fill=3D"rgb(227,65,33)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"409.94" y=3D"239.5" >c..</text>=0A</g>=0A<g >=0A<title>__default=
_send_IPI_dest_field (3,081,992,725 samples, 0.04%)</title><rect x=3D"1142.=
7" y=3D"101" width=3D"0.5" height=3D"15.0" fill=3D"rgb(251,205,4)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"1145.74" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<t=
itle>check_preempt_wakeup (7,410,140,507 samples, 0.10%)</title><rect x=3D"=
1142.2" y=3D"133" width=3D"1.2" height=3D"15.0" fill=3D"rgb(220,91,45)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1145.23" y=3D"143.5" ></text>=0A</g>=0A<g =
>=0A<title>__rcu_read_lock (2,414,771,769 samples, 0.03%)</title><rect x=3D=
"881.9" y=3D"149" width=3D"0.4" height=3D"15.0" fill=3D"rgb(230,59,13)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"884.91" y=3D"159.5" ></text>=0A</g>=0A<g >=
=0A<title>skb_queue_tail (43,797,403,485 samples, 0.60%)</title><rect x=3D"=
807.7" y=3D"245" width=3D"7.0" height=3D"15.0" fill=3D"rgb(232,156,28)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"810.66" y=3D"255.5" ></text>=0A</g>=0A<g >=
=0A<title>mod_memcg_state (11,434,207,898 samples, 0.16%)</title><rect x=3D=
"262.3" y=3D"165" width=3D"1.8" height=3D"15.0" fill=3D"rgb(231,212,24)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"265.27" y=3D"175.5" ></text>=0A</g>=0A<g >=
=0A<title>put_pid (1,629,103,116 samples, 0.02%)</title><rect x=3D"756.6" y=
=3D"245" width=3D"0.3" height=3D"15.0" fill=3D"rgb(228,38,4)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"759.63" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title=
>put_prev_entity (1,409,666,926 samples, 0.02%)</title><rect x=3D"606.1" y=
=3D"245" width=3D"0.3" height=3D"15.0" fill=3D"rgb(208,62,30)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"609.15" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title=
>__fget_light (49,031,522,817 samples, 0.67%)</title><rect x=3D"663.7" y=3D=
"293" width=3D"7.9" height=3D"15.0" fill=3D"rgb(242,33,45)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"666.68" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>swi=
tch_mm_irqs_off (2,838,516,795 samples, 0.04%)</title><rect x=3D"1188.6" y=
=3D"213" width=3D"0.5" height=3D"15.0" fill=3D"rgb(220,94,51)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1191.63" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<titl=
e>_copy_to_iter (345,571,839,300 samples, 4.74%)</title><rect x=3D"488.6" y=
=3D"197" width=3D"55.9" height=3D"15.0" fill=3D"rgb(237,194,39)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"491.58" y=3D"207.5" >_copy..</text>=0A</g>=0A<g >=
=0A<title>skb_put (7,028,280,002 samples, 0.10%)</title><rect x=3D"806.5" y=
=3D"245" width=3D"1.2" height=3D"15.0" fill=3D"rgb(249,117,49)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"809.52" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title=
>save_fpregs_to_fpstate (6,287,092,170 samples, 0.09%)</title><rect x=3D"11=
86.9" y=3D"389" width=3D"1.0" height=3D"15.0" fill=3D"rgb(245,116,52)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1189.91" y=3D"399.5" ></text>=0A</g>=0A<g =
>=0A<title>asm_sysvec_reschedule_ipi (1,405,330,613 samples, 0.02%)</title>=
<rect x=3D"462.9" y=3D"181" width=3D"0.3" height=3D"15.0" fill=3D"rgb(253,5=
3,32)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"465.94" y=3D"191.5" ></text>=0A</=
g>=0A<g >=0A<title>__lock_text_start (49,121,154,889 samples, 0.67%)</title=
><rect x=3D"302.5" y=3D"197" width=3D"8.0" height=3D"15.0" fill=3D"rgb(205,=
125,44)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"305.53" y=3D"207.5" ></text>=0A=
</g>=0A<g >=0A<title>schedule_timeout (2,975,706,668 samples, 0.04%)</title=
><rect x=3D"1188.6" y=3D"261" width=3D"0.5" height=3D"15.0" fill=3D"rgb(207=
,123,26)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.60" y=3D"271.5" ></text>=
=0A</g>=0A<g >=0A<title>consume_skb (1,019,714,006,591 samples, 13.98%)</ti=
tle><rect x=3D"192.7" y=3D"245" width=3D"164.9" height=3D"15.0" fill=3D"rgb=
(220,119,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"195.69" y=3D"255.5" >consum=
e_skb</text>=0A</g>=0A<g >=0A<title>cpu_startup_entry (2,535,483,173 sample=
s, 0.03%)</title><rect x=3D"1189.6" y=3D"373" width=3D"0.4" height=3D"15.0"=
 fill=3D"rgb(253,86,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.58" y=3D"3=
83.5" ></text>=0A</g>=0A<g >=0A<title>vfs_write (2,954,076,188,975 samples,=
 40.49%)</title><rect x=3D"671.6" y=3D"309" width=3D"477.8" height=3D"15.0"=
 fill=3D"rgb(241,77,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"674.61" y=3D"31=
9.5" >vfs_write</text>=0A</g>=0A<g >=0A<title>put_pid (779,136,525 samples,=
 0.01%)</title><rect x=3D"473.3" y=3D"229" width=3D"0.2" height=3D"15.0" fi=
ll=3D"rgb(223,112,42)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"476.35" y=3D"239.=
5" ></text>=0A</g>=0A<g >=0A<title>skb_copy_datagram_iter (647,052,648,376 =
samples, 8.87%)</title><rect x=3D"483.8" y=3D"229" width=3D"104.7" height=
=3D"15.0" fill=3D"rgb(212,81,25)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"486.84=
" y=3D"239.5" >skb_copy_dat..</text>=0A</g>=0A<g >=0A<title>__lock_text_sta=
rt (1,551,455,793 samples, 0.02%)</title><rect x=3D"1109.8" y=3D"213" width=
=3D"0.3" height=3D"15.0" fill=3D"rgb(206,12,28)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1112.85" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>sched_clock_c=
pu (1,647,672,553 samples, 0.02%)</title><rect x=3D"468.9" y=3D"181" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(220,128,16)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"471.88" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__update_load=
_avg_se (1,637,256,647 samples, 0.02%)</title><rect x=3D"1138.1" y=3D"101" =
width=3D"0.2" height=3D"15.0" fill=3D"rgb(211,80,33)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1141.06" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__list_=
del_entry_valid (635,711,397 samples, 0.01%)</title><rect x=3D"456.4" y=3D"=
165" width=3D"0.1" height=3D"15.0" fill=3D"rgb(224,8,3)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"459.42" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>set_ne=
xt_buddy (6,612,780,562 samples, 0.09%)</title><rect x=3D"459.3" y=3D"181" =
width=3D"1.0" height=3D"15.0" fill=3D"rgb(236,76,9)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"462.26" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>entry_SY=
SRETQ_unsafe_stack (2,015,332,832 samples, 0.03%)</title><rect x=3D"1179.1"=
 y=3D"357" width=3D"0.3" height=3D"15.0" fill=3D"rgb(212,183,21)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"1182.11" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>__list_del_entry_valid (959,217,200 samples, 0.01%)</title><rect x=3D"4=
63.8" y=3D"181" width=3D"0.1" height=3D"15.0" fill=3D"rgb(253,25,11)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"466.76" y=3D"191.5" ></text>=0A</g>=0A<g >=0A=
<title>sock_read_iter (8,531,072,837 samples, 0.12%)</title><rect x=3D"1185=
=2E2" y=3D"325" width=3D"1.4" height=3D"15.0" fill=3D"rgb(209,33,14)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1188.19" y=3D"335.5" ></text>=0A</g>=0A<g >=
=0A<title>__update_load_avg_cfs_rq (1,322,504,574 samples, 0.02%)</title><r=
ect x=3D"457.5" y=3D"149" width=3D"0.2" height=3D"15.0" fill=3D"rgb(236,75,=
46)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"460.52" y=3D"159.5" ></text>=0A</g>=
=0A<g >=0A<title>ktime_get_coarse_real_ts64 (6,990,991,060 samples, 0.10%)<=
/title><rect x=3D"621.4" y=3D"309" width=3D"1.1" height=3D"15.0" fill=3D"rg=
b(219,99,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"624.35" y=3D"319.5" ></tex=
t>=0A</g>=0A<g >=0A<title>cpuacct_charge (766,302,875 samples, 0.01%)</titl=
e><rect x=3D"457.1" y=3D"149" width=3D"0.1" height=3D"15.0" fill=3D"rgb(247=
,111,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"460.08" y=3D"159.5" ></text>=0A=
</g>=0A<g >=0A<title>syscall_exit_to_user_mode_prepare (36,121,350,036 samp=
les, 0.50%)</title><rect x=3D"609.6" y=3D"309" width=3D"5.9" height=3D"15.0=
" fill=3D"rgb(226,207,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"612.62" y=3D"=
319.5" ></text>=0A</g>=0A<g >=0A<title>syscall_trace_enter.constprop.0 (43,=
421,822,818 samples, 0.60%)</title><rect x=3D"615.5" y=3D"325" width=3D"7.0=
" height=3D"15.0" fill=3D"rgb(250,210,42)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"618.46" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgroup_uncharge=
_pages (12,901,414,926 samples, 0.18%)</title><rect x=3D"442.2" y=3D"229" w=
idth=3D"2.1" height=3D"15.0" fill=3D"rgb(230,207,53)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"445.23" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>pick_nex=
t_task_fair (3,139,116,236 samples, 0.04%)</title><rect x=3D"1164.0" y=3D"2=
61" width=3D"0.5" height=3D"15.0" fill=3D"rgb(227,61,3)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"1167.04" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>rewei=
ght_entity (7,459,704,463 samples, 0.10%)</title><rect x=3D"458.1" y=3D"181=
" width=3D"1.2" height=3D"15.0" fill=3D"rgb(231,7,11)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"461.06" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>exit_to_=
user_mode_prepare (1,040,414,087 samples, 0.01%)</title><rect x=3D"1189.1" =
y=3D"341" width=3D"0.2" height=3D"15.0" fill=3D"rgb(234,20,28)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1192.09" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<titl=
e>memcg_account_kmem (7,480,153,710 samples, 0.10%)</title><rect x=3D"987.7=
" y=3D"149" width=3D"1.3" height=3D"15.0" fill=3D"rgb(237,215,43)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"990.75" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>syscall_return_via_sysret (17,083,888,495 samples, 0.23%)</title><rect =
x=3D"1180.3" y=3D"357" width=3D"2.8" height=3D"15.0" fill=3D"rgb(237,3,54)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"1183.30" y=3D"367.5" ></text>=0A</g>=0A=
<g >=0A<title>__rcu_read_unlock (5,064,911,021 samples, 0.07%)</title><rect=
 x=3D"1057.8" y=3D"165" width=3D"0.8" height=3D"15.0" fill=3D"rgb(243,13,22=
)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1060.80" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>security_file_permission (34,418,447,943 samples, 0.47%)</=
title><rect x=3D"695.4" y=3D"293" width=3D"5.6" height=3D"15.0" fill=3D"rgb=
(227,63,33)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"698.43" y=3D"303.5" ></text=
>=0A</g>=0A<g >=0A<title>kmem_cache_alloc_node (689,206,787,167 samples, 9.=
45%)</title><rect x=3D"997.0" y=3D"197" width=3D"111.5" height=3D"15.0" fil=
l=3D"rgb(249,177,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"999.98" y=3D"207.5=
" >kmem_cache_al..</text>=0A</g>=0A<g >=0A<title>sched_clock_cpu (1,003,563=
,692 samples, 0.01%)</title><rect x=3D"1134.3" y=3D"117" width=3D"0.2" heig=
ht=3D"15.0" fill=3D"rgb(235,216,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"113=
7.31" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>psi_account_irqtime (4,72=
0,480,066 samples, 0.06%)</title><rect x=3D"469.7" y=3D"181" width=3D"0.8" =
height=3D"15.0" fill=3D"rgb(228,180,10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"472.74" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>enqueue_entity (3,330,=
999,959 samples, 0.05%)</title><rect x=3D"356.0" y=3D"69" width=3D"0.6" hei=
ght=3D"15.0" fill=3D"rgb(209,73,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"359=
=2E03" y=3D"79.5" ></text>=0A</g>=0A<g >=0A<title>secondary_startup_64_no_v=
erify (2,615,568,120 samples, 0.04%)</title><rect x=3D"1189.6" y=3D"405" wi=
dth=3D"0.4" height=3D"15.0" fill=3D"rgb(235,214,18)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1192.57" y=3D"415.5" ></text>=0A</g>=0A<g >=0A<title>bpf_lsm=
_socket_sendmsg (14,688,745,143 samples, 0.20%)</title><rect x=3D"724.0" y=
=3D"245" width=3D"2.4" height=3D"15.0" fill=3D"rgb(223,144,27)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"726.99" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title=
>do_syscall_64 (9,941,767,670 samples, 0.14%)</title><rect x=3D"1185.2" y=
=3D"373" width=3D"1.6" height=3D"15.0" fill=3D"rgb(253,143,33)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1188.19" y=3D"383.5" ></text>=0A</g>=0A<g >=0A<titl=
e>unix_stream_recvmsg (1,174,322,291 samples, 0.02%)</title><rect x=3D"631.=
2" y=3D"357" width=3D"0.2" height=3D"15.0" fill=3D"rgb(221,17,20)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"634.19" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>unix_stream_read_generic (8,531,072,837 samples, 0.12%)</title><rect x=
=3D"1185.2" y=3D"293" width=3D"1.4" height=3D"15.0" fill=3D"rgb(237,45,9)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.19" y=3D"303.5" ></text>=0A</g>=0A<=
g >=0A<title>__rcu_read_lock (1,415,315,661 samples, 0.02%)</title><rect x=
=3D"881.4" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(240,211,17)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"884.39" y=3D"143.5" ></text>=0A</g>=0A<=
g >=0A<title>_raw_spin_lock (1,640,202,083 samples, 0.02%)</title><rect x=
=3D"605.3" y=3D"261" width=3D"0.3" height=3D"15.0" fill=3D"rgb(232,139,39)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"608.34" y=3D"271.5" ></text>=0A</g>=0A<=
g >=0A<title>get_obj_cgroup_from_current (41,638,129,485 samples, 0.57%)</t=
itle><rect x=3D"876.4" y=3D"165" width=3D"6.8" height=3D"15.0" fill=3D"rgb(=
228,63,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"879.44" y=3D"175.5" ></text>=
=0A</g>=0A<g >=0A<title>__check_heap_object (19,952,015,349 samples, 0.27%)=
</title><rect x=3D"575.8" y=3D"165" width=3D"3.2" height=3D"15.0" fill=3D"r=
gb(211,18,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"578.81" y=3D"175.5" ></te=
xt>=0A</g>=0A<g >=0A<title>finish_task_switch.isra.0 (4,217,038,257 samples=
, 0.06%)</title><rect x=3D"462.5" y=3D"197" width=3D"0.7" height=3D"15.0" f=
ill=3D"rgb(246,9,40)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"465.53" y=3D"207.5=
" ></text>=0A</g>=0A<g >=0A<title>bpf_lsm_file_permission (12,153,120,572 s=
amples, 0.17%)</title><rect x=3D"88.4" y=3D"277" width=3D"2.0" height=3D"15=
=2E0" fill=3D"rgb(218,193,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"91.44" y=
=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>__get_obj_cgroup_from_memcg (15,=
204,467,620 samples, 0.21%)</title><rect x=3D"879.5" y=3D"149" width=3D"2.4=
" height=3D"15.0" fill=3D"rgb(206,84,17)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"882.45" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__switch_to (1,136,=
560,626 samples, 0.02%)</title><rect x=3D"1188.0" y=3D"389" width=3D"0.2" h=
eight=3D"15.0" fill=3D"rgb(239,129,52)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
1190.99" y=3D"399.5" ></text>=0A</g>=0A<g >=0A<title>put_cpu_partial (686,0=
71,850 samples, 0.01%)</title><rect x=3D"875.2" y=3D"133" width=3D"0.1" hei=
ght=3D"15.0" fill=3D"rgb(216,222,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"87=
8.21" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>entry_SYSRETQ_unsafe_stac=
k (1,731,718,563 samples, 0.02%)</title><rect x=3D"623.9" y=3D"357" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(227,138,30)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"626.85" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>native_queued=
_spin_lock_slowpath (1,413,936,832 samples, 0.02%)</title><rect x=3D"1109.9=
" y=3D"197" width=3D"0.2" height=3D"15.0" fill=3D"rgb(253,224,26)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"1112.87" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<t=
itle>sock_write_iter (4,806,428,590 samples, 0.07%)</title><rect x=3D"1179.=
5" y=3D"357" width=3D"0.8" height=3D"15.0" fill=3D"rgb(225,199,20)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"1182.52" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<=
title>schedule_timeout (8,531,072,837 samples, 0.12%)</title><rect x=3D"118=
5.2" y=3D"277" width=3D"1.4" height=3D"15.0" fill=3D"rgb(214,88,27)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"1188.19" y=3D"287.5" ></text>=0A</g>=0A<g >=0A=
<title>syscall_exit_to_user_mode (121,143,763,755 samples, 1.66%)</title><r=
ect x=3D"1151.1" y=3D"325" width=3D"19.6" height=3D"15.0" fill=3D"rgb(228,1=
30,14)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1154.11" y=3D"335.5" ></text>=0A=
</g>=0A<g >=0A<title>memcg_account_kmem (3,056,589,733 samples, 0.04%)</tit=
le><rect x=3D"1106.7" y=3D"165" width=3D"0.5" height=3D"15.0" fill=3D"rgb(2=
43,6,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1109.73" y=3D"175.5" ></text>=
=0A</g>=0A<g >=0A<title>psi_account_irqtime (1,190,206,310 samples, 0.02%)<=
/title><rect x=3D"1113.7" y=3D"165" width=3D"0.2" height=3D"15.0" fill=3D"r=
gb(236,17,34)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1116.71" y=3D"175.5" ></t=
ext>=0A</g>=0A<g >=0A<title>__audit_syscall_exit (16,504,158,516 samples, 0=
=2E23%)</title><rect x=3D"1167.0" y=3D"293" width=3D"2.7" height=3D"15.0" f=
ill=3D"rgb(216,81,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1169.99" y=3D"303.=
5" ></text>=0A</g>=0A<g >=0A<title>__cond_resched (3,698,912,341 samples, 0=
=2E05%)</title><rect x=3D"1028.3" y=3D"181" width=3D"0.6" height=3D"15.0" f=
ill=3D"rgb(220,222,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1031.27" y=3D"19=
1.5" ></text>=0A</g>=0A<g >=0A<title>update_cfs_group (820,186,960 samples,=
 0.01%)</title><rect x=3D"356.8" y=3D"69" width=3D"0.2" height=3D"15.0" fil=
l=3D"rgb(219,164,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"359.82" y=3D"79.5"=
 ></text>=0A</g>=0A<g >=0A<title>__virt_addr_valid (57,503,221,360 samples,=
 0.79%)</title><rect x=3D"773.7" y=3D"213" width=3D"9.3" height=3D"15.0" fi=
ll=3D"rgb(225,129,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"776.74" y=3D"223.=
5" ></text>=0A</g>=0A<g >=0A<title>load_new_mm_cr3 (633,390,683 samples, 0.=
01%)</title><rect x=3D"1189.2" y=3D"277" width=3D"0.1" height=3D"15.0" fill=
=3D"rgb(218,64,16)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.15" y=3D"287.5"=
 ></text>=0A</g>=0A<g >=0A<title>syscall_exit_to_user_mode (156,658,340,359=
 samples, 2.15%)</title><rect x=3D"590.1" y=3D"325" width=3D"25.4" height=
=3D"15.0" fill=3D"rgb(235,227,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"593.1=
2" y=3D"335.5" >s..</text>=0A</g>=0A<g >=0A<title>load_new_mm_cr3 (2,516,52=
9,779 samples, 0.03%)</title><rect x=3D"1188.7" y=3D"197" width=3D"0.4" hei=
ght=3D"15.0" fill=3D"rgb(229,124,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
91.68" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>__list_del_entry_valid (=
16,312,417,792 samples, 0.22%)</title><rect x=3D"865.3" y=3D"133" width=3D"=
2.6" height=3D"15.0" fill=3D"rgb(219,101,49)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"868.31" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>swapper (2,657,90=
7,199 samples, 0.04%)</title><rect x=3D"1189.6" y=3D"421" width=3D"0.4" hei=
ght=3D"15.0" fill=3D"rgb(206,169,49)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
92.56" y=3D"431.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_read_actor (=
656,380,164,838 samples, 9.00%)</title><rect x=3D"482.3" y=3D"245" width=3D=
"106.2" height=3D"15.0" fill=3D"rgb(209,149,31)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"485.33" y=3D"255.5" >unix_stream_..</text>=0A</g>=0A<g >=0A<title>=
unix_stream_recvmsg (2,946,655,000,576 samples, 40.39%)</title><rect x=3D"1=
11.9" y=3D"277" width=3D"476.6" height=3D"15.0" fill=3D"rgb(228,183,7)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"114.88" y=3D"287.5" >unix_stream_recvmsg</=
text>=0A</g>=0A<g >=0A<title>memcg_account_kmem (6,773,545,095 samples, 0.0=
9%)</title><rect x=3D"442.9" y=3D"213" width=3D"1.1" height=3D"15.0" fill=
=3D"rgb(247,110,20)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"445.92" y=3D"223.5"=
 ></text>=0A</g>=0A<g >=0A<title>_raw_spin_unlock_irqrestore (19,247,109,55=
6 samples, 0.26%)</title><rect x=3D"189.5" y=3D"245" width=3D"3.1" height=
=3D"15.0" fill=3D"rgb(244,195,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"192.48=
" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (3,694,923,=
891 samples, 0.05%)</title><rect x=3D"1039.2" y=3D"165" width=3D"0.6" heigh=
t=3D"15.0" fill=3D"rgb(208,174,42)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1042=
=2E18" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>do_syscall_64 (4,061,933=
,144 samples, 0.06%)</title><rect x=3D"1188.6" y=3D"373" width=3D"0.7" heig=
ht=3D"15.0" fill=3D"rgb(246,192,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"119=
1.60" y=3D"383.5" ></text>=0A</g>=0A<g >=0A<title>all (7,295,302,424,356 sa=
mples, 100%)</title><rect x=3D"10.0" y=3D"437" width=3D"1180.0" height=3D"1=
5.0" fill=3D"rgb(219,141,49)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"13.00" y=
=3D"447.5" ></text>=0A</g>=0A<g >=0A<title>switch_fpu_return (3,144,970,704=
 samples, 0.04%)</title><rect x=3D"1164.7" y=3D"293" width=3D"0.5" height=
=3D"15.0" fill=3D"rgb(215,92,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1167.6=
9" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (1,821,976=
,295 samples, 0.02%)</title><rect x=3D"881.6" y=3D"133" width=3D"0.3" heigh=
t=3D"15.0" fill=3D"rgb(205,188,12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"884.=
62" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (7,479,394,=
825 samples, 0.10%)</title><rect x=3D"1090.3" y=3D"149" width=3D"1.2" heigh=
t=3D"15.0" fill=3D"rgb(212,67,43)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1093.=
32" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>cgroup_rstat_updated (1,097=
,210,713 samples, 0.02%)</title><rect x=3D"441.9" y=3D"181" width=3D"0.2" h=
eight=3D"15.0" fill=3D"rgb(225,138,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
444.87" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__list_add_valid (4,050=
,814,178 samples, 0.06%)</title><rect x=3D"178.2" y=3D"229" width=3D"0.6" h=
eight=3D"15.0" fill=3D"rgb(221,175,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
181.16" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (2,733,=
432,493 samples, 0.04%)</title><rect x=3D"1038.7" y=3D"165" width=3D"0.5" h=
eight=3D"15.0" fill=3D"rgb(221,13,42)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1=
041.74" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>ttwu_do_activate (12,45=
7,409,523 samples, 0.17%)</title><rect x=3D"355.2" y=3D"101" width=3D"2.1" =
height=3D"15.0" fill=3D"rgb(210,84,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
358.24" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__wake_up_common_lock (=
136,294,079,224 samples, 1.87%)</title><rect x=3D"1123.8" y=3D"229" width=
=3D"22.0" height=3D"15.0" fill=3D"rgb(223,47,3)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"1126.78" y=3D"239.5" >_..</text>=0A</g>=0A<g >=0A<title>__rcu_read=
_unlock (5,198,309,196 samples, 0.07%)</title><rect x=3D"250.9" y=3D"197" w=
idth=3D"0.9" height=3D"15.0" fill=3D"rgb(236,12,34)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"253.92" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>sched_cl=
ock_cpu (1,603,235,888 samples, 0.02%)</title><rect x=3D"1145.2" y=3D"149" =
width=3D"0.2" height=3D"15.0" fill=3D"rgb(243,171,42)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1148.18" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>__updat=
e_load_avg_se (733,568,711 samples, 0.01%)</title><rect x=3D"357.1" y=3D"53=
" width=3D"0.1" height=3D"15.0" fill=3D"rgb(212,93,23)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"360.12" y=3D"63.5" ></text>=0A</g>=0A<g >=0A<title>sock_rea=
d_iter (3,834,275,606 samples, 0.05%)</title><rect x=3D"624.2" y=3D"357" wi=
dth=3D"0.6" height=3D"15.0" fill=3D"rgb(216,146,10)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"627.16" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>pick_nex=
t_task_fair (5,653,337,400 samples, 0.08%)</title><rect x=3D"605.7" y=3D"26=
1" width=3D"0.9" height=3D"15.0" fill=3D"rgb(222,204,31)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"608.66" y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>copy_=
user_enhanced_fast_string (330,472,215,124 samples, 4.53%)</title><rect x=
=3D"491.0" y=3D"181" width=3D"53.5" height=3D"15.0" fill=3D"rgb(232,57,31)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"494.02" y=3D"191.5" >copy_..</text>=0A<=
/g>=0A<g >=0A<title>dequeue_task_fair (44,765,394,458 samples, 0.61%)</titl=
e><rect x=3D"455.3" y=3D"197" width=3D"7.2" height=3D"15.0" fill=3D"rgb(211=
,216,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"458.29" y=3D"207.5" ></text>=
=0A</g>=0A<g >=0A<title>__schedule (5,267,083,807 samples, 0.07%)</title><r=
ect x=3D"1163.8" y=3D"277" width=3D"0.9" height=3D"15.0" fill=3D"rgb(245,12=
3,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1166.84" y=3D"287.5" ></text>=0A</=
g>=0A<g >=0A<title>schedule_timeout (117,187,439,639 samples, 1.61%)</title=
><rect x=3D"451.9" y=3D"245" width=3D"19.0" height=3D"15.0" fill=3D"rgb(229=
,25,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"454.92" y=3D"255.5" ></text>=0A=
</g>=0A<g >=0A<title>__entry_text_start (64,597,682,881 samples, 0.89%)</ti=
tle><rect x=3D"639.0" y=3D"357" width=3D"10.4" height=3D"15.0" fill=3D"rgb(=
252,18,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"642.00" y=3D"367.5" ></text>=
=0A</g>=0A<g >=0A<title>__update_load_avg_cfs_rq (2,237,527,596 samples, 0.=
03%)</title><rect x=3D"461.8" y=3D"165" width=3D"0.3" height=3D"15.0" fill=
=3D"rgb(249,14,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"464.77" y=3D"175.5" =
></text>=0A</g>=0A<g >=0A<title>skb_release_data (733,946,484,773 samples, =
10.06%)</title><rect x=3D"195.0" y=3D"229" width=3D"118.8" height=3D"15.0" =
fill=3D"rgb(216,84,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"198.04" y=3D"239=
=2E5" >skb_release_data</text>=0A</g>=0A<g >=0A<title>rb_next (732,248,303 =
samples, 0.01%)</title><rect x=3D"465.3" y=3D"165" width=3D"0.1" height=3D"=
15.0" fill=3D"rgb(234,209,4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"468.32" y=
=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>refill_stock (5,112,523,019 samp=
les, 0.07%)</title><rect x=3D"264.1" y=3D"181" width=3D"0.8" height=3D"15.0=
" fill=3D"rgb(244,178,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"267.12" y=3D"=
191.5" ></text>=0A</g>=0A<g >=0A<title>cgroup_rstat_updated (822,854,839 sa=
mples, 0.01%)</title><rect x=3D"443.9" y=3D"165" width=3D"0.1" height=3D"15=
=2E0" fill=3D"rgb(242,206,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"446.88" y=
=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>sock_alloc_send_pskb (3,021,519,=
057 samples, 0.04%)</title><rect x=3D"1188.6" y=3D"277" width=3D"0.5" heigh=
t=3D"15.0" fill=3D"rgb(212,141,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191=
=2E60" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>sock_sendmsg (3,021,519,=
057 samples, 0.04%)</title><rect x=3D"1188.6" y=3D"309" width=3D"0.5" heigh=
t=3D"15.0" fill=3D"rgb(213,153,5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1191.=
60" y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>__ksize (24,817,121,633 sam=
ples, 0.34%)</title><rect x=3D"993.0" y=3D"197" width=3D"4.0" height=3D"15.=
0" fill=3D"rgb(250,83,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"995.95" y=3D"2=
07.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_unlock (4,718,502,997 samp=
les, 0.06%)</title><rect x=3D"1028.9" y=3D"181" width=3D"0.7" height=3D"15.=
0" fill=3D"rgb(241,137,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1031.87" y=
=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>skb_free_head (2,821,775,378 sam=
ples, 0.04%)</title><rect x=3D"313.3" y=3D"213" width=3D"0.5" height=3D"15.=
0" fill=3D"rgb(224,83,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"316.30" y=3D"=
223.5" ></text>=0A</g>=0A<g >=0A<title>copy_user_enhanced_fast_string (107,=
774,045,197 samples, 1.48%)</title><rect x=3D"789.1" y=3D"213" width=3D"17.=
4" height=3D"15.0" fill=3D"rgb(216,139,17)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"792.08" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>sched_clock_cpu (1,=
273,579,679 samples, 0.02%)</title><rect x=3D"1145.0" y=3D"133" width=3D"0.=
2" height=3D"15.0" fill=3D"rgb(231,222,45)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"1147.97" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_lruvec=
_state (2,680,551,362 samples, 0.04%)</title><rect x=3D"441.6" y=3D"197" wi=
dth=3D"0.5" height=3D"15.0" fill=3D"rgb(213,172,29)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"444.62" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>__calc_d=
elta (2,965,581,735 samples, 0.04%)</title><rect x=3D"1139.0" y=3D"101" wid=
th=3D"0.4" height=3D"15.0" fill=3D"rgb(227,224,32)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"1141.96" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>check_stac=
k_object (10,467,578,445 samples, 0.14%)</title><rect x=3D"783.0" y=3D"213"=
 width=3D"1.7" height=3D"15.0" fill=3D"rgb(211,5,52)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"786.04" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>update_l=
oad_avg (642,924,152 samples, 0.01%)</title><rect x=3D"1111.3" y=3D"149" wi=
dth=3D"0.1" height=3D"15.0" fill=3D"rgb(247,180,42)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1114.33" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>mod_mem=
cg_state (2,828,148,269 samples, 0.04%)</title><rect x=3D"1106.8" y=3D"149"=
 width=3D"0.4" height=3D"15.0" fill=3D"rgb(208,189,6)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1109.77" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>task_h_=
load (822,410,315 samples, 0.01%)</title><rect x=3D"1131.6" y=3D"149" width=
=3D"0.1" height=3D"15.0" fill=3D"rgb(218,35,0)" rx=3D"2" ry=3D"2" />=0A<tex=
t  x=3D"1134.60" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>psi_flags_chan=
ge (1,098,330,562 samples, 0.02%)</title><rect x=3D"466.2" y=3D"181" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(251,66,11)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"469.19" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_lr=
uvec_state (3,242,138,319 samples, 0.04%)</title><rect x=3D"260.0" y=3D"165=
" width=3D"0.6" height=3D"15.0" fill=3D"rgb(234,203,46)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"263.04" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>update=
_cfs_group (866,216,651 samples, 0.01%)</title><rect x=3D"1111.8" y=3D"165"=
 width=3D"0.1" height=3D"15.0" fill=3D"rgb(224,27,25)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1114.75" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>skb_rel=
ease_head_state (271,244,671,280 samples, 3.72%)</title><rect x=3D"313.8" y=
=3D"229" width=3D"43.8" height=3D"15.0" fill=3D"rgb(224,133,36)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"316.75" y=3D"239.5" >skb_..</text>=0A</g>=0A<g >=
=0A<title>entry_SYSCALL_64_safe_stack (8,386,939,091 samples, 0.11%)</title=
><rect x=3D"1177.8" y=3D"357" width=3D"1.3" height=3D"15.0" fill=3D"rgb(243=
,163,1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1180.75" y=3D"367.5" ></text>=
=0A</g>=0A<g >=0A<title>save_fpregs_to_fpstate (992,417,350 samples, 0.01%)=
</title><rect x=3D"1189.3" y=3D"389" width=3D"0.1" height=3D"15.0" fill=3D"=
rgb(221,146,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.28" y=3D"399.5" ></=
text>=0A</g>=0A<g >=0A<title>is_vmalloc_addr (2,701,038,766 samples, 0.04%)=
</title><rect x=3D"784.7" y=3D"213" width=3D"0.5" height=3D"15.0" fill=3D"r=
gb(226,113,5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"787.73" y=3D"223.5" ></te=
xt>=0A</g>=0A<g >=0A<title>native_sched_clock (1,372,402,489 samples, 0.02%=
)</title><rect x=3D"468.9" y=3D"165" width=3D"0.2" height=3D"15.0" fill=3D"=
rgb(232,68,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"471.91" y=3D"175.5" ></t=
ext>=0A</g>=0A<g >=0A<title>[unknown] (7,253,766,796,414 samples, 99.43%)</=
title><rect x=3D"10.0" y=3D"405" width=3D"1173.3" height=3D"15.0" fill=3D"r=
gb(232,52,40)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"13.01" y=3D"415.5" >[unkn=
own]</text>=0A</g>=0A<g >=0A<title>switch_mm_irqs_off (1,806,569,238 sample=
s, 0.02%)</title><rect x=3D"469.2" y=3D"197" width=3D"0.3" height=3D"15.0" =
fill=3D"rgb(210,20,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"472.24" y=3D"207=
=2E5" ></text>=0A</g>=0A<g >=0A<title>mod_objcg_state (84,912,511,504 sampl=
es, 1.16%)</title><rect x=3D"946.4" y=3D"149" width=3D"13.8" height=3D"15.0=
" fill=3D"rgb(219,156,2)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"949.45" y=3D"1=
59.5" ></text>=0A</g>=0A<g >=0A<title>sock_sendmsg (2,678,193,365,505 sampl=
es, 36.71%)</title><rect x=3D"716.2" y=3D"277" width=3D"433.2" height=3D"15=
=2E0" fill=3D"rgb(233,14,24)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"719.24" y=
=3D"287.5" >sock_sendmsg</text>=0A</g>=0A<g >=0A<title>unix_write_space (44=
,536,800,825 samples, 0.61%)</title><rect x=3D"350.4" y=3D"181" width=3D"7.=
2" height=3D"15.0" fill=3D"rgb(218,171,27)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"353.42" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__alloc_skb (1,787,=
499,496,842 samples, 24.50%)</title><rect x=3D"820.6" y=3D"213" width=3D"28=
9.2" height=3D"15.0" fill=3D"rgb(205,184,51)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"823.63" y=3D"223.5" >__alloc_skb</text>=0A</g>=0A<g >=0A<title>_raw_s=
pin_lock (39,693,222,165 samples, 0.54%)</title><rect x=3D"746.3" y=3D"245"=
 width=3D"6.4" height=3D"15.0" fill=3D"rgb(217,5,41)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"749.26" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>hackbenc=
h (7,291,864,790,720 samples, 99.95%)</title><rect x=3D"10.0" y=3D"421" wid=
th=3D"1179.4" height=3D"15.0" fill=3D"rgb(219,5,3)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"13.00" y=3D"431.5" >hackbench</text>=0A</g>=0A<g >=0A<title>pre=
pare_to_wait (1,780,046,720 samples, 0.02%)</title><rect x=3D"1109.8" y=3D"=
229" width=3D"0.3" height=3D"15.0" fill=3D"rgb(228,98,33)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"1112.81" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>mod=
_memcg_lruvec_state (4,874,455,608 samples, 0.07%)</title><rect x=3D"959.4"=
 y=3D"133" width=3D"0.8" height=3D"15.0" fill=3D"rgb(240,116,5)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"962.39" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<titl=
e>native_sched_clock (1,003,563,692 samples, 0.01%)</title><rect x=3D"1134.=
3" y=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(210,215,54)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"1137.31" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<=
title>update_load_avg (2,193,405,660 samples, 0.03%)</title><rect x=3D"465.=
4" y=3D"165" width=3D"0.4" height=3D"15.0" fill=3D"rgb(245,197,2)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"468.44" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>__skb_datagram_iter (641,721,044,071 samples, 8.80%)</title><rect x=3D"=
484.7" y=3D"213" width=3D"103.8" height=3D"15.0" fill=3D"rgb(229,170,21)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"487.70" y=3D"223.5" >__skb_datagr..</text=
>=0A</g>=0A<g >=0A<title>set_next_entity (5,471,798,178 samples, 0.08%)</ti=
tle><rect x=3D"464.9" y=3D"181" width=3D"0.9" height=3D"15.0" fill=3D"rgb(2=
35,191,22)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"467.91" y=3D"191.5" ></text>=
=0A</g>=0A<g >=0A<title>__calc_delta (732,431,575 samples, 0.01%)</title><r=
ect x=3D"356.7" y=3D"37" width=3D"0.1" height=3D"15.0" fill=3D"rgb(248,112,=
11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"359.69" y=3D"47.5" ></text>=0A</g>=
=0A<g >=0A<title>update_rq_clock (8,318,413,342 samples, 0.11%)</title><rec=
t x=3D"469.5" y=3D"197" width=3D"1.4" height=3D"15.0" fill=3D"rgb(215,163,2=
3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"472.53" y=3D"207.5" ></text>=0A</g>=
=0A<g >=0A<title>__x64_sys_write (20,586,608,396 samples, 0.28%)</title><re=
ct x=3D"656.6" y=3D"325" width=3D"3.4" height=3D"15.0" fill=3D"rgb(216,137,=
47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"659.64" y=3D"335.5" ></text>=0A</g>=
=0A<g >=0A<title>native_queued_spin_lock_slowpath (37,528,998,439 samples, =
0.51%)</title><rect x=3D"1022.0" y=3D"133" width=3D"6.1" height=3D"15.0" fi=
ll=3D"rgb(222,188,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1025.02" y=3D"143=
=2E5" ></text>=0A</g>=0A<g >=0A<title>put_pid (3,706,790,162 samples, 0.05%=
)</title><rect x=3D"330.2" y=3D"197" width=3D"0.6" height=3D"15.0" fill=3D"=
rgb(238,23,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"333.23" y=3D"207.5" ></t=
ext>=0A</g>=0A<g >=0A<title>drain_stock (725,997,871 samples, 0.01%)</title=
><rect x=3D"264.8" y=3D"165" width=3D"0.1" height=3D"15.0" fill=3D"rgb(234,=
37,19)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"267.83" y=3D"175.5" ></text>=0A<=
/g>=0A<g >=0A<title>ttwu_do_activate (62,754,327,884 samples, 0.86%)</title=
><rect x=3D"1131.8" y=3D"165" width=3D"10.2" height=3D"15.0" fill=3D"rgb(24=
2,57,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1134.83" y=3D"175.5" ></text>=
=0A</g>=0A<g >=0A<title>__lock_text_start (23,747,497,801 samples, 0.33%)</=
title><rect x=3D"810.9" y=3D"229" width=3D"3.8" height=3D"15.0" fill=3D"rgb=
(235,147,28)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"813.90" y=3D"239.5" ></tex=
t>=0A</g>=0A<g >=0A<title>__schedule (11,537,583,010 samples, 0.16%)</title=
><rect x=3D"605.0" y=3D"277" width=3D"1.8" height=3D"15.0" fill=3D"rgb(229,=
52,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"607.98" y=3D"287.5" ></text>=0A<=
/g>=0A<g >=0A<title>entry_SYSCALL_64_after_hwframe (9,941,767,670 samples, =
0.14%)</title><rect x=3D"1185.2" y=3D"389" width=3D"1.6" height=3D"15.0" fi=
ll=3D"rgb(240,168,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.19" y=3D"399=
=2E5" ></text>=0A</g>=0A<g >=0A<title>cpuidle_enter (1,296,957,193 samples,=
 0.02%)</title><rect x=3D"1189.6" y=3D"341" width=3D"0.2" height=3D"15.0" f=
ill=3D"rgb(210,129,35)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1192.60" y=3D"35=
1.5" ></text>=0A</g>=0A<g >=0A<title>update_curr (963,611,850 samples, 0.01=
%)</title><rect x=3D"1111.5" y=3D"149" width=3D"0.2" height=3D"15.0" fill=
=3D"rgb(249,208,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1114.50" y=3D"159.5=
" ></text>=0A</g>=0A<g >=0A<title>page_counter_uncharge (679,739,881 sample=
s, 0.01%)</title><rect x=3D"264.8" y=3D"149" width=3D"0.1" height=3D"15.0" =
fill=3D"rgb(240,172,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"267.84" y=3D"15=
9.5" ></text>=0A</g>=0A<g >=0A<title>__switch_to_asm (4,856,911,135 samples=
, 0.07%)</title><rect x=3D"1184.1" y=3D"389" width=3D"0.8" height=3D"15.0" =
fill=3D"rgb(239,15,5)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1187.08" y=3D"399=
=2E5" ></text>=0A</g>=0A<g >=0A<title>mod_memcg_state (6,753,148,042 sample=
s, 0.09%)</title><rect x=3D"987.9" y=3D"133" width=3D"1.1" height=3D"15.0" =
fill=3D"rgb(219,127,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"990.86" y=3D"14=
3.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_recvmsg (8,531,072,837 sam=
ples, 0.12%)</title><rect x=3D"1185.2" y=3D"309" width=3D"1.4" height=3D"15=
=2E0" fill=3D"rgb(218,174,21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1188.19" =
y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>switch_mm_irqs_off (728,908,817=
 samples, 0.01%)</title><rect x=3D"606.7" y=3D"261" width=3D"0.1" height=3D=
"15.0" fill=3D"rgb(209,210,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"609.72" =
y=3D"271.5" ></text>=0A</g>=0A<g >=0A<title>kmalloc_slab (12,040,559,099 sa=
mples, 0.17%)</title><rect x=3D"991.0" y=3D"181" width=3D"2.0" height=3D"15=
=2E0" fill=3D"rgb(214,32,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"994.01" y=
=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>simple_copy_to_iter (272,032,861=
,452 samples, 3.73%)</title><rect x=3D"544.5" y=3D"197" width=3D"44.0" heig=
ht=3D"15.0" fill=3D"rgb(235,161,41)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"547=
=2E49" y=3D"207.5" >simp..</text>=0A</g>=0A<g >=0A<title>__audit_syscall_ex=
it (15,016,048,654 samples, 0.21%)</title><rect x=3D"612.2" y=3D"293" width=
=3D"2.4" height=3D"15.0" fill=3D"rgb(251,173,6)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"615.19" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>obj_cgroup_unc=
harge_pages (25,918,108,448 samples, 0.36%)</title><rect x=3D"260.8" y=3D"1=
97" width=3D"4.1" height=3D"15.0" fill=3D"rgb(239,209,9)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"263.76" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>__sch=
edule (22,755,784,004 samples, 0.31%)</title><rect x=3D"1110.3" y=3D"197" w=
idth=3D"3.7" height=3D"15.0" fill=3D"rgb(243,174,32)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1113.30" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>exit_to=
_user_mode_prepare (1,410,694,833 samples, 0.02%)</title><rect x=3D"1186.6"=
 y=3D"341" width=3D"0.2" height=3D"15.0" fill=3D"rgb(252,185,18)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"1189.57" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>__slab_free (145,811,037,493 samples, 2.00%)</title><rect x=3D"152.0" y=
=3D"245" width=3D"23.6" height=3D"15.0" fill=3D"rgb(240,57,24)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"155.02" y=3D"255.5" >_..</text>=0A</g>=0A<g >=0A<ti=
tle>__rcu_read_lock (827,791,848 samples, 0.01%)</title><rect x=3D"442.7" y=
=3D"213" width=3D"0.1" height=3D"15.0" fill=3D"rgb(215,180,22)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"445.68" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title=
>kfree_skbmem (3,780,084,214 samples, 0.05%)</title><rect x=3D"357.7" y=3D"=
245" width=3D"0.6" height=3D"15.0" fill=3D"rgb(245,16,52)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"360.70" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>__sc=
hedule (8,531,072,837 samples, 0.12%)</title><rect x=3D"1185.2" y=3D"245" w=
idth=3D"1.4" height=3D"15.0" fill=3D"rgb(225,99,24)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1188.19" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>do_idle=
 (2,059,458,793 samples, 0.03%)</title><rect x=3D"1189.6" y=3D"357" width=
=3D"0.3" height=3D"15.0" fill=3D"rgb(235,8,53)" rx=3D"2" ry=3D"2" />=0A<tex=
t  x=3D"1192.58" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_lr=
uvec_state (3,196,771,876 samples, 0.04%)</title><rect x=3D"1091.9" y=3D"13=
3" width=3D"0.5" height=3D"15.0" fill=3D"rgb(219,9,43)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"1094.86" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__put_=
user_nocheck_8 (1,690,342,557 samples, 0.02%)</title><rect x=3D"604.3" y=3D=
"277" width=3D"0.3" height=3D"15.0" fill=3D"rgb(245,69,25)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"607.31" y=3D"287.5" ></text>=0A</g>=0A<g >=0A<title>sch=
edule (1,410,694,833 samples, 0.02%)</title><rect x=3D"1186.6" y=3D"325" wi=
dth=3D"0.2" height=3D"15.0" fill=3D"rgb(208,44,30)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"1189.57" y=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>vfs_read (=
8,531,072,837 samples, 0.12%)</title><rect x=3D"1185.2" y=3D"341" width=3D"=
1.4" height=3D"15.0" fill=3D"rgb(246,20,43)" rx=3D"2" ry=3D"2" />=0A<text  =
x=3D"1188.19" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_lock (1=
5,918,296,545 samples, 0.22%)</title><rect x=3D"186.3" y=3D"245" width=3D"2=
=2E6" height=3D"15.0" fill=3D"rgb(226,144,27)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"189.34" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>update_rq_clock =
(1,830,699,334 samples, 0.03%)</title><rect x=3D"1113.7" y=3D"181" width=3D=
"0.3" height=3D"15.0" fill=3D"rgb(249,181,12)" rx=3D"2" ry=3D"2" />=0A<text=
  x=3D"1116.68" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__rseq_handle_n=
otify_resume (2,042,589,303 samples, 0.03%)</title><rect x=3D"1163.4" y=3D"=
293" width=3D"0.3" height=3D"15.0" fill=3D"rgb(218,4,22)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1166.41" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>__rc=
u_read_lock (1,277,694,242 samples, 0.02%)</title><rect x=3D"959.1" y=3D"13=
3" width=3D"0.2" height=3D"15.0" fill=3D"rgb(227,46,41)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"962.09" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>refill=
_obj_stock (4,235,847,425 samples, 0.06%)</title><rect x=3D"989.0" y=3D"149=
" width=3D"0.6" height=3D"15.0" fill=3D"rgb(220,177,5)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"991.96" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>put_cpu=
_partial (3,459,083,949 samples, 0.05%)</title><rect x=3D"312.7" y=3D"213" =
width=3D"0.6" height=3D"15.0" fill=3D"rgb(229,76,50)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"315.74" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_re=
ad_unlock (5,394,130,461 samples, 0.07%)</title><rect x=3D"882.3" y=3D"149"=
 width=3D"0.9" height=3D"15.0" fill=3D"rgb(243,106,31)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"885.30" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>enqueue=
_task_fair (46,340,567,024 samples, 0.64%)</title><rect x=3D"1134.5" y=3D"1=
49" width=3D"7.5" height=3D"15.0" fill=3D"rgb(220,126,0)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1137.47" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>rewe=
ight_entity (7,471,591,857 samples, 0.10%)</title><rect x=3D"1138.3" y=3D"1=
33" width=3D"1.2" height=3D"15.0" fill=3D"rgb(248,98,49)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"1141.33" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__x8=
6_indirect_thunk_rax (4,806,428,590 samples, 0.07%)</title><rect x=3D"1179.=
5" y=3D"341" width=3D"0.8" height=3D"15.0" fill=3D"rgb(243,229,51)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"1182.52" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<=
title>_raw_spin_unlock (3,500,152,436 samples, 0.05%)</title><rect x=3D"188=
=2E9" y=3D"245" width=3D"0.6" height=3D"15.0" fill=3D"rgb(229,87,34)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"191.91" y=3D"255.5" ></text>=0A</g>=0A<g >=0A=
<title>native_queued_spin_lock_slowpath (39,999,923,777 samples, 0.55%)</ti=
tle><rect x=3D"179.8" y=3D"213" width=3D"6.5" height=3D"15.0" fill=3D"rgb(2=
34,66,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"182.84" y=3D"223.5" ></text>=
=0A</g>=0A<g >=0A<title>__list_del_entry_valid (824,569,634 samples, 0.01%)=
</title><rect x=3D"1126.2" y=3D"181" width=3D"0.2" height=3D"15.0" fill=3D"=
rgb(236,129,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1129.23" y=3D"191.5" ><=
/text>=0A</g>=0A<g >=0A<title>__mod_memcg_lruvec_state (3,786,157,980 sampl=
es, 0.05%)</title><rect x=3D"959.6" y=3D"117" width=3D"0.6" height=3D"15.0"=
 fill=3D"rgb(252,148,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"962.57" y=3D"1=
27.5" ></text>=0A</g>=0A<g >=0A<title>__check_object_size (116,215,414,253 =
samples, 1.59%)</title><rect x=3D"766.4" y=3D"229" width=3D"18.8" height=3D=
"15.0" fill=3D"rgb(213,173,26)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"769.37" =
y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__mod_memcg_state (1,738,275,23=
5 samples, 0.02%)</title><rect x=3D"443.7" y=3D"181" width=3D"0.3" height=
=3D"15.0" fill=3D"rgb(206,117,6)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"446.73=
" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>switch_mm_irqs_off (7,756,123=
,937 samples, 0.11%)</title><rect x=3D"1185.3" y=3D"229" width=3D"1.3" heig=
ht=3D"15.0" fill=3D"rgb(231,208,27)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"118=
8.32" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>rb_insert_color (684,720,=
763 samples, 0.01%)</title><rect x=3D"1137.0" y=3D"117" width=3D"0.1" heigh=
t=3D"15.0" fill=3D"rgb(221,58,31)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1139.=
98" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (2,370,829,=
836 samples, 0.03%)</title><rect x=3D"261.8" y=3D"181" width=3D"0.3" height=
=3D"15.0" fill=3D"rgb(247,137,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"264.7=
5" y=3D"191.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_read_lock (38,485,878,=
850 samples, 0.53%)</title><rect x=3D"399.5" y=3D"229" width=3D"6.3" height=
=3D"15.0" fill=3D"rgb(226,17,13)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"402.53=
" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>unix_stream_sendmsg (2,615,55=
7,981,795 samples, 35.85%)</title><rect x=3D"726.4" y=3D"261" width=3D"423.=
0" height=3D"15.0" fill=3D"rgb(223,54,38)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"729.37" y=3D"271.5" >unix_stream_sendmsg</text>=0A</g>=0A<g >=0A<title>=
check_stack_object (8,606,128,060 samples, 0.12%)</title><rect x=3D"586.0" =
y=3D"165" width=3D"1.4" height=3D"15.0" fill=3D"rgb(208,174,33)" rx=3D"2" r=
y=3D"2" />=0A<text  x=3D"588.97" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<titl=
e>_raw_spin_lock (15,604,148,684 samples, 0.21%)</title><rect x=3D"1127.7" =
y=3D"165" width=3D"2.5" height=3D"15.0" fill=3D"rgb(249,95,2)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1130.70" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__x86_indirect_thunk_rax (34,826,964,944 samples, 0.48%)</title><rect x=
=3D"39.9" y=3D"357" width=3D"5.7" height=3D"15.0" fill=3D"rgb(241,23,48)" r=
x=3D"2" ry=3D"2" />=0A<text  x=3D"42.93" y=3D"367.5" ></text>=0A</g>=0A<g >=
=0A<title>schedule (23,122,413,978 samples, 0.32%)</title><rect x=3D"1110.2=
" y=3D"213" width=3D"3.8" height=3D"15.0" fill=3D"rgb(207,208,29)" rx=3D"2"=
 ry=3D"2" />=0A<text  x=3D"1113.24" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<t=
itle>vfs_write (3,021,519,057 samples, 0.04%)</title><rect x=3D"1188.6" y=
=3D"341" width=3D"0.5" height=3D"15.0" fill=3D"rgb(219,28,11)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1191.60" y=3D"351.5" ></text>=0A</g>=0A<g >=0A<titl=
e>pick_next_entity (771,085,923 samples, 0.01%)</title><rect x=3D"1112.5" y=
=3D"165" width=3D"0.1" height=3D"15.0" fill=3D"rgb(238,105,51)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1115.47" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<titl=
e>cgroup_rstat_updated (1,507,952,127 samples, 0.02%)</title><rect x=3D"988=
=2E7" y=3D"101" width=3D"0.3" height=3D"15.0" fill=3D"rgb(224,56,43)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"991.71" y=3D"111.5" ></text>=0A</g>=0A<g >=0A=
<title>ttwu_do_wakeup (732,771,795 samples, 0.01%)</title><rect x=3D"357.3"=
 y=3D"101" width=3D"0.1" height=3D"15.0" fill=3D"rgb(221,9,27)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"360.25" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title=
>__kmalloc_node_track_caller (948,909,962,668 samples, 13.01%)</title><rect=
 x=3D"839.5" y=3D"197" width=3D"153.5" height=3D"15.0" fill=3D"rgb(208,86,3=
4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"842.47" y=3D"207.5" >__kmalloc_node_=
trac..</text>=0A</g>=0A<g >=0A<title>put_prev_entity (1,183,675,958 samples=
, 0.02%)</title><rect x=3D"464.7" y=3D"181" width=3D"0.2" height=3D"15.0" f=
ill=3D"rgb(218,214,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"467.72" y=3D"191=
=2E5" ></text>=0A</g>=0A<g >=0A<title>security_socket_getpeersec_dgram (32,=
988,821,630 samples, 0.45%)</title><rect x=3D"756.9" y=3D"245" width=3D"5.3=
" height=3D"15.0" fill=3D"rgb(241,38,26)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"759.90" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>kfree (13,244,382,1=
52 samples, 0.18%)</title><rect x=3D"310.6" y=3D"213" width=3D"2.1" height=
=3D"15.0" fill=3D"rgb(225,90,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"313.59"=
 y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>native_queued_spin_lock_slowpa=
th (1,413,541,672 samples, 0.02%)</title><rect x=3D"605.4" y=3D"245" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(232,60,28)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"608.37" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>mod_objcg_stat=
e (49,328,178,860 samples, 0.68%)</title><rect x=3D"434.1" y=3D"229" width=
=3D"8.0" height=3D"15.0" fill=3D"rgb(253,18,45)" rx=3D"2" ry=3D"2" />=0A<te=
xt  x=3D"437.07" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>__calc_delta (=
1,953,246,720 samples, 0.03%)</title><rect x=3D"458.8" y=3D"149" width=3D"0=
=2E3" height=3D"15.0" fill=3D"rgb(249,59,31)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"461.81" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<title>entry_SYSCALL_64_=
safe_stack (8,471,694,987 samples, 0.12%)</title><rect x=3D"622.5" y=3D"357=
" width=3D"1.4" height=3D"15.0" fill=3D"rgb(238,61,50)" rx=3D"2" ry=3D"2" /=
>=0A<text  x=3D"625.48" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<title>vfs_rea=
d (3,243,622,038,196 samples, 44.46%)</title><rect x=3D"63.8" y=3D"309" wid=
th=3D"524.7" height=3D"15.0" fill=3D"rgb(212,223,47)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"66.85" y=3D"319.5" >vfs_read</text>=0A</g>=0A<g >=0A<title>p=
si_account_irqtime (6,887,662,174 samples, 0.09%)</title><rect x=3D"1144.1"=
 y=3D"149" width=3D"1.1" height=3D"15.0" fill=3D"rgb(245,179,26)" rx=3D"2" =
ry=3D"2" />=0A<text  x=3D"1147.07" y=3D"159.5" ></text>=0A</g>=0A<g >=0A<ti=
tle>schedule (12,120,539,340 samples, 0.17%)</title><rect x=3D"604.9" y=3D"=
293" width=3D"1.9" height=3D"15.0" fill=3D"rgb(214,37,32)" rx=3D"2" ry=3D"2=
" />=0A<text  x=3D"607.88" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>upda=
te_load_avg (4,446,037,180 samples, 0.06%)</title><rect x=3D"457.3" y=3D"16=
5" width=3D"0.7" height=3D"15.0" fill=3D"rgb(245,221,31)" rx=3D"2" ry=3D"2"=
 />=0A<text  x=3D"460.32" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>sysca=
ll_return_via_sysret (14,772,246,002 samples, 0.20%)</title><rect x=3D"624.=
8" y=3D"357" width=3D"2.4" height=3D"15.0" fill=3D"rgb(232,103,10)" rx=3D"2=
" ry=3D"2" />=0A<text  x=3D"627.78" y=3D"367.5" ></text>=0A</g>=0A<g >=0A<t=
itle>update_cfs_group (4,611,663,556 samples, 0.06%)</title><rect x=3D"1139=
=2E5" y=3D"133" width=3D"0.8" height=3D"15.0" fill=3D"rgb(220,65,16)" rx=3D=
"2" ry=3D"2" />=0A<text  x=3D"1142.54" y=3D"143.5" ></text>=0A</g>=0A<g >=
=0A<title>__x86_indirect_thunk_rax (1,375,660,436 samples, 0.02%)</title><r=
ect x=3D"726.1" y=3D"229" width=3D"0.3" height=3D"15.0" fill=3D"rgb(252,105=
,23)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"729.13" y=3D"239.5" ></text>=0A</g=
>=0A<g >=0A<title>__unfreeze_partials (67,953,268,647 samples, 0.93%)</titl=
e><rect x=3D"299.6" y=3D"213" width=3D"10.9" height=3D"15.0" fill=3D"rgb(24=
2,99,53)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"302.56" y=3D"223.5" ></text>=
=0A</g>=0A<g >=0A<title>skb_copy_datagram_from_iter (273,809,520,128 sample=
s, 3.75%)</title><rect x=3D"762.2" y=3D"245" width=3D"44.3" height=3D"15.0"=
 fill=3D"rgb(215,150,38)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"765.23" y=3D"2=
55.5" >skb_..</text>=0A</g>=0A<g >=0A<title>__lock_text_start (44,416,769,0=
50 samples, 0.61%)</title><rect x=3D"867.9" y=3D"133" width=3D"7.2" height=
=3D"15.0" fill=3D"rgb(229,106,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"870.9=
5" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>pick_next_task_fair (16,444,=
238,754 samples, 0.23%)</title><rect x=3D"463.2" y=3D"197" width=3D"2.7" he=
ight=3D"15.0" fill=3D"rgb(225,196,15)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"4=
66.23" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title>sock_alloc_send_pskb (1,=
876,623,952,478 samples, 25.72%)</title><rect x=3D"814.7" y=3D"245" width=
=3D"303.6" height=3D"15.0" fill=3D"rgb(218,228,27)" rx=3D"2" ry=3D"2" />=0A=
<text  x=3D"817.74" y=3D"255.5" >sock_alloc_send_pskb</text>=0A</g>=0A<g >=
=0A<title>cgroup_rstat_updated (954,596,714 samples, 0.01%)</title><rect x=
=3D"960.0" y=3D"101" width=3D"0.2" height=3D"15.0" fill=3D"rgb(222,95,35)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"963.03" y=3D"111.5" ></text>=0A</g>=0A<g=
 >=0A<title>mod_memcg_lruvec_state (7,178,327,773 samples, 0.10%)</title><r=
ect x=3D"440.9" y=3D"213" width=3D"1.2" height=3D"15.0" fill=3D"rgb(227,42,=
21)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"443.89" y=3D"223.5" ></text>=0A</g>=
=0A<g >=0A<title>update_load_avg (3,700,577,581 samples, 0.05%)</title><rec=
t x=3D"1137.7" y=3D"117" width=3D"0.6" height=3D"15.0" fill=3D"rgb(208,137,=
54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1140.73" y=3D"127.5" ></text>=0A</g=
>=0A<g >=0A<title>sock_write_iter (2,772,433,061,603 samples, 38.00%)</titl=
e><rect x=3D"701.0" y=3D"293" width=3D"448.4" height=3D"15.0" fill=3D"rgb(2=
26,204,39)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"703.99" y=3D"303.5" >sock_wr=
ite_iter</text>=0A</g>=0A<g >=0A<title>__audit_syscall_entry (22,155,436,16=
6 samples, 0.30%)</title><rect x=3D"617.8" y=3D"309" width=3D"3.5" height=
=3D"15.0" fill=3D"rgb(233,7,9)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"620.75" =
y=3D"319.5" ></text>=0A</g>=0A<g >=0A<title>update_load_avg (10,427,361,632=
 samples, 0.14%)</title><rect x=3D"1140.3" y=3D"133" width=3D"1.7" height=
=3D"15.0" fill=3D"rgb(250,121,45)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1143.=
28" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>__wake_up_common (123,383,9=
82,181 samples, 1.69%)</title><rect x=3D"1125.5" y=3D"213" width=3D"19.9" h=
eight=3D"15.0" fill=3D"rgb(213,4,11)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
28.48" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>select_task_rq_fair (1,5=
04,903,751 samples, 0.02%)</title><rect x=3D"355.0" y=3D"101" width=3D"0.2"=
 height=3D"15.0" fill=3D"rgb(237,44,42)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"357.97" y=3D"111.5" ></text>=0A</g>=0A<g >=0A<title>__wake_up_common_lock =
(18,437,148,592 samples, 0.25%)</title><rect x=3D"354.6" y=3D"165" width=3D=
"3.0" height=3D"15.0" fill=3D"rgb(235,91,47)" rx=3D"2" ry=3D"2" />=0A<text =
 x=3D"357.64" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>audit_reset_conte=
xt (6,436,876,553 samples, 0.09%)</title><rect x=3D"1169.7" y=3D"293" width=
=3D"1.0" height=3D"15.0" fill=3D"rgb(207,182,54)" rx=3D"2" ry=3D"2" />=0A<t=
ext  x=3D"1172.66" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>autoremove_w=
ake_function (18,257,513,956 samples, 0.25%)</title><rect x=3D"354.7" y=3D"=
133" width=3D"2.9" height=3D"15.0" fill=3D"rgb(244,112,40)" rx=3D"2" ry=3D"=
2" />=0A<text  x=3D"357.66" y=3D"143.5" ></text>=0A</g>=0A<g >=0A<title>sel=
ect_task_rq_fair (9,120,451,518 samples, 0.13%)</title><rect x=3D"1130.3" y=
=3D"165" width=3D"1.4" height=3D"15.0" fill=3D"rgb(234,50,31)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"1133.26" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<titl=
e>__rcu_read_lock (39,287,610,896 samples, 0.54%)</title><rect x=3D"244.6" =
y=3D"197" width=3D"6.3" height=3D"15.0" fill=3D"rgb(223,225,4)" rx=3D"2" ry=
=3D"2" />=0A<text  x=3D"247.56" y=3D"207.5" ></text>=0A</g>=0A<g >=0A<title=
>syscall_exit_to_user_mode (1,040,414,087 samples, 0.01%)</title><rect x=3D=
"1189.1" y=3D"357" width=3D"0.2" height=3D"15.0" fill=3D"rgb(213,187,8)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1192.09" y=3D"367.5" ></text>=0A</g>=0A<g =
>=0A<title>native_sched_clock (1,136,197,631 samples, 0.02%)</title><rect x=
=3D"1145.0" y=3D"117" width=3D"0.2" height=3D"15.0" fill=3D"rgb(209,202,37)=
" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1148.00" y=3D"127.5" ></text>=0A</g>=
=0A<g >=0A<title>should_failslab (1,234,547,921 samples, 0.02%)</title><rec=
t x=3D"990.8" y=3D"165" width=3D"0.2" height=3D"15.0" fill=3D"rgb(254,208,5=
1)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"993.81" y=3D"175.5" ></text>=0A</g>=
=0A<g >=0A<title>schedule (5,405,288,923 samples, 0.07%)</title><rect x=3D"=
1163.8" y=3D"293" width=3D"0.9" height=3D"15.0" fill=3D"rgb(243,33,54)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1166.82" y=3D"303.5" ></text>=0A</g>=0A<g =
>=0A<title>__virt_addr_valid (42,206,601,577 samples, 0.58%)</title><rect x=
=3D"579.0" y=3D"165" width=3D"6.9" height=3D"15.0" fill=3D"rgb(234,75,53)" =
rx=3D"2" ry=3D"2" />=0A<text  x=3D"582.03" y=3D"175.5" ></text>=0A</g>=0A<g=
 >=0A<title>__rdgsbase_inactive (1,408,939,826 samples, 0.02%)</title><rect=
 x=3D"1183.3" y=3D"389" width=3D"0.2" height=3D"15.0" fill=3D"rgb(242,201,4=
4)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1186.31" y=3D"399.5" ></text>=0A</g>=
=0A<g >=0A<title>__x86_indirect_thunk_rax (5,742,218,511 samples, 0.08%)</t=
itle><rect x=3D"649.5" y=3D"357" width=3D"0.9" height=3D"15.0" fill=3D"rgb(=
230,222,36)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"652.50" y=3D"367.5" ></text=
>=0A</g>=0A<g >=0A<title>mutex_lock (16,195,520,501 samples, 0.22%)</title>=
<rect x=3D"447.0" y=3D"245" width=3D"2.6" height=3D"15.0" fill=3D"rgb(214,1=
81,51)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"449.99" y=3D"255.5" ></text>=0A<=
/g>=0A<g >=0A<title>__slab_free (195,587,459,809 samples, 2.68%)</title><re=
ct x=3D"267.9" y=3D"213" width=3D"31.7" height=3D"15.0" fill=3D"rgb(250,144=
,30)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"270.92" y=3D"223.5" >__..</text>=
=0A</g>=0A<g >=0A<title>syscall_trace_enter.constprop.0 (43,563,380,904 sam=
ples, 0.60%)</title><rect x=3D"1170.7" y=3D"325" width=3D"7.1" height=3D"15=
=2E0" fill=3D"rgb(218,86,54)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1173.70" y=
=3D"335.5" ></text>=0A</g>=0A<g >=0A<title>bpf_lsm_socket_recvmsg (11,376,6=
47,051 samples, 0.16%)</title><rect x=3D"110.0" y=3D"245" width=3D"1.9" hei=
ght=3D"15.0" fill=3D"rgb(217,143,6)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"113=
=2E04" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>_raw_spin_unlock_irqrest=
ore (2,364,960,954 samples, 0.03%)</title><rect x=3D"1145.4" y=3D"213" widt=
h=3D"0.4" height=3D"15.0" fill=3D"rgb(235,139,30)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1148.44" y=3D"223.5" ></text>=0A</g>=0A<g >=0A<title>get_partial=
_node (81,160,472,435 samples, 1.11%)</title><rect x=3D"1015.1" y=3D"165" w=
idth=3D"13.2" height=3D"15.0" fill=3D"rgb(218,44,7)" rx=3D"2" ry=3D"2" />=
=0A<text  x=3D"1018.14" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__rcu_r=
ead_unlock (6,786,680,293 samples, 0.09%)</title><rect x=3D"405.8" y=3D"229=
" width=3D"1.1" height=3D"15.0" fill=3D"rgb(231,169,26)" rx=3D"2" ry=3D"2" =
/>=0A<text  x=3D"408.76" y=3D"239.5" ></text>=0A</g>=0A<g >=0A<title>bpf_ls=
m_socket_getpeersec_dgram (12,777,865,712 samples, 0.18%)</title><rect x=3D=
"760.2" y=3D"229" width=3D"2.0" height=3D"15.0" fill=3D"rgb(220,57,0)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"763.17" y=3D"239.5" ></text>=0A</g>=0A<g >=
=0A<title>__rcu_read_unlock (49,463,043,212 samples, 0.68%)</title><rect x=
=3D"938.4" y=3D"149" width=3D"8.0" height=3D"15.0" fill=3D"rgb(232,169,30)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"941.39" y=3D"159.5" ></text>=0A</g>=0A<=
g >=0A<title>place_entity (1,409,054,445 samples, 0.02%)</title><rect x=3D"=
1136.8" y=3D"117" width=3D"0.2" height=3D"15.0" fill=3D"rgb(233,199,37)" rx=
=3D"2" ry=3D"2" />=0A<text  x=3D"1139.75" y=3D"127.5" ></text>=0A</g>=0A<g =
>=0A<title>__get_task_ioprio (16,565,588,500 samples, 0.23%)</title><rect x=
=3D"692.1" y=3D"293" width=3D"2.7" height=3D"15.0" fill=3D"rgb(213,141,48)"=
 rx=3D"2" ry=3D"2" />=0A<text  x=3D"695.10" y=3D"303.5" ></text>=0A</g>=0A<=
g >=0A<title>load_balance (921,354,136 samples, 0.01%)</title><rect x=3D"46=
4.0" y=3D"165" width=3D"0.1" height=3D"15.0" fill=3D"rgb(206,54,42)" rx=3D"=
2" ry=3D"2" />=0A<text  x=3D"466.96" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<=
title>__rseq_handle_notify_resume (12,932,834,096 samples, 0.18%)</title><r=
ect x=3D"602.5" y=3D"293" width=3D"2.1" height=3D"15.0" fill=3D"rgb(220,94,=
10)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"605.49" y=3D"303.5" ></text>=0A</g>=
=0A<g >=0A<title>cgroup_rstat_updated (1,143,968,148 samples, 0.02%)</title=
><rect x=3D"263.9" y=3D"133" width=3D"0.2" height=3D"15.0" fill=3D"rgb(254,=
70,29)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"266.92" y=3D"143.5" ></text>=0A<=
/g>=0A<g >=0A<title>__rcu_read_lock (728,366,867 samples, 0.01%)</title><re=
ct x=3D"1106.6" y=3D"165" width=3D"0.1" height=3D"15.0" fill=3D"rgb(212,98,=
12)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1109.56" y=3D"175.5" ></text>=0A</g=
>=0A<g >=0A<title>syscall_exit_to_user_mode_prepare (34,034,016,031 samples=
, 0.47%)</title><rect x=3D"1165.2" y=3D"309" width=3D"5.5" height=3D"15.0" =
fill=3D"rgb(227,86,18)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1168.20" y=3D"31=
9.5" ></text>=0A</g>=0A<g >=0A<title>__get_obj_cgroup_from_memcg (24,548,67=
1,807 samples, 0.34%)</title><rect x=3D"1034.8" y=3D"165" width=3D"3.9" hei=
ght=3D"15.0" fill=3D"rgb(238,170,7)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"103=
7.77" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>psi_group_change (3,013,9=
53,670 samples, 0.04%)</title><rect x=3D"1113.1" y=3D"165" width=3D"0.5" he=
ight=3D"15.0" fill=3D"rgb(226,157,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"11=
16.08" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>default_send_IPI_single_=
phys (3,492,399,515 samples, 0.05%)</title><rect x=3D"1142.7" y=3D"117" wid=
th=3D"0.5" height=3D"15.0" fill=3D"rgb(216,26,39)" rx=3D"2" ry=3D"2" />=0A<=
text  x=3D"1145.68" y=3D"127.5" ></text>=0A</g>=0A<g >=0A<title>update_load=
_avg (1,093,423,597 samples, 0.01%)</title><rect x=3D"356.4" y=3D"53" width=
=3D"0.2" height=3D"15.0" fill=3D"rgb(243,2,12)" rx=3D"2" ry=3D"2" />=0A<tex=
t  x=3D"359.39" y=3D"63.5" ></text>=0A</g>=0A<g >=0A<title>skb_unlink (54,7=
39,525,936 samples, 0.75%)</title><rect x=3D"473.5" y=3D"245" width=3D"8.8"=
 height=3D"15.0" fill=3D"rgb(215,214,43)" rx=3D"2" ry=3D"2" />=0A<text  x=
=3D"476.47" y=3D"255.5" ></text>=0A</g>=0A<g >=0A<title>rw_verify_area (3,3=
76,550,556 samples, 0.05%)</title><rect x=3D"84.5" y=3D"293" width=3D"0.6" =
height=3D"15.0" fill=3D"rgb(236,172,37)" rx=3D"2" ry=3D"2" />=0A<text  x=3D=
"87.53" y=3D"303.5" ></text>=0A</g>=0A<g >=0A<title>update_rq_clock (10,817=
,328,571 samples, 0.15%)</title><rect x=3D"1143.7" y=3D"165" width=3D"1.7" =
height=3D"15.0" fill=3D"rgb(233,185,3)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"=
1146.69" y=3D"175.5" ></text>=0A</g>=0A<g >=0A<title>__cond_resched (1,830,=
503,434 samples, 0.03%)</title><rect x=3D"1149.1" y=3D"229" width=3D"0.3" h=
eight=3D"15.0" fill=3D"rgb(250,19,47)" rx=3D"2" ry=3D"2" />=0A<text  x=3D"1=
152.13" y=3D"239.5" ></text>=0A</g>=0A</g>=0A</svg>=0A
--oudKfyDVtxiFA6ja--
