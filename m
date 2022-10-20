Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C33605EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJTLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJTLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:25:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5822106E36
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z5vCg4fZ++9q6ZHqE1Y7XphjIBR9oZaDjLMJARhZK+k=; b=O0ZufuZpwwy7snW5RWWBTuhTXX
        6gO9M0z9COPVX0CrjHptxtBtt02xUZmEGSs/Uws9oVB0tRW3oGssLYxh9Lue0iDc+bn24Xhc/Ot0s
        pK/7M/DqLC/tVfHLDPhqGAY4hPro963EeoBR4Hxpttvwfsgcs6rQ/nyx285tOrlB5v9d3puFR1++T
        VxuNXWxs48DWZcemmHpKlTGRZSgr9eVrzE1JLEs1SPyzSRcGV+3C1I3o7cxUtfkFMVW9SakWPa6LS
        LavdPJQjQBJJhGyHU+/LjiYNIlTDLo/X+vXu5vh0epUkSljMH/6yAwe/uWoF3RBQywJqyKZdVGYK+
        H2v+dEcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTfe-00E30Z-4R; Thu, 20 Oct 2022 11:25:06 +0000
Date:   Thu, 20 Oct 2022 04:25:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 5/7] mm: vmalloc: Use trace_purge_vmap_area_lazy event
Message-ID: <Y1EwEg7E4OodgecC@infradead.org>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-6-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018181053.434508-6-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	return num_purged_areas > 0 ? true:false;

The formatting here is a bit off due to the lack of whitespaces around
the :.  But as boolean expression propagate to boolean values this
can be simplified to:

	return num_purged_areas > 0;

anyway.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
