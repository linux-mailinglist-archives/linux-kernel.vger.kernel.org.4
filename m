Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5D704D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjEPLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjEPLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:53:08 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDC275592;
        Tue, 16 May 2023 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=VS
        +nfB/HDB6UiMWHB0tfrnL0IzjksWjCC8c/qPgjfM4=; b=YCK/QyFJMV6H+G9ugE
        SEE3gVFxOfyVQLaOzVc8LR0n2JMo/osesjt9jeW2N3jLc+8rPhlpCR/cVF4GuiE8
        YO+q830PIIxaOLROE83jHcUu0uQscdxxuZ4XClq4hbZEcMQIAgWkcrbkVTKddX+/
        8pXiiXPFFe7efNBgL9qgZuKGo=
Received: from localhost (unknown [10.7.98.243])
        by front01 (Coremail) with SMTP id 5oFpogBnYrxdbmNk7jBtAw--.4402S2;
        Tue, 16 May 2023 19:52:02 +0800 (CST)
Date:   Tue, 16 May 2023 19:51:57 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH v2 4/4] mm: page_table_check: Ensure user pages are not
 slab pages
Message-ID: <mgnjfbklr6ew7p4utamdidrvdtchaazovfuduaabplwtpq3se2@uamamaee3rlk>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-5-lrh2000@pku.edu.cn>
 <CA+CK2bBD_fdmz1fFjB8MXBGMHf4jzRWeBRirH3HdWRLqY7cmtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBD_fdmz1fFjB8MXBGMHf4jzRWeBRirH3HdWRLqY7cmtw@mail.gmail.com>
X-CM-TRANSID: 5oFpogBnYrxdbmNk7jBtAw--.4402S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xur45Gr17XFyfCFyDZFb_yoW8Wr45p3
        ykC3Z2kFs5KF92k3ZFqwsI9w1FyayDAay5Zrn5tF1vv3ZIyryxCr1UZwsa9rnI9rZFk34j
        vF4Yqry0vayDZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w
        4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbZmitUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy7743xAAWsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:28:54PM -0400, Pasha Tatashin wrote:
> 
> On Mon, May 15, 2023 at 9:10 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> >
> > The current uses of PageAnon in page table check functions can lead to
> > type confusion bugs between struct page and slab [1], if slab pages are
> > accidentally mapped into the user space. This is because slab reuses the
> > bits in struct page to store its internal states, which renders PageAnon
> > ineffective on slab pages.
> >
> > Since slab pages are not expected to be mapped into the user space, this
> > patch adds BUG_ON(PageSlab(page)) checks to make sure that slab pages
> > are not inadvertently mapped. Otherwise, there must be some bugs in the
> > kernel.
> >
> > Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
> > Fixes: df4e817b7108 ("mm: page table check")
> > Cc: <stable@vger.kernel.org> # 5.17
> > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> 
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> I would also update order in mm/memory.c
> static int validate_page_before_insert(struct page *page)
> {
> if (PageAnon(page) || PageSlab(page) || page_has_type(page))
> 
> It is not strictly a bug there, as it works by accident, but
> PageSlab() should go before PageAnon(), because without checking if
> this is PageSlab() we should not be testing for PageAnon().

Right. Perhaps it would be better to send another patch for this
separately.

> 
> Thanks you,
> Pasha

Thanks,
Ruihan Li

