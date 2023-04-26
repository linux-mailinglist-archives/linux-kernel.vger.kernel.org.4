Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F86EFD11
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbjDZWJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbjDZWJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:09:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA962D56;
        Wed, 26 Apr 2023 15:09:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso9035132b3a.1;
        Wed, 26 Apr 2023 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682546949; x=1685138949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxpYnE1u1Q2bjTfyL3mlyd6uQYcX9SBjAJDlWJodPlE=;
        b=ecBuUF2WKdDeRURQIP2jve85Tdg403UVVTg28R8vqv1Z+iszu5qmMk+RirueEwDrFN
         4++zFgmKaLm2nUA6Uhodv1/eLdrlDRzkgqnox1hs5J9itu0epPwp0GJRI6H68YMjLPf9
         LvF0Gdf7zj7XeXbl5FIW+qwP/3SEdPy7W8gPX/XEHmTdiTKwyaeZiVS+ZFVy8hpE1Euo
         nHNWMlHgiLQ/gYrsgqIHgmwrm8zfzBM02upCm/ZSBgZfD8YwrQ3CwLX1h+wyQbcoosph
         6tOMuWt4YZCxPhVs5RlFpYFQqhZCwwBuVXoV3w9N8aFmHif2ofr5DZrY9vSM5vs7foCe
         DbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682546949; x=1685138949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxpYnE1u1Q2bjTfyL3mlyd6uQYcX9SBjAJDlWJodPlE=;
        b=B2bWX9amsBtLPGI/Kb80+PPJJ6hcsmEG1guTsi6p/06QHOQkcL2Ylj6aE2ktXM4AnY
         7ggbOIem8Nd82rGUAIKujzKSqZmf9InA1tHuea4kfz0o/gi6pR3ly+MAQiJYarXlQJwd
         FskXrSD1rXZaeN0RX9YToS0s+JyViqfgkqkzHuaGO+E4poq6ojh7Wm/+4mhnEHHE6x9T
         wYWcsXQuXGsXKOywf4X4+b5Lx57PTMJsLTyed7TAjOMiQ+quYsI3YDmn0Tm6rIg5oRV5
         fzYqWfH8ERgQfi2nrmgzxDGxQzwFdiUNP+jUliT6yNrqaZt00fSX6Crsuo/QU5ElkNw0
         4UNA==
X-Gm-Message-State: AAQBX9cKMve9PGEQ4tjnQt67h9MKFZ3OhGMw202zDryyAkYdSBbDQPCM
        Nx4/oBO/CHsH/QvGnbm5aZSpyp9R/bs=
X-Google-Smtp-Source: AKy350ao+O9KfxqiWpxItYiM7+VJzjgeiu3hovDCVESstDcqw4QKVA0p2GgoCsmh0O9uOBMaM7H/qQ==
X-Received: by 2002:a05:6a21:8dc5:b0:f0:e3ed:469a with SMTP id ti5-20020a056a218dc500b000f0e3ed469amr19873769pzb.55.1682546949331;
        Wed, 26 Apr 2023 15:09:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1976])
        by smtp.gmail.com with ESMTPSA id b6-20020a63d806000000b005143d3fa0e0sm10245458pgh.2.2023.04.26.15.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 15:09:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Apr 2023 12:09:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <ZEmhAzUMnQ1rP2YU@slm.duckdns.org>
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
 <ZEmBy0H5T5vQJDUW@slm.duckdns.org>
 <1713f8f6-88d6-41f1-bbc6-045b2e017289@paulmck-laptop>
 <ZEmYFLKspo-rhyp4@slm.duckdns.org>
 <c4d39cb7-dbb7-44ad-b90e-71655bdbefd1@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d39cb7-dbb7-44ad-b90e-71655bdbefd1@paulmck-laptop>
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

On Wed, Apr 26, 2023 at 02:55:04PM -0700, Paul E. McKenney wrote:
> But if the call_rcu_tasks_*() code detects too much lock contention on
> CPU 0's queue, which indicates that very large numbers of callbacks are
> being queued, it switches to per-CPU mode.  In which case, we are likely
> to have lots of callbacks on lots of queues, and in that case we really
> want to invoke them concurrently.
> 
> Then if a later grace period finds that there are no more callbacks, it
> switches back to CPU-0 mode.  So this extra workqueue overhead should
> happen only on systems with sparse cpu_online_masks that are under heavy
> call_rcu_tasks_*() load.

I still wonder whether it can be solved by simply switching to unbound
workqueues instead of implementing custom load-spreading mechanism. We'd be
basically asking the scheduler to what it thinks is best instead of trying
to make manual CPU placement decisions. That said, as a fix, the original
patch looks fine to me. Gonna go ack that.

Thanks.

-- 
tejun
