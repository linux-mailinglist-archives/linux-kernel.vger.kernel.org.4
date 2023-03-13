Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C806B8138
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCMSzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCMSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2900287DA7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678733560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8VTCHZ3m4KVktMISSoKGR6SbUH6ZBvRQrkruaWACog=;
        b=EGO+3hZIA0H4zRSJHJjXoPKzQZDfqhjZAJOKvFs6GEVtkvISEyfkab+bPjElJwkFy3+2Sw
        M/fmvdf3WOww0Iov2/Bo4t1g4QZdrku80EPxSkDoYyPAIMPsivPfyzjgmszT4cTR9BA129
        qCznwNOncfO+BINF6yCHJuSKK6O/Qk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Y-YIBbnxNj-wi6l7Wbp2jg-1; Mon, 13 Mar 2023 14:52:39 -0400
X-MC-Unique: Y-YIBbnxNj-wi6l7Wbp2jg-1
Received: by mail-wm1-f70.google.com with SMTP id j6-20020a05600c1c0600b003eaf882cb85so4783816wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678733557;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8VTCHZ3m4KVktMISSoKGR6SbUH6ZBvRQrkruaWACog=;
        b=syalKIKV345F8e7LjZNT3AxCvCckEumVQPXZTyQRJmY7GYjUmsyy+10MlbCVaoYIbm
         dHKz5z2qDBRBHL4mLVopNIc5593GoFcsj2P3HWV0OyP9eKBDPTc5leo1PLeF+4Vxhhpo
         LldbZHl65ckeimuSvSgDtBFBOuIHm+oZN7p6Yfq8DDNODtFSo5zb5XuEVByRWCicVedP
         1Yb+uTKSS1eM2lh0M3dJYLQW+ptFFl5XkpZTKI7lcmquQV2L1CynLvMVIFnnc0rXHWs+
         SqnJU0PlVAW85TV32vZv2VTCMtXLP6NS80sQO4n+W1Or1iX2AeYWiN4xGTJMZZhayHy9
         x3Gg==
X-Gm-Message-State: AO0yUKUH9l6/VmhW2cosfN9q7CXpnL0oDyNdiz2sYQs7EGXTBZj4DcGZ
        TrZLKKDMmXR8+gjSoz8gNMiml6CjuWFkAcAk3J7gQe/kXgQ8NrqpgNEpVJiHovehSO303/PMcNp
        uObbvuDdgJvfJKx2NDW1wNAEI
X-Received: by 2002:a05:600c:470e:b0:3ed:1fa1:9030 with SMTP id v14-20020a05600c470e00b003ed1fa19030mr5792195wmo.29.1678733557824;
        Mon, 13 Mar 2023 11:52:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set9TvA6r5EXacliDuiYhZheG2jfGc1duSyGOa9hRsbVnPfgKKBTxKjJo0kQulu/mdvPLWiUXEg==
X-Received: by 2002:a05:600c:470e:b0:3ed:1fa1:9030 with SMTP id v14-20020a05600c470e00b003ed1fa19030mr5792178wmo.29.1678733557497;
        Mon, 13 Mar 2023 11:52:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:7500:9d5c:56ee:46c3:8593? (p200300cbc70175009d5c56ee46c38593.dip0.t-ipconnect.de. [2003:cb:c701:7500:9d5c:56ee:46c3:8593])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bca54000000b003ecc64edf7esm504097wml.39.2023.03.13.11.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 11:52:36 -0700 (PDT)
Message-ID: <662a1ed9-2a40-1082-b893-e5d7e02955b9@redhat.com>
Date:   Mon, 13 Mar 2023 19:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: prefer xxx_page() alloc/free functions for order-0
 pages
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <50c48ca4789f1da2a65795f2346f5ae3eff7d665.1678710232.git.lstoakes@gmail.com>
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

On 13.03.23 13:27, Lorenzo Stoakes wrote:
> Update instances of alloc_pages(..., 0), __get_free_pages(..., 0) and
> __free_pages(..., 0) to use alloc_page(), __get_free_page() and
> __free_page() respectively in core code.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

