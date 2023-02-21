Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA23069DC40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjBUIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjBUIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:40:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D223640;
        Tue, 21 Feb 2023 00:39:51 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s26so13858261edw.11;
        Tue, 21 Feb 2023 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+s3LghqL/xNmAVCsHxyUzyrjEgIj+4vMZ5iip7icUXw=;
        b=BeQAjFO9ydOReLQGkvdAAU/LRuf7WcC3QQk2V7giMfmBzOpAzm9xlK5CC7pqR25XYO
         vlGacp8gx2xLItmgNYKS/IMUAEXYqgc+2k0Llwn68G+WN8w0cw1eIrlBvugyaO8H4lS/
         BzIg3kd5h5tmPj7T9vF1Fs/6Dk+Iqc87s1guyXkDF9rMOCXyoQZIOv3D1LDA4GZHESE0
         EYzFl3AVlvWz0sIpKB8UluoBij7uzBsbQK8gurSlP8igsiOZW6EplyCpUfnkjf9HNkcM
         RlhbNcoeXHkIW/eq4lkUtsoDgBuMy/6lmqx1/QUZVYjWkOZ3D5R0BXviU0TBpy30MiOL
         YvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s3LghqL/xNmAVCsHxyUzyrjEgIj+4vMZ5iip7icUXw=;
        b=MS8fCp7itGrHuddGm4q613S5b1MRDvov8PPOx3deUmr+5BsVSDVynaLkCywW2dy0/D
         qpRa5ia+zViGntKC4KNUiyXjRLinHq/NNrKdQR+ukcc+K+oVa9ykv/l/VFzMA5CKepvy
         wh5upOY9W6hqmO8APryrQPPSaBfI8nuH1kpuSsJV86u9g2hIqRZ0yeInbqEgV2eDMJnn
         S7scNu3aJx0GuyLWFXATQp+iZ3iexV/traygZjafQhBcjkxQ7I9sh8hxACUxPgkCJZWc
         v9Wa3QkkfZIblnoEvXTh2qNu2emzixMYdkKeCs5TfdOMKuySE+jKNhb7apee/NzPVQ38
         LqCA==
X-Gm-Message-State: AO0yUKWXHcRHsPq40iKatsleJf4+N4gQm9ykotL4unEs5ai3+ZywfaY1
        JtYTEHJaO86SDSkHAwcE2Po=
X-Google-Smtp-Source: AK7set8zE5R9imDjkfkNuxiJSk0+e0JA3dNsTUxWIeITlzljnpOOVxOFMIa6S9dDuddJcALQVRJnQQ==
X-Received: by 2002:a17:906:2358:b0:88d:d700:fe15 with SMTP id m24-20020a170906235800b0088dd700fe15mr10557817eja.0.1676968789991;
        Tue, 21 Feb 2023 00:39:49 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906539700b008b128106fc7sm6835503ejo.46.2023.02.21.00.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 00:39:49 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 21 Feb 2023 09:39:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Xen Devel <xen-devel@lists.xenproject.org>,
        Per Bilse <per.bilse@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the xen-tip tree
Message-ID: <Y/SDU7d2LS9ka1+a@gmail.com>
References: <20230214124700.22f0a62e@canb.auug.org.au>
 <Y+tu6Xqqb6cdiDAA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tu6Xqqb6cdiDAA@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 14, 2023 at 12:47:00PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commits are also in the tip tree as different commits
> > (but the same patches):
> > 
> >   415dab3c1796 ("drivers/xen/hypervisor: Expose Xen SIF flags to userspace")
> >   336f560a8917 ("x86/xen: don't let xen_pv_play_dead() return")
> >   f697cb00afa9 ("x86/xen: mark xen_pv_play_dead() as __noreturn")
> > 
> > These are commits
> > 
> >   859761e770f8 ("drivers/xen/hypervisor: Expose Xen SIF flags to userspace")
> >   076cbf5d2163 ("x86/xen: don't let xen_pv_play_dead() return")
> >   1aff0d2658e5 ("x86/xen: mark xen_pv_play_dead() as __noreturn")
> > 
> > in the tip tree.
> 
> This was intentional (dependencies) and the plan is to only offer the
> tip branch for merge after the Xen tree goes in.

The rebase & *duplication* was not intentional at all - I assumed 
1aff0d2658e5 won't get rebased. :-/

We'll probably have to redo the objtool tree.

Thanks,

	Ingo
