Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4268B86E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBFJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBFJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:18:07 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4741026C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:18:02 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id l7so4480909ilf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt6qUSo+NN+sGjxIgLWkfa10wQgR4VlY8VLtCt+q0TQ=;
        b=RITpqFOgeyUI39ch8xCoG5V6Pkxd9JpnP2tbaObCtXbgx6Q1YxbxGyI499PReZMv8O
         Qcfh4F4h80CVVkEAiHxOlj73uuQO4pY5ul/YEMgzRHTzgOEjmagYXISfqkLfcdjYc0sc
         dENUHDM9aLdZhxKqKZHb6Pt2Wxdj7ckEwuK95+p/TLBEBeEZrvDcX2h9Xz0mOYCwVtIr
         /qsOZ9ftVNYK3HYwyvMQIwttb/w379mZ25+Jr+PSe7kGhDV44LZdLYpGO5GqFMSszmBJ
         1UzQg5VwfVaJStd8hWgphOzZd9OvRYtoCnlZRNM5r2kV0ijjj/l4ED4EfVs09b72OGgg
         C3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt6qUSo+NN+sGjxIgLWkfa10wQgR4VlY8VLtCt+q0TQ=;
        b=T4HDFk4K6eF+upUkoZHQJ+ubeRi0G0hiYZQFcMu5iKDKthSZgCkNQHiAFxXq+9d+JA
         53A6voRp9Qd8zE3dqZCTOBuvIoDRQ7wCmpeoTCuLnZsM+vEPoT3CpNP34PYFJAO+VGDB
         o3b9hTx05ZHuS0Mc8x2ErIDjef9PSOu3CsMLU4Mc3WocdfZbY0VAaUjraAX8oc+0NOQO
         cQM1npzt3vQ+sB/uXDY7jsK5WNyriRyMSXFzAq2vxi5Q21g+pKg/0bYM5+BkrWcedBWI
         S8EbTJWMLcaIHrVrXfEmdDvlETXJrf3LzuPhFsZKOsh+tudfmIf7fjazX8thXBanfT7Y
         xROQ==
X-Gm-Message-State: AO0yUKXPs1k5edptun5N0+4fnFmJT6FuiNd7dtUw9CTXmFPD9YYkOpPI
        ZLPt0Qa0GRkBXiSyOPG4p2l6N7Y2hxw=
X-Google-Smtp-Source: AK7set99mxYzaEhg86X4tpcgtXPomIIaukgljHRTb/x5Ppc6tqs1FUMuBJYWdWNmmgUTJ5z7IThKVw==
X-Received: by 2002:a05:6e02:128b:b0:311:ad48:ff18 with SMTP id y11-20020a056e02128b00b00311ad48ff18mr8170278ilq.0.1675675082006;
        Mon, 06 Feb 2023 01:18:02 -0800 (PST)
Received: from haolee.io ([2600:3c04::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id b12-20020a05663801ac00b003a951542b10sm3465626jaq.60.2023.02.06.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:18:01 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:17:59 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: eliminate function call overhead during
 copy_page_range()
Message-ID: <20230206091759.GA16477@haolee.io>
References: <20230205150602.GA25866@haolee.io>
 <Y+AlcdA3fH0FiJGO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+AlcdA3fH0FiJGO@casper.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 09:53:53PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 05, 2023 at 03:06:02PM +0000, Hao Lee wrote:
> > vm_normal_page() is called so many times that its overhead is very high.
> > After changing this call site to an inline function, copy_page_range()
> > runs 3~5 times faster than before.
> 
> So you're saying that your compiler is making bad decisions?  What
> architecture, what compiler, what version?  Do you have
> CONFIG_ARCH_HAS_PTE_SPECIAL set?
> 
> Is there something about inlining it that makes the compiler able to
> optimise away code, or is it really the function call overhead?  Can
> you share any perf results?

I am so embarrassed; I forgot to disable function_graph when timing the
non-inlined function so my test was interfered. And the actual
performance improvement is only ~3%.
Please ignore this patch. Sorry...

> 
