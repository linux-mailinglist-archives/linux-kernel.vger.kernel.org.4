Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B01645DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLGPdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLGPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3408B61BA7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670427143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nI23qKURDk6eVp9CxCt+uXO/ZCpFRupAOr1zW0mjEQ=;
        b=J81LOcO4YQvvcc74lkcamCDyNGXfefxlish7frtKgXbxjyvihyKW4FPAnspMty5g+O93JG
        ZAKQAv9vpmZvGbuX7sIDDuyT04zC3sZdss+HbezrsabSJrv7GJhj8fCnmX4sIVpfAF03+6
        9a0y9hKzXjInNZ45TgNm3ZEkgTSlFSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-36-elHAN870Nqq3xSEOuZMBQA-1; Wed, 07 Dec 2022 10:32:22 -0500
X-MC-Unique: elHAN870Nqq3xSEOuZMBQA-1
Received: by mail-wr1-f71.google.com with SMTP id o10-20020adfa10a000000b00241f603af8dso4348257wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:organization:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nI23qKURDk6eVp9CxCt+uXO/ZCpFRupAOr1zW0mjEQ=;
        b=ENjceEj+1u1l8R7bXQt7GyL4shkialeJVSj1jUkwgXkcm56wiL3QroFBuHCM/LUN62
         jY71x4Om9VczGspBPWkc354DeC/XAf4n8GNzPqr/2+dKamdsOT5W+XtaG+RO97Ex/Zg/
         b33ISQR1JYwOnsO3gmhZ3ae8LuP0z0BSYJ5DDEatK6OgDfx3bXNtgzXR+e9J9lNdqGgL
         Yeeo+cmlTTlsyPv5NMFv2K6P019U4rqDny6qcYCIqfbSAjzk8YW5o9M3tzECquuQesEL
         pfESQhF589hyTlCIftSTb+8NFr1rlcYzBOm9cM/6i1NGHjh+S1ll46uKboi+AZP5Y/t1
         V4Rw==
X-Gm-Message-State: ANoB5plWCJN7LZevOjjMjUVvMEyamZft27OH0Kddip4ISpxNh06o83HP
        QbZYYVDFwGXmJKOH0K1aG979mPhC2xp+tJlb+iRc7Keo5ZwrTYeysg9rh1krZ36ZtzclEmIgAEm
        qPe9JxvAXTLb1bHrjUj9DqDa2
X-Received: by 2002:a1c:7401:0:b0:3cf:934b:b7ad with SMTP id p1-20020a1c7401000000b003cf934bb7admr53987907wmc.22.1670427139423;
        Wed, 07 Dec 2022 07:32:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7O35hsuo8dbjtox4fvfog9RkwM8WRapY5ELWbC2kzgYi/8JBrDdoJ/iLrtdUl92Q2i4Ny42g==
X-Received: by 2002:a1c:7401:0:b0:3cf:934b:b7ad with SMTP id p1-20020a1c7401000000b003cf934bb7admr53987890wmc.22.1670427139005;
        Wed, 07 Dec 2022 07:32:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:2500:fe2d:7534:ffa4:c1e5? (p200300cbc7022500fe2d7534ffa4c1e5.dip0.t-ipconnect.de. [2003:cb:c702:2500:fe2d:7534:ffa4:c1e5])
        by smtp.gmail.com with ESMTPSA id i2-20020adff302000000b002421a8f4fa6sm19595033wro.92.2022.12.07.07.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:32:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------goKdyuB03uIJj0avVFOrEX4v"
Message-ID: <be1a2244-24a8-480a-a38b-e4ebb9868ce5@redhat.com>
Date:   Wed, 7 Dec 2022 16:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@goole.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20221202122748.113774-1-david@redhat.com> <Y4oo6cN1a4Yz5prh@x1n>
 <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com>
 <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com> <Y45duzmGGUT0+u8t@x1n>
 <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
 <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com> <Y4+xpCRQCazCymdS@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
In-Reply-To: <Y4+xpCRQCazCymdS@x1n>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------goKdyuB03uIJj0avVFOrEX4v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> David, would you please repost a new patch for this one and copy Ives to
> make sure it'll work for him in his systems?

Yes, will do. I think has was already cc'ed.

> 
> I'd suggest to drop the mprotect example, I'll reply later on that to the
> other email but I still don't know whether it's a good example for a reader
> to understand the problem.

Yes, can do.

> 
> No reproducer needed for numa I think - I guess Ives's test case would be
> far enough to verify it if possible.  I also hope what Ives saw was the
> numa balancing issue you reported, so maybe it'll resolve all problem he
> has.  Then with that verified and queued we can drop the mm/migrate patch.

I tried writing a numa hinting reproducer, but so far I assume that it's 
with current code not (easily) possible for shmem.

We'd have to call change_prot_numa() in order to protnone these PTEs. 
That can either happen via

a) mbind() with MPOL_MF_LAZY. However, user space is currently not able
    to set that flag (dead code ...).
b) task_numa_work(). However, vma_policy_mof() seems to always fail on
    shmem and prevent us from reaching that code. Reason is that shmem
    implements vm_ops->get_policy, and it seems to be impossible to get
    MPOL_F_MOF set. At least I haven't found an easy way or I am missing
    something.

So numa hinting might not immediately explain the lost write faults.

... but are there other ways to reach do_numa_page(), even without 
active NUMA hinting? I found at least one:


   map = mmap(NULL, size, PROT_WRITE, MAP_SHARED|MAP_ANON, -1, 0);
   memset(map, 0, size);
   uffd_wp_range(map, size);

On upstream during the next write fault, we'll end up in do_numa_page() 
and simply remap the page writable due to vm_page_prot, not triggering a 
write fault. I can see the "numa_hint_faults" counter in /proc/vmstat 
increasing accordingly, so we're really in do_numa_page().


PROT_WRITE on shmem with uffd-wp is completely non-functional as it 
seems. It seems to work with anon memory. And with my patch, it also 
works with shmem.

Attaching a simple reproducer (uffd-wp-prot-write.c).



Independent of uffd-wp on shmem, we seem to be missing propagating the 
uffd-wp bit when splitting the huge zeropage. So uffd-wp'ing the huge 
zeropage and then splitting it loses the uffd-wp markers. :/

Fix seems easy and I just tested my possible fix. Attaching a simple 
reproducer (uffd-wp-huge-zero.c).

-- 
Thanks,

David / dhildenb

--------------goKdyuB03uIJj0avVFOrEX4v
Content-Type: text/x-csrc; charset=UTF-8; name="uffd-wp-prot-write.c"
Content-Disposition: attachment; filename="uffd-wp-prot-write.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRl
IDxpbnR0eXBlcy5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxmY250bC5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8cG9sbC5o
PgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUg
PHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPGxpbnV4
L21lbWZkLmg+CiNpbmNsdWRlIDxsaW51eC91c2VyZmF1bHRmZC5oPgoKc3RhdGljIHNpemVf
dCBwYWdlc2l6ZTsKc3RhdGljIGludCB1ZmZkOwpzdGF0aWMgaW50IHBhZ2VtYXBfZmQ7Cgoj
ZGVmaW5lIFNJWkUgKDEwMjQqMTAyNCoxMDI0dWxsKQojZGVmaW5lIGJhcnJpZXIoKSBfX2Fz
bV9fIF9fdm9sYXRpbGVfXygiIjogOiA6Im1lbW9yeSIpCgp2b2xhdGlsZSBib29sIHVmZmRf
dHJpZ2dlcmVkOwoKc3RhdGljIHZvaWQgdWZmZF93cF9yYW5nZShjaGFyICpzdGFydCwgc2l6
ZV90IHNpemUsIGJvb2wgd3ApCnsKCXN0cnVjdCB1ZmZkaW9fd3JpdGVwcm90ZWN0IHVmZmRf
d3JpdGVwcm90ZWN0OwoKCXVmZmRfd3JpdGVwcm90ZWN0LnJhbmdlLnN0YXJ0ID0gKHVuc2ln
bmVkIGxvbmcpIHN0YXJ0OwoJdWZmZF93cml0ZXByb3RlY3QucmFuZ2UubGVuID0gc2l6ZTsK
CWlmICh3cCkgewoJCXVmZmRfd3JpdGVwcm90ZWN0Lm1vZGUgPSBVRkZESU9fV1JJVEVQUk9U
RUNUX01PREVfV1A7Cgl9IGVsc2UgewoJCXVmZmRfd3JpdGVwcm90ZWN0Lm1vZGUgPSAwOwoJ
fQoJaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19XUklURVBST1RFQ1QsICZ1ZmZkX3dyaXRlcHJv
dGVjdCkpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIlVGRkRJT19XUklURVBST1RFQ1QgZmFpbGVk
OiAlZFxuIiwgZXJybm8pOwoJCWV4aXQoMSk7Cgl9Cn0KCnN0YXRpYyB2b2lkICp1ZmZkX3Ro
cmVhZF9mbih2b2lkICphcmcpCnsKCXN0YXRpYyBzdHJ1Y3QgdWZmZF9tc2cgbXNnOwoJc3Np
emVfdCBucmVhZDsKCgl3aGlsZSAoMSkgewoJCXN0cnVjdCBwb2xsZmQgcG9sbGZkOwoJCWlu
dCBucmVhZHk7CgoJCXBvbGxmZC5mZCA9IHVmZmQ7CgkJcG9sbGZkLmV2ZW50cyA9IFBPTExJ
TjsKCQlucmVhZHkgPSBwb2xsKCZwb2xsZmQsIDEsIC0xKTsKCQlpZiAobnJlYWR5ID09IC0x
KSB7CgkJCWZwcmludGYoc3RkZXJyLCAicG9sbCgpIGZhaWxlZDogJWRcbiIsIGVycm5vKTsK
CQkJZXhpdCgxKTsKCQl9CgoJCW5yZWFkID0gcmVhZCh1ZmZkLCAmbXNnLCBzaXplb2YobXNn
KSk7CgkJaWYgKG5yZWFkIDw9IDApCgkJCWNvbnRpbnVlOwoKCQlpZiAobXNnLmV2ZW50ICE9
IFVGRkRfRVZFTlRfUEFHRUZBVUxUIHx8CgkJICAgICEobXNnLmFyZy5wYWdlZmF1bHQuZmxh
Z3MgJiBVRkZEX1BBR0VGQVVMVF9GTEFHX1dQKSkgewoJCQlwcmludGYoIkZBSUw6IHdyb25n
IHVmZmQtd3AgZXZlbnQgZmlyZWRcbiIpOwoJCQlleGl0KDEpOwoJCX0KCgkJLyogdW4tcHJv
dGVjdCAqLwoJCXVmZmRfdHJpZ2dlcmVkID0gdHJ1ZTsKCQl1ZmZkX3dwX3JhbmdlKChjaGFy
ICopKHVpbnRwdHJfdCltc2cuYXJnLnBhZ2VmYXVsdC5hZGRyZXNzLCBwYWdlc2l6ZSwgZmFs
c2UpOwoJfQoJcmV0dXJuIGFyZzsKfQoKc3RhdGljIGludCBzZXR1cF91ZmZkKGNoYXIgKm1h
cCwgc2l6ZV90IHNpemUpCnsKCXN0cnVjdCB1ZmZkaW9fYXBpIHVmZmRpb19hcGk7CglzdHJ1
Y3QgdWZmZGlvX3JlZ2lzdGVyIHVmZmRpb19yZWdpc3RlcjsKCXB0aHJlYWRfdCB0aHJlYWQ7
CgoJdWZmZCA9IHN5c2NhbGwoX19OUl91c2VyZmF1bHRmZCwKCQkgICAgICAgT19DTE9FWEVD
IHwgT19OT05CTE9DSyB8IFVGRkRfVVNFUl9NT0RFX09OTFkpOwoJaWYgKHVmZmQgPCAwKSB7
CgkJZnByaW50ZihzdGRlcnIsICJzeXNjYWxsKCkgZmFpbGVkOiAlZFxuIiwgZXJybm8pOwoJ
CXJldHVybiAtZXJybm87Cgl9CgoJdWZmZGlvX2FwaS5hcGkgPSBVRkZEX0FQSTsKCXVmZmRp
b19hcGkuZmVhdHVyZXMgPSBVRkZEX0ZFQVRVUkVfUEFHRUZBVUxUX0ZMQUdfV1A7CglpZiAo
aW9jdGwodWZmZCwgVUZGRElPX0FQSSwgJnVmZmRpb19hcGkpIDwgMCkgewoJCWZwcmludGYo
c3RkZXJyLCAiVUZGRElPX0FQSSBmYWlsZWQ6ICVkXG4iLCBlcnJubyk7CgkJcmV0dXJuIC1l
cnJubzsKCX0KCglpZiAoISh1ZmZkaW9fYXBpLmZlYXR1cmVzICYgVUZGRF9GRUFUVVJFX1BB
R0VGQVVMVF9GTEFHX1dQKSkgewoJCWZwcmludGYoc3RkZXJyLCAiVUZGRF9GRUFUVVJFX1dS
SVRFUFJPVEVDVCBtaXNzaW5nXG4iKTsKCQlyZXR1cm4gLUVOT1NZUzsKCX0KCgl1ZmZkaW9f
cmVnaXN0ZXIucmFuZ2Uuc3RhcnQgPSAodW5zaWduZWQgbG9uZykgbWFwOwoJdWZmZGlvX3Jl
Z2lzdGVyLnJhbmdlLmxlbiA9IHNpemU7Cgl1ZmZkaW9fcmVnaXN0ZXIubW9kZSA9IFVGRkRJ
T19SRUdJU1RFUl9NT0RFX1dQOwoJaWYgKGlvY3RsKHVmZmQsIFVGRkRJT19SRUdJU1RFUiwg
JnVmZmRpb19yZWdpc3RlcikgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJVRkZESU9fUkVH
SVNURVIgZmFpbGVkOiAlZFxuIiwgZXJybm8pOwoJCXJldHVybiAtZXJybm87Cgl9CgoJcHRo
cmVhZF9jcmVhdGUoJnRocmVhZCwgTlVMTCwgdWZmZF90aHJlYWRfZm4sIE5VTEwpOwoKCXJl
dHVybiAwOwp9CgppbnQgbWFpbih2b2lkKQp7Cgljb25zdCBzaXplX3Qgc2l6ZSA9IFNJWkU7
CgljaGFyICptYXAsICpjdXI7CgoJcGFnZXNpemUgPSBnZXRwYWdlc2l6ZSgpOwoJcGFnZW1h
cF9mZCA9IG9wZW4oIi9wcm9jL3NlbGYvcGFnZW1hcCIsIE9fUkRPTkxZKTsKCWlmIChwYWdl
bWFwX2ZkIDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAiT3BlbmluZyAvcHJvYy9zZWxmL3Bh
Z2VtYXAgZmFpbGVkXG4iKTsKCQlyZXR1cm4gMTsKCX0KCgltYXAgPSBtbWFwKE5VTEwsIHNp
emUsIFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OLCAtMSwgMCk7CglpZiAobWFw
ID09IE1BUF9GQUlMRUQpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIm1tYXAoKSBmYWlsZWRcbiIp
OwoJCXJldHVybiAtZXJybm87Cgl9CgoJaWYgKG1hZHZpc2UobWFwLCBzaXplLCBNQURWX05P
SFVHRVBBR0UpKSB7CgkJZnByaW50ZihzdGRlcnIsICJNQURWX0hVR0VQQUdFIGZhaWxlZFxu
Iik7CgkJcmV0dXJuIC1lcnJubzsKCX0KCgkvKiBQb3B1bGF0ZSBhbGwgcGFnZXMgLi4uICov
CgltZW1zZXQobWFwLCAwLCBzaXplKTsKCglpZiAoc2V0dXBfdWZmZChtYXAsIHNpemUpKQoJ
CXJldHVybiAxOwoKCS8qIC4uLiBhbmQgd3JpdGUtcHJvdGVjdCB0aGVtIHVzaW5nIHVmZmQt
d3AuICovCgl1ZmZkX3dwX3JhbmdlKG1hcCwgc2l6ZSwgdHJ1ZSk7CgoJLyogVGVzdCBpZiBh
bGwgZmF1bHRzIHRyaWdnZXIuICovCglmb3IgKGN1ciA9IG1hcDsgY3VyIDwgbWFwICsgc2l6
ZTsgY3VyICs9IHBhZ2VzaXplKSB7CgkJdWZmZF90cmlnZ2VyZWQgPSBmYWxzZTsKCQliYXJy
aWVyKCk7CgoJCS8qIFRyaWdnZXIgYSB3cml0ZSBmYXVsdC4gKi8KCQkqY3VyID0gMTsKCgkJ
YmFycmllcigpOwoJCWlmICghdWZmZF90cmlnZ2VyZWQpIHsKCQkJcHJpbnRmKCJGQUlMOiB1
ZmZkLXdwIGRpZCBub3QgdHJpZ2dlclxuIik7CgkJCXJldHVybiAxOwoJCX0KCX0KCglwcmlu
dGYoIlBBU1M6IHVmZmQtd3AgdHJpZ2dlcmVkXG4iKTsKCXJldHVybiAwOwp9Cg==
--------------goKdyuB03uIJj0avVFOrEX4v
Content-Type: text/x-csrc; charset=UTF-8; name="uffd-wp-huge-zero.c"
Content-Disposition: attachment; filename="uffd-wp-huge-zero.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRl
IDxpbnR0eXBlcy5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxmY250bC5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8cG9sbC5o
PgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUg
PHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPGxpbnV4
L21lbWZkLmg+CiNpbmNsdWRlIDxsaW51eC91c2VyZmF1bHRmZC5oPgoKc3RhdGljIHNpemVf
dCBwYWdlc2l6ZTsKc3RhdGljIGludCB1ZmZkOwpzdGF0aWMgaW50IHBhZ2VtYXBfZmQ7Cgoj
ZGVmaW5lIFNJWkUgKDEyOCoxMDI0KjEwMjR1bGwpCiNkZWZpbmUgYmFycmllcigpIF9fYXNt
X18gX192b2xhdGlsZV9fKCIiOiA6IDoibWVtb3J5IikKCnZvbGF0aWxlIGJvb2wgdWZmZF90
cmlnZ2VyZWQ7CgpzdGF0aWMgdm9pZCB1ZmZkX3dwX3JhbmdlKGNoYXIgKnN0YXJ0LCBzaXpl
X3Qgc2l6ZSwgYm9vbCB3cCkKewoJc3RydWN0IHVmZmRpb193cml0ZXByb3RlY3QgdWZmZF93
cml0ZXByb3RlY3Q7CgoJdWZmZF93cml0ZXByb3RlY3QucmFuZ2Uuc3RhcnQgPSAodW5zaWdu
ZWQgbG9uZykgc3RhcnQ7Cgl1ZmZkX3dyaXRlcHJvdGVjdC5yYW5nZS5sZW4gPSBzaXplOwoJ
aWYgKHdwKSB7CgkJdWZmZF93cml0ZXByb3RlY3QubW9kZSA9IFVGRkRJT19XUklURVBST1RF
Q1RfTU9ERV9XUDsKCX0gZWxzZSB7CgkJdWZmZF93cml0ZXByb3RlY3QubW9kZSA9IDA7Cgl9
CglpZiAoaW9jdGwodWZmZCwgVUZGRElPX1dSSVRFUFJPVEVDVCwgJnVmZmRfd3JpdGVwcm90
ZWN0KSkgewoJCWZwcmludGYoc3RkZXJyLCAiVUZGRElPX1dSSVRFUFJPVEVDVCBmYWlsZWQ6
ICVkXG4iLCBlcnJubyk7CgkJZXhpdCgxKTsKCX0KfQoKc3RhdGljIHZvaWQgKnVmZmRfdGhy
ZWFkX2ZuKHZvaWQgKmFyZykKewoJc3RhdGljIHN0cnVjdCB1ZmZkX21zZyBtc2c7Cglzc2l6
ZV90IG5yZWFkOwoKCXdoaWxlICgxKSB7CgkJc3RydWN0IHBvbGxmZCBwb2xsZmQ7CgkJaW50
IG5yZWFkeTsKCgkJcG9sbGZkLmZkID0gdWZmZDsKCQlwb2xsZmQuZXZlbnRzID0gUE9MTElO
OwoJCW5yZWFkeSA9IHBvbGwoJnBvbGxmZCwgMSwgLTEpOwoJCWlmIChucmVhZHkgPT0gLTEp
IHsKCQkJZnByaW50ZihzdGRlcnIsICJwb2xsKCkgZmFpbGVkOiAlZFxuIiwgZXJybm8pOwoJ
CQlleGl0KDEpOwoJCX0KCgkJbnJlYWQgPSByZWFkKHVmZmQsICZtc2csIHNpemVvZihtc2cp
KTsKCQlpZiAobnJlYWQgPD0gMCkKCQkJY29udGludWU7CgoJCWlmIChtc2cuZXZlbnQgIT0g
VUZGRF9FVkVOVF9QQUdFRkFVTFQgfHwKCQkgICAgIShtc2cuYXJnLnBhZ2VmYXVsdC5mbGFn
cyAmIFVGRkRfUEFHRUZBVUxUX0ZMQUdfV1ApKSB7CgkJCXByaW50ZigiRkFJTDogd3Jvbmcg
dWZmZC13cCBldmVudCBmaXJlZFxuIik7CgkJCWV4aXQoMSk7CgkJfQoKCQkvKiB1bi1wcm90
ZWN0ICovCgkJdWZmZF90cmlnZ2VyZWQgPSB0cnVlOwoJCXVmZmRfd3BfcmFuZ2UoKGNoYXIg
KikodWludHB0cl90KW1zZy5hcmcucGFnZWZhdWx0LmFkZHJlc3MsIHBhZ2VzaXplLCBmYWxz
ZSk7Cgl9CglyZXR1cm4gYXJnOwp9CgpzdGF0aWMgaW50IHNldHVwX3VmZmQoY2hhciAqbWFw
LCBzaXplX3Qgc2l6ZSkKewoJc3RydWN0IHVmZmRpb19hcGkgdWZmZGlvX2FwaTsKCXN0cnVj
dCB1ZmZkaW9fcmVnaXN0ZXIgdWZmZGlvX3JlZ2lzdGVyOwoJcHRocmVhZF90IHRocmVhZDsK
Cgl1ZmZkID0gc3lzY2FsbChfX05SX3VzZXJmYXVsdGZkLAoJCSAgICAgICBPX0NMT0VYRUMg
fCBPX05PTkJMT0NLIHwgVUZGRF9VU0VSX01PREVfT05MWSk7CglpZiAodWZmZCA8IDApIHsK
CQlmcHJpbnRmKHN0ZGVyciwgInN5c2NhbGwoKSBmYWlsZWQ6ICVkXG4iLCBlcnJubyk7CgkJ
cmV0dXJuIC1lcnJubzsKCX0KCgl1ZmZkaW9fYXBpLmFwaSA9IFVGRkRfQVBJOwoJdWZmZGlv
X2FwaS5mZWF0dXJlcyA9IFVGRkRfRkVBVFVSRV9QQUdFRkFVTFRfRkxBR19XUDsKCWlmIChp
b2N0bCh1ZmZkLCBVRkZESU9fQVBJLCAmdWZmZGlvX2FwaSkgPCAwKSB7CgkJZnByaW50Zihz
dGRlcnIsICJVRkZESU9fQVBJIGZhaWxlZDogJWRcbiIsIGVycm5vKTsKCQlyZXR1cm4gLWVy
cm5vOwoJfQoKCWlmICghKHVmZmRpb19hcGkuZmVhdHVyZXMgJiBVRkZEX0ZFQVRVUkVfUEFH
RUZBVUxUX0ZMQUdfV1ApKSB7CgkJZnByaW50ZihzdGRlcnIsICJVRkZEX0ZFQVRVUkVfV1JJ
VEVQUk9URUNUIG1pc3NpbmdcbiIpOwoJCXJldHVybiAtRU5PU1lTOwoJfQoKCXVmZmRpb19y
ZWdpc3Rlci5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBsb25nKSBtYXA7Cgl1ZmZkaW9fcmVn
aXN0ZXIucmFuZ2UubGVuID0gc2l6ZTsKCXVmZmRpb19yZWdpc3Rlci5tb2RlID0gVUZGRElP
X1JFR0lTVEVSX01PREVfV1A7CglpZiAoaW9jdGwodWZmZCwgVUZGRElPX1JFR0lTVEVSLCAm
dWZmZGlvX3JlZ2lzdGVyKSA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIlVGRkRJT19SRUdJ
U1RFUiBmYWlsZWQ6ICVkXG4iLCBlcnJubyk7CgkJcmV0dXJuIC1lcnJubzsKCX0KCglwdGhy
ZWFkX2NyZWF0ZSgmdGhyZWFkLCBOVUxMLCB1ZmZkX3RocmVhZF9mbiwgTlVMTCk7CgoJcmV0
dXJuIDA7Cn0KCmludCBtYWluKHZvaWQpCnsKCWNvbnN0IHNpemVfdCBzaXplID0gU0laRTsK
CWNoYXIgKm1hcCwgKmN1cjsKCglwYWdlc2l6ZSA9IGdldHBhZ2VzaXplKCk7CglwYWdlbWFw
X2ZkID0gb3BlbigiL3Byb2Mvc2VsZi9wYWdlbWFwIiwgT19SRE9OTFkpOwoJaWYgKHBhZ2Vt
YXBfZmQgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJPcGVuaW5nIC9wcm9jL3NlbGYvcGFn
ZW1hcCBmYWlsZWRcbiIpOwoJCXJldHVybiAxOwoJfQoKCW1hcCA9IG1tYXAoTlVMTCwgc2l6
ZSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9BTk9OLCAtMSwgMCk7
CglpZiAobWFwID09IE1BUF9GQUlMRUQpIHsKCQlmcHJpbnRmKHN0ZGVyciwgIm1tYXAoKSBm
YWlsZWRcbiIpOwoJCXJldHVybiAtZXJybm87Cgl9CgoJaWYgKG1hZHZpc2UobWFwLCBzaXpl
LCBNQURWX0hVR0VQQUdFKSkgewoJCWZwcmludGYoc3RkZXJyLCAiTUFEVl9IVUdFUEFHRSBm
YWlsZWRcbiIpOwoJCXJldHVybiAtZXJybm87Cgl9CgoJaWYgKHNldHVwX3VmZmQobWFwLCBz
aXplKSkKCQlyZXR1cm4gMTsKCgkvKiBQb3B1bGF0ZSB0aGUgc2hhcmVkIHplcm9wYWdlLCBo
b3BlZnVsbHQgYWxzbyB0aGUgaHVnZSBvbmUuKi8KCW1hZHZpc2UobWFwLCBzaXplLCBNQURW
X1BPUFVMQVRFX1JFQUQpOwoKCS8qIC4uLiBhbmQgd3JpdGUtcHJvdGVjdCBhbGwgcGFnZXMg
dXNpbmcgdWZmZC13cC4gKi8KCXVmZmRfd3BfcmFuZ2UobWFwLCBzaXplLCB0cnVlKTsKCgkv
KgoJICogRGlzY2FyZCBldmVyeSBzZWNvbmQgb2RkIHBhZ2UsIHRoaXMgd2lsbCBzcGxpdCBh
bnkgaHVnZSB6ZXJvCgkgKiBUSFAgYW5kIHdpbGwgaG9wZWZ1bGx5IGtlZXAgdGhlIFBURSBw
cm90ZWN0ZWQgdXNpbmcgdWZmZC13cC4KCSAqCgkgKiBBbnkgbWVjaGFuaXNtIHRvIFBURS1t
YXAgdGhlIFRIUCB3b3VsZCBkby4KCSAqLwoJZm9yIChjdXIgPSBtYXAgKyBwYWdlc2l6ZTsg
Y3VyIDwgbWFwICsgc2l6ZTsgY3VyICs9IDIgKiBwYWdlc2l6ZSkKCQltYWR2aXNlKGN1ciwg
cGFnZXNpemUsIE1BRFZfRE9OVE5FRUQpOwoKCS8qCgkgKiBUZXN0IGV2ZXJ5IHNlY29uZCBl
dmVuIHBhZ2UgKC0+IGFsbCByZW1haW5pbmcgb25lcykgaWYgd2UgZ2V0IG91cgoJICogdWZm
ZC13cCBldmVudHMuCgkgKi8KCWZvciAoY3VyID0gbWFwOyBjdXIgPCBtYXAgKyBzaXplOyBj
dXIgKz0gMiAqIHBhZ2VzaXplKSB7CgkJdWZmZF90cmlnZ2VyZWQgPSBmYWxzZTsKCgkJYmFy
cmllcigpOwoJCS8qIFRyaWdnZXIgYSB3cml0ZSBmYXVsdC4gKi8KCQkqY3VyID0gMTsKCQli
YXJyaWVyKCk7CgoJCWlmICghdWZmZF90cmlnZ2VyZWQpIHsKCQkJcHJpbnRmKCJGQUlMOiB1
ZmZkLXdwIGRpZCBub3QgdHJpZ2dlclxuIik7CgkJCXJldHVybiAxOwoJCX0KCX0KCglwcmlu
dGYoIlBBU1M6IHVmZmQtd3AgdHJpZ2dlcmVkXG4iKTsKCXJldHVybiAwOwp9Cg==

--------------goKdyuB03uIJj0avVFOrEX4v--

