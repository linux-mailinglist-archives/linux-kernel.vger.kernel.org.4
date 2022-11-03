Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50861847D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKCQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiKCQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:31:03 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2081B9D6;
        Thu,  3 Nov 2022 09:30:57 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso327353ooa.11;
        Thu, 03 Nov 2022 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wf8Ox+cqI36jbP+T7p6EKTUvmpF6v5KouIok7EbcyU=;
        b=Jxprr5Yb6GFP2iMDdNYwrv+edL5lsVZ+sskHoEYasypEvTLy4Q6vhTS7qqFC2ZOJ9F
         7UlwmUBWdL8ATQXLGSU2oLt77vVHPXn0OrJO9RZ4ozCxeZSFNH6CKpqcZtCvnwol4zeN
         srTpQmrtC9fSlFcJoeE3VBMkcRHxF4UC77PI0QPdBZOTiLk4O1EgX10WGEBp+gELT/Of
         f0hLEd5d1y3j2mzfUulOKKw9wLwe0rGXdFxYErQK/3o71DkASuqcP1UgrC5XDCQfhx1n
         GSTmaFTFIU7py0xRt57Y61rOd+D7tYEKoK35ZenJvXOnTlTZe3nUPKJMZ1OW7PKQwbP+
         CarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wf8Ox+cqI36jbP+T7p6EKTUvmpF6v5KouIok7EbcyU=;
        b=xeSml70lzdk6Im+gznsgmRpQEqFrjzvZ8ZDIs3UDsAQ8Zu6AfPwNOjDuw905JyBM0I
         fxEyt7Duk6uEGz8xuDpSCY0LXwbYdRJqbSJLo+D4JclTnOjlEJyJj98mmq2u6HcKu1NE
         NVkqCYcvAOgi73ws5DW+LZuT+ycAk51lXMxwDYyPDeQeCmK14H8rEdeGKYS7lr7ymQQz
         DbkrPaKiS9C/Lw+O0kiyI5Bl0IhVmZUHf7msJgc8hC80WT2ERNnXzVYfUVLAa+TAM+ry
         QtEfhJIZn6F8XASs9rrua86uyhBgZU1Wejq+lCL2zPTPFMCxl5eQ2ke3RXiYSNGYvc8P
         lC1A==
X-Gm-Message-State: ACrzQf2k14Wv/JL70i0Vpgg2bu5A5VQvEUMD0L9KVa4TFx75EuYfrL3y
        ImreOytLYgILP/0sdEyLoz8=
X-Google-Smtp-Source: AMsMyM4XFkvxtx6hYtImOQooUBUuMwcsCe7CNpBD20J79Sc2FfnE52Rm7s0RT965HybTqZXYxmJ8ng==
X-Received: by 2002:a4a:a609:0:b0:499:74ab:f10e with SMTP id e9-20020a4aa609000000b0049974abf10emr12101601oom.13.1667493056510;
        Thu, 03 Nov 2022 09:30:56 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id t15-20020a4a858f000000b00480e1109695sm370965ooh.10.2022.11.03.09.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:30:56 -0700 (PDT)
From:   yury.norov@gmail.com
X-Google-Original-From: Yury Norov <yury.norov@gmail.com>, To: Andrew Jones <ajones@ventanamicro.com>;
Date:   Thu, 3 Nov 2022 09:30:54 -0700
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y2PsvvOWVs9ZLBsp@yury-laptop>
References: <Y1vvMlwf/4EA/8WW@zn.tnic>
 <CAAH8bW_DkvPCH0-q2Bfe0OJ72r63mRM3GP7NKOFrhe3zMO2gbQ@mail.gmail.com>
 <Y1v+Ed6mRN9gisJS@zn.tnic>
 <20221031080604.6xei6c4e3ckhsvmy@kamzik>
 <Y1+OUawGJDjh4DOJ@zn.tnic>
 <20221031100327.r7tswmpszvs5ot5n@kamzik>
 <Y2K6clNJBn0SbWU+@zn.tnic>
 <20221103125945.lrr5oxxmylwpam53@kamzik>
 <Y2PX9GfxWYh6+XGT@zn.tnic>
 <20221103153404.uh77nrdkowrxj6cr@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103153404.uh77nrdkowrxj6cr@kamzik>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:34:04PM +0100, Andrew Jones wrote:
> On Thu, Nov 03, 2022 at 04:02:12PM +0100, Borislav Petkov wrote:
> > On Thu, Nov 03, 2022 at 01:59:45PM +0100, Andrew Jones wrote:
> > > The patch I'm proposing ensures cpumask_next()'s range, which is actually
> > > [-1, nr_cpus_ids - 1),
> > 
> > Lemme make sure I understand it correctly: on the upper boundary, if you
> > supply for n the value nr_cpu_ids - 2, then it will return potentially
> > the last bit if the mask is set, i.e., the one at position (nr_cpu_ids - 1).
> > 
> > If you supply nr_cpus_ids - 1, then it'll return nr_cpu_ids to signal no
> > further bits set.
> > 
> > Yes, no?
> 
> Yes
> 
> > 
> > > I'll send a v4 with another stab at the commit message.
> > 
> > Yes, and it is still an unreadable mess: "A kernel compiled with commit
> > ... but not its revert... " Nope.
> > 
> > First make sure cpumask_next()'s valid accepted range has been settled
> > upon, has been explicitly documented in a comment above it and then I'll
> > take a patch that fixes whatever is there to fix.
> 
> That's fair, but I'll leave that to Yury.

I'll take care of it.
 
> > Callers should not have to filter values before passing them in - the
> > function either returns an error or returns the next bit in the mask.
> 
> That's reasonable, but cpumask folk probably need to discuss it because
> not all cpumask functions have a return value where an error may be
> placed.
 
Callers should pass sane arguments into internal functions if they
expect sane output. The API not exported to userspace shouldn't
sanity-check all inputs arguments. For example, cpumask_next() doesn't
check srcp for NULL.

However, cpumask API is exposed to drivers, and that's why optional
cpumask_check() exists. (Probably. It has been done long before I took
over this.)

Current *generic* implementation guarantees that out-of-region offset
would prevent cpumask_next() from dereferencing srcp, and makes it
returning nr_cpu_ids. This behavior is expected by many callers. However,
there is a couple of non-generic cpumask implementations, and one of
them is written in assembler. So, the portable code shouldn't expect
from cpumasks more than documentation said: for a _valid_ offset
cpumask_next() returns next set bit or >= nr_cpu_ids.

cpumask_check() has been broken for years. Attempting to fix it faced
so much resistance, that I had to revert the patch. Now there's
ongoing discussion whether we need this check at all. My opinion is
that if all implementations of cpumask (more precisely, underlying
bitmap API) are safe against out-of-range offset, we can simply remove
cpumask_check(). Those users, like cpuinfo, who waste time on useless
last iteration will bear it themselves. 
 
Thanks,
Yury
