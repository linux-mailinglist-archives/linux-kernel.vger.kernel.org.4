Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B064EF00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLPQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiLPQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CADE2FBD7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671207884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XA1mi3/yvF2SMJgghhMSPk1ys5oNzMW3ysl1aCR5HSU=;
        b=f5Y3+KeTlw5bWIsAd/2jheHrZqsYHuwCxhJ/O/u+RYk2dCS/PH2vsrUuEVIZca8gatRqbD
        X4Yf6Td1MvwkYBvcdCkkTZTOwZkMu3+ajMKGU1HgBxUa7duSkcw5h9G/eGlRpm+DxQDlJ7
        S1pVh6L9QVOpyFM6kC97rZJ775chqpI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-D3U3Jti7Ox-GQMbI4H7xww-1; Fri, 16 Dec 2022 11:24:43 -0500
X-MC-Unique: D3U3Jti7Ox-GQMbI4H7xww-1
Received: by mail-ua1-f72.google.com with SMTP id t7-20020ab04ac7000000b004199dbe4e01so1119804uae.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA1mi3/yvF2SMJgghhMSPk1ys5oNzMW3ysl1aCR5HSU=;
        b=EGFs8AmAmfkUnlJ99vfkVKtnCKsN++r4L5fHZ9S427ymYReCQdk0IA9hmod01g6pkj
         6fiLpzqaw/7B61HuUkvOdWVN5Q7Ahmz7sUl2D3Rd9nP2aMRZwVkWo8w0iD1p0NbHyXvH
         MKgeruHUv+DqDgIH+oZhhNs7AiOuZ81abyE4kOl2agAKekpmgMdnKqLCPXZ3ugwzoDym
         w1o6N8OLp5fJhtQOpC4tZv322my1n9r+9oFwmVDWAW7QynYc7k77VwPDYUIin+lZk4G1
         5V9fr1daOCpSQw796ovxuCoFqZ5RFNsI4HH0TUXSG0FT8ZvOJr8So72TWRHeh0cCe0Ji
         7MPQ==
X-Gm-Message-State: ANoB5pn/bWrt1tvo7zCntSbh7X29dmFVLyCaOLpnlU9MuZNBSVqq/8Us
        wL8Xzdcm/2w9CF4IZ6arDZ3hTrdrmOwNkuGTTUhLTlsUqCXyDKpnKA2+CprkzfxbcIswW60dKdk
        oMRn5xOmBq+KGZDsWCN0FuMLR
X-Received: by 2002:a67:dd10:0:b0:3b3:6ddc:97f with SMTP id y16-20020a67dd10000000b003b36ddc097fmr15187490vsj.29.1671207882414;
        Fri, 16 Dec 2022 08:24:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OJlfzNjkPvaVv4RHsPHN78/T6Vk/8cntq0gr0I50Jwzh7j9GHfeHPbvrFscG2qYOO36b7iQ==
X-Received: by 2002:a67:dd10:0:b0:3b3:6ddc:97f with SMTP id y16-20020a67dd10000000b003b36ddc097fmr15187469vsj.29.1671207882204;
        Fri, 16 Dec 2022 08:24:42 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id de26-20020a05620a371a00b006cfc01b4461sm1688741qkb.118.2022.12.16.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:24:41 -0800 (PST)
Date:   Fri, 16 Dec 2022 11:24:40 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Huang Ying <ying.huang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/uffd: Fix pte marker when fork() without fork
 event
Message-ID: <Y5ybyFa5U9VzVcwg@x1n>
References: <20221214200453.1772655-1-peterx@redhat.com>
 <20221214200453.1772655-2-peterx@redhat.com>
 <618b69be-0e99-e35f-04b3-9c63d78ece50@redhat.com>
 <Y5yGp6ToQD+eYrv/@x1n>
 <8c36dd0a-90be-91bf-0ded-55b34ee0a770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c36dd0a-90be-91bf-0ded-55b34ee0a770@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:57:33PM +0100, David Hildenbrand wrote:
> I'm more concerned about backports, when one backports #1 but not #2. In
> theory, patch #2 fixes patch #1, because that introduced IMHO a real
> regression -- a possible memory corruption when discarding a hwpoison
> marker. Warnings are not nice but at least indicate that something needs a
> second look.

Note that backporting patch 1 only is exactly what I wanted to do here - it
means his/her tree should not have the swapin error pte markers at all.

The swapin error pte marker change only existed for a few days in Linus's
tree, so no one should be backporting patch 2.

Thanks,

-- 
Peter Xu

