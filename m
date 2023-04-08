Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870BA6DB9DD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDHJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjDHJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:33:34 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B2C642
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 02:33:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8DCC1604F2;
        Sat,  8 Apr 2023 11:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680946406; bh=9qY63Pb2f3dgMyT3wEGvktfQukQgL9RMQfUt+8E0LJQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=HBWH/Z0MMe5JgBrDRNLkRKfSb7Ul6V692F/u77uJp8BGg5S0nM7hspmK9rrCS/Ei4
         4OiZXjNY8kge8VbC19Vmz42/skqfqDTYY3C7Ax6NFFk5GreJt1juuRhbV4gge/QUDZ
         /oJhLIX9Ol2NHkgWnAeWyEjzgwLiBezyDEawqZ1cnJuLSr/upZtWb/YuTxOY0xG3GU
         KFIUIAW2r1ERVuod6dcGqbxfrbvHtOlytMpEcVr6fQP0dnq/IgAGXLq1oFaB0UBAgB
         ja1iQtDEPFfwFL8SK+HNGLOVc3LbiAMzysLWLXEhFUxWQVOWX/P4AQk0bnwbA6zAdE
         A2ht5wos8bdUA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pj4PlDsxeA12; Sat,  8 Apr 2023 11:33:23 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id 92587604ED;
        Sat,  8 Apr 2023 11:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680946403; bh=9qY63Pb2f3dgMyT3wEGvktfQukQgL9RMQfUt+8E0LJQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=k01v9ZO/B7zNlABkMUPRWlJALEl+KIkElb9O6PDMIqA2ywZ3nd8ihbdyNDI5sVZTB
         O5Tz1y1u6xce+ldD/B3InLjfCpavYJ9qUh2s5dYaKdtWjMBAHQaNB4vTeb1gUGutml
         UFRCzrfSLyzyV6qxPlmQNk/W2p7/ypVZ/NZGJSlfgxrzAnR8dkYdwThWsXrYN8Vt14
         s1XBaC7/zJ6o8QojwcJUOM+HMQmkOO8oVyYr/42teFjqsfwNfWHtuk6CSakWjfvQIB
         pV7U2W8yMngGEgRg918k2wIPmakzi6WIj3KMhSj40RKh8ABZNfITXTggoRhA75nmLU
         vA58VvBm+CXNg==
Message-ID: <6375e778-43e8-7cf7-4ddc-19771148ecdf@alu.unizg.hr>
Date:   Sat, 8 Apr 2023 11:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] test_firmware: Fix some racing conditions in
 test_fw_config locking.
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
In-Reply-To: <65bac38f-7934-4e79-0efc-43973dad0349@alu.unizg.hr>
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

On 07. 04. 2023. 23:08, Mirsad Goran Todorovac wrote:
> On 07. 04. 2023. 11:03, Dan Carpenter wrote:
>> On Fri, Apr 07, 2023 at 10:24:24AM +0200, Mirsad Goran Todorovac wrote:
>>>
>>> Hi Mr. Carpenter,
>>>
>>> Thank you for your review.
>>>
>>> I will proceed according to your guidelines and issue the next version of the
>>> patch set.
>>>
>>> But I cannot promise it will be before the holidays - I do not want to make
>>> the gods angry either ;-)
>>>
>>
>> There is never a rush.
>>
>>> I cannot promise to try smart macros or inline functions with smart function
>>> parameters just yet.
>>>
>>
>> Don't worry about that.  It just seemed like you were working towards
>> a more general purpose infrastructure.  It's just a clean up.
>>
>>> I would consider the real success if I hunt down the remaining leak and races
>>> in this driver. Despite being considered a less important one.
>>>
>>> As you have previously asserted, it is not a real security issue with a CVE,
>>> however, for completeness sake I would like to see these problems fixed.
>>
>> That's great.  If you get bored and feel like giving up then just send
>> PATCH 2/2 by itself because that one could be merged as is.
> 
> Hi Mr. Carpenter,
> 
> Actually, I do not like to give up easily :-)
> 
> I seem to be onto something:
> 
> In drivers/base/firmware_loader/main.c:
> 
>  202 static void __free_fw_priv(struct kref *ref)
>  203         __releases(&fwc->lock)
>  204 {
>  205         struct fw_priv *fw_priv = to_fw_priv(ref);
>  206         struct firmware_cache *fwc = fw_priv->fwc;
>  207 
>  208         pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
>  209                  __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
>  210                  (unsigned int)fw_priv->size);
>  211 
>  212         list_del(&fw_priv->list);
>  213         spin_unlock(&fwc->lock);
>  214 
>  215         if (fw_is_paged_buf(fw_priv))
>  216                 fw_free_paged_buf(fw_priv);
>  217         else if (!fw_priv->allocated_size)
>  218                 vfree(fw_priv->data);
>  219 
>  220         kfree_const(fw_priv->fw_name);
>  221         kfree(fw_priv);
>  222 }
> 
> This deallocates fw_priv->data only if fpriv->allocated_size == 0
> 
>  217         else if (!fw_priv->allocated_size)
>  218                 vfree(fw_priv->data);
> 
> However, this function:
> 
>  112 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
>  113                                           struct firmware_cache *fwc,
>  114                                           void *dbuf,
>  115                                           size_t size,
>  116                                           size_t offset,
>  117                                           u32 opt_flags)
>  118 {
>  119         struct fw_priv *fw_priv;
>  120 
>  121         /* For a partial read, the buffer must be preallocated. */
>  122         if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
>  123                 return NULL;
>  124 
>  125         /* Only partial reads are allowed to use an offset. */
>  126         if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
>  127                 return NULL;
>  128 
>  129         fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
>  130         if (!fw_priv)
>  131                 return NULL;
>  132 
>  133         fw_priv->fw_name = kstrdup_const(fw_name, GFP_ATOMIC);
>  134         if (!fw_priv->fw_name) {
>  135                 kfree(fw_priv);
>  136                 return NULL;
>  137         }
>  138 
>  139         kref_init(&fw_priv->ref);
>  140         fw_priv->fwc = fwc;
>  141         fw_priv->data = dbuf;
>  142         fw_priv->allocated_size = size;
>  143         fw_priv->offset = offset;
>  144         fw_priv->opt_flags = opt_flags;
>  145         fw_state_init(fw_priv);
>  146 #ifdef CONFIG_FW_LOADER_USER_HELPER
>  147         INIT_LIST_HEAD(&fw_priv->pending_list);
>  148 #endif
>  149 
>  150         pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);
>  151 
>  152         return fw_priv;
>  153 }
> 
> Has both set:
> 
>  141         fw_priv->data = dbuf;
>  142         fw_priv->allocated_size = size;
> 
> I suspect this could be the source of the leak?
> 
> size in passed all the way down from
> 
> request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
> 			  struct device *device, void *buf, size_t size)
> 
> It is sized test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL); which is
> 
> #define TEST_FIRMWARE_BUF_SIZE	SZ_1K
> 
> (the exact size of the leak: 1024 bytes)
> 
> I did not dare to fix this, because in other contexts as xz_uncompress this
> test allocated_size is used with different semantics, and I am not sure what
> is the right way to fix this:
> 
>  357         if (!fw_priv->allocated_size)
>  358                 fw_priv->data = out_buf;
> 
> so I would break this case.
> 
> Possibly, the way of allocation and allocated_size could be separated?
> 
> I did not expect the fix to go that deep into the kernel proper?
> 
> Just to give you a progress report.
> 
> I might even come up with a fix attempt, but not yet a formal patch I suppose.

P.S.

Apparently, AFAICS, in this context:

lib/test_firmware.c:lines 842-858:
		if (test_fw_config->partial)
			req->rc = request_partial_firmware_into_buf
						(&req->fw,
						 req->name,
						 req->dev,
						 test_buf,
						 test_fw_config->buf_size,
						 test_fw_config->file_offset);
		else
			req->rc = request_firmware_into_buf
						(&req->fw,
						 req->name,
						 req->dev,
						 test_buf,
						 test_fw_config->buf_size);
		if (!req->fw)
			kfree(test_buf);

we call

request_firmware_into_buf(&req->fw, req->name, req->dev, test_buf, test_fw_config->buf_size);

that calls drivers/base/firmware_loader/main.c:1035-1036:

	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
				FW_OPT_UEVENT | FW_OPT_NOCACHE);

which calls line 814-815:

	ret = _request_firmware_prepare(&fw, name, device, buf, size,
					offset, opt_flags);

which calls line 748-749:

	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
				   offset, opt_flags);

which calls line 189:

	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, opt_flags);

which does line 112-153:

static struct fw_priv *__allocate_fw_priv(const char *fw_name,
					  struct firmware_cache *fwc,
					  void *dbuf,
					  size_t size,
					  size_t offset,
					  u32 opt_flags)
{
	struct fw_priv *fw_priv;

	/* For a partial read, the buffer must be preallocated. */
	if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
		return NULL;

	/* Only partial reads are allowed to use an offset. */
	if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
		return NULL;

	fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
	if (!fw_priv)
		return NULL;

	fw_priv->fw_name = kstrdup_const(fw_name, GFP_ATOMIC);
	if (!fw_priv->fw_name) {
		kfree(fw_priv);
		return NULL;
	}

	kref_init(&fw_priv->ref);
	fw_priv->fwc = fwc;
	fw_priv->data = dbuf;
	fw_priv->allocated_size = size;
	fw_priv->offset = offset;
	fw_priv->opt_flags = opt_flags;
	fw_state_init(fw_priv);
#ifdef CONFIG_FW_LOADER_USER_HELPER
	INIT_LIST_HEAD(&fw_priv->pending_list);
#endif

	pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);

	return fw_priv;
}

Now, fw_priv->data is set to test_buf, fw_priv->allocated_size is set to test_fw_config->buf_size.

When release_firmware(fw) is called, it calls in line drivers/base/firmware_loader/main.c:1081:

firmware_free_data(fw) which calls lines 582-591:

/* firmware holds the ownership of pages */
static void firmware_free_data(const struct firmware *fw)
{
	/* Loaded directly? */
	if (!fw->priv) {
		vfree(fw->data);
		return;
	}
	free_fw_priv(fw->priv);
}

fw_priv is allocated in line 129 of drivers/base/firmware_loader/main.c:

	fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);

so vfree(fw->data) is not called.

free_fw_priv(fw->priv) is in lines 224-230:

void free_fw_priv(struct fw_priv *fw_priv)
{
	struct firmware_cache *fwc = fw_priv->fwc;
	spin_lock(&fwc->lock);
	if (!kref_put(&fw_priv->ref, __free_fw_priv))
		spin_unlock(&fwc->lock);
}

which calls __free_fw_priv(struct kref *ref), lines 202-222:

static void __free_fw_priv(struct kref *ref)
	__releases(&fwc->lock)
{
	struct fw_priv *fw_priv = to_fw_priv(ref);
	struct firmware_cache *fwc = fw_priv->fwc;

	pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
		 __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
		 (unsigned int)fw_priv->size);

	list_del(&fw_priv->list);
	spin_unlock(&fwc->lock);

	if (fw_is_paged_buf(fw_priv))
		fw_free_paged_buf(fw_priv);
	else if (!fw_priv->allocated_size)
		vfree(fw_priv->data);

	kfree_const(fw_priv->fw_name);
	kfree(fw_priv);
}

This has this construct:

215	if (fw_is_paged_buf(fw_priv))
216		fw_free_paged_buf(fw_priv);
217	else if (!fw_priv->allocated_size)
218		vfree(fw_priv->data);

but as fw->priv was set to test_fw_config->buf_size with the line

141	fw_priv->data = dbuf;
142	fw_priv->allocated_size = size;

apparently vfree(fw_priv->data) is never being called for the firmware loaded
with

	req-rc = request_firmware_into_buf(&req->fw, req->name, req->dev, test_buf,
					   test_fw_config->buf_size);

so IMHO we need to release it on the side of the caller, for this is what causes
the leaks sized test_fw_config->buf_size = TEST_FIRMWARE_BUF_SIZE where

TEST_FIRMWARE_BUF_SIZE is

#define TEST_FIRMWARE_BUF_SIZE	SZ_1K

that is, the actual size of the memleaks:

unreferenced object 0xffff9e011c39f000 (size 1024):
  comm "test_firmware-2", pid 27646, jiffies 4302559254 (age 466.216s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff9390d59c>] slab_post_alloc_hook+0x8c/0x4f0
    [<ffffffff93914a69>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffff93883a9e>] kmalloc_trace+0x2e/0xc0
    [<ffffffff93cd1760>] test_fw_run_batch_request+0x90/0x170
    [<ffffffff935d901a>] kthread+0x11a/0x150
    [<ffffffff93402fc9>] ret_from_fork+0x29/0x50

(71-73 of them per run of tools/testing/selftest/firmware/fw_filesystem.sh)

I hope this helps.

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

