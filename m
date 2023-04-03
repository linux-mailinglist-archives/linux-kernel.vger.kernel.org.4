Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38836D4B80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjDCPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:13:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E409D;
        Mon,  3 Apr 2023 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B7kXOVNKKiYGm55LmYo0xLWWOBNIP+Mr/6zTfTQhP4Y=; b=Gt8/CIKy93b4Mx86hSubZHEeFl
        +7LgmPyqg45dIbDO94knccQIb8oGwFp2IWCL16yWJnKaOxe3cqzf9iS5VK4btn1wDSB/SfPB4vyaa
        cw+hRDSbkXTftd4AQus1hdriDCjc9labIJEbRzJQrYmDZrHo+ZKMu7e1zhrUpd+MIGaTR10Js2Skw
        7NSdOgAKWyZ4NaXWDsciHiAQktdcPsBEX+fGlyqQiTH8uXySChIVHrsPkxpjK6t5MmyLdK/0SUk9c
        BL0gY3XnNJOFPzGe2hCYr5E1NEkDH7VlDUeGS8Qsiuj5YjQxAu1KHuetUeEs9nlsNY8gkfIe+rMdU
        OlmPBKpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjLs1-00FkUU-2f;
        Mon, 03 Apr 2023 15:13:21 +0000
Date:   Mon, 3 Apr 2023 08:13:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 2/2] block: Rework bio_for_each_folio_all()
Message-ID: <ZCrtEWEYGdGN++wX@infradead.org>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-3-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327174402.1655365-3-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:44:02PM -0400, Kent Overstreet wrote:
> +	bio_for_each_folio_all(fv, bio, iter)
> +		iomap_finish_folio_read(fv.fv_folio, fv.fv_offset, fv.fv_len, error);

Please avoid the overly long lines.  Also if we pass all arguments
of the folio_vec we might as ell just pass that folio_vec anyway.

> -	BUG_ON(iter->idx > bio->bi_vcnt || (iter->idx == bio->bi_vcnt && iter->done));
> +	BUG_ON(iter->idx > bio->bi_vcnt ||
> +	       (iter->idx == bio->bi_vcnt && iter->done));

Seems like this should be folded into the previous patch.  Also I
generally prefer to avoid top-level || in asserts and just do multiple
asserts, as that shows which condition triggered.
