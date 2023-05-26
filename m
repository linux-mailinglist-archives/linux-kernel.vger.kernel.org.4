Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0471228E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjEZIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbjEZIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:45:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E097219A;
        Fri, 26 May 2023 01:45:36 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0B496606E83;
        Fri, 26 May 2023 09:45:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685090735;
        bh=jIYCjGbXEyWJJEvEqZFXDnEttlE1pdHBfo4pRBrBZ44=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ddK5/GN9kRklJI2XLwlNE6peqrD4tc8nVY5l2UQ41DrEC44HDa+qWEkoxqNMbJLgF
         FxYJM7znsKalwM09C/EjgdvjYdnhB1Lu9mCrvmvIGYAFPv8ePMm7llLDEdaoCXLydp
         RjLGCxvZsLX1d0k71oNsBQTyxypn+8p34mTrNs0vYFyKym+1MNGLwMze01bxEUJCBe
         DAJhb3Z/vPGM06ZQ+3/Zbh13CswcOPkgdbgv8u+pz1jHAm7/jLzZkBGyku+DKAbXUg
         iCnTdzx5QI/RURMXHwOoUJtVsKPA+eVlXBz2RxePNN6DYdYcBENtP49hZXOHAeH+nd
         0fwUTB3RJT0sQ==
Message-ID: <23366389-1be5-92ef-7728-ce639d46a0b0@collabora.com>
Date:   Fri, 26 May 2023 10:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] notifier: Initialize new struct srcu_usage field
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20230526073539.339203-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230526073539.339203-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/05/23 09:35, Chen-Yu Tsai ha scritto:
> In commit 95433f726301 ("srcu: Begin offloading srcu_struct fields to
> srcu_update"), a new struct srcu_usage field was added, but was not
> properly initialized. This led to a "spinlock bad magic" BUG when
> the SRCU notifier was ever used. This was observed in the MediaTek
> CCI devfreq driver on next-20230525. Trimmed stack trace as follows:
> 
>      BUG: spinlock bad magic on CPU#4, swapper/0/1
>       lock: 0xffffff80ff529ac0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>      Call trace:
>       spin_bug+0xa4/0xe8
>       do_raw_spin_lock+0xec/0x120
>       _raw_spin_lock_irqsave+0x78/0xb8
>       synchronize_srcu+0x3c/0x168
>       srcu_notifier_chain_unregister+0x5c/0xa0
>       cpufreq_unregister_notifier+0x94/0xe0
>       devfreq_passive_event_handler+0x7c/0x3e0
>       devfreq_remove_device+0x48/0xe8
> 
> Add __SRCU_USAGE_INIT() to SRCU_NOTIFIER_INIT() so that srcu_usage gets
> initialized properly.
> 
> Fixes: 95433f726301 ("srcu: Begin offloading srcu_struct fields to srcu_update")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

