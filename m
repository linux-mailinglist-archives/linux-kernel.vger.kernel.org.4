Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E66FF6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbjEKQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbjEKQI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:08:27 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AAA276B9;
        Thu, 11 May 2023 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=GA6F6KLMupm3XEAOfoKLPP9S98jm
        f1urQ4v3ILsS6CM=; b=Fdx2N8F9i2gJ+IcjtOz+X0+1pGGLoCfW5dS9MZiTvOYJ
        WCFu8MAy53XsgprExggCeB+zbDDBkG9B9VuRs+LMK6+iiRID+5qT2+ElUOepUINa
        A3Yjl58cWo251/STtzbf/ONYcSgw2x0u6CRspE3AANPoHG8X0E+0jXCrrjWdvMw=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogBnYrnfEl1kJK2TEw--.22381S2;
        Fri, 12 May 2023 00:08:04 +0800 (CST)
Date:   Fri, 12 May 2023 00:07:59 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH 3/4] mm: page_table_check: Make it dependent on !DEVMEM
Message-ID: <ehnawbpypxg5vppwcoiuswlq5c54td5mos4jldf5tuy7wbjlvb@o7fydrxd2y34>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <20230510085527.57953-4-lrh2000@pku.edu.cn>
 <f74f2080-1def-f9c2-8884-97bb4c8ba4d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74f2080-1def-f9c2-8884-97bb4c8ba4d1@redhat.com>
X-CM-TRANSID: 54FpogBnYrnfEl1kJK2TEw--.22381S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur48JrW7Gry7Jw4xJrW5Wrg_yoWrGF47pa
        s7JayS9r45G345ur1xZwn2gr1rCrs3Gay5ur9akry5Cas8Ar92kr1agry5Z3WUC393Ca4D
        ZFWYga4aya15ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04
        k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy772BUwAPsv
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 06:40:31PM +0200, David Hildenbrand wrote:
> On 10.05.23 10:55, Ruihan Li wrote:
> > The special device /dev/mem enables users to map arbitrary physical
> > memory regions into the user space, which can conflict with the double
> > mapping detection logic used by the page table check. For instance,
> > pages may change their properties (e.g., from anonymous pages to named
> > pages) while they are still being mapped in the user space via /dev/mem,
> > leading to "corruption" detected by the page table check.
> > 
> > To address this issue, the PAGE_TABLE_CHECK config option is now
> > dependent on !DEVMM. This ensures that the page table check cannot be
> > enabled when /dev/mem is used. It should be noted that /dev/mem itself
> > is a significant security issue, and its conflict with a hardening
> > technique is understandable.
> > 
> > Cc: <stable@vger.kernel.org> # 5.17
> > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > ---
> >   Documentation/mm/page_table_check.rst | 18 ++++++++++++++++++
> >   mm/Kconfig.debug                      |  2 +-
> >   2 files changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
> > index cfd8f4117..b04f29230 100644
> > --- a/Documentation/mm/page_table_check.rst
> > +++ b/Documentation/mm/page_table_check.rst
> > @@ -52,3 +52,21 @@ Build kernel with:
> >   Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
> >   table support without extra kernel parameter.
> > +
> > +Implementation notes
> > +====================
> > +
> > +We specifically decided not to use VMA information in order to avoid relying on
> > +MM states (except for limited "struct page" info). The page table check is a
> > +separate from Linux-MM state machine that verifies that the user accessible
> > +pages are not falsely shared.
> > +
> > +As a result, special devices that violate the model cannot live with
> > +PAGE_TABLE_CHECK. Currently, /dev/mem is the only known example. Given it
> > +allows users to map arbitrary physical memory regions into the userspace, any
> > +pages may change their properties (e.g., from anonymous pages to named pages)
> > +while they are still being mapped in the userspace via /dev/mem, leading to
> > +"corruption" detected by the page table check. Therefore, the PAGE_TABLE_CHECK
> > +config option is now dependent on !DEVMEM. It's worth noting that /dev/mem
> > +itself is a significant security issue, and its conflict with a hardening
> > +technique is understandable.
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index a925415b4..37f3d5b20 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -97,7 +97,7 @@ config PAGE_OWNER
> >   config PAGE_TABLE_CHECK
> >   	bool "Check for invalid mappings in user page tables"
> > -	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
> > +	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK && !DEVMEM
> >   	select PAGE_EXTENSION
> >   	help
> >   	  Check that anonymous page is not being mapped twice with read write
> 
> That might disable it in a lot of environments I'm afraid. I wonder if we
> could allow it for STRICT_DEVMEM. Hm ...
> -- 
> Thanks,
> 
> David / dhildenb

That sounds pretty reasonable. However, I'm not quite sure if PageAnon
makes sense of (and is guaranteed to work well with) I/O memory pages,
which should be the only pages allowed to be accessed via /dev/mem under
STRICT_DEVMEM.

A quick test has shown that PageAnon (by accident or design?) results in
"false" for I/O memory pages. Meanwhile, the logic used in the page
table check allows named (i.e., non-anonymous) pages to be shared
arbitrarily (i.e. in both read-only and read-write modes) between
processes. So it looks that everything works fine. But is it a
coincidence?

Thanks,
Ruihan Li

