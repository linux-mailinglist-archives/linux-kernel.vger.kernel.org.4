Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD16DFF66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDLUJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDLUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143161B3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681330121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdO2/I6wOUQxoSSiwra0n4gQA+gYUisy/Yi9wlX79ws=;
        b=hQLEBxLzsIefIzM49b8iHYgn35Ki1e3lsjxygq95WjOqUjMhj1FR8J5Oe9zpB5tNPeIAyQ
        5NfkGGLkCi4maozZwj96tUmh3AgM7D0l0xZq5bkO5G4noHpXas19EAMmHB6T2y8KvyoecG
        1eugd0zUJgSX9IwbHCLRqrXW8HfE3SM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-XdMWEGzWMvyUFgR4hLpnNA-1; Wed, 12 Apr 2023 16:08:39 -0400
X-MC-Unique: XdMWEGzWMvyUFgR4hLpnNA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74a904f38f3so88173885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330119; x=1683922119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdO2/I6wOUQxoSSiwra0n4gQA+gYUisy/Yi9wlX79ws=;
        b=NeTliGAE/WpcGnYsmjKz/Bo2z0yCAZKuOqWt1YscEpZDcAKcz4krn/n1l7xrGJamZx
         UHSF/R1Hpn4qZnByZbg1VgEvVQpKguQz80WXDtjMmtHUak9vQRCDJGX5VQoTQVCyAI0T
         dhYR9FKkpl4M2zSNEug4wtZtfwr3pdPQpRAcpigxXpYs2CQEYMweYx4ybeq2q2VfjWL5
         XjNlYjZ7Q1/eVaD8vZSwiYXpeJMLqKvBsbZZpCQgk1+wv8stvSb5Fog+eSXOPRhAUc6a
         8Z5OnqDqbsRZbOzOgGgv57BxjPfOWXC3wRCk/bo/lkmF5DZMMiuSMruRu48R4XDGkr3S
         vBRA==
X-Gm-Message-State: AAQBX9fYlEe2k6wj3XsjYU8W3sau/50bKCki9sUiO2ll7+ud64qfSSo/
        UwlvMM1xJKRErFXqsFQ6+hnhieJF4zW5UkqDLJVRJb2JUWLsDBam7R5Gm35eVrTyvigXBsx+u1x
        hHw2mpATCimDOhkggWZFaKj76
X-Received: by 2002:a05:6214:401a:b0:5aa:14b8:e935 with SMTP id kd26-20020a056214401a00b005aa14b8e935mr5581611qvb.2.1681330119268;
        Wed, 12 Apr 2023 13:08:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bX1oAtWowJaU6wuzfTqtxyW4XmdGaEUQDzVIuNdn57ibnNFhftBPj9Nv0c9ckS+f1wdk5+SQ==
X-Received: by 2002:a05:6214:401a:b0:5aa:14b8:e935 with SMTP id kd26-20020a056214401a00b005aa14b8e935mr5581584qvb.2.1681330118958;
        Wed, 12 Apr 2023 13:08:38 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id pe6-20020a056214494600b005e938eb99ecsm3618698qvb.122.2023.04.12.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 13:08:37 -0700 (PDT)
Date:   Wed, 12 Apr 2023 16:08:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PATCH v2 16/31] selftests/mm: UFFDIO_API test
Message-ID: <ZDcPxBvzPOt5POy/@x1n>
References: <20230412163922.327282-1-peterx@redhat.com>
 <20230412164257.328375-1-peterx@redhat.com>
 <CAJHvVcgtAhEkqkYegHONCJz5uJoxRLRdm9Kp8DmkcnZhU=w=9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgtAhEkqkYegHONCJz5uJoxRLRdm9Kp8DmkcnZhU=w=9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:47:39PM -0700, Axel Rasmussen wrote:
> > +#define  uffd_test_fail(...)  do {             \
> > +               printf("failed [reason: ");     \
> > +               printf(__VA_ARGS__);            \
> > +               printf("]\n");                  \
> > +               ksft_inc_fail_cnt();            \
> > +       } while (0)
> > +
> > +#define  uffd_test_skip(...)  do {             \
> > +               printf("skipped [reason: ");    \
> > +               printf(__VA_ARGS__);            \
> > +               printf("]\n");                  \
> > +               ksft_inc_xskip_cnt();           \
> > +       } while (0)
> 
> Some of this is duplicating what's in kselftest_harness.h - e.g.
> assertions, printing test summary, keeping track of pass/fail/skip
> counts, etc.
> 
> I wonder how you feel about using the standard harness? E.g. is the
> plan to do this (more straightforward?) refactor first, and then
> switch later? Or is there some reason it can't be used?

David asked similar question.  I wanted to arrange the output mostly for:
(1) one test per line, (2) dump test name before anything (even failing).
The 2nd one is important for uffd tests since it uses err() which bails out
immediately on unexpected failures (comparing to uffd_test_fail).

To achieve that I found I can use ksft_inc_xskip_cnt() etc. so I kept using
the counters in the harness but leave the print format on my own.  I assume
that's also why these were exported in kselftests.h so when tests want to
have customized output it can still use the counters.

Thanks,

-- 
Peter Xu

