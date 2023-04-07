Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7412B6DB5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDGVI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDGVI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:08:27 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC79EC1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:08:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BF890604F6;
        Fri,  7 Apr 2023 23:08:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680901702; bh=egfXuoS/aVFNj9dlzmZi7nNmywavawdgQD7FkAh+/w0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eIt8w/pmtDdOlnDVHOzKsnX0My453Pfp3JCb/U+sBtooSjsh2tyNfT6jumX4Ie3IT
         fKfe+XgrWoCQY1GSzmakWIJ+hsl0VoV3c48ijjoAooR5vUOFZW5SF1uOIh4EGdrGL6
         1dCWDCnzRVR5pqSP2YatgoTsrrGOqIVi9/TC/0ftdGekB2OrxJvt4iYHxU1ofUpzZw
         ww6tFzjDV/RylcOklAIuaKYFKP8cCdhKQTHY/qID942oNUwYuDYpxcqiXXTmF4pyXv
         aNvLgeZIaM51Lh9VfFRkxpDyW95vA7iPainkerEMNX3GExSrnESbpTH3qVemS6MfF9
         yQdPHYfPg5Eyw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U1WrvBVg8sWr; Fri,  7 Apr 2023 23:08:20 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id 8DA35604F5;
        Fri,  7 Apr 2023 23:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680901700; bh=egfXuoS/aVFNj9dlzmZi7nNmywavawdgQD7FkAh+/w0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bc/uXOKzNK6eOTILJhE6RqgvQ552KrgTkkM9kfhCeGp9aGZUbqvW7x02juNu6Tyza
         MMOqeL5GvGsraf5wWkji7DJAXbjesv2KCf4/d3PTJv0M6oMI6Sh3f+mkK8eDL3vHFT
         oEjvomYSH7G5+QVUN8NAEXD7HudrxdqAOfZYcVe1kaNf8UNoHnv3y7Iw8KR0+vENHA
         FUF6WlR13w+GeD8PIzpEYbp4A4DgyvNk3iIZiTy+5rTuayR11woZTqOo//SYbWtnE4
         ne6UjGlxJ2ht7DEiqkG9x1PLqaYpcMyja4xnKAzcosqPk1GXkwqb261UGBLi8hraR5
         O7LDIWlTDaaag==
Message-ID: <65bac38f-7934-4e79-0efc-43973dad0349@alu.unizg.hr>
Date:   Fri, 7 Apr 2023 23:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] test_firmware: Fix some racing conditions in
 test_fw_config locking.
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
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <c1eda760-2ed1-4f42-b8bb-7e380e1adb3e@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 04. 2023. 11:03, Dan Carpenter wrote:
> On Fri, Apr 07, 2023 at 10:24:24AM +0200, Mirsad Goran Todorovac wrote:
>>
>> Hi Mr. Carpenter,
>>
>> Thank you for your review.
>>
>> I will proceed according to your guidelines and issue the next version of the
>> patch set.
>>
>> But I cannot promise it will be before the holidays - I do not want to make
>> the gods angry either ;-)
>>
> 
> There is never a rush.
> 
>> I cannot promise to try smart macros or inline functions with smart function
>> parameters just yet.
>>
> 
> Don't worry about that.  It just seemed like you were working towards
> a more general purpose infrastructure.  It's just a clean up.
> 
>> I would consider the real success if I hunt down the remaining leak and races
>> in this driver. Despite being considered a less important one.
>>
>> As you have previously asserted, it is not a real security issue with a CVE,
>> however, for completeness sake I would like to see these problems fixed.
> 
> That's great.  If you get bored and feel like giving up then just send
> PATCH 2/2 by itself because that one could be merged as is.

Hi Mr. Carpenter,

Actually, I do not like to give up easily :-)

I seem to be onto something:

In drivers/base/firmware_loader/main.c:

 202 static void __free_fw_priv(struct kref *ref)
 203         __releases(&fwc->lock)
 204 {
 205         struct fw_priv *fw_priv = to_fw_priv(ref);
 206         struct firmware_cache *fwc = fw_priv->fwc;
 207 
 208         pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
 209                  __func__, fw_priv->fw_name, fw_priv, fw_priv->data,
 210                  (unsigned int)fw_priv->size);
 211 
 212         list_del(&fw_priv->list);
 213         spin_unlock(&fwc->lock);
 214 
 215         if (fw_is_paged_buf(fw_priv))
 216                 fw_free_paged_buf(fw_priv);
 217         else if (!fw_priv->allocated_size)
 218                 vfree(fw_priv->data);
 219 
 220         kfree_const(fw_priv->fw_name);
 221         kfree(fw_priv);
 222 }

This deallocates fw_priv->data only if fpriv->allocated_size == 0

 217         else if (!fw_priv->allocated_size)
 218                 vfree(fw_priv->data);

However, this function:

 112 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 113                                           struct firmware_cache *fwc,
 114                                           void *dbuf,
 115                                           size_t size,
 116                                           size_t offset,
 117                                           u32 opt_flags)
 118 {
 119         struct fw_priv *fw_priv;
 120 
 121         /* For a partial read, the buffer must be preallocated. */
 122         if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
 123                 return NULL;
 124 
 125         /* Only partial reads are allowed to use an offset. */
 126         if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
 127                 return NULL;
 128 
 129         fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
 130         if (!fw_priv)
 131                 return NULL;
 132 
 133         fw_priv->fw_name = kstrdup_const(fw_name, GFP_ATOMIC);
 134         if (!fw_priv->fw_name) {
 135                 kfree(fw_priv);
 136                 return NULL;
 137         }
 138 
 139         kref_init(&fw_priv->ref);
 140         fw_priv->fwc = fwc;
 141         fw_priv->data = dbuf;
 142         fw_priv->allocated_size = size;
 143         fw_priv->offset = offset;
 144         fw_priv->opt_flags = opt_flags;
 145         fw_state_init(fw_priv);
 146 #ifdef CONFIG_FW_LOADER_USER_HELPER
 147         INIT_LIST_HEAD(&fw_priv->pending_list);
 148 #endif
 149 
 150         pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);
 151 
 152         return fw_priv;
 153 }

Has both set:

 141         fw_priv->data = dbuf;
 142         fw_priv->allocated_size = size;

I suspect this could be the source of the leak?

size in passed all the way down from

request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
			  struct device *device, void *buf, size_t size)

It is sized test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL); which is

#define TEST_FIRMWARE_BUF_SIZE	SZ_1K

(the exact size of the leak: 1024 bytes)

I did not dare to fix this, because in other contexts as xz_uncompress this
test allocated_size is used with different semantics, and I am not sure what
is the right way to fix this:

 357         if (!fw_priv->allocated_size)
 358                 fw_priv->data = out_buf;

so I would break this case.

Possibly, the way of allocation and allocated_size could be separated?

I did not expect the fix to go that deep into the kernel proper?

Just to give you a progress report.

I might even come up with a fix attempt, but not yet a formal patch I suppose.

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

