Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64E621154
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiKHMr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiKHMr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:47:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1252891
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:47:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2E3911F88D;
        Tue,  8 Nov 2022 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667911674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J124qO1Z9y6DzHbvakiNCQhSpW1cqMUfl1QPHuvbt2U=;
        b=r3HTL/vjpwM9jB75W0UF8rnnuQsQprAxiWFueVsQCSUtZ44uwXWIru7zNWdMLxrOqovXYQ
        viqos2Es+rKWjJ0Omasox4CUr5G9QZ5i8KvUhXDzY1zclHeAm/9o4mJ2c6O6kWfs7hPgAC
        DHrDK9k33BIl2SqIUi6/TgkkKs7ANR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667911674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J124qO1Z9y6DzHbvakiNCQhSpW1cqMUfl1QPHuvbt2U=;
        b=z9+z/v40XHfv+V1NDIh+6O/xq4eB4FlowkcTGrmkcQq7qGQsGcOymKJ76tgqghzVh5gDSP
        uokMDUgHuRh5kOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 131D713398;
        Tue,  8 Nov 2022 12:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GYOUA/pPamOragAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 08 Nov 2022 12:47:54 +0000
Message-ID: <eb620736-9078-6c87-1fde-3132ec8739f8@suse.cz>
Date:   Tue, 8 Nov 2022 13:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mm: fix compiler warning with make W=1
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <1667884582-2465-1-git-send-email-quic_charante@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1667884582-2465-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 06:16, Charan Teja Kalla wrote:
> Fix the below compiler warnings reported with 'make W=1 mm/'.
> mm/page_ext.c:178: warning: Function parameter or member 'page_ext' not
> described in 'page_ext_put'.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>

Reported-and-tested-by: Vlastimil Babka <vbabka@suse.cz>

> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Thanks!

> ---
>   mm/page_ext.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index affe8024..ddf1968 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -166,7 +166,7 @@ struct page_ext *page_ext_get(struct page *page)
>   
>   /**
>    * page_ext_put() - Working with page extended information is done.
> - * @page_ext - Page extended information received from page_ext_get().
> + * @page_ext: Page extended information received from page_ext_get().
>    *
>    * The page extended information of the page may not be valid after this
>    * function is called.

