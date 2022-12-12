Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31966498EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLLGXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:23:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A3B845
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:23:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id js9so9917245pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16qjFjVCSByPSmaTuD6/Rn3kPnlB8HVnWQrOiENDUnQ=;
        b=i9Z0r6NITq9TRj+RUGURJbxiHaklMCriP5vPoXMX1iq0ZiQUewgeuwqnS+moJb1Pxb
         aKaM5fiqklCwGLtJoqWAlSKTPQML5vV18ez36qWb/FJQKXNlr3ooSmnYxRL3I7sQz2Q5
         Mqa5Sy5ZB3x5aFnQBy2UL9Kwby2+bmzGxQpf6heIA3AizBdIwqNzh3aN6KQk4dtJthN7
         0sxax/K5xH3wOkQ7b7o7pFlUCXBBgxiuBBY7bwgx6+fqHSnkoRZxiP+uuF2s1bFu0/9p
         0FbW4W5JUODSa5Hz2fuorIC/M5sHPmcUHhIRaoc75q1SnTe6rAMeROBlUC6pYlujVNUI
         ewyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16qjFjVCSByPSmaTuD6/Rn3kPnlB8HVnWQrOiENDUnQ=;
        b=iqvEtOPIjZCkML/3neujdi6+1kp7GWybjQnaF63fw4xmI+8CCvfpTudNr8Enr8r9Jb
         M8/EvTAU1vdfMGnsHC4qkAv9CSLxUfqhfQ8jDcCB3Jw4NY6sB/+v54Kd5T+YCVxLKVE6
         A87Gjmks++gPXAZl0fwg2mne0jCSAQWmakvus7Yv6dVC8e91vQQ+VSHlccdt8/eupzq4
         8TTk1vWpHBko5x/QUPZnBd+EEu+m1kUP8mZx7e/f+deAWhR55zVdwM6kox9QwwByEYZv
         R/Gk71OpdSrlMfy2iy4K0Muj+e6Nyb1V+jr3P/abA92Lty2W/J2Ipqs6UNd/zVpUR4V2
         JaOA==
X-Gm-Message-State: ANoB5plJZeMpyPLRALp/h5c0rxirA2QXnXeU9WQNUX7+qktQtduVPsET
        WgxB1wYg51Ua8xgCKH7cSVV++VzqzxMizQ==
X-Google-Smtp-Source: AA0mqf7BcvB/V0ijOniyMqhsVQqV3Fi4laAk2txZkZMuFZcjghgl6Ff663EKYGi92pEfcajCcOwbwA==
X-Received: by 2002:a17:902:930a:b0:188:da5c:152b with SMTP id bc10-20020a170902930a00b00188da5c152bmr14515056plb.9.1670826231221;
        Sun, 11 Dec 2022 22:23:51 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:9159])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b00189c26719cdsm5375734plg.272.2022.12.11.22.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:23:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 11 Dec 2022 20:23:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Richard Clark <richard.xnu.clark@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Prevent a new work item from queueing into a
 destruction wq
Message-ID: <Y5bI9ZbjpzNFpk/8@slm.duckdns.org>
References: <20221212061836.3620-1-richard.xnu.clark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212061836.3620-1-richard.xnu.clark@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:18:36PM +0800, Richard Clark wrote:
> Currently the __WQ_DRAINING is used to prevent a new work item from queueing
> to a draining workqueue, but this flag will be cleared before the end of a
> RCU grace period. Because the workqueue instance is actually freed after
> the RCU grace period, this fact results in an opening window in which a new
> work item can be queued into a destorying workqueue and be scheduled
> consequently, for instance, the below code snippet demos this accident:

I mean, this is just use-after-free. The same scenario can happen with
non-RCU frees or if there happens to be an RCU grace period inbetween. I'm
not sure what's being protected here.

Thanks.

-- 
tejun
