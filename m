Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959FF6DF2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDLLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjDLLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:16:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED183FA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:16:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 282F11F893;
        Wed, 12 Apr 2023 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681298104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xWf3qbvw15Y48ZKzuDRGBdbN9kZo9jg9YFpiuDLBuY=;
        b=dzSHglQHENg8RbSVh6dt9cLLlGy3QQfvVVudJ3J4i/jQyLwctJOqT9o+uot89k4Sa49M/C
        TaWGjQfMEnN6gtJi49pnWb3IItLbnWIVBnfy9RMA143I57R/VLORkLkTlGWpZxMSeu/+ce
        PCX6TdbJIrEyfNMMHpmoF8hseDdmRcg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AA6C13498;
        Wed, 12 Apr 2023 11:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1abGOreSNmRQMQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 12 Apr 2023 11:15:03 +0000
Date:   Wed, 12 Apr 2023 13:15:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
Message-ID: <ZDaSt8gW7kjfYGx5@dhcp22.suse.cz>
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 18:45:31, Baolin Wang wrote:
> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
> which checks whether the given zone contains holes, and uses pfn_valid()
> to check if the end pfn is valid. However pfn_valid() can not make sure
> the end pfn is not a hole if the size of a pageblock is larger than the
> size of a sub-mem_section, since the struct page getting by pfn_to_page()
> may represent a hole or an unusable page frame, which may cause incorrect
> zone contiguous is set.
> 
> Though another user of pageblock_pfn_to_page() in compaction seems work
> well now, it is better to avoid scanning or touching these offline pfns.
> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
> populated to have holes"), we should also use pfn_to_online_page() for
> the end pfn to make sure it is a valid pfn with usable page frame.
> Meanwhile the pfn_valid() for end pfn can be dropped now.
> 
> Moreover we've already used pfn_to_online_page() for start pfn to make
> sure it is online and valid, so the pfn_valid() for the start pfn is
> unnecessary, drop it.

Is this a theoretical problem or something you have encountered on a
real machine? Could you provide more details please?

-- 
Michal Hocko
SUSE Labs
