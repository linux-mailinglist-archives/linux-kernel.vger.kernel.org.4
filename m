Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D56AC20D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCFOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCFOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02226586
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678111173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/wVyxF7X8v5Rihnr47AJpuo/zEUiUXj51F4TpZ8Hk8=;
        b=SXUDk0tCoGZgTXqRkJRpcl/ag3KZ5kY1jcM/UjKw+7hgXWxFGBWaHsLU2OhJlFJKjPPZVV
        Z90yStPFhXst7emgw+s2JwRMcy2D/JKY8tpadtD++8yUrlFbVhWlOaNC7aZcMgYpg0qbtk
        tFFAmarGglCYj8RyJCKQlz78ALRZbhc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-yLEJajxdPmikMb1S00NZpQ-1; Mon, 06 Mar 2023 08:59:32 -0500
X-MC-Unique: yLEJajxdPmikMb1S00NZpQ-1
Received: by mail-wr1-f72.google.com with SMTP id c30-20020adfa31e000000b002c59b266371so1493859wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111171;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/wVyxF7X8v5Rihnr47AJpuo/zEUiUXj51F4TpZ8Hk8=;
        b=1F+DJoPmmYNj4AwXI494StUZmM8ln9Vm/7aFYN05ITX0CQW3UOFCs2qLmhE16bhxz3
         4qvfhW5nqOj+pRf2NQsTvM+AdyP/p4Z0CqjvL3Thn2U08RsMmO7mjqpt5sJo8X+cmnuB
         g+nVEot01OcCJP/SHU58RqEEv2Xvo90P8ukVtB7OfFQhbJdZ3FEIRjdX1IvE5X7NIgh0
         Gsrv6svUqZz/HdWF2O4MS1BecG9hzOB2NHvknnMEDzviShxDJh5hCHgexw+W7oY7Me62
         QgU9ibwRNMIj8I7pPpBoLmKp8HRSIs1rty6BLnmB/wT32j4S+R0ECfvWifPg0A42InpX
         NeSw==
X-Gm-Message-State: AO0yUKXknFs2FZfC1WgDE5+b99P07ko/3tDSHmxCSOKkitAQDkWMlDFk
        XSBmTxa9mK/aKVf8L6xXL3N4J8kznkYYBJoDRtxcegg0zUKrbECTMfny9SzaF8qqmJ2lGCAvqlC
        xh4W/wJ+nkbPJQSmAI3V1WkPU
X-Received: by 2002:a05:600c:4ecf:b0:3eb:399d:ab1a with SMTP id g15-20020a05600c4ecf00b003eb399dab1amr8875634wmq.21.1678111171448;
        Mon, 06 Mar 2023 05:59:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/rppROKlCDe1OMxkgmAULnb3zDPT283NgVkX5TfaUiRMqCs34bM9FlAufSTBytifeaefB1wg==
X-Received: by 2002:a05:600c:4ecf:b0:3eb:399d:ab1a with SMTP id g15-20020a05600c4ecf00b003eb399dab1amr8875617wmq.21.1678111171096;
        Mon, 06 Mar 2023 05:59:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id v28-20020a5d591c000000b002c6e8af1037sm9895953wrd.104.2023.03.06.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 05:59:30 -0800 (PST)
Message-ID: <5f8a3f21-86cb-639e-66d8-9b40a218618c@redhat.com>
Date:   Mon, 6 Mar 2023 14:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/6] shmem: set shmem_writepage() variables early
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-3-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302232758.888157-3-mcgrof@kernel.org>
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

On 03.03.23 00:27, Luis Chamberlain wrote:
> shmem_writepage() sets up variables typically used *after* a possible
> huge page split. However even if that does happen the address space
> mapping should not change, and the inode does not change either. So it
> should be safe to set that from the very beginning.
> 
> This commit makes no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

