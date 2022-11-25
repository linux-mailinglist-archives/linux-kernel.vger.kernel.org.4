Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D68C6384D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKYHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKYHz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:55:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F31F2D0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:55:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B381E21A59;
        Fri, 25 Nov 2022 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669362956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWHka+bF7lvTsWy8NI8njBiXWBMpqAxPsNHk6MbD580=;
        b=sL5gO+QSy0VXv4iepJpCQn/d10xZcwLL+RxxMOoSVk6bzSzWOlUAUcsYIfiIEa16UhqPJ3
        pzijSpAqUE9xiCHVamfpdwDo2g4QtXXpWfmcsTU9L4iH33bCOOgOAtFYByMEH84QLiKZCf
        ZH7SSjvfSGEsYUt92hy1glkD/rlW8uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669362956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWHka+bF7lvTsWy8NI8njBiXWBMpqAxPsNHk6MbD580=;
        b=GAKnOiBNYiji1m/zJf+MPoFuzBEmKb9CYy4TJXUEic8JZ0M5CNWplL82/CQP1974dHz7bR
        +kwNAbcHRjeFR1CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84EC713A08;
        Fri, 25 Nov 2022 07:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SjG3Hwx1gGNeGAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 25 Nov 2022 07:55:56 +0000
Message-ID: <d70314d3-a274-8b64-3eb3-b8ac08e074da@suse.cz>
Date:   Fri, 25 Nov 2022 08:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/12] mm, slub: add CONFIG_SLUB_TINY
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-3-vbabka@suse.cz> <Y39WeEpboF4u7pP6@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y39WeEpboF4u7pP6@hyeyoo>
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

On 11/24/22 12:33, Hyeonggon Yoo wrote:
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks.

> small comment:
> SLAB || (SLUB && !SLUB_TINY) would be easier to interpret than
> SLAB || SLUB && !SLUB_TINY

OK, will do.

