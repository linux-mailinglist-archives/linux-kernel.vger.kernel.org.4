Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7426FF604
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjEKPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEKPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:32:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D6E559F;
        Thu, 11 May 2023 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ukarEjrht7JhMJxsWUDK8oALIr9FUvFh7Sj9Teu/1Wk=; b=wEQNUTAcDAM2o1nSwW8TRDfzef
        pR2hm2LdCvaF9/3/ZGKV4hA2eHkUo8SRHXan5JeOGeinnWQ4sztTfMDIqVB3bxU5coTLeVs4EKgX4
        RyV1i6KPTSC0T26g1h1aio5Zkp4eV/opt7tCMpUOMUtZ+4yudzHlzf1bhb7XYWnHV4cPBSSIrpdcv
        r9Kq7LlzKTyYnYBPG6Yyf7FXiBlgkGMwPkIFStRNsNISQhY7lb7NaeYOBqUbYb6VY1ANG03l6g4CZ
        E2NQftm7xEz7YJ4dVuFR0I4WJhtLUEOodbkZ8WCNBdQalIL1pNTEBQKMvvNniuqegBmDKNLp2do+u
        eG4S7bmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1px8Gv-009DVp-09;
        Thu, 11 May 2023 15:32:01 +0000
Date:   Thu, 11 May 2023 08:32:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ruihan Li <lrh2000@pku.edu.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/4] Fix type confusion in page_table_check
Message-ID: <ZF0KcRgclDJ6POrb@infradead.org>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <2023051108-lens-unsocial-8425@gregkh>
 <cyym2uqyqdtegfbdpworng4fa7iiuyh3e2wjrf4lp47jksvoxt@wwhvnzy5757c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cyym2uqyqdtegfbdpworng4fa7iiuyh3e2wjrf4lp47jksvoxt@wwhvnzy5757c>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:44:55PM +0800, Ruihan Li wrote:
> Christoph's patch perfectly fixes _one_ problem: kmalloc'ed memory
> cannot be mapped to user space. However, as I detailed in the commit
> message, this series of patches fixes _three_ problems.

FYI, I agree with you.  My simple patch was sent before reading
your new series, and is a strict subset of it.

> I have to say that the original code is quite buggy. In the
> gen_pool_dma_alloc path, there is no guarantee of page alignment. 

I also find this whole interface very problematic to start with,
but that's a separate discussion for later.
