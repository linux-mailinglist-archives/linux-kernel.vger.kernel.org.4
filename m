Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F76D3E7F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDCH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjDCH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DC7685
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzHpZ5WAiQYV9j8cFvgWd2yh5/Eu+1K2MnoYxqZ9t0M=;
        b=a15xqE/FIeCRREwGpozybN8UIDWfyv9nen+VAq17ZntfpbnEVcMahYrhbnifrvsgviWjPr
        AGM9pFWT2JeUQPZdgMFSMyIIkIkZNEgC5GVRgi7hSE9IcV1t3tAmIvuOlxZWmyB1WFjK8i
        IXSx4Zj5F2+hLUDt8hu9EEKKZ+F4nFs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-21bQ4I8-MPue9_K-QXO-6Q-1; Mon, 03 Apr 2023 03:56:54 -0400
X-MC-Unique: 21bQ4I8-MPue9_K-QXO-6Q-1
Received: by mail-wm1-f72.google.com with SMTP id o37-20020a05600c512500b003edd119ec9eso14143380wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508613;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzHpZ5WAiQYV9j8cFvgWd2yh5/Eu+1K2MnoYxqZ9t0M=;
        b=HPEg+6ArxxEcbPYdkTWnoRINJFfjBaoZvzHef0y56Wlo8IjhByOxrWVAiJHPbd+/v9
         ODcFqTy/T0uxEFYEGSqre5dGWstjTvBwjt38nG8IS4F3SP2qQg2d2k4PtgaK3mV5TyKA
         IwKXGoBLnlYC1rZRvqilHJmJv4TRtMJjXFKoa7aV9F+0rmcq5IxnCSvgNTvPMLPFoeaN
         VAKwRtAYmXhWE0nGe1R2VFgKFB9+LBrpL2aZr4bfoH5H+TwcrjSa5uai7wn1neGvWjcl
         lp1CcetqOcJW2KtBPJcMVI3LfMvZK47bdSPPrdH8ZAZAfit6pcZzv/JL6B9VEx5A47dq
         4oCg==
X-Gm-Message-State: AAQBX9fySajsbMCa8VTzSW4OgwR+rFP4VxNr7rpgKVb/eyYsZJVwAmi9
        2K8mb768GVPhzLtfPbEHMiC93G2k5h3wEsqFxU2E2C1TvabHsyjC0TZq0EAFuGfpJVuHwB8yDe5
        yV0R8Cg4PHGH+ImD271I8zyuu
X-Received: by 2002:a5d:5742:0:b0:2d0:c37a:5ebd with SMTP id q2-20020a5d5742000000b002d0c37a5ebdmr25774651wrw.64.1680508613641;
        Mon, 03 Apr 2023 00:56:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350byxxRpdTK6BbJbot7lH5iAmTTcmMRSXk6dbIlT+FfyplV1kxbX23F9ngOslpl1pXo/s5CKkQ==
X-Received: by 2002:a5d:5742:0:b0:2d0:c37a:5ebd with SMTP id q2-20020a5d5742000000b002d0c37a5ebdmr25774630wrw.64.1680508613362;
        Mon, 03 Apr 2023 00:56:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id t17-20020adff611000000b002c5a790e959sm9044849wrp.19.2023.04.03.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:56:53 -0700 (PDT)
Message-ID: <73e9d113-0418-8a69-83eb-935be531e9e0@redhat.com>
Date:   Mon, 3 Apr 2023 09:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/29] selftests/mm: Drop test_uffdio_zeropage_eexist
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160717.3107010-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160717.3107010-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:07, Peter Xu wrote:
> The idea was trying to flip this var in the alarm handler from time to time
> to test -EEXIST of UFFDIO_ZEROPAGE, but firstly it's only used in the
> zeropage test so probably only used once, meanwhile we passed
> "retry==false" so it'll never got tested anyway.
> 
> Drop both sides so we always test UFFDIO_ZEROPAGE retries if has_zeropage
> is set (!hugetlb).
> 
> One more thing to do is doing UFFDIO_REGISTER for the alias buffer too,
> because otherwise the test won't even pass!  We were just lucky that this
> test never really got ran at all.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

