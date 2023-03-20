Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5176C23F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCTViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCTVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:37:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B859DF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=efiuhXiRsVtS87TEO9aeU4SVSwcnAGnV2VTVQCunDHQ=; b=Q5INos9sIjfYhsxfgGksAigKeD
        iqKTMm0t/0tGg9jN/qaLTvq7tsx6FM7yGMMqz4Wd55vOjgziYM0uaYpnQ7MPguTvICQyTTlBztxsM
        F/bbWHNkCdx86AryWhqS9AFNBCOLG/FwI+0Hs+5VaPHI9cuhFvX5AVzTpghVyVe4AkvMmu8kwn/CH
        PHSvWPgrhQu9IPcz5utiNTP9Kr42gHGRhCMg7ICxpJ29l4gNg8qJ2b4r76LRM8j5raG3t4ZrOtrht
        gBNSNc+QQZ9DYT0kXQjphUXUnyrPgB4JEcLLNa5fhfZVCe0uErwI92chiFn6EnLkQtpe3rb+JY/wm
        SQ9SaLMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peNB1-00AYTC-1t;
        Mon, 20 Mar 2023 21:36:23 +0000
Date:   Mon, 20 Mar 2023 14:36:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] tmpfs: add the option to disable swap
Message-ID: <ZBjR15Tr1o98crup@bombadil.infradead.org>
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <e1de614b-25e1-5c21-933a-880412ac7421@linux.alibaba.com>
 <ZBdxWsrYfPgBG6NX@bombadil.infradead.org>
 <edb78eea-a9a2-5c62-d203-6f2be39757d2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edb78eea-a9a2-5c62-d203-6f2be39757d2@linux.alibaba.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:14:22PM +0800, haoxin wrote:
> 
> 在 2023/3/20 上午4:32, Luis Chamberlain 写道:
> > On Tue, Mar 14, 2023 at 10:46:28AM +0800, haoxin wrote:
> > > All these series looks good to me and i do some test on my virtual machine
> > > it works well.
> > > 
> > > so please add Tested-by: Xin Hao<xhao@linux.alibaba.com>  .
> > > 
> > > just one question, if tmpfs pagecache occupies a large amount of memory, how
> > > can we ensure successful memory reclamation in case of memory shortage?
> > If you're disabling swap then you know the only thing you can do is
> > unmount if you want to help the VM, otherwise the pressure is just
> > greater for the VM.
> 
> Un, what i mean is can we add a priority so that this type of pagecache is
> reclaimed last ?

That seems to be a classifier request for something much less aggressive
than mapping_set_unevictable(). My patches *prior* to using mapping_set_unevictable()
are I think closer to what it seems you want, but as noted before by
folks, that also puts unecessary stress on the VM because just fail
reclaim on our writepage().

> Instead of just setting the parameter noswap to make it unreclaimed, because
> if such pagecache which occupy big part of memory which can not be
> reclaimed, it will cause OOM.

You can't simultaneously retain possession of a cake and eat it, too,
once you eat it, its gone and noswap eats the cake because of the
suggestion / decision to follow through with mapping_set_unevictable().

It sounds like you want to make mapping_set_unevictable() optional and
deal with the possible stress incurred writepage() failing? Not quite
sure what else to recommend here.

  Luis
