Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA271700E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjE3V6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjE3V61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:58:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814510D;
        Tue, 30 May 2023 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3C/NcqnL3nbx3116cpidA3gdTYZDwalpUlZFWRa3Q2M=; b=MmweSvhsrE7SrMXuJP8lIPse5J
        PoyyDbMUvAuiCnNgvIyFrkCknpL3lcKNAQHMe17ywG1G0z5YMPZZDCQ0eElBIoYi+GS5AYiUWTIbc
        fCgh3hVqbeZfY3lckoOAeSlqTBrCHEDkjokqElfUAI6W2egcibNkQhq4szw5S+OM72dHx23dKZi06
        /gDqowkPKxlCgK/Nva5LTsYAT5nwuNfli6tAGI7qe47dwVDC5qW3tIbL1BrwxYgMVTAq3AwF/eq4B
        fSkwfODrIv+uqi2ONCc5cfwHNN/MhUYaJq8HE6hdSanPigHkt89jEzmrc8oGvr92r2/coZRp8C/fC
        BiHk5n4w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q47M8-00FFAc-06;
        Tue, 30 May 2023 21:58:16 +0000
Date:   Tue, 30 May 2023 14:58:15 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"'
Message-ID: <ZHZxdz6TSkf7aBJD@bombadil.infradead.org>
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:43:12PM -0700, Dan Williams wrote:
> [ add linux-cxl ]
> 
> Sedat Dilek wrote:
> > Hi,
> > 
> > after building Linux v6.4-rc4 I can NOT boot into my Debian GNU/Linux
> > AMD64 system with root-ext4 (/dev/sdc2 - of course using UUID in
> > /etc/fstab).
> 
> I did not find a mailing-list thread for "9828ed3f695a module: error out early
> on concurrent load of the same module file", so replying here. This
> commit breaks the basic CXL smoke test of loading the combination of
> cxl_acpi, cxl_pci, and cxl_mem modules.
> 
> Just wanted to highlight this a test case for the next attempt at this
> fix.

The revert has already been done:

commit ac2263b588dffd3a1efd7ed0b156ea6c5aea200d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon May 29 06:40:33 2023 -0400

    Revert "module: error out early on concurrent load of the same
    module file"

The smoke test, is this the ndctl cxl tests with the mock driver? If so
then I could use it to test future efforts for alternatives for this
work before any new changes get merged.

  Luis
