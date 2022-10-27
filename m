Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA0610606
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiJ0W4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiJ0W41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B869BC6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666911385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4xRVRM6HYM4dL/jcPP/fB2OpyR5lIQBVcswO2a72qg=;
        b=YB86aGvGw+lBDBXWhDOX68ac+rjcjv+bOs7nsVnQmX16jSvfraoGyAk4pAtDbXGiKWa1y+
        igvYSNPgrmC4i9ThiOHYKDDV6jMksuCBdiZQbs/ErgUfvKnE6NKzwZ+CQolhGutk797yxW
        PAnAnbiDuxoSzRP8pQLbZMAz6FYsAmM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-3davNqSbO_Owdnx0-5oHVQ-1; Thu, 27 Oct 2022 18:56:22 -0400
X-MC-Unique: 3davNqSbO_Owdnx0-5oHVQ-1
Received: by mail-io1-f72.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso2518636iob.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4xRVRM6HYM4dL/jcPP/fB2OpyR5lIQBVcswO2a72qg=;
        b=gD9gL8euvnVFtDiQWJB67abku+ehjS4NgmD+jPeoO1/tPpv7Eq5G2Dc2Y4FwhCTLbO
         09n2QJItEkxW9AdX836RA4xArLn/eijQIbR7zazsAQeDnY9tlBJVBmF467+l5Hms6H5A
         BFYeCQIAq/jka3byfPQr0Fk0pmE9j9i7VacisPkXihMpvMzV2s8zndrLUqy2KHtwtet0
         W2TJlhW39rNjF7TKXt9DJGE6kcosy3mFbs6pvB8PMiQo1oFyRVvvT99kWKe01ajjG0gI
         mTElstPqm3M9EV4YCOqwshxZ66bYW0DBZw8SDFnb9ucrs8rvvPz4APmghaFXj3/cE7ps
         x4JA==
X-Gm-Message-State: ACrzQf3LYi8BXZj/pZA04nsKa7nU4WWXxEoj2RYr1k+HeelAphIvPL+i
        AIFn1++uKuqu5TsWRTm2+/6Y7xeL/XszvyDfI4+bHFbXBL2Y0UPjVZoANJjx4l+uoqHnKSymojH
        IldtdDe78FCqPi5AzAXwBMxhq
X-Received: by 2002:a02:2a04:0:b0:374:fe6c:2a96 with SMTP id w4-20020a022a04000000b00374fe6c2a96mr11316940jaw.109.1666911381473;
        Thu, 27 Oct 2022 15:56:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7T7Q5zxySQTKkcYSbAXC1Tm9HpqTCvGbn5Ns3K5+i3OYkTS7p+EAyxJDWdQMgah0eBwjsKVw==
X-Received: by 2002:a02:2a04:0:b0:374:fe6c:2a96 with SMTP id w4-20020a022a04000000b00374fe6c2a96mr11316920jaw.109.1666911381260;
        Thu, 27 Oct 2022 15:56:21 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id j197-20020a0263ce000000b00369a91d1bd4sm1019725jac.138.2022.10.27.15.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:56:20 -0700 (PDT)
Date:   Thu, 27 Oct 2022 18:56:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yuanzheng Song <songyuanzheng@huawei.com>,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH STABLE 5.10] mm/memory: add non-anonymous page check in
 the copy_present_page()
Message-ID: <Y1sMk30wS+1uH/hc@x1n>
References: <20221024094911.3054769-1-songyuanzheng@huawei.com>
 <3823471f-6dda-256e-e082-718879c05449@google.com>
 <Y1nRiJ1LYB62uInn@x1n>
 <fffefe4-adce-a7d-23e0-9f8afc7ce6cf@google.com>
 <Y1qdY8oUlUvWl067@x1n>
 <8aad435-bdc6-816f-2fe4-efe53abd6e5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8aad435-bdc6-816f-2fe4-efe53abd6e5@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:58:02PM -0700, Hugh Dickins wrote:
> Let me delete stable from the Cc, this discussion is not for stable.
> 
> On Thu, 27 Oct 2022, Peter Xu wrote:
> > On Wed, Oct 26, 2022 at 06:48:29PM -0700, Hugh Dickins wrote:
> > > 
> > > And I imagined that the correct fix (short of going forward with David's
> > > full changes) would be to back out to a context where one could add an
> > > anon_vma_prepare(), then retry after that - involves dropping pt lock,
> > > maybe gets nasty (tedious, anyway).
> > 
> > Right, that looks a larger changeset with minimum benefit - the page is
> > still inconsistent before fork(), and also for users don't fork() at all
> > after the RO pin.
> 
> Sorry, I don't understand any of what you're saying there: but you appear
> to be saying ("larger changeset with minimum benefit") that my suggestion
> would not be worth the effort - fair enough, but...
> 
> > 
> > It looks to me Hugh's suggestion would be the best suite here for stable.
> > Yuanzheng, what do you think?
> 
> ... now you appear to be saying it would be worth the effort.  Oh,
> perhaps you're referring to just the change to check dst anon_vma:
> perhaps, but I'm really having to guess at what you mean.

Sorry for not being clear.  Yes I was referring to that original idea of
using dest->anon_vma.

> 
> But none of that matters as much as below...
> 
> > 
> > For the long term I think we should wait for David's further unshare work
> > so gup_must_unshare() will work for page caches too while mapped private.
> 
> I do wonder if in the long term we shall have to port all David's work
> back to 5.15 and 5.10 (but I think there's yet more to come from him).
> But set aside that thought for now...
> 
> More urgently, in the short term:
> 
> Peter, you've made no reference to David's mail, where he concludes that
> Yuanzheng's !PageAnon patch is the appropriate one; and
> David, you've made no reference to Peter's mail, where he concludes that
> my doubts were correct, and it needs a different patch.
> 
> You appear to disagree over whether a RO-pinned file page needs to
> be copied at fork() time.  I don't know, but I hope you can agree
> on that (in the 5.10 and 5.15 context: maybe David is thinking of
> the 6.0 context and Peter of the 5.10 context) before going further.
> 
> (I'm hoping David is right, and I was plain wrong, since that's easiest.)

For some reason I thought David was talking about the plan for the latest..

The major difference IIUC is whether we'll CoW for page caches during
fork() with the old kernels or not with the two approaches (PageAnon check,
or dst->anon_vma check).

After a re-read and 2nd thought, I think David has a valid point in that we
shouldn't have special handling of !anon pages on CoW during fork(),
because that seems to be against the fundamental concept of fork().

So now I think I agree the !Anon original check does look a bit cleaner,
and also make fork() behavior matching with the old/new kernels, irrelevant
of the pin mess.

Thanks,

-- 
Peter Xu

