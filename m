Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574905F5AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiJEU3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJEU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2356814E4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665001767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVmEIbMQRI5L+v4T6I3zVAGhgWSit7Ys4wZB8dGoYBQ=;
        b=GtA4neWe4SRsk1jt40uVHz4J3PwbV+ZBdLSEtOMzDB7kiUgyg1bD0vAhyZC2RiTEAuDMo1
        j5f716KefNiPoF2q3NeR/uLVAkh8a75Q8R6hdnYJECMheD+oziii7ZFJxhKFbvjJp4UUtB
        EwvZC2pijVmTIdZUvG/c20Pu4YIJdiE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-cObPmUHYNxiDpKXLopqoxw-1; Wed, 05 Oct 2022 16:29:20 -0400
X-MC-Unique: cObPmUHYNxiDpKXLopqoxw-1
Received: by mail-qv1-f72.google.com with SMTP id q6-20020a0cf5c6000000b004b1999f94bcso5009590qvm.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iVmEIbMQRI5L+v4T6I3zVAGhgWSit7Ys4wZB8dGoYBQ=;
        b=ZJyjLqw63PP5XAkFBhS3+N5QQpKnpmqVazDU0ekAt3EPKxQmrSHS6bL2c+hx8LUSQ7
         08TvNc4ZuCKIX68zRolnHzi+R3kcdL1VTP8Voi35PO42repOnctRE6zoiL1PkgQaqzvl
         oRB+iFw5gp3I10y6qmbRs2545sS+RhbOiPnHvpxZ/zU/FMYpw9Kfpo0NjAzX8A/iDgsq
         tdGvCAKo5yHq9IwAxFZ9BR9OAlJjKkUxy8htDh+X38coW80WAz+/S27oF6oPSdR2syAE
         thexZPiQVvx7iEMcR6bAD/QaMIZMvYrK4rn1rRedhOW5DVQiunoEcYVDq+x3FvXI1N/p
         AsGQ==
X-Gm-Message-State: ACrzQf2X7XEo+wgsposx8pKjWVYZcLMSrGfTZ/2QsyOmAHoND4J+FqUs
        KavhVgpFmLFDWGIEZBiLEB1wbeNdd2i5KHyFa+9SAsRw3JR0o7+axmXndUTus1CupcnjMkZxKvm
        Z/CiH4UaZ0G3HTCxJkfjPxaeR
X-Received: by 2002:ac8:5850:0:b0:35b:b672:2731 with SMTP id h16-20020ac85850000000b0035bb6722731mr1055825qth.560.1665001760082;
        Wed, 05 Oct 2022 13:29:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6l0AOsxsoHvXk4fcs+JUvOMaPwo2dP+VDHS9+YfPNM5zlQOrdMpx0jPn2226W5v2NvuTNwjg==
X-Received: by 2002:ac8:5850:0:b0:35b:b672:2731 with SMTP id h16-20020ac85850000000b0035bb6722731mr1055819qth.560.1665001759885;
        Wed, 05 Oct 2022 13:29:19 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t123-20020a375f81000000b006a65c58db99sm18044819qkb.64.2022.10.05.13.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:29:19 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:29:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 3/7] mm: remove VM_FAULT_WRITE
Message-ID: <Yz3pHt+Z9EhFAFUJ@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-4-david@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:27PM +0200, David Hildenbrand wrote:
> All users -- GUP and KSM -- are gone, let's just remove it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

