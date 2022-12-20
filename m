Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19C652773
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiLTT4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiLTT4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:56:21 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA111AD83
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:55:46 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o127so14162132yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T6Ibv8lELNGtBRxXq2xqbZ6XNIWdISjKd5l36khEMAE=;
        b=KSZwcjFTFFO55WSmVmRgONnRwskWoYawCL4xr2GcTp5EfCyO5dWsx7AbSD6Ir/ybby
         C7hVXroJGbjMZ6JZecHbZizIkqMntO9LCfTQjh70KYV62x3n7GT3pigY+IdDXJ6+hW0U
         mEwxE2cJuzhZ473p3CRLSLMKt5y1k+WqODiXLaurmLprlQIu83KIRui/7aB62vVSerFG
         oJ6BbA0p2cayN9RAavaPE83CL3JFmwg8mr83/EY4R4NMFXcDSamu5fqDMXFsJi4+yNTL
         KYFBpfYMu9bW5ttoTGe9B6d7fqichfkqe1iiFZLjZZbtB+BAkuBEyxDREF+RcnvyviBH
         sPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6Ibv8lELNGtBRxXq2xqbZ6XNIWdISjKd5l36khEMAE=;
        b=cKl/QcID0eCwTdQjsiuUKw/ag1tpk9nXVMen7UWXDzWjsJu2eR5JsxPWf536jRUQZZ
         RvQAjvb8r5519/qJHp/bh0/+ssNUAYl+JJkWsavharmKfSrpBkVGmhtGD7eCEHtgcRsT
         j2BDNDsKhVDliRq5jmZ4JcdShRAqdwsvbmQOysODozzjt7Q0W0BgzHCGrNyEwSRyvkWR
         pT2fwDz7LuI6n89f2YAWY8LUj6RaA1QyQaTeimeiAbtG1hse9LmsxwukyaBMscg+9i9h
         m0aG9VYnSYFwUJuq2akxPl8NFENZ4n2z/nHspMa1Yq9iihDIKoEsxvELbzF7jJMlvv6L
         steg==
X-Gm-Message-State: ANoB5pkDBlv7YS0Ee0Yzv5zQ5cnbtXi8/x6aeICnbFIqmhDNNqzL4aSt
        CWRMvI4XVqvpK1j3rQ1LV0Jy9sSn9sWI0JNBj6tr9g==
X-Google-Smtp-Source: AA0mqf7NCtlgUgNd0Hd1SP3QL7km2fBfAOvVUDERTH4v4MYwU6+4xOVJ3IJ4IDEzTj4uQn7xjEc4O/4GfJxHa4RW258=
X-Received: by 2002:a25:5047:0:b0:70b:e651:d1e6 with SMTP id
 e68-20020a255047000000b0070be651d1e6mr6047265ybb.363.1671566145422; Tue, 20
 Dec 2022 11:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20221220182745.1903540-1-roman.gushchin@linux.dev> <20221220182745.1903540-2-roman.gushchin@linux.dev>
In-Reply-To: <20221220182745.1903540-2-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Dec 2022 11:55:34 -0800
Message-ID: <CALvZod5q0koAckpTr4VBq-_KiQpsmC86bE4eP9gzX71PzRdicA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: kmem: optimize get_obj_cgroup_from_current()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Dec 20, 2022 at 10:28 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Manually inline memcg_kmem_bypass() and active_memcg() to speed up
> get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
> and active_memcg() readings.
>
> Also add a likely() macro to __get_obj_cgroup_from_memcg():
> obj_cgroup_tryget() should succeed at almost all times except
> a very unlikely race with the memcg deletion path.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Can you please add your performance experiment setup and result of
this patch in the commit description of this patch as well?

Acked-by: Shakeel Butt <shakeelb@google.com>
