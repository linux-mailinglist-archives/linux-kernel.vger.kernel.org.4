Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122096408CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiLBO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbiLBO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:56:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BDD2D91
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669992943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHUHbx8F/8wtzFT6faTcNX7ZhZo5NrRQiROyLPZZhTA=;
        b=diynUNwpXR6zKOUvF7HjV9e198NJQTDktTxY7nu7KTIYsSXGvTauOCAiYGlzNaZm1gcI5m
        eRlUV6wWjXRgeM6EhcFtlpQFiuSO3lhui1cdQD36iUwhxN8BvMb+t5LJyI7+BPO0yaB6tc
        jYa35Zg/hJzz4xXfhq/mKi3Z5SECq/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-oKz2nJgVOU2BCGxdjkm7uw-1; Fri, 02 Dec 2022 09:55:41 -0500
X-MC-Unique: oKz2nJgVOU2BCGxdjkm7uw-1
Received: by mail-wr1-f71.google.com with SMTP id a7-20020adfbc47000000b002421f817287so1136069wrh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHUHbx8F/8wtzFT6faTcNX7ZhZo5NrRQiROyLPZZhTA=;
        b=PIZxflNlOZc2rn2RQW+t26UkXDEwVpWAyn+eDCN/27z4vuxzg72XZ0RztLHH19wXxC
         6VNAMoLfoqgGEwzJn1jkwHTCr928XWNH4qNEm9eCWCSp4VtU/gtqBDG3a5PuYkgWnS6L
         W8JDTPrx4Gv1XFz8Gks+tFJcJ0RUSsGZ2Dwwi+BVwrDXOucL0kPXqvzpagpDeBxgrNmM
         OR7W9pFfjy1KektlfsjilkMdeY33woB07LllMqhhw6Agn/h+Q3sPxO1hj0Cnueht0grn
         2MVuyBIuJ72qLS7RDbUARF4enNG+/dc3fO/GIV9hMEuGdQlfMNUh7DLN7yc7PBjcD7b/
         oEQg==
X-Gm-Message-State: ANoB5pkW5eTctmFl/OzAVaHewij0j9sPIc4FHzi46HwogUczkiDUJXET
        A7v/WX9EADxR+9Sh9gRe8Azcux+SdW3aCshR1ElSoCRRy9OCSAvwKVCxSZX5mBpgVr/3qvlhG6q
        cKSidtYAUASOpPfSaXKPRmi3q
X-Received: by 2002:a05:6000:12cf:b0:236:6442:2f86 with SMTP id l15-20020a05600012cf00b0023664422f86mr4143803wrx.588.1669992940577;
        Fri, 02 Dec 2022 06:55:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5eX11b1JZOPoseBqgJt9x/1WBiTeKiOnqv3/IZ3HiskKmhV1TftMA7rfJ0rb0BaiAsNkeyeg==
X-Received: by 2002:a05:6000:12cf:b0:236:6442:2f86 with SMTP id l15-20020a05600012cf00b0023664422f86mr4143793wrx.588.1669992940378;
        Fri, 02 Dec 2022 06:55:40 -0800 (PST)
Received: from [192.168.110.200] (82-65-22-26.subs.proxad.net. [82.65.22.26])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4570000000b00242109cf587sm7420324wrc.28.2022.12.02.06.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 06:55:39 -0800 (PST)
Message-ID: <c9912b24-f611-29b8-28e1-5e8be0d5ad41@redhat.com>
Date:   Fri, 2 Dec 2022 15:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20221121104403.1545f9b5@gandalf.local.home>
 <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
Content-Language: en-US
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
In-Reply-To: <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/22 22:13, Linus Torvalds wrote:
> On Thu, Dec 1, 2022 at 8:59 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> The hid-bpf framework depends on it.
> 
> Ok, this is completely unacceptably disgusting hack.

[foreword: I have read the other replies, just replying to this one
because it is the explicit ask for a fix]

> 
> That needs fixing.
> 
>> Either hid-bpf or bpf core can add
>> "depends on FUNCTION_ERROR_INJECTION"
> 
> No, it needs to be narrowed down a lot. Nobody sane wants error
> injection just because they want some random HID thing.
> 
> And no, BPF shouldn't need it either.
> 
> This needs to be narrowed down to the point where HID can say "I want
> *this* particular call to be able to be a bpf call.

So, would the following be OK? I still have a few concerns I'll explain
after the patch.

---
 From 1290561304eb3e48e1e6d727def13c16698a26f1 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 2 Dec 2022 12:40:29 +0100
Subject: [PATCH] bpf: do not rely on ALLOW_ERROR_INJECTION for fmod_ret

The current way of expressing that a non-bpf kernel component is willing
to accept that bpf programs can be attached to it and that they can change
the return value is to abuse ALLOW_ERROR_INJECTION.
This is debated in the link below, and the result is that it is not a
reasonable thing to do.

An easy fix is to keep the list of valid functions in the BPF verifier
in the same way we keep the non-sleepable ALLOW_ERROR_INJECTION ones.
However, this kind of defeat the point of being able to add bpf APIs in
non-BPF subsystems, so we probably need to rethink that part.


Link: https://lore.kernel.org/all/20221121104403.1545f9b5@gandalf.local.home/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
  drivers/hid/bpf/hid_bpf_dispatch.c  |  2 --
  drivers/hid/bpf/hid_bpf_jmp_table.c |  1 -
  kernel/bpf/verifier.c               | 20 +++++++++++++++++++-
  3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 3c989e74d249..d1f6a1d4ae60 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -44,7 +44,6 @@ __weak noinline int hid_bpf_device_event(struct hid_bpf_ctx *ctx)
  {
  	return 0;
  }
-ALLOW_ERROR_INJECTION(hid_bpf_device_event, ERRNO);
  
  u8 *
  dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
@@ -105,7 +104,6 @@ __weak noinline int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
  {
  	return 0;
  }
-ALLOW_ERROR_INJECTION(hid_bpf_rdesc_fixup, ERRNO);
  
  u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
  {
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index 579a6c06906e..207972b028d9 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -103,7 +103,6 @@ __weak noinline int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx)
  {
  	return 0;
  }
-ALLOW_ERROR_INJECTION(__hid_bpf_tail_call, ERRNO);
  
  int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
  		     struct hid_bpf_ctx_kern *ctx_kern)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 225666307bba..4eac440d659f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,6 +24,7 @@
  #include <linux/bpf_lsm.h>
  #include <linux/btf_ids.h>
  #include <linux/poison.h>
+#include <linux/hid_bpf.h>
  
  #include "disasm.h"
  
@@ -14827,6 +14828,20 @@ static int check_non_sleepable_error_inject(u32 btf_id)
  	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
  }
  
+/* Manually tag fmod_ret functions to not misuse ALLOW_ERROR_INJECTION */
+BTF_SET_START(btf_modify_return)
+#if CONFIG_HID_BPF
+BTF_ID(func, hid_bpf_device_event)
+BTF_ID(func, hid_bpf_rdesc_fixup)
+BTF_ID(func, __hid_bpf_tail_call)
+#endif /* CONFIG_HID_BPF */
+BTF_SET_END(btf_modify_return)
+
+static int check_function_modify_return(u32 btf_id)
+{
+	return btf_id_set_contains(&btf_modify_return, btf_id);
+}
+
  int bpf_check_attach_target(struct bpf_verifier_log *log,
  			    const struct bpf_prog *prog,
  			    const struct bpf_prog *tgt_prog,
@@ -15047,7 +15062,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
  				bpf_log(log, "can't modify return codes of BPF programs\n");
  				return -EINVAL;
  			}
-			ret = check_attach_modify_return(addr, tname);
+			ret = -EINVAL;
+			if (!check_function_modify_return(btf_id) ||
+			    check_attach_modify_return(addr, tname))
+				ret = 0;
  			if (ret) {
  				bpf_log(log, "%s() is not modifiable\n", tname);
  				return ret;
-- 
2.38.1
---

While this patch removes the need for ALLOW_ERROR_INJECTION it has a
couple of drawbacks:
- suddenly we lose the nice separation of concerns between bpf core and
its users (HID in my case)
- it would need to be changed in 6.3 simply because of the previous
point, so it is just a temporary fix.

So I am not sure if this would qualify HID-BPF for 6.2. Please speak up.

> 
> Stop this crazy "bpf / hid needs error injection" when that then
> implies a _lot_ more than that, plus is documented to be something
> entirely different anyway.
> 
> I realize that HID has mis-used the "we could just use error injection
> here to instead insert random bpf code", but that's a complete hack.

Just to be fair, HID only happens to be the first on the front line for
this particular problem. I was told to use that mis-use because that was
probably what was available, and adding that decorator didn't seem to be
such a big deal to me.

But with a bigger picture in mind, I am happy we get to that point now
before it is merged because I know that behind me there are a few other
people in other subsystems also willing to take advantage of BPF in
their own subsystem. And at Plumbers, everybody was saying: look at the
HID-BPF patch series.

Cheers,
Benjamin

> 
> Plus it seems to happily not even have made it into mainline anyway,
> and only exists in linux-next. Let's head that disgusting hack off at
> the pass.
> 
> I'm going to apply Steven's patch, because honestly, we need to fix
> this disgusting mess *before* it gets to mainline, rather than say
> "oh, we already have broken users in next, so let's bend over
> backwards for that".
> 
> The code is called "error injection", not "random bpf extension"
> 
>                 Linus
> 

