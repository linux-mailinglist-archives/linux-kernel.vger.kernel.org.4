Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCB7015E5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbjEMJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D713C00;
        Sat, 13 May 2023 02:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49A26119C;
        Sat, 13 May 2023 09:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A2EC433EF;
        Sat, 13 May 2023 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683971459;
        bh=dMoTQ63RKbecSEixIrO0V2zTmSrM95YztdeqbgXoWZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5ddjGc85xi7cSC/NNfwLHwTpvtjLrXK7IvvdEFi3tNEPzk+42ExMh44gtjKTRrzS
         fK8huJe61GeBwSqIuabTIUt+ZSJB99e/44+qBQMoVF1pw7vaOEdOZCwVC5IiL6GW1j
         RbN7A0KyQJVwIKibLnHefJGsLY5HeiUuBcrqqCm0=
Date:   Sat, 13 May 2023 18:37:52 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] Fix type confusion in page_table_check
Message-ID: <2023051324-attentive-footwork-9dec@gregkh>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <2023051108-lens-unsocial-8425@gregkh>
 <cyym2uqyqdtegfbdpworng4fa7iiuyh3e2wjrf4lp47jksvoxt@wwhvnzy5757c>
 <ZF0KcRgclDJ6POrb@infradead.org>
 <zwixiok55avpjvfiknp7tzm7e4aragjj43a46abna4qqegdvdx@suat6sk34lgb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zwixiok55avpjvfiknp7tzm7e4aragjj43a46abna4qqegdvdx@suat6sk34lgb>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:19:09AM +0800, Ruihan Li wrote:
> On Thu, May 11, 2023 at 08:32:01AM -0700, Christoph Hellwig wrote:
> > On Thu, May 11, 2023 at 09:44:55PM +0800, Ruihan Li wrote:
> > > Christoph's patch perfectly fixes _one_ problem: kmalloc'ed memory
> > > cannot be mapped to user space. However, as I detailed in the commit
> > > message, this series of patches fixes _three_ problems.
> > 
> > FYI, I agree with you.  My simple patch was sent before reading
> > your new series, and is a strict subset of it.
> 
> Thank you for the clarification.
> 
> > > I have to say that the original code is quite buggy. In the
> > > gen_pool_dma_alloc path, there is no guarantee of page alignment. 
> > 
> > I also find this whole interface very problematic to start with,
> > but that's a separate discussion for later.
> 
> Yes. I don't think hybrid allocation of DMA memory and normal memory in
> one function is a good thing, but currently there is no clear way to fix
> this. Mixing memory allocation and page allocation is another bad thing,
> and at least, my patch can (hopefully) solve the second (and much
> easier) issue.

Ok, I'll take these through the usb tree if I can get an ack for the
mm-specific patches.  Or were you going to send a v2 series?

thanks,

greg k-h
