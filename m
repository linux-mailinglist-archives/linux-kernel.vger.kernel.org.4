Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4266D4E41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjDCQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjDCQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E1E4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680540233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVGiDe1GkdsOT9JWQfHlYWDDmX0XUnWruX5ozd/Uk+0=;
        b=A+WZ0KYRL/t9tVDdYg204uzeZuyMT0wASMwTsCRiqFk1AJahHC0JovEAUzVnTiHVHHlUnC
        p7TcfQf/TKDNGANUgV1jEjGMGBG5HD/Xarm1I66c3wb0moyz89cnTcIIuWEsSc/0kknitF
        ZbU6SrenBv8Pu1DXRu//6zwu2pZPZIs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-4SxBpa9yNeiNG1h8MHY1IA-1; Mon, 03 Apr 2023 12:43:52 -0400
X-MC-Unique: 4SxBpa9yNeiNG1h8MHY1IA-1
Received: by mail-qv1-f71.google.com with SMTP id q1-20020ad44341000000b005a676b725a2so13301127qvs.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680540231; x=1683132231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVGiDe1GkdsOT9JWQfHlYWDDmX0XUnWruX5ozd/Uk+0=;
        b=QE0aMsJY/riyK8hKoG3yFE7HqAsh9NIrK9ssKFyeNqpEZGUDbAuOOZ+O+0L70Ym5Uv
         HM+R2kSZcEjnE70gzj4Y3gZqxzmZPOBlTFrwR+lmzEApTjvLZ94o+ko4itmK0lrAlw9c
         9RWVjTyRe+oNyom8kMVsquqe41qkbEIHLq+W+kT//v+y1L085q9yAM80rtIlV/pCcTJi
         fZExv1Gob/87gQFXJvSyi/Cwnm9j78t6OgGd2PYoZD7tI3O51B9jWTSgNvtK5OO4pOE0
         Z/142l/aDdjYHh1FpSZ+6gywyhWJmQYHXb8yZzsrHqPT8QuXbj7euhYI3iiQ8DqXy56r
         bfgg==
X-Gm-Message-State: AO0yUKXLQKwRrTDYTC6rDe8NVADbVqV5rsJMUS5rjvkQqTWilV+9lOZV
        I04khz8vH27JvwyULluvsKsYl+XdrrpfNa9Y4M5D8kpX7urnWiiujee3B1/2kXrFEbGqnRFmHAn
        DR6fbDg6xK6t0b1FPDnNbKNEUPi7KFb5s
X-Received: by 2002:a05:622a:1441:b0:3e3:c889:ecf9 with SMTP id v1-20020a05622a144100b003e3c889ecf9mr61308908qtx.1.1680540231260;
        Mon, 03 Apr 2023 09:43:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Mao/c8oTEy6R1RYMtBygjhwJTcm8vryVgWjjDeFRhfShcj9BuRddHEpnSf3AqTCB4rbemCw==
X-Received: by 2002:a05:622a:1441:b0:3e3:c889:ecf9 with SMTP id v1-20020a05622a144100b003e3c889ecf9mr61308870qtx.1.1680540230949;
        Mon, 03 Apr 2023 09:43:50 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id t18-20020ac87612000000b003e4d96eae60sm2650833qtq.4.2023.04.03.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:43:50 -0700 (PDT)
Date:   Mon, 3 Apr 2023 12:43:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/29] selftests/mm: UFFDIO_API test
Message-ID: <ZCsCRRdnbeNgcSlq@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160752.3107283-1-peterx@redhat.com>
 <fcf40deb-e731-c257-fb77-7fcfddf623b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcf40deb-e731-c257-fb77-7fcfddf623b1@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 09:59:50AM +0200, David Hildenbrand wrote:
> There is ksft_print_msg, ksft_test_result, ksft_test_result_fail, ... do we
> maybe want to convert properly to ksft while already at it?

Yes, I started with trying to use that but found that there're not a lot of
things that I can leverage.

Starting with ksft_set_plan() - I think this is something we call first. I
want the current unit test to skip everything if UFFD API test failed here,
then I need to feed in a dynamic number of "plan" into ksft_set_plan().
But I never know after I ran the 1st test..

I can call ksft_set_plan() later than this, but it misses a few tests which
also looks weird.

It also seems to not really help anything at all and not obvious to use.
E.g. ksft_finished() will reference ksft_plan then it'll trigger
ksft_exit_fail() but here I want to make it SKIP if the 1st test failed
simply because the kernel probably doesn't have CONFIG_USERFAULTFD.

Another example: I never figured what does x{fail|pass|skip} meant in the
header..  e.g. ksft_inc_xfail_cnt() is used nowhere so I cannot reference
either.  Then I don't know when I should increase them.

In short, to make the unit test behave as expected, I figured I'll just
write these few helpers and that's good enough for this unit test.  That
takes perhaps 5 min anyway and isn't hugely bad for an unit test.

Then I keep the exit code matching kselftests (KSFT_SKIP, etc.).

What I can do here, though, is at least reuse the counters, e.g:

 ksft_inc_pass_cnt() / ksft_inc_fail_cnt()

There's no ksft_inc_skip_cnt() so, maybe, I can just reuse
ksft_inc_xskip_cnt() assuming that counts "skip"s?

Let me know if you have better ideas, I'll be happy to switch in that case.

Thanks,

-- 
Peter Xu

