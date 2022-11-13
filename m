Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8D626D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 01:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiKMAnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 19:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKMAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 19:43:50 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820F11172
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:43:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F0100540707;
        Sun, 13 Nov 2022 00:43:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 72F295407D1;
        Sun, 13 Nov 2022 00:43:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668300228; a=rsa-sha256;
        cv=none;
        b=1vfLe76Jt0E2XJM5dfu3avAPDEISBqkcLgQNpcCeEJuPGs36pOe74kxY9Mp5Nnds0Totcp
        MQ+pe/L1nGTstCN9ttmuxcJa9Ro+pcheDfFvHMHQaXTWv4Uo8TQm8yj9VZK81SbAEJVr4a
        RbxuWkO3E4R+4f7U+VDfPOIWUTw9so9s6bCyGo/ToRveg18Er7KtdAAjbPo56GISKJDZ/A
        ya9o3/gbTXz1BvrPZ7Nc4ZSbZuDcsTJyWi2+xl1Riabg0itQUfnPhCXTLb+sdUWfe51Q5C
        xmS0CeS1EzMQmyIyTSyuKwoRrl290UsnFgLZhFelkiMtzRwIt6gZfaBmNY6ONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668300228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=RY4aqpDDzvkCdwtb+i57uYm/67+sdpR3Z3/UKePDnI4=;
        b=YlGyo+Srv7SPsXWZVXNYPtsWGUK9C7KRJ1ffKpgUs6ZZNmPJjH1uTZnIa3JRZdOyrv/r9o
        UKhgG+rQYsODpfhrjaIoA7jrtffsFj1tuzQCAw7T5uQZNMKtrTcu1vHolkjoZrqlowDGyv
        PaZKLltr7OoFp88cA0kwZ3bPlW48S9iY5kiKZj85Q2qbn0uJOUcYO3eEgEQ1TxD1aRUmdr
        wKxTwNDmMh46tq/KjM2/jokL/dfGgAS2rUwhkWmZ5o0I+2BVee3tbghA/mPLUmcGNHr9rO
        CUBfajkghiODC4asv+KmgEPt772WJlXr+PVbKBN3X4LTeRx//r092VdxnBPktA==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-ktmnm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Belong-Interest: 2a9f40c60a2e6cae_1668300228771_2422924357
X-MC-Loop-Signature: 1668300228771:2856677908
X-MC-Ingress-Time: 1668300228771
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.12 (trex/6.7.1);
        Sun, 13 Nov 2022 00:43:48 +0000
Received: from rhino (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4N8twg38CCzP6;
        Sat, 12 Nov 2022 16:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668300228;
        bh=RY4aqpDDzvkCdwtb+i57uYm/67+sdpR3Z3/UKePDnI4=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=vGkMkBlcben9J/SjBmz4dbFddrzFyW2wZlSdUKLZ2JkiNgD5YFKOEjmV/DTt8o0q/
         nzXD7D5UenZxmGSwmFfaJjquVSBRQ4enLTVJd02alBWZrnzFUl77fLiIVU4A4Gq7UF
         2FyK8aZO2fHcFjiTKGpROHw3x1kQ/JazfMKy6jdi2m3msrCWjv2w79bJ1FzJi7jUfL
         GucVOsEFyJcZGYbfAduOJRp9prvetndZNe1OO3dDLb3GFjHR6dRLIq3ig53UhqEJRm
         d5L3c1buIdcwO/G1MWXSc6/6vUEE3RpHy0oErtHvzxF7c3+1yB88qTugI76qj2vZgJ
         jPYqFChVnoF3A==
Date:   Sat, 12 Nov 2022 19:43:45 -0500
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Message-ID: <Y3A9waTkehESUyn+@rhino>
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org>
 <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
> 
> 
> On 11/12/22 13:59, Ian Cowan wrote:
> > On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
> >> Hi--
> >>
> >> On 11/12/22 08:37, Ian Cowan wrote:
> >>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
> >>> the following modpost error for both `kmalloc_trace` and
> >>> `kmalloc_node_trace` on the staging/staging-next branch:
> >>>
> 
> Ian, what do you mean by "on the staging/staging-next branch"?
> 
> What kernel version are you trying to build?
> 
> The .config that you sent is for v6.1.0-rc1.

I am building from the staging repository (gregkh/staging) and my
working branch when building is staging-next. So I am trying to build
from staging and not a particular version. I have also run `make modules_prepare`
and updated the .config per that script. However, when I do build
v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.
