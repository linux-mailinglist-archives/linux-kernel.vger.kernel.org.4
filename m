Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67A64CC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbiLNO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiLNO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9027DCF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671028071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUOCPLsMlvmgNvxqq+xl+qmXFp8RWQPctNaQzKj5Za8=;
        b=fQwuf/P3/WyJ2+Q6lkafpaJTPjyTDBlJPlykfMNFl/RwOlRs10fEOESzaA9nKUiuLKZOtc
        SbFAFk2RScvXll6vy6exTOvKZ0EM9pG7UkOPvfUWE0T6hmcNjMw2jK5pKFGXzGlSNLHqFS
        LkpzBbtGudg46ePPzeBCAqyn4THgWvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-m9by8QAVMw6msAdiiBzc8g-1; Wed, 14 Dec 2022 09:27:47 -0500
X-MC-Unique: m9by8QAVMw6msAdiiBzc8g-1
Received: by mail-wm1-f69.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so6473012wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUOCPLsMlvmgNvxqq+xl+qmXFp8RWQPctNaQzKj5Za8=;
        b=VxBK02CoxLk9kPGwYRZmhLkMS4ov6wRTx2PoAJjdbHlfU9Bxf5JmO3MgADKhKaiKaZ
         p9OzZtEmuUf6vpD8Z/re4x28awoiCWj5kuJZl/9Azpmj1o/1BDhh7ElLUL9S4yf5BJx+
         6+YyfZxFeZCRhO8uiSOdv20H+gXNTBjs/EQG7bczm53IyBUcD39bzKdC+CAJAS3tNsxf
         FeByuhH7loCEonNQYKCvN0c/09q3MEjxFc4AoxdZdiYXMIUqJx1Fps/zYm1l649alo39
         GjrQZt8Ts14xXKCJZpnICkimkNSCVQnaxb4aea8/9fYM9wIhVg3U+2hbLLEYM7/gTWPK
         G1pw==
X-Gm-Message-State: ANoB5pnTU2YxXlU1Zp934l0OJoG5sCfHq1XuS+GrbyEXwyDVZbGNGBpl
        46m25IwP+EaaW5XeqDSg0UZwJvhvXjli29nsD5KjPqOwrC/K58Ak1hPZ9Tm3LmVLam32BiodQPY
        95tNKyAa2TeZe414dEtQLiKhA
X-Received: by 2002:a05:6000:10a:b0:242:3b08:51ee with SMTP id o10-20020a056000010a00b002423b0851eemr14250625wrx.61.1671028065479;
        Wed, 14 Dec 2022 06:27:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6D+MsUcEs1FOJY6loDHWSlpVg1Lbs8KDbj30T68FfG0OAE5mfaDnky52VFD3wc9G8R+3zSUQ==
X-Received: by 2002:a05:6000:10a:b0:242:3b08:51ee with SMTP id o10-20020a056000010a00b002423b0851eemr14250609wrx.61.1671028065130;
        Wed, 14 Dec 2022 06:27:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7700:dd7c:92f8:481f:b96b? (p200300cbc7037700dd7c92f8481fb96b.dip0.t-ipconnect.de. [2003:cb:c703:7700:dd7c:92f8:481f:b96b])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b00241f029e672sm2914089wrp.107.2022.12.14.06.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 06:27:44 -0800 (PST)
Message-ID: <a30b2940-f650-4a09-0d5a-be43bbff313f@redhat.com>
Date:   Wed, 14 Dec 2022 15:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm/uffd: Always wr-protect pte in pte|pmd_mkuffd_wp()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221208194628.766316-1-peterx@redhat.com>
 <e679d3fe-be8e-d7c0-798a-df32587553ed@redhat.com> <Y5ndIlgWMp8RuTdI@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y5ndIlgWMp8RuTdI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.12.22 15:26, Peter Xu wrote:
> On Wed, Dec 14, 2022 at 11:59:35AM +0100, David Hildenbrand wrote:
>> On 08.12.22 20:46, Peter Xu wrote:
>>> This patch is a cleanup to always wr-protect pte/pmd in mkuffd_wp paths.
>>>
>>> The reasons I still think this patch is worthwhile, are:
>>>
>>>     (1) It is a cleanup already; diffstat tells.
>>>
>>>     (2) It just feels natural after I thought about this, if the pte is uffd
>>>         protected, let's remove the write bit no matter what it was.
>>>
>>>     (2) Since x86 is the only arch that supports uffd-wp, it also redefines
>>>         pte|pmd_mkuffd_wp() in that it should always contain removals of
>>>         write bits.  It means any future arch that want to implement uffd-wp
>>>         should naturally follow this rule too.  It's good to make it a
>>>         default, even if with vm_page_prot changes on VM_UFFD_WP.
>>>
>>>     (3) It covers more than vm_page_prot.  So no chance of any potential
>>>         future "accident" (like pte_mkdirty() sparc64 or loongarch, even
>>>         though it just got its pte_mkdirty fixed <1 month ago).  It'll be
>>>         fairly clear when reading the code too that we don't worry anything
>>>         before a pte_mkuffd_wp() on uncertainty of the write bit.
>>
>> Don't necessarily agree with (3). If you'd have a broken pte_mkdirty() and
>> do the pte_mkdirty() after pte_mkuffd_wp() it would still be broken. Because
>> sparc64 and loongarch are simply broken.
> 
> That's why I mentioned on the order of operations matters.
> 
>>
>>>
>>> We may call pte_wrprotect() one more time in some paths (e.g. thp split),
>>> but that should be fully local bitop instruction so the overhead should be
>>> negligible.
>>>
>>> Although this patch should logically also fix all the known issues on
>>> uffd-wp too recently on either page migration or numa balancing, but this
>>> is not the plan for that fix.  So no fixes, and stable doesn't need this.
>>
>> I don't see how this would fix do_numa_page(), where we only do a
>> pte_modify().
> 
> Yes, this patch won't, because it's a pure cleanup.  Otherwise we need
> another line of wr-protect in numa recover path.
> 
> I can remove that sentence in v2 commit log.

Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

Nothing jumped at me.

-- 
Thanks,

David / dhildenb

