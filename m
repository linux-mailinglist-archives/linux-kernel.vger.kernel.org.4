Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68965BDAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiITD3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiITD26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:28:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5E5722B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:28:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4D11F85D;
        Tue, 20 Sep 2022 03:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663644531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJV8FwE+A5Dc4HYylZheQIWHRM8TrBG9/FpxnqYq3FU=;
        b=xwYkmWZcNtVN1aC1yMG5mIj7jRaK0NZgsF3FKII1oohRt1GgHZmG0+QaqVZjSnItFf5t3E
        DP1eerzJ91hvVfgBtEoezk7r6G0LEl20/JEmWcffvxEPA4zQax/9d25Vwu5X281AjM37x2
        FvHwS2c3FTBjWRnT8UHBwjMiJ/DIut8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663644531;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJV8FwE+A5Dc4HYylZheQIWHRM8TrBG9/FpxnqYq3FU=;
        b=C3TfYTIkGu0Z5CmOYMg+fBQ5E6o6j3kYGT0r5SSs/79n03UppkhfK4czp44lBP/hJvddi5
        ZmbvbBFCCud//aAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0358B13ABD;
        Tue, 20 Sep 2022 03:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1vWfOXIzKWOidAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 20 Sep 2022 03:28:50 +0000
Date:   Tue, 20 Sep 2022 05:28:49 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/hugetlb: add available_huge_pages() func
Message-ID: <YykzcQqYig4wyyM+@localhost.localdomain>
References: <20220917011528.11331-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917011528.11331-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 09:15:28AM +0800, Xin Hao wrote:
> In hugetlb.c file, there are several places to compare the values of
> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
> there add a new available_huge_pages() func to do these.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
