Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E455F44D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJDNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJDNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546D175A3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664891593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UJoVLNpycu3H8iv7G0OfnnRojQ2rXony+DMsriTu0BI=;
        b=HFlNjom9XOF1WVt2mhtocV4up2WjyYI+A6KcnBFsu+kteiJ9LxCfcpbCqd7oKCZAON1YIK
        LKb1dCeoQd22JmcwMpVIOydfry0sQ9tnhQ2hCiT9qOeruq2sRahhkxZsfnYYV3G1mul1In
        TLvG/5iuCO2wzTkzHieRwfJj2FEzEP8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-B8eBd147PKSQRLK_i8FPwA-1; Tue, 04 Oct 2022 09:53:12 -0400
X-MC-Unique: B8eBd147PKSQRLK_i8FPwA-1
Received: by mail-qv1-f69.google.com with SMTP id g12-20020a0cfdcc000000b004ad431ceee0so8764967qvs.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 06:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UJoVLNpycu3H8iv7G0OfnnRojQ2rXony+DMsriTu0BI=;
        b=ArhP4KVCsBBr0uhUzupzvviCqI0zMbFaZCH4SE5oSqdvmEQ15qHouqFYrV+LbmXgnh
         CqYvxGwPaequAdQzJNsnv2++t7pkkRJfiF8jzoJ85z98OzUjYyhMAHiBe0mjEHggh0AG
         lAeirCRBjQbyX2xZ/QEaYs72xaP7IyGLNJCbxcsHq0lSGvKm2OzmP7HFmsNyZsZyYpze
         ufmVW2YCIuPJjsbiMTCfXFAGniQ294snbL6hJFRVxk1ERvbsRuRokk1mpTpKLixNo3FI
         3Yl8/QPTZi77YYPivrhmTdPWOtZF7q3fvxJlHhBpxd/lNjcB4AjtAcdS460umdfTvwZR
         VOeg==
X-Gm-Message-State: ACrzQf11pK8lx2/UyYB1t3yydK9Pmur/4WRAKovqKkU4anomtHo8RHfR
        eyeTmBW3p3asb1+ecQngjFhKWDKItbgIj6+q23KfYx8yl+wL/qZoIQd9gH6hCScDgLxpv20MdMY
        VkCgdohPBvUOeCnByT/fZW5hU
X-Received: by 2002:ae9:ef4d:0:b0:6cf:427b:c250 with SMTP id d74-20020ae9ef4d000000b006cf427bc250mr16987090qkg.607.1664891592201;
        Tue, 04 Oct 2022 06:53:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sZbNAoxkd2cPHA7koXimItxcnTlOVhabR7D7EBSYPcmds2qb++cSX8X2LeClkgpuc0gCOsA==
X-Received: by 2002:ae9:ef4d:0:b0:6cf:427b:c250 with SMTP id d74-20020ae9ef4d000000b006cf427bc250mr16987075qkg.607.1664891592011;
        Tue, 04 Oct 2022 06:53:12 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bp42-20020a05620a45aa00b006cea2984c9bsm14574953qkb.100.2022.10.04.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:53:11 -0700 (PDT)
Date:   Tue, 4 Oct 2022 09:53:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/3] mm/hugetlb: Fix race condition of uffd
 missing/minor handling
Message-ID: <Yzw6xY1JQcEtmifY@x1n>
References: <20221004003705.497782-1-peterx@redhat.com>
 <20221004003705.497782-2-peterx@redhat.com>
 <YzubWledIOzKHNln@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzubWledIOzKHNln@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 07:32:58PM -0700, Mike Kravetz wrote:
> Do note that this will not apply on top of "mm: hugetlb: fix UAF in
> hugetlb_handle_userfault" which is already in Andrew's tree.  However,
> required changes should be simple.

Thanks for the heads up, I'll rebase.

> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks,

-- 
Peter Xu

