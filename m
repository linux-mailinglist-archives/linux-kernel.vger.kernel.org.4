Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F486219CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiKHQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKHQvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:51:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487157B5A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:51:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC87616A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4CCC433C1;
        Tue,  8 Nov 2022 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667926294;
        bh=APtEjyH5Uack2UlY2blKatc3e2SEGTBkQlXBZhgLgdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFNRGEXktsRgRKW7p+I5y/E+TxHHTTEaKtritc0XZpTq/Rcs4PdFb1zX//7H84Ey+
         Tf6cKTBr5oC3eL2uhuTwCYdzJ1XfwupQGDo7iC9BlKVesekdBK+XhkfAuA39x3Ozzu
         Rj4qHwkuEFqZ0ifDHb/T9wjKqJxV2BM3zayHDnurCqP4O9dKxnyOKf5hPy3kTWUnC1
         JUDNE9ywMENTyiz6FkI220QNWrU317LO0lggox4F0eTK2IeplRGcb55tkQn3/zY8FG
         ZhSaNB6kFkEUFgR6OiL/BO48vvp5tLekmSlGivNFx9Hov2/MRovRloVCnP1Ty5V+7j
         GQ2B5yhTMkEVQ==
Date:   Tue, 8 Nov 2022 09:51:31 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com
Subject: Re: nvme: hung task in blk_mq_freeze_queue_wait
Message-ID: <Y2qJE2Bpbvnf5Ejb@kbusch-mbp>
References: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:56:02PM -0800, Francesco Ruggeri wrote:
> [ 4390.119745] INFO: task kworker/u80:2:8279 blocked for more than 300 seconds.
> [ 4390.471456]       Tainted: P           O      4.19.142.Ar-29007847.buytenhb7335070 #1

That is an old kernel, I think it'd be worth trying something newer to
confirm if this observation isn't already fixed. Specifically, it looks
like you have multiple namespaces timing out IO near simultaneously, and
causing a mismatched handling. That kind of thing was fixed after the
follow (plus some prior dependencies): 

  commit d6135c3a1ec0cddda7b8b8e1b5b4abeeafd98289
  Author: Keith Busch <kbusch@kernel.org>
  Date:   Tue May 14 14:46:09 2019 -0600
  
      nvme-pci: Sync queues on reset
