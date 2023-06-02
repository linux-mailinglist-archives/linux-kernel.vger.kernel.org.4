Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D709F7205F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbjFBPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbjFBPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3CA1B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685719507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tf9XTi4m1mcrgHK3qjV3h4k5KcTMYkHl5NNGAMKEGNA=;
        b=X6lr8N7vu0aIooRIgY73gG5zU+cf3erXgxMlWWxbnpXAXvQITKXLX/7tD5jrZB0SmCxedA
        OhZDoiHdMFk8dR+/q4gI4TO7OV5lUVaEU9P1qTONCOP9k2tCPkISVA59YsxHshVX+inAyz
        I5qjnxq5wUiuDbBdJFTIOiIDGYsYUzM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-fCB9iQrPME-BncD5dvOB2A-1; Fri, 02 Jun 2023 11:25:05 -0400
X-MC-Unique: fCB9iQrPME-BncD5dvOB2A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f7d72d552fso5775371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685719504; x=1688311504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf9XTi4m1mcrgHK3qjV3h4k5KcTMYkHl5NNGAMKEGNA=;
        b=FbTx8+XHdCj9f/89e83/DDLiGWzgnh4yG0t1D5mhqAAYDwifFDpuLjCb8+A5lrUq5P
         kbi5oS4fHCfAn5mQ0Cp2/CFA50c532HJS1Q2wO4fuTVn+nIYOg2FDy6NR5TosTc8nYyc
         NmLep7gFuoazRZ+Sky2gpbvs4JkwAtMoTAbupMtqHtag1jjBGa6XiylDe2QE3gy8Dtv/
         4M7N+OJ5Zj9Ts7Rv80+S1VaE1W+/6xJrW4ijhD2u2EjUKQ6UkQ3scu7Vta5mNV/gRZxj
         IxWRK5uL8KZpnOpU09Qptqpa+cQkyxJu3Q7D+MB2bLyS5XHKgBnwxMTxSg+Rdm3hguYG
         ed+A==
X-Gm-Message-State: AC+VfDx4V3Ucbas/R/zqwFEidZvcLXnti1u99YIhtZ0CN5u7/21Nq/M7
        IXyf/m+r+1pKfOJZNABDRkzQDFbLO7zNDMIMhNkXRVfAr2jSJrsMdLxeYrTuixrY2CmuH9JJlk5
        Gzl5pYPpquRvCRXzq5Xcwy/9mSTx+kctg
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr10033223qvz.1.1685719504440;
        Fri, 02 Jun 2023 08:25:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HVJ6zVXHbrSuPEXRVVVl+vYEeh7Aot44vhghufKdcl9OcI7FYOwCXizswwMYA2eMjHbYEQQ==
X-Received: by 2002:a05:6214:765:b0:5ed:c96e:ca4a with SMTP id f5-20020a056214076500b005edc96eca4amr10033208qvz.1.1685719504178;
        Fri, 02 Jun 2023 08:25:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id mg22-20020a056214561600b005ef5f8dc89esm933933qvb.88.2023.06.02.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:25:03 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:25:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] selftests/mm: fix uffd-stress unused function
 warning
Message-ID: <ZHoJzs4rP9NicJSP@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602013358.900637-2-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:33:47PM -0700, John Hubbard wrote:
> uffd_minor_feature() was unused. Remove it in order to fix the
> associated clang build warning.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

