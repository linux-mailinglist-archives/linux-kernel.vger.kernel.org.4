Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091E666EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjALKAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjALKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:00:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A1718E0B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:57:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 127073EEDF;
        Thu, 12 Jan 2023 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673517467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRCSQFW44Cc2tUnJiTmVd65jIs6fvgvwHYQz2Hxv9FI=;
        b=rIRFn+XbYsCB2mJEIE01vsJljj15gvqGKQY2YENMTlKvc4T6VoJxVfgk2rWh9+i/lEG+AH
        gPR0Sw+rmd3r+3uW25EscnTHq++r5W7CdAkkt7oLT14QbB+kbwzERO23IscSV1ApdhAvkL
        C6UvtL3NgKQjVg6gVCFjIRdERAK5GKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673517467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRCSQFW44Cc2tUnJiTmVd65jIs6fvgvwHYQz2Hxv9FI=;
        b=H9MiK/DYWPcH0X7jx3yLDcC91vr29O0UlIwz0egp25ulqsQbHys7RIL5enKiYKZtfc24p3
        ioHhvQPXha3awfDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB8EC13585;
        Thu, 12 Jan 2023 09:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8H/0MJrZv2ORHwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 09:57:46 +0000
Message-ID: <48d8b7df-bc23-ba2b-135d-5d91046769fb@suse.cz>
Date:   Thu, 12 Jan 2023 10:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/5] mm: pagevec: add folio_batch_reinit()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1672043615.git.lstoakes@gmail.com>
 <b75d577d0994229f142bcca8ff330c4c587389dd.1672043615.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b75d577d0994229f142bcca8ff330c4c587389dd.1672043615.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 09:44, Lorenzo Stoakes wrote:
> This performs the same task as pagevec_reinit(), only modifying a folio
> batch rather than a pagevec.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/pagevec.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 215eb6c3bdc9..2a6f61a0c10a 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -103,6 +103,11 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
>  	fbatch->percpu_pvec_drained = false;
>  }
>  
> +static inline void folio_batch_reinit(struct folio_batch *fbatch)
> +{
> +	fbatch->nr = 0;
> +}
> +
>  static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
>  {
>  	return fbatch->nr;

