Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB85616F94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiKBVWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKBVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B825F9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667424078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwjUJXk275rFecz1ZN/R5h4zz71FMLP/gKQdOhmKyzk=;
        b=GHwEMl8CQr7Z4uBRlW2EIYP9IZgvvKDV10xaINqq2m05h9mMmc4gjkOQqZBxib4rLs2ILW
        5a+ITA40VimbuNZopWfBXS02kBEM+kNtbupFF1GtAuoPxbMYunBJSLPHyqRLt4ztxisZJQ
        cl9u8B0bfDGGsZ96jhxAxddDjcaSey4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-478-uoohoJhwM8myu_ckJ27Etg-1; Wed, 02 Nov 2022 17:21:17 -0400
X-MC-Unique: uoohoJhwM8myu_ckJ27Etg-1
Received: by mail-qt1-f197.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso209576qtj.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 14:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwjUJXk275rFecz1ZN/R5h4zz71FMLP/gKQdOhmKyzk=;
        b=imaRIamZYC8KrKBZo0rzfedkejq0au4xHKuhB9j+EVJp5dCz046E09YT4/+b+2+Iqv
         sPNoGKFX8Dg2Kw630MmOrW5b2oPkYWtzt04D5u8cKIQ/878Qkc0IwJJZfPizm/fLJINp
         1lv0ToXMUWvAehDf/QjExUM0567no0QghDX8yTNBJ/daOtqQEGOQc9j44PTnAjFwRnIl
         +9LrfXOZs8YwmEYW4Cy2kGV1XRbibYiJSFLO6CxV1XtBsO/EgMHRdlKUv9xqVbJpqidf
         2lcWM0/kOmq6EMNVKGOnkUjtMJ2zIp/nZuqLYhvB4typLFSxzoTcL59jhiu8wPMdQ80Q
         thHw==
X-Gm-Message-State: ACrzQf3NWWC74+XkSiRYdlKimQITzd8J1E/j8Ckd2HIMyiGR+D/mTI8F
        3bCORUsb4w+ew9n1/kldJ2Di9AiY8BAU0u18HEs4DZQxHoMcQAU1x1zmqTk88QqzRkK0y8I2FqP
        sV+Xus2XQuVI6ElBIoL9ChiqX
X-Received: by 2002:a05:622a:1196:b0:3a5:2fc4:5852 with SMTP id m22-20020a05622a119600b003a52fc45852mr11788051qtk.202.1667424076621;
        Wed, 02 Nov 2022 14:21:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM44f3iMP6a6UsCDkjqdOvGbgMfFn28VOd/20STHVLbjpmYQEoDITy/sO8/YJ03SRJtRUbYRlw==
X-Received: by 2002:a05:622a:1196:b0:3a5:2fc4:5852 with SMTP id m22-20020a05622a119600b003a52fc45852mr11788039qtk.202.1667424076409;
        Wed, 02 Nov 2022 14:21:16 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id 123-20020a370381000000b006e702033b15sm9250562qkd.66.2022.11.02.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:21:15 -0700 (PDT)
Date:   Wed, 2 Nov 2022 17:21:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH RFC 10/10] mm/hugetlb: Comment at rest huge_pte_offset()
 places
Message-ID: <Y2LfSjdJmgQHPTLA@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030213045.335680-1-peterx@redhat.com>
 <3D896ED0-5600-4E55-8509-3F0E355FF692@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D896ED0-5600-4E55-8509-3F0E355FF692@gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:39:33PM -0700, Nadav Amit wrote:
> On Oct 30, 2022, at 2:30 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > +		/* With vma lock held, safe without RCU */
> > 		src_pte = huge_pte_offset(src, addr, sz);
> 
> Just another option to consider: you can create an inline function
> huge_pte_offset_locked_mm(), which would do the lockdep_assert_held_*().
> 
> I personally would prefer it, since it would clarify exactly the lock you
> care about and "make the code document itself”.

That's a great suggestion, I'll give it a shot in the next version.

Thanks!

-- 
Peter Xu

