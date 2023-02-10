Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203D8692317
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjBJQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBJQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:16:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA774074
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676045767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XicZZaHKYiFxVDJoxrajqH9cjcclHt3r5xKv9x112Ig=;
        b=c+CSO15Hsne+m0fgwn148hhYEcjiQ3h3xmeP7VRinRV8iIMoW9G9sbWcMJDqpRMHDUwVuh
        Pi4gWuNEwb90aun4ph8Q4R6l/cp6KfdN+6crLcCHE87Ke6GDBjgFA8lxlQ3zyMpKsFVN47
        F6F4MvTAymzwW28tU8WXz8LShPXZwuM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-393-Q2mM4mC1OcqswpFhJlHrSQ-1; Fri, 10 Feb 2023 11:16:06 -0500
X-MC-Unique: Q2mM4mC1OcqswpFhJlHrSQ-1
Received: by mail-ej1-f70.google.com with SMTP id wu9-20020a170906eec900b0088e1bbefaeeso3921482ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XicZZaHKYiFxVDJoxrajqH9cjcclHt3r5xKv9x112Ig=;
        b=BRi8zi+extBKhr10O20ZUDgM0m9FSMJuNJw2An2bfg8dIYCchz9YG+EDIYEQTH8vm3
         /2eb9bpP+mdbKFG2Zux7OFn65S2w+3EiI0olrHxq6lhQKlGEYZ54eWB1AkTVlQfaCHr/
         EM/uxfrdWbMlirACK66vaspeUDdH1HG725RgMfgGfXAc2/Liiy3tkXOrxrEGJbAUluFj
         yzWNgNca560EQ5jdu9Na1jeVIp+hQ2VzG71jk+W4MDwyuE5YC2K7prNprvsawVNKhHMa
         zkiqwBLj9Wo6WOIPuLnBRU5fS0ncBXURsWmIQdqqisKAG0UP7cTPN9Iji+cmZ73z4ajg
         gMug==
X-Gm-Message-State: AO0yUKXehfQGoBvUE5SphzO5euEE1UrFN0pamw2KNh140iD2q2hcdV6E
        C/kQTuo0qjwwJlX4+M4SKiQHDr/7B1IeEAhkvhZi9A3XgWKskSVETMSVSos8etfz9RbLNl8h//w
        LQYTME2MhtOFkmV9bIPDNsG7F
X-Received: by 2002:a17:906:6b08:b0:887:8f6:c1d7 with SMTP id q8-20020a1709066b0800b0088708f6c1d7mr15842704ejr.38.1676045765551;
        Fri, 10 Feb 2023 08:16:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9EFJLiV03HZKytK34nIYfzlrZI+4a21JtGCaNebyCEsD8o90112AQwAiLygjujR89MXKnBJw==
X-Received: by 2002:a17:906:6b08:b0:887:8f6:c1d7 with SMTP id q8-20020a1709066b0800b0088708f6c1d7mr15842681ejr.38.1676045765414;
        Fri, 10 Feb 2023 08:16:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f26-20020a170906825a00b0084c4b87aa18sm2561668ejx.37.2023.02.10.08.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:16:05 -0800 (PST)
Message-ID: <2e959ac0-e33a-6128-4fb7-6d86fbb6f69a@redhat.com>
Date:   Fri, 10 Feb 2023 17:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1] platform/x86: Add include/linux/platform_data/x86
 to MAINTAINERS
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
References: <20230206150202.27892-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230206150202.27892-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/6/23 16:02, Andy Shevchenko wrote:
> Most of the files there are being used under PDx86 subsystem or
> tightly related drivers (like drivers/clk/x86/). I think it makes
> sense to assure that PDx86 keeps an eye on the changes there.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4329d6611c20..705ffd15afbe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22598,6 +22598,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>  F:	drivers/platform/olpc/
>  F:	drivers/platform/x86/
> +F:	include/linux/platform_data/x86/
>  
>  X86 PLATFORM DRIVERS - ARCH
>  R:	Darren Hart <dvhart@infradead.org>

