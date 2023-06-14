Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B172EC36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjFMTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjFMTqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:46:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FD19A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:46:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6662fcaac93so132955b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686685590; x=1689277590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxeuPCO3GTvztmCaqFwBCrXNFMyoav37TQYPe5N2X2Q=;
        b=ZXwqdQSU/HiRRBmiMo0Q4BulnluPAh2ryLShUC8dzGZsPXV27BS3mYaNw52krhQxmi
         FDxiku3oDSIq7ETXuQ8zuIR6vPTTTiy5Uh+q09OiBHP7jNeYHGe8a87/wG4jR/UkKFXO
         m0LB4L/wA3k4VB+TGrW72v2AVbhniQkqNzr60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685590; x=1689277590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxeuPCO3GTvztmCaqFwBCrXNFMyoav37TQYPe5N2X2Q=;
        b=dOsWX31NcCY4k4zoyd2EkLnR/br2OMLpeuKI2jkFhgZJr/n5jEKJtI9chBC2gTMlXp
         ujBlFUrmLaPvmt4Lif6yJqHOSkb2nfz5hsci/3y7zhUyUl/XdTJlCqABDfGb8fPfSEIM
         DGN5HS7dXRyp6TkEtOIpCM4sKaLuljbWGn7vBzA0XY5dk776p4SI+DM8guM0j2PDnzrW
         yE4zRYkx7rP1iAq3F8njAIplP/IU4iXuuzNWxHo61eoNRo0Pzubqfg8PyjyeTvD88tr6
         1vYCd42nDBrU1aS6ku3ivTHhLpmDjkfqkgpkP12XzKQrsssSwviIaYYxncb999jtSBO9
         9zZA==
X-Gm-Message-State: AC+VfDzXLK2zadtsZckc1Y9QUWJFHjHe3E1NzU/8LwoJElODwpM+m7X5
        wo2joyvq2JVXmgU9nn6ynEmS0w==
X-Google-Smtp-Source: ACHHUZ7jZ3mi9XpzJyAKqWF/U6Ou18xsuMhGoP192JvILRSeeC4WqAi7Cv8VWP4EnGr6RjXn0fMPJw==
X-Received: by 2002:a05:6a00:1783:b0:662:c48b:47e2 with SMTP id s3-20020a056a00178300b00662c48b47e2mr19702410pfg.19.1686685589881;
        Tue, 13 Jun 2023 12:46:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t12-20020a62ea0c000000b00643355ff6a6sm9215426pfh.99.2023.06.13.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:46:29 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:46:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v3 03/57] locking: Introduce __cleanup() based
 infrastructure
Message-ID: <202306131244.E8DF4CA166@keescook>
References: <20230612090713.652690195@infradead.org>
 <20230612093537.614161713@infradead.org>
 <20230613105522.GU4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613105522.GU4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:55:22PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 12, 2023 at 11:07:16AM +0200, Peter Zijlstra wrote:
> 
> > --- /dev/null
> > +++ b/include/linux/cleanup.h
> > @@ -0,0 +1,167 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_GUARDS_H
> > +#define __LINUX_GUARDS_H
> > +
> > +#include <linux/compiler.h>
> > +
> > +/*
> > + * DEFINE_FREE(name, type, free):
> > + *	simple helper macro that defines the required wrapper for a __free()
> > + *	based cleanup function. @free is an expression using '_T' to access
> > + *	the variable.
> > + *
> > + * __free(name):
> > + *	variable attribute to add a scoped based cleanup to the variable.
> > + *
> 
> 	no_free_ptr(var):
> 	  like a non-atomic xchg(var, NULL), such that the cleanup
> 	  function will be inhibited -- provided it sanely deals with a
> 	  NULL value.
> 
> > + * return_ptr(p):
> > + *	returns p while inhibiting the __free().
> > + *
> > + * Ex.
> > + *
> > + * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
> > + *
> > + *	struct obj *p = kmalloc(...);
> 
> That should obviously have been:
> 
> 	struct obj *p __free(kfree) = kmalloc(...);

Okay, good. I noticed that too. :)

I also didn't see any users of the kfree helpers (maybe I missed them?)
Maybe add at least one conversion just to have an example conversion for
it too?

-Kees

-- 
Kees Cook
