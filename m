Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3508662752
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjAINjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbjAINif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:38:35 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28243D84
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:36:22 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id AA9A5A0040;
        Mon,  9 Jan 2023 14:36:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz AA9A5A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1673271366; bh=f2GqUf1cW2FRwVBF1cKFnGll2JhGmKIGzLlt2Uudu+s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zYnxmFdY+pnNgl2bfkA4Lid2Ih+melJfNu4K1+x5uvxpl6qVkSpQ6hahXmEWy7nWL
         PZmRYaD5Y6PJzRz4fVdjLKZaP4xdd7JzHY878j20WKzZu7TZYU3a8G7u7/D+SO+XBo
         mIuDG5OubgSuIioB0bp0zAnFNMSx80QZSQjY2Tv8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon,  9 Jan 2023 14:36:00 +0100 (CET)
Message-ID: <ef91d500-60e8-fdfd-b661-161e7f2b12a3@perex.cz>
Date:   Mon, 9 Jan 2023 14:36:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH linux-next] ALSA: control-led: use strscpy() to instead of
 strncpy()
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, yang.yang29@zte.com.cn
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
References: <202301091945513559977@zte.com.cn> <87zgarg9ul.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <87zgarg9ul.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 01. 23 13:40, Takashi Iwai wrote:
> On Mon, 09 Jan 2023 12:45:51 +0100,
> <yang.yang29@zte.com.cn> wrote:
>>
>> From: Xu Panda <xu.panda@zte.com.cn>
>>
>> The implementation of strscpy() is more robust and safer.
>> That's now the recommended way to copy NUL-terminated strings.
>>
>> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
>> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
>> ---
>>   sound/core/control_led.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
>> index f975cc85772b..c88653c205eb 100644
>> --- a/sound/core/control_led.c
>> +++ b/sound/core/control_led.c
>> @@ -534,8 +534,7 @@ static ssize_t set_led_id(struct snd_ctl_led_card *led_card, const char *buf, si
>>   	struct snd_ctl_elem_id id;
>>   	int err;
>>
>> -	strncpy(buf2, buf, len);
>> -	buf2[len] = '\0';
>> +	strncpy(buf2, buf, len + 1);
> 
> Still using strncpy()...?

The original code should be:

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index f975cc85772b..b44abefcb593 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -530,7 +530,7 @@ static ssize_t set_led_id(struct snd_ctl_led_card 
*led_card, const char *buf, si
                           bool attach)
  {
         char buf2[256], *s, *os;
-       size_t len = max(sizeof(s) - 1, count);
+       size_t len = min(sizeof(buf2) - 1, count);
         struct snd_ctl_elem_id id;
         int err;

But it can be replaced with:

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index f975cc85772b..41d4e898d34c 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -530,12 +530,11 @@ static ssize_t set_led_id(struct snd_ctl_led_card 
*led_card, const char *buf, si
                           bool attach)
  {
         char buf2[256], *s, *os;
-       size_t len = max(sizeof(s) - 1, count);
         struct snd_ctl_elem_id id;
         int err;

-       strncpy(buf2, buf, len);
-       buf2[len] = '\0';
+       if (strscpy(buf2, buf, count) < 0)
+               return -E2BIG;
         memset(&id, 0, sizeof(id));
         id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
         s = buf2;

I'll send a patch ASAP.

				Jaroslav

--
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
