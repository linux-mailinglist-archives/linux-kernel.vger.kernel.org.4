Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DB70505C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEPORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjEPORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:17:44 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A1F6E9D;
        Tue, 16 May 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=FB
        KSDE0EuEU40vy6iCCv7/n8PL6OgdqOnstZM6vjbHo=; b=q0DFWp8sOY79jMlpJB
        YC1ukt6gww8HB5SMjfhkNk1u3owE1Tc/YeM944bqQn3DlrhWJbEp2I7wCSzZjbXs
        PMi3aQ56HNx3S78Vh1lj6lDteppli7MGpBXLTWFl8Rdvl2DBa6x7kgfV89B/l4mA
        fglBKYV90hRdfaTznNMZ/I6tA=
Received: from localhost (unknown [10.7.98.243])
        by front02 (Coremail) with SMTP id 54FpogCXn7tjkGNkJmddFA--.5433S2;
        Tue, 16 May 2023 22:17:12 +0800 (CST)
Date:   Tue, 16 May 2023 22:17:02 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH v2 4/4] mm: page_table_check: Ensure user pages are not
 slab pages
Message-ID: <od63jsnrn4fgmwihrsa2kidtgenp2yr2hmzb5es5go4uflaige@45vlzzaa73o3>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-5-lrh2000@pku.edu.cn>
 <CA+CK2bBD_fdmz1fFjB8MXBGMHf4jzRWeBRirH3HdWRLqY7cmtw@mail.gmail.com>
 <mgnjfbklr6ew7p4utamdidrvdtchaazovfuduaabplwtpq3se2@uamamaee3rlk>
 <c60d3aa9-f8cd-6c78-3004-8017d7c95443@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c60d3aa9-f8cd-6c78-3004-8017d7c95443@redhat.com>
X-CM-TRANSID: 54FpogCXn7tjkGNkJmddFA--.5433S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWkZr4UJFWxXF1DZr17GFg_yoW5Gr4xp3
        y8Ca1qkFs5KFySkrnFqrnF9rySk3y8Gay5uryrta4jv3ZIyr1fCr15twnFkF129rZFk34U
        ZF4jqryS93ZrZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w
        4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy7743xAAbsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:54:04PM +0200, David Hildenbrand wrote:
> 
> On 16.05.23 13:51, Ruihan Li wrote:
> > On Mon, May 15, 2023 at 12:28:54PM -0400, Pasha Tatashin wrote:
> > > 
> > > On Mon, May 15, 2023 at 9:10 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> > > > 
> > > > The current uses of PageAnon in page table check functions can lead to
> > > > type confusion bugs between struct page and slab [1], if slab pages are
> > > > accidentally mapped into the user space. This is because slab reuses the
> > > > bits in struct page to store its internal states, which renders PageAnon
> > > > ineffective on slab pages.
> > > > 
> > > > Since slab pages are not expected to be mapped into the user space, this
> > > > patch adds BUG_ON(PageSlab(page)) checks to make sure that slab pages
> > > > are not inadvertently mapped. Otherwise, there must be some bugs in the
> > > > kernel.
> > > > 
> > > > Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
> > > > Fixes: df4e817b7108 ("mm: page table check")
> > > > Cc: <stable@vger.kernel.org> # 5.17
> > > > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > > 
> > > Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > 
> > > I would also update order in mm/memory.c
> > > static int validate_page_before_insert(struct page *page)
> > > {
> > > if (PageAnon(page) || PageSlab(page) || page_has_type(page))
> > > 
> > > It is not strictly a bug there, as it works by accident, but
> > > PageSlab() should go before PageAnon(), because without checking if
> > > this is PageSlab() we should not be testing for PageAnon().
> > 
> > Right. Perhaps it would be better to send another patch for this
> > separately.
> 
> Probably not really worth it IMHO. With PageSlab() we might have PageAnon()
> false-positives. Either will take the same path here ...

Well, I'm not against that. If just fixing this one doesn't look
worthwhile, I'm not sure if anyone wishes to find and clean up all these
"misuses" altogether, though that's certainly a low-priority task if
nothing is actually broken.

> 
> On a related note, stable_page_flags() checks PageKsm()/PageAnon() without
> caring about PageSlab().
> 
> At least it's just a debugging interface and will indicate KPF_SLAB in any
> case as well ...

I just went through that function quickly, and found that PageHuge also
seems to be accessing non-existent fields (folio->_folio_dtor) on slab
pages. Again, nothing is really broken.

> 
> -- 
> Thanks,
> 
> David / dhildenb

Thanks,
Ruihan Li

