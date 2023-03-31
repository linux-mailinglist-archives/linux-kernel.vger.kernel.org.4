Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70446D2958
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjCaUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjCaUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:23:41 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46E1A473;
        Fri, 31 Mar 2023 13:23:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 471C360515;
        Fri, 31 Mar 2023 22:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680294217; bh=RZ+rY79K5VQKo5KtBwXcs2KmE2OPkNmkQCcCyuwUy00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CoAHI5pQOU13t+4AGiKD/ZfLfBHhZpxHgeQ/hDEBEmSBADVF0fzfa9wyOdDW9YEik
         m3Wqnba0hpi7mYmjQvDr/ZAoETdwXHdWtMKsIUtmBTkmDoZb01oBy8lFrk7iYEFtl7
         3Gy28g214+cCty5mJCM0ieaB2vA36Sjvlu0f0RgTWHPKNiS3oNe6ceCZ90n06IjAz8
         ClCBDQwsIPqyJuG5MwDHZk1jCzppZb55j/BSGhT9xBvBT4yMAQxAf7FEqqT+thnbQe
         QRhDt5H27d1qORz+ZLa1ub8tCygbgvBiMC9H63QUX3VPmS8sZGny48wPex/+6uJQ12
         v+Q5YNBiTLmWQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id plt5PKoDAWVt; Fri, 31 Mar 2023 22:23:34 +0200 (CEST)
Received: from [192.168.1.4] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id 28CD260514;
        Fri, 31 Mar 2023 22:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680294214; bh=RZ+rY79K5VQKo5KtBwXcs2KmE2OPkNmkQCcCyuwUy00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O2gKb9mV9Pgl2qSp0CjM8lBcZ+LGdOY/KpRGwP5YN3UjU40KuTzbN05vhDn0sBtbV
         cxvgmGRY07w/GzPs9kseKlGpZ60h8Ibw5Haw00n7t+faQamQYdB4zk3CMIwypMijTP
         EUEO5kVgysMKjNW+kPyOrXEN31PEhppukaFrUMetr/TJQ+UAGtP94mQVkhZkAxcb4u
         aj7nKEtdggAung8KQSNzMb8QfTO/1aUym/QnqVl5nVI94qpccuZksWJ23lpuzNYnLQ
         5C5mFodYeq6OxEgyIAKzYiZLh7aoqAFrvw2xcCYVHBSa/5DufeiH8+C9iW//31mPQM
         w3PKvybqYvNFQ==
Message-ID: <baa37033-9b0c-5e40-41a9-bca0836c1330@alu.unizg.hr>
Date:   Fri, 31 Mar 2023 22:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] platform/x86: think-lmi: Fix memory leak when showing
 current settings
Content-Language: en-US, hr
To:     Armin Wolf <W_Armin@gmx.de>, markpearson@lenovo.com
Cc:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331180912.38392-1-W_Armin@gmx.de>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230331180912.38392-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 03. 2023. 20:09, Armin Wolf wrote:
> When retriving a item string with tlmi_setting(), the result has to be
> freed using kfree(). In current_value_show() however, malformed
> item strings are not freed, causing a memory leak.
> Fix this by eliminating the early return responsible for this.
> 
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr/T/#t
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - Add Reported-by: and Link: tags
> ---
>  drivers/platform/x86/think-lmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index cc66f7cbccf2..8cafb9d4016c 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>  	/* validate and split from `item,value` -> `value` */
>  	value = strpbrk(item, ",");
>  	if (!value || value == item || !strlen(value + 1))
> -		return -EINVAL;
> +		ret = -EINVAL;
> +	else
> +		ret = sysfs_emit(buf, "%s\n", value + 1);
> 
> -	ret = sysfs_emit(buf, "%s\n", value + 1);
>  	kfree(item);
> +
>  	return ret;
>  }
> 
> --
> 2.30.2

I can confirm that the test passed in the original environment that caused the kmemleak.

[root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak 
unreferenced object 0xffff8e614889e390 (size 16):
  comm "kworker/u12:5", pid 366, jiffies 4294896428 (age 93.704s)
  hex dump (first 16 bytes):
    6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
  backtrace:
    [<ffffffff860fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffff86102b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffff860773c9>] __kmalloc_node_track_caller+0x59/0x180
    [<ffffffff86066a1a>] kstrdup+0x3a/0x70
    [<ffffffff86066a8c>] kstrdup_const+0x2c/0x40
    [<ffffffff864a987c>] kvasprintf_const+0x7c/0xb0
    [<ffffffff86e3b427>] kobject_set_name_vargs+0x27/0xa0
    [<ffffffff8678ed17>] dev_set_name+0x57/0x80
    [<ffffffffc0e49f0f>] memstick_check+0x10f/0x3b0 [memstick]
    [<ffffffff85dcb4c0>] process_one_work+0x250/0x530
    [<ffffffff85dcb7f8>] worker_thread+0x48/0x3a0
    [<ffffffff85dd6dff>] kthread+0x10f/0x140
    [<ffffffff85c02fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff8e6158f93b90 (size 16):
  comm "kworker/u12:5", pid 366, jiffies 4294896433 (age 93.684s)
  hex dump (first 16 bytes):
    6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
  backtrace:
    [<ffffffff860fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffff86102b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffff860773c9>] __kmalloc_node_track_caller+0x59/0x180
    [<ffffffff86066a1a>] kstrdup+0x3a/0x70
    [<ffffffff86066a8c>] kstrdup_const+0x2c/0x40
    [<ffffffff864a987c>] kvasprintf_const+0x7c/0xb0
    [<ffffffff86e3b427>] kobject_set_name_vargs+0x27/0xa0
    [<ffffffff8678ed17>] dev_set_name+0x57/0x80
    [<ffffffffc0e49f0f>] memstick_check+0x10f/0x3b0 [memstick]
    [<ffffffff85dcb4c0>] process_one_work+0x250/0x530
    [<ffffffff85dcb7f8>] worker_thread+0x48/0x3a0
    [<ffffffff85dd6dff>] kthread+0x10f/0x140
    [<ffffffff85c02fa9>] ret_from_fork+0x29/0x50
[root@pc-mtodorov marvin]# uname -rms
Linux 6.3.0-rc4-00034-gfcd476ea6a88-dirty x86_64
[root@pc-mtodorov marvin]# 

NOTE: The leaks here belong to drivers/memstick/core/memstick.c leak for which I have
proposed a fix in message <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>.

This test was built on the 6.3-rc4+ commit fcd476ea6a88 Torvalds tree + the following
patches (Armin's, and Thomas's).

 drivers/platform/x86/think-lmi.c | 18 ++++++++++--------
 drivers/usb/host/xhci.c          |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index c816646eb661..c2146add88ab 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
        /* validate and split from `item,value` -> `value` */
        value = strpbrk(item, ",");
        if (!value || value == item || !strlen(value + 1))
-               return -EINVAL;
+               ret = -EINVAL;
+       else
+               ret = sysfs_emit(buf, "%s\n", value + 1);
 
-       ret = sysfs_emit(buf, "%s\n", value + 1);
        kfree(item);
+
        return ret;
 }
 
@@ -1380,7 +1382,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
 
 static int tlmi_analyze(void)
 {
-       acpi_status status;
        int i, ret;
 
        if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
@@ -1417,8 +1418,8 @@ static int tlmi_analyze(void)
                char *p;
 
                tlmi_priv.setting[i] = NULL;
-               status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
-               if (ACPI_FAILURE(status))
+               ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
+               if (ret)
                        break;
                if (!item)
                        break;
@@ -1457,10 +1458,10 @@ static int tlmi_analyze(void)
                         * name string.
                         * Try and pull that out if it's available.
                         */
-                       char *item, *optstart, *optend;
+                       char *optitem, *optstart, *optend;
 
-                       if (!tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
-                               optstart = strstr(item, "[Optional:");
+                       if (!tlmi_setting(setting->index, &optitem, LENOVO_BIOS_SETTING_GUID)) {
+                               optstart = strstr(optitem, "[Optional:");
                                if (optstart) {
                                        optstart += strlen("[Optional:");
                                        optend = strstr(optstart, "]");
@@ -1469,6 +1470,7 @@ static int tlmi_analyze(void)
                                                        kstrndup(optstart, optend - optstart,
                                                                        GFP_KERNEL);
                                }
+                               kfree(optitem);
                        }
                }
                /*
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6183ce8574b1..905f1e89ead8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4438,6 +4438,7 @@ static int __maybe_unused xhci_change_max_exit_latency(struct xhci_hcd *xhci,
 
        if (!virt_dev || max_exit_latency == virt_dev->current_mel) {
                spin_unlock_irqrestore(&xhci->lock, flags);
+               xhci_free_command(xhci, command);
                return 0;
        }
 
Xhci patch from Mathias is included because it is well tested and already submitted and acked.

At your convenience and according to the Code of Conduct, you can add:

Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Otherwise, Armin, I think you should submit this patch rightly because all idea to search in
think-lmi.c was yours.

Bisect was also much faster and in fewer steps.

Thanks,
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

