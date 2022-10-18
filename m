Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8B603294
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJRSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJRSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:33:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F99A29A;
        Tue, 18 Oct 2022 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TE0o9ct148mf7iAtxZG4Y88MlcY2NeqbmBgT+PQtIW0=; b=mLD0ZmLMRmP3xJQu10Yb0dKYxL
        XwFs5iPOZo6AcGRxsrvzrjrHyDDcyz+8E9VBsGTzyorVjFWrXaULl5isXGvGy4U3RGx14TlmL+SiV
        Bhsj6YExynDJcCxiOJilDPxcPFQh04VtDYWjmghVzWBvRmVJCjKDZxJLnF6Nut32La4piJ0GvBL2T
        GHTQbLAogdJ7vKDnCxuzIg7xGCyt5TxSQSAWDYji1umlnH45AKwVmJ+I//6e79SqWNuGF93a1QDFf
        2rLGSDpysWG5RXb57tlkZUm7HQ2a+qiPfy8gDiwbgEHQ0QGiwN7iwRKuhHAKkWAhVtiMCyoCSPHbQ
        h1s7UqjQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okrOi-009vzl-0P; Tue, 18 Oct 2022 18:33:04 +0000
Date:   Tue, 18 Oct 2022 11:33:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
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

On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> The patch does address a regression observed after commit 6e6de3dee51a
> ("kernel/module.c: Only return -EEXIST for modules that have finished
> loading"). I guess it can have a Fixes tag added to the patch.
> 
> I think it is hard to split this patch into parts because the implemented
> "optimization" is the fix.

git describe --contains 6e6de3dee51a
v5.3-rc1~38^2~6

I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
right thing to do, but without it, it still leaves the issue reported
by Prarit Bhargava. We need a way to resolve the issue on stable and
then your optimizations can be applied on top.

Prarit Bhargava, please review Petry's work and see if you can come up
with a sensible way to address this for stable.

  Luis
