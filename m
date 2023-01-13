Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB366695B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjAMLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbjAMLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:33:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F25FA5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:20:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8A105FD96;
        Fri, 13 Jan 2023 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673608852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWMF6ZUA5DiNQ+vW0F4WrqZDdOO5RKO0kvQA67ItQAw=;
        b=r4RgcOgN/mqUdk13Kd/S8GP37pZxZHssQLb+S4uLnF/4Zelqq5Xelquxyb2XjEio/XgXxN
        NEe3yzaWge+PZn6op6GzCT0JMY2j2HsyGn12w0GDxGD7Zc3HNWk5POvmv6zN8JhXK+nXZn
        WwlrCAWzfUoi4yRAduWYg4+spHMZt0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673608852;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWMF6ZUA5DiNQ+vW0F4WrqZDdOO5RKO0kvQA67ItQAw=;
        b=7ND6idC7sKObrIb3mHffYA9ENTIQGYtr00oCiPDC5ibUzvtQabv/oelwXoZ72EJe5xo+D+
        Mpi6PUECRNjSR6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1CD11358A;
        Fri, 13 Jan 2023 11:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pbW9KpQ+wWNtMAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 13 Jan 2023 11:20:52 +0000
Message-ID: <2d656d51-a0ce-88bc-529e-e254defdc421@suse.cz>
Date:   Fri, 13 Jan 2023 12:20:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] mm/slab.c: Delete the if statement
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>, lvqian <lvqian@nfschina.com>
Cc:     cl@linux.co, penberg@kernel.org, kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230111092744.112038-1-lvqian@nfschina.com>
 <1848b8d7-f40e-1851-b2b1-68c3df8f0bb7@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1848b8d7-f40e-1851-b2b1-68c3df8f0bb7@google.com>
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

On 1/13/23 00:53, David Rientjes wrote:
> On Wed, 11 Jan 2023, lvqian@nfschina.com wrote:
> 
>> From: lvqian <lvqian@nfschina.com>
>> 
>> 	Remove the if statement to increase code readability.
>> 
>> Signed-off-by: lvqian <lvqian@nfschina.com>
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
> Will rely on Vlastimil to remove the spurious tab in the commit 
> description.

Right, also changed subject to:
mm/slab.c: cleanup is_debug_pagealloc_cache()

Function could be inline, but no strong preference.

Good point, did that too.

Added to
slab/for-6.3/cleanups

Thanks.
