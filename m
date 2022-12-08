Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97066646B29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLHI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHI4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68C61B92
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670489742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94o1vDMU6dLWOzRVJEl23OAXi5JeqCSUmbJc/8D9OYk=;
        b=XIbIbgE2kN3C93rw9VnzqLxAXhWO27v4zI+zIRzd4/EV3aNGc/2tCss5qcEoKRi/2LCNw/
        6iREnmhg4zcaxQUic/lWh2GRG+zGp5uAzXnin9f+HNfk3DwjmrpDvknSkjweTFMUyepcot
        qcKXL1GVnynGA6oQhroQ+VTdRpBZI4w=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-r0Py_6g1NuOfMjPRAnwy-Q-1; Thu, 08 Dec 2022 03:55:38 -0500
X-MC-Unique: r0Py_6g1NuOfMjPRAnwy-Q-1
Received: by mail-vs1-f69.google.com with SMTP id a4-20020a671a04000000b003b057ae263cso168413vsa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94o1vDMU6dLWOzRVJEl23OAXi5JeqCSUmbJc/8D9OYk=;
        b=m+RIKifXueKm8OgeKz/ReF9jRbPEMiACNHtFxZe+nMmXbA+ib6oLSaEGAQLAgV5Dnv
         /P8ZZThFb6P43/s6TPz/4JAfGl3qWeGEoe1ra6OE0AUdcfU6UAx6A90NYQ0AFRPo7fkc
         glEXfQRM/KvKiMPiNkIJAh4KQnzjQivWKnAQ871aNkH8vlsAh1plnS8D1Em+cOuOXa+Z
         y6amsK/pek2DXHqdG03a5nnhBu+hqkZdbqK3cG+HHkATNGPa3BtESN4ij5amqwnH2q36
         cc2YYG/hmXnCf6qmipHCc3WrE2QYzWnyMaolJmFRQB38LhHpxjCAAdNcTEZ+aoN5Kq3P
         H3Ww==
X-Gm-Message-State: ANoB5pm2E7pRUujBD15FUg5Zvdu9L9cJBeOzRDwjnFdc1IvjdpCXRZ75
        T06gpK1nb+Gh0Tf7rpNOS+MhW7ovmQxGayu4Gj92OqP1/q2UK4+bj383n0JOMRbNFnD3MEyn57I
        RikaTtIQyVjggf+Ix5HMc4W7jeDuo5NlLWLNEd/Uw
X-Received: by 2002:a05:6102:a4c:b0:3aa:2125:2573 with SMTP id i12-20020a0561020a4c00b003aa21252573mr41688486vss.59.1670489737618;
        Thu, 08 Dec 2022 00:55:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5RYrccsx+1CD8iQ1H386933+kgTEz7P8+0xUUtameokiOyPtVElOj0qR1dboms72q9sne52T2ahn4Gs+1Ikl0=
X-Received: by 2002:a05:6102:a4c:b0:3aa:2125:2573 with SMTP id
 i12-20020a0561020a4c00b003aa21252573mr41688483vss.59.1670489737380; Thu, 08
 Dec 2022 00:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20221206090939.871239-1-zhongjinghua@huawei.com> <Y4/mzMd4evRg9yDi@fedora>
In-Reply-To: <Y4/mzMd4evRg9yDi@fedora>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 8 Dec 2022 16:55:26 +0800
Message-ID: <CAFj5m9KHDMaK5jg3_UXNWiEFbSNt9Ot==B8Bdxd8_G_Kis0nsw@mail.gmail.com>
Subject: Re: [PATCH-next] block: fix null-deref in percpu_ref_put
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 9:08 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> Hello,
>
> On Tue, Dec 06, 2022 at 05:09:39PM +0800, Zhong Jinghua wrote:
> > A problem was find in stable 5.10 and the root cause of it like below.
> >
> > In the use of q_usage_counter of request_queue, blk_cleanup_queue using
> > "wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter))"
> > to wait q_usage_counter becoming zero. however, if the q_usage_counter
> > becoming zero quickly, and percpu_ref_exit will execute and ref->data
> > will be freed, maybe another process will cause a null-defef problem
> > like below:
> >
> >       CPU0                             CPU1
> > blk_mq_destroy_queue
> >  blk_freeze_queue
> >   blk_mq_freeze_queue_wait
> >                               scsi_end_request
> >                                percpu_ref_get
> >                                ...
> >                                percpu_ref_put
> >                                 atomic_long_sub_and_test
> >  blk_put_queue
> >   kobject_put
> >    kref_put
> >     blk_release_queue
> >      percpu_ref_exit
> >       ref->data -> NULL
> >                                  ref->data->release(ref) -> null-deref
> >
>
> I remember thinking about this a while ago. I don't think this fix works
> as nicely as it may seem. Please correct me if I'm wrong.
>
> q->q_usage_counter has the oddity that the lifetime of the percpu_ref
> object isn't managed by the release function. The freeing is handled by
> a separate path where it depends on the percpu_ref hitting 0. So here we
> have 2 concurrent paths racing to run with 1 destroying the object. We
> probably need blk_release_queue() to wait on percpu_ref's release
> finishing, not starting.
>
> I think the above works in this specific case because there is a
> call_rcu() in blk_release_queue(). If there wasn't a call_rcu(),
> then by the same logic we could delay ref->data->release(ref) further
> and that could potentially lead to a use after free.
>
> Ideally, I think fixing the race in q->q_usage_counter's pattern is
> better than masking it here as I think we're being saved by the
> call_rcu() call further down the object release path.

The problem is actually in percpu_ref_is_zero(), which can return true
before ->release() is called. And any pattern of wait_event(percpu_ref_is_zero)
may imply such risk.

It may be not easy to fix the issue in block layer cleanly, but can be
solved in percpu-refcount simply by adding ->release_lock(spin lock)
in the counter for draining atomic_long_sub_and_test() & ->release()
in percpu_ref_exit(). Or simply use percpu_ref_switch_lock.

Thanks,
Ming

