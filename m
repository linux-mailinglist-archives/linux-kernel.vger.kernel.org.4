Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18F726266
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbjFGOKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjFGOKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:10:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1121BE6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Eo410/mvVPKIDvL65SAibhxBxSngpZMHxmIM5A6ESGs=; b=upW37M0YmfRVSPlDuO8CFVotIn
        Z4AGgoHeL5plEiHj6ShVSCIvOzV2JPcwdG3VOtqwgF4TGg3Dal6vOGvJXbQmFsJ2BjTlURdjAj6O3
        fZseSWZ5uMKFeeSGelXQMndDUnE+WiesPQGM7tvDndeyCRD5rqtTcKZjEpcCJL/JNDTJjPh+OYOtw
        0zzJ2CHq7AdUJrJ6xVuLZuRqeRXb7sKo3iUSlwv8ZjL5w3IYQlm2aIzfcIcM3HBfZG54fWcrZDaA4
        NHwyNkb+OcMAQgZhw1t2uYcQ6odJkJK27AZGLDhN0jZH13HqtmnbCaL9AXldk7/v7n4Vo7DlooGL5
        NrBGNkVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6trb-006D93-1v;
        Wed, 07 Jun 2023 14:10:15 +0000
Date:   Wed, 7 Jun 2023 07:10:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Message-ID: <ZICPx7RU0Qzh5zQY@infradead.org>
References: <20230606050149.25699-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606050149.25699-1-mpenttil@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:01:49AM +0300, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> Migrating file pages and swapcache pages into device memory is not supported.
> The decision is done based on page_mapping(). For now, swapcache pages are not migrated.

Please fix the commit log formatting, it should not exceed 7 lines.

>  		if (is_device_private_page(newpage) ||
>  		    is_device_coherent_page(newpage)) {
> -			/*
> -			 * For now only support anonymous memory migrating to
> -			 * device private or coherent memory.
> -			 */
> +
>  			if (mapping) {

Very nitpicky, but this empty line looks odd.  Also isn't the comment
still (mostly) correct given that file backed memory is still not
supported?

> +				/*
> +				 * For now only support anonymous memory migrating to
> +				 * device private or coherent memory.
> +				 *
> +				 * Try to get rid of swap cache if possible.
> +				 *
> +				 */
> +				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {

Please avoid the overly long lines.

