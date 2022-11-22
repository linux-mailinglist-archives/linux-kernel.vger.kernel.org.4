Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028EB6331FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiKVBKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiKVBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:09:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671130A;
        Mon, 21 Nov 2022 17:09:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y13so12916988pfp.7;
        Mon, 21 Nov 2022 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uV2G9OkZPteRDUPIBbpEX1LqAlP08euqxHlCCibjYMg=;
        b=Y3nI5487nqR6VxtRBsXipeMeYIXKNLnY1fDiz3CB8hzh6ncTORDBO3ea32fif8rXmE
         3AkJ42BJHg532Gxy22qkIcVtzyj0+AcIDFscuLzjHizx7Y47tNWjZ5ZD1nywtqzeL9b/
         V9cGOaRtgETlHdWcjkliVNokhcq0wXqCT0qHAx+rsOy8ahnGLsG80E/g30MkccN6f7CA
         pRd04oT0gQAv3qVVD1Kwy41c2qazhP1iglssahvDYjdM+AJjC5uThbarEO0PNRTs9fr4
         rLJkeYSBu2tKQUdiMK0dnztyxbgIbjccMU32q51UI0kZghamUHBG+6Lh4CFT+S+Lj7Xm
         Zrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV2G9OkZPteRDUPIBbpEX1LqAlP08euqxHlCCibjYMg=;
        b=Gey6g0zwnMjireComvgwP14/J/LbeIKJXka4MzKWuO1PCxQXVHzXSgmNsD3a43NdOp
         CsF2suGs5v0MUNMYO7D78vRV3tozbZYkLa8RquAPwY6Qax9S+EFB1Ltfi9vaL8kDVZkD
         WJ6mbe6SJXzw/jeFEM3aYe8lhtL7qdRjyb3Um2KW/YE/PPsFHhd0F6DvFX1N91jpYDXS
         wRdKY0V1d992KyUnyJNrRM7uvgBpYOgfiwHEe0ipXbI3NZL4GcBHIUHp4ZnbvurtxO5G
         mSNwhfWA2LoIYkbNz/1Jn1XMt5tdkKe0mE0ehRCh9y7vk9es5Aj/O+5mXIAp7lNjR1jd
         yhiw==
X-Gm-Message-State: ANoB5pl0pgr5QilKvXy5+ax+MOzj/Yv1j0BWxsf7dtmZHRB2k6BAztYb
        YkA32mfm10P0G44e6e0iHiE=
X-Google-Smtp-Source: AA0mqf62LDAWIzni+cMb50T56DT4QotJkb1srT7PWNFsCeMJ1pXofhMNRmv3fE3a1bbPADAGLhnpLw==
X-Received: by 2002:a05:6a00:1941:b0:56b:a80f:38d4 with SMTP id s1-20020a056a00194100b0056ba80f38d4mr2119390pfk.12.1669079371514;
        Mon, 21 Nov 2022 17:09:31 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903028f00b001754fa42065sm10389614plr.143.2022.11.21.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:09:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Nov 2022 15:09:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 rcu 13/16] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <Y3whScgTs0FgrVtY@slm.duckdns.org>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-13-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122010421.3799681-13-paulmck@kernel.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 05:04:18PM -0800, Paul E. McKenney wrote:
> And another call_rcu() instance that cannot be lazy is the one
> in queue_rcu_work(), given that callers to queue_rcu_work() are
> not necessarily OK with long delays.

So, this is fine but another thing we can do is propagating the distinction
through the workqueue interface so that the the choice can be made by
workqueue users. Would that make sense?

Thanks.

-- 
tejun
