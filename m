Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B36E6C60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDRSrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDRSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020FF2694
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681843580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BB7vJoU3HrrLNxTi8Xk72x9Aag8/v7/whz+Iy4S1B8Q=;
        b=LXhFFRg/NVCzPkYdOh1yK9Ophktn4fgdMyxYo0QnFRerKYP31w83TpZnNx+yW4fgOo5DK1
        IfB1O98ECxqAqBDwig6sX7o6KRaHu+cntczFftZS5+oIGpZRiBfTXzTsbWEHktipd5LkY0
        zhqL33YXNCeWUk4lXEkcpl+wbDS34Zw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-LtQTkdBIO7C4mUIZ7IzFuA-1; Tue, 18 Apr 2023 14:46:18 -0400
X-MC-Unique: LtQTkdBIO7C4mUIZ7IzFuA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ecd50d9db9so4601141cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681843578; x=1684435578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BB7vJoU3HrrLNxTi8Xk72x9Aag8/v7/whz+Iy4S1B8Q=;
        b=PQk2G6Fu0nVKZgB3rUnzVMxmhAfdUJ5WOyohS+XWQaWPYe/Y8rUivhxnhwMpP7K9QJ
         0U0D89DsPBB9Stli9QtkyYyKHVNz95BBATRSMJlUm7R77AQrRcGY4kidplj+RlAv0YaE
         xUaM0B04a9lX7OruFJ7yWzFMf5g3C49CW1cJsCM7qCtaWIKN96gTEMNfyXg+hx66r12h
         fkjwAb6VTo/PIfciygDWhzQZD1FZHE5IsvjtCx0ZQnngpDUGW9FJ3aEymzQ7o/KZwb4U
         CoEWyZh+nA2KgItxbB7WAfRtUkIeCDHk7AgplafWlmOkLEzmkN9tm/6RH75GbeBkTzk8
         Ws3w==
X-Gm-Message-State: AAQBX9ciSlWmlK3NgtZ6SVcoej+OCC19CPckceE/a8QATm/jFyX7iltW
        nXcME7BMoKHXuZM1W4+DRtL+NjCwPPpyC6dfTwZ094qCMGVpTGzVrEp43LXjqntSVdkp/uWSuyo
        XVRuFMc85DsoEnhTFWUXbXCpt
X-Received: by 2002:a05:622a:1352:b0:3ef:37fa:e1d6 with SMTP id w18-20020a05622a135200b003ef37fae1d6mr7109281qtk.2.1681843578060;
        Tue, 18 Apr 2023 11:46:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aaYkIPSXh56iejgXsondxtvJiaCp+DeLUdNdH+yalmk8s8oiHwbrbN5wEHL54x9K9oqF0MMA==
X-Received: by 2002:a05:622a:1352:b0:3ef:37fa:e1d6 with SMTP id w18-20020a05622a135200b003ef37fae1d6mr7109253qtk.2.1681843577799;
        Tue, 18 Apr 2023 11:46:17 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a210500b0074cf009f443sm2553280qkl.85.2023.04.18.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:46:17 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:46:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD7ld4Iffdmv5Q8f@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD25bBPbZYSb7grA@x1n>
 <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
 <ZD61DLJNilUeDCnC@x1n>
 <ZD64C3R6BzqpSfYX@casper.infradead.org>
 <ZD672ewd4j/1v2IQ@x1n>
 <CAJuCfpGuF_kKXMSx2bHNC7FprOfqbCp+cfdsoct9sN=1+wqtAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGuF_kKXMSx2bHNC7FprOfqbCp+cfdsoct9sN=1+wqtAQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:45:52AM -0700, Suren Baghdasaryan wrote:
> On Tue, Apr 18, 2023 at 8:48 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Apr 18, 2023 at 04:32:27PM +0100, Matthew Wilcox wrote:
> > > ... when we called clone()?  A thread by definition has a reference to
> > > its own mm.
> >
> > Ah yes.. thanks!
> 
> re: I also had a quick look on do_exit() but I also didn't see where
> do we e.g. wait for all the threads to stop before recycles a mm.
> 
> We recycle mm after all refcounts are dropped in the exit path:
>   do_exit
>     exit_mm
>       mmput(if !mm->mm_users)
>         mmdrop(if !mm->mm_count)
>           free_mm

I assume Matthew means when the task_struct is created with part of
kernel_clone().

copy_mm() has:

	if (clone_flags & CLONE_VM) {
		mmget(oldmm);
		mm = oldmm;
	} else {
		mm = dup_mm(tsk, current->mm);
		if (!mm)
			return -ENOMEM;
	}

If CLONE_VM, we'll mmget() on the existing mm. If !CLONE_VM, we'll just
create a new one with reference held.  For the latter, I think that hides
in mm_init() where it'll just set it to 1:

	atomic_set(&mm->mm_users, 1);

With mm_users>0, do_exit() will leave the mm_struct* alone since mmput()
will still be called but not the final step on mmdrop().

Thanks,

-- 
Peter Xu

