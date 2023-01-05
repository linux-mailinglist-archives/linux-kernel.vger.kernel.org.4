Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED11465EB96
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjAENAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjAENAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:00:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F35A8AB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672923578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Io9oEIwx4ZVMgTyXWJJH24o/hc0ChEoCddN2UNU0iw=;
        b=S7VSWdBsI3Ntx7aKMcamwFqjNXcinmr4WcwBuW+GHPkAFLK3dExqJJdQC7l5bXFucQVnLP
        wbb48RJ2sxJFvUo6W3ZdimXGRZ9GLQNjxN4t3KBuilFZ8gPIG4EmTB+ccuUhzRSh09lHtY
        E4UpiFSNf7s/V+qJvmgR0eme/KjW3ow=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-aseg_AVuPqCBuarAqxEQrA-1; Thu, 05 Jan 2023 07:59:37 -0500
X-MC-Unique: aseg_AVuPqCBuarAqxEQrA-1
Received: by mail-wr1-f69.google.com with SMTP id q3-20020adfab03000000b002b32e25058dso320139wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Io9oEIwx4ZVMgTyXWJJH24o/hc0ChEoCddN2UNU0iw=;
        b=1acyvK0P3QdPqIwebdqMs7Vp6CUU38ylSSxC4MnTcz2V+OONHMMEG19Itbwn9R5q0x
         71c+dMHCEfiIVdssqcJQy1AMorfIWutqy0togliZ/mQQGohDmZ7VSOxqa2bVxjMcxY2b
         fsvpao3wYxgB0bfbISzSOsntLhw5AIcNepOiRpiiLgLKB/P6b0jHg+J24lPqQINTFAow
         S85PfDwaRGQi3gb1uCUtYK9poAGH1HfrhqcU6uKoH83YdiGV12U+v4gnFERibdJvIFMM
         ilnDRTZl0trJNz1vynocx7YDF9XguPlB5C7N6wedzb39f7xZ6XDz0y6LTK8yOZGdvF+6
         Vl2g==
X-Gm-Message-State: AFqh2kqwIVyzYJBkMpk6omgtN2G0Opb8MmAvvQOWEBgv1HOjMmhZDn1G
        56dMlxq8yWqB+a0SUXak4nmhR9aGinTj0kWDxk87C8NhgG1hXSY/BWVkJrwHWSaJ9KS2JOXifyJ
        UQVimLP7LHx0vq+9GT9SOpU+r
X-Received: by 2002:a5d:45d2:0:b0:27a:d81:112e with SMTP id b18-20020a5d45d2000000b0027a0d81112emr24864507wrs.15.1672923576370;
        Thu, 05 Jan 2023 04:59:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtXUz+mkMZ9AJl4nXIAmmeAD2HmzXPErv6XexMRxryYmSjN4WkKzmFDTvQD53QosbC/0LufTA==
X-Received: by 2002:a5d:45d2:0:b0:27a:d81:112e with SMTP id b18-20020a5d45d2000000b0027a0d81112emr24864497wrs.15.1672923576061;
        Thu, 05 Jan 2023 04:59:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b0028df2d57204sm21693381wru.81.2023.01.05.04.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 04:59:35 -0800 (PST)
Message-ID: <2e44fa8a-f3e6-631f-9a18-2bc04b78fb83@redhat.com>
Date:   Thu, 5 Jan 2023 13:59:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/page_alloc: invert logic for early page initialisation
 checks
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230104191805.2535864-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230104191805.2535864-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 20:18, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Rename early_page_uninitialised() to early_page_initialised() and invert
> its logic to make the code more readable.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

