Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84A6F3E7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjEBHpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:45:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13E19BE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:45:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F1B11F8AA;
        Tue,  2 May 2023 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683013540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mp2p1cOI63OqchM/aYd5M0KrSgJ0E9fnfdPswaSvyVk=;
        b=mZeUCNLL5WSw5Mw9Gna0+yIl1brHiZkMYIaS3PVcpVxr/sUWHKBWqOqyUhGS8dT4QSXFNx
        t4U+eEN2IszKHcXwn9ajxzKAl5fOglKjjkIeXZthQuTrmev6+ohk18mUMFBemkGjSHBJq6
        8ploAZSEiHbnCx0O8cpUwKEWEScWZBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683013540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mp2p1cOI63OqchM/aYd5M0KrSgJ0E9fnfdPswaSvyVk=;
        b=KpwUJz+U8P4RFXMfSD4hrusKRHsN/4b8K0yeVVrPhPtZR5FIePpWHEdGszvRHZjxC0P5op
        m2qBw0atezlemrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 672ED139C3;
        Tue,  2 May 2023 07:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q3aDGKS/UGQvGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 May 2023 07:45:40 +0000
Message-ID: <c8d21c1e-1bcb-e995-9b58-01ea3320085e@suse.cz>
Date:   Tue, 2 May 2023 09:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: mbind MPOL_INTERLEAVE existing pages
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
References: <20230501185836.GA85110@monkey>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230501185836.GA85110@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/23 20:58, Mike Kravetz wrote:
> I received a question from a customer that was trying to move pages via
> the mbind system call.  In this specific case, the system had two nodes
> and all pages in the range were already present on node 0.  They then
> called mbind with mode MPOL_INTERLEAVE and the MPOL_MF_MOVE_ALL flag.  Their
> expectation was that half the pages in the range would be moved to node 1
> in an interleaved pattern.
> 
> In the above situation, no pages actually get moved.  This is because mbind
> creates a list of pages to be moved via:
> 
> 	ret = queue_pages_range(mm, start, end, nmask,
>                           flags | MPOL_MF_INVERT, &pagelist);
> 
> No page will be added to the list as queue_folio_required is called for each
> page to determine if it resides within the set of nodes.  And, all page are
> within the set.
> 
> I have reread the mbind man page several times and agree that one might
> expect MPOL_INTERLEAVE with MPOL_MF_MOVE_ALL to move pages and create an
> interleaved pattern.  My question is should we:
> - Change mbind so that pages are moved to an interleaved pattern?

I guess it could be worth trying, if there's a use case. And hope nobody
else is depending on the current behavior and will complain afterwards :)

> - Update the documentation to be more explicit?
> 
> I can do either, but just wanted to get opinions before starting.


