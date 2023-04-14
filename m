Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3F6E1FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDNJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDNJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567955FD3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681465964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36cFCzN7i4Qa6Nw/h904auZ24hEonHUCle7ZOEbyOEY=;
        b=YYfg1LA1EjOEgTQbWahD/YH6zwekq27h1tuROaUpHScMnZfKjee8u9wAL4EDmyuuExorBE
        xiTN41Af7MkEI1dB07uIOjIWsWX/CNVR4NYE1D/gZ1tMNu8CedliAHIc9gQV72asTNXEto
        TFjp0wlalW3PwFUIAwfgv1IxtwY5hM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-6_V8UiXIMdKZfKioBnkWSg-1; Fri, 14 Apr 2023 05:52:43 -0400
X-MC-Unique: 6_V8UiXIMdKZfKioBnkWSg-1
Received: by mail-wm1-f69.google.com with SMTP id h8-20020a05600c314800b003ef649aa8c7so5609246wmo.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465962; x=1684057962;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36cFCzN7i4Qa6Nw/h904auZ24hEonHUCle7ZOEbyOEY=;
        b=U/FGSqXFzzihQy8RqLOr6VbTxzkcO9cC506MxFxCC/YCYx+vIqt+wAzTGdlr7bTde2
         SF7/fKdwAdx5kJ3A5aJZ4bvQjNP3uwXfiSC4ppaZ+oKfbeivbqo6pVAALOMB20aNtOaz
         nXQC9Fji1Vaxddt/fiBX9vlSuU5Eu5UjXnjy60UxGY7DiO0stE99v8TBrVer0u4f90fz
         k73h/FfG4cdzWUDJfi0ME9jToI5xrEK3eymSZAitR2IP7gnrYyxhnx0DxaFC/gDHZMgz
         WR/4VvhoUP5GdL5T8z5wr2Qe4ChLbqFydZhlKH7XKNduD+2mojm43E1sCJ1b2ZRgoSof
         wSAw==
X-Gm-Message-State: AAQBX9f6HAAR8NNzX+Yln6xy4ij9edR2fRdilEFEijDllGBhbi9h7IxP
        Z8Icqn5UmYfjqRt/diz1xR9mCRPMG1WG/wajVqdX5ta+4JBpWlZsx/3+RYZLBp7SlK+CQY5SU51
        OkmWDZeb9QLxBOdakV5S/bnOu
X-Received: by 2002:a7b:c395:0:b0:3f0:3a5a:362e with SMTP id s21-20020a7bc395000000b003f03a5a362emr3968641wmj.39.1681465961962;
        Fri, 14 Apr 2023 02:52:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350aRy4TRCmo8oxHFnjtdO3wCEfkusFzgY7VdMpgtuzV9kgTe6yTmTkleM0kONQ2A7d6Cj0V0dA==
X-Received: by 2002:a7b:c395:0:b0:3f0:3a5a:362e with SMTP id s21-20020a7bc395000000b003f03a5a362emr3968630wmj.39.1681465961622;
        Fri, 14 Apr 2023 02:52:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c1c0400b003ee8ab8d6cfsm7721232wms.21.2023.04.14.02.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 02:52:41 -0700 (PDT)
Message-ID: <1a2544eb-7d42-eda3-fafa-9bed1377841d@redhat.com>
Date:   Fri, 14 Apr 2023 11:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/6] selftests/mm: Rename COW_EXTRA_LIBS to
 IOURING_EXTRA_LIBS
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-6-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413231120.544685-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.23 01:11, Peter Xu wrote:
> The macro and facility can be reused in other tests too.  Make it general.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/Makefile        | 8 ++++----
>   tools/testing/selftests/mm/check_config.sh | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 5a3434419403..9ffce175d5e6 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -161,8 +161,8 @@ warn_32bit_failure:
>   endif
>   endif
>   
> -# cow_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
> -$(OUTPUT)/cow: LDLIBS += $(COW_EXTRA_LIBS)
> +# IOURING_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
> +$(OUTPUT)/cow: LDLIBS += $(IOURING_EXTRA_LIBS)
>   
>   $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
>   
> @@ -175,11 +175,11 @@ local_config.mk local_config.h: check_config.sh
>   
>   EXTRA_CLEAN += local_config.mk local_config.h
>   
> -ifeq ($(COW_EXTRA_LIBS),)
> +ifeq ($(IOURING_EXTRA_LIBS),)
>   all: warn_missing_liburing
>   
>   warn_missing_liburing:
>   	@echo ; \
> -	echo "Warning: missing liburing support. Some COW tests will be skipped." ; \
> +	echo "Warning: missing liburing support. Some tests will be skipped." ; \
>   	echo
>   endif
> diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
> index bcba3af0acea..3954f4746161 100644
> --- a/tools/testing/selftests/mm/check_config.sh
> +++ b/tools/testing/selftests/mm/check_config.sh
> @@ -21,11 +21,11 @@ $CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
>   
>   if [ -f $tmpfile_o ]; then
>       echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
> -    echo "COW_EXTRA_LIBS = -luring"              > $OUTPUT_MKFILE
> +    echo "IOURING_EXTRA_LIBS = -luring"          > $OUTPUT_MKFILE
>   else
>       echo "// No liburing support found"          > $OUTPUT_H_FILE
>       echo "# No liburing support found, so:"      > $OUTPUT_MKFILE
> -    echo "COW_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
> +    echo "IOURING_EXTRA_LIBS = "                >> $OUTPUT_MKFILE
>   fi
>   
>   rm ${tmpname}.*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

