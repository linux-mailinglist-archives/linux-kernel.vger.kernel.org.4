Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FDC6F4090
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjEBKAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEBKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:00:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FDF9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:00:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 639BD1F8BE;
        Tue,  2 May 2023 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683021648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQGFmprAkf6SOGmZcALNchoLIXzx1I6PSxS66a6jet8=;
        b=xQ6JaecBwap2jvpIJ31SWlM85SFeS5pVbSmJrTo8OcH8F+BJl7Bn+3GZHGG4pRq3YgMFK7
        UTSSsOlEhV5ox5haOFuEl/z9ln+zEQ49zYyjI0uz11RCqGbHwtULOI+FNLc+VdR6ZC9bTg
        /5k3CGJ3kuqBHRJ+CFo/uavxNGinkOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683021648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQGFmprAkf6SOGmZcALNchoLIXzx1I6PSxS66a6jet8=;
        b=FquHuOLlZRQgEkHms/NYY7NkRXmeTQlbefmtFXMHofFnlEWcLdee1WSLeDp4v9FRmyYbwh
        GUYS/XhGVKDhFeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4681C139C3;
        Tue,  2 May 2023 10:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fqmEEFDfUGTlZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 May 2023 10:00:48 +0000
Message-ID: <a0182cf5-5d1d-8a3d-2cf7-8862a70edd11@suse.cz>
Date:   Tue, 2 May 2023 12:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/1] mm: change per-VMA lock statistics to be disabled by
 default
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230428173533.18158-1-surenb@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230428173533.18158-1-surenb@google.com>
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

On 4/28/23 19:35, Suren Baghdasaryan wrote:
> Change CONFIG_PER_VMA_LOCK_STATS to be disabled by default, as most
> users don't need it. Add configuration help to clarify its usage.
> 
> Fixes: 52f238653e45 ("mm: introduce per-VMA lock statistics")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/Kconfig.debug | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 6dae63b46368..a925415b4d10 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -274,6 +274,12 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
>  config PER_VMA_LOCK_STATS
>  	bool "Statistics for per-vma locks"
>  	depends on PER_VMA_LOCK
> -	default y
>  	help
> -	  Statistics for per-vma locks.
> +	  Say Y here to enable success, retry and failure counters of page
> +	  faults handled under protection of per-vma locks. When enabled, the
> +	  counters are exposed in /proc/vmstat. This information is useful for
> +	  kernel developers to evaluate effectiveness of per-vma locks and to
> +	  identify pathological cases. Counting these events introduces a small
> +	  overhead in the page fault path.
> +
> +	  If in doubt, say N.

