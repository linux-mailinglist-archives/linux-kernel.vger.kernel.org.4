Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818F76B395D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCJJAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCJI7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:59:22 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47D10A4CC;
        Fri, 10 Mar 2023 00:53:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C9BCF604F2;
        Fri, 10 Mar 2023 09:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678438378; bh=IsLuUXaig4H7+tKIosOQn+P1LVRBMz5NHKBpirsIh3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X2IFNlD31ieJKBstvr60he4Xlen9ZX9GUbh/qQvkq91C8SfL8buI2sB/tIJyGqFVl
         heJ69Pwylxp/qdrM+LM+jtVJlVnOho+mm2ULHwRQLt7ijOlkReD4frbv2SjAj6YgDl
         g8Nw45Q80YDhhIxFqanwKAXozBOOJPZKhByipQxW3IWzOIdw3BsOSC3LdVLwCBYcwU
         3fQvBrSkBYB4fWkh9QZWQyrzH9wARhzBPrJcvenKvinNyG8Xec+K//xAAaDEJ3PeHP
         yVI7VqawhanDDwNcrcQGK7t4Eoj8b4x1uCJWH7fvUy0+iMgnZqa8KtxLJZ6acKTJYE
         I8dKEj/7wzcrA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9wHLTu9uQ_2F; Fri, 10 Mar 2023 09:52:56 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id BC692604EF;
        Fri, 10 Mar 2023 09:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678438376; bh=IsLuUXaig4H7+tKIosOQn+P1LVRBMz5NHKBpirsIh3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cZhu7nCO2HsLlwdlLPF4tmEc5bepZDVIDSI2pHZ7EOPho+54fdVjz0LMwm+QqHdsS
         jmcR/hKFADrJGSxQojpOBWEPaRURkjfWjfB0STB2/Tbca25HK7HfMJebniQrrpA24l
         30zzrwT9zZERXLVV82YHpYyTJonahqVy0iiy3tyEx7rhfDAti3UqpsEl3CGxHKD/yN
         pYV0vNpztXBfdZ+NT7DJ1/MVaA2OdJv5EITxPExpC/llS4fTVyixcYgY+BmYuskfgg
         P6FomZHtpumt3Z79z3v0SCtv4RCQiH68A5iRL59OP9sRSjZI5gh5pGPaideDIcONAe
         0n1l702RHuwhw==
Message-ID: <dc4f7684-2bec-ece2-17bd-ecaaaa5d5c69@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 09:52:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
 <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
 <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
 <d10f18b4-56cf-8a55-b12f-79b1163d8841@alu.unizg.hr>
 <7f977a5d-8302-4a32-9dce-f6d7637b2555@t-8ch.de>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <7f977a5d-8302-4a32-9dce-f6d7637b2555@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

The good news is that the

"kobject: 'integrity' (000000001aa7f87a): does not have a release() function"

is now removed:

https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/fix/20230310_082429.jpg

On 3/10/23 00:26, Thomas Weißschuh wrote:
> On Thu, Mar 09, 2023 at 10:46:50PM +0100, Mirsad Goran Todorovac wrote:
>> On 09. 03. 2023. 22:23, Thomas Weißschuh wrote:
>>
>> Very well, but who then destroys the cache crated here:
>>
>> security/integrity/iint.c:177-179
>>> 177         iint_cache =
>>> 178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>>> 179                               0, SLAB_PANIC, init_once);
>>
>> I assumed that it must have been done from iint.c because iint_cache is
>> static?
> 
> It doesn't seem like anything destroys this cache.
> 
> I'm not sure this is a problem though as iint.c can not be built as module.

Maybe I was just scolded when I relied on exit() to do the memory deallocation
from heap automatically in userspace programs. :-/

I suppose this cache is destroyed when virtual Linux machine is shutdown.

Still, it might seem prudent for all of the objects to be destroyed before shutting
down the kernel, assuring the call of proper destructors, and in the right order.

> At least it's not a problem with kobjects as those are not used here.

I begin to understand.

security/integrity/iint.c:
175 static int __init integrity_iintcache_init(void)
176 {
177         iint_cache =
178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
179                               0, SLAB_PANIC, init_once);
180         return 0;
181 }
182 DEFINE_LSM(integrity) = {
183         .name = "integrity",
184         .init = integrity_iintcache_init,
185 };

and struct lsm_info

include/linux/lsm_hooks.h:
1721 struct lsm_info {
1722         const char *name;       /* Required. */
1723         enum lsm_order order;   /* Optional: default is LSM_ORDER_MUTABLE */
1724         unsigned long flags;    /* Optional: flags describing LSM */
1725         int *enabled;           /* Optional: controlled by CONFIG_LSM */
1726         int (*init)(void);      /* Required. */
1727         struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
1728 };

Here a proper destructor might be prudent to add.

Naive try could be like this:

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acffc..d5a6ab9b5eb2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1724,6 +1724,7 @@ struct lsm_info {
         unsigned long flags;    /* Optional: flags describing LSM */
         int *enabled;           /* Optional: controlled by CONFIG_LSM */
         int (*init)(void);      /* Required. */
+       int (*release)(void);   /* Release associated resources */
         struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
  };

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..3f69eb702b2e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -179,9 +179,16 @@ static int __init integrity_iintcache_init(void)
                               0, SLAB_PANIC, init_once);
         return 0;
  }
+
+static int __exit integrity_iintcache_release(void)
+{
+       kmem_cache_destroy(iint_cache);
+}
+
  DEFINE_LSM(integrity) = {
         .name = "integrity",
         .init = integrity_iintcache_init,
+       .release = integrity_iintcache_release,
  };

However, I lack insight of who should invoke .release() on 'integrity',
in 10.7 million lines of *.c and *.h files. Obviously, now no one is
expecting .release in LSM modules. But there might be a need for the
proper cleanup.

For it is not a kobject as you already observed? :-/

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
