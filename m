Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739C06C48B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCVLNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCVLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173B497FF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679483533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/aPGKaPvh2Lx38+k9wl4Z2hIIrRuiYn/f4bCGiiCybA=;
        b=dpgKw/x37lQjuYjXYs5p2ZAf46fu3rCVPr/V+6KpC4voOUPEElISmlC+iXatBz209VJn9h
        E7JltaJX+FKErOU6t5T46xb/EdKIXVbs/pJ65B4vIuM0PS90ndriyBClotDsZSzY7lgCiQ
        fe7MfUMtNr2+kzObZG0U8BKKh+KCjug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-JGjTZa5lPzC_p5oVtQ35Zw-1; Wed, 22 Mar 2023 07:12:12 -0400
X-MC-Unique: JGjTZa5lPzC_p5oVtQ35Zw-1
Received: by mail-wm1-f71.google.com with SMTP id k29-20020a05600c1c9d00b003ee3a8d547eso2251195wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483531;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aPGKaPvh2Lx38+k9wl4Z2hIIrRuiYn/f4bCGiiCybA=;
        b=wjP7mz+UbCs7yi57UrVVnwPwvpnBK2QImri2LekBO39mIR2iKse2OmMMoIgEDj1UmH
         8gA6dbuXLEE1qXGGtbS+T2lTK01bw1QWBkK3mjYnORHJxTuC6oFd73FwPOqL6LtONXLh
         ZagRNZDEz9W3y7P0pd9GcOwWLwa453jzMOvBquHP1BodnSnRD0X4IRLM7x9FTnSH1CvW
         F2oWw3DhAs+ny+ioC7OQTTG21dCMb5R0BlVyP2ZSNEHJ5tGcsDWZpvDmsxhuxWeDVnpy
         8nrfsDhlITQCAnDvViKKwfdDEkUmBoL5gUJsZ/yydWZys3TA9Tgx5PLOLDI719xY0YPY
         PskQ==
X-Gm-Message-State: AO0yUKVlJXr+DdsHAU4DmYrKhBZX0OxZcSIjsbqELtlUTDeQTKm0n2+v
        ww9uc9TN0GcYB464oLHCi2wcTZbwlWEwxovczFZS26As7lWZddHeUPfFt2hLzZ4CFbu1tVVomR4
        57aJJkHyRkeCMz35jzJDWvpUf
X-Received: by 2002:a05:600c:22cd:b0:3ee:5ea1:65f5 with SMTP id 13-20020a05600c22cd00b003ee5ea165f5mr1343527wmg.26.1679483531548;
        Wed, 22 Mar 2023 04:12:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set/sZYFpMjjZHaVQVb3usc140Yjc7XHH7cOoCrF5A+aRLaiPdtgF9CC6V3vYev6u2xlG4xewcA==
X-Received: by 2002:a05:600c:22cd:b0:3ee:5ea1:65f5 with SMTP id 13-20020a05600c22cd00b003ee5ea165f5mr1343508wmg.26.1679483531254;
        Wed, 22 Mar 2023 04:12:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b003ee04190ddfsm8292351wmb.17.2023.03.22.04.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:12:10 -0700 (PDT)
Message-ID: <e2c63348-fbf9-0d2a-7c09-ee14f6106770@redhat.com>
Date:   Wed, 22 Mar 2023 12:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/4] fs/proc/kcore: convert read_kcore() to
 read_kcore_iter()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <a84da6cc458b44d949058b5f475ed3225008cfd9.1679431886.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a84da6cc458b44d949058b5f475ed3225008cfd9.1679431886.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.23 21:54, Lorenzo Stoakes wrote:
> Now we have eliminated spinlocks from the vread() case, convert
> read_kcore() to read_kcore_iter().
> 
> For the time being we still use a bounce buffer for vread(), however in the
> next patch we will convert this to interact directly with the iterator and
> eliminate the bounce buffer altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   fs/proc/kcore.c | 58 ++++++++++++++++++++++++-------------------------
>   1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 556f310d6aa4..25e0eeb8d498 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -24,7 +24,7 @@
>   #include <linux/memblock.h>
>   #include <linux/init.h>
>   #include <linux/slab.h>
> -#include <linux/uaccess.h>
> +#include <linux/uio.h>
>   #include <asm/io.h>
>   #include <linux/list.h>
>   #include <linux/ioport.h>
> @@ -308,9 +308,12 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>   }
>   
>   static ssize_t
> -read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> +read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
> +	struct file *file = iocb->ki_filp;
>   	char *buf = file->private_data;
> +	loff_t *ppos = &iocb->ki_pos;

Not renaming fpos -> ppos in this patch would result in less noise in 
this patch. Just like you didn't rename buflen.

In general, LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

