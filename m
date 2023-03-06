Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBA6AC23C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCFOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCFOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96D25BB0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678111503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpjQI4eZNUyy1a8d8ToFfb8eUyexksQgeyNW7lbutB0=;
        b=Xz8NXAgbsxxpnlqfXXJlA30md+H8ysAPiwoeLXv3gORGnWdQbdqbnNDjr1D9WVfIbF2WTI
        CAS+xSaycmZuzbKvyjaWZVELg4DpaSzdZYLQc7EC+D2TJrGg8ZSW4D2Z8qp9EBLTgIbJR3
        F9eQWdB315kU9CCUMQVI6/9NjUMwElE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-nRMqiSTUPMuokcpJShebRg-1; Mon, 06 Mar 2023 09:05:00 -0500
X-MC-Unique: nRMqiSTUPMuokcpJShebRg-1
Received: by mail-wm1-f71.google.com with SMTP id j32-20020a05600c1c2000b003e9bdf02c9fso6788269wms.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111499;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpjQI4eZNUyy1a8d8ToFfb8eUyexksQgeyNW7lbutB0=;
        b=QR0AY9wv0TVPB/0UXdsm7jMf2p3jjP2cyNo0XXW8NoHNHOYYzFuZ0I6w8QSrrBFUuH
         5EPSpbPZIfpmTD6s+4d11UAQq9n0etNHaPlvaZppx+LENEJgYTORzWWPIaZoEmOmbxld
         sHwU8AaYk60fAMhfFtvNnY5QvaASRwYwZyWFSjQJZbK+01sVrwaeH8bfHHcVqoeVcL/g
         hePTdqwAmPfUx33yTnEsF7Fgpx7y/08pzuNSVxDCEShZ1x4dkgcNKfaFTQoLkwlrjSPT
         J49O95ficVDQb1y8Qr/4vyU8sguRWS5WAmkCzbs3qmkpQ/Ox+8fc1Rf4jgtRTqiKVmpn
         2Bmw==
X-Gm-Message-State: AO0yUKWpRCFhSiZx8E4u2U4wGrtRDtH2X0crVe5QJ3TvZ/MhTdVVy0eo
        3N+jBzeqixiNfQFBSoWVTkotYeAO7vz4q9rucjkr8sjm2YhX1Okokg4zDCEn0nLXqcQCz8w2oLX
        nINMgc4935cn1sYcXtqK2jK9pvqooASVY
X-Received: by 2002:a05:600c:1990:b0:3e2:20c7:6553 with SMTP id t16-20020a05600c199000b003e220c76553mr9340866wmq.13.1678111498923;
        Mon, 06 Mar 2023 06:04:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9t/0QaqgG9LAMjdWr1ncqogSGh8xkuI6ju2p3ppfz/c1knl1GVMAO3FPLfnnJj9dP9HbPRUA==
X-Received: by 2002:a05:600c:1990:b0:3e2:20c7:6553 with SMTP id t16-20020a05600c199000b003e220c76553mr9340820wmq.13.1678111498605;
        Mon, 06 Mar 2023 06:04:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id y33-20020a05600c342100b003e21f20b646sm10432673wmp.21.2023.03.06.06.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:04:58 -0800 (PST)
Message-ID: <efae0531-7f72-a78c-07c9-82879adf5666@redhat.com>
Date:   Mon, 6 Mar 2023 15:04:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/6] shmem: update documentation
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-6-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302232758.888157-6-mcgrof@kernel.org>
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

On 03.03.23 00:27, Luis Chamberlain wrote:
> Update the docs to reflect a bit better why some folks prefer tmpfs
> over ramfs and clarify a bit more about the difference between brd
> ramdisks.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   Documentation/filesystems/tmpfs.rst | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 0408c245785e..e77ebdacadd0 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -13,14 +13,25 @@ everything stored therein is lost.
>   
>   tmpfs puts everything into the kernel internal caches and grows and
>   shrinks to accommodate the files it contains and is able to swap
> -unneeded pages out to swap space. It has maximum size limits which can
> -be adjusted on the fly via 'mount -o remount ...'
> -
> -If you compare it to ramfs (which was the template to create tmpfs)
> -you gain swapping and limit checking. Another similar thing is the RAM
> -disk (/dev/ram*), which simulates a fixed size hard disk in physical
> -RAM, where you have to create an ordinary filesystem on top. Ramdisks
> -cannot swap and you do not have the possibility to resize them.
> +unneeded pages out to swap space.

I suppose, in contrast to ramfs, tmpfs also supports THP. Maybe worth 
adding as well.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

