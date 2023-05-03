Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2956F5BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjECQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjECQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:07:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99D5598
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:07:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D258068AA6; Wed,  3 May 2023 18:07:52 +0200 (CEST)
Date:   Wed, 3 May 2023 18:07:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     jiweisun126@126.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        ahuang12@lenovo.com, sunjw10@lenovo.com
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <20230503160752.GA683@lst.de>
References: <20230502125412.65633-1-jiweisun126@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502125412.65633-1-jiweisun126@126.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 08:54:12PM +0800, jiweisun126@126.com wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> A soft lockup issue will be triggered when do fio test on a 448-core
> server, such as the following warning:

nvme_complete_batch can be called from irq context, so I don't think
a cond_resched is a good idea here.

