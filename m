Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41A6E25C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDNObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F7C669
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681482576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciNfkS+DqWy2PbM1VAL60cecuqn9PuTT/O3WDgTfYTE=;
        b=aDekCmm9SmvVEk0ySrICT0hO/ZDr6X8m5hAFduBYqrUY8lqrNqphBdeR4T4DnOc6e3fZj5
        yJ1VLrLc1cworLTHHIgL38UROlJV8zV9HHqY7jQZMMHPrG1B/3OD7oeThpEh+TocuKACn0
        ahgxxi6Jqsj5T2AVxET7wRUzhOAxNGk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-EoPoNaIHML2vNSd8Jdfyvg-1; Fri, 14 Apr 2023 10:29:35 -0400
X-MC-Unique: EoPoNaIHML2vNSd8Jdfyvg-1
Received: by mail-wm1-f70.google.com with SMTP id f14-20020a05600c154e00b003f0a04fd5b6so3825902wmg.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482574; x=1684074574;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciNfkS+DqWy2PbM1VAL60cecuqn9PuTT/O3WDgTfYTE=;
        b=FNJnmKmYCqm+1vqnww3pjnUfIrjQEa1VLAXNoiY8VLcM4ueJH3qVrw66liDWFn0Fyu
         cseI/NWuM0CFRmt6bBDEYrxt2bl0uzHuR2yUMmMEU6+h0Y/+RodUQa9SnxhdMbF9rXEG
         c/k/JOteFFdeYBFVmIHwuujyJnbwtpTvI7orWXXKMecX5uU/vEeh/H+/ZVH8DgN2LJ46
         9/22pbteC/nstdi68f+VZbmmpu3VdJzFBhuTR5crRFbWV8m3+i3OnUlw8WX+AAruA3Gy
         VD64S2Z7y8aoH3hVU5khMegYvsNqMDiQmt14tPlSS47oCTpMi3NFSuAqWcWWPqx8g2qg
         aY5Q==
X-Gm-Message-State: AAQBX9eoYVM57Pwz5/PFKmDr1le47uhR9OGIw+jxIliD1nUfYKRycQzW
        m8qL2r1gQOtFvcJNRe9dt0Ds3Sks54K24JRzppYGCiWfJLM+sqk/6p6iktUNB0QgPiw3rFIvOWh
        6zrGKzJfTb05xzNEK9RJ+UrxM
X-Received: by 2002:a05:600c:c8f:b0:3ed:2346:44bd with SMTP id fj15-20020a05600c0c8f00b003ed234644bdmr3977790wmb.19.1681482573910;
        Fri, 14 Apr 2023 07:29:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350bI78tIuL9jBC1nxSwxc+mv+j6jNyVJ4ARXBJ1W0tmFVvNnqFckPh69mrWIuRNpCcRLhpWjsg==
X-Received: by 2002:a05:600c:c8f:b0:3ed:2346:44bd with SMTP id fj15-20020a05600c0c8f00b003ed234644bdmr3977775wmb.19.1681482573551;
        Fri, 14 Apr 2023 07:29:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b003ee6aa4e6a9sm8242103wmq.5.2023.04.14.07.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:29:33 -0700 (PDT)
Message-ID: <032003fc-997e-4dad-84d4-1590aeedc8ff@redhat.com>
Date:   Fri, 14 Apr 2023 16:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/6] selftests/mm: Rename COW_EXTRA_LIBS to
 IOURING_EXTRA_LIBS
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
 <20230413231120.544685-6-peterx@redhat.com>
 <1a2544eb-7d42-eda3-fafa-9bed1377841d@redhat.com> <ZDlbdxxfj1yT8ImB@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZDlbdxxfj1yT8ImB@x1n>
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

On 14.04.23 15:56, Peter Xu wrote:
> On Fri, Apr 14, 2023 at 11:52:40AM +0200, David Hildenbrand wrote:
>> On 14.04.23 01:11, Peter Xu wrote:
>>> The macro and facility can be reused in other tests too.  Make it general.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    tools/testing/selftests/mm/Makefile        | 8 ++++----
>>>    tools/testing/selftests/mm/check_config.sh | 4 ++--
>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>>> index 5a3434419403..9ffce175d5e6 100644
>>> --- a/tools/testing/selftests/mm/Makefile
>>> +++ b/tools/testing/selftests/mm/Makefile
>>> @@ -161,8 +161,8 @@ warn_32bit_failure:
>>>    endif
>>>    endif
>>> -# cow_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
>>> -$(OUTPUT)/cow: LDLIBS += $(COW_EXTRA_LIBS)
>>> +# IOURING_EXTRA_LIBS may get set in local_config.mk, or it may be left empty.
>>> +$(OUTPUT)/cow: LDLIBS += $(IOURING_EXTRA_LIBS)
>>>    $(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
>>> @@ -175,11 +175,11 @@ local_config.mk local_config.h: check_config.sh
>>>    EXTRA_CLEAN += local_config.mk local_config.h
>>> -ifeq ($(COW_EXTRA_LIBS),)
>>> +ifeq ($(IOURING_EXTRA_LIBS),)
>>>    all: warn_missing_liburing
>>>    warn_missing_liburing:
>>>    	@echo ; \
>>> -	echo "Warning: missing liburing support. Some COW tests will be skipped." ; \
>>> +	echo "Warning: missing liburing support. Some tests will be skipped." ; \
>>>    	echo
>>>    endif
>>> diff --git a/tools/testing/selftests/mm/check_config.sh b/tools/testing/selftests/mm/check_config.sh
>>> index bcba3af0acea..3954f4746161 100644
>>> --- a/tools/testing/selftests/mm/check_config.sh
>>> +++ b/tools/testing/selftests/mm/check_config.sh
>>> @@ -21,11 +21,11 @@ $CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
>>>    if [ -f $tmpfile_o ]; then
>>>        echo "#define LOCAL_CONFIG_HAVE_LIBURING 1"  > $OUTPUT_H_FILE
>>> -    echo "COW_EXTRA_LIBS = -luring"              > $OUTPUT_MKFILE
>>> +    echo "IOURING_EXTRA_LIBS = -luring"          > $OUTPUT_MKFILE
>>>    else
>>>        echo "// No liburing support found"          > $OUTPUT_H_FILE
>>>        echo "# No liburing support found, so:"      > $OUTPUT_MKFILE
>>> -    echo "COW_EXTRA_LIBS = "                    >> $OUTPUT_MKFILE
>>> +    echo "IOURING_EXTRA_LIBS = "                >> $OUTPUT_MKFILE
>>>    fi
>>>    rm ${tmpname}.*
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Oops, I planned to drop this patch but I forgot.. I was planning to use
> iouring but only later found that it cannot take RO pins so switched to
> gup_test per your cow test.  Hence this patch is not needed anymore.
> 

Yeah, it's unfortunate ... I briefly thought about adding R/O fixed 
buffer support, but it looked like more work than eventual benefit.

> But since it's already there and looks like still good to have.. let me
> keep it around with your R-b then.

Yes, makes sense to me.

-- 
Thanks,

David / dhildenb

