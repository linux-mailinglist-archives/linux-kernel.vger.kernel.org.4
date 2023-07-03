Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D267461A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGCRyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:54:38 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B961C2;
        Mon,  3 Jul 2023 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=34vRStLGAQoJriIw6NiUXlpXaGnbKbmWEhsgdnuUb54=; b=LylI2GAAfUfDF6CQLs54PrNrVV
        AOq7yg01zxf4vUah81PjIL3PVSLCwGrnVUg7EnSd4EL6ksMoLsbuMqXZ/97BBQOErac8BdrAR7wQZ
        fvodYIvwxJeih7Ov1cO0kavbdz1OuE+PxkgiwBq/e31kBEXA/QQDc5oQHXwT+jnmbs4plVJcJ6XUX
        IDsWnD5mXYdacK2e/O5R+SkNF97LootK939X3dBhKfHMmUWSYV4BqRYykxjQ9jPy8T/JxgfhwXh6c
        SzMDNSfyFQLBUOcbU0QQkYWISUCxjk4YxoUICyWiwKigGodVXLkWDEfCJWbhLfGeVXBkvfB8Bi16q
        N5nbmGow==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qGNku-000By8-Ju; Mon, 03 Jul 2023 19:54:32 +0200
Received: from [178.197.249.52] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qGNku-000QNS-5q; Mon, 03 Jul 2023 19:54:32 +0200
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        catalin.marinas@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
 <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <009e49a8-38f0-04cd-2482-f30b84a9069c@iogearbox.net>
Date:   Mon, 3 Jul 2023 19:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26958/Mon Jul  3 09:29:03 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 7:15 PM, Mark Rutland wrote:
[...]
>> On 6/26/23 10:58 AM, Puranjay Mohan wrote:
>>> BPF programs currently consume a page each on ARM64. For systems with many BPF
>>> programs, this adds significant pressure to instruction TLB. High iTLB pressure
>>> usually causes slow down for the whole system.
>>>
>>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
>>> It packs multiple BPF programs into a single huge page. It is currently only
>>> enabled for the x86_64 BPF JIT.
>>>
>>> This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.
> 
>> If you get a chance to take another look at the v4 changes from Puranjay and
>> in case they look good to you reply with an Ack, that would be great.
> 
> Sure -- this is on my queue of things to look at; it might just take me a few
> days to get the time to give this a proper look.

Awesome, thanks Mark!
