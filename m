Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE55717890
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjEaHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjEaHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1DE93
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685519108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOB0vfWNd/3N8aaFlpLooYega2vQlYMAF6QRKGMinKw=;
        b=SgKW5bvKzHs+C7ZZ7M5tTjy1Gk9DtRdFGjxpnhskVogZ3lqL0vJeglKtSUBrHh6CgzXZyl
        vECG5Ni20hQWwbVupLIZtukCQGOFEfmkbzVKfbBqE0H+OHVMffNpQ7h/caWwcdnl8VhF4/
        dGLj9tBpAwDcJQ8133XJVndoeEzqR3o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-y-FseXIoOLKi6yTHrRHwnQ-1; Wed, 31 May 2023 03:45:07 -0400
X-MC-Unique: y-FseXIoOLKi6yTHrRHwnQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30aa5fb26b3so3312323f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519106; x=1688111106;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOB0vfWNd/3N8aaFlpLooYega2vQlYMAF6QRKGMinKw=;
        b=gi5kohd9UGTNAakt5rTa7qsBx1iSdZYjZeSeEB8s8vVKZNtX6HSEsjPifzGrUgj1cR
         K4Y6MriQnsRUMLaRl6YN2Xbdeszd+0TaCrTR8sYjcNMiarKF2Fmf8tEc6wfCjeddep34
         K8hxwNhd3LA/H2qrEjbgpK8XIPDqJvqcjoXRedE+mvSPKDR15q5LRW0sZwZB2JoCCc+v
         yIRHtv7lyTt5nNEqJcXwmQBnDbBAQS6SK3qgjIBMbiSkzz3dyXxiWi+Hy1/d/L7U3TSW
         bhtuPXTOyVF4lIlfMw/ctBGgBfpKgk+fU56upBrnci7J0jJOnMe1DdYrV1kdEBUj5gRo
         +uSw==
X-Gm-Message-State: AC+VfDxRp5rwSgQwYiv0Mv18TjA19yZCyNJiG6EHEmm+JwhFjPKfOpFy
        GL/UQsOptDPwhRK4iP9ClG2/IqTf43ovaJB4ExkbW1kx0VzaI/YxBBasmeeCjCdM7GDo2SICUSY
        Fb2BeCqHQXqNUIZ6gbPUYJwc+
X-Received: by 2002:a5d:4cd2:0:b0:307:a52c:26b4 with SMTP id c18-20020a5d4cd2000000b00307a52c26b4mr3221204wrt.66.1685519106538;
        Wed, 31 May 2023 00:45:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vHaOAB4dSjF4uctl0lqe2UkA9cnoir5JVWgD45qApy0tRQfcKjzysYCBklfFSSYDvAZh1YQ==
X-Received: by 2002:a5d:4cd2:0:b0:307:a52c:26b4 with SMTP id c18-20020a5d4cd2000000b00307a52c26b4mr3221182wrt.66.1685519106183;
        Wed, 31 May 2023 00:45:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4741000000b002f9e04459desm5686117wrs.109.2023.05.31.00.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:45:05 -0700 (PDT)
Message-ID: <5151bb67-550b-87f1-f656-20683052b0aa@redhat.com>
Date:   Wed, 31 May 2023 09:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V3 2/5] swap, __read_swap_cache_async(): enlarge
 get/put_swap_device protection range
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-3-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230529061355.125791-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.23 08:13, Huang Ying wrote:
> This makes the function a little easier to be understood because we
> don't need to consider swapoff.  And this makes it possible to remove
> get/put_swap_device() calling in some functions called by
> __read_swap_cache_async().
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

