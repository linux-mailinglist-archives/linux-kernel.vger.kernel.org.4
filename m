Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A16A9377
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCCJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCCJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82BB125A4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677834770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kq9Es4dod/cRHyvJfYLinhSyGtDGpFt4oR6h5bY7Ano=;
        b=FFjYX8AdsNxOE1mIDeigdSNxQxYPfumzpWH5DrEV4m9TOrG5KJbtSXQlda/K0nEggt1Rxt
        So7skiZHK2yXWdaI3NcZPeR990VbMAK4KjnxRIi4+JNEzar9T5mZIykVDWaxATLfFj41fF
        3f08GNharkprpzMy5gHV5Sz/uum3Y6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-m0Dc_DmnPG-t9R1xU5_9dg-1; Fri, 03 Mar 2023 04:12:48 -0500
X-MC-Unique: m0Dc_DmnPG-t9R1xU5_9dg-1
Received: by mail-wr1-f72.google.com with SMTP id l14-20020a5d526e000000b002cd851d79b2so271241wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kq9Es4dod/cRHyvJfYLinhSyGtDGpFt4oR6h5bY7Ano=;
        b=B4D55iAPHzgmOVXM7qGeE7bgHuTOR3gL8ESzMdcRzsQclGqrcvPhDgcWSyo82XCcwl
         oP3al6bg0iR4fOKTZm7e/WtjzKqqrM6CF99/KjA8k7PiF8I6y3qYgbcCkxFDBoa+itGn
         KKjI3nigHXdgXdoTBy+LeMQIdmnoYdydOdvN2jnJghuN6T83ealw/OOxxktx9FIxwaOy
         1l4e3eQzB0mtzUsQBvl8qLocEzFU5E7MqGy5zg2n/yUk5CrjFrIw7NJ79ntcDNZzdBBZ
         7mh0UPlB5jRxUjyJbfqWb9cy6zznzeookVRcJfCZ44XzOvg3q8BhoBmGczPVFJRms4cK
         /5RQ==
X-Gm-Message-State: AO0yUKUsRHCdyaFhg033jU8eJPsMbb3/WYKjuy8n5EJrq53jrsEJlCUO
        WhklUM7Yc41QD/wroUghR/J9Sa7h1it1p2er3SuRBTHriv67B1YcV5QJNBblayWpGQQZmeZABm0
        FjG7P1nBs3hRZMLy7wpQU3ZROomqfxw==
X-Received: by 2002:adf:db0f:0:b0:2c7:454:cee8 with SMTP id s15-20020adfdb0f000000b002c70454cee8mr877873wri.1.1677834767746;
        Fri, 03 Mar 2023 01:12:47 -0800 (PST)
X-Google-Smtp-Source: AK7set+DAUgFDorHKQKIsZfhThS3y+tvSbr9vnC86Tsgomh8s9CSHx8Oo8FqL7gE5yuyMiRJFDIVHA==
X-Received: by 2002:adf:db0f:0:b0:2c7:454:cee8 with SMTP id s15-20020adfdb0f000000b002c70454cee8mr877856wri.1.1677834767446;
        Fri, 03 Mar 2023 01:12:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6100:f5c9:50a5:3310:d8ac? (p200300cbc7026100f5c950a53310d8ac.dip0.t-ipconnect.de. [2003:cb:c702:6100:f5c9:50a5:3310:d8ac])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b002c5503a8d21sm1612137wrq.70.2023.03.03.01.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:12:47 -0800 (PST)
Message-ID: <22681eea-fac6-9a51-df43-b5613b75bdaa@redhat.com>
Date:   Fri, 3 Mar 2023 10:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] mm/userfaultfd: propagate uffd-wp bit when PTE-mapping
 the huge zeropage
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
References: <20230302175423.589164-1-david@redhat.com>
 <20230302175734.7be9da18e4724720a12a4b40@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302175734.7be9da18e4724720a12a4b40@linux-foundation.org>
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

>> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Jerome Glisse <jglisse@redhat.com>
>> Cc: Shaohua Li <shli@fb.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Do you agree that a -stable backport is appropriate?

Yes, actually I wanted to include the tag but somehow I dropped it. Thanks!

-- 
Thanks,

David / dhildenb

