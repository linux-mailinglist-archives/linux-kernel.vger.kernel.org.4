Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DA6A7E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCBJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCBJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288DE38673
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677750074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Hjvoc1rI0mNChL06OP2EkJBsd0IDPnqcUCuNFEfHkQ=;
        b=KGBTkKOGax1pq/vs64yu32LKj+IfzWcD7KPLs+ytKvLvgLrOFbFHDkbDM+9CDiZvAI0NdV
        ZvG5sSOnl3zyWGV/jGS3+WJJK3lzXYehIVTggDMKRHvpcIvp62JwyPKzNWEUVFpfiICJ/F
        La/FzUoYb2Ss86JQlK7pCuJLDISWFQQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-j2-ROS9rP1iy4fZWERIqHQ-1; Thu, 02 Mar 2023 04:41:13 -0500
X-MC-Unique: j2-ROS9rP1iy4fZWERIqHQ-1
Received: by mail-wr1-f70.google.com with SMTP id m7-20020a056000008700b002c7047ea429so3090412wrx.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Hjvoc1rI0mNChL06OP2EkJBsd0IDPnqcUCuNFEfHkQ=;
        b=5yCQBGpuswpTqPCS8+ipYmPGYylWQ1BAk7wgi1CEhdUvSSD6EdQTPHN55oQQSSShWw
         4YHgkl9gxMnirSTAZZcnKSytRDFUq0EgYflsi1OdYUij3GWp//SfJ4S/VWHqmA9ZQ4o1
         9K7kuA5xiw91DpP7MMnn+WvWyhHLBEA3z8GZtg7QqltL6mK5wrOHWG8bFNZ62/KDonzY
         J2NZytqvX/9y/1/2Ad0tIvvSfd0E3HN0cpYBmEo5Sb/iX5o7F2fO4LTWtlWMbM8Vgoid
         ezqZ6Ftdi1oRXX7NvnCyiuhRFWd/SGy7xR56umM6zpCZfcZNdMjOfxAY+iL7N5315Z2k
         ON6g==
X-Gm-Message-State: AO0yUKWSdq4vuDOtKMu76pnYwH+5l1TRNXZir3YtMJripMKFfRDnQTqi
        eiec4AxQSjScf0AbgeMFwK5qjcPM1h90oAh2uUdtCLA2I/Ph8SB9+0P7NUBvSP4ZnPEMoQ401gt
        IipsyvNRmlx0PoNBWEl2A3tq4
X-Received: by 2002:a05:600c:3c81:b0:3df:fcbd:3159 with SMTP id bg1-20020a05600c3c8100b003dffcbd3159mr976040wmb.3.1677750072247;
        Thu, 02 Mar 2023 01:41:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+m2jCmZxrs/r4qdIoc1nGJTJq70PHpt6bJcgP4GAdRKd8i5kpDUdOX8h35tBt+ePXnjDguwA==
X-Received: by 2002:a05:600c:3c81:b0:3df:fcbd:3159 with SMTP id bg1-20020a05600c3c8100b003dffcbd3159mr976010wmb.3.1677750071838;
        Thu, 02 Mar 2023 01:41:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:4f00:87ba:e9e9:3821:677b? (p200300cbc70e4f0087bae9e93821677b.dip0.t-ipconnect.de. [2003:cb:c70e:4f00:87ba:e9e9:3821:677b])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003eafc47eb09sm2127748wmb.43.2023.03.02.01.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:41:11 -0800 (PST)
Message-ID: <31a88065-063a-727e-52fd-9fbc7d17fb5c@redhat.com>
Date:   Thu, 2 Mar 2023 10:41:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] mm/nommu: remove unnecessary VMA locking
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230301190457.1498985-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230301190457.1498985-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.23 20:04, Suren Baghdasaryan wrote:
> Since CONFIG_PER_VMA_LOCK depends on CONFIG_MMU, the changes in nommu
> are not needed. Remove them.
> 
> Fixes: bad94decd6a4 ("mm: write-lock VMAs before removing them from VMA tree")
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Link: https://lore.kernel.org/all/Y%2F8CJQGNuMUTdLwP@localhost/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> Fix cleanly applies over mm-unstable, SHA in "Fixes" is from that tree.
> 
>   mm/nommu.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 2ab162d773e2..57ba243c6a37 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -588,7 +588,6 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
>   		       current->pid);
>   		return -ENOMEM;
>   	}
> -	vma_start_write(vma);
>   	cleanup_vma_from_mm(vma);
>   
>   	/* remove from the MM's tree and list */
> @@ -1520,10 +1519,6 @@ void exit_mmap(struct mm_struct *mm)
>   	 */
>   	mmap_write_lock(mm);
>   	for_each_vma(vmi, vma) {
> -		/*
> -		 * No need to lock VMA because this is the only mm user and no
> -		 * page fault handled can race with it.
> -		 */
>   		cleanup_vma_from_mm(vma);
>   		delete_vma(mm, vma);
>   		cond_resched();

So, i assume this should be squashed.

Reviewed-by: David Hildenbrand <david@redhat.com>


Just a general comment: usually, if review of the original series is 
still going on, it makes a lot more sense to raise such things in the 
original series so the author can fixup while things are still in 
mm-unstable. Once the series is in mm-stable, it's a different story. In 
that case, it is usually good to have the mail subjects be something 
like  "[PATCH mm-stable 1/1] ...".

-- 
Thanks,

David / dhildenb

