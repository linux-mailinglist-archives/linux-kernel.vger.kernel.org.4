Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A5567D3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAZSQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:16:13 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC45E533
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:15:58 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 626A0921DB5;
        Thu, 26 Jan 2023 18:15:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0D2D2921618;
        Thu, 26 Jan 2023 18:15:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674756953; a=rsa-sha256;
        cv=none;
        b=2VJ+UaeeDXKlINAObl5A7Y6xCmBXCEn7KSsf5cTbVV+tQs7pINo5FTZnch0Nb8Dxqn48XP
        YMzQR1UpFYf860h3LfFFlvmmPQALkOOA4fctdEBep+yRx7qVlH6YWelPxVLYo6iM2S0QIA
        1Vc6cfM9MXwk0JV11HLc/nSvW4u9BNJR/4U29zDqqA9wJRU13fbyH5M0Vn8J6Su+6+wbpj
        d9Qj6x4wIUOLfQHYiT9qBzOUXMpRzjbUTddQFuz8ysFpvR8+vtZXv02zr+j5mTswugLDQS
        28ujb4BcNLAMPt9OD/Vo85pNV3sqKJ4hh4BOwetZy3EJ+Wz+5i0byQ/v2GFBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674756953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BjAq7stYCEU0LfFp3xSDkbIfCy1Lt6xLAOHKbUfQFpc=;
        b=e5+HyIEehag8VI8HAJweOiWLk0SQgSr1UEjig9TcAdPCTyODTVlDiKorTapsIYyUhx3fP/
        Z2H94OxwxmuAHPsYt122Nw3sv7VV7kN0OJyACUHRMMbbiKWXXawJ+uMqiwAFCrSxPkji+g
        i6qtfuHLHGncl9waZuPBqYXZHY3rpAxi2voUf+nZ/BeSG0qNThuE/iWfcUxaS5lNM2pSds
        QSOvG3ttOUvv0X37+f4SlZsHqU/KGzTPJ3x3qkLdal5Nyhclr/QxDQricbmumFjgqI5+LU
        oByEywm0yldEWJ+pUp0BspYvfscUKrOssZqcAJreK7B41BCgL8LJF1gOSyKolg==
ARC-Authentication-Results: i=1;
        rspamd-9476994bd-27fh8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Cure: 10ca89f21e12bec8_1674756954048_636975460
X-MC-Loop-Signature: 1674756954048:253671399
X-MC-Ingress-Time: 1674756954048
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.120 (trex/6.7.1);
        Thu, 26 Jan 2023 18:15:54 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4P2pmP2ZHHz22;
        Thu, 26 Jan 2023 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674756952;
        bh=BjAq7stYCEU0LfFp3xSDkbIfCy1Lt6xLAOHKbUfQFpc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ieib9aHKHrfLqCOC+rDVo4CAMUit/ODVDKl1jArfcQUCadb85FUQY/H0KEG0EamMM
         cryA9XIfSkiMOBZjpvwjkd68rMLg04rgzpJfTsEV8rlqUr3b0go58wvdQ6NyLBaHbq
         AIG+iCfCi/ABoRDRnpRu7+MlEeTjIy9RflpDEoxB9g8VeeddbCvvY7o5UGMaVa9+l0
         8ao6U0i4NdOFQWQBYe+ov9zzXqI8ZfGyhrqzgT03Zu2QUNjzz1UL3xTVPPBUcBejs/
         Yy2/ETZ59zv1XZgGdXNCwnGb++JAu62SpehNcb/7nMIB6o0SpuhnbF3YtUtjz+23Mw
         sWtnk0S8tQy9w==
Date:   Thu, 26 Jan 2023 09:48:59 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
Message-ID: <20230126174859.x7rloojcuafbvjpo@offworld>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-3-surenb@google.com>
 <20230125162419.13379944d6c0d4253d7bc88c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230125162419.13379944d6c0d4253d7bc88c@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023, Andrew Morton wrote:

>On Wed, 25 Jan 2023 15:35:49 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
>> vm_flags are among VMA attributes which affect decisions like VMA merging
>> and splitting. Therefore all vm_flags modifications are performed after
>> taking exclusive mmap_lock to prevent vm_flags updates racing with such
>> operations. Introduce modifier functions for vm_flags to be used whenever
>> flags are updated. This way we can better check and control correct
>> locking behavior during these updates.
>>
>> ...
>>
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> +static inline void init_vm_flags(struct vm_area_struct *vma,
>> +static inline void reset_vm_flags(struct vm_area_struct *vma,
>> +static inline void set_vm_flags(struct vm_area_struct *vma,
>> +static inline void clear_vm_flags(struct vm_area_struct *vma,
>> +static inline void mod_vm_flags(struct vm_area_struct *vma,
>
>vm_flags_init(), vm_flags_reset(), etc?
>
>This would be more idiomatic and I do think the most-significant-first
>naming style is preferable.

I tend to prefer this naming yes, but lgtm regardless.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
