Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E815F42DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJDMVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJDMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23FC21E01
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664886055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmYbzauBro8vmjMuuRDX3URZE5ffnFmx7G/2HXpXgtM=;
        b=JDn/28C8t1E+rSJyt7Nu/z8Wj3xR1Z9ZoPjqU1Ng6Ab4ktE4P9BqOsqJtzxSvAJ4DEbKhX
        kuxCGUCAvWotNNuN1JNtyYo2YDJ8M6TaRazMWfwLgxGOoOCFAz8U3QjPKho+LIEUh3erbd
        gN8ymolTw3VoBRP+Hh5OpAwdKPtaMi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-25-kQl2kernNPCjhZ8eMNGYlg-1; Tue, 04 Oct 2022 08:20:54 -0400
X-MC-Unique: kQl2kernNPCjhZ8eMNGYlg-1
Received: by mail-wr1-f69.google.com with SMTP id q28-20020adfab1c000000b0022e0399964dso2810296wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=FmYbzauBro8vmjMuuRDX3URZE5ffnFmx7G/2HXpXgtM=;
        b=ZTe/YTcgu8gJXjb/hrNNG+uHoALNKuZM87H+VQ51mTbgTiLda9mCDQMu6Fc6E8vTTy
         UvK93pDld+L608CEkD7m52x/GqrQMN/RrCotxM06gKEU4Vy9G+EER+n2INacXAqZ4zkm
         SpW/JOCcHudhSPN0SayZeO9yJ4Wa8IsZb1mlLqdlZUNzDAkA8Pgxztz+pAyJ16p9ZHCt
         cle3mC5eUvYR/YxZbr9dew+Y/DXI11pjPH3HjgdMG2FkyQZ02hMeIa1afE1fg+8QrLHA
         i79Nt+Xer296/O/SwnEEG775UoPHsmEyJO7wXlBHwXgStTn53BXmrosnwHhrZtDG2+Q7
         bamQ==
X-Gm-Message-State: ACrzQf07+Er7xzQmI3LtRiwH0Pk0IlprFL0TTZnOI47mS8ZcwofUY0fk
        aQkEE7xj1OmUBJv7YSQTEGNzfqAZZAsdByJNKJqKdfjXLjnK6+N6Lv4Dj9LsUvwKgglB/ikuiUm
        iwxH2mkBxqbD2ORMtdim6NBr4
X-Received: by 2002:a05:600c:3d86:b0:3b4:b65f:a393 with SMTP id bi6-20020a05600c3d8600b003b4b65fa393mr10217714wmb.0.1664886053226;
        Tue, 04 Oct 2022 05:20:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63LSNpJtRkOtNEv1B4u9KA+okwjGBtQbtCq0O81IXbU5C07q3ECIIrQhYometIdTC4zPA2Bg==
X-Received: by 2002:a05:600c:3d86:b0:3b4:b65f:a393 with SMTP id bi6-20020a05600c3d8600b003b4b65fa393mr10217689wmb.0.1664886052961;
        Tue, 04 Oct 2022 05:20:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:5000:4fff:1dd6:7868:a36? (p200300cbc70650004fff1dd678680a36.dip0.t-ipconnect.de. [2003:cb:c706:5000:4fff:1dd6:7868:a36])
        by smtp.gmail.com with ESMTPSA id z15-20020a056000110f00b0022e0580b7a9sm3697476wrw.17.2022.10.04.05.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 05:20:52 -0700 (PDT)
Message-ID: <87c2ce28-41fa-cc10-8c8f-3b831621df35@redhat.com>
Date:   Tue, 4 Oct 2022 14:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 3/3] mm/selftest: uffd: Explain the write missing fault
 check
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221004003705.497782-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.22 02:37, Peter Xu wrote:
> It's not obvious why we had a write check for each of the missing messages,
> especially when it should be a locking op.  Add a rich comment for that,
> and also try to explain its good side and limitations, so that if someone
> hit it again for either a bug or a different glibc impl there'll be some
> clue to start with.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 74babdbc02e5..297f250c1d95 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -774,7 +774,27 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
>   		continue_range(uffd, msg->arg.pagefault.address, page_size);
>   		stats->minor_faults++;
>   	} else {
> -		/* Missing page faults */
> +		/*
> +		 * Missing page faults.
> +		 *
> +		 * Here we force a write check for each of the missing mode
> +		 * faults.  It's guaranteed because the only threads that
> +		 * will trigger uffd faults are the locking threads, and
> +		 * their first instruction to touch the missing page will
> +		 * always be pthread_mutex_lock().
> +		 *
> +		 * Note that here we relied on an NPTL glibc impl detail to
> +		 * always read the lock type at the entry of the lock op
> +		 * (pthread_mutex_t.__data.__type, offset 0x10) before
> +		 * doing any locking operations to guarantee that.  It's
> +		 * actually not good to rely on this impl detail because
> +		 * logically a pthread-compatible lib can implement the
> +		 * locks without types and we can fail when linking with
> +		 * them.  However since we used to find bugs with this
> +		 * strict check we still keep it around.  Hopefully this
> +		 * could be a good hint when it fails again.  If one day
> +		 * it'll break on some other impl of glibc we'll revisit.
> +		 */
>   		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
>   			err("unexpected write fault");
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

