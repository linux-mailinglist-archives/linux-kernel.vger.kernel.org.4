Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE17224B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjFELhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjFELhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9869E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OkG9olqH5PYoud9/38E7Kg0uccFHuOTuI1AZcy25Yc=;
        b=Gv4x9QvuSo5rg2xaIbwhpeRpIwOHMV4aU8W/PdrTitlp3VecfPUXNP4fG4vdrgf2aV5w8j
        Wm1GjW3YdYL7l+2ite/D469LxNBA04qXgh7d1Rn5AKOuleSUWZb+ICe3GLRrcmW/0A7PgB
        EFL4OISj1uVFVU6rSf1NyMTqbnEQPNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-5OEXP8lyO7y8d030Vizxlw-1; Mon, 05 Jun 2023 07:36:25 -0400
X-MC-Unique: 5OEXP8lyO7y8d030Vizxlw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f70f9995aeso22982395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964984; x=1688556984;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OkG9olqH5PYoud9/38E7Kg0uccFHuOTuI1AZcy25Yc=;
        b=JJQWq4gJdJhtvb3VhtXCPIGQC0LDF5eoFOORoNm07mGiTJ6Ku+AgLPWGHTZ68V2xEU
         JEcUeBcS+E3M1U2Zv3jKtEDaeyE2BDfTNIHrnIyT2UihsipyLeRw4Tv5GsvpgxcQykwN
         dqtvi82Y9zHxSMHuUvRW7FuTYRnu78mPjkUEKbrEGhOlrXqn861z76Gkb0nmt+bdfxix
         f4b00XC9NBa8djFaa+rQqRvIxevw533etzB49MAfHgyymsab9ykzYfquhfpcdgpLV740
         zZxcigZ8Tb/rkGBDlrcMPy36kcaM9IeMPmzzOSILSC/2gYZaiboZH37Xswh3iptBB6qG
         0uwQ==
X-Gm-Message-State: AC+VfDwkjAMuQ9NMnDjQy6ZOIbpdh9pqRcRLkUEWsquYH4wUmPsn815b
        +L3LwltTmsHrk56ioN1X1IiWTm4CcGEo4iqZDKOGbuW4DmPaEaJXlszpW1elnJNOQQL5KHx9+v3
        /qV0y6jVaqcThe0M/80wPJtP8
X-Received: by 2002:a05:600c:22d4:b0:3f4:28db:f5ff with SMTP id 20-20020a05600c22d400b003f428dbf5ffmr6047802wmg.35.1685964983938;
        Mon, 05 Jun 2023 04:36:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ730wx1qPM41cxYciesFUjVPXLwung5A2wk66PQ+XPHH3tXLqc84LkCheTb8+lJicuJyZ239Q==
X-Received: by 2002:a05:600c:22d4:b0:3f4:28db:f5ff with SMTP id 20-20020a05600c22d400b003f428dbf5ffmr6047791wmg.35.1685964983736;
        Mon, 05 Jun 2023 04:36:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f42a75ac2asm10536563wml.23.2023.06.05.04.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:36:23 -0700 (PDT)
Message-ID: <4a47fbdd-c8dd-d20f-bc13-08a56dc05647@redhat.com>
Date:   Mon, 5 Jun 2023 13:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/11] selftests/mm: fix "warning: expression which
 evaluates to zero..." in mlock2-tests.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-4-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> The stop variable is a char*, and the code was assigning a char value to
> it. This was generating a warning when compiling with clang.
> 
> However, as both David and Peter pointed out, stop is not even used
> after the problematic assignment to a char type. So just delete that
> line entirely.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

