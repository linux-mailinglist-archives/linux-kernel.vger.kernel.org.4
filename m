Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28686800A0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjA2SD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2SD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:03:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150318B00
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:03:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 297071FF79;
        Sun, 29 Jan 2023 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675015435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4N7XfFpKedbQUz8C79ouctf6fb3ifOCQOWuZ7/2i9ik=;
        b=TWu/QjJa/vuYmhJ6uCa9UEZhGgdGLUBMAXE1zHqNKQx3eJWkRwgCPKVeIXSAGU3h6KaUhd
        GxRtmZToHW3akE+Va71Px8f3DXPUwatZZSHsLfTHkYt99ywGkZJX3PDrt1ORm/NjqyXKDD
        5rO+199Spf1tATfkpeCJLm2yY8a1lK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675015435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4N7XfFpKedbQUz8C79ouctf6fb3ifOCQOWuZ7/2i9ik=;
        b=hlzAkxKT0hXn7Hwrjk0+pQL7LPr0mf0fIRrhPDYRv90EOFHmcRyPoj/fJCqZuIWm4U5Rjk
        OOJmbHjV+j6aJGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EF901358A;
        Sun, 29 Jan 2023 18:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cKT0IAq11mMQGQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 29 Jan 2023 18:03:54 +0000
Message-ID: <7ad2cbdc-8589-3aa2-b16a-41336f849f65@suse.cz>
Date:   Sun, 29 Jan 2023 19:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 0/4] Fix excessive CPU usage during compaction
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
 <20230125171159.355a770a2e34f78d7664e1f0@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230125171159.355a770a2e34f78d7664e1f0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 02:11, Andrew Morton wrote:
> On Wed, 25 Jan 2023 13:44:30 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> If we drop Vlastimil's reversion and apply this, the whole series
> should be cc:stable and it isn't really designed for that.
> 
> So I think either
> 
> a) drop Vlastimil's reversion and persuade Mel to send us a minimal
>    version of patch #4 for -stable consumption.  Patches 1-3 of this
>    series come later.
> 
> b) go ahead with Vlastimil's revert for -stable, queue up this
>    series for 6.3-rc1 and redo the original "fix set skip in
>    fast_find_migrateblock" some time in the future.
> 
> If we go with b) then the Fixes: tag in "[PATCH 4/4] mm, compaction:
> Finish pageblocks on complete migration failure" is inappropriate -
> fixing a reverted commit which Vlastimil's revert already fixed.
> 
> I'll plan on b) for now.

Agreed with the plan b). I couldn't review this yet due to being sick,
but I doubt I would have enough confidence to fast-track the series to
6.2 and 6.1-stable. It's subtle enough area and extra time in -next and
full -rc cycle will help.
