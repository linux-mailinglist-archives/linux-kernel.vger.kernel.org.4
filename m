Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881BB662BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAIQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbjAIQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E450E5D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673282888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2s1dO3gCdbWAdquiI2zGRPT9LhkQGJcjuyv4u6/GZVA=;
        b=MIF3nzLwmUVWaDqUMVQyRi6cA2zSLeLfnlEERy6SLmbqgTxmN1TEg0zME0K4G6D5eM+aAi
        zHCvjhyQUnGd55fPWEWfA7O9rGH0evfSxeKVMBlHX0efEa97h1jBUZBFRL4vG/zNseIrrX
        dZFY3A0RgqBnq59WrkwC1SELg/hSd4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-X5rtstB4NZmu4zwBuP7ioA-1; Mon, 09 Jan 2023 11:48:07 -0500
X-MC-Unique: X5rtstB4NZmu4zwBuP7ioA-1
Received: by mail-wm1-f70.google.com with SMTP id m8-20020a05600c3b0800b003d96bdce12fso5008151wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 08:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s1dO3gCdbWAdquiI2zGRPT9LhkQGJcjuyv4u6/GZVA=;
        b=4qkY8JorL3yWXSwWV4etgbzFS2RiiZpCUqL8TXN04Fhqegb1FnYbmLhLwQk2LPpyoR
         ZADn322Z2gjxJ3mJ41SXxJ8s0vyFQ6Is7Zg7FqmrVDOhgjv5BXEcHCJs9GvlYRoEFmwM
         imk8Piy9odIi6RQbtGrnux99u/Cmx9bhi/6Sq3e9EcijQUNBRW/3LP3fRDcj6F0vweWP
         erzmHr3TlsjwL7LmEx3AGrk4ScyYXkvRI0m8nZjbfg4nCorkhW+VQLuJhqIPv46d+YSb
         rnH+lM0/cU1uzRyEY3hEl7jxLSNjxuPxtmJwOfUQGFDlYSUJ5CgK3tREBIDzgXLPl9Me
         VIzw==
X-Gm-Message-State: AFqh2kr5sKNlfFhCSzVR/9a6lNJuiLqwjYnZHtwy23l3183NHGkmD6mr
        mI0gJSN9KVdHL1LUjxRoMmIw0KhuUOWrKAu4XZ6t77Uqdkcp3/0gOLU7BCx0F9Sp8EKA7iYrYxs
        eF1pGVeZdfkKDhPOA9lpLKciW
X-Received: by 2002:a05:600c:1f18:b0:3cf:5583:8b3f with SMTP id bd24-20020a05600c1f1800b003cf55838b3fmr45517040wmb.20.1673282886651;
        Mon, 09 Jan 2023 08:48:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtu0/JPsHnmz6xcFkEARE/Iy3w35DOqPfisg95gJxVPLJRvEuDTNXy6tcUgsVAAsa2ugkeWHg==
X-Received: by 2002:a05:600c:1f18:b0:3cf:5583:8b3f with SMTP id bd24-20020a05600c1f1800b003cf55838b3fmr45517022wmb.20.1673282886428;
        Mon, 09 Jan 2023 08:48:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:8f00:ba3:7d27:204f:8e29? (p200300cbc7038f000ba37d27204f8e29.dip0.t-ipconnect.de. [2003:cb:c703:8f00:ba3:7d27:204f:8e29])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003d1f2c3e571sm18434117wmq.33.2023.01.09.08.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 08:48:06 -0800 (PST)
Message-ID: <721f677e-02a0-271a-2181-404873816f71@redhat.com>
Date:   Mon, 9 Jan 2023 17:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: remove PageMovable export
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230106135900.3763622-1-gregkh@linuxfoundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230106135900.3763622-1-gregkh@linuxfoundation.org>
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

On 06.01.23 14:59, Greg Kroah-Hartman wrote:
> The only in-kernel users that need PageMovable() to be exported are
> z3fold and zsmalloc and they are only using it for dubious debugging
> functionality.  So remove those usages and the export so that no driver
> code accidentally thinks that they are allowed to use this symbol.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

