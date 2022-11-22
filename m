Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58800633C65
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiKVMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiKVMYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:24:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3B429B6;
        Tue, 22 Nov 2022 04:24:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1A2768D05; Tue, 22 Nov 2022 13:24:46 +0100 (CET)
Date:   Tue, 22 Nov 2022 13:24:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] elevator: restore old io scheduler on failure
 in elevator_switch
Message-ID: <20221122122446.GA5068@lst.de>
References: <cover.1668772991.git.nickyc975@zju.edu.cn> <20221121071305.GB23882@lst.de> <6d74b4a9.5489.1849f42de2d.Coremail.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d74b4a9.5489.1849f42de2d.Coremail.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:14:30PM +0800, Jinlong Chen wrote:
> Mostly failures specific to the intended io scheduler, like consuming more
> resources than the old one that the system can not afford. But sure it's
> rare, so do you think I should just correct the outdated document?

I'd be tempted to just documented the behavior, because I think the
chances are high that if switching to one schedule will fail that
switching back to the old one will fail as well.  I've done a quick
audit of all three schedulers, and unless I missed something there
are no other failure cases except for running out of memory.

Maybe a printk to document that switching the scheduler failed are
we aren't using any scheduler now might be useful, though.
