Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C66D28B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCaTeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCaTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:34:29 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D783C1F;
        Fri, 31 Mar 2023 12:34:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5A08560515;
        Fri, 31 Mar 2023 21:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680291266; bh=uahcBWy7Ha1o3rDHhVUuQzjC/2eNTtyiZ77WUZ7/CQk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0sf5aJaOOutkDAwu16mvP0kWtPvozjVJu3GWpzUImF0Q45J/CizW/FQCnGQ3/wChT
         +szdQv/1FEH5wc5nRScBzdiznWHWCS9KruYGyguDWojNu05TKLWoIaiwhaC65rjge7
         H4e95mBXjABXWmRhJX319o9SBsHXHPF0PTxj1YpagkXcj76T6ys1k/sX3EGm+Ab/M6
         WMDaRID9sdqeb9J8huptjV0q5ivZJyTQzF8RjbDzxhXYZ8aK5AHOj14NRy7iOtf7QE
         1Sh7NjTnOhvTFMONyzLj1q+CcPmVCDaLvca3RAqDwVhmX7OBm3r9K/+MzEdQJbZ/WH
         jIw4oomoiQDqw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YehviXHhkPW8; Fri, 31 Mar 2023 21:34:23 +0200 (CEST)
Received: from [192.168.1.4] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id 57AC460514;
        Fri, 31 Mar 2023 21:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680291263; bh=uahcBWy7Ha1o3rDHhVUuQzjC/2eNTtyiZ77WUZ7/CQk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bUg1krQ6Ndlr0yv0imrxGs/BpHk+QIk1SwTAZUDqiZHUMq1fb3cn8hCgkDsTj02qg
         2quIRtWj22y7V1HY7HL6mw/ck7MnHo65n0R70xcfQrR6HLllqVf3NdhRS9fndDs22W
         v720vDrWtxm8L3XrOUuMuKhv8lU9G5fyThd3nmDE94L0d/C7C/mOct1jX3cnNwuN2y
         GciXQVx1W9Ln1XFq9fA5XdBQbLrHlIeEmOQpg1kwsnw7iuVqs6r8WvmVAuJXK6DNAC
         pNDDEDs0drh8cbdHvGqwhuG0A90fyaxKuiRyFtM1gKzXJA0vNny/5NL1NwgvqdvmyH
         p4WI+j2kNeGbQ==
Message-ID: <b166ae90-3878-061d-4bda-6de214c63ca0@alu.unizg.hr>
Date:   Fri, 31 Mar 2023 21:34:22 +0200
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

Hi, Armin,

You might have wanted it to be tested in the original setting?

Should this patch work as a standalone fix, without the others?

This part:

@@ -929,8 +929,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a

        /* validate and split from `item,value` -> `value` */
        value = strpbrk(item, ",");
-       if (!value || value == item || !strlen(value + 1))
+       if (!value || value == item || !strlen(value + 1)) {
+               kfree(item);
                return -EINVAL;
+       }

        ret = sysfs_emit(buf, "%s\n", value + 1);
        kfree(item);

was apparently superseded.

Should this one be applied? I guess it should, as I stated in email
<4dc118c2-0dde-bd5e-ea41-427ed33e4545@alu.unizg.hr> from 2023-03-29 20:49 UTC+02:

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

If Mark had found a better fix, then that one goes away, too.

NOTE PLEASE that in the above-mentioned message (like all the others) I just specified the
commit at which the test kernel was built + all the applied patches (git diff did not give
authors).

This did not imply that I claim Mr. Weißschuh's fix for tlmi_analyze() return, God forbid!
I apologise if I made room for such an impression.

That's all, I think. Thank Heavens. God bless!

I will assume the test build on the bottom patch + the Thomas's patch still apply + your patch.

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

