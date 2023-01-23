Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DC677A55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjAWLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjAWLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:46:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10314EAD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674474355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKJxlJGIfIsaD5LRoMOc9aRdfkqWYBvoEPdj64DJbCY=;
        b=FfbhWoyJhoUBGew/EuR3PX2wci3063JmgVsf7KBpHh6B2sBtno+WcHrfZApvH2vYVlVXAe
        DIn3ExwHzkpdKKI/zfNkw6yjXVF3VHa6OqL4Pa3L7pX/ZacZHHP1Ms+K+nyJXWXPEA2Tc7
        r+1BwndakXKFrCqIIkFKsSmUcb9rHDU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-NxLxYZzSOieidrztaJEi2Q-1; Mon, 23 Jan 2023 06:45:54 -0500
X-MC-Unique: NxLxYZzSOieidrztaJEi2Q-1
Received: by mail-wm1-f72.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso7373568wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKJxlJGIfIsaD5LRoMOc9aRdfkqWYBvoEPdj64DJbCY=;
        b=ium0dmPuAS7qIfpg/jJjz9hBxpgRPgT18+e9uINT5QlBKAImScOfzqOFDYw8iRqwQa
         3IEPd2IAZvPL4qIrL+OSNvGBX5NOwxywrX3PvxT6/dylFf7abvRcEqCSDQeIffprtzin
         MycNtcXBfWhdky8uYr05Vace4IaAxpQE/hVIJzjfL2c/etTbsRGkNDNNV7YlaleYAyae
         xCYYql0FPNAaTZfxTTW/GwoH5OxFK+puZ5PTb6WjjK3YTFjNXk8ySjSJ0X9Kz6X+E8hd
         A0X+k+Yc8qeQmWj8kvEcvJV0+RZCAtAP1C97TO/ykpANHurwRMkkrFahUC8rKeprlCUC
         vnaw==
X-Gm-Message-State: AFqh2krEaUBCi5eZWqPlu/4u6/9i6w27XBDjPqMoUEGL1QZC5CzoEaYB
        /sfF++OnMOQYK7NeIBTgZXK26j7xxeN7LpL4FIPPcg5FBq4jZge9MfkVTuQvzHBmb6XPwl94Yfc
        /9Ah9fdsDnMMf6mEGeo8skJn5
X-Received: by 2002:a5d:46c2:0:b0:2bf:9465:64a with SMTP id g2-20020a5d46c2000000b002bf9465064amr9244230wrs.27.1674474352630;
        Mon, 23 Jan 2023 03:45:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvTZG6hW9a8LI7tEVvYp5YnPxCUcCD42L3k31ZE04ppuyLjPSI1rlGzrMMMlKglCuEQmxM+9g==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9465:64a with SMTP id g2-20020a5d46c2000000b002bf9465064amr9244213wrs.27.1674474352288;
        Mon, 23 Jan 2023 03:45:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm26465943wrb.57.2023.01.23.03.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:45:51 -0800 (PST)
Message-ID: <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com>
Date:   Mon, 23 Jan 2023 12:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
Content-Language: en-US
To:     Joey Gouly <joey.gouly@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-2-joey.gouly@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230119160344.54358-2-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19.01.23 17:03, Joey Gouly wrote:
> The aim of such policy is to prevent a user task from creating an
> executable mapping that is also writeable.
> 
> An example of mmap() returning -EACCESS if the policy is enabled:
> 
> 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
> 
> Similarly, mprotect() would return -EACCESS below:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
> 
> The BPF filter that systemd MDWE uses is stateless, and disallows
> mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
> be enabled if it was already PROT_EXEC, which allows the following case:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> 
> where PROT_BTI enables branch tracking identification on arm64.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>   include/linux/mman.h           | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/sched/coredump.h |  6 +++++-
>   include/uapi/linux/prctl.h     |  6 ++++++
>   kernel/sys.c                   | 33 +++++++++++++++++++++++++++++++++
>   mm/mmap.c                      | 10 ++++++++++
>   mm/mprotect.c                  |  5 +++++
>   6 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 58b3abd457a3..cee1e4b566d8 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
>   }
>   
>   unsigned long vm_commit_limit(void);
> +
> +/*
> + * Denies creating a writable executable mapping or gaining executable permissions.
> + *
> + * This denies the following:
> + *
> + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
> + *
> + *	b)	mmap(PROT_WRITE)
> + *		mprotect(PROT_EXEC)
> + *
> + *	c)	mmap(PROT_WRITE)
> + *		mprotect(PROT_READ)
> + *		mprotect(PROT_EXEC)
> + *
> + * But allows the following:
> + *
> + *	d)	mmap(PROT_READ | PROT_EXEC)
> + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
> + */

Shouldn't we clear VM_MAYEXEC at mmap() time such that we cannot set 
VM_EXEC anymore? In an ideal world, there would be no further mprotect 
changes required.

-- 
Thanks,

David / dhildenb

