Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B96660ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAGAYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:24:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C77D9C1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:24:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o21so3127549pjw.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 16:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c6SeUYCDbLEXf7oCXsnAFwikq8uYLadAzjVq6GC0F4=;
        b=q0Q085+CxZdSa3SbS1sI89tTVP+wQj71WZRFPpabAK80bLlJAKpEPCNB6NAh0Q5rg8
         BFOYXRKtoX/7RfELKBJoHsVQxvAE1OQFhJf23nQm2w1pZvpDVG27nL8mgjWTewfxisda
         LWO//6ZPDjSN7fKwjCbmZAcPxv3ge7qd5RQEPGyyutCTM4WwUd2uxbrBMuoivLnaqgxd
         4fEYIwEH/L6wWa5+NhFUFd2MKv1UT4ACIvszFsimTc3W76yeXEwZB08sKLPettYsBRAe
         yWmks053lRurrU3dLlikxiqElYn3dWfc7uiaSvGRsMiU8ZU+b856mphIxURuQor4n5OX
         e8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4c6SeUYCDbLEXf7oCXsnAFwikq8uYLadAzjVq6GC0F4=;
        b=n88BYYTIVsyE/Qcjj7QVVe9oGvVxduK/QgypkKkijJqj9WVl6BrRULJrcWy5YGTOr4
         9cFXsC/93LMlpXfXvnjNSNBCyuB9oZpFtfflaLhSO3U8mEjkbtPzOHqN74B4FbvPvh4J
         1ZtLapSA9YXQwUxgZtG3PpoHoc4yOUwvb78K53+3x1vyt8bPYFrp6fT6g7PsDsiZnM8f
         w2DSY6hxomSl9wbmjlv+dXivzfoAHMb1VUj+qybIY+YlWSwZJ5JnT2qFOrmtu6/crozZ
         E13Z64J6jHov4ieQkqSudyWtPrLE6jtUOFWzm1MOy5dGfY3+R2fzX8iiY1zvzYH6sD4I
         yXPw==
X-Gm-Message-State: AFqh2krYT6/ASkRRrvJ6ATx/HKCF10Cc2z67lPQ5q3ZOyztJ/Mzmtgjl
        xV2DtcbG0+D3vNuSHf8YSvs=
X-Google-Smtp-Source: AMrXdXvq/xAcBzUIUUncggYqpTzo9t3kyLIUqvr/KBV02/6Y6XB4gjGlWkGUeTWfXeyc5qqARzrELg==
X-Received: by 2002:a17:90a:b891:b0:226:eac4:b22e with SMTP id o17-20020a17090ab89100b00226eac4b22emr2332671pjr.8.1673051071003;
        Fri, 06 Jan 2023 16:24:31 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a4f0600b00218f7c1a7d4sm3302138pjh.56.2023.01.06.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 16:24:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 14:24:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] workqueue: Make show_pwq() use run-length encoding
Message-ID: <Y7i7vadFAo0z8NoH@slm.duckdns.org>
References: <20230107001024.GA3893528@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107001024.GA3893528@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 04:10:24PM -0800, Paul E. McKenney wrote:
> The show_pwq() function dumps out a pool_workqueue structure's activity,
> including the pending work-queue handlers:
> 
>  Showing busy workqueues and worker pools:
>  workqueue events: flags=0x0
>    pwq 0: cpus=0 node=0 flags=0x1 nice=0 active=10/256 refcnt=11
>      in-flight: 7:test_work_func, 64:test_work_func, 249:test_work_func
>      pending: test_work_func, test_work_func, test_work_func1, test_work_func1, test_work_func1, test_work_func1, test_work_func1
> 
> When large systems are facing certain types of hang conditions, it is not
> unusual for this "pending" list to contain runs of hundreds of identical
> function names.  This "wall of text" is difficult to read, and worse yet,
> it can be interleaved with other output such as stack traces.
> 
> Therefore, make show_pwq() use run-length encoding so that the above
> printout instead looks like this:
> 
>  Showing busy workqueues and worker pools:
>  workqueue events: flags=0x0
>    pwq 0: cpus=0 node=0 flags=0x1 nice=0 active=10/256 refcnt=11
>      in-flight: 7:test_work_func, 64:test_work_func, 249:test_work_func
>      pending: 2*test_work_func, 5*test_work_func1
> 
> When no comma would be printed, including the WORK_STRUCT_LINKED case,
> a new run is started unconditionally.
> 
> This output is more readable, places less stress on the hardware,
> firmware, and software on the console-log path, and reduces interference
> with other output.

This is fantastic. Applied to wq/for-6.3.

Thanks.

-- 
tejun
