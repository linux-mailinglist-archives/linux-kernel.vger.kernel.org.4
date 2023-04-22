Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC16EBB2E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDVUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDVUiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96093E79
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682195841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JtfJn4MJ6gAop5RVC9IkdG/X2lGlmefMlzt0PDQ6GT0=;
        b=Hb6tYVadIG2irmDI0ZoV0hL5n3R3wgxJ2dKq9ErXexpniw5l9ErFUS+3rTn1VHSnb0vD54
        r7hCR9C3oGLNjdnU3Bm1yvloK5cM/wyvd29Lxhwt8SnmsnAvFzfBCCPsge2TacKbuJFdqU
        AFaFQViONPPshmWH0+FFjmJwWZfcd/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-UArOraTyMIKnscIQMFHEXw-1; Sat, 22 Apr 2023 16:37:20 -0400
X-MC-Unique: UArOraTyMIKnscIQMFHEXw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f1912ed0daso6923755e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 13:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682195839; x=1684787839;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtfJn4MJ6gAop5RVC9IkdG/X2lGlmefMlzt0PDQ6GT0=;
        b=WfT//HhmYwMaBBoRNwGD7nDDlGkJbAG0i50WdA7FtNRwFmUAf0pBhFoDSCj0X5ayPJ
         6yu+OECh6gTkBm3oR23FAnQBH/zPvMY0QXl7hwEMvUb4TojKmkumQsFbmgNvZgqQxXen
         CSm5Oh5i/sg+p2LqMWuaSl6cA8nK2hgOuYGtRoDbGGaOBulzPIrXYBJOMFob24mxtoFx
         p/D7brSiMbg4WqvixByJiZIteqir34tjsyg7Ex4zsw8/j1lGYxVuD0PBQNE1+CZvPDl8
         pj/ZSK0EodL1aIDWu7g4l5YrRP8K6zXxGKEHLGfJQ4IFrtZ8b+kxLEE8CX1dWb1C1KcV
         rT9g==
X-Gm-Message-State: AAQBX9c5oQKToIv4x9ecuaG4K1NaJzc2otEFx8eLwLooCycCLvWU8VL6
        MksSeNb+LAStmkb7ijG3sgbmTGC4oC9V8o9yvnsHMCOMGRU4m4jR0rzHcZCC9trsUbxooad6O+6
        78+fTphZXFE0yjFPMLHG4Uk6W
X-Received: by 2002:a05:6000:12c6:b0:2f4:9004:e5d1 with SMTP id l6-20020a05600012c600b002f49004e5d1mr6433261wrx.67.1682195839043;
        Sat, 22 Apr 2023 13:37:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350brEWRc2j/1lTB1hhH396sCW5kPOFS5HHlLH4SuGUb8RXEZYO3FqX77zLOKKoC4NMxhb2GZow==
X-Received: by 2002:a05:6000:12c6:b0:2f4:9004:e5d1 with SMTP id l6-20020a05600012c600b002f49004e5d1mr6433253wrx.67.1682195838693;
        Sat, 22 Apr 2023 13:37:18 -0700 (PDT)
Received: from [10.6.143.183] ([62.37.235.193])
        by smtp.gmail.com with ESMTPSA id i3-20020adff303000000b002f4cf72fce6sm7269623wro.46.2023.04.22.13.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 13:37:18 -0700 (PDT)
Message-ID: <5e46b2e0-3a1c-99c7-d0b9-35b617542f76@redhat.com>
Date:   Sat, 22 Apr 2023 22:37:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] mm/page_alloc: drop the unnecessary pfn_valid() for
 start pfn
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     ying.huang@intel.com, mgorman@techsingularity.net, vbabka@suse.cz,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.23 12:15, Baolin Wang wrote:
> We've already used pfn_to_online_page() for start pfn to make sure
> it is online and valid, so the pfn_valid() for the start pfn is
> unnecessary, drop it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

