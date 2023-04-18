Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4DB6E67EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDRPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjDRPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2ED335
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681831185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miM/su/ZqczkGcKkc9PCKjknSxb3kUfz7+/bPlcxub8=;
        b=LYNhTO21XgQIE8Imc8D1gupkJSvz6HEFAuaCbeANcaeUtJyHaB0effV8nGIPk0CbT5gqEm
        WjduqQUA6enAoDBY08Gja8nlQhfGhGI1KOfOlq51iuYW3j4oyQnQ+FAoYa1Id89Myp+AP/
        y4HF0P5HRPETU6RAuIaYP9ifZ4oagwI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-I8dvfcGjN2mVIPQzFcctMw-1; Tue, 18 Apr 2023 11:19:43 -0400
X-MC-Unique: I8dvfcGjN2mVIPQzFcctMw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef3116d1dcso3747521cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831183; x=1684423183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miM/su/ZqczkGcKkc9PCKjknSxb3kUfz7+/bPlcxub8=;
        b=Nn3kdOo1L+HpRUK1Dqcra1gMhIouA0LWq8sSLov6VkhLeC3bJgFge4dPSg9cKyiHCt
         MvGvnN4k4JMR382MLxb7t/wGQFa73UXbY3V9ewJUJJFO0rE1TsQ5Cvg9n64M24xeXscr
         vVHaozQ0xpoyaAGJbxre3Czzg3N3l8S4asE1ZTIfXEqj/EkscPHcaH5jilvolm3Sa60V
         pA52CwyiiXguVCen07g56OmdUYP2HwanwiRkbuHusBMHbXjQxWHcNOXCLZtwY8M3n7mI
         XOeN5Rg4fVXW2b0F10nZthrIQvGxWfQDkJj7k54V3FwDfWXWkoaFWPNsQYSOQ07iq77D
         iwgQ==
X-Gm-Message-State: AAQBX9frtHKxmv5q6xjuDUIlQTzgoAhzNMVe+T/SpbyBVf5lqPkCBqOd
        0aJo2N8f3pLrXDcmX6GWC+d/xfSHTcJBajO28PPIqIzMN7E5iV8vYea2wVV9fOTA7aIJfgguQ2A
        ySM/99j/XWb/HBJ7tjLrOmMh7
X-Received: by 2002:ac8:5e0b:0:b0:3ee:5637:29be with SMTP id h11-20020ac85e0b000000b003ee563729bemr14493400qtx.5.1681831183442;
        Tue, 18 Apr 2023 08:19:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zi17x4m1IQ5qI1ICKFQyCQl4GhyF2z+67LbRfbzNK+T1eFMCyaLE7CzceXB+rr//EqZo72gA==
X-Received: by 2002:ac8:5e0b:0:b0:3ee:5637:29be with SMTP id h11-20020ac85e0b000000b003ee563729bemr14493360qtx.5.1681831183172;
        Tue, 18 Apr 2023 08:19:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a210500b0074cf009f443sm2422417qkl.85.2023.04.18.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:19:42 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:19:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD61DLJNilUeDCnC@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
 <ZD25bBPbZYSb7grA@x1n>
 <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHf06cr2d277DXQUtBto_0bVgK3ykMHLYRgZXgnot=e4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:47:57PM -0700, Suren Baghdasaryan wrote:
> On Mon, Apr 17, 2023 at 2:26 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> > > @@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > >               if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
> > >                       mem_cgroup_oom_synchronize(false);
> > >       }
> > > -
> > > -     mm_account_fault(regs, address, flags, ret);
> > > +out:
> > > +     mm_account_fault(mm, regs, address, flags, ret);
> >
> > Ah, one more question.. can this cached mm race with a destroying mm (just
> > like the vma race we wanted to avoid)?  Still a question only applies to
> > COMPLETE case when mmap read lock can be released.  Thanks,
> 
> I believe that is impossible because whoever is calling the page fault
> handler has stabilized the mm by getting a refcount.

Do you have a hint on where that refcount is taken?

Btw, it's definitely not a question sololy for this patch but a more common
question to the page fault path.  It's just that when I wanted to look for
any refcount boost (which I also expect to have somewhere) I didn't really
see that in current path (e.g. do_user_addr_fault() for x86_64).

I also had a quick look on do_exit() but I also didn't see where do we
e.g. wait for all the threads to stop before recycles a mm.

I had a feeling that I must have missed something, but just want to make
sure it's the case.

-- 
Peter Xu

