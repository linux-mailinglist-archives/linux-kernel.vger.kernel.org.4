Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED16D0DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjC3Sc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjC3ScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CF26B8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680201096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jobE+W1McsuIR3du17YGJC3Z6W/dejQUbpwCNwzU5Sc=;
        b=AVKIdV8YHZewAguVrUZqzrkuII2p/r7iwSSaTIQE51Dnbt8LfOVme09peVqqi3yj0K+xPT
        vMvnOGkACZETpK428IKwijkslhUP1rT22EJMH6NAnh75Dz3T4amxkUbrpHeIcpf+e8Kp1J
        hfWl29t7GUzfMYqvyt4qJpHmUZ9H220=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-DxNs0ONEPxKBsxtnAIng5A-1; Thu, 30 Mar 2023 14:31:33 -0400
X-MC-Unique: DxNs0ONEPxKBsxtnAIng5A-1
Received: by mail-pf1-f197.google.com with SMTP id i26-20020aa796fa000000b006261da7aeceso9186387pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201092;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jobE+W1McsuIR3du17YGJC3Z6W/dejQUbpwCNwzU5Sc=;
        b=oYTrA8S4FzrcQnl24v3LiQGnufHxQhQ/DutLoV0IP8V59hg+X89H9wVrgHiob1HtRK
         Ab/Z2+oAUAExCZQLOW5VdV0RLZVvoz9MktaYp4ErRPvSWY2Voxs8uupwOBaqH/vbSd1W
         6uIClFCWV+5GRnLz8E610m3PqF+wS4iDq0sthh6OrRuyJLy8jY4qh61ahlkcOyBiOrws
         yEHGhxAL4TJdolsOhbBGGFLWmH0Y9ZJaDy4zCmkFxnvr6cjTRs5/G/UTO9wifAGlnhiw
         phMrdJoYni6DUMOYHoSTo8CYOzPa/vAVDdPxpvn8Dmj717yaYe6p1iIjwJCpu+mwrTM6
         cg/g==
X-Gm-Message-State: AAQBX9dDz0XDXpS+sT2es0TZ6s2Wl4saMtsv8s38ppuXE/wLjmnGQU1G
        dg/NIGqHHhPVQ1Rhedecm4DCp7FWQwLBAyL2Cx5o8MoavJgQbPbwKUark6P8bOpacNxPNks3eJA
        ZK/hzSF1dDdkzFxnduSNn2EPqWxBCFE1s2S4=
X-Received: by 2002:a17:902:f550:b0:1a1:b8cc:59da with SMTP id h16-20020a170902f55000b001a1b8cc59damr34302066plf.33.1680201092400;
        Thu, 30 Mar 2023 11:31:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y2XtPFSh2/v9wjpAeWlY42dx0ySEUXCrM0cIilFUSj200Kj1d2tPF9lFKbZ4sHT5e1f1bXcw==
X-Received: by 2002:a17:902:f550:b0:1a1:b8cc:59da with SMTP id h16-20020a170902f55000b001a1b8cc59damr34302031plf.33.1680201092055;
        Thu, 30 Mar 2023 11:31:32 -0700 (PDT)
Received: from [10.20.159.115] ([204.239.251.6])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001a1a31953a8sm50799pll.130.2023.03.30.11.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 11:31:31 -0700 (PDT)
Message-ID: <6eb02bdd-e69e-d277-c44c-0aefb23430bb@redhat.com>
Date:   Thu, 30 Mar 2023 20:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/29] Revert "userfaultfd: don't fail on unrecognized
 features"
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        linux-stable <stable@vger.kernel.org>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330155707.3106228-2-peterx@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330155707.3106228-2-peterx@redhat.com>
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

On 30.03.23 17:56, Peter Xu wrote:
> This is a proposal to revert commit 914eedcb9ba0ff53c33808.
> 
> I found this when writting a simple UFFDIO_API test to be the first unit
> test in this set.  Two things breaks with the commit:
> 
>    - UFFDIO_API check was lost and missing.  According to man page, the
>    kernel should reject ioctl(UFFDIO_API) if uffdio_api.api != 0xaa.  This
>    check is needed if the api version will be extended in the future, or
>    user app won't be able to identify which is a new kernel.

Agreed.

> 
>    - Feature flags checks were removed, which means UFFDIO_API with a
>    feature that does not exist will also succeed.  According to the man
>    page, we should (and it makes sense) to reject ioctl(UFFDIO_API) if
>    unknown features passed in.
> 

Agreed.

I understand the motivation of the original commit, but it should not 
have changed existing checks/functionality. Introducing a different way 
to enable such functionality on explicit request would be better. But 
maybe simple feature probing (is X support? is Y supported? is Z 
supported) might be easier without requiring ABI changes.

I assume we better add

Fixes: 914eedcb9ba0 ("userfaultfd: don't fail on unrecognized features")


Acked-by: David Hildenbrand <david@redhat.com>

> Link: https://lore.kernel.org/r/20220722201513.1624158-1-axelrasmussen@google.com
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/userfaultfd.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 8395605790f6..3b2a41c330e6 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1977,8 +1977,10 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>   	ret = -EFAULT;
>   	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
>   		goto out;
> -	/* Ignore unsupported features (userspace built against newer kernel) */
> -	features = uffdio_api.features & UFFD_API_FEATURES;
> +	features = uffdio_api.features;
> +	ret = -EINVAL;
> +	if (uffdio_api.api != UFFD_API || (features & ~UFFD_API_FEATURES))
> +		goto err_out;
>   	ret = -EPERM;
>   	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
>   		goto err_out;

-- 
Thanks,

David / dhildenb

