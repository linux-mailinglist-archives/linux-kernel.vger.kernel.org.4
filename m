Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B7616302
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKBMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKBMsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:48:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFA2A27A;
        Wed,  2 Nov 2022 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GLmyYC068tDZ71XmeksiuAt/PZ4nQaY8vISb1JRaoX8=; b=MTVBYjpNyaEs8LlanL0huN8KSg
        kvmuqGJ/DpvpEzJApRfI+jiMmSzg5Gc6+FnQVp82JXOeY78TI3a1LO2GbJrqavz7BgPcgIzxM8sux
        m7YpT9yG5YHFa8Q16d43bk0rleaYNAAi0l1eapLbtiHm+rpZh5w3H24fK4x6L8S4FYg/vuz/UyGfj
        1MVdg5g4PFC0KeEuiaTMZfC/Aizyqqy/0YG0PigzRcpZQRZJM+XeQ8isR1DXIO9PJQL3OUzfzHKJT
        epDQBqBfXJhti/42JHTFAD5JgDzZNog1frMzVtibCPcpDpHeeyTqUI+VyughUqkhk8NzNWR3Kr5Q4
        4BmKKgqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqDAD-008Oit-5g; Wed, 02 Nov 2022 12:48:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF547300137;
        Wed,  2 Nov 2022 13:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C878320B1E7E1; Wed,  2 Nov 2022 13:48:08 +0100 (CET)
Date:   Wed, 2 Nov 2022 13:48:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] perf/hw_breakpoint: test: Skip the test if dependencies
 unmet
Message-ID: <Y2JnCDhPicfORyas@hirez.programming.kicks-ass.net>
References: <20221026141040.1609203-1-davidgow@google.com>
 <CAGS_qxrd7kPzXexF_WvFX6YyVqdE_gf_7E7-XJhY2F0QAHPQ=w@mail.gmail.com>
 <CANpmjNOgADdGqze9ZA-o8cb6=isYfE3tEBf1HhwtwJkFJqNe=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOgADdGqze9ZA-o8cb6=isYfE3tEBf1HhwtwJkFJqNe=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:22:43AM +0100, Marco Elver wrote:
> Was there going to be a v2 to address (a), or is this patch ready to
> be picked up?
> 
> I assume (unless I hear otherwise), this patch shall also go through -tip?

Yes, I've got it queued, I just haven't gotten around to pushing it out
to -tip, hopefully later today.
