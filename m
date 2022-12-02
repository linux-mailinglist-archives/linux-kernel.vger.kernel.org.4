Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C76640B97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiLBRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiLBRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:01:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D67A9EB1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:01:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b21so5152698plc.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uoXHuXaDFXgTbdeII3XSjCL3MMgeQDGKGZbJs+rBEy0=;
        b=LH8TpNoJbUpqT1Ja07NjbIoseIZ4NyVW0z6y23GVkz2CxUjoXzJvhA3Lgq4gMgMRl7
         SZh3C0V0GfyuYAy9kqJKZWJ/0QUx6v2PxUuDj8oZFhszd20jDcEBsUIUn+0/kb18jp4+
         8uuMl3Q+eVzjrXKW0oFZCf5QTFYOb3URBtcBZuqKzN+ix6sBjtPhGX3QJ0mffW/NSx9E
         0ejC9+/20aGMBCxdLXtwASe4RuGm28K7RCez+eaXPkGtNCTF/Wngk33bRIBU1WLmcCbd
         HC46O7mkw6GmVe4pQRSuzWJhN5x7/Hmm0cAv3dUENxvo1Td3Bng9Fu52iZXfqWTYsP4y
         /5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoXHuXaDFXgTbdeII3XSjCL3MMgeQDGKGZbJs+rBEy0=;
        b=zriIkGuWeM43pt4cbcmtMaFx8H9cI053PhBsP+Ver/5TzGjM+KO+aD08sEgANmmtYj
         CvuxqUIMwjWNZmErqd7Nl/OgV0/WN+5ID25FEfvOHbGhAYzy2hHBADr/SHJ4p/xyGhZk
         wB9DWg2PSSpax40M6531T/DBHKchzWjBKWyw+eSAMliAIIjZPkrr9QXeiFqN7Pwx+i0Q
         HA8sMcODlJVm23n7d/XscsuVlwGDNNgrgKtWhfkVcKj+shL9jWcxAF3OJ8LUS8EZ8Ix/
         A9nDROnslAgdWdRkERh7l85BJ9V3DLGfSLPXLRl9jZnluv3KJYlO5EfykB6lWaiZdgd8
         0Nsg==
X-Gm-Message-State: ANoB5pmQ1At4WJyq3d9p+ZpbzlpImuClO9D5O45+QQm5gdYzN+hOvUEP
        UOwFKTJe62SG4RWLKB1MHWPDJ1+sScHwhJno
X-Google-Smtp-Source: AA0mqf58WiSlSMSGI31X+dhgPr90e5VdR2MYMXpIF56y4pL8uVVrulYu3CKuM3UsMW9NAr/SE126Pw==
X-Received: by 2002:a17:902:d711:b0:17f:cdd1:7ab1 with SMTP id w17-20020a170902d71100b0017fcdd17ab1mr53917452ply.86.1670000498040;
        Fri, 02 Dec 2022 09:01:38 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79590000000b00574e84ed847sm5332856pfj.24.2022.12.02.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:01:37 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:01:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Michal Luczaj <mhal@rbox.co>, Like Xu <like.xu.linux@gmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/16] KVM: x86: Remove unused argument in
 gpc_unmap_khva()
Message-ID: <Y4ovbTiLQ2Jy0em9@google.com>
References: <20221013211234.1318131-1-seanjc@google.com>
 <20221013211234.1318131-6-seanjc@google.com>
 <544d854f-e980-c7bf-39e9-425202760cc5@gmail.com>
 <6a984015-cacc-b8e9-d834-9d6827be5832@rbox.co>
 <ffc971cc6166528de7c33c30d190ece5eaee3dbf.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffc971cc6166528de7c33c30d190ece5eaee3dbf.camel@infradead.org>
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

On Fri, Dec 02, 2022, David Woodhouse wrote:
> On Fri, 2022-12-02 at 11:57 +0100, Michal Luczaj wrote:
> > On 12/2/22 10:28, Like Xu wrote:
> > > On 14/10/2022 5:12 am, Sean Christopherson wrote:
> > > > Remove the unused @kvm argument from gpc_unmap_khva().
> > > 
> > > Nit: the caller kvm_gpc_unmap() can also get rid of the unused @kvm argument.
> > 
> > Right, the initial series cleaned up kvm_gpc_unmap() in a separate patch.
> > Current iteration removes kvm_gpc_unmap() later in the series:
> > https://lore.kernel.org/kvm/20221013211234.1318131-12-seanjc@google.com/
> 
> I have been keeping that series up to date in
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/gpc-fixes
> 
> Now that the dust has settled on the Xen runstate area, I may post it
> as v3 of the series.
> 
> Or I may attempt to resolve the gpc->len immutability thing first. I'm
> still not really convinced Sean has won me round on that;

Ya, I agree that storing "len" is undesirable, but so is storing "gpa" instead of
"gfn".

> I'm still quite attached to the TOCTOU benefit of checking the length right
> there at the moment you're going to use the pointer — especially given that
> it *doesn't* have bounds checks like get_user() does, as Sean points out.

I'm in favor of keeping the length checks if we modify the cache to store the
gfn, not the gpa, and require the gpa (or maybe just offset?) in the "get a kernel
pointer" API.

So, how about this for a set of APIs?  Obviously not tested whatsoever, but I
think they address the Xen use cases, and will fit the nested virt cases too
(which want to stuff a pfn into a VMCS/VMCB).

void *kvm_gpc_get_kmap(struct gfn_to_pfn_cache *gpc, gpa_t offset,
		       unsigned long len, bool atomic)
{
	<lock + refresh>

	return gpc->khva + offset;
}
EXPORT_SYMBOL_GPL(kvm_gpc_refresh);

kvm_pfn_t kvm_gpc_get_pfn(struct gfn_to_pfn_cache *gpc, bool atomic)
{
	<lock + refresh of full page>

	return gpc->pfn;
}
EXPORT_SYMBOL_GPL(kvm_gpc_refresh);

void kvm_gpc_put(struct gfn_to_pfn_cache *gpc)
{
	<unlock>
}
EXPORT_SYMBOL_GPL(kvm_gpc_refresh);

int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc)
{
	return __kvm_gpc_refresh(gpc, gfn_to_gpa(gpc->gfn), PAGE_SIZE);
}
EXPORT_SYMBOL_GPL(kvm_gpc_refresh);


And then __kvm_gpc_refresh() would do something like:

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 2d6aba677830..b2dd2eda4b56 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -236,22 +236,19 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
        return -EFAULT;
 }
 
-static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
+static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpt_t gpa,
                             unsigned long len)
 {
        struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-       unsigned long page_offset = gpa & ~PAGE_MASK;
        bool unmap_old = false;
        unsigned long old_uhva;
        kvm_pfn_t old_pfn;
        void *old_khva;
+       gfn_t gfn;
        int ret;
 
-       /*
-        * If must fit within a single page. The 'len' argument is
-        * only to enforce that.
-        */
-       if (page_offset + len > PAGE_SIZE)
+       /* An individual cache doesn't support page splits. */
+       if ((gpa & ~PAGE_MASK) + len > PAGE_SIZE)
                return -EINVAL;
 
        /*
@@ -268,16 +265,16 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
                goto out_unlock;
        }
 
+       gfn = gpa_to_gfn(gpa);
+
        old_pfn = gpc->pfn;
-       old_khva = gpc->khva - offset_in_page(gpc->khva);
+       old_khva = gpc->khva;
        old_uhva = gpc->uhva;
 
        /* If the userspace HVA is invalid, refresh that first */
-       if (gpc->gpa != gpa || gpc->generation != slots->generation ||
+       if (gpc->gfn != gfn || gpc->generation != slots->generation ||
            kvm_is_error_hva(gpc->uhva)) {
-               gfn_t gfn = gpa_to_gfn(gpa);
-
-               gpc->gpa = gpa;
+               gpc->gfn = gfn;
                gpc->generation = slots->generation;
                gpc->memslot = __gfn_to_memslot(slots, gfn);
                gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
@@ -295,12 +292,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
        if (!gpc->valid || old_uhva != gpc->uhva) {
                ret = hva_to_pfn_retry(gpc);
        } else {
-               /*
-                * If the HVA→PFN mapping was already valid, don't unmap it.
-                * But do update gpc->khva because the offset within the page
-                * may have changed.
-                */
-               gpc->khva = old_khva + page_offset;
+               /* If the HVA→PFN mapping was already valid, don't unmap it. */
                ret = 0;
                goto out_unlock;
        }

