Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F863F1AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiLANcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiLANcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:32:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB04B53;
        Thu,  1 Dec 2022 05:32:41 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2BEC1FD8F;
        Thu,  1 Dec 2022 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669901559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REO845ueyHwukIo955ToEcih+b2p0jbrSygtR1fpLsc=;
        b=BKuigp6t6zYSJq6epjH3Fyq2dG43DX6R6hARA4Ls0+P49Q8qSbImY66ni9vcfpSTzce3so
        hdVLtWv3qPfSDI8bUo3X1hHSNDS7ANumug2WMP1uE48vspkzdVyVPH6p25nmuDijDaGMiO
        p+TXaBcSKG63CAO5VTe2J1+4jK7T5aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669901560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REO845ueyHwukIo955ToEcih+b2p0jbrSygtR1fpLsc=;
        b=iJqJUqp8TV21SEaoFP9VR/Gi4boXcz2DHT6/USjQxObFzt9Ls8i3vjMIjNh2Zk8PLTCKXZ
        FO+4j+uakXy2tZCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 76CA013503;
        Thu,  1 Dec 2022 13:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2pMhD/esiGO5FAAAGKfGzw
        (envelope-from <krisman@suse.de>); Thu, 01 Dec 2022 13:32:39 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huaweicloud.com>,
        <linfeilong@huawei.com>, <liuzhiqiang@huawei.com>
Subject: Re: [PATCH 1/5] sbitmap: don't consume nr for inactive waitqueue to
 avoid lost wakeups
References: <20221201045408.21908-1-shikemeng@huawei.com>
        <20221201045408.21908-2-shikemeng@huawei.com>
Date:   Thu, 01 Dec 2022 10:32:36 -0300
In-Reply-To: <20221201045408.21908-2-shikemeng@huawei.com> (Kemeng Shi's
        message of "Thu, 1 Dec 2022 12:54:04 +0800")
Message-ID: <87y1rrmeq3.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kemeng Shi <shikemeng@huawei.com> writes:

> If we decremented queue without waiters, we should not decremente freed
> bits number "nr", or all "nr" could be consumed in a empty queue and no
> wakeup will be called.
> Currently, for case "wait_cnt > 0", "nr" will not be decremented if we
> decremented queue without watiers and retry is returned to avoid lost
> wakeups. However for case "wait_cnt == 0", "nr" will be decremented
> unconditionally and maybe decremented to zero. Although retry is
> returned by active state of queue, it's not actually executed for "nr"
> is zero.
>

Hi Kemeng,

Fwiw, I sent a patch rewriting this algorithm which is now merged in
axboe/for-next.  It drops the per-waitqueue wait_cnt entirely.  You can
find it here:

https://lore.kernel.org/lkml/20221110153533.go5qs3psm75h27mx@quack3/T/

Thanks!


-- 
Gabriel Krisman Bertazi
