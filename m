Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C066C37B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjAPPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAPPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA7244A9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673881972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8GPUBKE/NuQUsbNLJNTHyoSEwq0B/JvfXQkuCQI2A8=;
        b=idC36IR4LPDpNv81yqOPbPfR73TcyM/WR1O3JiWR3bJsX31IVn9GWNHU1039FcZCZodsbZ
        886Xior5pK/OYqLxNB9NZVwFmdTfqPtElBB8Yr5SlaVQmpHMsBGRkhoe7254iTx3u1zZCG
        oiAsTAECeKCkouDNQQNrjjp7g+zbtFI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-bR3A6SUwM8WY3O2uYLMEUA-1; Mon, 16 Jan 2023 10:12:51 -0500
X-MC-Unique: bR3A6SUwM8WY3O2uYLMEUA-1
Received: by mail-wm1-f71.google.com with SMTP id t24-20020a1c7718000000b003d1fd0b866fso6073498wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8GPUBKE/NuQUsbNLJNTHyoSEwq0B/JvfXQkuCQI2A8=;
        b=BvtZOzIMOrYQRT2+QCF8Y0yEMFM4vMRRKrgRFHqg3jaPLYXMbMI7NZl9pD406h8/pt
         cPaw7ea0Z7lK9bRp4y02+4Zdn7tQollKuOK+PtP0ZMkTLE8O3EIjO9KOghrqCyvaJRe4
         RRyAxQu+9syl4xxvZQh2yYLZzKnRuifhgQ8hQwZZhGegQFOT/5aL9GEg+OE7oDhYTiwA
         k3JyIf2OP0wV7umw0VGud/R/mJup//j/1oRps5SooYQOKjq91A65OfPdt9h8/p0nNDGw
         g+AbYYpb8Uwzomctlph5y8PFT9+RlisCYy3ERgslE3/skzg/3VtW7u7jUBlEPiyFesPa
         ueHg==
X-Gm-Message-State: AFqh2krlGztfkJyOQGNhttzekUwYv96xvevVR0egLf17VwQTL2Up+GEC
        a1975StyWFiuAhu93Y5grXm2I0VkDHnwFEBdNRLz/gj16gSKa2sMnxtRusyD881ZsN2MtMMR127
        E+BNqjUzNtbKlT15dOZm8TLyH
X-Received: by 2002:a05:6000:120e:b0:2bd:d948:3c3e with SMTP id e14-20020a056000120e00b002bdd9483c3emr12425228wrx.19.1673881970300;
        Mon, 16 Jan 2023 07:12:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuYQj0NYJaAaPUwl6DhsnV5BhYVrjbmEgaQQaWjKL2U5u+qrkhqwf+J8sfH/rU5oiS9MVZzwA==
X-Received: by 2002:a05:6000:120e:b0:2bd:d948:3c3e with SMTP id e14-20020a056000120e00b002bdd9483c3emr12425214wrx.19.1673881970037;
        Mon, 16 Jan 2023 07:12:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1000:21d5:831d:e107:fbd6? (p200300cbc704100021d5831de107fbd6.dip0.t-ipconnect.de. [2003:cb:c704:1000:21d5:831d:e107:fbd6])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b0027cb20605e3sm3243298wrb.105.2023.01.16.07.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 07:12:49 -0800 (PST)
Message-ID: <a402b90d-372e-2774-d2c4-ceae64c6eed2@redhat.com>
Date:   Mon, 16 Jan 2023 16:12:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm] mm: hugetlb: Add checks for NULL for vma returned from
 find_vma. find_vma may return NULL, that's why its return value is usually
 checked for NULL.
Content-Language: en-US
To:     =?UTF-8?B?0JXQutCw0YLQtdGA0LjQvdCwINCV0YHQuNC90LA=?= 
        <eesina@astralinux.ru>, Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230116100520.71277-1-eesina@astralinux.ru>
 <6f5ac7ee-0af3-a466-cf7f-b17270bc1391@redhat.com>
 <182575210.374192581.1673881818398.JavaMail.zimbra@astralinux.ru>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <182575210.374192581.1673881818398.JavaMail.zimbra@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.23 16:10, Екатерина Есина wrote:
> Sorry, I've noticed that I'd sent the patch without description and sent 
> version 2.
> Function find_vma may return NULL, that's why its return value is 
> usually checked for NULL. In this case vma and its fields also should be 
> checked before dereferencing to avoid NULL pointer dereference

Thanks, but again

What are the symptoms? How exactly does this BUG manifest?

For example, does the kernel crash, and if so, how can it be triggered?

-- 
Thanks,

David / dhildenb

