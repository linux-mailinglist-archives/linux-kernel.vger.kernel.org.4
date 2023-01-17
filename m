Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A124266DE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbjAQM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjAQM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:59:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31BC3866D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:57:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7E91686FC;
        Tue, 17 Jan 2023 12:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673960257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBch0VSHbnKV/Owivc/UbreapD9Gr0DL7X9SM2fZmV8=;
        b=PA8tgO4QYccksGRomyTaYrbBa0zFWnx89nvqGWGBDCAn1lstn+/HgOtSbXXI8I2b8OiPTO
        xl3GSKWHrUFrp7DB9FC3LuRYIxn5q45+0r+YrCkM1FqfVshdCqj9f6QnGs8WUXds5s4pYS
        b7SQlC4GqyX6TumYgZ3MNIMK+6gSa9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673960257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBch0VSHbnKV/Owivc/UbreapD9Gr0DL7X9SM2fZmV8=;
        b=J5wLNuMfVyIw05+gCOS0e/gwxRQU+Ta1WrfLpzwx15Vuw2prmORLuGKnepuyOxQ2nLDUhb
        5N42//+Pq3jIouDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E60C1390C;
        Tue, 17 Jan 2023 12:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9qyHHUGbxmOIcwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Jan 2023 12:57:37 +0000
Message-ID: <ae5ccd01-f43f-1228-414b-48491e477768@suse.cz>
Date:   Tue, 17 Jan 2023 13:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mm: Functions used internally should not be put into
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, 42.hyeyoo@gmail.com
Cc:     akpm@linux-foundation.org, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        rongtao@cestc.cn, sdf@google.com, yhs@fb.com
References: <Y8U8OfoVwkJPdJcv@localhost>
 <tencent_6238B3302FB554EC5EEF475F11470C048509@qq.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <tencent_6238B3302FB554EC5EEF475F11470C048509@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 03:01, Rong Tao wrote:
> Hi, dear Hyeonggon.
> 
> If sl*b_def.h is not intended to be used externally. That is to say we should
> never include sl*b_def.h in module? The following code will not compile success
> since commit 40f3bf0cb04c("mm: Convert struct page to struct slab in functions
> used by other subsystems"), but success in older kernel. Especially for modules
> that use the kmem_cache structure, this is catastrophic.

If such module was part of the Linux tree, breaking it would be noticed 
sooner and fixed, probably by changing the include to "mm/slab.h" 
instead of sl*b_def

...

> You are right, if sl*b_def.h is not intended to used externally, Modules that
> use kmem_cache structures should not be designed from the outset to use
> kmem_cache structures. Or the kernel can use this patch, and these modules can
> be compiled successfully.

For out of tree modules we can't make any guarantees. It's best for 
those if they don't rely on such specifics. As Hyeonggon pointed out, 
there are more robust ways to get object layout than including kernel 
headers. Also it was broken since 5.17, which is quite some time ago. Is 
the code you're fixing still relevant or was replaced with something 
based on BTF already?

> Best wishes.
> 
> Rong Tao

