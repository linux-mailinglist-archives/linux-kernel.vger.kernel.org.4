Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0E6C0DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCTKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTJ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA54234E0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679306332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eusdBqGYQDxvoAs8ndLlA22S0Bv6aqSKMaLO9WfcaK4=;
        b=PCj9RSPjNxS7IM4JlKxc1weYQhCOhuwgxdZae97dYjt6cYcASygz4n08q1xTf3nCZ8IJNY
        G/FYbghigWCKMsi0HyWRp90ShPmNRUvMrxjPQ7cEQi4o1HOzNIQ6cIeX59QPHxpZJByFIf
        dcPjULCA/m7xvffrZJijwHbjQE1LmVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-IsDzkIc-Ngu9RtwbicITuw-1; Mon, 20 Mar 2023 05:58:51 -0400
X-MC-Unique: IsDzkIc-Ngu9RtwbicITuw-1
Received: by mail-wm1-f72.google.com with SMTP id r35-20020a05600c322300b003edce6ff3b4so1275323wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306330;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eusdBqGYQDxvoAs8ndLlA22S0Bv6aqSKMaLO9WfcaK4=;
        b=GO0rKDLUoO1++JeKB5Rf8Vr5uA7i8HHcNjC11jEo/4V462LkqkncumnrUkbtApEnMf
         0YXgl72YnYaOFHECw2plQTXxH8ekDBigGTe9GdOD2mWPT2xWl0Uya3YyCdaqC37SsRCf
         q2W6H5mwW/D12yGBf9olYjKo4dTzeV6UyRtjom26hM31078tjuAh95B2u+soe4VpDv/F
         zbE88rVj3q0QeTuQeLpoOzUuFbIYOQ7s0r0nRmKF3NpKECdtxuzRlr2+k7GryKh+7WhC
         SjPRXgTJJRXn7H5SFYkMomIkCcczq7sfPdx4ShXx2xQwyeIIhZI8ecJXzuP2jo0+roI4
         2Gpw==
X-Gm-Message-State: AO0yUKVdym2qfcAWbYspCK1THjvxVEiLXJVBnI4JhOA17Ulbss6j2dgh
        zLVJv8NXoI/j08GOAdniNtQPrhTtfgxUGecu9/Ie39KEFWf+snFJMoS8/PluYKzGrO1VgEEH94X
        7wIrR/AZKNm28/fFI66XdvJPy
X-Received: by 2002:a05:600c:3ca8:b0:3ed:b9ee:b436 with SMTP id bg40-20020a05600c3ca800b003edb9eeb436mr5407677wmb.7.1679306330239;
        Mon, 20 Mar 2023 02:58:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set/G9biqC479ICASHvl9gHffWMTV5W8wX+knwU5u+GUa24HaC6JE/ihsB8eKFFScolHb3CqGNQ==
X-Received: by 2002:a05:600c:3ca8:b0:3ed:b9ee:b436 with SMTP id bg40-20020a05600c3ca800b003edb9eeb436mr5407658wmb.7.1679306329950;
        Mon, 20 Mar 2023 02:58:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003ed551b139csm10000745wma.36.2023.03.20.02.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:58:49 -0700 (PDT)
Message-ID: <2593f450-f65b-53ea-8b5d-d0bab89c1bfb@redhat.com>
Date:   Mon, 20 Mar 2023 10:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] fs/proc/kcore: Avoid bounce buffer for ktext data
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <2ed992d6604965fd9eea05fed4473ddf54540989.1679209395.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2ed992d6604965fd9eea05fed4473ddf54540989.1679209395.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 08:09, Lorenzo Stoakes wrote:
> Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
> introduced the use of a bounce buffer to retrieve kernel text data for
> /proc/kcore in order to avoid failures arising from hardened user copies
> enabled by CONFIG_HARDENED_USERCOPY in check_kernel_text_object().
> 
> We can avoid doing this if instead of copy_to_user() we use _copy_to_user()
> which bypasses the hardening check. This is more efficient than using a
> bounce buffer and simplifies the code.
> 
> We do so as part an overall effort to eliminate bounce buffer usage in the
> function with an eye to converting it an iterator read.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   fs/proc/kcore.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 71157ee35c1a..556f310d6aa4 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -541,19 +541,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>   		case KCORE_VMEMMAP:
>   		case KCORE_TEXT:
>   			/*
> -			 * Using bounce buffer to bypass the
> -			 * hardened user copy kernel text checks.
> +			 * We use _copy_to_user() to bypass usermode hardening
> +			 * which would otherwise prevent this operation.
>   			 */
> -			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
> -				if (clear_user(buffer, tsz)) {
> -					ret = -EFAULT;
> -					goto out;
> -				}
> -			} else {
> -				if (copy_to_user(buffer, buf, tsz)) {
> -					ret = -EFAULT;
> -					goto out;
> -				}
> +			if (_copy_to_user(buffer, (char *)start, tsz)) {
> +				ret = -EFAULT;
> +				goto out;
>   			}
>   			break;
>   		default:

Looks correct to me. The only difference between copy_to_user() and 
_copy_to_user() is the check_copy_size() check, that ends up calling 
check_kernel_text_object().

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

