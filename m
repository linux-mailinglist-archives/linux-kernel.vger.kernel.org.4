Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE7666EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbjALJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbjALJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:51:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75513D34
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:47:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7B13EEDC;
        Thu, 12 Jan 2023 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673516854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pAskPltJylX3UqT1F2MMIp5X7L1+xETo5b+dITA2HnY=;
        b=TMliVbvNNt16Pm+wuhBgLIyXvWqU/oT64gWYgDqU/73o/7JCNMu746ekxIGudh1m+8C+Xl
        UV7c69CW/L6psE9AqezENsmXXTWrUIKR4yJ3uS8YuoJaedbPvdtVuwhrRoqLE/H5vKUlax
        NVa8KhgMthQ4POLV6JBHkv9b5U90uW0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6109813585;
        Thu, 12 Jan 2023 09:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id puXdFDbXv2PmHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 12 Jan 2023 09:47:34 +0000
Date:   Thu, 12 Jan 2023 10:47:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Message-ID: <Y7/XLPfpZqtsRRMg@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-3-mgorman@techsingularity.net>
 <Y77VYdboKBUsILhD@dhcp22.suse.cz>
 <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-01-23 09:36:23, Mel Gorman wrote:
[...]
> I agree with you but given the risk of bisections hitting this series,
> would you be opposed to delaying the removal by 1 kernel release? That
> way bisections for failures will hit 6.3 and a single commit or at least
> just a report against 6.3. That would mitigate the risk of a full revert
> of the series. I can add a note to the changelog mentioning the expected
> removal so git blame will also highlight it.

Sure. I will post the removal on top of your series and put myself into
the "wait for regression chair".

-- 
Michal Hocko
SUSE Labs
