Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4968A7D7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 03:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBDCeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 21:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjBDCee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 21:34:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86385709B4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 18:34:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so10506194pjd.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 18:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fywi/Ti0TlNNeuFvNTyWvoWAKwt8+gjFHWHrrYQyMPc=;
        b=EfLArmYHeuf243oXflKPZ4jK88UPhOXPLNBH3HtDMSiO0595j44T+bKG8AAA3aEg8y
         BBgyx/KVvkt5nHMbYqmo8ZzluSmjxSmdSI+YAYtOWv3ZvM6pemLbma6eZo4YmjmA2gaJ
         Xeki3nWxYapRn0bx1KOy9T9CWurz4NPMEgx7uI+f5uIBfQdvuv9AUfgTXy35+z9IxbA9
         JCpJimLVg5Hf8hJUDCmxRGCwBTcnd1I14honMljRTeZBtOQooptb3l4iKEwOqHrWCRYK
         UY/hx5yISxnwstyUiMm1iuNtS+59Gw81NRc9c2cgnhJhKi5xVhBfEjd4RSK2gswad4UD
         dZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fywi/Ti0TlNNeuFvNTyWvoWAKwt8+gjFHWHrrYQyMPc=;
        b=GC9zrKL5DNl74r5Lf71zX6wUq4mdFTw5pLoJ8rqvEs/Ly02RS2wFSuR1eehfOULU87
         dtLVgK01xdtJi2y3JZe50JduVioz6JrXm+lCv4nokjmHcZEPHulfAUfA7dxdY5heADRi
         QOkvfitc+5JK3+5Gw8Vo9okrPiCWney2KumN38UxneB4uTKlnHow8zwQ/A126T7DH4T/
         AKaSVy0JIicutLKdah8qd5fF0L+fIWI8zorRKKshYB/jxRXWYp9BbhX0oap1xb0zj8t2
         KRKjOhJr7nNYEjfYa3KyqdBphcHHV3XOdm0lmJ1aSKX0NvhFPUrfaVUJt7d9d7i6ZvH2
         acmA==
X-Gm-Message-State: AO0yUKVTKOMxC+HwFJu4u3CoElCmjKZkdBMc7f5sJudvxpfq6vHWLOyG
        F57S/id3D+qmDbwDVnxeheCMuA==
X-Google-Smtp-Source: AK7set8qXcdEKZpCS5/BerMEwbvyo7P6DKG8m8Ux4zwfKnbcrddEh0Jzv/WAwU9+gJcAuhS5MmXY+A==
X-Received: by 2002:a17:903:2350:b0:198:af50:e4e8 with SMTP id c16-20020a170903235000b00198af50e4e8mr97386plh.14.1675478072856;
        Fri, 03 Feb 2023 18:34:32 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g10-20020a639f0a000000b00496317241f9sm2160448pge.51.2023.02.03.18.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 18:34:32 -0800 (PST)
Date:   Sat, 4 Feb 2023 02:34:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kvm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH 0/3] KVM: Make use of SRCU deadlock detection support
Message-ID: <Y93ENVvdDWEkrV6S@google.com>
References: <20230113065955.815667-1-boqun.feng@gmail.com>
 <20230113124606.10221-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113124606.10221-1-dwmw2@infradead.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023, David Woodhouse wrote:
> David Woodhouse (3):
>       KVM: Show lockdep the kvm->mutex vs. kvm->srcu ordering rule
>       KVM: selftests: Use enum for test numbers in xen_shinfo_test
>       KVM: selftests: Add EVTCHNOP_send slow path test to xen_shinfo_test
> 
>  .../testing/selftests/kvm/x86_64/xen_shinfo_test.c | 165 ++++++++++++++-------
>  virt/kvm/kvm_main.c                                |  10 ++
>  2 files changed, 124 insertions(+), 51 deletions(-)

As mentioned in patch three, I'm going to repost the selftests changes on top
of other cleanups, and will plan on applying them next week if all goes well.

Paolo, do you want to grab the KVM change directly?
