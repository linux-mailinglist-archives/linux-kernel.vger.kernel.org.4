Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0A6D3E68
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjDCHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjDCHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55210B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxFAvH30KTtt4Kdwm1rs0YVLmwDE+uign6p92XMle54=;
        b=L9ceXDsgsnNo2rZ5pXgPFanqvhgdk5den6nBM8vjUSzGOTNJEVsxD26un+nTUmyZvmalLx
        K8IBEuLJVOuiMDNGSRPYk7hBQ3NClGXqYSisxnJqGmeSOkfGVQulzD9L4bO1TsgzfvNxNe
        s1mUptT0Ncid6hS9SG+VbL0oj5auCFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-4eYN3v-vOaG_VFqxtMBhNg-1; Mon, 03 Apr 2023 03:48:50 -0400
X-MC-Unique: 4eYN3v-vOaG_VFqxtMBhNg-1
Received: by mail-wm1-f71.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so14114837wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508129;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxFAvH30KTtt4Kdwm1rs0YVLmwDE+uign6p92XMle54=;
        b=OnpwMvDap8cPFxTJRTaNqo5ipIpl5Gl4rnrHlhvSbNzouervaSZoC8Z30tyvBuGLk6
         wvLBuWipk1RiVUjzpMtgETHmcFf/kT0OWk/5JMfOAvc1i7Dao5VYc4TBeI3aKPwBOJKk
         CoIvndtJp6Mnz/fOonI0RD7AzlBWW5JfZ7a0V73JfZdmt93XMzvequq5XvdFa6v0gqYy
         LTNO/wKqlfB+lOeWSy/Y/89lulY8ax4w8KWAWi4ZZYMZIcx/LWGBdZzz09ful/35lxff
         IOskeOQmDsbD3tcu/kDWk9wmdyHX8AJFphoVYiP4C28JrnIwsO1mwcSbPNC0YUNfcehW
         Givw==
X-Gm-Message-State: AO0yUKX3uGSF0mIjf8yQJMl7YkHGYqJgTDJZP1h86n20fm8kXhA6braf
        i+N0R8XAyqOUIaVwEI7SnJcTWh5mPAtq2nOb9gXWXXQybOBRcP3B5bjPDi4VS/a3VeLQfO1uHVy
        TeuKkxrXqlTfoxZuf8ekmpbCe
X-Received: by 2002:a7b:c416:0:b0:3ee:f1a4:8895 with SMTP id k22-20020a7bc416000000b003eef1a48895mr24722265wmi.24.1680508129717;
        Mon, 03 Apr 2023 00:48:49 -0700 (PDT)
X-Google-Smtp-Source: AK7set/QLZW29OW3qp6xNWoHmkWIeWtEdwT1SlE8g/Kx6N8LT6hbWv9113bPM2hbGNEhVtz4epGwAg==
X-Received: by 2002:a7b:c416:0:b0:3ee:f1a4:8895 with SMTP id k22-20020a7bc416000000b003eef1a48895mr24722250wmi.24.1680508129430;
        Mon, 03 Apr 2023 00:48:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id g25-20020a7bc4d9000000b003eae73f0fc1sm11162407wmk.18.2023.04.03.00.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:48:49 -0700 (PDT)
Message-ID: <a2ff4dde-65ef-3e77-4c6e-b0d3a994dc83@redhat.com>
Date:   Mon, 3 Apr 2023 09:48:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/29] selftests/mm: Update .gitignore with two missing
 tests
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160643.3106892-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160643.3106892-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:06, Peter Xu wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 1f8c36a9fa10..347277f2adc3 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -36,3 +36,5 @@ split_huge_page_test
>   ksm_tests
>   local_config.h
>   local_config.mk
> +ksm_functional_tests
> +mdwe_test

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

