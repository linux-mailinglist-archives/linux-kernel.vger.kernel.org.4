Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350BD5F3A99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJDA2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJDA2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A0815700
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664843290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pj+13W7HFM06WePLHe+jsxNPLN/rwSpvvUEX7p+XOZo=;
        b=aejP18nD6WsJOX5VuG0YPhRp0FmSf7SdRCJDNlsvZb08rwg26ld+7KuvcqsIgGRYewxqx7
        cdgYbEGIRp1pw1xa9O56u04/zoTs+zYeOUVobT5JEMVHc9YoBw5DX7k97hbd4LQ7aHkW5E
        ksD5QO82CD6LOe8QGvFk/w14ga8KnuU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-Z2yicR0hPsWNP67nnKj0dQ-1; Mon, 03 Oct 2022 20:28:06 -0400
X-MC-Unique: Z2yicR0hPsWNP67nnKj0dQ-1
Received: by mail-qk1-f199.google.com with SMTP id i7-20020a05620a404700b006ced0d02b68so10415173qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pj+13W7HFM06WePLHe+jsxNPLN/rwSpvvUEX7p+XOZo=;
        b=R+1UMDurwa55Vs54TX3ucmPpAtFRA6sOXcmY5rIg2GtLlAEkJTg6KlteA4SMseTBQD
         76l0O1cwJ8nYX10x8y+vr1hWl1txMWaQYRflVNbosvB410CnqED7okwy3Ig6DCwnU99l
         Ir4Y0jL95ugvLcAzg/AV0ufmpyf+V8/vTyMy2icy8wt95YaL6Of80G60kMt3eAqbq7ow
         pzIRg4I7Zrf9d6KfBQtyDbuHWbJSSrZslJ7qH5Uplm3KlcNpHhBUA2HVqKdXgR1crFw9
         bH1C6tnjMT2/3hHmVrpiJm5xHkICawlq7MLxwBPDQb34Ubv8Df30wU6CWd8fKpd/Wgqz
         9JFw==
X-Gm-Message-State: ACrzQf14YXMt6aPVV37hO7b/kRDKXDkOiBszl3SbY0D/hA1whDXu1Xhi
        Fy6eUWzXIU2HVUx+yQYTUpkgpvzorcMA1C5S1faBBZIthnoZjf+7YUM9k/qgo8CltoYFUWHn/fT
        mFBeGwvgt49cUP7shsdAPB7to
X-Received: by 2002:ac8:5b95:0:b0:35c:e579:1feb with SMTP id a21-20020ac85b95000000b0035ce5791febmr17993204qta.481.1664843286440;
        Mon, 03 Oct 2022 17:28:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5IEwX3LFHu386ZT/atsDghlRieK/y5Wumcw8asQhPJ2iC/POzF1khL8FoV+rLT3iH/Y5mXaA==
X-Received: by 2002:ac8:5b95:0:b0:35c:e579:1feb with SMTP id a21-20020ac85b95000000b0035ce5791febmr17993193qta.481.1664843286247;
        Mon, 03 Oct 2022 17:28:06 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b00342f8d4d0basm10584846qtx.43.2022.10.03.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:28:05 -0700 (PDT)
Date:   Mon, 3 Oct 2022 20:28:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/3] mm/hugetlb: Fix race condition of uffd missing/minor
 handling
Message-ID: <Yzt+EwJdLr0j9VwH@x1n>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
 <YzsZ3VV/95AvXDUz@monkey>
 <YztT2OJake65WG3P@x1n>
 <YztYC+2jalrsxKDm@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YztYC+2jalrsxKDm@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 02:45:47PM -0700, Mike Kravetz wrote:
> This also explains why the new locking exposes the race.
> hugetlb_change_protection needs to take the i_mmap_sema in write mode because
> it could unshare pmds.  Previously, hugetlb page faults took i_mmap_sema in
> read mode so this race could not happen.

Makes sense, thanks for explaining.

-- 
Peter Xu

