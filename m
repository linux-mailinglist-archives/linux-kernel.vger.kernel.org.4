Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81794704E61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjEPM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjEPM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E67280
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684241708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcyEykK3oU2aR43SsclKXEYSiS1KO2O1iEjSHmGB+ZA=;
        b=E/PMAng5IlilKjOEGiZc70Gd2REspjWBoDhT2opu2HeEx1GpurSeETRbGyVlqGvhlTr6LK
        vZpi9BbqMHj6xhSyl8QeqsSjZ74t2G9JULJWSI47vq8M1lYb7X8TpNBWYcVnQzPQwv/KD+
        9w5pYaZRRGp9/R6xncQz98dgFbeJodQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-vtbgforPPyeej-mQfyHUOg-1; Tue, 16 May 2023 08:55:04 -0400
X-MC-Unique: vtbgforPPyeej-mQfyHUOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f4245ffb03so63285975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241703; x=1686833703;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcyEykK3oU2aR43SsclKXEYSiS1KO2O1iEjSHmGB+ZA=;
        b=CuOXqQKQCQVieUI2CWSuY7KkbX9VZnusakdjxyZS4yIU5Pqgi5Rv/HPVBX8upRO2Ih
         NaUirqATBNrkFl9L4bxmrYy/zlBSKAceM88DIYxzNgECUj7TRNartDzAEKCn95xtDreo
         AjaTOxPItPuZWgNNksTUbb7uibGLV1qtfzKkeAA4tyZjbXeONd2tMVd916GtYtEtiXQj
         Zu04iVxMCnMyIMgdSDYpOu+ytaEEZD2xB4gZ8Y9YEjWPxYU3LSLZ1Jt8VMal+keCRbVi
         LHhTbH5OL63TzAkqzQFW2pQYHS0DxxYAxsLnntE4vmnd9OxzZY0PujD6gAuAcrOv0vap
         V79w==
X-Gm-Message-State: AC+VfDz/ttR0yVHFjJd7ieExxcoqheTeMY+Gb3JIC43DFsWr8xh5wlwe
        z5pspdr+5IbqM74xXv5/WdsZVVyviZ+EkSrMQm4qpx48mv9eQt6xJXHI0TrX9o0PcZzpZYLQ+bj
        iPy01JVHOAk2ua7kgPiQRnAfc
X-Received: by 2002:a7b:cc93:0:b0:3f4:2bb3:a5bb with SMTP id p19-20020a7bcc93000000b003f42bb3a5bbmr16864223wma.9.1684241703493;
        Tue, 16 May 2023 05:55:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4O9DSGlObFp5mEh5qki+n58oAVDuOhHeEbfmxQ1l2nAU4LVaY/g/d7eIH3LFkvzUt+akGc6A==
X-Received: by 2002:a7b:cc93:0:b0:3f4:2bb3:a5bb with SMTP id p19-20020a7bcc93000000b003f42bb3a5bbmr16864199wma.9.1684241703121;
        Tue, 16 May 2023 05:55:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id o2-20020a1c7502000000b003f195d540d9sm2256533wmc.14.2023.05.16.05.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:55:02 -0700 (PDT)
Message-ID: <72fc50da-c3b9-b71b-209b-9413a8693f13@redhat.com>
Date:   Tue, 16 May 2023 14:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] mm: page_table_check: Make it dependent on
 EXCLUSIVE_SYSTEM_RAM
Content-Language: en-US
To:     Ruihan Li <lrh2000@pku.edu.cn>, linux-mm@kvack.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-4-lrh2000@pku.edu.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230515130958.32471-4-lrh2000@pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.23 15:09, Ruihan Li wrote:
> Without EXCLUSIVE_SYSTEM_RAM, users are allowed to map arbitrary
> physical memory regions into the userspace via /dev/mem. At the same
> time, pages may change their properties (e.g., from anonymous pages to
> named pages) while they are still being mapped in the userspace, leading
> to "corruption" detected by the page table check.
> 
> To avoid these false positives, this patch makes PAGE_TABLE_CHECK
> depends on EXCLUSIVE_SYSTEM_RAM. This dependency is understandable
> because PAGE_TABLE_CHECK is a hardening technique but /dev/mem without
> STRICT_DEVMEM (i.e., !EXCLUSIVE_SYSTEM_RAM) is itself a security
> problem.
> 
> Even with EXCLUSIVE_SYSTEM_RAM, I/O pages may be still allowed to be
> mapped via /dev/mem. However, these pages are always considered as named
> pages, so they won't break the logic used in the page table check.
> 
> Cc: <stable@vger.kernel.org> # 5.17
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

