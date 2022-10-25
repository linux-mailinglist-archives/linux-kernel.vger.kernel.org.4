Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED160D0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiJYPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJYPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9BE2FC11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666712686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfBxSc/Q/Rl1HQ7uZjJdrWCzL0Cr32j4KHcNRwl17rE=;
        b=YL2AcDq0sJ2YYCC0N4ujEI+gd6ec2TmrCVpoEach1EhQ38ZjQ6c7+A17Cou3xb0TN8+3vr
        8quIeAfefxmgFP75XCxjyVcd2331hZOjR0pRJiyIZM4Ts8knlA97gHxJwR5Syyoc6y+wW8
        QzA4MFSDehGHbIfUdUWXTcJuUesOSwo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-_ls6TtK5NzabWbUo623pTQ-1; Tue, 25 Oct 2022 11:44:44 -0400
X-MC-Unique: _ls6TtK5NzabWbUo623pTQ-1
Received: by mail-qk1-f197.google.com with SMTP id bm16-20020a05620a199000b006ee95743ad2so11849880qkb.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfBxSc/Q/Rl1HQ7uZjJdrWCzL0Cr32j4KHcNRwl17rE=;
        b=e00o4iduVb0Hp7JcQ4Rrp4EHOcBlmJ3Q7xBrEWpzH+BU/BsThFSK38utC8jTxTiQ9Z
         LOUPybOgtdexdruMHq/AWM3mncr1SPClKB+5sr0YBW6shwlU8PkSnTRXhY1fwi1vPSHP
         MZzPQW4CU+hbX8xnXEvMb1cKvXAfNcr+ivPt3cxi5rlsKv7JWTJ59FSotpkWgadijvss
         btmVOjnqRKr05QQUFkQIaqaXAlz4v41F22LFa7C17AaCyhj+s31RJSuR5uILCOFIc9Lc
         yszBDcAJegFTFEBUFAS1LGAplcKyZ6mpQP3UGAORyyouQIiIQknDo6mr3TAdceMi1VP8
         wH9w==
X-Gm-Message-State: ACrzQf38rncQv4FosUgE4n1TFITJuJsu++z8ZL+GHNZS2VN+MXs8mWUp
        NrwstwKsWjXqxgUQS3437XI1317SnRn4NEGkEL4rcEi6ukqCK8iXO0S+nggEGDg7N0vMlhJJdAA
        E82S6iPqgUZ+ApFzjYKzK+mQS
X-Received: by 2002:ac8:5f89:0:b0:39c:e5a2:6db9 with SMTP id j9-20020ac85f89000000b0039ce5a26db9mr31619740qta.138.1666712684050;
        Tue, 25 Oct 2022 08:44:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42N6ywBWBizXln5NRrhisEsi7LnXik9WLoAdJztzrqoMBMafUeCmrqJ3IWYkRC7rvbzueHRQ==
X-Received: by 2002:ac8:5f89:0:b0:39c:e5a2:6db9 with SMTP id j9-20020ac85f89000000b0039ce5a26db9mr31619731qta.138.1666712683848;
        Tue, 25 Oct 2022 08:44:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a254e00b006cf8fc6e922sm2234747qko.119.2022.10.25.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:44:43 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:44:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC 2/2] mm: Use pte markers for swap errors
Message-ID: <Y1gEapirqtJACeK/@x1n>
References: <20221024204830.1342169-1-peterx@redhat.com>
 <20221024204830.1342169-3-peterx@redhat.com>
 <d0b8384b-6699-0485-1d39-afbf598a34e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0b8384b-6699-0485-1d39-afbf598a34e9@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 05:31:43PM +0200, David Hildenbrand wrote:
> > -#define  PTE_MARKER_UFFD_WP  BIT(0)
> > -#define  PTE_MARKER_MASK     (PTE_MARKER_UFFD_WP)
> > +#define  PTE_MARKER_UFFD_WP			BIT(0)
> > +#define  PTE_MARKER_SWAP_ERROR			BIT(1)
> 
> I'd suggest to keep the term SWAPIN. An error happened during swapin, which
> is why the page is corrupted.

Sure thing.

-- 
Peter Xu

