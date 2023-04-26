Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496936EF76C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbjDZPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjDZPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:05:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35477696
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:04:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 621041FDD2;
        Wed, 26 Apr 2023 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682521490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ran8tF+5YdxHQWbx/a5kNj8I7fUsKN7ujlcec/eb9Uc=;
        b=gfD6s8wJu7G73s2FAfefxkP92wl2/oRlyHOxoMDqBACvRHxPVXHKVvv2eBnYh+rY+4OmvX
        jAmcRLpVXC40ohDY9gXZdN+5XqeXsaOJngbF4CHeA9cYs6yC/o0/7srhzbEP2xV4q7cttb
        Q4CVDkVvYI2z58pqwc8MPoonyxQnFkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682521490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ran8tF+5YdxHQWbx/a5kNj8I7fUsKN7ujlcec/eb9Uc=;
        b=JZP2tJxjFXOmgTvjg3n8TpZHbTiIIECcpSIqGXfMnK1Wtrv+okh+V8bX93K0g488LXKYLg
        MyU9jbtj3czKC3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3268513421;
        Wed, 26 Apr 2023 15:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5a1qC5I9SWRSdgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Apr 2023 15:04:50 +0000
Message-ID: <44f2df1a-ace4-0c44-166f-4f2fef49e0c1@suse.cz>
Date:   Wed, 26 Apr 2023 17:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad> <ZD/Qq9v0EDxUn7HW@tpad> <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain> <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz> <ZEAYQBJmVwsjpjGY@tpad>
 <ZEFB8FSKWms2VmaL@tpad>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZEFB8FSKWms2VmaL@tpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 15:45, Marcelo Tosatti wrote:
> Perhaps the complexity should be judged for individual cases 
> of interruptions, and if a given interruption-free conversion 
> is seen as too complex, then a "disable feature which makes use of per-CPU
> caches" style solution can be made (and then userspace has to
> explicitly request for that per-CPU feature to be disabled).
> 
> But i don't see that this patchset introduces unmanageable complexity,
> neither: 
> 
> 01b44456a7aa7c3b24fa9db7d1714b208b8ef3d8 mm/page_alloc: replace local_lock with normal spinlock
> 4b23a68f953628eb4e4b7fe1294ebf93d4b8ceee mm/page_alloc: protect PCP lists with a spinlock

Well that one is a bit different, as there was one kind of lock replaced
with other kind of lock, the lock is uncontended unless there's remote
flushes happening so it's not causing extra overhead for the fast paths,
and later even the irq disabling was removed, which should even improve
things. But this patchset is turning all vmstat counter increments a
cmpxchg.

