Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBB6A0CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjBWPQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjBWPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:16:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD8E26B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8HzabJp/cXrWDY48qzMLxByeXCQnGuuL8reAj6STRjM=; b=kunqqM/8FTfbAJeEfKATMqrhEV
        F7Ge+WPDReiKFgh/ffkKpwejot8v2MSbxMQ+ndeYFx9+oWOjxWBiWnTBNSDIr9MZjRAmJZATLYqCR
        2xgoDFnAg6uidlA1N0/usqtfmDpoKkEZrTR7/RnEvwPwZB3Jonhl+zv479rn/lL69ePIstJNwolhq
        NcWscEL+D2pVroU8h0fXFQXBd/Vac4tZL9gpLdjtJkn94B8E6HeyNgaKbkR+CrvnyJlp1gLIbWaDS
        QorViMPiTKcAZRu+03LO5t2WlK+adt3u4mWSRLlRF13U50yrWXiRi4Gxli4NBUzP0xWAQzM8Svown
        zvnGFpIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVDKL-00Gzh3-V0; Thu, 23 Feb 2023 15:16:09 +0000
Date:   Thu, 23 Feb 2023 07:16:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        yosryahmed@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 5/5] shmem: add support to ignore swap
Message-ID: <Y/eDOXC4+vpCCBic@infradead.org>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
 <20230223024412.3522465-6-mcgrof@kernel.org>
 <20230223122631.hwvhbqxadvbm23nb@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223122631.hwvhbqxadvbm23nb@wittgenstein>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 01:26:31PM +0100, Christian Brauner wrote:
> We would have use-cases for this in systemd. We currently use ramfs for
> systemd's credential logic since ramfs is unswappable. It'd be very neat
> if we could use tmpfs instead,

What is the advantage of using a swapless tmpfs over ramf?
