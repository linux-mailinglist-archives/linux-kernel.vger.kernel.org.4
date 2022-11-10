Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0782A623F50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiKJKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKJKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:03:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6606B3AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668074562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2q1t7C25N3Vp3tFlEZLX1WD9ENHtLq/HGn/qVSycOr4=;
        b=Jj3S01Wk1ZNn0S0GlVQL9VSMXbRYQK5uv7EO/jZp57I1j0YrXqSCNk+QXvaZN8IFUE/Wh8
        hxsrTtvWBzDIFtgLXUN8Hcs2ZcfFh9eKmDQ4rABlJpGxHmh7x0qTKpoFLu+oRDwVqVQSQD
        Rae/lYrRTdzxAr21YNzz/Nb/SXW/RiY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-waU6EajgNoG2aLhBRrt5fQ-1; Thu, 10 Nov 2022 05:02:41 -0500
X-MC-Unique: waU6EajgNoG2aLhBRrt5fQ-1
Received: by mail-pl1-f200.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso1099421plg.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2q1t7C25N3Vp3tFlEZLX1WD9ENHtLq/HGn/qVSycOr4=;
        b=Pk+edqb3bRejsEX+0sEQOHjnjx3zkm+QxciObP1oyLmfYrXYLJUk1bDjNLoIWOrGnX
         vuvDdIi5PE4282OI3ImZQ5YZfVTQ0TQg27tWzfXF6B+0TCKtifLp97Xu7ik9m3Hg60xs
         gr7CavXhLD5N9moRWqS9UpvhqoVeMrNfiB2lRuBbxfZZX7570IV63DPHz/hTInznY5Wh
         yHXoE7qAqDzyEtLhAsJcL5gXAwEigrVIzhRQV/DNbUtn+MpBMTyHGIt99xXSpgQJjx0I
         wn1AC3NDAy9Tsp6lTMqYynCcFGQcXHzWC+o8oALoFyYcYRFXdnumtr7uUMEyg10UtIAD
         sRew==
X-Gm-Message-State: ANoB5pkP2HRHAonFrcLSMf94AA0Ds4nM426TdzkboEYsoHojPrQpx9DF
        kxU276ed+cj+u3kJLkH+ceFFRv8pEoTM+9gJjufkDN8oCqMrcqp/X7dnukAUqytQem4F9aH+Anq
        bbno8/zyXvPHAqdguDuThhvcmHb5TF/3hW4y2z+EmWVDWAp+03EjP231csJEvzrMQSvkCzr/fcm
        +h
X-Received: by 2002:a17:90a:64c5:b0:217:346c:6ed2 with SMTP id i5-20020a17090a64c500b00217346c6ed2mr31623569pjm.202.1668074560288;
        Thu, 10 Nov 2022 02:02:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7FIh7WS8WC/aUKorNND7B0z1uT6DsvPJJ/B87AT2mIW3fRadQkmtnp/p6pMOxxrhW0OmWkQw==
X-Received: by 2002:a17:90a:64c5:b0:217:346c:6ed2 with SMTP id i5-20020a17090a64c500b00217346c6ed2mr31623535pjm.202.1668074559631;
        Thu, 10 Nov 2022 02:02:39 -0800 (PST)
Received: from ovpn-194-83.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b004388ba7e5a9sm8865479pgk.49.2022.11.10.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:02:38 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>, seanjc@google.com,
        pbonzini@redhat.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: selftests: Make Hyper-V guest OS ID common
In-Reply-To: <CAHVum0eYbQJvXY_TVyjadAYVrAcwXSEyJhpddkcBSohj+i+LqA@mail.gmail.com>
References: <20221105045704.2315186-1-vipinsh@google.com>
 <20221105045704.2315186-5-vipinsh@google.com>
 <874jv8p7c5.fsf@ovpn-194-83.brq.redhat.com>
 <CAHVum0eYbQJvXY_TVyjadAYVrAcwXSEyJhpddkcBSohj+i+LqA@mail.gmail.com>
Date:   Thu, 10 Nov 2022 11:02:28 +0100
Message-ID: <87v8nnnn4b.fsf@ovpn-194-83.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vipin Sharma <vipinsh@google.com> writes:

> On Wed, Nov 9, 2022 at 5:48 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Vipin Sharma <vipinsh@google.com> writes:
>>
>> > Make guest OS ID calculation common to all hyperv tests and similar to
>> > hv_generate_guest_id().
>>
>> A similar (but without hv_linux_guest_id()) patch is present in my
>> Hyper-V TLB flush update:
>>
>> https://lore.kernel.org/kvm/20221101145426.251680-32-vkuznets@redhat.com/
>>
>
> After getting feedback from David, I decided to remove
> LINUX_VERSION_CODE in v2. Our patches are functionally identical now.
>
> @Sean, Paolo, Vitaly
> Should I be rebasing my v2 on top of TLB flush patch series and remove
> patch 4 and 5 from my series? I am not sure how these situations are
> handled.
>
> @Vitaly
> Are you planning to send v14?
>
> If yes, then for v13 Patch 31 (KVM: selftests: Move HYPERV_LINUX_OS_ID
> definition to a common header) will you keep it same or will you
> modify it to add  HYPERV_LINUX_OS_ID  in hyperv_clock.c and
> hyperv_svm_test.c?
>
> If not, then I can add a patch in my series to change those two files
> if I end up rebasing on top of your series.
>

Rumor has it that v13 is going to be merged to kvm/queue soon so I have
no plans for v14 at this point. Fingers crossed)

-- 
Vitaly

