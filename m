Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD2868F45B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjBHRYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBHRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9B30282
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IUqBstuHz31BqYAH45XQiY9e8g79CcuPVVxrpMxtUqI=; b=qEupYAAuMu0sDh+BbYVoGnX3mv
        fUj+aiYhTI+PqBBRURZo/XmMFP45wNW8rQjF6Y3xDy4rncv1A7MhB7e4vshV+FItywdeCy85CWJdk
        ZhKMw8KEe7rwauxmqSPgZ+ZuBSop7eZTvtPNoXVgFRCPun1K4YR5SU/+i9oL4m+WBBkyQ37kc8MoY
        84yUXL9u3I+hm570fG3WHTyM0pm1p9KnV8Bkb9icwOYBkrOPiFz6XNGcmWpMsg5XPRXuvnogcNcU9
        1T8iQM2+ibz4deX+O4HZ8BI2HyXdK4AWpcWYaoWRDTE+/BJCnUOwKu5oPnzjsdczSmy0cSeNU3fXQ
        YxCBpUDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA3-007Vvc-2V;
        Wed, 08 Feb 2023 17:23:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14F413001CB;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F2F7A203C41EF; Wed,  8 Feb 2023 18:23:49 +0100 (CET)
Message-ID: <20230208171756.898991570@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:17:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 00/10] objtool: Honey, I shrunk the instruction
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Boris complained he could no longer build allyesconfig on his 32G desktop
machine without having OOM terminate either objtool or chrome.

After talking about these patches on IRC, Nathan mentioned the linux-clang CI
was also having trouble of recent, and these patches appear to make it happy
again.

In total these patches shrink an allyesconfig run by about 6G:

pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem

Also at:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

