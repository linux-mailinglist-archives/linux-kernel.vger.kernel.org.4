Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219A766BFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjAPNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAPNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9472004B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673875479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XC0yuhfsAzxdKAV8+kZLseSZr9HPn/cM3ZhIZ8eKy3k=;
        b=VyemqRoq8AXrI0MNQIRKf0b8mm+gU+ND2E5YRump1Og7f3F+T95GJHYJ+I8ysxPnRf8F/R
        a/YtihpoCdnVdnnzWSOdZWOeDg0MZ0Lht6ZFWFGwcOeRc2fJpi6VtvMC27ipOFLza8/h2g
        vQ3BZ7Nfd0DbpB/XVtgaQ1AYKNHvDxc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-1OhAzFa1NMChR4g3AeJACQ-1; Mon, 16 Jan 2023 08:24:36 -0500
X-MC-Unique: 1OhAzFa1NMChR4g3AeJACQ-1
Received: by mail-wr1-f71.google.com with SMTP id e29-20020adf9bdd000000b002bb0d0ea681so5337816wrc.20
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XC0yuhfsAzxdKAV8+kZLseSZr9HPn/cM3ZhIZ8eKy3k=;
        b=AwhV4nHUl0Z/JqS343dYlP4mrxn3QQnKJdlOqTRVKe+9XfwATFV9DbJVtS4mLKcMkW
         /Oy/4RfwqsxUz5ZlLIirhVcOnmWuL+oOsZOH61nFvFLsVhZb0ZjwXHRbf32+eoH5CpOb
         phX2x2DkT6zlGbw+gXjyWqShPyItwsTfTpoKA7jZe+krzQMiDINceIT3ivJN+3lP3POj
         mvT0WDGae+MMk2A6R9X0RZdU56qRJWLTJG70NLFhSjzOywb502K1GiPWA6j9UYYUULWp
         zNMHQeGD7fMeViH8hw8t2krCrbd9Lvc3ticxskdDqyzMi5+CLJ1xtu3JhQ6IzJPvhTxN
         +k6A==
X-Gm-Message-State: AFqh2ko2kfhU7Vn5DoZ8b/EUS18odR9VM3cY/OxipCeOVaY3cYWjgu8f
        lNIsqqqNZFRllgOn5tSQG+MdthU1c9EGEWeAmPSm4wwsy1yObbDeVpDjs6YO9BPaS0Kv3BEVtb4
        OYLiUCsoSbDQy5BppfQp1ppF1
X-Received: by 2002:a1c:7416:0:b0:3da:fcf1:d4cc with SMTP id p22-20020a1c7416000000b003dafcf1d4ccmr2416798wmc.30.1673875475155;
        Mon, 16 Jan 2023 05:24:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXun2GD+tbwFUn60JuBqjkqki8t23rFIH3PTJqWBorbr3wFPZTb7NuVUlCpxIhYqh7dOg4Ct0g==
X-Received: by 2002:a1c:7416:0:b0:3da:fcf1:d4cc with SMTP id p22-20020a1c7416000000b003dafcf1d4ccmr2416778wmc.30.1673875474864;
        Mon, 16 Jan 2023 05:24:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1000:21d5:831d:e107:fbd6? (p200300cbc704100021d5831de107fbd6.dip0.t-ipconnect.de. [2003:cb:c704:1000:21d5:831d:e107:fbd6])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003da286f8332sm8390138wmi.18.2023.01.16.05.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 05:24:34 -0800 (PST)
Message-ID: <6f5ac7ee-0af3-a466-cf7f-b17270bc1391@redhat.com>
Date:   Mon, 16 Jan 2023 14:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm] mm: hugetlb: Add checks for NULL for vma returned from
 find_vma. find_vma may return NULL, that's why its return value is usually
 checked for NULL.
Content-Language: en-US
To:     Esina Ekaterina <eesina@astralinux.ru>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230116100520.71277-1-eesina@astralinux.ru>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230116100520.71277-1-eesina@astralinux.ru>
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

On 16.01.23 11:05, Esina Ekaterina wrote:
> Found by Astra Linux on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.

Please trim the subject and move details to the description.

What are the symptoms? How exactly does this BUG manifest? What is this 
patch fixing?


-- 
Thanks,

David / dhildenb

