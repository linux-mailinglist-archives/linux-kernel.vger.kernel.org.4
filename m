Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C356F2B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjD3XGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjD3XGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:06:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72933E58
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 16:06:32 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74e19dcf217so79415585a.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682895991; x=1685487991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Psay3iWMJhmxHkZAg5Iuol6oj90ri2pdTt2YuZmWUE=;
        b=n3H6nqEHaqJne+lMWDC0WazrrjZKvmjwaYoQAJtpanf6mj6GHbj1dlXBHBaDdRJ+VJ
         sv7ABRjeVJaqylOzt45cK/IIUNW3mZClbmkW29YYN8dkoDJFikicRRqifcTXLvgdAP9I
         9Aksh8PYtpqGxA8F7/EEEOfpB6+1wdI0k/MwDx2UAOft1Q/qoqTVMv2BpEyDWEYGudFd
         Yf0K7EVCzbc2LnQNbHrulIeS/0IwOSNTkjedU4nS7B7KlWo++xnQ/sMFm6Bkz3VB7g2C
         l9KDF/fzGBQKKIi00h422ACQLJjY1qneZG0zqlOtnxIXUiZFxyc6LWGYB1wHbkPqYZG+
         KejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682895991; x=1685487991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Psay3iWMJhmxHkZAg5Iuol6oj90ri2pdTt2YuZmWUE=;
        b=bVI73bghIE+VgMglDFOffgMXd434+xzIGB3sJ0wFGysMgVt67QxGWGGb3Q/ZBPjFfF
         QwcLjvWvpWUvUrmDbtcNSFw81D7r8j92P+XSjGTGt2Dmd3UWBFpkp0cbczlqo+r2IkTt
         bi2B3h8rOKt+NvirskEHCJceKCDDVlxd7rjIu+1BYbqv8w9j40o3t7O3UQV/GTT7nkWJ
         8CgcJeT82W3w+q2wqVPUKe7qme4inbvEf5Q6k61hBt+5/9mgdXgsWNeCrtLg+ErzP/jx
         4nsyhpWRhgjKDfe9QEpDFe6H2rtZpgUJkV8t6AB3yie+lih95sqg9YXl8k+dlbOsA1Gl
         Sczw==
X-Gm-Message-State: AC+VfDzOErP9FNUNIT4+dxeM0oa0WeCQGtdXASrmVWu/Y+jz+FHUNopi
        ePTaJ13eCTnjEkzWmQQ78/5N0JPXbquLVOWPZ1Y=
X-Google-Smtp-Source: ACHHUZ7N8wIq7sna6v8mheeplG6fRtbWccoLeo3L3czcxGeQmS0itVhx8sZeyiIb+7kZSatIlT1rTg==
X-Received: by 2002:ad4:5967:0:b0:56f:37a:4561 with SMTP id eq7-20020ad45967000000b0056f037a4561mr15383256qvb.34.1682895991597;
        Sun, 30 Apr 2023 16:06:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x14-20020a0cda0e000000b006166a48357asm3485820qvj.60.2023.04.30.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 16:06:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ptG7i-005eii-Ev;
        Sun, 30 Apr 2023 20:06:30 -0300
Date:   Sun, 30 Apr 2023 20:06:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
Message-ID: <ZE70doFi8X3KgfrV@ziepe.ca>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
 <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiriLmq6OgLLF9seANqCJqjCrgUC384zcJUFtv3xJgVkQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 01:07:45PM -0700, Linus Torvalds wrote:
> On Sun, Apr 30, 2023 at 4:13 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > this pull-request is somewhat messier than usual because it has a lot of
> > conflicts with your tree. I resolved them in a test-merge and sorted it out
> > for you to compare your solution to mine (mine is also mostly similar to
> > the one in linux-next).
> 
> Your resolution is different from mine.
> 
> Some of it is just white-space differences etc, but some of it is meaningful.
> 
> For example, you have
> 
>                 if (mm->pasid < min || mm->pasid >= max)
> 
> in your iommu_sva_alloc_pasid(), which seems to have undone the change
> in commit 4e14176ab13f ("iommu/sva: Stop using ioasid_set for SVA"),
> which changed it to check for
> 
>            .. mm->pasid > max)
> 
> instead (which seems also consistent with what ida_alloc_range() does:
> 'max' is inclusive).

Yes, that is what the new function comment says it should do, and the
only caller is:

drivers/iommu/iommu-sva.c:      ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);

Which looks inclusive also

> You also seem to have kept the deleted <linux/ioasid.h> header file.

Should be deleted
 
> I'm also a bit unsure about what the intent with mm_valid_pasid() is.
> In commit cd3891158a77 ("iommu/sva: Move PASID helpers to sva code")
> that helper (under the previous name) got moved to a different header
> file, but in the process it also got done unconditionally as

I think the whole thing was originally a micro-optimization to remove
this if statement from some mm paths..

> But in your merge, you ended up splitting it into two versions again.
> 
> I don't think that's technically the "right" merge (it basically
> changes things wrt the two branches), but I do think it's nicer.

It is closer to the intent, I think

> Finally, I'm not happy with the Kconfig situation here. Commit
> 99b5726b4423 ("iommu: Remove ioasid infrastructure") removed
> CONFIG_IOASID, but left the
> 
>         select IOASID
 
> in the 'config INTEL_IOMMU' Kconfig case. I removed that as dead, but
> now we have that
> 
>         select IOMMU_SVA

We've had this longstanding confusion in the iommu layer that SVA and
PASID are one and the same thing, we are slowly reorganizing it.. For
now it is fine for IOMMU_SVA to cover the PASID allocator as the only
drivers that support PASID also support SVA.

Arguably the design is backwards and IOMMU_SVA should be user
selectable and it should turn off the SVA code entirely including the
driver code.

> Somebody should double-check my result, in other words.

I didn't notice anything wrong, I'm sure Lu and Yi will test it!

Thanks,
Jason
