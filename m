Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5125BE54E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiITMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiITMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A327CFD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663675840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tomIFmT2auPWgU52HW7Ixu9aQt/lJ7bkSj0XCxjEol8=;
        b=GaFlfbT0FmjGGc79xTMpgFOSo4A67zNsCSWGkkDr5Ie+LM4dj30vJx2793xYVkKsiqGf73
        quvQzztG2s0RJv3mGSBHlFJy4t3IjrjEPYSeyQmASx74nQcz78uj/csZCmWGzIc7mDh/QH
        UR3XG8JG0ZJgUCOjy0cEZ6B36bZIPTs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-mX_wTQy-McaUuTcPGnA5OQ-1; Tue, 20 Sep 2022 08:10:38 -0400
X-MC-Unique: mX_wTQy-McaUuTcPGnA5OQ-1
Received: by mail-wm1-f69.google.com with SMTP id y20-20020a05600c365400b003b4d4ae666fso581781wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tomIFmT2auPWgU52HW7Ixu9aQt/lJ7bkSj0XCxjEol8=;
        b=i+FouRCVqvDRox2npaFiAt8yu4MG0CEUaERYmSV28fyO5rQ9SA8HRN93dmxDTUIWEb
         jBfkdC0LPHcwXXO29l/R084w0nZOEhUXyfyO3E8U4Ee3h6NVnUu21unOyrL0m8dj2svU
         6fQqlNKJIwtK8vX00pTb85IhNAX94QiIRF0tdSCYL9iZBgj7fMmozVssRFue9AYOWEbM
         ZQgGSdwVMHIOkXmmoc8izCrOpbL4uZIiEi7ceixO9Vm8UWDyc2iAZ0Sf6VpjM9sFDkyQ
         LrkeX4l+4GIivQQYP+8jc5ERm4N6I91CZLH82wq0rXTdeg1WF/d8c1tYC+GvJid9I3La
         m5Rw==
X-Gm-Message-State: ACrzQf34CIz9V0FHoTfuyW36eGk6qR08e/Gn1g8/Cj6XQ/b56x9ZiBv1
        lGF0VSkdLyTNkEv3UMR8g/XsMGBsOMcpi66kNg0TplYeyMa2pzATwEZjXGTuTnj1RTQoBvF91vZ
        y65NYbDDNaPXLF9X4l3JTGoWV
X-Received: by 2002:a05:6000:815:b0:22a:418e:f354 with SMTP id bt21-20020a056000081500b0022a418ef354mr13956798wrb.97.1663675837139;
        Tue, 20 Sep 2022 05:10:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7WQqz1rESE7cF5L6XLg90fFIoyXCvRsKbGaq9PEEF6VFsm7YhkfEjvOeeeX5sDsAdwlyWJKw==
X-Received: by 2002:a05:6000:815:b0:22a:418e:f354 with SMTP id bt21-20020a056000081500b0022a418ef354mr13956784wrb.97.1663675836799;
        Tue, 20 Sep 2022 05:10:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b47b80cec3sm19087785wmq.42.2022.09.20.05.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:10:36 -0700 (PDT)
Message-ID: <3196b824-bcee-0c44-bfd3-f6cd8a1e6719@redhat.com>
Date:   Tue, 20 Sep 2022 14:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/secretmem: remove reduntant return value
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220920012205.246217-1-xiujianfeng@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220920012205.246217-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.22 03:22, Xiu Jianfeng wrote:
> The return value @ret is always 0, so remove it and return 0 directly.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   mm/secretmem.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 6a44efb673b2..04c3ac9448a1 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -278,10 +278,8 @@ static struct file_system_type secretmem_fs = {
>   
>   static int __init secretmem_init(void)
>   {
> -	int ret = 0;
> -
>   	if (!secretmem_enable)
> -		return ret;
> +		return 0;
>   
>   	secretmem_mnt = kern_mount(&secretmem_fs);
>   	if (IS_ERR(secretmem_mnt))

On top of which tree is that?

6.0-rc6 has here:

if (IS_ERR(secretmem_mnt))
	ret = PTR_ERR(secretmem_mnt);

-- 
Thanks,

David / dhildenb

