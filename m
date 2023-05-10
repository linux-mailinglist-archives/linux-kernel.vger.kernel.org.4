Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4286FE480
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjEJT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:28:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B66A4B;
        Wed, 10 May 2023 12:28:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ab01bf474aso58807065ad.1;
        Wed, 10 May 2023 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683746936; x=1686338936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St8Hsth3yEssLy+3L8DNZSzYbP8LaSjJkmswj6bNhNY=;
        b=jmprtQ6vpXwG0djM6z+KYh5xl8h/Ac8X1jiJLHIWobiFbjifXXm2vyi3dzLL8l8FCU
         gMtCj9s2LzKLXPphcW+x0sL3jIRVsCybxzXG73KULcUwKpMnjBJTZDQEtfxWRGVnJLCN
         5My6mKN9k8Syy7gNptWZg2RQMKupWGbxmFd3k6myHjpkphei3w3WCmBlOSLyHS0Em8Kl
         RQW1rKBEN+MMEXR3IJABsWyW8nMvdZElwXOIix/q0IPG628wL9CFeCsWHHrZ6/JbNM76
         TPVMHtbLqST4NDstlWGNC2LD8EMAVl3xpGpm083kfa2mHDjwN5tOix+zZukkW2rSfBW5
         1x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683746936; x=1686338936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=St8Hsth3yEssLy+3L8DNZSzYbP8LaSjJkmswj6bNhNY=;
        b=RYd6/s3lGMjzeEFME9IwL+EHk45sQaNodqDuicGvcDnpXAnQxmxMkf2FF9+692y/Wz
         7GMZkaPKMQI+RzlDlCUc692CAm4WQig4VkZur6UBsdJNeLYTwxwVndp88rjvMCLfSpNw
         GbzNXfm42mgVWN+OX9yLKQGcQQultUTx/SxlbWoPxL8Ni7BhqBH8LAcTYYDcC3nFSgzb
         dwDWutaAFzuWIHblfZzDn5tq8eudN6a/H6LieiBmLbminiKiInNJHqF5eVhIppfF3aT7
         xavFOFYevxIpnx5GTLIjue14a3e8voBtvjPy4T+vM8xH4kNJfFQ4ekXyq79NEFqkVOSY
         9+6A==
X-Gm-Message-State: AC+VfDzfNmkdlVYgvx3Lqnz0SI3uQCXESG5h49CS8JePAE/72JYnsdmj
        bVocfkN5fdPVyTgDz0sbLpM=
X-Google-Smtp-Source: ACHHUZ45Vb34sEQWoilNdNFya7MELHannGfHXzwWNj9+lbiu9vgdbORva+tXb7Ric3zyI/9AUWDN/w==
X-Received: by 2002:a17:902:c402:b0:1ac:b259:87ea with SMTP id k2-20020a170902c40200b001acb25987eamr4196664plk.0.1683746936214;
        Wed, 10 May 2023 12:28:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902b40500b0019a6cce2060sm4156156plr.57.2023.05.10.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:28:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 09:28:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC PATCH 2/4] workqueue: support holding a mutex for each work
Message-ID: <ZFvwdro1T4lnLDrs@slm.duckdns.org>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
 <20230510175846.cc21c84b0e6b.I9d3df459c43a78530d9c2046724bb45626402d5f@changeid>
 <ZFvjoUtg2ax11UlC@slm.duckdns.org>
 <0c44265eae421eff49e19be3ebfe20d1fb5e6f9a.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c44265eae421eff49e19be3ebfe20d1fb5e6f9a.camel@sipsolutions.net>
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

Hello,

On Wed, May 10, 2023 at 09:16:09PM +0200, Johannes Berg wrote:
> Yeah I thought you'd say that :)

Sorry about being so predictable. :)

> It isn't difficult, the issue is just that in the case I'm envisioning,
> you can't just call wiphy_lock() since that would attempt to pause the
> workqueue, which can't work from on the workqueue itself. So you need
> wiphy_lock_from_work()/wiphy_unlock_from_work() or remember to use the
> mutex directly there, which all seemed more error-prone and harder to
> maintain.
> 
> But anyway I could easily implement _both_ of these in cfg80211
> directly, with just a linked list of works and a single struct
> work_struct to execute things on the list, with the right locking. That
> might be easier overall, just at the expense of more churn while
> converting, but that's not even necessarily _bad_, it would really
> guarantee that we can tell immediately the work is properly done...
> 
> I'll play with that idea some, I guess. Would you still want the
> pause/resume patch anyway, even if I end up not using it then?

I think it's something inherently useful (along with the ability to do the
same thing to a work time - ie. cancel and inhibit a work item to be
queued0); however, it's probably not a good idea to merge without an in-tree
user. Would you mind posting a fixed patch nonetheless for future reference
if it's not too much hassle?

Thanks.

-- 
tejun
