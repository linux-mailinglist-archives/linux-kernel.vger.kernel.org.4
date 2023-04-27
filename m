Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE986F07A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbjD0OjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0OjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:39:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305340E7;
        Thu, 27 Apr 2023 07:39:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC0611FE4C;
        Thu, 27 Apr 2023 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682606353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCaK1kQTBnKVzZEqwaD7vAZ7IWvkRl+dKm9iAKEVDFI=;
        b=cYFyY+idWuItPkjEMcolMKnRrKN5hEPoZRc2eEE/bPlofPmIQPI1cC751gP6De6adKLs6o
        FgkTN+b1VmccmmgW629pqDEOpxKu+zJinioe2buqHocyPh1xpvQKUR3k+fP1wtOa89obNa
        PnV+EoMCLpRpPAoC5JOjVUcvogVliG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682606353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCaK1kQTBnKVzZEqwaD7vAZ7IWvkRl+dKm9iAKEVDFI=;
        b=ksdxb+7kXsi4bLJ3SCvar5BCQBjnV93jUSmVL1D6/Ox2SZTBKLLjnm4xOq6e/9rBJebXZL
        /x1Oz9hw/pB6VHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F45113910;
        Thu, 27 Apr 2023 14:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G/5LIhGJSmRjIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Apr 2023 14:39:13 +0000
Message-ID: <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz>
Date:   Thu, 27 Apr 2023 16:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
Content-Language: en-US
To:     Greg KH <greg@kroah.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
References: <20230427140959.27655-1-vbabka@suse.cz>
 <2023042719-stratus-pavestone-505e@gregkh>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2023042719-stratus-pavestone-505e@gregkh>
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

On 4/27/23 16:27, Greg KH wrote:
> On Thu, Apr 27, 2023 at 04:09:59PM +0200, Vlastimil Babka wrote:
>> After upgrading build guests to v6.3, rpm started segfaulting for
>> specific packages, which was bisected to commit 0503ea8f5ba7 ("mm/mmap:
>> remove __vma_adjust()"). rpm is doing many mremap() operations with file
>> mappings of its db. The problem is that in vma_merge() case 3 (we merge
>> with the next vma, expanding it downwards) vm_pgoff is not adjusted as
>> it should when vm_start changes. As a result the rpm process most likely
>> sees data from the wrong offset of the file. Fix the vm_pgoff
>> calculation.
>> 
>> For case 8 this is a non-functional change as the resulting vm_pgoff is
>> the same.
>> 
>> Reported-and-bisected-by: Jiri Slaby <jirislaby@kernel.org>
>> Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1210903
>> Fixes: 0503ea8f5ba7 ("mm/mmap: remove __vma_adjust()")
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: <stable@vger.kernel.org>
>> ---
>> Hi, I'm sending this patch on top of v6.3 as I think it should be
>> applied and backported to 6.3-stable rather sooner than later.
>> This means there would be a small conflict when merging mm/mm-stable
>> later. Alternatively it could be added to mm/mm-stable and upcoming 6.4
>> pull request, but then the stable backport would need adjustment.
>> It's up to Linus and Andrew.
> 
> That's not how the stable tree works, sorry, it needs to be in Linus's
> tree _first_.

Sorry, I wasn't clear what I meant here. I didn't intend to bypass that
stable rule that I'm aware of, just that it might be desirable to get this
fix to Linus's tree faster so that stable tree can also take it soon.

> thanks,
> 
> greg k-h

