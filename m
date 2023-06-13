Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351F572ECB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjFMURQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFMURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26281E6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686687388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gY01Tx4BIc89rInz9irLDAvinQyYun0b+aEdVCR03A=;
        b=ONgYaSA6lZ3FdyWgEDuOGQ82EKGFzPv1ESzzVuzwp7Gs7vvO7T6lfteQklsvo8CX6l/1Hl
        mW+gZuqqSE49rACX1G6uJM2LBHw34rh+79b0AWWxESicnvOYJRvWOf4C1yr+t3qpHldiUA
        v+xto4ShAsrcLJ65wZPVbcFwJqEBbhw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-JvvnfbYRM1S6syPIu4-mNA-1; Tue, 13 Jun 2023 16:16:26 -0400
X-MC-Unique: JvvnfbYRM1S6syPIu4-mNA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7606a134623so42883885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687383; x=1689279383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gY01Tx4BIc89rInz9irLDAvinQyYun0b+aEdVCR03A=;
        b=JQY0ic5pfLhHzkFEcehqQLqO9NIMhQMs0KMQVIJp+gFf1mBhuua92RcSg27SD1gpvS
         omZ8aA102ZdaUzISRTYxvOuPo5vsO01+QWN2JNJStBuyFEUHgojHMNhIboXLkFVlopSM
         2h4hSY3BktvyBfnS9ViL5zdRvLGZ1syl41dmOQrCdcc1LTUZFalqKd+pN3CuoRgCK8R/
         vzxyjfVZ1OksR71x2oq4JCNu00QZgIv2noz8zznX3+gmfckYC/bdQYtqZJVPWYWL9LBj
         b87LWW30gMNUFkmJOUd+gaNxkjxU+1kYq4NEAP+Xp1QZkIZ7kPPsVVfe90SuzJOYkBKf
         kVHA==
X-Gm-Message-State: AC+VfDwIsTrAiI0rcW0DWbqaeT7X759B//WxMOKQYBAqqmhsFAUktJUq
        vQSKtw8aL+V6lZXSr7ZpXc4YpgGNmSycN2bLmqgE7LtuoT2FM7p7ClLcU/4Sqx0b7tD7XZeLh/W
        XebfassR4TN86yvew+XkngaRt
X-Received: by 2002:a05:620a:d96:b0:75e:da20:a10e with SMTP id q22-20020a05620a0d9600b0075eda20a10emr14985496qkl.3.1686687383548;
        Tue, 13 Jun 2023 13:16:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iLH0WqTagTH32CHBbOR+wl+dP1yrz10MNUnCv37WfCOA1VxEblO4cznoDu1tHw6xJ5PXvag==
X-Received: by 2002:a05:620a:d96:b0:75e:da20:a10e with SMTP id q22-20020a05620a0d9600b0075eda20a10emr14985483qkl.3.1686687383204;
        Tue, 13 Jun 2023 13:16:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a164200b00759322a6089sm3843860qko.14.2023.06.13.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:16:22 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:16:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Liam.Howlett@oracle.com, zhangpeng.00@bytedance.com,
        akpm@linux-foundation.org, koct9i@gmail.com, david@redhat.com,
        ak@linux.intel.com, hughd@google.com, emunson@akamai.com,
        rppt@linux.ibm.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
Message-ID: <ZIjOlU5EfVNt6NRU@x1n>
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff,

On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> + more ppl to the list.
> 
> On Mon, Jun 12, 2023 at 6:04 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Hello,
> >
> > There seems to be inconsistency in different VMA fixup
> > implementations, for example:
> > mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> > not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
> > problem? the merge/split skipped by mlock_fixup, might get acted on in
> > the madvice/mprotect case.
> >
> > mlock_fixup currently check for
> > if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
> > is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> > vma_is_dax(vma) || vma_is_secretmem(vma))

The special handling you mentioned in mlock_fixup mostly makes sense to me.

E.g., I think we can just ignore mlock a hugetlb page if it won't be
swapped anyway.

Do you encounter any issue with above?

> > Should there be a common function to handle VMA merge/split ?

IMHO vma_merge() and split_vma() are the "common functions".  Copy Lorenzo
as I think he has plan to look into the interface to make it even easier to
use.

-- 
Peter Xu

