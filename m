Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A906CFA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjC3Eqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC3Eqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF91995
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680151560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC32CzxNEi0UHq3EF126Vl3LWEH+Ja2D8JcygdUTSF0=;
        b=f/sBIb+1Qynf/Y6AZUPhzuQxQFl0CywkbD52qZVhaN704TIjNDrQ6D8jVWgcp9tQkNvZXv
        oGkLpa7rEu4e0YqbOCSMqJZkFzYC6mDyD8rR9/mtX1k4Au3XRuWdH1+vLWdNWtisy5tMo3
        YH+CkZruuHX1e32Ysdbrl44zqa3jEsI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-JLPSz0MLPUq4hyvKJU5Q6A-1; Thu, 30 Mar 2023 00:42:16 -0400
X-MC-Unique: JLPSz0MLPUq4hyvKJU5Q6A-1
Received: by mail-pf1-f197.google.com with SMTP id d4-20020a056a00198400b00628000145bcso8182456pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680151335;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC32CzxNEi0UHq3EF126Vl3LWEH+Ja2D8JcygdUTSF0=;
        b=gHtxFuENAj2K9Z2xAT/Xk7uUoqRiua43LH0WxYA9qsfS44MQxlz6ysdQDldu5NNocg
         DN5WWzvTDf2Y3ubzh0bkem8FYYJ2PxAExxVRGoIUf1b+7WGozCd3UES/hhcsnWqgP0dd
         AlSVGCDuer1bnP5Ul3XunE4jiqiPkZVn4T8ZHVj0p90Yg0xiG7RWmtAicz/Zx5Iqngwm
         8FNepUvF13lYkQuLqWSaVeyuF/PX0lcJyljhvPgtEnlpnggxxPn/gILXmA0JBNZ6hdNz
         C5K3DmKFNt8ObqgKH6DZk8IfQDzxp9HAdu0VQ6kU3lBZa5KioAfDJtnvGfapko8eRTtT
         KzHA==
X-Gm-Message-State: AAQBX9ciJD47tEQcVh4pMSXg0DkcIega0Q7uTboHI00k8rMIzUqAYWf+
        1fUgzOzXgNNb+cH+GvEVlG1T7v9T5MFf8lZGdsxpd7pvZGAYXOisDRvAEogzoQ0fF2G+H9r9HqN
        zjCWRPVHY8kSCr5wfCr8vfsyT
X-Received: by 2002:aa7:9f82:0:b0:626:658:c998 with SMTP id z2-20020aa79f82000000b006260658c998mr19255221pfr.10.1680151335582;
        Wed, 29 Mar 2023 21:42:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZbaXZJAxR6+SahDxpVIV0UnbkptaPuaQZqyLAa7ksLapMGp18XFWxKyQYYcjHE5Vmnrjnzsg==
X-Received: by 2002:aa7:9f82:0:b0:626:658:c998 with SMTP id z2-20020aa79f82000000b006260658c998mr19255189pfr.10.1680151335148;
        Wed, 29 Mar 2023 21:42:15 -0700 (PDT)
Received: from [192.168.35.160] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id x5-20020aa784c5000000b006262520ac59sm23591164pfn.127.2023.03.29.21.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 21:42:14 -0700 (PDT)
Message-ID: <4fa825ac-707d-ad38-0af7-937a2c1e75b7@redhat.com>
Date:   Thu, 30 Mar 2023 06:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
References: <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <e5c2183a-f62a-6ca9-eec6-a7fab7ce4c91@redhat.com>
 <ZCKGI1LxktS7pKS9@bombadil.infradead.org>
 <5aceccdf-d268-7872-abb5-c14e9aa8b7b7@redhat.com>
 <ZCPNONX3O3bp2Om1@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
In-Reply-To: <ZCPNONX3O3bp2Om1@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.23 07:31, Luis Chamberlain wrote:
> On Tue, Mar 28, 2023 at 11:02:49PM +0200, David Hildenbrand wrote:
>>
>> So we're a bit faster (0.2 -- 0.7s) than the original version without the
>> rcu patch (~6s).
> 
> Groovy.

Just to clarify, it was up to 0.7s faster (I phrased it in a confusing way).

> 
>>> The commit log needs updateing to reflect the results I just collected:
>>>
>>> With the alloc patch ("module: avoid allocation if module is already
>>> present and ready") I see 145 MiB in memory difference in comparison
>>> to its last patch, "module: extract patient module check into helper".
>>> So I think that's a clear keeper and should help large CPU count boots.
>>>
>>> The patch "module: add concurrency limiter" which puts the concurency
>>> delimiter on the kread only saves about 2 MiB with 100 stress-ng ops,
>>> which seems to be what I needed to reproduce your 400 CPU count original
>>> issue.
>>>
>>> The program used to reproduce is stress-ng with the new module option:
>>>
>>> echo 0 > /proc/sys/vm/oom_dump_tasks
>>> ./stress-ng --module 100 --module-name xfs
>>
>> Above command fills for me with nfs (but also ext4) the kernel log with:
>>
>> ...
>> [  883.036035] nfs: Unknown symbol xdr_reserve_space (err -2)
>> [  883.042221] nfs: Unknown symbol rpc_init_wait_queue (err -2)
>> [  883.048549] nfs: Unknown symbol put_rpccred (err -2)
>> [  883.054104] nfs: Unknown symbol __fscache_invalidate (err -2)
>> [  883.060540] nfs: Unknown symbol __fscache_use_cookie (err -2)
>> [  883.066969] nfs: Unknown symbol rpc_clnt_xprt_switch_has_addr (err -2)
>> [  883.074264] nfs: Unknown symbol __fscache_begin_write_operation (err -2)
>> [  883.081743] nfs: Unknown symbol nlmclnt_init (err -2)
>> [  883.087396] nfs: Unknown symbol nlmclnt_done (err -2)
>> [  883.093074] nfs: Unknown symbol nfs_debug (err -2)
>> [  883.098429] nfs: Unknown symbol rpc_wait_for_completion_task (err -2)
>> [  883.105640] nfs: Unknown symbol __fscache_acquire_cookie (err -2)
>> [  883.163764] nfs: Unknown symbol rpc_put_task (err -2)
>> [  883.169461] nfs: Unknown symbol __fscache_acquire_volume (err -2)
>> [  883.176297] nfs: Unknown symbol rpc_proc_register (err -2)
>> [  883.182430] nfs: Unknown symbol rpc_shutdown_client (err -2)
>> [  883.188765] nfs: Unknown symbol rpc_clnt_show_stats (err -2)
>> [  883.195097] nfs: Unknown symbol __fscache_begin_read_operation (err -2)
>> ...
>>
>>
>> I do *not* get these errors on manual morprobe/rmmod. BUG in concurrent
>> handling or just side-effect of the concurrent loading?
> 
> It is just because modprobe deals with module dependencies, stress-ng
> modprobe doesn't, it just calls finit_module() and expects dependencies
> to be loaded first.

Oh, right. That makes sense.

> 
>>> To see how much max memory I use, I just use:
>>>
>>> free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > foo.log
>>>
>>> Run the test in another window, CTRL-C the test when above
>>> finishes after 40 seconds and then:
>>>
>>> sort -n -r foo.log  | head -1
>>
>> [root@lenovo-sr950-01 fs]# sort -n -r foo.log  | head -1
>> 14254024
>> [root@lenovo-sr950-01 fs]# sort -n -r foo.log  | tail -1
>> 12862528
>>
>> So 1391496 (KiB I assume, so 1.3 GiB !?)
> 
> That is sadly correct.
> 
>> difference compared to before the
>> test (I first start capturing and then run stress-ng).
> 
> That's a good chunk :-D
> 
> On a recent thread I do a full analysis of average module sizes [0], you
> can use that to also get an average size estimate of your currently
> loaded modules. Do a bit of math and that could give you the average
> memory pressure on real vmap allocations. For a synthentic test as with
> stress-ng modules we'd be doing twice the memory for a success load, and
> only one time allocation due to kread for a failed allocation, since we
> always allocate memory even for bogus modules on the kread side.
> 
> My xfs.ko is 42M on my test guest system, with 100 concurrent threads
> doing two allocations each that puts the expected vmap allocation at
> around:
> 
> 42*2*100
> 8400
> 8400/1024
> 8.20312500000000000000
> 
> 8.2 GiB
> 
> So on the worst case that's what we'd see. Since I saw seeing the
> patches helped overall around 145 MiB in difference let's see what
> that means. Let me re-test:
> 
> Idle memory: (note free -k uses kibibytes, KiB.
> 
> root@kmod ~ # free -k -s 1 -c 3 | grep Mem | awk '{print $3}' | sort -n -r  | head -1
> 416452
> 
> So while idle, the system is using up 416452 KiB, so 406 MiB.
> 
> While running stress-ng with 100 module ops
> 
> free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > 2023-03-28-kmodsem-stress-ng-v1.txt
> echo 0 > /proc/sys/vm/oom_dump_tasks
> ./stress-ng --module 100 --module-name xfs
> root@kmod ~ # sort -n -r 2023-03-28-kmodsem-stress-ng-v1.txt | head -1
> 4886492
> 
> 4886492/1024
> 4771.96484375000000000000
> 4886492/1024/1024
> 4.66012191772460937500
> 
> So during the stress test we see memory highest usage was about
> 4771.96 MiB or ~4.66 GiB.
> 
> What's the difference between idle and after the stress test:
> 
> 4886492 - 416452
> 4470040
> 4470040/1024
> 4365.27343750000000000000
> 4470040/1024/1024
> 4.26296234130859375000
> 
> So about 4365.27 MiB or 4.26 GiB.
> 
> Now, the upper limit for the test should have been a delta of 8.2 GiB
> and we get about 4.26, so it means we're rejecting more than half of
> the requests. Why half not just half? I only see 40 successful loads
> of XFS during a 40 second window:
> 
>    dmesg -c > /dev/null
>    # run tests
>    dmesg -c | grep XFS | wc -l
> 
> At 100 ops all running finit_module for 40 seconds those successful
> loads only should have consumed about 40 * 2 * size of XFS (42 MiB):
> 3360 MiB or 3.28 GiB. But at any point in time only one module could
> be loaded at a time, so in the *worst* consumption point a XFS in this
> test should only be consuming 2*size_of_XFS(42 MiB) so 84 MiB.
> 
> 4365.27 - 84
> 4281.27
> 
> So about 4281.27 MiB (4.18 GiB) are consumed by the 98.07% of the
> failed module loads due to the kread*() calls from finit_module().
> 
> And get this... *if* you use module compression that also uses vmap()
> *after* the kernel_read*() call which uses vmalloc(). *At least* in
> that case we immediately free the buffer for the compressed module,
> but *still* -- that is 3 possible vmap space allocations for every
> module!

:/

> 
> It'd be hard, but not impossible to collect stats for failed
> finit_modules(). *That* could be indicative of areas in the kernel
> we need to brush up on to stop doing stupid things, like we learned
> about for the CPU frequency scaling modules. As I wrote this paragraph
> I realized -- that this *is*  what we really have wanted all along to
> help us debug these stupid things, so we can slowly learn where to
> point fingers at to help optimize things. Altough I recently did some
> tool scraping to collect stats and *wished* for this from userspace [0],
> it wasn't hard to just a debug option for this to help us debug these
> failures. So I added support for that and sent finally a new patch
> series.

Makes sense to me.


I didn't have time to look at the code yet (currently traveling), I hope 
that the kasan vmap issues are at least history.

I'll do another test with debug kernels using your latest version on 
that machine before I have to hand it back.

Thanks!

-- 
Thanks,

David / dhildenb

