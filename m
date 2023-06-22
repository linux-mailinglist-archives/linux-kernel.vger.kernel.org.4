Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81C73A24C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFVN4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFVN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:56:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DE19BE;
        Thu, 22 Jun 2023 06:56:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19E9122A8E;
        Thu, 22 Jun 2023 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687442165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPaIEngRL3T7x6VRCa5QVWYsxa8/mc85dKX9wqb7yEk=;
        b=isKr+xSXffF+dLyPHf9G4AsOkCRvES8RC2VV0vJMT4mbay+1c6BiM0zPqwSSiqg4NxAsY6
        ZpctKYnHqkGwrrRGz74i0peP0IYGgYAvXjBUcy544q9KDAVTy+Uenf4JcEbnQ4BNL+cmdr
        xIKg2aE3Zc1h+bf11l3Wvdy0yT7EzKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687442165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPaIEngRL3T7x6VRCa5QVWYsxa8/mc85dKX9wqb7yEk=;
        b=Nsdiw7QaG941AWh+1x0X4FGGyDyQx29Cd10FMOX5WO6OcheI0MpDKySlUP5CJGTPKc7gNf
        GjS/cZiAvYv2AwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B29E2132BE;
        Thu, 22 Jun 2023 13:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A/TeKvRSlGSEDwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 22 Jun 2023 13:56:04 +0000
Message-ID: <3fdc76f0-6c45-c405-0024-d1d69b5bf068@suse.cz>
Date:   Thu, 22 Jun 2023 15:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] Randomized slab caches for kmalloc()
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
References: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
 <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230616111843.3677378-2-gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 13:18, GONG, Ruiqi wrote:
> index a3c95338cd3a..6150e9a946a7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -337,6 +337,55 @@ config SLUB_CPU_PARTIAL
>  	  which requires the taking of locks that may cause latency spikes.
>  	  Typically one would choose no for a realtime system.
>  
> +config RANDOM_KMALLOC_CACHES
> +	default n
> +	depends on SLUB
> +	bool "Random slab caches for normal kmalloc"
> +	help
> +	  A hardening feature that creates multiple copies of slab caches for
> +	  normal kmalloc allocation and makes kmalloc randomly pick one based
> +	  on code address, which makes the attackers unable to spray vulnerable
> +	  memory objects on the heap for exploiting memory vulnerabilities.
> +
> +choice
> +	prompt "Number of random slab caches copies"
> +	depends on RANDOM_KMALLOC_CACHES
> +	default RANDOM_KMALLOC_CACHES_16
> +	help
> +	  The number of copies of random slab caches. Bigger value makes the
> +	  potentially vulnerable memory object less likely to collide with
> +	  objects allocated from other subsystems or modules.

When I read this, without further knowledge, why would I select anything
else than the largest value? It should mention memory overhead maybe?

Also would anyone really select only "2" and thus limit the collision
probability to 50% and not less? "4" also seems quite low for the given
purpose? Could we just pick and hardcode 8 or 16 and avoid the selection, at
least until there's some more experience with the whole approach?

