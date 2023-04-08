Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D676DBC1B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDHQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDHQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 12:14:59 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099ADB75E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 09:14:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 76DCD604F5;
        Sat,  8 Apr 2023 18:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680970492; bh=m6I3FynbHXPeYdEdsiaL4KiYvT6oNhq6ivVvpkzYf7M=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=NNA2nHkID1Pw5sDuSxExIqf8rDTij8+71lzhxTt5PQ2MlA7UQCpPJjp/xez8BszQj
         VdYH9cukfyHE2WhUELkAO0UrICqdRHqR1K5XDktYyIsboS888tFlxUwcNjMmEGidf0
         2rwfMkzJ1EY7wkr5dujt48sx2ECZiNXDjK53smIMWJwQmjIP4E4fuQDSa2bShmCKSL
         QxvHQSVqj0khWxjVRLxrv18BRdIOs55WdVdfASUgFBRnRwtRrFOKhu4j+9FGB46MIt
         seCF/+JFNqjtoO3HeNRw6gJvCnd5hYL+56Wn8FvrSl42Um4eAhep7ZyUAQJCHZDXR+
         nbyH3Eong7E8g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pzJRQOpnWSQY; Sat,  8 Apr 2023 18:14:49 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id 01977604ED;
        Sat,  8 Apr 2023 18:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680970489; bh=m6I3FynbHXPeYdEdsiaL4KiYvT6oNhq6ivVvpkzYf7M=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=DDC/v1Nn3l2ZVPGbQo9LVuCWMAYmFqVcTRPLylmLpT8E1EDhTG4RIdmoGUTsfPOSN
         1psT51mJB9jh7/YObC6Q9dNHMmsWJSHbKh1amv5bQdIKzW7lWf/WXCcmeZBQ23l+4O
         lu/7kpWJQSSuOIUtFwZNiw8KXWu3B6b4schOgzlePvS1NIgbPpCZDr+kKNim4PoedA
         x5eCNnVh24OuP5KX+ATwAQqEqIoW9R3Hwk821VYvCS0dZNqFs1DrbFmmtxYHv7IbuF
         GZJgeMcK8Bl2usRY6A3o33p4/rUyI4DHpT4cPgRNCGmeUI10rk85BcmkWXWQ5sVI29
         ZtBFqA3QbRkPg==
Message-ID: <1aecbf73-d0f7-27e4-667a-439fe9a912fa@alu.unizg.hr>
Date:   Sat, 8 Apr 2023 18:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] [FIXED] test_firmware: Fix some racing conditions
 in test_fw_config locking.
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
References: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
 <eb117a50-79ad-4f5a-8ad9-73247107469e@kili.mountain>
 <1f07fd79-b7db-9bd5-f281-8ba1ca71e195@alu.unizg.hr>
 <c1eda760-2ed1-4f42-b8bb-7e380e1adb3e@kili.mountain>
 <65bac38f-7934-4e79-0efc-43973dad0349@alu.unizg.hr>
 <6375e778-43e8-7cf7-4ddc-19771148ecdf@alu.unizg.hr>
In-Reply-To: <6375e778-43e8-7cf7-4ddc-19771148ecdf@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 04. 2023. 11:33, Mirsad Goran Todorovac wrote:
> On 07. 04. 2023. 23:08, Mirsad Goran Todorovac wrote:
>> On 07. 04. 2023. 11:03, Dan Carpenter wrote:
>>> On Fri, Apr 07, 2023 at 10:24:24AM +0200, Mirsad Goran Todorovac wrote:
>>>>
>>>> Hi Mr. Carpenter,
>>>>
>>>> Thank you for your review.
>>>>
>>>> I will proceed according to your guidelines and issue the next version of the
>>>> patch set.
>>>>
>>>> But I cannot promise it will be before the holidays - I do not want to make
>>>> the gods angry either ;-)
>>>>
>>>
>>> There is never a rush.
>>>
>>>> I cannot promise to try smart macros or inline functions with smart function
>>>> parameters just yet.
>>>>
>>>
>>> Don't worry about that.  It just seemed like you were working towards
>>> a more general purpose infrastructure.  It's just a clean up.
>>>
>>>> I would consider the real success if I hunt down the remaining leak and races
>>>> in this driver. Despite being considered a less important one.
>>>>
>>>> As you have previously asserted, it is not a real security issue with a CVE,
>>>> however, for completeness sake I would like to see these problems fixed.
>>>
>>> That's great.  If you get bored and feel like giving up then just send
>>> PATCH 2/2 by itself because that one could be merged as is.
>>
>> Hi Mr. Carpenter,
>>
>> Actually, I do not like to give up easily :-)
>>
>> I seem to be onto something:
>>
>> In drivers/base/firmware_loader/main.c:
>>
>>  202 static void __free_fw_priv(struct kref *ref)
>>  203         __releases(&fwc->lock)
>>  204 {
>>  205         struct fw_priv *fw_priv = to_fw_priv(ref);
>>  206         struct firmware_cache *fwc = fw_priv->fwc;
>>  207 
>>  208         pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
>>  209                  __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
>>  210                  (unsigned int)fw_priv->size);
>>  211 
>>  212         list_del(&fw_priv->list);
>>  213         spin_unlock(&fwc->lock);
>>  214 
>>  215         if (fw_is_paged_buf(fw_priv))
>>  216                 fw_free_paged_buf(fw_priv);
>>  217         else if (!fw_priv->allocated_size)
>>  218                 vfree(fw_priv->data);
>>  219 
>>  220         kfree_const(fw_priv->fw_name);
>>  221         kfree(fw_priv);
>>  222 }
>>
>> This deallocates fw_priv->data only if fpriv->allocated_size == 0
>>
>>  217         else if (!fw_priv->allocated_size)
>>  218                 vfree(fw_priv->data);
>>
>> However, this function:
>>
>>  112 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
>>  113                                           struct firmware_cache *fwc,
>>  114                                           void *dbuf,
>>  115                                           size_t size,
>>  116                                           size_t offset,
>>  117                                           u32 opt_flags)
>>  118 {
>>  119         struct fw_priv *fw_priv;
>>  120 
>>  121         /* For a partial read, the buffer must be preallocated. */
>>  122         if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
>>  123                 return NULL;
>>  124 
>>  125         /* Only partial reads are allowed to use an offset. */
>>  126         if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
>>  127                 return NULL;
>>  128 
>>  129         fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
>>  130         if (!fw_priv)
>>  131                 return NULL;
>>  132 
>>  133         fw_priv->fw_name = kstrdup_const(fw_name, GFP_ATOMIC);
>>  134         if (!fw_priv->fw_name) {
>>  135                 kfree(fw_priv);
>>  136                 return NULL;
>>  137         }
>>  138 
>>  139         kref_init(&fw_priv->ref);
>>  140         fw_priv->fwc = fwc;
>>  141         fw_priv->data = dbuf;
>>  142         fw_priv->allocated_size = size;
>>  143         fw_priv->offset = offset;
>>  144         fw_priv->opt_flags = opt_flags;
>>  145         fw_state_init(fw_priv);
>>  146 #ifdef CONFIG_FW_LOADER_USER_HELPER
>>  147         INIT_LIST_HEAD(&fw_priv->pending_list);
>>  148 #endif
>>  149 
>>  150         pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);
>>  151 
>>  152         return fw_priv;
>>  153 }
>>
>> Has both set:
>>
>>  141         fw_priv->data = dbuf;
>>  142         fw_priv->allocated_size = size;
>>
>> I suspect this could be the source of the leak?
>>
>> size in passed all the way down from
>>
>> request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
>> 			  struct device *device, void *buf, size_t size)
>>
>> It is sized test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL); which is
>>
>> #define TEST_FIRMWARE_BUF_SIZE	SZ_1K
>>
>> (the exact size of the leak: 1024 bytes)
>>
>> I did not dare to fix this, because in other contexts as xz_uncompress this
>> test allocated_size is used with different semantics, and I am not sure what
>> is the right way to fix this:
>>
>>  357         if (!fw_priv->allocated_size)
>>  358                 fw_priv->data = out_buf;
>>
>> so I would break this case.
>>
>> Possibly, the way of allocation and allocated_size could be separated?
>>
>> I did not expect the fix to go that deep into the kernel proper?
>>
>> Just to give you a progress report.
>>
>> I might even come up with a fix attempt, but not yet a formal patch I suppose.
> 
> P.S.
> 
> Apparently, AFAICS, in this context:
> 
> lib/test_firmware.c:lines 842-858:
> 		if (test_fw_config->partial)
> 			req->rc = request_partial_firmware_into_buf
> 						(&req->fw,
> 						 req->name,
> 						 req->dev,
> 						 test_buf,
> 						 test_fw_config->buf_size,
> 						 test_fw_config->file_offset);
> 		else
> 			req->rc = request_firmware_into_buf
> 						(&req->fw,
> 						 req->name,
> 						 req->dev,
> 						 test_buf,
> 						 test_fw_config->buf_size);
> 		if (!req->fw)
> 			kfree(test_buf);
> 
> we call
> 
> request_firmware_into_buf(&req->fw, req->name, req->dev, test_buf, test_fw_config->buf_size);
> 
> that calls drivers/base/firmware_loader/main.c:1035-1036:
> 
> 	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
> 				FW_OPT_UEVENT | FW_OPT_NOCACHE);
> 
> which calls line 814-815:
> 
> 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
> 					offset, opt_flags);
> 
> which calls line 748-749:
> 
> 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
> 				   offset, opt_flags);
> 
> which calls line 189:
> 
> 	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, opt_flags);
> 
> which does line 112-153:
> 
> static struct fw_priv *__allocate_fw_priv(const char *fw_name,
> 					  struct firmware_cache *fwc,
> 					  void *dbuf,
> 					  size_t size,
> 					  size_t offset,
> 					  u32 opt_flags)
> {
> 	struct fw_priv *fw_priv;
> 
> 	/* For a partial read, the buffer must be preallocated. */
> 	if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
> 		return NULL;
> 
> 	/* Only partial reads are allowed to use an offset. */
> 	if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
> 		return NULL;
> 
> 	fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
> 	if (!fw_priv)
> 		return NULL;
> 
> 	fw_priv->fw_name = kstrdup_const(fw_name, GFP_ATOMIC);
> 	if (!fw_priv->fw_name) {
> 		kfree(fw_priv);
> 		return NULL;
> 	}
> 
> 	kref_init(&fw_priv->ref);
> 	fw_priv->fwc = fwc;
> 	fw_priv->data = dbuf;
> 	fw_priv->allocated_size = size;
> 	fw_priv->offset = offset;
> 	fw_priv->opt_flags = opt_flags;
> 	fw_state_init(fw_priv);
> #ifdef CONFIG_FW_LOADER_USER_HELPER
> 	INIT_LIST_HEAD(&fw_priv->pending_list);
> #endif
> 
> 	pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);
> 
> 	return fw_priv;
> }
> 
> Now, fw_priv->data is set to test_buf, fw_priv->allocated_size is set to test_fw_config->buf_size.
> 
> When release_firmware(fw) is called, it calls in line drivers/base/firmware_loader/main.c:1081:
> 
> firmware_free_data(fw) which calls lines 582-591:
> 
> /* firmware holds the ownership of pages */
> static void firmware_free_data(const struct firmware *fw)
> {
> 	/* Loaded directly? */
> 	if (!fw->priv) {
> 		vfree(fw->data);
> 		return;
> 	}
> 	free_fw_priv(fw->priv);
> }
> 
> fw_priv is allocated in line 129 of drivers/base/firmware_loader/main.c:
> 
> 	fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
> 
> so vfree(fw->data) is not called.
> 
> free_fw_priv(fw->priv) is in lines 224-230:
> 
> void free_fw_priv(struct fw_priv *fw_priv)
> {
> 	struct firmware_cache *fwc = fw_priv->fwc;
> 	spin_lock(&fwc->lock);
> 	if (!kref_put(&fw_priv->ref, __free_fw_priv))
> 		spin_unlock(&fwc->lock);
> }
> 
> which calls __free_fw_priv(struct kref *ref), lines 202-222:
> 
> static void __free_fw_priv(struct kref *ref)
> 	__releases(&fwc->lock)
> {
> 	struct fw_priv *fw_priv = to_fw_priv(ref);
> 	struct firmware_cache *fwc = fw_priv->fwc;
> 
> 	pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
> 		 __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
> 		 (unsigned int)fw_priv->size);
> 
> 	list_del(&fw_priv->list);
> 	spin_unlock(&fwc->lock);
> 
> 	if (fw_is_paged_buf(fw_priv))
> 		fw_free_paged_buf(fw_priv);
> 	else if (!fw_priv->allocated_size)
> 		vfree(fw_priv->data);
> 
> 	kfree_const(fw_priv->fw_name);
> 	kfree(fw_priv);
> }
> 
> This has this construct:
> 
> 215	if (fw_is_paged_buf(fw_priv))
> 216		fw_free_paged_buf(fw_priv);
> 217	else if (!fw_priv->allocated_size)
> 218		vfree(fw_priv->data);
> 
> but as fw->priv was set to test_fw_config->buf_size with the line
> 
> 141	fw_priv->data = dbuf;
> 142	fw_priv->allocated_size = size;
> 
> apparently vfree(fw_priv->data) is never being called for the firmware loaded
> with
> 
> 	req-rc = request_firmware_into_buf(&req->fw, req->name, req->dev, test_buf,
> 					   test_fw_config->buf_size);
> 
> so IMHO we need to release it on the side of the caller, for this is what causes
> the leaks sized test_fw_config->buf_size = TEST_FIRMWARE_BUF_SIZE where
> 
> TEST_FIRMWARE_BUF_SIZE is
> 
> #define TEST_FIRMWARE_BUF_SIZE	SZ_1K
> 
> that is, the actual size of the memleaks:
> 
> unreferenced object 0xffff9e011c39f000 (size 1024):
>   comm "test_firmware-2", pid 27646, jiffies 4302559254 (age 466.216s)
>   hex dump (first 32 bytes):
>     45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff9390d59c>] slab_post_alloc_hook+0x8c/0x4f0
>     [<ffffffff93914a69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>     [<ffffffff93883a9e>] kmalloc_trace+0x2e/0xc0
>     [<ffffffff93cd1760>] test_fw_run_batch_request+0x90/0x170
>     [<ffffffff935d901a>] kthread+0x11a/0x150
>     [<ffffffff93402fc9>] ret_from_fork+0x29/0x50
> 
> (71-73 of them per run of tools/testing/selftest/firmware/fw_filesystem.sh)
> 
> I hope this helps.

This analysis really helped, and while waiting for the reply I have actually came upon
a fix:

(This v4 probably needs some style changes, as much as I tried to blend in the present
code ...).

---
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..1d7d480b8eeb 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -45,6 +45,7 @@ struct test_batched_req {
        bool sent;
        const struct firmware *fw;
        const char *name;
+       const char *fw_buf;
        struct completion completion;
        struct task_struct *task;
        struct device *dev;
@@ -175,8 +176,14 @@ static void __test_release_all_firmware(void)
 
        for (i = 0; i < test_fw_config->num_requests; i++) {
                req = &test_fw_config->reqs[i];
-               if (req->fw)
+               if (req->fw) {
+                       if (req->fw_buf) {
+                               kfree_const(req->fw_buf);
+                               req->fw_buf = NULL;
+                       }
                        release_firmware(req->fw);
+                       req->fw = NULL;
+               }
        }
 
        vfree(test_fw_config->reqs);
@@ -353,16 +360,26 @@ static ssize_t config_test_show_str(char *dst,
        return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
                                       bool *cfg)
 {
        int ret;
 
-       mutex_lock(&test_fw_mutex);
        if (kstrtobool(buf, cfg) < 0)
                ret = -EINVAL;
        else
                ret = size;
+
+       return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+                                      bool *cfg)
+{
+       int ret;
+
+       mutex_lock(&test_fw_mutex);
+       ret = __test_dev_config_update_bool(buf, size, cfg);
        mutex_unlock(&test_fw_mutex);
 
        return ret;
@@ -373,7 +390,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
        return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+                                        const char *buf,
                                         size_t size,
                                         size_t *cfg)
 {
@@ -384,9 +402,7 @@ static int test_dev_config_update_size_t(const char *buf,
        if (ret)
                return ret;
 
-       mutex_lock(&test_fw_mutex);
        *(size_t *)cfg = new;
-       mutex_unlock(&test_fw_mutex);
 
        /* Always return full write size even if we didn't consume all */
        return size;
@@ -402,7 +418,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
        return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
        u8 val;
        int ret;
@@ -411,14 +427,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
        if (ret)
                return ret;
 
-       mutex_lock(&test_fw_mutex);
        *(u8 *)cfg = val;
-       mutex_unlock(&test_fw_mutex);
 
        /* Always return full write size even if we didn't consume all */
        return size;
 }
 
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+       int ret;
+
+       mutex_lock(&test_fw_mutex);
+       ret = __test_dev_config_update_u8(buf, size, cfg);
+       mutex_unlock(&test_fw_mutex);
+
+       return ret;
+}
+
 static ssize_t test_dev_config_show_u8(char *buf, u8 val)
 {
        return snprintf(buf, PAGE_SIZE, "%u\n", val);
@@ -471,10 +496,10 @@ static ssize_t config_num_requests_store(struct device *dev,
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
-       mutex_unlock(&test_fw_mutex);
 
-       rc = test_dev_config_update_u8(buf, count,
-                                      &test_fw_config->num_requests);
+       rc = __test_dev_config_update_u8(buf, count,
+                                        &test_fw_config->num_requests);
+       mutex_unlock(&test_fw_mutex);
 
 out:
        return rc;
@@ -518,10 +543,10 @@ static ssize_t config_buf_size_store(struct device *dev,
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
-       mutex_unlock(&test_fw_mutex);
 
-       rc = test_dev_config_update_size_t(buf, count,
-                                          &test_fw_config->buf_size);
+       rc = __test_dev_config_update_size_t(buf, count,
+                                            &test_fw_config->buf_size);
+       mutex_unlock(&test_fw_mutex);
 
 out:
        return rc;
@@ -548,10 +573,10 @@ static ssize_t config_file_offset_store(struct device *dev,
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
-       mutex_unlock(&test_fw_mutex);
 
-       rc = test_dev_config_update_size_t(buf, count,
-                                          &test_fw_config->file_offset);
+       rc = __test_dev_config_update_size_t(buf, count,
+                                            &test_fw_config->file_offset);
+       mutex_unlock(&test_fw_mutex);
 
 out:
        return rc;
@@ -652,6 +677,8 @@ static ssize_t trigger_request_store(struct device *dev,
 
        mutex_lock(&test_fw_mutex);
        release_firmware(test_firmware);
+       if (test_fw_config->reqs)
+               __test_release_all_firmware();
        test_firmware = NULL;
        rc = request_firmware(&test_firmware, name, dev);
        if (rc) {
@@ -752,6 +779,8 @@ static ssize_t trigger_async_request_store(struct device *dev,
        mutex_lock(&test_fw_mutex);
        release_firmware(test_firmware);
        test_firmware = NULL;
+       if (test_fw_config->reqs)
+               __test_release_all_firmware();
        rc = request_firmware_nowait(THIS_MODULE, 1, name, dev, GFP_KERNEL,
                                     NULL, trigger_async_request_cb);
        if (rc) {
@@ -794,6 +823,8 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
        mutex_lock(&test_fw_mutex);
        release_firmware(test_firmware);
+       if (test_fw_config->reqs)
+               __test_release_all_firmware();
        test_firmware = NULL;
        rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOUEVENT, name,
                                     dev, GFP_KERNEL, NULL,
@@ -856,6 +887,8 @@ static int test_fw_run_batch_request(void *data)
                                                 test_fw_config->buf_size);
                if (!req->fw)
                        kfree(test_buf);
+               else
+                       req->fw_buf = test_buf;
        } else {
                req->rc = test_fw_config->req_firmware(&req->fw,
                                                       req->name,
@@ -895,6 +928,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
        mutex_lock(&test_fw_mutex);
 
+       if (test_fw_config->reqs) {
+               rc = -EBUSY;
+               goto out_bail;
+       }
+
        test_fw_config->reqs =
                vzalloc(array3_size(sizeof(struct test_batched_req),
                                    test_fw_config->num_requests, 2));
@@ -911,6 +949,7 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
                req->fw = NULL;
                req->idx = i;
                req->name = test_fw_config->name;
+               req->fw_buf = NULL;
                req->dev = dev;
                init_completion(&req->completion);
                req->task = kthread_run(test_fw_run_batch_request, req,
@@ -993,6 +1032,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
        mutex_lock(&test_fw_mutex);
 
+       if (test_fw_config->reqs) {
+               rc = -EBUSY;
+               goto out_bail;
+       }
+
        test_fw_config->reqs =
                vzalloc(array3_size(sizeof(struct test_batched_req),
                                    test_fw_config->num_requests, 2));
@@ -1010,6 +1054,7 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
        for (i = 0; i < test_fw_config->num_requests; i++) {
                req = &test_fw_config->reqs[i];
                req->name = test_fw_config->name;
+               req->fw_buf = NULL;
                req->fw = NULL;
                req->idx = i;
                init_completion(&req->completion);
--

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

