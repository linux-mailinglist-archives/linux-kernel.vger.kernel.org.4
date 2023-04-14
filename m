Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F376E2C77
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDNWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3B4C3C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681511700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DyNvvB9wJMtWOTjvADdK8ORGZLiBdVVNFj/pcFzDnMw=;
        b=XePh97Yksvj+97az/9wabJiBT5JFFO6NCi3uHRtukn+6MI9if3TJmQ8plvQ2lW2II/i8ZB
        GcAOpufdFAGgX6yDO/0uuKbciNFLtkvPxgBd+YmZTczPB08MnT+Le76hr2IWJ4kN8K3F/c
        dK3LQV5BPy16dD5Fsnwp9/vXYhbQdJI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-DIHmlTn_PNWYUgchQjj1kQ-1; Fri, 14 Apr 2023 18:34:59 -0400
X-MC-Unique: DIHmlTn_PNWYUgchQjj1kQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5e9b05246edso5203896d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681511699; x=1684103699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyNvvB9wJMtWOTjvADdK8ORGZLiBdVVNFj/pcFzDnMw=;
        b=HkuxkdG3DMWaDBfmiVHHT4CK1wZ1KmGDCYcpLi7Xj24xspVXU+OxJiJY0KHPH9sBJ3
         40HmbeBDW2QhQ7OHSRliLRndlbyjsYCwIFHbYuV2GjOZlMCqX2fJ6jBklCVHKKJFzQGg
         eIm41UCu/+pumlwhGJxqEbWNKr73friiZqyLKTRh3wQV0Dde26upxMkRc872ZIA0YFfG
         sf9T8JEnDXTQwihmtU+ELSrPa13ZRWUBaEuhmufhZbnWtPuS7DzpEKMuKyWaf8jYeizq
         tCuVXNmYd5c3A3OuxTSijmr0RL5jHagUs6HVj95HCyB0VB+Um+PF2+vKntr3B3ebit+t
         gECQ==
X-Gm-Message-State: AAQBX9d6sMusUIKUNdklP1w7oUmwTl3gvW520j8jVwnfT1uMK1snhjp0
        0eQApkVrwmtr6al4Sdc9qE50f91pDBApQBFfUgz8iLmJSC/3wb+5JlXgfJ7sVVzQZRCysvdWZ1o
        +gJTfIxlLLOsjKhv6Ug9pvm9t
X-Received: by 2002:a05:6214:5095:b0:5ef:55d8:7164 with SMTP id kk21-20020a056214509500b005ef55d87164mr5618863qvb.5.1681511699315;
        Fri, 14 Apr 2023 15:34:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZpRphu7aw7txYK/zYfhKTPUmplTazgUS277/tOMkhwtgZpx/RZM5lMrYPXLLaEPwiEhUEOAw==
X-Received: by 2002:a05:6214:5095:b0:5ef:55d8:7164 with SMTP id kk21-20020a056214509500b005ef55d87164mr5618838qvb.5.1681511699015;
        Fri, 14 Apr 2023 15:34:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id ny16-20020a056214399000b005ef6128255bsm145744qvb.92.2023.04.14.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 15:34:58 -0700 (PDT)
Date:   Fri, 14 Apr 2023 18:34:57 -0400
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
Subject: Re: [PATCH 1/1] mm: do not increment pgfault stats when page fault
 handler retries
Message-ID: <ZDnVETTFus3BFLxH@x1n>
References: <20230414175444.1837474-1-surenb@google.com>
 <ZDnJ1dOU2tpK6l68@x1n>
 <CAJuCfpFc2SohkkJnEFqZD-uCpSS9sUzToPcQXOR6dHTTE0Ty5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpFc2SohkkJnEFqZD-uCpSS9sUzToPcQXOR6dHTTE0Ty5w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Suren,

On Fri, Apr 14, 2023 at 03:14:23PM -0700, Suren Baghdasaryan wrote:
> > It also already ignores invalid faults:
> >
> >         if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> >                 return;
> 
> Can there be a case of (!VM_FAULT_ERROR && VM_FAULT_RETRY) - basically
> we need to retry but no errors happened? If so then this condition
> would double-count pagefaults in such cases.

If ret==VM_FAULT_RETRY it should return here already, so I assume
mm_account_fault() itself is fine regarding fault retries?

Note that I think "ret & (VM_FAULT_ERROR | VM_FAULT_RETRY)" above means
"either ERROR or RETRY we'll skip the accounting".

IMHO we should have 3 cases here:

  - ERROR && !RETRY
    error triggered of any kind

  - RETRY && !ERROR
    we need to try one more time

  - !RETRY && !ERROR
    we finished the fault

I don't think ERROR & RETRY can even be set at the same time so I assume
there's no option 4) - a RETRY should imply no ERROR already, even though
it's still incomplete so need another attempt.

Thanks,

-- 
Peter Xu

