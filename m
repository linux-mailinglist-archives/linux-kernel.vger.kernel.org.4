Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225056AC20C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCFOAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCFOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:00:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA2C1980
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678111153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZbNQdV4FYPtOj26Ts0Bv5UjRK7OPjSiZogSK8fE+7o=;
        b=AWiGjZq1+TmhLriS63ybf2nWXrhJ6lfAUcDkMm1v0Yrc66NFt0SIUPNyQt+bvozKjGMqqV
        1GU2NzaDaPsm0EB1y1hwWNRuTUyOvP4cvy3RT4KJDY/KkThfDPkJA1AuRj/TVqOy7LAFS+
        ICBECsHhyu5/v0g+m8bjRX6/fB59zE8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-FikKV0xFOgGD7jpWfp2mcA-1; Mon, 06 Mar 2023 08:59:11 -0500
X-MC-Unique: FikKV0xFOgGD7jpWfp2mcA-1
Received: by mail-wr1-f70.google.com with SMTP id c30-20020adfa31e000000b002c59b266371so1493628wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111150;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZbNQdV4FYPtOj26Ts0Bv5UjRK7OPjSiZogSK8fE+7o=;
        b=ya20Vi5c8y7lpAAjvL1uSkgdgTt9ugzzCncL1CWTSXKfIefWlBrMHdTW37MB50J6Xl
         k0iUgyuiHY+RwTqZWoLduaa/M/LPI6Y8J7TuOTJ32MzBKwihAQx4QvpY8Jnpy40sk+W7
         LxPNfryf1q9nz6xiP19aFIOTyNYEi0kFab1rpJ4k9oFJpmd9mrBoNGqJBVGY3DuP0e62
         G3NAezhzbHXcow3zEfALe3LVi448VBRjRsqUQMf/Y9U2OsbXi2xxfL83ZaOWtZ0FrPtn
         7HsQvanbVDTuhlFQy9bvsxl1LUej8T03uwkdRYWtXvSvEL9MFAYLDSvr+jMmD6RC6OA5
         KpAA==
X-Gm-Message-State: AO0yUKXbaisHAD53N93YmOwHYr8aJ/BJGVrF+oOP6PULongDsClrpOv1
        KQ8a5Twa08/SX8Wtq8waovQnc0IV0IMQTZNcwCLEw7w3ON1rS0VcrZ55892WrVeeiii/jgMh5VC
        U3hhE2acgZ8SMK+JURaJW++g3
X-Received: by 2002:adf:e492:0:b0:2c9:2292:3f8c with SMTP id i18-20020adfe492000000b002c922923f8cmr6261738wrm.40.1678111150729;
        Mon, 06 Mar 2023 05:59:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8URRo+VuPTwIZlwc9T6VPu4ZprYZJyIpKlbhlSQMnlagDn+3h3JtXbhdydJHdnUOAOO+l24g==
X-Received: by 2002:adf:e492:0:b0:2c9:2292:3f8c with SMTP id i18-20020adfe492000000b002c922923f8cmr6261721wrm.40.1678111150407;
        Mon, 06 Mar 2023 05:59:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id o16-20020a056000011000b002c703d59fa7sm9956231wrx.12.2023.03.06.05.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 05:59:10 -0800 (PST)
Message-ID: <f4b32f05-6396-329b-4bc8-18d4af244279@redhat.com>
Date:   Mon, 6 Mar 2023 14:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] shmem: remove check for folio lock on writepage()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-2-mcgrof@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302232758.888157-2-mcgrof@kernel.org>
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
> Matthew notes we should not need to check the folio lock
> on the writepage() callback so remove it. This sanity check
> has been lingering since linux-history days. We remove this
> as we tidy up the writepage() callback to make things a bit
> clearer.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/shmem.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1af85259b6fc..7fff1a3af092 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1354,7 +1354,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>   		folio_clear_dirty(folio);
>   	}
>   
> -	BUG_ON(!folio_test_locked(folio));
>   	mapping = folio->mapping;
>   	index = folio->index;
>   	inode = mapping->host;


It's still required IIUC. At least for split_huge_page() and 
setting/clearing some page flags in there.

At least split_huge_page() also contains a
	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);

So it's probably reasonable to remove this unconditional sanity check 
here; removing BUG_ON's is always nice.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

