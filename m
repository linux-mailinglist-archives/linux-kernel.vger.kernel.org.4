Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC9563BBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiK2ImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiK2Il6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:41:58 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC27677
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:41:57 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4412468AFE; Tue, 29 Nov 2022 09:41:52 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:41:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lei Rao <lei.rao@intel.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Message-ID: <20221129084151.GA25609@lst.de>
References: <20221129014711.91305-1-lei.rao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221129014711.91305-1-lei.rao@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:47:11AM +0800, Lei Rao wrote:
> If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
> field is garbage data. According to nvme spec, the prp2 is reserved if
> the data transfer does not cross a memory page boundary. Writing a
> reserved coded value into a controller property field produces undefined
> results, so it needs to be cleared in nvme_setup_rw().

But this is not the right place to clear it, that needs to be done
in the place that sets up the PRPs, і.e. nvme_setup_prp_simple.
