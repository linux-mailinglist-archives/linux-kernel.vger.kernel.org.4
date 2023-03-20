Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B96C13DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCTNoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCTNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:44:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7F11F92F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lyaRvsye6sWCYUaK2r7kITb5Cun3WkrtNnMFlhr/WZs=; b=BN6jRCUiL5YXWEQuJl9pMl5886
        K4uUNDR9EKK7rheJ/M/Ig50O9RvfiuWlggLqjqsXM77Wlx5UG3DJpT2/u05D4hI+cXFNHzF2nB/Ca
        IWb5oHndufarTQI8vZUVq3lpXW7kZ1O5LqeTr9hbeVSl3I15sp1wxMRB44IKU3c8AXTOhksjBBy+k
        jZPBO1Q4JX88AMgaSIW1Ft1w3TSUbv2gFFZ5ISdOWq+8uoWfLJrFrQInZKbJC7EyX+dxuYWFgoIvH
        I/My94HTVPUF9KZKE7ldXlAJGHZTcZUQUR8RHWsouypLxmGjgr1XQMJVoe5Cp5NQ6mtp6hm6qS172
        4bnXPsyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peFnI-009Dkw-1x;
        Mon, 20 Mar 2023 13:43:24 +0000
Date:   Mon, 20 Mar 2023 06:43:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hanqi@vivo.com,
        liyangtao <11127627@bbktel.com>
Subject: Re: [PATCH] f2fs: compress: fix to wait page writeback in
 f2fs_write_raw_pages()
Message-ID: <ZBhi/OSEak3QPryb@infradead.org>
References: <20230316093632.25929-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316093632.25929-1-frank.li@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 05:36:32PM +0800, Yangtao Li wrote:
> +		if (PageWriteback(cc->rpages[i])) {
> +			if (wbc->sync_mode != WB_SYNC_NONE)
> +				f2fs_wait_on_page_writeback(cc->rpages[i],
> +						DATA, true, true);
> +			else
> +				goto continue_unlock;

Please avoid the else by doing the goto in the branch:

		if (PageWriteback(cc->rpages[i])) {
			if (wbc->sync_mode == WB_SYNC_NONE)
				goto continue_unlock;
			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true,
						    true);
