Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C416EFB61
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjDZT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjDZTz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:55:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFD71BCB;
        Wed, 26 Apr 2023 12:55:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a69f686345so59582035ad.2;
        Wed, 26 Apr 2023 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682538958; x=1685130958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXVsxpmf8NT6a27PDFT8eqyBfJWxliivvXRcwaeV6Sc=;
        b=fb+7+q9J88OsywngTW4TRQfcybLuVB+o/UUns8oo71cyjoIFC85MSuqMxpHmhklHgf
         kcGktHFP1PnwOcTleRxpoV6QLrahiFVNXuJ9UHjb3il0r7G/Wi3ayc9JbWJJSsUMAUQx
         uM5EHftptCJ2BuY7dJn95UGDu0demIjeNBeWG6u4kbKlwugOWiUSjuQEX7EBpi5SCUcv
         cUAnUKg5XGLFPO3btYa0YE4rlEwsANtVKmEviQq7e9EG+udiaYIentLtkqQP5PA9yn2u
         BgxYRJkokYwS4c+LxMNgx6i+DUFFcnHe3LkVl5/rKl6xHkn50SpUKXRDnktIn8eg5OBM
         ZJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538958; x=1685130958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXVsxpmf8NT6a27PDFT8eqyBfJWxliivvXRcwaeV6Sc=;
        b=kyhVwATMEmiMZjjL7dTr7TFR6aqv/thuBML7ExXzCTBIjbTeR14dv0LIzGey9xXB0V
         DA7bHrAaPoKYdfAjYl0zK2oxysMrl+Nd2dtwnYXrih6+D3sUtMoJJl/cyLNlmRyq9IIg
         u20MUrO1VPcxeUQekjZnS8q9MChBqO2CW4udSF4zXtHTdHbOu/KnTso1TcH0xKfXGbbu
         mCqjngCd0a/Vp+icUxjm+lhwxavFYlxIplzs21GsFdsa+eW/4hpp6jjEUDOBIDQxlsFR
         pSebFCQq2HZe2MYkZ+KjJgnXdQI8kVM8crI8BvecXpzpWmT29zo1umPaSjVFqsmUDkvU
         dBkA==
X-Gm-Message-State: AAQBX9eXqoVD9reMcWERvqYphONhryuYfrS4uPdhdzF5NQQ/7ev7b3I5
        XWOW79yZTfNPiCm8UR1EOlXxios02uk=
X-Google-Smtp-Source: AKy350ZlCiwbjf2XZNOP6TGrchJIdwoHgw3Zh4kSa2vyY9NtAhrVM8doq5uo9BFUgYsD80IBl+bjrg==
X-Received: by 2002:a17:902:e741:b0:1a6:b23c:3bf2 with SMTP id p1-20020a170902e74100b001a6b23c3bf2mr27425254plf.10.1682538958150;
        Wed, 26 Apr 2023 12:55:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1976])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001a94a497b50sm8547641pls.20.2023.04.26.12.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 12:55:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Apr 2023 09:55:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <ZEmBy0H5T5vQJDUW@slm.duckdns.org>
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul.

On Wed, Apr 26, 2023 at 10:26:38AM -0700, Paul E. McKenney wrote:
> The rcu_tasks_invoke_cbs() relies on queue_work_on() to silently fall
> back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
> the queue_work_on() function's silent fallback mechanism relies on that
> CPU having been online at some time in the past.  When queue_work_on()
> is passed a CPU that has never been online, workqueue lockups ensue,
> which can be bad for your kernel's general health and well-being.
> 
> This commit therefore checks whether a given CPU is currently online,
> and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
> queue_work_on().  Why not simply omit the queue_work_on() call entirely?
> Because this function is flooding callback-invocation notifications
> to all CPUs, and must deal with possibilities that include a sparse
> cpu_possible_mask.
> 
> Fixes: d363f833c6d88 rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

I don't understand the code at all but wonder whether it can do sth similar
to cpumask_any_distribute() which RR's through the specified cpumask. Would
it make sense to change rcu_tasks_invoke_cbs() to do something similar
against cpu_online_mask?

Thanks.

-- 
tejun
