Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE16374A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKXJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKXJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:00:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38E510EA37
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:00:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51F5E218FF;
        Thu, 24 Nov 2022 09:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669280439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rA5/aENVR0bEyMQoBGdlZhbE0LfdmtRdobdrIQ0v1Uc=;
        b=rqTkvg4c1kL0BjXJTshfAM9/+BK6UEAok/LW/2i3kos0fWOfTntEwrTr8sQJVDvIodE1QI
        OiuPtRXXKMNc1YZDKgTpTb6J+DSrRi2XBSF2WAsTHAso+95u2eQU9uhkSRNWu2nfGTg2If
        3VNSieUmjIvikPHaFEHZrdHqW41ZklM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669280439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rA5/aENVR0bEyMQoBGdlZhbE0LfdmtRdobdrIQ0v1Uc=;
        b=lMVHKR7ZEll/NHNQJo2mvK5GvaaWcC67KOJ3HX9Tq7Pmt4nwnWnALo94wghDhCU0SedIwN
        FMhK7hVZoLPEpkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F30A13B4F;
        Thu, 24 Nov 2022 09:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u0SyBrcyf2MJEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Nov 2022 09:00:39 +0000
Message-ID: <1d075dad-d0f3-c4c3-d169-89e7b166ea53@suse.cz>
Date:   Thu, 24 Nov 2022 10:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/12] mm, slub: disable SYSFS support with
 CONFIG_SLUB_TINY
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-4-vbabka@suse.cz>
 <Y37E5Dpu/FLi7wrA@P9FQF9L96D.corp.robot.car>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y37E5Dpu/FLi7wrA@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 02:12, Roman Gushchin wrote:
> On Mon, Nov 21, 2022 at 06:11:53PM +0100, Vlastimil Babka wrote:
>> Currently SLUB enables its sysfs support depending unconditionally on
>> the general CONFIG_SYSFS setting. To reduce the configuration
>> combination space, make CONFIG_SLUB_TINY disable SLUB's sysfs support by
>> reusing the existing SLAB_SUPPORTS_SYSFS define. It is unlikely that
>> real tiny systems would combine CONFIG_SLUB_TINY with CONFIG_SYSFS, but
>> a randconfig might.
> 
> Hm, don't we want to introduce CONFIG_SLAB_SYSFS instead?
> I believe many users don't really need it, even if they don't
> need CONFIG_SLUB_TINY and they do have CONFIG_SYSFS.

Dunno, adding more and more config options is generally frowned upon. Also
tools might be using it to get more details than /proc/slabinfo does - i.e.
tools/vm/slabinfo.c

> Thanks!

