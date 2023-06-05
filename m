Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50305722C04
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjFEP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjFEPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C606A98
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685980445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnGZe2ilus++rN8zbkaGZiYRKzaIR14IuW+BRuj6vnQ=;
        b=SEGjEdNZO890EzUmKGZ79VaNyy80Jp1d6SsZSI00mIszpWElPPnEuHVFuVjV0lQYJ6Yelz
        iYwh1OB3+5ZYUXX3q7f/UtZrn3kJYdY3hVhXbEcczRMu3uuFbrAzSU9V1ZjmUE7GrTO9lq
        IzB2YRjmGoz6QsZ5tEsAVMYjeoHx4to=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-l0MeopiaPcuGjIUsdNLJlA-1; Mon, 05 Jun 2023 11:54:02 -0400
X-MC-Unique: l0MeopiaPcuGjIUsdNLJlA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75d54053a76so13232285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980440; x=1688572440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnGZe2ilus++rN8zbkaGZiYRKzaIR14IuW+BRuj6vnQ=;
        b=M1rOUhoXUMLn32msFzn8neWJqQ/+f1CnagAPdeunu91qVf+6w4zXUvhg/LV5uldsQk
         I3TC8VxlG+Oo//audYH32BONuQ0sejJxQZ6YujMjn59l+GMwPKo3bQjs8fNYxGlM49w/
         6WKu5PpHrqReqUVqSoPluuh9OdgEWJq6D2s6Qeg1yovOcXVpXXf+x+hnt7VWU2AbgoRk
         +EFErm4++k30hx84zMm7YOvO5d10ZrfzCFidWeGA62G5DxdH7wq6vslsrdanPtcUzqf1
         3ucZ1Wxrx4cbh2Hed5vBd38ptf2EqdstavyeNlJ661yemzTprjiP9c7XRwk2UHXEW3vU
         2u2Q==
X-Gm-Message-State: AC+VfDzw15YGqHg6Gq6JFd7ZyWb1ec1d/jOUR5uv+NzSWHzrFTLr7BSb
        awidEBhJNgw05u73UQQKd7siHdUeRVcHy5gkTbBwNEoG3QfVB2Jmaq0paCwm20DbfQmZQBDiK+9
        9WoiYE7zfcieEfbvxOp1+GoWq
X-Received: by 2002:a05:620a:9489:b0:75e:c678:d49e with SMTP id sn9-20020a05620a948900b0075ec678d49emr863504qkn.2.1685980440270;
        Mon, 05 Jun 2023 08:54:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61kcSxuNBntjQ5RQOTzn43/Y6bCUQxP8v4qMNgTUyCXWLS6gcFbCAUdXkDQjnyKfpjq/sYkQ==
X-Received: by 2002:a05:620a:9489:b0:75e:c678:d49e with SMTP id sn9-20020a05620a948900b0075ec678d49emr863494qkn.2.1685980440037;
        Mon, 05 Jun 2023 08:54:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b0075bcc5ab975sm4270572qkm.92.2023.06.05.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:53:58 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:53:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] selftests/mm: .gitignore: add mkdirty,
 va_high_addr_switch
Message-ID: <ZH4FFa4FV9KGwBZo@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-6-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-6-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:52PM -0700, John Hubbard wrote:
> These new build products were left out of .gitignore, so add them now.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 8917455f4f51..ab215303d8e9 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -39,3 +39,5 @@ local_config.h
>  local_config.mk
>  ksm_functional_tests
>  mdwe_test
> +mkdirty
> +va_high_addr_switch
> \ No newline at end of file

Maybe also the new gup_longterm?

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

