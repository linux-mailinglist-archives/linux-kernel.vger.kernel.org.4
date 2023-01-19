Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2767342C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjASJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjASJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:07:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AE4683C1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 01:07:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 099FB3F7BD;
        Thu, 19 Jan 2023 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674119244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lx+G4gaGNhV68KQmveYTrDwihb7CIXIEx7gck3bp6IQ=;
        b=q+LqR2yCOHNqpVWOIvbansbDL3VSCocmrsGHwL7zBVmSPFJMHmv8CSt4WqfzkBrD21Zbm9
        KgSEbdbfq6BuL7AWtvVzsWaWy4x5wRctXKROBuNxL8YSxmD4u3sjUUSC+22Rwqzzx2tUNS
        LJRo5m9YIUefiZhysTQqmKyZ7zWnKIY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD6B4134F5;
        Thu, 19 Jan 2023 09:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id atXVM0sIyWNNbwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 19 Jan 2023 09:07:23 +0000
Date:   Thu, 19 Jan 2023 10:07:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8kIS+nx2/nBfKei@dhcp22.suse.cz>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
 <Y8gn0KQDWC/5CZ/w@google.com>
 <Y8gt5Gb7DPaEI2uN@dhcp22.suse.cz>
 <Y8g1VWkdSwt5SUVo@google.com>
 <Y8hjNm+kB8WquUH6@dhcp22.suse.cz>
 <Y8hyS3yVnxXTsFIz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hyS3yVnxXTsFIz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 14:27:23, Minchan Kim wrote:
[...]
> Let me know if you have other concern or suggestion.

I would propose to use a tracepoint to track this on the madvise side.
This way you can both track a per-process effectivity as well a madvise
originator effectivity (if the policy is implemented by a global monitor
then it won't get interfering activity by other users of this
interface). Global counters cannot do neither of that.
-- 
Michal Hocko
SUSE Labs
