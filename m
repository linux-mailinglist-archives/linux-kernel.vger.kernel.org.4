Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578105F9F27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJJNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:09:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F02EF13;
        Mon, 10 Oct 2022 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gyIX3AzIymxYoNriDmltRqIhXboTWSwCFq+wUsDyIZQ=; b=gGOCd3YeFdaBwBl2MW+tnd5r55
        LgaxTyufuAidu0AxR29dCeciklDBoOZGaiFhqGu19IBonngzt9KXrRM662lnI6mBvAC48taBAVOYP
        6mWug9b2g3foLMROliBcOrWV84P5XlEVt6v6+80ADZt/urX1RxDbjAByE7ja8U2jDoywfxZDScA42
        HLpFMfaKi3L6Sq9u80PWor0KDB1wwzYuu6k9X6n/PKQK/qxO5OR6OPCsnexhIN3fh6Sj1i54igEr9
        yVvVQeXA8MsNeuQMQzo/t+lsnSrB6SbiQkCAi9LvaHlItgGOrfDd1nRUDHOQ3HvTJcaPL94g12H0f
        1DIzYvvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohsXP-000y8l-TY; Mon, 10 Oct 2022 13:09:43 +0000
Date:   Mon, 10 Oct 2022 06:09:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, steve.kang@unisoc.com
Subject: Re: [RFC PATCH] mm: skip GFP_IO if swap is zram only
Message-ID: <Y0QZlxhPIRMTcqgE@infradead.org>
References: <1665399622-20236-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665399622-20236-1-git-send-email-zhaoyang.huang@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:00:22PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> __GFP_IO is believed to prevent the allocation being suspended due to accessing
> physical block devices when reclaiming dirty pages. Zram is not considered as
> such kind of device from kernel perspective of view. Do swap things if the system
> is zram only.

No, zram is not in any way special, and for sure not important enough
to add special case hacks to the VM code.
