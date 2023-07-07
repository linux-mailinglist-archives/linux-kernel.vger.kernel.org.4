Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968D174B6AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGGS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:56:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295C10C;
        Fri,  7 Jul 2023 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iKKhHf4vxup8Dipa1rYXDF76sBEYhb1cNBcsVojkLVg=; b=1Y8zfepe1HJaB2bncP9IilTchy
        XCv61wfpmXga1uA8Crnf9g52NAmOUgaNJSgXd48VbP+c4aYnZJzGMBL2UlxkKY+wY+wu045TIhXS1
        JTDh0hsNwCuUqqlmnf3xoy+E6nlepQkL9zcwiBVQsL9zCVf1c7zBPtxq3KUt9gGLVae37lxLH6xiv
        XiND/Kl7cDK+rkZWi+ZH9Of9s2k/8++XAPtFUhw4cKlLx8QobWgyGprzCcdiWMEjmL0PIeppGGqkV
        i8wEnfIRcLJy0NqO75bwOT25b5EQB6Rk7Gox7tAeGGERaFzijHOVyzL3oqKuB9MBGDzSrpMDMkfQs
        qNnwc2xA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHqdN-005TDU-0T;
        Fri, 07 Jul 2023 18:56:49 +0000
Date:   Fri, 7 Jul 2023 11:56:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZKhf8bi/eBDhaihD@bombadil.infradead.org>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
 <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
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

On Mon, Jul 03, 2023 at 03:47:22PM +0200, Michal Hocko wrote:
> On Fri 30-06-23 16:05:33, Luis Chamberlain wrote:
> [...]
> > What prevents code from racing the free with a random module_put()
> > called by some other piece of code?
> 
> Wouldn't be ref count a garbage already? How can you race when freeing
> if module_put fail?

It could yes, ie, so this risks at all being junk. So best IMHO is
to tidy up all the get / puts and add respective tests to fix all
this mess with proper messages as needed. My cursory review of the
refcnt stuf is I see some races possible.

While I'd be happy to help debugging aids, adding accesses to random
memory for a string seems more risk prone.

  Luis
