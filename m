Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D966601B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAKQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjAKQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:13:32 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F8E167FE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:13:31 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7FC96881032;
        Wed, 11 Jan 2023 16:13:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BBDBE880899;
        Wed, 11 Jan 2023 16:13:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673453608; a=rsa-sha256;
        cv=none;
        b=kBt8CodQDMxAaJCJ9NkjMnsMHYrzssuMjtELc8yv22zwenwf+6kU3J7TvMY1y+cBd2WUy7
        h4m5WUCVqLN5lE176ZhbHkrlKaQGoNJ0hv5z70ilWehI6lEVwPk+3y4z4ezJ9ErjqBdgDm
        yQ8gfZJ08NogfWw+v/e3+YYkGc8kqFNxslFxVeP1nQNaEaj/DE9pz2EmKqxwhelOM7NWpU
        c17pYNAQx1+pXL6SUucpK7n1oCpmJVs9B58wUGnBOqEw7fwZEXD60u+OZqmPpBrEfGpJlu
        WzBdKs768TdId/v64LwIKfy+PyseSOcoGGRpPuJ5NytC/ExLpJF5WMD4Jb5YBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673453608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KqIdSfYPmousuY+i1hAYcNEcFaIbxrAIfRrrhY59IL8=;
        b=luH8dHpwgxUE+PsIhm23bxBHudBJcBtkq2X3xfr03x1FSwr2Zf+JFpIliyQWFlQb/g9xYf
        t8Z+2vPvgF+GK7JW3Aw6pPdw31Lv7RHpj152RMr1Ovz/GW/8iwwVmGjUxaBI0/ojUQdUyd
        LGMXUYpd8a+73BAaqD2l5NBJYJDwz+7OOMnPLbIQFrJIFFByH93GtTJdLCIq0MbeYVD0aA
        dU8ioi09wDuQPFwSciZevdL8D7SInxxvKE0mHxWO1LOx0Rn2CKJSDZyb1u9qfBMdph2BeW
        YdWuAwGxPwHiGYXGIDNBiVch7rZ8SVMWeiIkSUmDeILv0VqtefzrbJykKe9wzg==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-cfcxj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Abaft: 22751edb54470cba_1673453609106_2379691172
X-MC-Loop-Signature: 1673453609106:2687867213
X-MC-Ingress-Time: 1673453609106
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.75 (trex/6.7.1);
        Wed, 11 Jan 2023 16:13:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4NsXm31ljkz2L;
        Wed, 11 Jan 2023 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1673453607;
        bh=KqIdSfYPmousuY+i1hAYcNEcFaIbxrAIfRrrhY59IL8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=MgHokpDIPaFmfSbcnF0EHEFEvg0EoFiKyrM7Sz7SHRg0Jdy9hMryQ5+V4NEnQX+Oj
         PNhCzQrfq4+IaNp6XAKB6Fp/Hrjkr29MKyhqR1hm91ne+tr33nCDYpRWnB8paCpmwN
         a3Rj8zxogdkLlSB6kgz1P68UXMlRpsKKTqBZfA98LL8YPwnW/RCO3OyH/1qdecIVu8
         S46cPS7yT0U9Bo6BbMAdBLjgmoCZgMlIoBGSddz7fKiUwOFcg4g0MH+rGLgNttS6ap
         ZW+pYHxNXpPl/O+Xzu9dLdHce/4Jz/A6W+V2lOPYE8w8uU+cfT4j1V3NVfQRvoGRP/
         J0ftdyQQJWHgw==
Date:   Wed, 11 Jan 2023 07:47:26 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
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
Subject: Re: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
Message-ID: <20230111154726.stadwtzicabwh5u5@offworld>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
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
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-14-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230109205336.3665937-14-surenb@google.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:

>To keep vma locking correctness when vm_flags are modified, add modifier
>functions to be used whenever flags are updated.

How about moving this patch and the ones that follow out of this series,
into a preliminary patchset? It would reduce the amount of noise in the
per-vma lock changes, which would then only be adding the needed
vma_write_lock()ing.

Thanks,
Davidlohr
