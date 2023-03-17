Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBA6BE8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCQMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:06:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63DABDE0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:06:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 560221FDDC;
        Fri, 17 Mar 2023 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679054765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6PwRF5jGpu+1tTOnVCWhJum42ZPWZ4cZsnTSiet66Cg=;
        b=dYGfpPT4WMSMZebdPdvo6iCoQzY6ypQEBvdLq+yorweDRLz4kKw6uL7WdsEPFrfIvYh28g
        GKWGBYdfnT7ep0xomHURF3vrTDA3eKOJNHr326rUrgcBqvMRFQDv4DtV6zZi9gkqRuM7Qv
        9t8FOuGDHc3Xm772eAnOz0+Zsb5htWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679054765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6PwRF5jGpu+1tTOnVCWhJum42ZPWZ4cZsnTSiet66Cg=;
        b=icpHnZpVJ7K61r5lnh3SyemtNwYEgTi+INIeQe+/M54feUZk+07i4WD6Z+cIYT+2mj4YiE
        FcF4tv2oH+yZqnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC091346F;
        Fri, 17 Mar 2023 12:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VXo3Cq1XFGSBKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Mar 2023 12:06:05 +0000
Message-ID: <8c700468-245d-72e9-99e7-b99d4547e6d8@suse.cz>
Date:   Fri, 17 Mar 2023 13:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Content-Language: en-US
To:     "chenjun (AM)" <chenjun102@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
 <344c7521d72e4107b451c19b329e9864@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <344c7521d72e4107b451c19b329e9864@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 12:32, chenjun (AM) wrote:
> 在 2023/3/14 22:41, Vlastimil Babka 写道:
>>>   	pc.flags = gfpflags;
>>> +
>>> +	/*
>>> +	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
>>> +	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
>>> +	 * 2) if 1) failed, try to allocate a new slab from target node with
>>> +	 *    __GFP_THISNODE.
>>> +	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
>>> +	 */
>>> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
>>> +			pc.flags |= __GFP_THISNODE;
>> 
>> Hmm I'm thinking we should also perhaps remove direct reclaim possibilities
>> from the attempt 2). In your qemu test it should make no difference, as it
>> fills everything with kernel memory that is not reclaimable. But in practice
>> the target node might be filled with user memory, and I think it's better to
>> quickly allocate on a different node than spend time in direct reclaim. So
>> the following should work I think?
>> 
>> pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE
>> 
> 
> Hmm, Should it be that:
> 
> pc.flags |= GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE

No, we need to ignore the other reclaim-related flags that the caller
passed, or it wouldn't work as intended.
The danger is that we ignore some flag that would be necessary to pass, but
I don't think there's any?

