Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C686AD336
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCGAQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGAQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BB367C9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678148133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3mAOro0Ev+QaSIa4qsnSHWb6Poo29R0wjU0QXUfzbU=;
        b=h+CEy1aofJGjkwRwmxCNmRIBBcvdiPBnI6+s/ga8cQFk14G8iOKSLOV35X+9XhWGpeXWzZ
        +esd3N4U05mJuZmVGjkbqqkSkryWEPs/zwZZYJfgP+fAY/mcep0rGmAfJQH7T8dxCwLlbp
        OQlheV4QtZ9EukV+8KF86FR58ikYrOU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-mcraYlhXNHOE6luDn6rOLg-1; Mon, 06 Mar 2023 19:15:32 -0500
X-MC-Unique: mcraYlhXNHOE6luDn6rOLg-1
Received: by mail-qk1-f200.google.com with SMTP id x14-20020ae9e90e000000b007429af46d5eso6392845qkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3mAOro0Ev+QaSIa4qsnSHWb6Poo29R0wjU0QXUfzbU=;
        b=AxQ3M+TBeU0PpAo8BCQM12ydVhCTWlDcEdlL9kvifUtOrlp2GDWde8tgMw8V6xzdWQ
         ov1WdNeniSVtpk0711UoTkMBAlIErsZUkxflccC88Kn7Hw1I9+JHx35BsGG8XKk59IGM
         SeRWN6qFNP5SJHC2VJAyRJ08PLi8xf859zAh4vBpcjwTHExWvZ/vXapp1oySKVQt9LwR
         AHbrwbF7qbgB6gYN/tZ16/3x3wrKCLsrdWnNOfmeykcdw+2j417GM37Riyq1mz4JGR/X
         dl0YkNF5tM8zANZj2Bf19yMHjiGoSqOF8ae/NYk0veXbGuY6mzi87GVI3K+VQDau+7km
         J42g==
X-Gm-Message-State: AO0yUKWJdXTUowKnSdM8Cz8y4KDgfLpIWZ3hX+0ohjXcGKKn8Tr9XNgz
        J3BR3rkJQHwBBKdKB8QHbNRQrc7UDL509DsWctC1nzuTDRp4MxQijKnDyJtJAFu1sBfinraCZNm
        S2n2wTdCsM8p4sh8sbE+1HfkP5uDmaCeA
X-Received: by 2002:a05:622a:28a:b0:3bf:a60d:43b9 with SMTP id z10-20020a05622a028a00b003bfa60d43b9mr20492391qtw.4.1678148131170;
        Mon, 06 Mar 2023 16:15:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/NYsFR3vMRJsaCq5gmejuHuCA+r8anGeehdq+VWUDtS6J66BH71wCshaZogf5wJ7bDwB+aiA==
X-Received: by 2002:a05:622a:28a:b0:3bf:a60d:43b9 with SMTP id z10-20020a05622a028a00b003bfa60d43b9mr20492368qtw.4.1678148130825;
        Mon, 06 Mar 2023 16:15:30 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id o5-20020a374105000000b007429ee9482dsm8248414qka.134.2023.03.06.16.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:15:30 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:15:29 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: THP backed thread stacks
Message-ID: <ZAaCISgq4A/GnkCk@x1n>
References: <20230306235730.GA31451@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306235730.GA31451@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:57:30PM -0800, Mike Kravetz wrote:
> One of our product teams recently experienced 'memory bloat' in their
> environment.  The application in this environment is the JVM which
> creates hundreds of threads.  Threads are ultimately created via
> pthread_create which also creates the thread stacks.  pthread attributes
> are modified so that stacks are 2MB in size.  It just so happens that
> due to allocation patterns, all their stacks are at 2MB boundaries.  The
> system has THP always set, so a huge page is allocated at the first
> (write) fault when libpthread initializes the stack.
> 
> It would seem that this is expected behavior.  If you set THP always,
> you may get huge pages anywhere.
> 
> However, I can't help but think that backing stacks with huge pages by
> default may not be the right thing to do.  Stacks by their very nature
> grow in somewhat unpredictable ways over time.  Using a large virtual
> space so that memory is allocated as needed is the desired behavior.
> 
> The only way to address their 'memory bloat' via thread stacks today is
> by switching THP to madvise.
> 
> Just wondering if there is anything better or more selective that can be
> done?  Does it make sense to have THP backed stacks by default?  If not,
> who would be best at disabling?  A couple thoughts:
> - The kernel could disable huge pages on stacks.  libpthread/glibc pass
>   the unused flag MAP_STACK.  We could key off this and disable huge pages.
>   However, I'm sure there is somebody somewhere today that is getting better
>   performance because they have huge pages backing their stacks.
> - We could push this to glibc/libpthreads and have them use
>   MADV_NOHUGEPAGE on thread stacks.  However, this also has the potential
>   of regressing performance if somebody somewhere is getting better
>   performance due to huge pages.

Yes it seems it's always not safe to change a default behavior to me.

For stack I really can't tell why it must be different here.  I assume the
problem is the wasted space and it exaggerates easily with N-threads.  But
IIUC it'll be the same as thp to normal memories iiuc, e.g., there can be a
per-thread mmap() of 2MB even if only 4K is used each, then if such mmap()
is populated by THP for each thread there'll also be a huge waste.

> - Other thoughts?
> 
> Perhaps this is just expected behavior of THP always which is unfortunate
> in this situation.

I would think it's proper the app explicitly choose what it wants if
possible, and we do have the interfaces.

Then, would pthread_attr_getstack() plus MADV_NOHUGEPAGE work, which to be
applied from the JVM framework level?

Thanks,

-- 
Peter Xu

