Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947E6664214
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjAJNji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjAJNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:39:11 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6A7D1C2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1673357948; bh=v5N8p01gdRXd9HDoez1M3dRvvrduawOYO6ixbE1M6R8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DkxZm0T763oFY9qq45rG5QwyK3tN+7FmSsKQ5zw4f9nFmD+CqLjds31MCpG707Y+Z
         KuOIP/7a7vki9E5B76CFl2yHKj9gRHwCIqxpv7ws5FX4jdapX9UTOmW1LrFZ+VcL7i
         7mztigY8lC23ZkQoRMYAz17cEInna4r7lVOazJOlFxApdnY7qTuqnb1MEMGe2QIpxL
         sGCHWbwtweUc0JWx42us41cgQn1L79grbd5aM8QUWa6tbBZEys3+yqTvM71rAXIiRU
         CxVxq4eJuNwT5lXTA0fuFYXFZ51rXOv3sU9RDMnNEVmwiXULMdl6vCYkGSS+i3hld4
         I/snm5pBud8+g==
Received: by gentwo.de (Postfix, from userid 1001)
        id 9E14DB0017C; Tue, 10 Jan 2023 14:39:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 95146B00169;
        Tue, 10 Jan 2023 14:39:08 +0100 (CET)
Date:   Tue, 10 Jan 2023 14:39:08 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     Marcelo Tosatti <mtosatti@redhat.com>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific
 vmstat discrepancies
In-Reply-To: <Y71XpnJGumySL9ej@lothringen>
Message-ID: <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de>
References: <20230105125218.031928326@redhat.com> <20230105125248.813825852@redhat.com> <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de> <Y71XpnJGumySL9ej@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023, Frederic Weisbecker wrote:

> Note I'm absolutely clueless with vmstat. But I was wondering about it as well
> while reviewing Marcelo's series, so git blame pointed me to:
>
> 7c83912062c801738d7d19acaf8f7fec25ea663c ("vmstat: User per cpu atomics to avoid
> interrupt disable / enable")
>
> And this seem to mention that this can race with IRQs as well, hence the local
> cmpxchg operation.

The race with irq could be an issue but I thought we avoided that and were
content with disabling preemption.

But this issue illustrates the central problem of the patchset: It makes
the lightweight counters not so lightweight anymore. The basic primitives
add a  lot of weight. And the pre cpu atomic updates operations require
the modification of multiple values. The operation cannot be "atomic" in
that sense anymore and we need some other form of synchronization that can
span multiple instructions.


