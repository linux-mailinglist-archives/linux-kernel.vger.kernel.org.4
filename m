Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E15631CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKUJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiKUJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:28:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC624976;
        Mon, 21 Nov 2022 01:28:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01EB31F37E;
        Mon, 21 Nov 2022 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669022914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Y4IZoLVRj8AR5tjsHCss9N1teSmj9vglLERjZaMD7Q=;
        b=EJiKnqNXde2PecbphzNFPeQZKzd248pytCyissxmjveo7tle57utcAOW/oe0nlWO4jEtCc
        BO3l8hsNfvcWBKqctp7dnofsoYBgcXdGgi6TmmrFr2ePWNcxtt795C4RsJM6WZep9EeMQv
        8wSf3qXbTrLCXeOwx5CY+RnYJ11FaCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669022914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Y4IZoLVRj8AR5tjsHCss9N1teSmj9vglLERjZaMD7Q=;
        b=IwpqJHx8hRMgXiZAtVPlkONVoki455HtEg9cap4PP2aW7TFlYErq0jdY974Mkf59JI7FVm
        VMbq3j1UFverlZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C63ED1377F;
        Mon, 21 Nov 2022 09:28:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HLOfL8FEe2OgbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 09:28:33 +0000
Message-ID: <ba728b58-905a-3154-06a4-a0f38a76f024@suse.cz>
Date:   Mon, 21 Nov 2022 10:28:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] slab: Remove special-casing of const 0 size
 allocations
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221118034713.gonna.754-kees@kernel.org>
 <20221118035200.1269184-2-keescook@chromium.org>
 <f008f8a2-8d5e-88ab-8d23-a2043ea5abe7@suse.cz>
 <202211180906.3030FDDB4@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202211180906.3030FDDB4@keescook>
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

On 11/18/22 18:06, Kees Cook wrote:
> On Fri, Nov 18, 2022 at 12:34:01PM +0100, Vlastimil Babka wrote:
>> On 11/18/22 04:51, Kees Cook wrote:
>> > Passing a constant-0 size allocation into kmalloc() or kmalloc_node()
>> > does not need to be a fast-path operation, so the static return value
>> > can be removed entirely. This is in preparation for making sure that
>> > all paths through the inlines result in a full extern function call,
>> 
>> So with the kmalloc_trace() already solved, we could now say it's not "in
>> preparation", but simply "makes sure", right? I can correct that while
>> picking this patch.
> 
> Yeah, good point. I missed this when updating the commit logs. Thanks!

Great, pushed to slab/for-6.2/alloc_size
