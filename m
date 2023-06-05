Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514C8722BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjFEPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjFEPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4910DB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685979670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uft0/V/hdpGO50bCPjM3CiV+FvcYnCSQlJxLrPgoUA8=;
        b=Y/X81Bfm0geTLWizJnVdcI6r5PFkpBhSHfP65cAPCCE9rnAI/SBoj2rfhetWMadQhVD68f
        n28/S6tI0dM2J99sQMwynXIBnfS3W5buNnTOm4GaFINUdEgCofhMIxccjQqLP3b05BY/N6
        qIAq26RxEGoWoNSMVlz8MUQnwlR6lBE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-0suRLpaUOG-To8NmwDUbVQ-1; Mon, 05 Jun 2023 11:41:07 -0400
X-MC-Unique: 0suRLpaUOG-To8NmwDUbVQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f8654d47b4so3535961cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979665; x=1688571665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uft0/V/hdpGO50bCPjM3CiV+FvcYnCSQlJxLrPgoUA8=;
        b=VesTKvWA9/KrAmtU7lDMV6q3DcsPb0yaKqIqDW5uX7mvY4kCXNYRyIm71Mt1JC3xFK
         nNJFlctgr995XRMbc8BT6ImO/+IJPSpCsJYrru+3BO7ndn60/D7F2DywDnDhHb6jokOA
         k6C3Yh+bR5ILpD3pp6Nj2Do/A3rJP3r+iTNFKuSGurrGkEbCQnWscij1ZBgomhXVl6Gd
         CCuMvUF0OgNm0UKi/06n9pthHPdgweJwnSPOjG4EJYM6RXzlS9J18WS3H9lunZrwJaAJ
         1kwiBoNx4IxDCWe4dzAfzgxIMpedm9vxfVHPQ5anWCiPkwoE7w93WWRMxbHzKnX1I05Q
         fhzQ==
X-Gm-Message-State: AC+VfDy5Xw57KTsT6GwxcittQcclwrque5h41dE76FuOOfVotw142wpb
        OcDw3vPBRjC+nPoAUd8j747LjT2HNUakOt0BkK7J+1sDZXMgtHBQ/PyubAbhT7x+RnZPrv974iz
        ArrYchjJninS4rbJYkHwZq2BC
X-Received: by 2002:a05:622a:95:b0:3f9:ab19:714b with SMTP id o21-20020a05622a009500b003f9ab19714bmr1573737qtw.3.1685979665301;
        Mon, 05 Jun 2023 08:41:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6JOexwHI1evq4nWiluVsi0r15+oMcuWudqeNMtoU0/FALRbjWKt6iY9SHpYPWE2/xovsiUPg==
X-Received: by 2002:a05:622a:95:b0:3f9:ab19:714b with SMTP id o21-20020a05622a009500b003f9ab19714bmr1573725qtw.3.1685979665099;
        Mon, 05 Jun 2023 08:41:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87448000000b003e635f80e72sm4781861qtr.48.2023.06.05.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:41:04 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:41:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] selftests/mm: fix unused variable warnings in
 hugetlb-madvise.c, migration.c
Message-ID: <ZH4CDyV/dYItXfoP@x1n>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230603021558.95299-3-jhubbard@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:15:49PM -0700, John Hubbard wrote:
> Dummy variables are required in order to make these two (similar)
> routines work, so in both cases, declare the variables as volatile in
> order to avoid the clang compiler warning.
> 
> Furthermore, in order to ensure that each test actually does what is
> intended, add an asm volatile invocation (thanks to David Hildenbrand
> for the suggestion), with a clarifying comment so that it survives
> future maintenance.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

