Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2065532B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiLWRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiLWRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:15:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1CF58D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0cZ0mt91TyzNw0HU5DsG1MlYLdTdSBQN+CWQAWeWbAs=; b=G7X/ycThvePMUp6sX4GXGyf4gf
        laY9P5zoVQeWo7ULj06Z+TUMqp6dPpstZMJeTHWhP2EsHJE6FJNO+O2+RT0249LNp6jBi+H/+A6Wk
        d47u3JR71cla1iYa0R0mdrcPXBLIlF7RSA8PGgadPrI9kOsdwMs2VXv7t4NfZNYiKdta3WuBhckiI
        CSKzzo4A9ymV6Tmzyo+UHKRl7tqpQllT/s0mJA9lmSMhkVrAErZI0qqi+Wr8/Z0nmMFhuwAeV0Zcb
        rrw0t7vHaWMsg3fu2BPqxi9DC65J6FO1/Jk9PR+QED1vle+v6mhbOFBsVrPseVpaI11FDaeIgSvVY
        rWQjRLDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8ldj-00AIpJ-NW; Fri, 23 Dec 2022 17:15:23 +0000
Date:   Fri, 23 Dec 2022 09:15:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 11/11] dmapool: link blocks across pages
Message-ID: <Y6XiK/THZio8PuJ7@infradead.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-12-kbusch@meta.com>
 <Y6XeJ2mzd8p73J93@infradead.org>
 <d9d58b20-5ce5-ebfd-bcfa-523086b66739@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9d58b20-5ce5-ebfd-bcfa-523086b66739@cybernetics.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 12:08:54PM -0500, Tony Battersby wrote:
> I previously recommended that they should be size_t because they are
> counting the number of objects in the entire pool, which can be greater
> than 2^32.   See patch 4 "dmapool: cleanup integer types".

Oh, ok.

>   However the
> kernel test robot has complained that some of the printk format
> specifiers need to be changed to match the size_t type.

Yes, they do.
