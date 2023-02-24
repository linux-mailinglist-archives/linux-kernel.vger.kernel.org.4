Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8D6A18A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBXJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBXJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:22:04 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8565318
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:21:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id iv11-20020a05600c548b00b003dc52fed235so1315867wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enxa5NHwq2O6TtrXNEzJfnjaG+bP30p6bngVUy4j558=;
        b=hgXvCjiiqmvOyIz45/LTlHQkgvsKqQh4SPYtgY1n5GLpOzmjvc/Am+HB4gHxpWDy/K
         J1fbD9bqO/9jOJ9kww5wjj9ked1w1K7nK97Uv0o1vz804YyQDmvmdk2kuT4HgMh7u2dh
         SKq2E9+oXUUWfmIlWHtF0QPAURDlz7/oyiRLmNdYR4lVb7L/klcnYAhAs51pbE7AP35M
         wT2R0FgnaEQtb+3O3qfyy5o0VY/K8V5t0+CIQD8/xxwzHrSbdZDlKffBioyyxfytjc0L
         QvmqMTA3DZDAwY1ti/5dcBQt6gXqMIi6nk6b4aVSgPkCf3w6kYMwR6Tfq5f5jVwPd5ec
         QIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enxa5NHwq2O6TtrXNEzJfnjaG+bP30p6bngVUy4j558=;
        b=4f55nTP7T6h+kB8qM87PHpWRZdyVcrmXyXqulm03xo/H3c1nwsvAKjLqDt2ck4BL/+
         ZYUcMwwgDsZtG6mqXPN99PiRC5idf3Te2EG3C1eehVlhO32i6QuY5en+JmGi9gIVts7D
         fJzBadSBRGSewUL2awMocBP4TvcS+katDe3UijCWsp+4hoZHDBkTD43cI/pqbiHpcLyX
         jL01+hL+XsyV2x47JRs+suNJliuTeSNzLPvf6BiOAzC2gQzSDvvGHgv2ju9mmV33lEse
         6uZMRlULZMc5rgoK7n4I4kKKRlKlrnDn8yqTzCRIpxzBPVn2V8E8iDiXAQnizAUmVy90
         HCAA==
X-Gm-Message-State: AO0yUKX1WstMZVDyNB4WhOBU9yoApNvnBGDTim3NAPgFv17nrBM899CQ
        KpM1C801gERwPg==
X-Google-Smtp-Source: AK7set+m22cQJ0Vr+IFOQBtCF3t/xEvUUsdUgXvxgBwNIU08DejTG6SPFoBC7fhpPq+6LyZy7YAtww==
X-Received: by 2002:a05:600c:1652:b0:3e0:c75:7071 with SMTP id o18-20020a05600c165200b003e00c757071mr6588585wmn.5.1677230515541;
        Fri, 24 Feb 2023 01:21:55 -0800 (PST)
Received: from localhost.localdomain (ip2504e2d3.dynamic.kabel-deutschland.de. [37.4.226.211])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003ea57808179sm2128205wmh.38.2023.02.24.01.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 01:21:53 -0800 (PST)
From:   freak07 <michalechner92@googlemail.com>
To:     surenb@google.com
Cc:     akpm@linux-foundation.org, arjunroy@google.com,
        axelrasmussen@google.com, bigeasy@linutronix.de,
        chriscli@google.com, dave@stgolabs.net, david@redhat.com,
        dhowells@redhat.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, hannes@cmpxchg.org, hughd@google.com,
        jannh@google.com, jglisse@google.com, joelaf@google.com,
        kent.overstreet@linux.dev, kernel-team@android.com,
        ldufour@linux.ibm.com, leewalsh@google.com,
        liam.howlett@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, lstoakes@gmail.com, luto@kernel.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        michel@lespinasse.org, minchan@google.com, mingo@redhat.com,
        paulmck@kernel.org, peterjung1337@gmail.com, peterx@redhat.com,
        peterz@infradead.org, posk@google.com, punit.agrawal@bytedance.com,
        rientjes@google.com, rppt@kernel.org, shakeelb@google.com,
        soheil@google.com, songliubraving@fb.com, tatashin@google.com,
        vbabka@suse.cz, will@kernel.org, willy@infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v3 00/35] Per-VMA locks
Date:   Fri, 24 Feb 2023 10:21:34 +0100
Message-Id: <20230224092134.30603-1-michalechner92@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
References: <20230216051750.3125598-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some measurements from a Pixel 7 Pro that´s running a kernel either with the Per-VMA locks patchset or without. 
If there´s interest I can provide results of other specific apps as well.

Results are from consecutive cold app launches issued with "am start" command spawning the main activity of Slack Android app. 

https://docs.google.com/spreadsheets/d/1ktujfcyDmIJoQMWsoizGIE-0A_jMS9VMw_seehUY9s0/edit?usp=sharing

There´s quite a noticeable improvement, as can be seen in the graph. The results were reproducible. 

If you have any questions feel free to ask. 
