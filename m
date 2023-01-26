Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34567D8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjAZWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:45:33 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDC45F6B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:45:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2wlT4JJLz4xP9;
        Fri, 27 Jan 2023 09:45:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674773130;
        bh=XOKb+ncwVNSj6JKEiaBHvEDttpakjMycwDg9zTg++Is=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lXPZDhnKp+sd6gqb53jikb6eOO6odHtdILrgzMgKDSyLuMoDiBgRP+ELHuco2Pk5j
         bExTu6/51nR17KrDBvMMVYYRMM2grTktq8Y19ZTAzOGve6zQ0RyaYuxJJU/ccYwlLq
         VARaTKbguSWg8orJhovLaoxUEZ/5QmZ4v3DA+YJ3tYKHLpmDuiMv8TMcbVpE+OaslI
         cN4ip7nvjhM/ywEx0AI/tTtnUKDaMxc8nsEcWchZvTI/jVdU5mh3Uk7y/gMUlLr/rh
         I1ETMQKGU6oSz8J0oiWM1S5u/Qz57DHabOJzXwIqRnptofS40o/hs7F8nK2MOsp1A7
         36j8Yufdy8jkw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Subject: Re: [PATCH v4 5/7] mm: replace vma->vm_flags indirect modification
 in ksm_madvise
In-Reply-To: <20230126193752.297968-6-surenb@google.com>
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-6-surenb@google.com>
Date:   Fri, 27 Jan 2023 09:45:23 +1100
Message-ID: <87o7qkzzi4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suren Baghdasaryan <surenb@google.com> writes:
> Replace indirect modifications to vma->vm_flags with calls to modifier
> functions to be able to track flag changes and to keep vma locking
> correctness.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 6 +++++-

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
