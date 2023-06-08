Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F9727B07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjFHJSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjFHJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:18:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5918F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:18:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE61921A16;
        Thu,  8 Jun 2023 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686215882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sq4jU/k60jCVqjA4NKdWPht6bOFZJdg9eSAA9JH9D08=;
        b=WE72ZnGf7+kpC2HvEMTxu2ZJfE7PGl7iLN4T4mqtpy+KHCCrXMLvisvtuPdYf7zDGFcO+r
        yj4BAm5v/9BdILYpN00MAHS+gAgLe6dh86XxAFFelzaXFUxFB6LMzonmAiWNAHtkLAboKY
        XqfMsvEyrFmHTHE6wYUsE46lnKk5pKI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C323113480;
        Thu,  8 Jun 2023 09:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yuNTLcqcgWTRaQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 08 Jun 2023 09:18:02 +0000
Date:   Thu, 8 Jun 2023 11:18:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
Message-ID: <ZIGcyku+DN5IHtwp@dhcp22.suse.cz>
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
 <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
 <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
 <34f32148-24c3-09a3-8bec-9515139e15b1@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f32148-24c3-09a3-8bec-9515139e15b1@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-06-23 15:38:48, Haifeng Xu wrote:
> 
> 
> On 2023/6/7 18:22, David Hildenbrand wrote:
> > On 07.06.23 12:16, Michal Hocko wrote:
> >> On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
> >>> If freesize is less than dma_reserve, print warning message to report
> >>> this case.
> >>
> >> Why?
> > 
> > I'd like to second that question, and add
> > 
> > a) Did you run into that scenario?
> > b) What can an admin do in that case with that error messages?
> 
> In theory，dma_reserve shouldn't exceed freesize, so the error messages can remind us
> to verify whether the configuration of reserved memory is correct.

I am not really convinced this is worth touching the code TBH.

-- 
Michal Hocko
SUSE Labs
