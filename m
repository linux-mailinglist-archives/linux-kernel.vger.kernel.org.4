Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9668C2F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjBFQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjBFQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:19:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7C2A994
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=763ye/8X3APDNxobGOw1oc0nUCmlhrotZmvXI5/VHjA=; b=kBCRaFRZ4cccxqHt5MiYsau2FX
        /kttVZX2hRJw3vmk3v/nJesYa7mmXNBHzI/7YcK+MNs2CTaby+mUXEqrDqNCGRYGxYDGwWAniLIuD
        O9WVyM+HGx6F07oznBCbSjf53UGzlPCV6rfgZO8wp1OmJNJWFunOBr1lhrINev5acjE27GfZVX3Ak
        jK/bVJHd0lzQ+lanMA4d2SZguktjpgsm32YkPuAxS7LHfltSJgzZzI/FLCrhDEmmqpY9XKFlDqZhQ
        UbrO+Ghfo0siObCfFvX5fonZh8Dp/ktuWClP8ukRIWEN9elU+PmStnBIED3kmb6nV/nYVJTMI8brS
        kOkzxvtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP4CC-00Gtpn-GD; Mon, 06 Feb 2023 16:18:20 +0000
Date:   Mon, 6 Feb 2023 16:18:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, mhocko@suse.com, vbabka@suse.cz,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Message-ID: <Y+EoTPqkSOrOZlyq@casper.infradead.org>
References: <cover.1675690847.git.quic_charante@quicinc.com>
 <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:51:33PM +0530, Charan Teja Kalla wrote:
> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +				 pgoff_t start, pgoff_t long end)
> +{
> +	struct page *page;
> +	pgoff_t index;
> +
> +	xa_for_each_range(&mapping->i_pages, index, page, start, end) {
> +		if (!xa_is_value(page))
> +			continue;
> +		page = shmem_read_mapping_page(mapping, index);
> +		if (!IS_ERR(page))
> +			put_page(page);
> +	}
> +
> +	return 0;
> +}

Hm, that's a gap in the shmem folio API.  Patches imminent.
