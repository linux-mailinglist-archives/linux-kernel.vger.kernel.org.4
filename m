Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB16B7D56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCMQV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCMQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:21:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9806F49A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:21:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC85F1FE14;
        Mon, 13 Mar 2023 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678724508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=957lCchpL8BUZawVrhn7/dgEeyT0pbaGfoRJtdtut3E=;
        b=O/lj4ScZ6vYmUOtjfzEAfraHQoD09YkGYAw7PBU82SBNDqoexj2W1AxFC2bp85HuWnDE/p
        658mRBaeRKa5vGHeoNO1ssbqRFxpckFIRGeoMYPWSiK1G5uhbkWdiq/c2El/qbqIQu0AAW
        VXqtATlf/gYYvF7P/DS1+beYVdc/6rY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678724508;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=957lCchpL8BUZawVrhn7/dgEeyT0pbaGfoRJtdtut3E=;
        b=b6G5YtOZXimkCUIH/JqU0PgV2013nyqYiVWKEEXEyFSbeIYS2yCf6MfNP/iI5Dj0FxzozR
        z95LDIkB8hfnCbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4AB113517;
        Mon, 13 Mar 2023 16:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W1I9L5xND2SVDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Mar 2023 16:21:48 +0000
Message-ID: <34d76760-d24c-0e34-b8c4-d4f5fdc342b7@suse.cz>
Date:   Mon, 13 Mar 2023 17:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: slub: make kobj_type structure constant
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230220-kobj_type-mm-slub-v1-1-5ae49b96d9aa@weissschuh.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230220-kobj_type-mm-slub-v1-1-5ae49b96d9aa@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 00:25, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks, added to slab/for-6.4/trivial

> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 13459c69095a..be710dc4dc3e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6058,7 +6058,7 @@ static const struct sysfs_ops slab_sysfs_ops = {
>  	.store = slab_attr_store,
>  };
>  
> -static struct kobj_type slab_ktype = {
> +static const struct kobj_type slab_ktype = {
>  	.sysfs_ops = &slab_sysfs_ops,
>  	.release = kmem_cache_release,
>  };
> 
> ---
> base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
> change-id: 20230220-kobj_type-mm-slub-02d25836de84
> 
> Best regards,

