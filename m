Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F7718088
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjEaM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjEaM4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:56:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED841BD;
        Wed, 31 May 2023 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vvrMwE8BjC38RZj2WyqFyAbLSvr7o9QLGri8y3hsVWs=; b=LsMvMjodlrdIcQmqStvcRmEg6a
        p73uxa7uiSXgEqFhriiibCgnB2FhMDBVH4F2qp9/qRc6mLk+JyM9MYIWiIlxZ2DHT6qWm5atTLfMa
        OpHvyzf9lvD6g/hEdnuHMYAEmiyKQv+bsfJgYbLtvSXhFxarfCZfT1PX2QA+FFcehUhxw0W+GeQVN
        NffZr8VRBrS0QaOyFJ5XBR/nAoMFXL4+YlFyQJFt994UVHC1i9Y0g0P9eAmgLbTpU3RmOQq2Ym4T7
        wdFYC75VgJy0nGYxtTNHpqZ8CPmOZWDdNL1ZsMTtTGI7eHwh40D1mxHOHRxxzeUxn8pqODLBK0yHT
        1GqWLJxw==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LMZ-00HQu7-1g;
        Wed, 31 May 2023 12:55:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: fix the name_to_dev_t mess v2
Date:   Wed, 31 May 2023 14:55:11 +0200
Message-Id: <20230531125535.676098-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series tries to sort out accumulated mess around the name_to_dev_t
function.  This function is intended to allow looking up the dev_t of a
block device based on a name string before the root file systems is
mounted and thus the normal path based lookup is available.

Unfortunately a few years ago it managed to get exported and used in
non-init contexts, leading to the something looking like a path name
also beeing lookuped up by a different and potential dangerous
algorithm.

This series does a fair amount of refactoring and finally ends up with
the renamed and improved name_to_dev_t only beeing available for the
early init code again.

The series is against Jens' for-6.5/block tree but probably applies
against current mainline just fine as well.

A git tree is also available here:

    git://git.infradead.org/users/hch/block.git blk-init-cleanup

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-init-cleanup

Changes since v1:
 - really propagate the actual error in dm_get_device
 - improve the documentation in kernel-parameters.txt
 - spelling fixes

Diffstat:
