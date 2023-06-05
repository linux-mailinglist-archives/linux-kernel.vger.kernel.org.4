Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0046722C00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjFEPzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFEPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CBB0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685980506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwLGVmDqbkcCaY5EC3JMFUCO4whX8e6TfDsiOjgxq/Q=;
        b=XmAiOZQn2+0SLNUzuaVvNs9DYYya6yE9DresaIZ9JBoog7i2S1COnpd4Y98p8YccSs4OHJ
        RDQOIWS1ROU/H/SW269PP4njTPEZKLYedUl/L1RjOL4uwvmxRzl20tTgGzyRL6r8OcJdH4
        gHpzR35NrQ4fHPnh/syqQwsBAUpuNnc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-bYbCLSFgOLCVtoXHpLr6BA-1; Mon, 05 Jun 2023 11:55:05 -0400
X-MC-Unique: bYbCLSFgOLCVtoXHpLr6BA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f9aa9aee8cso1399141cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980504; x=1688572504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwLGVmDqbkcCaY5EC3JMFUCO4whX8e6TfDsiOjgxq/Q=;
        b=WZ1VO4M9kQYJRCuFWk4r47sl/mdyVfZYTxly2G6CqRxdxp7g9rSCLRYoHLDyCbdihY
         QMYw7WFac5habvd4+gEBkwqW4PT8o2yGAkEobNEk3uVfjZjGDYZ97yyHQxlpFagFSiIX
         3dtkUQX8UC1xAGLqBsBgyQ2qwZZNWP4coN7mdObNjUecQmPmw7im0O6BOUjr3NQNyC/y
         3DuvzBhEKRs+bg8pcZfvIbysrUYCDciRHjpP8F9Q0dTUWE8RJbQioQTi5Enpy4kAtyIn
         X/FF4oFImce1isrSd1EVMXIYUAPLzk9KzCRlWhkOkTwyuIjAoDaUAdjUMbNNBywsUnVe
         LTDQ==
X-Gm-Message-State: AC+VfDxn9vqdF3ykghCa5Q7NXlWsA+VaOUZ3nydMgWct8+iQyF3li1G0
        H5nSOFSWpLsWoeWuqtVi5fhS/gShZDTbeqJZAvzKuB6mT/5y8kIKBze9Qhj22zhsuo5PHWx++Eg
        8wJVPqIEzmapANo7/xNhro2mW
X-Received: by 2002:ac8:7f10:0:b0:3f4:fdaa:8e14 with SMTP id f16-20020ac87f10000000b003f4fdaa8e14mr24058164qtk.2.1685980504521;
        Mon, 05 Jun 2023 08:55:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5O9WI4eGMFyZs4w+vj++OK9goc6gtOc16upUEZKnKkx12mIS0AVqHYFJfLtAp2vyUQCLB11g==
X-Received: by 2002:ac8:7f10:0:b0:3f4:fdaa:8e14 with SMTP id f16-20020ac87f10000000b003f4fdaa8e14mr24058147qtk.2.1685980504283;
        Mon, 05 Jun 2023 08:55:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i8-20020ac871c8000000b003e69c51cf53sm4775373qtp.72.2023.06.05.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:55:03 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:55:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] selftests/mm: fix two -Wformat-security
 warnings in uffd builds
Message-ID: <ZH4FVkhxSB5g5RBN@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-7-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:53PM -0700, John Hubbard wrote:
> The uffd tests generate two compile time warnings from clang's
> -Wformat-security setting. These trigger at the call sites for
> uffd_test_start() and uffd_test_skip().
> 
> 1) Fix the uffd_test_start() issue by removing the intermediate
> test_name variable (thanks to David Hildenbrand for showing how to do
> this).
> 
> 2) Fix the uffd_test_skip() issue by observing that there is no need for
> a macro and a variable args approach, because all callers of
> uffd_test_skip() pass in a simple char* string, without any format
> specifiers. So just change uffd_test_skip() into a regular C function.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

