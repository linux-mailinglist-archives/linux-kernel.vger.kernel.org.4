Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089376FF6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjEKQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbjEKQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:19:32 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69EE3E70;
        Thu, 11 May 2023 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=T46lKjyksdSH1mMWMKwFyNNuZqIq
        3bsgJShvfu2imFw=; b=EYxzrv7yMThObCD2fNLyafIhForMgk7uoc+tziV+8jNF
        hQWhx+2nWjh/PPfagI73Jl3svDIVmHR8Gtjt0SIe9CS0V04XGTWr8DudC/nYsAle
        huohL4AKMJo2DMsSrr9HqSlPk5TPxNazbbZiUC8Nq/XpaFEaAdn1BACFDYW4mJ0=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogCXbjh9FV1kchqUEw--.22912S2;
        Fri, 12 May 2023 00:19:15 +0800 (CST)
Date:   Fri, 12 May 2023 00:19:09 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH 0/4] Fix type confusion in page_table_check
Message-ID: <zwixiok55avpjvfiknp7tzm7e4aragjj43a46abna4qqegdvdx@suat6sk34lgb>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <2023051108-lens-unsocial-8425@gregkh>
 <cyym2uqyqdtegfbdpworng4fa7iiuyh3e2wjrf4lp47jksvoxt@wwhvnzy5757c>
 <ZF0KcRgclDJ6POrb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF0KcRgclDJ6POrb@infradead.org>
X-CM-TRANSID: 54FpogCXbjh9FV1kchqUEw--.22912S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy5uF4kXw15Cr4UCr17KFg_yoWDCFgE9F
        yDKFnF93yDJa13tr43tF4IqrZ3KF4kXF10vFZYqr4IkF98XF97t3WkGrnrZF1xGw4Fva45
        Crnaya42vr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04
        k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy772BUwARsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:32:01AM -0700, Christoph Hellwig wrote:
> On Thu, May 11, 2023 at 09:44:55PM +0800, Ruihan Li wrote:
> > Christoph's patch perfectly fixes _one_ problem: kmalloc'ed memory
> > cannot be mapped to user space. However, as I detailed in the commit
> > message, this series of patches fixes _three_ problems.
> 
> FYI, I agree with you.  My simple patch was sent before reading
> your new series, and is a strict subset of it.

Thank you for the clarification.

> > I have to say that the original code is quite buggy. In the
> > gen_pool_dma_alloc path, there is no guarantee of page alignment. 
> 
> I also find this whole interface very problematic to start with,
> but that's a separate discussion for later.

Yes. I don't think hybrid allocation of DMA memory and normal memory in
one function is a good thing, but currently there is no clear way to fix
this. Mixing memory allocation and page allocation is another bad thing,
and at least, my patch can (hopefully) solve the second (and much
easier) issue.

Thanks,
Ruihan Li

