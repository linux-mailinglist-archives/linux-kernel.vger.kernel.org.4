Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815246476FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLHUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLHUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F3471266
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670530027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aO91Cy3aiM72NJuvUVHnXgYZwK+vF7vmwZ76fFMKBJA=;
        b=MUjSTNFgLbzV2kmaynBsaS3qYt5Sbxg439Z8L2l4A4L7MxJUsoQYzc2H3BISCJT3bm1ipn
        WYF49W0PyDuS99d4wmniK7AeOnonlSgKRH0ei6e1P4WLpLj0srtGqko9PiR8JJ8t6NFnAz
        zy+OKe1ihl2NN4pgkIEk5P07YmZQOwA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-136-tHOEfWaBPpCME_Z7XLVa5g-1; Thu, 08 Dec 2022 15:06:20 -0500
X-MC-Unique: tHOEfWaBPpCME_Z7XLVa5g-1
Received: by mail-yb1-f198.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so2599356ybf.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO91Cy3aiM72NJuvUVHnXgYZwK+vF7vmwZ76fFMKBJA=;
        b=5RGcCxIw3gjbRdWN1QGjtMdnpBl7j9vdtgdzDAqpd762pK/QkmMc+JLjqGHVhLuytb
         /zemmz11WKuH7ydST5eQTNDr8sduHXE7CONEBg9DLQjEWDfy7tBWDZ7Te4UI3rFPKfi7
         xqLVsE3902/i0PAAEnQkxjFGiC7FG2bLeN+fDgMRFrYtUOMH8kLEflFG7mAPQC6aQVpr
         Pnxd0Iz7BzcboW5MFlx7EMkD5LoPC9r5KVStQzmlmykeyNx50GywZOl9nC7OG8RJtFn1
         04TJFfnHqDJ3LiN+7NlBCKy4PBjCikkyc0jxrZ8kAAzOYa5uvI59KhF5pjJv+d5tp8im
         ubyA==
X-Gm-Message-State: ANoB5pkyshROV7pBHd2I2lCfyAyBvvuqkggX24VOsnaYla9v1VeqsBVD
        L/JVqFTK+MNG/VaY9F5Vf3SOuuAPzx9j640tZP88bxxuNze2Jl/ZHXUzRLhIDSsRmw4iJjapx7G
        wU9kpvGfKMRbM/UiKW6J/88ZU
X-Received: by 2002:a25:2314:0:b0:714:e101:8548 with SMTP id j20-20020a252314000000b00714e1018548mr1353388ybj.58.1670529968073;
        Thu, 08 Dec 2022 12:06:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6rgZb0VkMbKMAwlRjV5wDNe3+42qmtQQXCtPakXyJ8UHqzCz/Y5cKAOu9FJotIYvo1ZV0gPA==
X-Received: by 2002:a25:2314:0:b0:714:e101:8548 with SMTP id j20-20020a252314000000b00714e1018548mr1353366ybj.58.1670529967829;
        Thu, 08 Dec 2022 12:06:07 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0d8d00b006fab416015csm20082249qkl.25.2022.12.08.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:06:07 -0800 (PST)
Date:   Thu, 8 Dec 2022 15:06:06 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ives van Hoorne <ives@codesandbox.io>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hugh@veritas.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v1] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y5JDrkBGEyZviXz9@x1n>
References: <20221208114137.35035-1-david@redhat.com>
 <Y5IQzJkBSYwPOtiP@x1n>
 <b9162f04-7d8e-1ada-f428-85fd84327d1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9162f04-7d8e-1ada-f428-85fd84327d1c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 05:44:35PM +0100, David Hildenbrand wrote:
> I'll wait for some more (+retest) before I resend tomorrow.

One more thing just to double check:

It's 6a56ccbcf6c6 ("mm/autonuma: use can_change_(pte|pmd)_writable() to
replace savedwrite", 2022-11-30) that just started to break uffd-wp on
numa, am I right?

With the old code, pte_modify() will persist uffd-wp bit, afaict, and we
used to do savedwrite for numa hints.  That all look correct to me until
the savedwrite removal patchset with/without vm_page_prot changes.

If that's the case, we'd better also mention that in the commit message and
has another Fixes: for that one to be clear.

-- 
Peter Xu

