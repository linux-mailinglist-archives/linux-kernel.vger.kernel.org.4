Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F7623998
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiKJCKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiKJCKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:10:17 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C42FAE0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:10:16 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id x21so423063qkj.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPoVaZI3+eUsBLgHzkw8YZRMFuPpzhPKpLA9H61td34=;
        b=ckQT3Ln0AWhyYcixRuVnKI3VqCz+vuIXq+8vrTgHRwP1n+SGL6xWBeGeKf2k6sYaXh
         J5BM1A5rwDKCMVZYTmLNhB7saTxNdi5rxePE42Cdgm2Zp1ZmsPRoquLKYzA9smdPHMjg
         UuZiNSI70Z549wO8XYnVfxYqa5iydDdE4vr7ciAipPgTcM41T7iKpH2IT7BkqEROoktY
         2mBJzF0gkHRtH2+eYaORxT4JBLIs1qRTB6nh9VNq8dEroZ/DGn7Hgoq/PF6ErPgRm82E
         e4p3khY08YAjNlOcf4eyLWxnHv1o74EywFv7QI1F69hmgV0qu2AdYG2A1TeFib4Keb5C
         IqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPoVaZI3+eUsBLgHzkw8YZRMFuPpzhPKpLA9H61td34=;
        b=KtL49igV1G7fu2LJIf7TH7uvoutoRLIiTe/THlBmsD6kcuqNvbAd/DJvuF5MzEhalX
         e7QqRgRY3PU9YH2fF93k38KuQQywsYY9k/nV59hWO8uXYqSDPTLF/sIHAy79FQ3bpfGF
         rPZCfaArBV6D+iI3+ckKwez6mMs/sJvEAJpAqMWI36m5/MyLMhnFHVuLM0Uu4X7HmupC
         smmnEPmnh+YX+MqvX3a0zB0Qzqgu3JVpVGt3Xi4BdxKb6mc+/IU8nm7nUM/tKFRkQgXB
         OsYx+HoWk//+ngbLc8OvtLAPkcWINNUl+r26eL2wEZHIz/uExj51LbzqzVZsIOZx63xx
         IM0w==
X-Gm-Message-State: ACrzQf2jp12ECfoCOXMDO/LFXshD21bWVRSxOIU2mpu+6XXO3Okq3WFq
        bRBRBLONkFTAvcPOfp0SLPYCPg==
X-Google-Smtp-Source: AMsMyM6VqAYdH1w7nbaoUSJdUu0MzfC/8C4lngPt/v2w9Dd+3rH6N89utqPcwhNFO1u9ozXw0KCg6Q==
X-Received: by 2002:a37:444b:0:b0:6fa:2fc6:59e2 with SMTP id r72-20020a37444b000000b006fa2fc659e2mr40471427qka.541.1668046215381;
        Wed, 09 Nov 2022 18:10:15 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c1-20020a05622a024100b0039cc0fbdb61sm10856656qtx.53.2022.11.09.18.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:10:14 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:10:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
In-Reply-To: <e5bd10cd-eb86-3a70-a0fe-21ba49b5ab25@oracle.com>
Message-ID: <7f60bcac-a2e5-9c4b-8a8f-e972a93e116@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <3818cc9a-9999-d064-d778-9c94c5911e6@google.com> <5bd8a365-e2c5-a721-1257-81ec4ae0c626@oracle.com> <3934b34-ae2f-2119-9a68-33e51e909795@google.com>
 <e5bd10cd-eb86-3a70-a0fe-21ba49b5ab25@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, Sidhartha Kumar wrote:
> On 11/3/22 9:29 PM, Hugh Dickins wrote:
> >
> >> Should the usage of page_1 and page_2 also be documented here?
> > You must have something interesting in mind to document about them,
> > but I cannot guess what! They are for field alignment, not for use.
> > (page_2 to help when/if someone needs to add another pageful.)
> >
> > Do you mean that I should copy the
> > 	/* private: the union with struct page is transitional */
> > comment from above the original "struct page page;" line I copied?
> > Or give all three of them a few underscores to imply not for use?
> 
> I think the underscores with a comment about not for use could be helpful.

I've given them two underscores (but not to the original "struct page page",
since a build showed that used as "page" elsewhere, not just for alignment).

I'm sorry, but I've not given them any comment: I don't think they
belong in the commented fields section (_flags_1 etc), "page" is not
there; and I'm, let's be honest, terrified of dabbling in this kerneldoc
area - feel very fortunate to have escaped attack by a robot for my
additions so far.  I'll leave adding comment to you or other cognoscenti.

Hugh
