Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F865527A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiLWPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:55:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E122645B;
        Fri, 23 Dec 2022 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XlaGZY8DMBQJstKTpQhCotmCLDPFAe/nfsCTint1ghw=; b=uRAoWlvtWYebzOjr+Qq8FXA0TQ
        6sclV/2EdQf72+yzq4+niwwyR3zRevgTgY6sLEtNT5dnE8C44JVG99YEMItskygBk8/CfaO1nCfWZ
        swoyhtqvUCwO/GIxDJUBBB3aPXi0FhAZJsubVJnpFKjApr1acqxKOi7kMyVkaPybFkfpL3X59Mj/A
        mUp8P9I3Z2BYj2EvuyKykAlf7K4UyPT54U6/WsJFoBQncm7ZOzvCOAlRq5o40L2u5LiEe5gYhIDrv
        tUoGm8bhp+uA8rHOT9F5Enx9tZ7I57dXqBJtVq4YsJPirwRLgeH3bGmE+G34R5zdWap9X6CQpYEzO
        JS1sYSBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8kNh-009gH5-SN; Fri, 23 Dec 2022 15:54:45 +0000
Date:   Fri, 23 Dec 2022 07:54:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH 0/2] scsi:donot skip lun if inquiry returns PQ=1 for all
 hosts
Message-ID: <Y6XPRfgLSUShN+mY@infradead.org>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <Y5rHX95Vvl1aLhbp@infradead.org>
 <57c12317-c229-8cbe-b3d2-d799ea5f554c@huawei.com>
 <Y5waet8RoXKQHDR7@infradead.org>
 <5129c84b-38e5-8be4-6411-fcc003776d70@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5129c84b-38e5-8be4-6411-fcc003776d70@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 07:41:26PM +0800, Wenchao Hao wrote:
> For nothing, I want the iscsi_tcp transport do not skip PQ=1 default
> as what it did before commit 948e922fc4461 ("scsi: core: map PQ=1,
> PDT=other values to SCSI_SCAN_TARGET_PRESENT").

Well, that commit was very much intentional and is now three an a half
years old, so we've not just going to partially revert it on a
per-transport basis when it is in no way transport related.

If you can come up with a good enough rationale we could do the
sysfs override, but so far the reason mostly seems to be "I want"
and not anctual explanation of why it is useful.
