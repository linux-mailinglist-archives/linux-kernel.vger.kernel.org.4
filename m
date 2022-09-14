Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C925B8A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiINO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiINO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:26:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2325C59
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:25:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u132so15085962pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hdSD8tJb664Fr8pl0NO+kf8L2z4TDzTohEl0wY+gzYc=;
        b=W15M6v323Iel/iK6eFB5fJmsZj9UgNfzHvij6SGJNxbTuWnqIovbfOPRNq3jRPbdSH
         0oyEjnHDaHKU56TfRiVWrQ8OK4AkxXGpiH4n2ZY07EN7lKx2rh0fiNP/u3aArQnoqFKx
         /juLxkWKnaA99ijCsePo3+Yh3Qbi1J71jaTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hdSD8tJb664Fr8pl0NO+kf8L2z4TDzTohEl0wY+gzYc=;
        b=J/+plrMpLSU1QvCX32ujbWG440HbcpTqEoYfTEp7HU7A/7gO4hmFIdsSZTtcX8MG1z
         xYtF+eEUSNdh3MsqzAH/O49P3HVKHlkfUCCU7nA5tLaSSdGv/kUOESgFVPJL6kz5ciug
         lru9PGjwg0mZbhFP8H791dsYu1Gyyw2R3SSadwG9L1clPuVrE9gbQrhryDA3ue0qsUCZ
         eqc9jTOPX9eSJoh6JkJvtZ0JhGU4Dr4goynokHMk0NFksWm4RSjzXUUreMVLh5V0b9db
         P80bnc7NLXL8bXdthhVzsgXKBJ+bok4ZV/OPOG+lRvfD9vt33ktgt+WHSDqCY56FKrsh
         7cAw==
X-Gm-Message-State: ACgBeo2n1VPmkUtIQBUS85ZSFucGx/dHAuA6vgPMvOuM/qUhjOwoTWu3
        cywXsYO7LEJMFpyOUpHRW9LTrQ==
X-Google-Smtp-Source: AA6agR6En5JhEov24TDmvwIDj3j1j5VGKylIZcdmOMCIY6+KUUuqabgXpORLodRAghUj4fpa4NlpVw==
X-Received: by 2002:aa7:97b4:0:b0:547:f861:1fc3 with SMTP id d20-20020aa797b4000000b00547f8611fc3mr2784496pfq.42.1663165527599;
        Wed, 14 Sep 2022 07:25:27 -0700 (PDT)
Received: from fastly.com (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id e19-20020a656bd3000000b004351358f056sm9642274pgw.85.2022.09.14.07.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:25:27 -0700 (PDT)
Date:   Wed, 14 Sep 2022 07:25:24 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] mm: Add per-task struct tlb counters
Message-ID: <20220914142523.GC4422@fastly.com>
References: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
 <1663120270-2673-2-git-send-email-jdamato@fastly.com>
 <e0067441-19e2-2ae6-df47-2018672426be@intel.com>
 <20220914141507.GA4422@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914141507.GA4422@fastly.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:15:07AM -0700, Joe Damato wrote:
> On Wed, Sep 14, 2022 at 12:40:55AM -0700, Dave Hansen wrote:
> > On 9/13/22 18:51, Joe Damato wrote:
> > > TLB shootdowns are tracked globally, but on a busy system it can be
> > > difficult to disambiguate the source of TLB shootdowns.
> > > 
> > > Add two counter fields:
> > > 	- nrtlbflush: number of tlb flush events received
> > > 	- ngtlbflush: number of tlb flush events generated
> > > 
> > > Expose those fields in /proc/[pid]/stat so that they can be analyzed
> > > alongside similar metrics (e.g. min_flt and maj_flt).
> > 
> > On x86 at least, we already have two other ways to count flushes.  You
> > even quoted them with your patch:
> > 
> > >  	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
> > > +	current->ngtlbflush++;
> > >  	if (info->end == TLB_FLUSH_ALL)
> > >  		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
> > 
> > Granted, the count_vm_tlb...() one is debugging only.  But, did you try
> > to use those other mechanisms?  For instance, could you patch
> > count_vm_tlb_event()? 
> 
> I tried to address this in my cover letter[1]...

Err, I forgot the [1]:
https://lore.kernel.org/linux-mm/1663120270-2673-1-git-send-email-jdamato@fastly.com/
