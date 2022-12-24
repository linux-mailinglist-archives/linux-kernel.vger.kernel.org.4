Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8979E655A64
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiLXOzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLXOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 09:55:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B098BF9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE792B80066
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 14:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15B7C433EF;
        Sat, 24 Dec 2022 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671893746;
        bh=gaX8VmGlogTyXaLyHptsBL2ITu2PhTxstVcu9IRiPxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NChsf/pqA+XbwQc9qFtA1/VUeTtvZDDMW+X458LRRXg6jZyIUENIYVcAk0MdWMOlY
         5Ql4abF9/rCYdwbMkARbBOOF6L5l5zGDMM7YM5pOgQsz+LDJsow05KyORI6mBObgnP
         8x77MosOqRoTxPXLBnhd4jzhlyyC11qzx+0ZI5Di9eDKdJDSz+IRJcK+8aqEAoNdMA
         4Jjopsu/JT+uslfouQmp2DUCa90z4qCDD3hQSG9QaIqqikYr/rGTc9JeEsZoSRol6/
         Onld+1aaEzupnGaZ3TO0cf1mR8nJpuu9wYW9Hol6+IF/eDpUpp5vBhBJ3l3WxRj56t
         TFdsjI+5JHn7g==
Date:   Sat, 24 Dec 2022 07:55:42 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCHv2 11/11] dmapool: link blocks across pages
Message-ID: <Y6cS7srbbvvw/LKF@kbusch-mbp.dhcp.thefacebook.com>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-12-kbusch@meta.com>
 <Y6XeJ2mzd8p73J93@infradead.org>
 <d9d58b20-5ce5-ebfd-bcfa-523086b66739@cybernetics.com>
 <Y6XiK/THZio8PuJ7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6XiK/THZio8PuJ7@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:15:23AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 12:08:54PM -0500, Tony Battersby wrote:
> >   However the
> > kernel test robot has complained that some of the printk format
> > specifiers need to be changed to match the size_t type.
> 
> Yes, they do.

Yeah, the type change was a last minute addition that and I messed it
up. Thanks for the other reviews, though, I didn't want to respin this
just for print formats!
