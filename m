Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C4633E75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiKVOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiKVOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD95697C2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669125928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FvVCizhQDi+bLw8dsWFdCya/UrchTBQhvpQ3ysZKtzw=;
        b=LFXl0/Stsq4J0ddTLPvdJzyBmk6Dthvvdc6fzTMjXr6Z48TGF4oSXrnPZqxczLUL1tAO3W
        x/5CAcA6SC28xc+P6jyCe8xy3By2onCn8Bm0522agSjERXwNco70/SYZABWhF0YElkosrC
        UeY9zp8Sz8sXdqanH3sHDcH7QCIGdZY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-drazhOuOPOi9s4GOUjdPpQ-1; Tue, 22 Nov 2022 09:05:26 -0500
X-MC-Unique: drazhOuOPOi9s4GOUjdPpQ-1
Received: by mail-wm1-f69.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so8108738wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:organization:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvVCizhQDi+bLw8dsWFdCya/UrchTBQhvpQ3ysZKtzw=;
        b=PM6Cl6B29NbNsGkhHQK1gkxTrKKuZzpotZHhN1E33J8HWQcv9wfrzsuskrbdaaV3J/
         DtUKVdJW/UT/J7KzS//0IxsBeCqVkHEarUcG1wUUpONx4GMfdZsneJ8PLPNml+N8sn6N
         yer50uOLV1hAxddWGzdv+c0Apsq/+O/7QJDuKvGS+3aCeCNMJcbB3t5/DzsYRyMkrVnd
         z91lrLAIe+A9tAn0k1eHrVQ+wBcif144zEUQipJUn18nUdBlMgxB+bAgMD8BUo1DidXi
         qdtDcowlBNG2suf9bEi5WoJ9KoWuolyI8DWah+Qv+rGhOiMorhkOenEGknhy4+Ygz6Gx
         IPLA==
X-Gm-Message-State: ANoB5pneJ0EkJmyKYJsyo6QZVN7gSfb0tJOgXDsLvIR2gu2dvGWrLo2Y
        zSoCmRmq/n12sNGq9uDINVjG7cRzJS9yy4ATAZqfI/HRYVddVR9F8Pkjy1SXoViCHVMpF4aH0cB
        OT+sDmWI9yxBCucX0WcmVdvmYi6w26STambmFQCo4evrts9n0xjYzafonDHq8L01tM012FrgX
X-Received: by 2002:adf:dd4c:0:b0:241:c075:30db with SMTP id u12-20020adfdd4c000000b00241c07530dbmr4647768wrm.159.1669125925628;
        Tue, 22 Nov 2022 06:05:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf45BP0u5dlXTS9tBk7TfX4ga1EDACnSRGuH6hbUsR+feboSnLGrcScpNUORrYu9ggowIDYU6A==
X-Received: by 2002:adf:dd4c:0:b0:241:c075:30db with SMTP id u12-20020adfdd4c000000b00241c07530dbmr4647734wrm.159.1669125925190;
        Tue, 22 Nov 2022 06:05:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:c300:b066:75e3:f1d2:b69b? (p200300cbc706c300b06675e3f1d2b69b.dip0.t-ipconnect.de. [2003:cb:c706:c300:b066:75e3:f1d2:b69b])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b00236576c8eddsm14081329wru.12.2022.11.22.06.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:05:24 -0800 (PST)
Message-ID: <ceb85a8b-d6e8-830f-eddb-69ae1531e10e@redhat.com>
Date:   Tue, 22 Nov 2022 15:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: 32bit architectures and __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Spoiler: is there a real use case for > 16 GiB of swap in a single file 
on 32bit architectures?


I'm currently looking into implementing __HAVE_ARCH_PTE_SWP_EXCLUSIVE 
support for all remaining architectures. So far, I only implemented it 
for the most relevant enterprise architectures.


With __HAVE_ARCH_PTE_SWP_EXCLUSIVE, we remember when unmapping a page 
and replacing the present PTE by a swap PTE for swapout whether the 
anonymous page that was mapped was exclusive (PageAnonExclusive(), i.e., 
not COW-shared). When refaulting that page, whereby we replace the swap 
PTE by a present PTE, we can reuse that information to map that page 
writable and avoid unnecessary page copies due to COW, even if there are 
still unexpected references on the page.

While this would usually be a pure optimization, currently O_DIRECT 
still (wrongly) uses FOLL_GET instead of FOLL_PIN and can trigger in 
corner cases memory corruptions. So for that case, it is also a 
temporary fix until O_DIRECT properly uses FOLL_PIN. More details can be 
found in [1].


Ideally, I'd just implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE for all 
architectures. However, __HAVE_ARCH_PTE_SWP_EXCLUSIVE requires an 
additional bit in the swap PTE. While mostly unproblematic on 64bit, for 
32bit this implies that we'll have to "steal" one bit from the swap 
offset on most architectures, reducing the maximum swap size per file.


Assuming we previously supported 32 GiB per swap file (e.g., hexagon, 
csky), this number would get reduced to 16 GiB. The kernel would 
automatically truncate the oversized swap area and the system would 
continue working by using less space of that swapfile, but ... well, is 
there a but?

Usually (well, there is PAE on x86 ...), a 32bit system can address 4 
GiB of memory. Maximum swap size recommendation seem to be around 2--3 
times the memory size (2x without hibernation, 3x with hibernation). So 
it sounds like there is barely a use case for more swap space. Of course 
one can use multiple swap files.


So, is anybody aware of excessive swap space requirements on 32bit?


Note that I thought about storing the exclusive marker in the swap_map 
instead of in the swap PTE, but quickly decided to discard that idea 
because it results in significantly more complexity and the swap code is 
already horrible enough.

[1] https://lkml.kernel.org/r/20220329164329.208407-1-david@redhat.com

-- 
Thanks,

David / dhildenb

