Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6546C1383
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCTNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCTNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6098C167
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679319286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UL6ZvX+vjCKaJ8maGzwsaH5uxn7gh6HZeTFGTMUfwTI=;
        b=Pzbl4aAG3TaolLhhc3l6QdSDcNsXkTiJjtSisTLSXTKheeiAb+a1kVJ6TsX+mq3bIoci7d
        fuLOHHgtakKjz00neQnDG0k+lEsVZ+vB6gMknf4Dlel+rWxcqYGk+CMkoLrCYNFvVcFTq5
        onlKQdPXdNLpQ1h+dj2FvVEgLwnhW+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-DWT6hxrlPmWwuLE8pVKsEQ-1; Mon, 20 Mar 2023 09:34:45 -0400
X-MC-Unique: DWT6hxrlPmWwuLE8pVKsEQ-1
Received: by mail-wm1-f71.google.com with SMTP id bg13-20020a05600c3c8d00b003ed40f09355so5535749wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319284;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL6ZvX+vjCKaJ8maGzwsaH5uxn7gh6HZeTFGTMUfwTI=;
        b=4em8n1ZghtOBFgWsftR8UQ9Ec+Gg+X+I5sDRy639rLxatrG1DiN44qNzJv38f6RzO7
         kb3p2e+IDeU6vX731zvYxNn7ZHFundZPXPuQ5AjbuNQ4sxM4Bh2zjm8KXqNNXrVw1JgZ
         mmNtY9OzKxjUfAWR34SbNFp9RtagUxg6Rf6DgxkeioQbkzSpyGa0gdsbipq+GARCIutY
         zEsk+w77IYhEqsxB2G1kHvWUTkK7t8XwioKmJanO78RgVn5zrxEVcO2Uz7r9DR7VzR3K
         Vh4PNDpztS4kxBheMZAJRd353Z+ru3kRAa6Frk0tRmkVLCaB6kYDGhZBcv3qfBxhuMzd
         +hQA==
X-Gm-Message-State: AO0yUKWz8Kl4208QXNYZWrkkYRpNvS8z7KZeaZCIN2Ej491suieIkd68
        agxXFzBtJ7zfq1M0SSVNB/VRHd6O8MEhoKXErPBQ7tBvce4fZcCi1XEY9hIjIJRAGHgX3ynoPt/
        Z1suFZDQhWwXoSs2zVW576Y9k+U9VCTUf
X-Received: by 2002:adf:dec9:0:b0:2d4:e032:6322 with SMTP id i9-20020adfdec9000000b002d4e0326322mr5820652wrn.31.1679319284010;
        Mon, 20 Mar 2023 06:34:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Q81rpIrERD7ha3OcykcIz8yRM2cmG+OragzAJxFqbYZ6HxK/bVifpz+SZw9IO/LLzXVy7zQ==
X-Received: by 2002:adf:dec9:0:b0:2d4:e032:6322 with SMTP id i9-20020adfdec9000000b002d4e0326322mr5820642wrn.31.1679319283724;
        Mon, 20 Mar 2023 06:34:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id b4-20020a056000054400b002d672637520sm3454972wrf.96.2023.03.20.06.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 06:34:42 -0700 (PDT)
Message-ID: <70d9bf96-2623-d617-c03d-3c7f6c5cbf8b@redhat.com>
Date:   Mon, 20 Mar 2023 14:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: mmap: remove newline at the end of the trace
Content-Language: en-US
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <ZAu6qDsNPmk82UjV@minwoo-desktop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZAu6qDsNPmk82UjV@minwoo-desktop>
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

On 11.03.23 00:18, Minwoo Im wrote:
> We already have newline in TP_printk so remove the redundant newline
> character at the end of the mmap trace.
> 
> <...>-345     [006] .....    95.589290: exit_mmap: mt_mod ...
> 
> <...>-345     [006] .....    95.589413: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589571: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589606: vm_unmapped_area: addr=...
> 
> to
> 
> <...>-336     [006] .....    44.762506: exit_mmap: mt_mod ...
> <...>-336     [006] .....    44.762654: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762794: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762835: vm_unmapped_area: addr=...
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   include/trace/events/mmap.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

