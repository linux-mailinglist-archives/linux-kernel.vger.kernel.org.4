Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD11160BEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJXXmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiJXXlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE5B1B9F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666648809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aS4yi1vMu6K7Mzb0dwDEe+zwP7hRRYhJ4HxVAVJl5ro=;
        b=A0h3L+3OFO2hZeJ50KNvTH8BKCDW6NSZl5q30DEi2ouT0a8/nj9Q1eTAJcfnuLjqqQNm8t
        KhInuEA/g+VOF12nWxUr3U67vXAnJD4x43lngcWWmAtpJxz7L4UEnf17c/mZobCMCYOjh1
        eUl4WdSopd983/pZttCrdoxuTWdzrcA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-167-Ms8xgqHYPg29FvkGKzDYAg-1; Mon, 24 Oct 2022 15:43:02 -0400
X-MC-Unique: Ms8xgqHYPg29FvkGKzDYAg-1
Received: by mail-qv1-f69.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso5818556qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS4yi1vMu6K7Mzb0dwDEe+zwP7hRRYhJ4HxVAVJl5ro=;
        b=QtBWzCfWOrPCOaWK5RLEuf3c/tverQg9SOZQuuNrRX43BW62tFA5dX8ln9xV0iz1r5
         TR2396w/KTO/mWsQf+IME3DarIt5rfbteQFXl/KXlDsrjHVjwGZMX8J5ejCLrtxSXKsP
         hi0OlOLpR0SUV8MnwF2O3UFAS/+RZh5QE2I+VEHeOiD3iFQVNndsvM1hMUXf7PhQTNKT
         8Cg6l6XcjAADUyR1Uxm9Xg1NIJaYgtJ4BkxbBCPqOnPKbgLsT3L9ALnApJ8je2AK5mN9
         MyGlu/GBBWfq0XZgAyKLjnwc3IACso2OQvfmV6wubBhPpKAZOe5W0/iZp5u7hvaIqk5M
         5n1w==
X-Gm-Message-State: ACrzQf28BAQaOEO57khnlfBHHT69dmma72nf1qB1tuwy5qZBXJSD94Hc
        IPQE6rtbOz0vDgtnmmibjiiM4blNJdzAfUiAsvryeatf7CnRs+jdlIHTv4RBtrucxucPUZePAZW
        wPT06L9LBOmm4gmut0XhwFw8n
X-Received: by 2002:a37:64d0:0:b0:6ec:534b:d20e with SMTP id y199-20020a3764d0000000b006ec534bd20emr24544536qkb.491.1666640581833;
        Mon, 24 Oct 2022 12:43:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5HG4hPuNw+OrKVY7aj1+sC0sBSEP1h08iDsLmFF9r5v1x56LUQQ3QNpwRFzoTNCyuX90ew0A==
X-Received: by 2002:a37:64d0:0:b0:6ec:534b:d20e with SMTP id y199-20020a3764d0000000b006ec534bd20emr24544518qkb.491.1666640581591;
        Mon, 24 Oct 2022 12:43:01 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bn1-20020a05620a2ac100b006ce3cffa2c8sm521364qkb.43.2022.10.24.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:43:01 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:42:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/2] mm/uffd: Fix vma check on userfault for wp
Message-ID: <Y1bqw7M36Gyya3eD@x1n>
References: <20221024193336.1233616-1-peterx@redhat.com>
 <20221024193336.1233616-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221024193336.1233616-2-peterx@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:33:35PM -0400, Peter Xu wrote:
> We used to have a report that pte-marker code can be reached even when
> uffd-wp is not compiled in for file memories, here:
> 
> https://lore.kernel.org/all/YzeR+R6b4bwBlBHh@x1n/T/#u
> 
> I just got time to revisit this and found that the root cause is we simply
> messed up with the vma check, so that for !PTE_MARKER_UFFD_WP system, we
> will allow UFFDIO_REGISTER of MINOR & WP upon shmem as the check was wrong:
> 
>     if (vm_flags & VM_UFFD_MINOR)
>         return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
> 
> Where we'll allow anything to pass on shmem as long as minor mode is
> requested.
> 
> Axel did it right when introducing minor mode but I messed it up in
> b1f9e876862d when moving code around.  Fix it.
> 
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")

Should also have had:

Cc: stable@vger.kernel.org

> Signed-off-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

