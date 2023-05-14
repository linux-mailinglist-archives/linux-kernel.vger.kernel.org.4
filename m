Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A3701C9B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjENJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:30:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09011FFE;
        Sun, 14 May 2023 02:30:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CCB521FB9;
        Sun, 14 May 2023 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684056613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHSZYYmiO6JSUTlgPd0JkN7TgOMKpr6vyTG9Hwy+Zzo=;
        b=CTpsMPkbu+KTLlj7qn/aXMfbpi54eshjeH8xcgf1+nadUSMxP28eg4Nfz4wVFba5igv1iR
        WaRTj7xQSoUUFuLYm/3TWx23mqTbPoO0DetltCTar+yIibuMaNXD6HFJtpvr0Y9dm9mcuF
        TEXeOdPmW5AU0h3wj/rR0g3ZBwwENzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684056613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHSZYYmiO6JSUTlgPd0JkN7TgOMKpr6vyTG9Hwy+Zzo=;
        b=SJgsbtU9ve0LLJmy6hXTCPVFmUdu6F9PBYYtaUsOr8qn9AI5+hn5kKcc367zVHMvWUno1I
        gaQf9G4nN6C2OCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B35D8138F5;
        Sun, 14 May 2023 09:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dzHeKiSqYGRbUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 14 May 2023 09:30:12 +0000
Message-ID: <b9331fe4-11c8-5323-e757-5cae3c1e2233@suse.cz>
Date:   Sun, 14 May 2023 11:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Gong Ruiqi <gongruiqi1@huawei.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
 <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 12:11, Gong Ruiqi wrote:
> 
> 
> On 2023/05/11 2:43, Hyeonggon Yoo wrote:
>> On Mon, May 8, 2023 at 12:53 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>>>
> 
> [...]
> 
>>>
>>> The overhead of performance has been tested on a 40-core x86 server by
>>> comparing the results of `perf bench all` between the kernels with and
>>> without this patch based on the latest linux-next kernel, which shows
>>> minor difference. A subset of benchmarks are listed below:
>>>
>>
>> Please Cc maintainers/reviewers of corresponding subsystem in MAINTAINERS file.
> 
> Okay, I've appended maintainers/reviewers of linux-hardening and
> security subsystem to the Cc list.

I think they were CC'd on v1 but didn't respond yet. I thought maybe if
I run into Kees at OSS, I will ask him about it, but didn't happen.

As a slab maintainer I don't mind adding such things if they don't
complicate the code excessively, and have no overhead when configured
out. This one would seem to be acceptable at first glance, although
maybe the CONFIG space is too wide, and the amount of #defines in
slab_common.c is also large (maybe there's a way to make it more
concise, maybe not).

But I don't have enough insight into hardening to decide if it's a
useful mitigation that people would enable, so I'd hope for hardening
folks to advise on that. Similar situation with freelist hardening in
the past, which was even actively pushed by Kees, IIRC.
