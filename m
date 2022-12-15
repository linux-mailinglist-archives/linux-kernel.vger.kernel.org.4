Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2064D705
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiLOHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLOHKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:10:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41872982B;
        Wed, 14 Dec 2022 23:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pJM1bQVht4KEa8PGX0/1qnwZOWHWJSoGpR3/A3VryPg=; b=ESzkO2WQa0U25HA1PWM7bSYurV
        JCKPgXrwTOSW0/xC8moOmFvPhN4mKddp4eQN70NaNYjham+ZD6sk0BHTAok4nzqj0Nfu8Rs5QgVQH
        0XubeyMZdOHnf25Ypo3qHcZe5+xgUHpOzFcRLDXePFVRV6cMyXSt/D6eP52tZfYM6FE0GIUJJkKcw
        4JaJvicTcx7a7BpmQArlsYGv/3ovVUzXW1/1+I/TkBWeLfgMdM2KrLP1gcJNuguREdBmA93E/vtwY
        EvUeHkx7jBSkAQllxQWPBZURqEwfSuKpWVOIeNXOlI91MNKPG1TQ4tAmym9uxnKbxR70aRwEhVzJj
        9dqvdn2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5iJj-00742L-1i; Thu, 15 Dec 2022 07:06:07 +0000
Date:   Wed, 14 Dec 2022 23:06:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH 0/2] scsi:donot skip lun if inquiry returns PQ=1 for all
 hosts
Message-ID: <Y5rHX95Vvl1aLhbp@infradead.org>
References: <20221214070846.1808300-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214070846.1808300-1-haowenchao@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:08:44PM +0800, Wenchao Hao wrote:
> When iSCSI initiator logged in target, the target attached none valid
> lun but lun0. lun0 is not an valid disk, while it would response
> inquiry command with PQ=1 and other general scsi commands like probe lun.
> The others luns of target is added/removed dynamicly.

I can't find any special casing of LUN0 in RFC7144, can you clarify
where you think that treats LUN0 any differently than other transports?
