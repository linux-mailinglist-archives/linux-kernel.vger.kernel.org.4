Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361072C278
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjFLLGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjFLLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:06:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A346461B9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:53:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 594D22019C;
        Mon, 12 Jun 2023 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686567234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTt2k6tHEMrQxlljTt41YxlVh8IjAJSgQbZ59KJPanM=;
        b=yqAuZVZ6Vjc2Smq8sWUAIDdRkMTD/lmH5yRLAzt16FYv1R4utt6cyWelZY66Lg3CEX9Ov7
        9i6LY0Sjy5ryUJEOdaMZURyLnkHxRXxhazFbNQ4Y6tBmfKqV5nbTkXAh/zLnqEatHmjMe4
        Zx+/g0r2DK6TC9XyXc+9+Ot+o6xzN40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686567234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTt2k6tHEMrQxlljTt41YxlVh8IjAJSgQbZ59KJPanM=;
        b=pBIB/2+rilUtHLT3G5tNuJaqwseizOsvgKQJVAX1iEFDdCl+NovJJ6LPiVSBSyBsCGkQmO
        iNUC/s+/1n/kLgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32B10138EC;
        Mon, 12 Jun 2023 10:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JsSrC0L5hmRiNwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 12 Jun 2023 10:53:54 +0000
Message-ID: <a473be7c-a188-f30b-053f-cc0033892547@suse.cz>
Date:   Mon, 12 Jun 2023 12:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>
References: <20230516182537.3139-1-osalvador@suse.de>
 <20230516182537.3139-4-osalvador@suse.de>
 <CAG_fn=UJgnLFGgpkXbMeD6axZN_ifEPHvWpy2_oiPyG1a6PXng@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAG_fn=UJgnLFGgpkXbMeD6axZN_ifEPHvWpy2_oiPyG1a6PXng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 10:40, Alexander Potapenko wrote:
> On Tue, May 16, 2023 at 8:25 PM Oscar Salvador <osalvador@suse.de> wrote:
>> We want to be able to filter out the output on a threshold basis,
>> in this way we can get rid of a lot of noise and focus only on those
>> stacks which have an allegedly high counter.
>>
>> We can control the threshold value by a new file called
>> 'page_owner_threshold', which is 0 by default.
>>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Nack.
> We must decouple stackdepot from page_owner as much as possible, not
> add extra dependencies by sharing variables between the two.
> 
> What you need here is a pair of xxx_iter_start()/xxx_iter_next()
> functions in stackdepot.c that will hold the iteration state in a
> struct and return the next stack trace.
> The threshold value can also be part of that struct.

Agreed, that should be a much cleaner approach.
