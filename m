Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E36D4B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjDCPKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:10:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF6197;
        Mon,  3 Apr 2023 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZoXFx8oNL/N+tUpgQ9R5nRcJHiW5eJ11y0V+QBJtJbE=; b=JtMGl/T1h3Tk0EB9kqoDklN/1D
        vjpkewGSjYKCtkYwxAWFfCJqGdz2D4VE+0UDW8kLyvNHtkKi80O74EHK9KRsfQC0kTPlqp3Of78Wi
        oaDoWR0W6adOx2tA/Gyov+yKLgKsd+zHQ4uomWio0xAnlGrvOR3VeRugIZDiTveSJ8COwJLn1jV2u
        9WM0+/+wnsmTAkUhMC+Vi/2ifOoYmc0d459vRfx5KPv2me5HB9xovqCbHkGwFsJNdh98ZLeWgH11R
        Qteon8LpKeuBCIAbWEeQt+SkgNcmhwlguFM/qRQ28kclUvSnvjP9lMjBC8RUrcwWbg3JDI1Vj51ys
        Ol+vdD9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjLpO-00FkAA-1h;
        Mon, 03 Apr 2023 15:10:38 +0000
Date:   Mon, 3 Apr 2023 08:10:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCrsbv+zKGf4jvUm@infradead.org>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCNN2GE3WBjMkLkH@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:28:08PM -0400, Kent Overstreet wrote:
> > Can you post a code size comparism for the before and after cases?
> 
> 6.2:
> kent@moria:~/linux$ size ktest-out/kernel_build.x86_64/vmlinux
>    text    data     bss     dec     hex filename
> 13234215        5355074  872448 19461737        128f669 ktest-out/kernel_build.x86_64/vmlinux
> 
> With patches:
> kent@moria:~/linux$ size ktest-out/kernel_build.x86_64/vmlinux
>    text    data     bss     dec     hex filename
> 13234215        5355578  872448 19462241        128f861 ktest-out/kernel_build.x86_64/vmlinux

So we have a slightly larger binary size, and a slighly larger source
code size.  What is the overall benefit of this conversion?
