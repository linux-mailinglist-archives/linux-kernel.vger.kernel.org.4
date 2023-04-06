Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B916D8E73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjDFEoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjDFEoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:44:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C472A3;
        Wed,  5 Apr 2023 21:44:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so146353338ede.8;
        Wed, 05 Apr 2023 21:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680756258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xjmsZjVp+RHs53GtXmmi/MP0iaPYipjPhPYHzuWzSjY=;
        b=cshu7b59hlBuIgkp7jFp8eXASNV+7N8rZcktacOvUJtMb+N4yNXilVLl+b4JadkAPT
         3zmaYCH/aerIPEjWpptkuPOsuWenQI+7oHuBMhVVECRo/yf29sLGO6y9S8CkiwiXN06/
         QtI7ZdJ4Pddwy2dn/c4BAzZr233KsI78UamYnKHtiOKRN7k7gpaGE8no9TFETtjmc9M1
         rMESFHm8pc7F9a/hpKjH9CGdS54PhJTxauaAcoG2zkqX51oo1T4L2tsBScnCswtn4Bz8
         AU9Oo82AUAGRFBQzq2bLuaw0+f5Pg6OITfMeVsnGRlEk2kd7GKdU8r7yp45YwTlj4vwt
         QhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680756258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjmsZjVp+RHs53GtXmmi/MP0iaPYipjPhPYHzuWzSjY=;
        b=PLOrkX8dhAxFyWMpMIJLXtaIsaxCBf+SltpwN4fE/jHPCSN0+PDU9ONQ4UDhdr4eO3
         IOWgANP3kvPdpxVeBJDTLeNDpLe3+XRQJAV0Do20XBKERQVzjb0wXr2soU3JaEeHcrpd
         if7u/DHWo48p/1YiEVuY5l3OX5SqTrjIdL1DO/ZiAJwCRNAFKtMxJU+0agO1mhzhmpEm
         VOu652pJ9ZRExeFGAkBYySX2PuM5cZT997izi/dPlxHN7O7IpEzEI6Wxmlz2YeqxPyop
         ck0MxZ2viYKz8vrtTkN9ALUThfKBkFqLXhGc8qp5zNwIloArcFxNDWSk7aYHQu2X/Qdi
         zaMw==
X-Gm-Message-State: AAQBX9dtx2Z+zNZw3y5OLCfUWaBsyEDXwpmZW06dXEFVImNCIVIOAnLV
        CA/M5ZsljLxPVR99XIKmN3M=
X-Google-Smtp-Source: AKy350ZN437sTJUSZ6gY/twKBNbJVaGx2wJWaBVDCkFWctWhRKgKIoe51BdBQHlPGw7uf+ri69vFdg==
X-Received: by 2002:a17:906:b88a:b0:92e:b1dd:cff2 with SMTP id hb10-20020a170906b88a00b0092eb1ddcff2mr4552948ejb.28.1680756258204;
        Wed, 05 Apr 2023 21:44:18 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090671d100b0092973e209f2sm254503ejk.109.2023.04.05.21.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:44:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 6 Apr 2023 06:44:15 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
        =?utf-8?B?6L6b5L6d5YehIChZaWZhbiBYaW4p?= <Yifan.Xin@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= 
        <Xuewen.Yan@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= 
        <Zhiguo.Niu@unisoc.com>,
        =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjJdIHJj?=
 =?utf-8?Q?u=3A_Make_sure_new_krc?= =?utf-8?Q?p?= free business is handled
 after the wanted rcu grace period.
Message-ID: <ZC5OHyre9C/lDuno@pc636>
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
 <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
 <CAEXW_YRtV7pAYR-UyVNNsgPJ2dmBGrV+DkNROOivXj3MChDgGw@mail.gmail.com>
 <a1e006af-c935-4246-a239-669debb4717d@paulmck-laptop>
 <94c28b46617e46d1804a397a54f9fd8d@BJMBX01.spreadtrum.com>
 <6ff4eb09-13df-403f-ba4a-c5abb0f3fa8f@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ff4eb09-13df-403f-ba4a-c5abb0f3fa8f@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:46:15PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 06, 2023 at 01:38:09AM +0000, 代子为 (Ziwei Dai) wrote:
> > 
> > 
> > > -----邮件原件-----
> > > 发件人: Paul E. McKenney <paulmck@kernel.org>
> > > 发送时间: 2023年4月6日 2:46
> > > 收件人: Joel Fernandes <joel@joelfernandes.org>
> > > 抄送: 代子为 (Ziwei Dai) <Ziwei.Dai@unisoc.com>; urezki@gmail.com; frederic@kernel.org; quic_neeraju@quicinc.com;
> > > josh@joshtriplett.org; rostedt@goodmis.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; rcu@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; 王双 (Shuang Wang) <shuang.wang@unisoc.com>; 辛依凡 (Yifan Xin) <Yifan.Xin@unisoc.com>; 王科
> > > (Ke Wang) <Ke.Wang@unisoc.com>; 闫学文 (Xuewen Yan) <Xuewen.Yan@unisoc.com>; 牛志国 (Zhiguo Niu)
> > > <Zhiguo.Niu@unisoc.com>; 黄朝阳 (Zhaoyang Huang) <zhaoyang.huang@unisoc.com>
> > > 主题: Re: [PATCH V2] rcu: Make sure new krcp free business is handled after the wanted rcu grace period.
> > > 
> > > 
> > > 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the
> > > sender and know the content is safe.
> > > 
> > > 
> > > 
> > > On Wed, Apr 05, 2023 at 02:12:02PM -0400, Joel Fernandes wrote:
> > > > On Wed, Apr 5, 2023 at 1:39 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Fri, Mar 31, 2023 at 8:43 AM Ziwei Dai <ziwei.dai@unisoc.com> wrote:
> > > > > >
> > > > > > In kfree_rcu_monitor(), new free business at krcp is attached to
> > > > > > any free channel at krwp. kfree_rcu_monitor() is responsible to
> > > > > > make sure new free business is handled after the rcu grace period.
> > > > > > But if there is any none-free channel at krwp already, that means
> > > > > > there is an on-going rcu work, which will cause the
> > > > > > kvfree_call_rcu()-triggered free business is done before the wanted rcu grace period ends.
> > > > > >
> > > > > > This commit ignore krwp which has non-free channel at
> > > > > > kfree_rcu_monitor(), to fix the issue that kvfree_call_rcu() loses effectiveness.
> > > > > >
> > > > > > Below is the css_set obj "from_cset" use-after-free case caused by
> > > > > > kvfree_call_rcu() losing effectiveness.
> > > > > > CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq
> > > > > > comes, the task is schedule out.
> > > > > > CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
> > > > > > But "from_cset" is freed right after current gp end. "from_cset" is reallocated.
> > > > > > CPU 0 's task arrives back, references "from_cset"'s member, which causes crash.
> > > > > >
> > > > > > CPU 0                                   CPU 1
> > > > > > count_memcg_event_mm()
> > > > > > |rcu_read_lock()  <---
> > > > > > |mem_cgroup_from_task()
> > > > > >  |// css_set_ptr is the "from_cset" mentioned on CPU 1
> > > > > > |css_set_ptr = rcu_dereference((task)->cgroups)  |// Hard irq
> > > > > > comes, current task is scheduled out.
> > > > > >
> > > > > >                                         cgroup_attach_task()
> > > > > >                                         |cgroup_migrate()
> > > > > >                                         |cgroup_migrate_execute()
> > > > > >                                         |css_set_move_task(task, from_cset, to_cset, true)
> > > > > >                                         |cgroup_move_task(task, to_cset)
> > > > > >                                         |rcu_assign_pointer(.., to_cset)
> > > > > >                                         |...
> > > > > >                                         |cgroup_migrate_finish()
> > > > > >                                         |put_css_set_locked(from_cset)
> > > > > >                                         |from_cset->refcount return 0
> > > > > >                                         |kfree_rcu(cset, rcu_head) // means to free from_cset after new gp
> > > > > >                                         |add_ptr_to_bulk_krc_lock()
> > > > > >
> > > > > > |schedule_delayed_work(&krcp->monitor_work, ..)
> > > > > >
> > > > > >                                         kfree_rcu_monitor()
> > > > > >                                         |krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
> > > > > >                                         |queue_rcu_work(system_wq, &krwp->rcu_work)
> > > > > >                                         |if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
> > > > > >                                         |call_rcu(&rwork->rcu,
> > > > > > rcu_work_rcufn) <--- request a new gp
> > > > > >
> > > > > >                                         // There is a perious call_rcu(.., rcu_work_rcufn)
> > > > > >                                         // gp end, rcu_work_rcufn() is called.
> > > > > >                                         rcu_work_rcufn()
> > > > > >                                         |__queue_work(..,
> > > > > > rwork->wq, &rwork->work);
> > > > > >
> > > > > >                                         |kfree_rcu_work()
> > > > > >                                         |krwp->bulk_head_free[0] bulk is freed before new gp end!!!
> > > > > >                                         |The "from_cset" is freed before new gp end.
> > > > > >
> > > > > > // the task is scheduled in after many ms.
> > > > > >  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.
> > > > > >
> > > > > > v2: Use helper function instead of inserted code block at kfree_rcu_monitor().
> > > > > >
> > > > > > Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of
> > > > > > kfree_rcu() work")
> > > > > > Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> > > > >
> > > > > Please update the fixes tag to:
> > > > > 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")
> > > >
> > > > Vlad pointed out in another thread that the fix is actually to 34c881745549.
> > > >
> > > > So just to be sure, it could be updated to:
> > > > Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in
> > > > kfree_rcu()")
> > > > Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc
> > > > ptrs")
> > > 
> > > Ziwei Dai, does this change in Fixes look good to you?
> > > 
> > > If so, I will update the commit log in this commit that I am planning to submit into v6.3.  It is strictly speaking not a v6.3 regression,
> > > but it is starting to show up in the wild and the patch is contained enough to be considered an urgent fix.
> > > 
> > >                                                         Thanx, Paul
> > 
> > Hi Paul, it looks good to me and thanks!
> 
> Thank you, and I will fix on my next rebase.
> 
After heavy testing over night i do not see that any warnings
are triggered:

Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
