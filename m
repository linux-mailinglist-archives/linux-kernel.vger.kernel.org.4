Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E8274D95D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGJO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:56:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B2BC;
        Mon, 10 Jul 2023 07:56:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DAAAC20017;
        Mon, 10 Jul 2023 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689000972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEWPxet4qAxkuP2PISZ4OxOUGsMXMwH0HmtQelzmn/I=;
        b=vrFscLPcbV+pCGt7cy5jLUauEcIMd8Tz1h3WyDhgEdQP4x9ZCe8Bsff2mz0LpKkVaJM0YT
        VrO+9jMWG7zxy6+H7xGf6tRljrmt5DM6YFVg/yQHvsZYVN5dE/2oS56CN4D91gGg7GBDDy
        Pc1+0F7Ts5KteRWMfqZsBMnXjbKczq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689000972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEWPxet4qAxkuP2PISZ4OxOUGsMXMwH0HmtQelzmn/I=;
        b=kyZ5vWKkb9PL24I3b9vh1LeDNlDS5YxA5GvcXknfWLihpQcz59oe8EBCEOjvmhuxz5b8t+
        Lzf/DwJBQq7Bt3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F3BA13A05;
        Mon, 10 Jul 2023 14:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FT0+JgwcrGSQUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 10 Jul 2023 14:56:12 +0000
Message-ID: <598673f2-66e0-dc9c-4469-e0680685d81c@suse.cz>
Date:   Mon, 10 Jul 2023 16:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        Julian Pidancet <julian.pidancet@oracle.com>
Cc:     Christoph Lameter <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
References: <20230629221910.359711-1-julian.pidancet@oracle.com>
 <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
 <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
 <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
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

On 7/3/23 22:17, David Rientjes wrote:
> Additionally, I wouldn't consider this to be super urgent: slab cache 
> merging has been this way for several years, we have some time to do an 
> assessment of the implications of changing an important aspect of kernel 
> memory allocation that will affect everybody.

Agreed, although I wouldn't say "affect everybody" because the changed
upstream default may not automatically translate to what distros will use,
and I'd expect most people rely on distro kernels.

> I agree with the patch if 
> we can make it work, I'd just like to study the effect of it more fully 
> beyond some kernbench runs.

