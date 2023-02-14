Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36769631C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBNMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjBNMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A944211D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676376467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnnGhci8G9bgg/cHSUev+SUa0D8kZiVN6LjQKlMVnJQ=;
        b=aqip1uK3xcEtE30+Ke1O9umXz4LKNPig44Hd3zFWGFxbhKUURVnS39t9Y4QOeew8U/Ot/f
        s+gkBTo7DcU6LsZ4odnzbHAZUi36iJ5tebmXCZVp7Ye3HQRZVLvqr2NE1zubiG5b42gwvd
        UGEHbKYOB+OFZmk1u/lXN5DUcUGKrwg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-WE2jToyyPZisQzcBoMsOWw-1; Tue, 14 Feb 2023 07:07:43 -0500
X-MC-Unique: WE2jToyyPZisQzcBoMsOWw-1
Received: by mail-wm1-f69.google.com with SMTP id o2-20020a05600c510200b003dc51c95c6aso455521wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnnGhci8G9bgg/cHSUev+SUa0D8kZiVN6LjQKlMVnJQ=;
        b=JEKibyfEp2qoLVzT22wD4tb4kcRQjjLs6JVYFDQ+6RE7UGdeLpq+ZwTKHYNLbfZVfb
         foO5T4PyU4hwXaDcrlsRK1jGm1UZWfdpaatlbTXlQurg12lWPo8qX9Zcz21+sqVu8cqs
         W/KHHhMQ2KQhdvuhl0Hvj9lM9lPuwdqJrPDOLw2RPs5FKphw3+qDd3JfsGg/RBSHAseP
         kLkbRQopOBs+4pyqCB7iRTZ//NltF7rK23hoCeGvQUoZ3xUVyFnqKAtpkfU+ZAISjcdp
         +6VV/N1k/uTkSd4Is/fpXaPod2WLge32MXP7VqyE0VajIfTibeHB8wUrWdexAzmmCH9p
         /xGQ==
X-Gm-Message-State: AO0yUKWL/O7bf62NMPzPU2z+uLlvUzf6sb0PdE8zGKgsud0YRZa6iY/v
        qX1CKrEW6JOMJ7F275Sy0VNBP2V7/BGjWhaKbUoWXPI6GAIbXLlpM34OPVIYTpgb4j9hhvDerD8
        iYlqbLKU1J2r8OEyffMYcGlfP
X-Received: by 2002:adf:e909:0:b0:2c4:71d:244c with SMTP id f9-20020adfe909000000b002c4071d244cmr1857465wrm.25.1676376461738;
        Tue, 14 Feb 2023 04:07:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9JVRyPcksBjwU0iydRKtoaY2OusW9u5eIsJUAzolbLk6gP3ogyJcalxK/ei33Tej8x/threg==
X-Received: by 2002:adf:e909:0:b0:2c4:71d:244c with SMTP id f9-20020adfe909000000b002c4071d244cmr1857443wrm.25.1676376461512;
        Tue, 14 Feb 2023 04:07:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002c54d970fd8sm8754308wrq.36.2023.02.14.04.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:07:41 -0800 (PST)
Message-ID: <7533a41d-4e43-cdcf-e5fd-ba10f53c9b3b@redhat.com>
Date:   Tue, 14 Feb 2023 13:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] [RFC] maple_tree: reduce stack usage with gcc-9 and
 earlier
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vernon Yang <vernon2gm@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230214103030.1051950-1-arnd@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230214103030.1051950-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 11:30, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-10 changed the way inlining works to be less aggressive, but
> older versions run into an oversized stack frame warning whenever
> CONFIG_KASAN_STACK is enabled, as that forces variables from
> inlined callees to be non-overlapping:
> 
> lib/maple_tree.c: In function 'mas_wr_bnode':
> lib/maple_tree.c:4320:1: error: the frame size of 1424 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Change the annotations on mas_store_b_node() and mas_commit_b_node()
> to explicitly forbid inlining in this configuration, which is
> the same behavior that newer versions already have.
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

