Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9D71270F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjEZMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjEZMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFFE44
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685105641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FW1oe1uK4u4q8Og+riTNzG2g1eD3gmQuA5HQG1LlleE=;
        b=G4SjqC7MJG3E6HH+Qh3d3Z3VKuydJRJHIQ3FvrT9w4yZLkGONwkRO+tAOJbBQMZyEiMisy
        2yWaChK0sbL5JsdiUIEdkB+h0lemoSr2yQZ0nxnBwO30nI7BIgXAgi/lHwXtOSX76ZKGlL
        sh4E/4LL3G7W7ybJkZsbWRGW1rLdiHY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-3HFrtPh-Ob-ooVqIcw26OA-1; Fri, 26 May 2023 08:53:56 -0400
X-MC-Unique: 3HFrtPh-Ob-ooVqIcw26OA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6c3f5b767so4360031cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685105636; x=1687697636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW1oe1uK4u4q8Og+riTNzG2g1eD3gmQuA5HQG1LlleE=;
        b=fMR2hOJ0Qo7kHUq6YoCLZvvb3GutAQtuQytSUOMpf0QTffPvoPFAKJFr0+tc1a3m/l
         OgokvQwj97YUinW0r9rE/pE6tu/QNRnXopGqljl9l8QiljQir75w0M7LGhTO81NqONJG
         mtjKmx1bnTDbOrXIyWyc2ym5VNQD3SPSkl2BQexxjMUMlEhfGrlElz8QJ/ppD9kVMC9l
         HlVVNLk84I+FROHI2m1rRVkjaMiFpeSqdQi4aBIrK0r7NwV4rRRrD9rNLexsvVBG/zS4
         XMEUuKhp+JnPG7dgtuvfAnM84gdz6c+scagtZFojshF1brBsTTzIKLXPpg9a0QwpMxuO
         LRTQ==
X-Gm-Message-State: AC+VfDwgAjRjnOtdRNBm8wnVP0pjDuF+15WyuxBqBsnOcCHyYK0xisP0
        4c5ABytFN3Ho199XAPkvZ/9CTWUHZPW5nLS3wvKljIztTyMSSbMYBG55UdsCFHxeqMUwWk7HcRV
        kKowoF04CH6MNpcRkp8lRQoBV
X-Received: by 2002:a05:622a:1788:b0:3f6:ac41:9f29 with SMTP id s8-20020a05622a178800b003f6ac419f29mr1355413qtk.15.1685105636107;
        Fri, 26 May 2023 05:53:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4E2mK0jmUCYbGdbnawYy7a/EuK3DNerYvSFR/bSWzBHyn8E5maxyG8pouMYAmXfIQfF0XrFg==
X-Received: by 2002:a05:622a:1788:b0:3f6:ac41:9f29 with SMTP id s8-20020a05622a178800b003f6ac419f29mr1355395qtk.15.1685105635840;
        Fri, 26 May 2023 05:53:55 -0700 (PDT)
Received: from [192.168.1.20] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r6-20020ac85e86000000b003f018e18c35sm1226798qtx.27.2023.05.26.05.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 05:53:55 -0700 (PDT)
Message-ID: <6501836f-bf06-b551-aaf7-52f9e41e4da5@redhat.com>
Date:   Fri, 26 May 2023 05:53:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] watchdog: delete old declarations for
 watchdog_soft,hardlockup_user_enabled + make static
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230525162822.1.I0fb41d138d158c9230573eaa37dc56afa2fb14ee@changeid>
From:   Tom Rix <trix@redhat.com>
In-Reply-To: <20230525162822.1.I0fb41d138d158c9230573eaa37dc56afa2fb14ee@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/25/23 4:28 PM, Douglas Anderson wrote:
> From: Tom Rix <trix@redhat.com>
>
> smatch reports
> kernel/watchdog.c:40:19: warning: symbol
>    'watchdog_hardlockup_user_enabled' was not declared. Should it be static?
> kernel/watchdog.c:41:19: warning: symbol
>    'watchdog_softlockup_user_enabled' was not declared. Should it be static?
>
> These variables are only used in their defining file, so they should
> be static.
>
> This problem showed up after the patch ("watchdog/hardlockup: rename
> some "NMI watchdog" constants/function") because that rename missed
> the header file. That didn't cause any compile-time errors because,
> since commit dd0693fdf054 ("watchdog: move watchdog sysctl interface
> to watchdog.c"), nobody outside of "watchdog.c" was actually referring
> to them. Thus, not only should we make these variables static but we
> should remove the old declarations in the header file that we missed
> renaming.
>
> Fixes: 4b95b620dcd5 ("watchdog/hardlockup: rename some "NMI watchdog" constants/function")
> Signed-off-by: Tom Rix <trix@redhat.com>
> [dianders: updated subject + commit message; squashed in Petr's suggestion]
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This is a squash of two patches that were posted to mailing lists, one
> official patch posted by Tom [1] and one that was posted in reply to
> my previous patch by Petr [2].
>
> IMO it makes sense to put these two things into one patch since
> they're basically dealing with the same issue. As promised [3] I'm
> posting the squash of the two patches.
>
> I have no idea how to really tag this and set authorship. I've chosen
> to leave author/Signed-off-by from Tom. Peter didn't officially
> include his Singed-off-by on his patch (as is common when posting
> suggestions in reply to another patch), so I didn't add it but added a
> Suggested-by from him. Hopefully this is OK. I dropped Mukesh's
> Reviewed-by just because it felt like things changed enough with the
> addition of Petr's stuff that it should be re-added.
>
> I've tagged this as "Fixes" based on the git hash in the current
> linuxnext.
>
> [1] https://lore.kernel.org/r/20230523122324.1668396-1-trix@redhat.com
> [2] https://lore.kernel.org/r/ZG4TW--j-DdSsUO6@alley/
> [3] https://lore.kernel.org/all/CAD=FV=V_i5wR4oNy+xarA9e=VcgpH6i3U1uxFKtsaOe5AQX=Zw@mail.gmail.com/
>
>   include/linux/nmi.h | 6 ++----
>   kernel/watchdog.c   | 4 ++--
>   2 files changed, 4 insertions(+), 6 deletions(-)

Looks good to me.

Reviewed-by: Tom Rix <trix@redhat.com>

>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index d23902a2fd49..333465e235e1 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -18,8 +18,6 @@ void lockup_detector_soft_poweroff(void);
>   void lockup_detector_cleanup(void);
>   
>   extern int watchdog_user_enabled;
> -extern int nmi_watchdog_user_enabled;
> -extern int soft_watchdog_user_enabled;
>   extern int watchdog_thresh;
>   extern unsigned long watchdog_enabled;
>   
> @@ -70,8 +68,8 @@ static inline void reset_hung_task_detector(void) { }
>    * 'watchdog_enabled' variable. Each lockup detector has its dedicated bit -
>    * bit 0 for the hard lockup detector and bit 1 for the soft lockup detector.
>    *
> - * 'watchdog_user_enabled', 'nmi_watchdog_user_enabled' and
> - * 'soft_watchdog_user_enabled' are variables that are only used as an
> + * 'watchdog_user_enabled', 'watchdog_hardlockup_user_enabled' and
> + * 'watchdog_softlockup_user_enabled' are variables that are only used as an
>    * 'interface' between the parameters in /proc/sys/kernel and the internal
>    * state bits in 'watchdog_enabled'. The 'watchdog_thresh' variable is
>    * handled differently because its value is not boolean, and the lockup
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 877d8670f26e..237990e8d345 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -37,8 +37,8 @@ static DEFINE_MUTEX(watchdog_mutex);
>   
>   unsigned long __read_mostly watchdog_enabled;
>   int __read_mostly watchdog_user_enabled = 1;
> -int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
> -int __read_mostly watchdog_softlockup_user_enabled = 1;
> +static int __read_mostly watchdog_hardlockup_user_enabled = WATCHDOG_HARDLOCKUP_DEFAULT;
> +static int __read_mostly watchdog_softlockup_user_enabled = 1;
>   int __read_mostly watchdog_thresh = 10;
>   static int __read_mostly watchdog_hardlockup_available;
>   

