Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3C70ED84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbjEXGE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbjEXGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:04:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6E189
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KnLSv0+fPc6PEE7Rpygl26X9mUYlOCDFN5hMIQruVy8=; b=v45P3Sfe7pzlOmUUUO/XRUp/mE
        W1ojE0IGfhO5Wbvjf+mWwEH3jqb733iZJYieBdqjyMAe2kALKLvB6emXOHOggIcrV5N4yvteN653+
        CNenkySYftYeAJ2am2wdgqX1EdTFp2t1hXP11zK8PDpitVqXD9r4DxPlLWG/JqdKkMWtDtsWsU4vi
        3NYkP0nxEcwRKvjSgN/BlShTzSH5pif2/kskccf2muaJfSopXJWOagnwgxUOzWvKPodwhMIBX2Ca2
        /QAePD/3xIy7IuYjAb0sJ9udDOoknjhcIMokx/rg26UlyDJPqkcrwwKPHCxncW97wkoa7u7WywRpk
        koVXcnfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hbe-00CSMD-0L;
        Wed, 24 May 2023 06:04:18 +0000
Date:   Tue, 23 May 2023 23:04:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH 2/2] ubi: block: Fix deadlock on remove
Message-ID: <ZG2o4rrfqWGbYziq@infradead.org>
References: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
 <20230523-ubiblock-remove-v1-2-240bed75849b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-ubiblock-remove-v1-2-240bed75849b@axis.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you imlement ->free_disk, the list_del and kfree can move into
that, and we don't really care if a new opener raced with the delete.
