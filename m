Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5074EAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjGKJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGKJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634C512E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689068185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxZnkt/GWTCVKy5gbmmUIjXS8Q3h8dniG0lrhXDybwQ=;
        b=N0YKmQNmjHe2Z6/xubzhVSQU1davKD2a9dO8wlXLbO7ARqDvC9GgkrZhiZoAhskBKRBgTa
        iJoD0bbFDx2UvQ5XVrcEdqC+dd/udHQ49ZevGShNB2Q3j+zseshR4YT3MgSDqiouMNBZ9P
        t6j/YL0bHmrphptTFWVmJDEXsYW1KvQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-7LMjVs5VPYCNif7JSLreHg-1; Tue, 11 Jul 2023 05:36:24 -0400
X-MC-Unique: 7LMjVs5VPYCNif7JSLreHg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b708d79112so50581101fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068182; x=1691660182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxZnkt/GWTCVKy5gbmmUIjXS8Q3h8dniG0lrhXDybwQ=;
        b=GlmUlwJQrMX/PwtvZQlpRtZtgMsNrgSL/ZMvrPGbX9SVUSQZX2qMmrZI0B/luw5CWW
         mgnE6lqIqVXt6h6Gcjr6teygkz8pkW5Y6R4wODqVrOIH9Ms0xvGY1o1EHUtNOKWPkSFH
         ftCbZB3aGQNmaFh3rDdFRqCIt9deDnpnNjSJ6wh0UiYWO0nEQTueA1zi2c2DvoenWU9L
         HuvaHHbe1yh+DoQmhYEuuf2GR6wkTQDiESWeJ9bYX3MKkzW7aycd5+WfnwDzM9rw5isA
         aIuGc8BUKmrykcqbos7CCbfPGVQADqbVDzToD/G42LuRtPnuQM+c3HR3XVUd9H0uqxeV
         GKcA==
X-Gm-Message-State: ABy/qLYA5kDNAT71CBLGNPKRIsujAWUTLQFoZc3b/Bbo9H3pAtPbe4cx
        +oTB4FRWIcUUE/5BMa35gBlFHGnGzvYBORhM/cX6lPIJUtXhHX13zyRgKPbbRsYFM8ZC+Y+LiHT
        jbZ6Dn17qeAXNkQPWcmMY9dnt2W6vMZZZ
X-Received: by 2002:a2e:87d9:0:b0:2b5:9e51:2912 with SMTP id v25-20020a2e87d9000000b002b59e512912mr12591750ljj.24.1689068182627;
        Tue, 11 Jul 2023 02:36:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEUGsAXeMRIT10j5xnsaH1kDZrQGa77TizJzh04nRcJoaLS6Op78e4ChusyYi8YYOJjDGfFWQ==
X-Received: by 2002:a2e:87d9:0:b0:2b5:9e51:2912 with SMTP id v25-20020a2e87d9000000b002b59e512912mr12591736ljj.24.1689068182272;
        Tue, 11 Jul 2023 02:36:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dk7-20020a170906f0c700b009931a3adf64sm937696ejb.17.2023.07.11.02.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:36:21 -0700 (PDT)
Message-ID: <1dfb573a-7e60-2bad-00a1-132d37d05cfc@redhat.com>
Date:   Tue, 11 Jul 2023 11:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop
 when parsing GUID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/21/23 17:11, Andy Shevchenko wrote:
> The while-loop may break on one of the two conditions, either ID string
> is empty or GUID matches. The second one, may never be reached if the
> parsed string is not correct GUID. In such a case the loop will never
> advance to check the next ID.
> 
> Break possible infinite loop by factoring out guid_parse_and_compare()
> helper which may be moved to the generic header for everyone later on
> and preventing from similar mistake in the future.
> 
> Interestingly that firstly it appeared when WMI was turned into a bus
> driver, but later when duplicated GUIDs were checked, the while-loop
> has been replaced by for-loop and hence no mistake made again.
> 
> Fixes: a48e23385fcf ("platform/x86: wmi: add context pointer field to struct wmi_device_id")
> Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your series, I've applied this series to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/wmi.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 5b95d7aa5c2f..098512a53170 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -136,6 +136,16 @@ static acpi_status find_guid(const char *guid_string, struct wmi_block **out)
>  	return AE_NOT_FOUND;
>  }
>  
> +static bool guid_parse_and_compare(const char *string, const guid_t *guid)
> +{
> +	guid_t guid_input;
> +
> +	if (guid_parse(string, &guid_input))
> +		return false;
> +
> +	return guid_equal(&guid_input, guid);
> +}
> +
>  static const void *find_guid_context(struct wmi_block *wblock,
>  				     struct wmi_driver *wdriver)
>  {
> @@ -146,11 +156,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
>  		return NULL;
>  
>  	while (*id->guid_string) {
> -		guid_t guid_input;
> -
> -		if (guid_parse(id->guid_string, &guid_input))
> -			continue;
> -		if (guid_equal(&wblock->gblock.guid, &guid_input))
> +		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
>  			return id->context;
>  		id++;
>  	}
> @@ -895,11 +901,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
>  		return 0;
>  
>  	while (*id->guid_string) {
> -		guid_t driver_guid;
> -
> -		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
> -			continue;
> -		if (guid_equal(&driver_guid, &wblock->gblock.guid))
> +		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
>  			return 1;
>  
>  		id++;

