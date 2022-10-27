Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20B06104EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiJ0V6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiJ0V6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:58:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC4915E2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:58:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so1945119otp.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uq26a1rwMYIjpLBQk8nVo2sH1wrMjVXp0pojJk0NFQ=;
        b=cvf2A9oZAY4UQ0Tq36JlxosoocbwdV/ipWMMUeIdV9Fv6B9WqJBc8vF5axnD/klVCy
         dNnL5VDwrwBjc9ESODVzP4ZMuq9+QQXIPtn+UqVBRnhIw7UllMjCnmkraTT7PzFKaD2W
         tkKkDy42ZEE1EbTiaUCXEGs+cQKSX67TH1l5pLD0jo9zjWHbgT7snUMa2mvuZM4B+n1T
         P6JC4Ug8Bax+mEqUZty6VV13dDLPoDLFAa4l0jLUOTdOj/5KlwiM+HWoQSBQTQH1DdhY
         L+ArcuiENjHA9qjjQbH3jdQbasAHxnRbjeEicupcpq45lBGtaAzNVR+wU1Lfs3t/NECL
         4sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uq26a1rwMYIjpLBQk8nVo2sH1wrMjVXp0pojJk0NFQ=;
        b=gos0UJFnOT8RMUoEeFoWcIbQe1wslT8yF2jmi+NXCsoD3Bf1gSeay/xulnss/XM7Jb
         ePDnyYwUWX7TxZ7XR5nfnghT4t5DKlhyvGUgdcQBmfSR6zbJrXI/TvseIupiRmH7pQTP
         C7oqSmOgRovQd6AwgsWbpvfe5R+C80Mc8lmDTynFVqNfmaiy6T9s0NSlTcxhYr6UOBpl
         e+3/YSsR+OIv9KqO2BsMeyWc2wDz/K7LIPEBlgKvLUbEsEIbpPA+ZXxAIhDlgU1nZZvz
         mVv9SCxhl154i317IuOgmqWM6zJg0YeRt7sjJo6dLUjPzdfV1tCbaFebBkZd9VDzY8dl
         zVeg==
X-Gm-Message-State: ACrzQf1B8+yQudhI0C/sC2AatNHcr6il5x4cVm5gHzUADFY6huIbsKU9
        ZK0sEEwS73I1QgldtzdQ+JTolw==
X-Google-Smtp-Source: AMsMyM6Bi+L5A/E2O0uQPiXczSxifGF2nbn8FWHOQ7jUJBtS0WdTltn+K/qqa/dyhEwPiCALMH1ptg==
X-Received: by 2002:a05:6830:91e:b0:661:c4ad:d8e3 with SMTP id v30-20020a056830091e00b00661c4add8e3mr5388067ott.34.1666907892191;
        Thu, 27 Oct 2022 14:58:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v14-20020a056870310e00b0011dca1bd2cdsm1207937oaa.0.2022.10.27.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:58:11 -0700 (PDT)
Date:   Thu, 27 Oct 2022 14:58:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH STABLE 5.10] mm/memory: add non-anonymous page check in
 the copy_present_page()
In-Reply-To: <Y1qdY8oUlUvWl067@x1n>
Message-ID: <8aad435-bdc6-816f-2fe4-efe53abd6e5@google.com>
References: <20221024094911.3054769-1-songyuanzheng@huawei.com> <3823471f-6dda-256e-e082-718879c05449@google.com> <Y1nRiJ1LYB62uInn@x1n> <fffefe4-adce-a7d-23e0-9f8afc7ce6cf@google.com> <Y1qdY8oUlUvWl067@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me delete stable from the Cc, this discussion is not for stable.

On Thu, 27 Oct 2022, Peter Xu wrote:
> On Wed, Oct 26, 2022 at 06:48:29PM -0700, Hugh Dickins wrote:
> > 
> > And I imagined that the correct fix (short of going forward with David's
> > full changes) would be to back out to a context where one could add an
> > anon_vma_prepare(), then retry after that - involves dropping pt lock,
> > maybe gets nasty (tedious, anyway).
> 
> Right, that looks a larger changeset with minimum benefit - the page is
> still inconsistent before fork(), and also for users don't fork() at all
> after the RO pin.

Sorry, I don't understand any of what you're saying there: but you appear
to be saying ("larger changeset with minimum benefit") that my suggestion
would not be worth the effort - fair enough, but...

> 
> It looks to me Hugh's suggestion would be the best suite here for stable.
> Yuanzheng, what do you think?

... now you appear to be saying it would be worth the effort.  Oh,
perhaps you're referring to just the change to check dst anon_vma:
perhaps, but I'm really having to guess at what you mean.

But none of that matters as much as below...

> 
> For the long term I think we should wait for David's further unshare work
> so gup_must_unshare() will work for page caches too while mapped private.

I do wonder if in the long term we shall have to port all David's work
back to 5.15 and 5.10 (but I think there's yet more to come from him).
But set aside that thought for now...

More urgently, in the short term:

Peter, you've made no reference to David's mail, where he concludes that
Yuanzheng's !PageAnon patch is the appropriate one; and
David, you've made no reference to Peter's mail, where he concludes that
my doubts were correct, and it needs a different patch.

You appear to disagree over whether a RO-pinned file page needs to
be copied at fork() time.  I don't know, but I hope you can agree
on that (in the 5.10 and 5.15 context: maybe David is thinking of
the 6.0 context and Peter of the 5.10 context) before going further.

(I'm hoping David is right, and I was plain wrong, since that's easiest.)

Hugh
