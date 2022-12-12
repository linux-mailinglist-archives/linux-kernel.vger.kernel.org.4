Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD254649A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiLLI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLLI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:59:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9F3A455
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vlsLInJg8ivyDfT/+ECBjEvPmYLfNsOfrSBRnC/MnCA=; b=pui21rI8+7nedAtI9GIQ64pnf2
        XJBJRVftscIwEyQpDLOu9AAQ+NgK8nElLMBeR+mbt+tBpVfuSJ/pysMkjDVaQJKFGbS/M9qCcXyv9
        igVTe19hAMB/fS0pmbMmiLvmKeuqkrVqYSTG3K2stWl1oW2TyCSk7qDf3aGAcTfUOSqDUSnJ3n60e
        xwhEfAIBFJI/835vJSAtPCWoUEoOkwr4mwW7z+/4vde3Pz+zGHRJMrKzYVTPlulfhN1jExMHsd/v5
        undDr4r/40P4dxeetHfdaIBSsk7ixpowZMcD1za2Ilcd/Rp1Zl8zjdwWqpeygAonSZWKfK9w+BZum
        QmlfYvVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eeo-00Ahd4-5r; Mon, 12 Dec 2022 08:59:30 +0000
Date:   Mon, 12 Dec 2022 00:59:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] fs: sysv: Fix sysv_nblocks() returns wrong value
Message-ID: <Y5btclrLIUfLxuZ9@infradead.org>
References: <20221209100448.176857-1-chenzhongjin@huawei.com>
 <Y5TaOt0NLnB/h6QM@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5TaOt0NLnB/h6QM@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 07:12:58PM +0000, Al Viro wrote:
> This is obviously the sysvfs counterpart, not noticed back then and
> not caught in 18 years since then...
> 
> Mea culpa - the original bug (both in minixfs and sysvfs) is mine and
> I should've thought to look for sysvfs counterpart when minixfs fix
> got posted.

Btw, I have no way to actually test sysv anymore, so I'm tempted to
orphan it.  Is there anyone actually still using it?  With some
of the upcoming transitions in the folio, buffer_head and co APIs
it might be a good time to drop unmaintained file systems now,
and sysv is a hot candidate.
