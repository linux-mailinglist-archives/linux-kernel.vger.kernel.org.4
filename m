Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45B16C44BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCVISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCVISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:18:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC3A5259
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:18:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B462920B2D;
        Wed, 22 Mar 2023 08:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679473078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaCVa54jTiy0sgc0DeIq+Nm9gEuRnN1h71KkgJKmB4E=;
        b=dJo2/XNAugQ+AaQYit0oTk7CuTVIeaxtvGeZTEB6kdq8JaGEYVpMvNaqUqTck9T6OTit1C
        9RUYYtLNzOUByH+AcN1iCnDnsu08jYEn1qZmuVVVhFDMkjrbcy1tQB+6kY/2aGGnMgRMod
        9poTiAg/NgHvbzsi9Zbqht9jl7LlS5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679473078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaCVa54jTiy0sgc0DeIq+Nm9gEuRnN1h71KkgJKmB4E=;
        b=wrJhbWHZK7vewa10Gts4vVrvtEjZ24d1g+UpMC05Gra3buqFZ4mZ0DmOo/Kg2v9rHuIz9C
        ofh4C9Q1FGJ9s1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 916EA138E9;
        Wed, 22 Mar 2023 08:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IDYIra5GmQPNgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 22 Mar 2023 08:17:58 +0000
Message-ID: <55f3b07b-13dd-f7a1-8d3a-bc79ae1b4f50@suse.cz>
Date:   Wed, 22 Mar 2023 09:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/4] mm/mmap/vma_merge: further improve prev/next VMA
 naming
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
References: <cover.1679468982.git.lstoakes@gmail.com>
 <f4474a419648fbbef13b29ce00880054da085788.1679468982.git.lstoakes@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f4474a419648fbbef13b29ce00880054da085788.1679468982.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 08:13, Lorenzo Stoakes wrote:
> Previously the ASCII diagram above vma_merge() and the accompanying
> variable naming was rather confusing, however recent efforts by Liam
> Howlett and Vlastimil Babka have significantly improved matters.
> 
> This patch goes a little further - replacing 'X' with 'N', which feels more
> natural as this represents the _next_ VMA and replacing what was 'N' with
> 'C' which represents the current VMA.

Might have wanted to mention the 'A' to '*' change as well?

> No word quite describes a VMA that has coincident start as the input span,
> however 'concurrent' (or more simply 'current') abbreviated to 'curr' fits
> intuitions well alongside prev and next.

'curr' sounds good to me, I concur

> This has no functional impact.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/mmap.c | 86 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 042d22e63528..c9834364ac98 100644

