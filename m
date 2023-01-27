Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107A67ED38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjA0SOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjA0SOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F12E814
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674843182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7WGrncoPqddvmE8U2wQsFvVbHon5cLOB9FP25bYrec=;
        b=DuNhlDbkJv0cZjparRZDialgDObR1fTgEaz3w9C9r90KeCQ6c11xwVWvZBWT9GRDPuoM/l
        o5L7DVGGSJoWrgTi7c0OnrDqkDMBcqh1w7nJtWesbLLH9lkl4O/Eb85K0zNiaC7sxzgyGD
        1flv1qh59xly3Ir/fAmwz4BC4PWD4rs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-YwwMbjbBN4Ki9RrG9x6TIg-1; Fri, 27 Jan 2023 13:13:01 -0500
X-MC-Unique: YwwMbjbBN4Ki9RrG9x6TIg-1
Received: by mail-qk1-f199.google.com with SMTP id bm30-20020a05620a199e00b007090f3c5ec0so3458719qkb.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7WGrncoPqddvmE8U2wQsFvVbHon5cLOB9FP25bYrec=;
        b=WITtC1ZyHgS+eJXsbC0/O0C2HaoPIcgOZNkXgNL6KwS1mzJDWpB4+LT+9LV9MpWcVY
         vqA+nGbaiSDpj+UxVnHN4cIVC6m6CfsHQQrq7rXcj4KHfq93gckpL+qW0jq1LX3TOpoS
         fbBpxWsjA1DepGwHVzR/oO4RYh3wA0A/ueVEZcX1l/rOM6XpouL/EPubFaT7JDQUpWUO
         2TO/HyakSztNTU4MFgRCPtWXszZnl+Z0rBUMdiC5adXYIVULB0fMmeh/WIKDIvkuDO7h
         uxdMsQq5AVkjfRos0jOjk9Al03aIEUZjNRBecmPhtmk9PEspiHzK98/Ktc190E0Qm6hh
         bkRw==
X-Gm-Message-State: AO0yUKVNv2T+x2GdLlnuuYy4TsAjr8XoSMuan/+xg7BQjyhoUt2S4Ei5
        xwAebm7vyBSzgW9RcpfIllyWkNlQnQ7FMbsSpeHWYKfzDiiDAataECWtmAhSqOKfAn4Vy8ZX5YC
        IVSJ+BguLF8R6M3cLRM/IFJWu
X-Received: by 2002:a0c:dc13:0:b0:537:6a21:7dda with SMTP id s19-20020a0cdc13000000b005376a217ddamr9298273qvk.2.1674843180933;
        Fri, 27 Jan 2023 10:13:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/LhWFtdGo+TCe2msxqlt7AF4oiF71G4o1hcWJdsslSm0W49NjadB3u/cXnh4KLBTUXWKOisQ==
X-Received: by 2002:a0c:dc13:0:b0:537:6a21:7dda with SMTP id s19-20020a0cdc13000000b005376a217ddamr9298244qvk.2.1674843180619;
        Fri, 27 Jan 2023 10:13:00 -0800 (PST)
Received: from [192.168.8.105] (tmo-064-101.customers.d1-online.com. [80.187.64.101])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006fcab4da037sm3384260qkp.39.2023.01.27.10.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 10:13:00 -0800 (PST)
Message-ID: <df451f90-0809-cd99-4494-c930cf4936e5@redhat.com>
Date:   Fri, 27 Jan 2023 19:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH v1] KVM: selftests: Compile s390 tests with -march=z10
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127174552.3370169-1-nsg@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230127174552.3370169-1-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 18.45, Nina Schoetterl-Glausch wrote:
> The guest used in s390 kvm selftests is not be set up to handle all
> instructions the compiler might emit, i.e. vector instructions, leading
> to crashes.
> Limit what the compiler emits to the oldest machine model currently
> supported by Linux.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
> 
> Should we also set -mtune?

I don't think it's really necessary

> Since it are vector instructions that caused the problem here, there
> are some alternatives:
>   * use -mno-vx
>   * set the required guest control bit to enable vector instructions on
>     models supporting them
> 
> -march=z10 might prevent similar issues with other instructions, but I
> don't know if there actually exist other relevant instructions, so it
> could be needlessly restricting.

FWIW, the vector instructions have been introduced with the z13 ... so 
limiting to the zEC12 could be enough.

> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1750f91dd936..df0989949eb5 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -200,6 +200,9 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>   	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>   	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
>   	$(KHDR_INCLUDES)
> +ifeq ($(ARCH),s390)
> +	CFLAGS += -march=z10
> +endif

Starting with z10 sounds sane to me, we still can adjust later if necessary.

Reviewed-by: Thomas Huth <thuth@redhat.com>

