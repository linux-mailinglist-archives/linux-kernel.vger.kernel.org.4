Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94970A827
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjETMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:35:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98225115
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:35:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so1270611b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684586139; x=1687178139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi1BxeyXyBr0dFvjh80CQh5A+2m5jDZBC0Bu7zhHxEw=;
        b=QL/LdjHbI4m+gVCU+VvtvjX0NJ8mVhPe62iN8KT39wNVWlaM60Jxr2acJQK0RZkR0d
         nDT/0BYx2tyRGhkwA6WezQrmA76bxlTaLdmhPIpjZ2pDPg7FK44taZnStGq4tSdwrFIs
         fNarjRaZNC7cW140Z5nwBlcy+/Gz42AV6nYRot7ChkpRrjbwIl5ulku0KwU48qDXg5Zk
         7i5GDuSIkgV3Ve74itYUUonXj6phUzztKVazUERNLluyPmnVnqqb63iUXiLi6Y4q8yJn
         YYsBTHbdSTkTXN8z0p2T9NAY1pYxBqhEb7HZqxbHJuVoEgKFZVOiFtqdBQpxR7KivWg5
         mtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684586139; x=1687178139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi1BxeyXyBr0dFvjh80CQh5A+2m5jDZBC0Bu7zhHxEw=;
        b=Gboojaei6kgONc5p3pcnRBOQDMOSoqcyYAadMoIRUemFetB5yBLdAgW7JNpjyesozA
         VbYR845aEOEwZ+hfOvKCTec70mSTMeMMN8XK/EqL1cF3yczloUa+71Y6l/fOr4MCeuCc
         DVJt1yisbL1ZA33bZzYkncOudux6k0x522Mow+JkkF9xRnjpK5KenlsLLW+pmq36rirg
         sWL4W5pCFucGRxNhBAe2XiW9zlMU22OLnZxqkHzIYE5JxVK+T7nleLSei/LyI6YWtpat
         bU58jbiHzB0I/lpUxZ+Ul+J1O33tGsOv806aGI+YdqTJdXYQ684vbE7bz/QDlzcOINFS
         wZWg==
X-Gm-Message-State: AC+VfDzC8makQDwwhylNBDVOzCCWcclbDzgFuZa+xDs6OswUsk5rPUK6
        NndyeowN5OqxbaF9ucyulVHY7g==
X-Google-Smtp-Source: ACHHUZ7CzT1d8/QJg8ZlDIs8IMGzYxs0CAE5xM0ac4MEmXuxLlO65D0vgJA2pzrvzzXyJYhzORTc/Q==
X-Received: by 2002:a05:6a00:891:b0:63b:8afe:a4dc with SMTP id q17-20020a056a00089100b0063b8afea4dcmr6625617pfj.30.1684586138790;
        Sat, 20 May 2023 05:35:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r25-20020a62e419000000b0062d859a33d1sm1194351pfh.84.2023.05.20.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:35:38 -0700 (PDT)
Date:   Sat, 20 May 2023 12:35:34 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: fix UAF of alloc->vma in race with munmap()
Message-ID: <ZGi+ltbOgQcJEq58@google.com>
References: <20230519195950.1775656-1-cmllamas@google.com>
 <2023052048-sloping-credible-8871@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052048-sloping-credible-8871@gregkh>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 10:54:15AM +0100, Greg Kroah-Hartman wrote:
> On Fri, May 19, 2023 at 07:59:49PM +0000, Carlos Llamas wrote:
> > [ cmllamas: clean forward port from commit 015ac18be7de ("binder: fix
> >   UAF of alloc->vma in race with munmap()") in 5.10 stable. It is needed
> >   in mainline after the revert of commit a43cfc87caaf ("android: binder:
> >   stop saving a pointer to the VMA") as pointed out by Liam. The commit
> >   log and tags have been tweaked to reflect this. ]
> 
> I'm confused, is this for a stable release (and if so, which one), or is
> this for Linus's tree?

Sorry for the confusion. This is for Linus's tree.
