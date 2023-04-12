Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097376DEEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjDLIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjDLIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227186A8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681289036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/hXxn+yXaBHFr3p7Aq6yPxQrR1AxmJJ59WzgjnicMk=;
        b=e8Pjp/tuWe4XYthB+okNox9KqtIqR80U0v6YDdSK4LgGRTkq/lio+PU8jKhofzfhRwNhmN
        D2T8Snty7T8Tmcc20QeE7oS8vuxZ7ueO2PY3ohNCPbU2Z2xX2ToixrMw8l/MCuTIfKiJK/
        mXVnmjRGj88OfLIfQftb9xGfZrIYbxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Av2puyv_MQ-udMhezCV7cw-1; Wed, 12 Apr 2023 04:43:55 -0400
X-MC-Unique: Av2puyv_MQ-udMhezCV7cw-1
Received: by mail-wm1-f70.google.com with SMTP id h15-20020a05600c350f00b003f09815147dso1024515wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681289034; x=1683881034;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/hXxn+yXaBHFr3p7Aq6yPxQrR1AxmJJ59WzgjnicMk=;
        b=0uRo2bDG6LW8inK/oit+fojTwHZV9HcDm9qcybs7hgYFirUjt88pkTKQshB2ADkywc
         +3NV6mDa7jSXaA2D2SMhUVucWrH6UHYrHxccGPTGV/wkJhA0MYAkIPunU+sXf9o2nyEW
         lsVxOA0bJqB1zcKAu83F6L3zZwi+CpAy/5fazug4ldLRgvlFtGFhMuSDH1WGbKQdM86/
         dmiT5LAAi7ZSKMqtH8u6Bq9xT/9eVmdLUeBauLgIeMBmVwSc7PjARTsYP0Dg4WSJVMc/
         xPQNtJRAxaw9d8By7DmSHFbxEm2od2B5FPEOnV8ZbVk6swzkNVhHz1JXQc9VFafl+QZA
         fH0g==
X-Gm-Message-State: AAQBX9fLBAYZr/QnuLAo28LQASGAeHBVo41fhgUViHkDL+raVIczQcZc
        9rYNJFBBkgE9+l2JFcOUDAQL0eR+LkomscsWZrIaI9Xgz9lxHDJTwDpAfmtU8iDxYhc5vXNRlo5
        XBcVfs/0aCnDtoLW+yWsvFJqV
X-Received: by 2002:adf:ed91:0:b0:2ef:3980:87e0 with SMTP id c17-20020adfed91000000b002ef398087e0mr8026937wro.64.1681289034013;
        Wed, 12 Apr 2023 01:43:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350YAf16IuVo77Vevj7O1avN+jEH7YlsbUOO6l+PFz+Tq7rE5m5pRlSuGi74pD6b6XHxqd8bFDw==
X-Received: by 2002:adf:ed91:0:b0:2ef:3980:87e0 with SMTP id c17-20020adfed91000000b002ef398087e0mr8026924wro.64.1681289033659;
        Wed, 12 Apr 2023 01:43:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id e10-20020adfdbca000000b002ceac2ccc4asm16610129wrj.23.2023.04.12.01.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:43:53 -0700 (PDT)
Message-ID: <5db8766d-2574-7904-f112-80a862335a5d@redhat.com>
Date:   Wed, 12 Apr 2023 10:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/rmap: convert __page_{set, check}_anon_rmap() to
 folios
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230412021811.1503281-1-yajun.deng@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230412021811.1503281-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 04:18, Yajun Deng wrote:
> The 2nd parameter in __page_set_anon_rmap() is only used by
> SetPageAnonExclusive(), so there is no need to put
> SetPageAnonExclusive() in  __page_set_anon_rmap().
> 
> Remove SetPageAnonExclusive() from __page_set_anon_rmap() and modify
> __page_set_anon_rmap() to __folio_set_anon_rmap().
> 
> Since __page_check_anon_rmap() needs a folio, we can directly use
> and change it to __folio_check_anon_rmap().
> 

Leaking the SetPageAnonExclusive() into all callers is not an improvement.

Not convinced we want this patch TBH. Tentative NAK.

-- 
Thanks,

David / dhildenb

