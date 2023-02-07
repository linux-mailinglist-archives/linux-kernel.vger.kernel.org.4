Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC21068DE43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjBGQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBGQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:53:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7A46B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:53:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 773315FC7D;
        Tue,  7 Feb 2023 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675788819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5NcPOkp+Z/yhDkVYRJmYm46jPzt9w/1RGRXgbqCnuU=;
        b=BK2YGvpSLBwmZzbch5ZCxUOEYppRqJ9dQ8+rw/fEJVf/kkhrhG/vpB+5/adyHM4JgLJZ+B
        Am1HopSsvMc0DBHhOLoE6c+fUwZ8nYL4JfdXY/cljBoDNuk18Vl9avof/4w1+mbuZvb71E
        ye/lbay9Egv+iQobr6r08ArQ3WbtihQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675788819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5NcPOkp+Z/yhDkVYRJmYm46jPzt9w/1RGRXgbqCnuU=;
        b=7m9w95nelbKVOVN+1duhSn66FRAtgHTzBZfQx2jwnnZ/+welNcqzfBVs2fX6aLzzNlKo3J
        looNWePRzqiJLYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A32313467;
        Tue,  7 Feb 2023 16:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gZyKEROC4mOTTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Feb 2023 16:53:39 +0000
Message-ID: <7962d171-fc29-88db-ee33-4326838d7b40@suse.cz>
Date:   Tue, 7 Feb 2023 17:53:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] mm, compaction: Check if a page has been captured
 before draining PCP pages
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230125134434.18017-1-mgorman@techsingularity.net>
 <20230125134434.18017-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230125134434.18017-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 14:44, Mel Gorman wrote:
> If a page has been captured then draining is unnecssary so check first
> for a captured page.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/compaction.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c018b0e65720..28711a21a8a2 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2441,6 +2441,12 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  			}
>  		}
>  
> +		/* Stop if a page has been captured */
> +		if (capc && capc->page) {
> +			ret = COMPACT_SUCCESS;
> +			break;
> +		}
> +
>  check_drain:
>  		/*
>  		 * Has the migration scanner moved away from the previous
> @@ -2459,12 +2465,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  				last_migrated_pfn = 0;
>  			}
>  		}
> -
> -		/* Stop if a page has been captured */
> -		if (capc && capc->page) {
> -			ret = COMPACT_SUCCESS;
> -			break;
> -		}
>  	}
>  
>  out:

