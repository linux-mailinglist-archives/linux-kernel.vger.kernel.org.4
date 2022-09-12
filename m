Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697155B613F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiILSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiILSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:44:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1780112A84;
        Mon, 12 Sep 2022 11:44:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x1so9431677plv.5;
        Mon, 12 Sep 2022 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=x3dhgBdfZpa2wxUdiBs2W11ZyoCSSU9/WrWzizXcRIs=;
        b=EwswG/jwo90VzzM/Zj4fKy/aMwfPc470pwVa0b2up97FtV6VzgaKXs9ktEnKxp4zhe
         1keqGVQeJSXpCk2Nk5d2CEaRAU+lBDBvLN+0GDJI5IjBUqv+WLpBfAK111fcCpdBCuhM
         6iGlcWenbBsdIbEu1NnUwdHxoUJt5sqJ4pOt+mM/VBKyEdpyA7MxX3P7VxeM7kq6vgAr
         QuU0cAy0Pe7srYx6QAcog7RyebNFXHXLwMuJHXzBaZKfUltnnSVCvPgkUQk4ebZMj+Dz
         nngXu4juLdeDzIomVE9Q2k9jyJBhIwnswp0zoNGLbu2A9d2LpVqK6PkCdgKBrf/wzuMN
         +mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x3dhgBdfZpa2wxUdiBs2W11ZyoCSSU9/WrWzizXcRIs=;
        b=QPCoUKyAbscl1x9Jtu4tkO3upyAQry7xpxm3k1wIYbfJuQFMnh+dgg7gA2l22yVKpU
         G2+E+lTu3nJ8Pml1BMAHLUv9RmvYcvmwA+LrguLwMV4jck5A5Kwl+UpbisR7xPzIY0Nk
         4CEtT10KZEfDZZR7n8/fHvde48vm+C+Q/LmmC4JG4xAItoX6uppPH4bfeHQfsxq9gV2X
         DRk8TqBc/gTMFBF/6OxK8VNTrMV6hbQ2Egd/luI7Hp1gAeXXxsIHXRm7lxekJS3aTwQo
         eoIEEa+Xr6OBmItbEAgu5wceVqZ3XnGahAfMuKE9cJeakdh0JF7+HsdCEDtQ8HnnaND9
         8i/g==
X-Gm-Message-State: ACgBeo2W8s+E6mcWCEGoJSnytKegmO5j/DTjngCYJFeHQaUyYSoDcJEP
        tYS7wMvMTSO8XQqFPfErJCaF2aiFQKM=
X-Google-Smtp-Source: AA6agR7uMnULlpQjrxcYEgxdal/7yOuvPQt1Nk2OnGP4oQBPf9kbRFZabxrbnpFKJX2kYA7DqqhguQ==
X-Received: by 2002:a17:90b:390a:b0:202:c913:2216 with SMTP id ob10-20020a17090b390a00b00202c9132216mr7720633pjb.5.1663008290301;
        Mon, 12 Sep 2022 11:44:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 38-20020a631666000000b0041d95d805d6sm5962077pgw.57.2022.09.12.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:44:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Sep 2022 08:44:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <Yx9+IIQqizUB/DJu@slm.duckdns.org>
References: <20220912161812.072aaa3b@canb.auug.org.au>
 <Yx7iEv/wy5Olgu0M@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx7iEv/wy5Olgu0M@hirez.programming.kicks-ass.net>
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

On Mon, Sep 12, 2022 at 09:38:58AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 12, 2022 at 04:18:12PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the cgroup tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> 
> Hmm,. TJ should I base sched/psi on top of drivers-core-next and your
> cgroup tree?

Yeah, this is kinda nasty. Lemme just pull drivers-core-next into
cgorup/for-6.1 so that folks don't have to worry about this and you can just
pull that one.

Thanks.

-- 
tejun
