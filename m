Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AE6E4609
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDQLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:08:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEC10D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:07:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9931F749;
        Mon, 17 Apr 2023 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681729541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06x+K+qEGfBWa+nBU0/XoNWbB2gYx2EZL8IXlmuFUqM=;
        b=COW+9s2VXZkV8/jn1ThdDLAyMwQJ0ocv9VeWZi5xuVChVexb3Qh8ZTBIiPUs0hIbmhzCWZ
        RPhWlsG7+x4MuHb252ImXQHQZPA/pkuTsGIRe//3frw7ptJPEBaNvFEpn7AjP8DrRcJCLY
        qvYWRoVmAzXsQNpqm8H7stf+BBxqDwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681729541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06x+K+qEGfBWa+nBU0/XoNWbB2gYx2EZL8IXlmuFUqM=;
        b=09I3ZDMZvSsWvPtIVWL71LdC5t61NhDSuFrK9CiRWpjWyI/LYDb1vsB+RAmuhPyFZdoALV
        bDh3m348Ja6awAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EFF113319;
        Mon, 17 Apr 2023 11:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TjzHDgUoPWRwGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Apr 2023 11:05:41 +0000
Message-ID: <e2561303-8853-7e16-7eba-001415d34e09@suse.cz>
Date:   Mon, 17 Apr 2023 13:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     willy@infradead.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230415033159.4249-1-sj@kernel.org>
 <20230415033159.4249-3-sj@kernel.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230415033159.4249-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/23 05:31, SeongJae Park wrote:
> The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU

Since "tiny RCU" means something quite specific in the RCU world, it can be
confusing to read it in this sense. We could say e.g. "... snippet uses a
single RCU read-side critical section for retries"?

> read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> similar example code snippet, and commit da82af04352b ("doc: Update and
> wordsmith rculist_nulls.rst") has broken it.

"has broken it" has quite different meaning than "has broken it up" :) I
guess we could just add the "up", unless someone has an even better wording.

> Apply the change to
> SLAB_TYPESAFE_BY_RCU example code snippet, too.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/slab.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b18e56c6f06c..6acf1b7c6551 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -53,16 +53,18 @@
>   * stays valid, the trick to using this is relying on an independent
>   * object validation pass. Something like:
>   *
> + * begin:
>   *  rcu_read_lock();
> - * again:
>   *  obj = lockless_lookup(key);
>   *  if (obj) {
>   *    if (!try_get_ref(obj)) // might fail for free objects
> - *      goto again;
> + *      rcu_read_unlock();
> + *      goto begin;
>   *
>   *    if (obj->key != key) { // not the object we expected
>   *      put_ref(obj);
> - *      goto again;
> + *      rcu_read_unlock();
> + *      goto begin;
>   *    }
>   *  }
>   *  rcu_read_unlock();

