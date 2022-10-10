Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6905F9745
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiJJDzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJJDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:55:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE012A8F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 20:55:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z20so9288036plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHg7PCQfsS+7XZtzpDwJLaneTRAAVsZzS3wdGwh5q+w=;
        b=ivq1nvTNX4FhoBYGr9suu1WrwgN3ItOhHAMqOLrDbFanfCkE6DuUbX9Iu/Dk0CDb9O
         IPaB+NV0ktWIk7XVBIEy8juI0R9uMyPC933JOOM6riwozLHo4bcvCjCKs0Egw3aZ1rhb
         iR3j1sUQOhpSqITye7w5Pq9JcUG7Oeit2Kz0EWdDnODSLcpahv8kN/iOckQCn8a7RxrJ
         njoh9hXUou8Zk3xRpAUS8NMqdMam1vQfTiCcsaga7wWRzsgRXuImaKb1CAobFuUI5fTF
         PxRQuwt7L/1nuGguBvQ4dMLSKhNnqzMAZs34dH74qzGSJvfzPc4DcDFy6OdCOOQNbker
         i8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHg7PCQfsS+7XZtzpDwJLaneTRAAVsZzS3wdGwh5q+w=;
        b=PWlrfvH8awtlLCf+Ijg5TY6XJEO0sW+Dkh42NHdE2j+IhCURJxtn7PAa9aTRNlK7/j
         lxT9O7FLuij8V5EJDwdXZ5w5YT+T6gEFbxlfXeRJsQaleW69TCNHTQ8QcWWsG+WDKo1y
         RXUcCzeMHqq30Qq1svA8fBOP+9XaU9Xd7jM9BySWN10Tmp03YDeKETc9ybpD/6a1/Rp5
         muyKryelecQK/ikYLcyr29YJCc6+BIUydOPHuwUgx0f5OI9/ez/K69CA1tEKOP2eZEi6
         c7pzSpPLbr3+qxCkE0OryKnOsRQzuhwdcF9//RL8ClI3dv6jY3V/JjZ5s0d6gu/H/kAp
         i2gQ==
X-Gm-Message-State: ACrzQf0n5Z6FFfp86w9lW3MsSXwJT+pEIX2psWTDb0LIzr68EqUg7seo
        QQlrDtwnIK8EnwKXIPfSG+4e3Q==
X-Google-Smtp-Source: AMsMyM4cqgTWOczXJA0pjCrfj7CLfHqkbLg0TOFRa584lWrORN6uRK9rrxFAqE2ZzzSxSpv6gvRzGQ==
X-Received: by 2002:a17:902:900a:b0:178:77c7:aa28 with SMTP id a10-20020a170902900a00b0017877c7aa28mr17234333plp.3.1665374145681;
        Sun, 09 Oct 2022 20:55:45 -0700 (PDT)
Received: from [2620:15c:29:203:5c2c:f18c:2a4e:44d2] ([2620:15c:29:203:5c2c:f18c:2a4e:44d2])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b0056268979639sm5672143pfb.123.2022.10.09.20.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 20:55:45 -0700 (PDT)
Date:   Sun, 9 Oct 2022 20:55:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: slub: make slab_sysfs_init() a late_initcall
In-Reply-To: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
Message-ID: <4e36bc37-07c7-b502-572c-62b3aaa2b3cc@google.com>
References: <20220930102712.789755-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 30 Sep 2022, Rasmus Villemoes wrote:

> Currently, slab_sysfs_init() is an __initcall aka device_initcall. It
> is rather time-consuming; on my board it takes around 11ms. That's
> about 1% of the time budget I have from U-Boot letting go and until
> linux must assume responsibility of keeping the external watchdog
> happy.
> 
> There's no particular reason this would need to run at device_initcall
> time, so instead make it a late_initcall to allow vital functionality
> to get started a bit sooner.
> 
> This actually ends up winning more than just those 11ms, because the
> slab caches that get created during other device_initcalls (and before
> my watchdog device gets probed) now don't end up doing the somewhat
> expensive sysfs_slab_add() themselves. Some example lines (with
> initcall_debug set) before/after:
> 
> initcall ext4_init_fs+0x0/0x1ac returned 0 after 1386 usecs
> initcall journal_init+0x0/0x138 returned 0 after 517 usecs
> initcall init_fat_fs+0x0/0x68 returned 0 after 294 usecs
> 
> initcall ext4_init_fs+0x0/0x1ac returned 0 after 240 usecs
> initcall journal_init+0x0/0x138 returned 0 after 32 usecs
> initcall init_fat_fs+0x0/0x68 returned 0 after 18 usecs
> 
> Altogether, this means I now get to petting the watchdog around 17ms
> sooner. [Of course, the time the other initcalls save is instead spent
> in slab_sysfs_init(), which goes from 11ms to 16ms, so there's no
> overall change in boot time.]
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: David Rientjes <rientjes@google.com>
