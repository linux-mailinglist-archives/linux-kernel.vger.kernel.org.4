Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789767224C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjFELi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjFELi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ADCED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685965097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UW0puxYxX8lA/j29JZ44zu7J+ZrscXZgmo7qgszTgi8=;
        b=GiHhPpZhRj75Ray6pwLD56ZnpWNbKL1kPMcIDck8W6gCGTxqkY+rhvNAtRuk3PkbTvwP2Q
        vFFradOkZi/SakHuYOzNTf9IN7ESSIoQiuzfC+3bStEsTNEOFQu7OHHBhEtxNCgaCYNP3L
        MmLw/Vz5hbWyWzTk3ZO4zQMv5hjDVcs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-rO0oLnWcPZ2HEL9GXmIMvA-1; Mon, 05 Jun 2023 07:38:16 -0400
X-MC-Unique: rO0oLnWcPZ2HEL9GXmIMvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7e7a6981cso916865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685965095; x=1688557095;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW0puxYxX8lA/j29JZ44zu7J+ZrscXZgmo7qgszTgi8=;
        b=KJzuBdNpVdfxNAN7xDytBWmcE3ZUZmw9btCRnSpFTjROvMIb0mvR0hX4HLkWqQpgnz
         dOtqbeQZPSfpVhGoiTC6s5X6SReyoSPk21SHI4CRFCRaDMdU/ywSnBVh2iTs5aJUxXNJ
         aroQpC1y6CzD0K+c1V4YWK94OIOUYom7/lNhaPEUrYbLd2jrC8W8ekCcTAJoN4GUwxmY
         c/eb++3EWo8bOX9kip+Sk/DwbRmpBNT+fBx91PGSXhNxDsqAlBRY9gNh9ZlBpdXGbBs1
         Bn23Z1FeLKbMVLM5IohqY070cCl0CRPzmQqfnbVMBnxDtMuCEGKYOj/WO4KQr5WMOvmm
         ORww==
X-Gm-Message-State: AC+VfDxjOTIHoTA2JEiotbtfgOZj2GIGBiM3U7kDIh00aLHFkgvPvqEm
        qGmAVX/1p7vFhAeTAd5dUpsmyjcy6jZJswcKV4SLOn8z5unmCyN4YQ9MJaxEw4IVl3rM0jVCWm7
        YDGRISAq0mpGM05+e/gcYYfJg
X-Received: by 2002:a5d:46c4:0:b0:309:1532:8287 with SMTP id g4-20020a5d46c4000000b0030915328287mr4217238wrs.19.1685965095112;
        Mon, 05 Jun 2023 04:38:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4M44tZLcoGU14krnj+H/IKRXh8vHDtScQRiy+9d63g0QVyhDndxPwSt5oICqN1Qh74CeeJYA==
X-Received: by 2002:a5d:46c4:0:b0:309:1532:8287 with SMTP id g4-20020a5d46c4000000b0030915328287mr4217226wrs.19.1685965094788;
        Mon, 05 Jun 2023 04:38:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id j14-20020adff54e000000b0030aec5e020fsm9540701wrp.86.2023.06.05.04.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:38:14 -0700 (PDT)
Message-ID: <61c6f512-28cf-451b-b356-1a53493db634@redhat.com>
Date:   Mon, 5 Jun 2023 13:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/11] selftests/mm: move uffd* routines from vm_util.c
 to uffd-common.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-11-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-11-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> Move the uffd*() routines to their natural home. Note that
> ksm_functional_tests.c also depend, intentionally (due to a recent
> commit [1]), upon uffd-common.[ch].
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

