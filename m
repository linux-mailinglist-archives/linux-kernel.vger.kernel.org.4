Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7F6D1616
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCaDmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCaDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:42:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A8CC36
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:42:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j13so19209328pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680234136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2yoA6/ZMAiU5n58XnU5GRn99au0wJfFSmiuyy5JMiA=;
        b=l2BgSx22kuf8Hs3D7qJk6EE10cDBOjYG0ia03DbUz+keXgFSqQ0kOnwuvFo1mqJ7e8
         sr2sOplzSkPKNkE9f69WVC7cUXhYU+E/lJhlnq9gDVmZxBMPX8IDgw7cLxCFn7kC+pdl
         eP+vfO5qQh+5YySDiX2/XfMPhhzlNGGAVojJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680234136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2yoA6/ZMAiU5n58XnU5GRn99au0wJfFSmiuyy5JMiA=;
        b=kYBdy49Qf9qKQ8Tm+LR6IeT4Zc3VcLCZ1pPOTsOH5H4Zcm5VxeIt/ExX8tdKo1KrNZ
         F9WDcp5co1JblLCLF3nSTz0B7vbFawJhh63+PonoAD/1ppeWjAuvURMzL33H6xsUIQqG
         tj+rxHMm7BQ5I2Jniv79EU/RISZMcUgpEeXP/ndWUxNXxnjQVWmEcesVB18n87anaywa
         lCCFrc8JTrDHGJVbZcNtyeMmhGjXr534jhgti2Ewbzdqf/uGPK7pHE7w3CwjzMfe7t+x
         v+3I9CmHu025mZNRA4zwBTanEWzXPXCqQ/S4jTHTxJUt3OLD8+rsE64Fqac05wtGP/g9
         SS9w==
X-Gm-Message-State: AAQBX9dMJVksZoeOu63M+8jfsXs/tjIKIweq3UUzdHq9g+i0DMQ816FQ
        1NBR3XUfeZpt6lvX6byzphBoRw==
X-Google-Smtp-Source: AKy350YEadHnIPucAgMaeBL0HMKusS65/ZM2KAeXc/wd10yIBt72Hu/asTJYkl9H5ZaueGU8YrY2TA==
X-Received: by 2002:a17:903:230d:b0:1a1:9787:507d with SMTP id d13-20020a170903230d00b001a19787507dmr9866306plh.3.1680234136348;
        Thu, 30 Mar 2023 20:42:16 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001a1d7329235sm427500plr.234.2023.03.30.20.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:42:15 -0700 (PDT)
Date:   Fri, 31 Mar 2023 12:42:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <20230331034209.GA12892@google.com>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
 <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/30 09:23), Linus Torvalds wrote:
> Although we also do have some other issues - I think down_trylock() is
> ok in irq contexts, but mutex_trylock() is not. Maybe that's why
> printk uses semaphores? I forget.

Yes, correct. IIRC we also cannot safely call mutex_unlock() from IRQ
context because it takes some internal mutex spin_lock in a non-IRQ-safe
manner. Semaphore is OK in this regard, both semaphore try_lock() and
unlock() can be called from IRQ.
