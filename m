Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DBD6C102B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCTLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCTLE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7AB1E286
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679309943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIFtl/CdbkvqlgRRGw1TYckYM/MRLzEp0Cl1ZbWEyfY=;
        b=DkhL8Dd5ijPXAtwCFz/Jq1iu715MsOj9fFXyO08CE4bhQbKxlw8wuZm17LYHmZLVWtrzUe
        QvkLbXPSUWZJGgPR7T6f4kNfUQJDDtUQVjStbXeEaFqpuiBcPBtDmhrmtPMRaLTsPjdr9T
        s1aX7hy//Znf2E38wHUx6U0SLT7rhWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-2RCwgsjcMlWDfOMziru_4w-1; Mon, 20 Mar 2023 06:41:44 -0400
X-MC-Unique: 2RCwgsjcMlWDfOMziru_4w-1
Received: by mail-wm1-f71.google.com with SMTP id j10-20020a05600c190a00b003eda80e8086so2653133wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308903;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIFtl/CdbkvqlgRRGw1TYckYM/MRLzEp0Cl1ZbWEyfY=;
        b=hKiB9BciuGoEfdSFXV0jsWw1hHH2XzyTm9K7OaNXSHFrO+tk5YO4xP9u9Wnoo6bklb
         Nfa/unk1jxCPorZt7Eq4AEM0C55UEkE+QgvgB8s2n/ynlFdrmis+1B2Ri4e/mbReMOSt
         idChAeyE+eSTpFsWQvHNyYrwS1A8x+eMqTQf5DtYHS/V3G4ycuUdCssLeTZO3/MyZjil
         afORf7o3j/9LucEBNXVv7Jsj3aE5pdfJyiUbkLXzLrQJJoAV50mKGFelf/XpMaddlG7R
         PdsN1v1e8mkqfqK4SqxEzyy1zbMoGO2aEYraiQ/1S/lY6TGYIdclR0UaFQE6LQBwzW3x
         exTg==
X-Gm-Message-State: AO0yUKXu4VcR3l0azVt+CvhlsYReNwkcXEBsLNa8kcLsMou0aPLODLp1
        Pp209f+M57BLUqqG9yfkCZft3g7LyUZZXFsjR68G8Ajp6D1t7VC5glw+wiKrOWALsoSFETqiFQu
        IXP/QmI+seZTgg6gJTtng/et6
X-Received: by 2002:adf:cc8b:0:b0:2d0:776:b766 with SMTP id p11-20020adfcc8b000000b002d00776b766mr12583487wrj.8.1679308903300;
        Mon, 20 Mar 2023 03:41:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set/e1XYwRgb6akZTCg38dL9NExXXfVLSEf9eOFyMKKinU7dW/+58ajB7iwrsP5RR7BUj+5JVlg==
X-Received: by 2002:adf:cc8b:0:b0:2d0:776:b766 with SMTP id p11-20020adfcc8b000000b002d00776b766mr12583467wrj.8.1679308902986;
        Mon, 20 Mar 2023 03:41:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b002c567881dbcsm8514466wrr.48.2023.03.20.03.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:41:42 -0700 (PDT)
Message-ID: <79a78108-efa6-860f-03a6-d791171f8dcc@redhat.com>
Date:   Mon, 20 Mar 2023 11:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/15] MAINTAINERS: extend memblock entry to include MM
 initialization
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-16-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-16-rppt@kernel.org>
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

On 19.03.23 23:00, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> and add mm/mm_init.c to memblock entry in MAINTAINERS
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

