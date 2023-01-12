Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F3667006
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjALKoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjALKnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:43:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D91517C7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:38:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A8FF3FC25;
        Thu, 12 Jan 2023 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673519925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiHbfAzoDiwycK23l3fHbtyWHUw9DB1Df3pT+ntfda8=;
        b=e73uzU+bnMqq9LFOQgGpNrgqdhEKQrmaXaUODm8nFeQrUi0xBZA1oXURiJCEjStvc0RwUi
        unweLn6ObU1xePCVHxI3uQelM3jo/9YaESDW02qxuIqCM3S10Crf2mhhsJKjqkMElSHnZB
        C//uMqmhK8vMYsMH6QHEVRKRAzW9e/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673519925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiHbfAzoDiwycK23l3fHbtyWHUw9DB1Df3pT+ntfda8=;
        b=mNHJ2hvqK/CEoOHSOX99Pd7CFVkbLz8ZzUVkHf+yeh7tYJcYVNzsR1uWf93RcnIsgOj3qL
        3pOyxNUWO12mxvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB4AE13776;
        Thu, 12 Jan 2023 10:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vNelODTjv2MMKgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 10:38:44 +0000
Message-ID: <9005c77f-c929-21f7-a735-3ab4e6d89832@suse.cz>
Date:   Thu, 12 Jan 2023 11:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/5] m68k/mm/motorola: specify pmd_page() type
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
 <4b59f47ff4cd89ff76a5b6edbef6e8e0b37046f1.1672043615.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <4b59f47ff4cd89ff76a5b6edbef6e8e0b37046f1.1672043615.git.lstoakes@gmail.com>
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
> Failing to specify a specific type here breaks anything that relies on the type
> being explicitly known, such as page_folio().
> 
> Make explicit the type of null pointer returned here.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  arch/m68k/include/asm/motorola_pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
> index 7ac3d64c6b33..562b54e09850 100644
> --- a/arch/m68k/include/asm/motorola_pgtable.h
> +++ b/arch/m68k/include/asm/motorola_pgtable.h
> @@ -124,7 +124,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
>   * expects pmd_page() to exists, only to then DCE it all. Provide a dummy to
>   * make the compiler happy.
>   */
> -#define pmd_page(pmd)		NULL
> +#define pmd_page(pmd)		((struct page *)NULL)
>  
>  
>  #define pud_none(pud)		(!pud_val(pud))

