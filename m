Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E823D673476
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjASJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjASJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:31:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F085A825
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:31:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 529F637BC3;
        Thu, 19 Jan 2023 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674120671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FBT6wzhK2UunnASnPSdx/iqihHXc3wFh1VVgMsb6VKA=;
        b=tNshMnGxdSbA+I2e0XZ7irNDU1P9ofyO06zaZeOGrIRUrTbu32JIjVEkX2015Uqk8LTtr3
        4taFAjtwB8ddwicGYKdsvkCHowFdQKOrHjraZNi/52dFMBTwO9hEtyBFtFxDlEnRjQ/zsL
        d5ne5VEjHi2FDliNndYnS/tZzKOO1N0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F421134F5;
        Thu, 19 Jan 2023 09:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5vcgB98NyWMVfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 19 Jan 2023 09:31:11 +0000
Date:   Thu, 19 Jan 2023 10:31:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 17/41] mm/mmap: move VMA locking before
 anon_vma_lock_write call
Message-ID: <Y8kN3stHeEyAoB+D@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-18-surenb@google.com>
 <Y8a734ufLZjPHgtT@dhcp22.suse.cz>
 <CAJuCfpGoYaF2-z7FCiN4X8gEGD6nAwnQC+=n3tUHuMWZa7zx8Q@mail.gmail.com>
 <Y8e6lm76fIoT0603@dhcp22.suse.cz>
 <CAJuCfpHtV5xEo97X62uR=LXjK6wQMJXhhV2OxXexTfyudGOptw@mail.gmail.com>
 <Y8hls4MH353ZnlQu@dhcp22.suse.cz>
 <CAJuCfpF3j5Sx+D5p5QPCHP4jcWZUiYm=FfUNYhc6QyHZQvDgpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF3j5Sx+D5p5QPCHP4jcWZUiYm=FfUNYhc6QyHZQvDgpw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 13:48:13, Suren Baghdasaryan wrote:
> On Wed, Jan 18, 2023 at 1:33 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > So it will become:
> > Move VMA flag modification (which now implies VMA locking) before
> > vma_adjust_trans_huge() to ensure the modifications are done after VMA
> > has been locked. Because vma_adjust_trans_huge() modifies the VMA and such
> > modifications should be done under VMA write-lock protection.
> >
> > which is effectivelly saying
> > vma_adjust_trans_huge() modifies the VMA and such modifications should
> > be done under VMA write-lock protection so move VMA flag modifications
> > before so all of them are covered by the same write protection.
> >
> > right?
> 
> Yes, and the wording in the latter version is simpler to understand
> IMO, so I would like to adopt it. Do you agree?

of course.
-- 
Michal Hocko
SUSE Labs
