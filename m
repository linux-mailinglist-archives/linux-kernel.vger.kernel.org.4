Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56956701DEF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjENPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENPIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:08:47 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 737FB1BC5;
        Sun, 14 May 2023 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=Ni4GctG6j2JiKGvnSbCcZe/JfZsD
        B8hY8dsw53qz1zI=; b=DE6z7MdkJsS+bHcnlf7igxWIoUzmIn3KFRIiCBGjR/Rl
        XDJcF3y6fuCf/riHiMLxrxrTNifVzSGT7k7DQGKSQPiPlLTuDVKmNPg7B6MYoBoH
        nvualjmSTFxe6uFXkqFzwg0a7IS7BrU+mtwE4VLHtvBiKYu0gNHUiT9mgnjhpAU=
Received: from localhost (unknown [10.7.98.243])
        by front01 (Coremail) with SMTP id 5oFpogAHnTxb+WBkkWwfAw--.45456S2;
        Sun, 14 May 2023 23:08:15 +0800 (CST)
Date:   Sun, 14 May 2023 23:08:11 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH 0/4] Fix type confusion in page_table_check
Message-ID: <zwcena7ynuhyqqioppeh47jdlgvkc5k2uar3cnvkgwzck4w7w3@riv4ca62kyjr>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <2023051108-lens-unsocial-8425@gregkh>
 <cyym2uqyqdtegfbdpworng4fa7iiuyh3e2wjrf4lp47jksvoxt@wwhvnzy5757c>
 <ZF0KcRgclDJ6POrb@infradead.org>
 <zwixiok55avpjvfiknp7tzm7e4aragjj43a46abna4qqegdvdx@suat6sk34lgb>
 <2023051324-attentive-footwork-9dec@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023051324-attentive-footwork-9dec@gregkh>
X-CM-TRANSID: 5oFpogAHnTxb+WBkkWwfAw--.45456S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4xuF45Wr1xKw45GF1Utrb_yoW8Xr4Dpa
        y3tayDta1ktwn3Aw1Ivw1xu34rt3yfKryUW34Yq34fC3ZIgry3KrsrKr4a9F9xCr1kW3W7
        XF4jvasxZ3WYy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w
        4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEJBVPy773nzgACsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 06:37:52PM +0900, Greg Kroah-Hartman wrote:
> 
> On Fri, May 12, 2023 at 12:19:09AM +0800, Ruihan Li wrote:
> > On Thu, May 11, 2023 at 08:32:01AM -0700, Christoph Hellwig wrote:
> > > On Thu, May 11, 2023 at 09:44:55PM +0800, Ruihan Li wrote:
> > > > Christoph's patch perfectly fixes _one_ problem: kmalloc'ed memory
> > > > cannot be mapped to user space. However, as I detailed in the commit
> > > > message, this series of patches fixes _three_ problems.
> > > 
> > > FYI, I agree with you.  My simple patch was sent before reading
> > > your new series, and is a strict subset of it.
> > 
> > Thank you for the clarification.
> > 
> > > > I have to say that the original code is quite buggy. In the
> > > > gen_pool_dma_alloc path, there is no guarantee of page alignment. 
> > > 
> > > I also find this whole interface very problematic to start with,
> > > but that's a separate discussion for later.
> > 
> > Yes. I don't think hybrid allocation of DMA memory and normal memory in
> > one function is a good thing, but currently there is no clear way to fix
> > this. Mixing memory allocation and page allocation is another bad thing,
> > and at least, my patch can (hopefully) solve the second (and much
> > easier) issue.
> 
> Ok, I'll take these through the usb tree if I can get an ack for the
> mm-specific patches.  Or were you going to send a v2 series?
> 
> thanks,
> 
> greg k-h

There are some comments from Alan and David, so I'll send a v2 series to
address them (probably tomorrow).

Thanks,
Ruihan Li

