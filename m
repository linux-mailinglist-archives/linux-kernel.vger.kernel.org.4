Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C46D3E73
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjDCHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC824C1B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jtAbpQHxeVH0bO9L6ZJVIkBiW9knfyq71fuN73ZuVU=;
        b=ezJ/i0QmWk54aovxos/BM66Vx8cQO83xyQIdtQHTBrfPfWxcrtyhwcdrB0O28thSJXYnGz
        rlehmmnUkCC1ZoIKrL0+Kx+fIvI34tK1tBD2DxLTMRjJbdkb0T65GAkt1cbDOiwO4PoPE8
        nvEeJZZqnOmY43gevRvZFFxzNA2yrI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-4bVy-WTEMvKO53In0zYZZw-1; Mon, 03 Apr 2023 03:53:11 -0400
X-MC-Unique: 4bVy-WTEMvKO53In0zYZZw-1
Received: by mail-wm1-f72.google.com with SMTP id p10-20020a05600c358a00b003edf7d484d4so14346303wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508390;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jtAbpQHxeVH0bO9L6ZJVIkBiW9knfyq71fuN73ZuVU=;
        b=qpm5pAmP4ycw164DjSRpex1xMMUY6bYunfh+fm9pKtusrt58emic/LSsxP1n5MOGAG
         NKWs/WQMB0+ryKbjhsDtiOTA785eIh51uZH9LojdaFCKVBkpslb4YQKHGL0ToPGE+TjB
         s6fobiAJ28y84AH0bKRWJy8AlZzJPdeN7e+44iAhAQzRtALMep+4J+MuP/ho+vhnoGFu
         Ba+6x8IOTQTSIv0aJ1OPQ1K40kIgiJgQezd6sPFWtX5f9qlYSS2vlmoyXgJe241wZhYK
         NqfWiqf1kS/epW48xt/mSSQnk5jen0e0juXZQr3CG50H5gI5L/iJuWTw9CLuucymjkQF
         Iuvw==
X-Gm-Message-State: AO0yUKVuD3nyTfP0ieSJXjSaGpcgteJdnWd+TSNveHrX8TcFayIsd2a7
        gfE/rn2s8WAaf+TkpeNeKut1pXmVKewZ1jYhE07M5D8e6oAN8jvsc1bjwj0dO2/c7ZcE5g1ao7M
        P7owBY7+Rs5kvFqXP4+cc+sVU
X-Received: by 2002:a05:600c:d5:b0:3ed:bc83:3745 with SMTP id u21-20020a05600c00d500b003edbc833745mr24992362wmm.25.1680508390750;
        Mon, 03 Apr 2023 00:53:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set/lWjuBT98j/Te72N2ovb1mUi4Jlu+/DWCvpVEri851m+W70GKzpEAiCq3OUqkn2zotbrBp+Q==
X-Received: by 2002:a05:600c:d5:b0:3ed:bc83:3745 with SMTP id u21-20020a05600c00d500b003edbc833745mr24992348wmm.25.1680508390455;
        Mon, 03 Apr 2023 00:53:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b003ee70225ed2sm11262998wmc.15.2023.04.03.00.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 00:53:10 -0700 (PDT)
Message-ID: <7cf8f38c-ae54-1440-e1f6-51a44e87e0b7@redhat.com>
Date:   Mon, 3 Apr 2023 09:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 07/29] selftests/mm: Merge default_huge_page_size() into
 one
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160705.3106966-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160705.3106966-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:07, Peter Xu wrote:
> There're already 3 same definitions of the three functions.  Move it into
> vm_util.[ch].
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

