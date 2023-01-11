Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB749665D62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbjAKOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjAKOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:12:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8EFA46F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:12:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 423F517B86;
        Wed, 11 Jan 2023 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673446367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE6y7iidhdQwZd82DKF1P74kvAoThMrkO4ILYhJI85s=;
        b=otU9jeW47puvDnW4VE5snuBapCRXMvnaWEww5kef6FKrMlu2Z6ox/CAMABuoCgTnnhIgSI
        nRjuOfv7axEJcBvgWII/TE/0KKy7x4Fy+6Qv08KRp2Nbfe5/Fs+Dbed8Q7m9ockc2Rt4SO
        XgFLAdgFZoUhqOdSZUqq2zPJXCb7/f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673446367;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE6y7iidhdQwZd82DKF1P74kvAoThMrkO4ILYhJI85s=;
        b=hIayZIEXLvp9eLqg376vCZivzXzrAubGfO9PbSoe6BDh8w+wbgZx8nHfwDk0II+EAb1Fxt
        f1rkRXcnIfLw3ODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F0AB1358A;
        Wed, 11 Jan 2023 14:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XtSJBt/DvmPwBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 11 Jan 2023 14:12:47 +0000
Message-ID: <2e6d0187-bbef-7db1-a2a6-7beae715a17c@suse.cz>
Date:   Wed, 11 Jan 2023 15:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/7] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230109151631.24923-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 16:16, Mel Gorman wrote:
> Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> other non-blocking allocation requests equal access to reserve.  Rename
> ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> means.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

