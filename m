Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE50563BBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiK2InS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiK2InO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:43:14 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021320351
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:43:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6238D68AFE; Tue, 29 Nov 2022 09:43:10 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:43:10 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Rao, Lei" <lei.rao@intel.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Message-ID: <20221129084310.GB25609@lst.de>
References: <20221129014711.91305-1-lei.rao@intel.com> <15de4902-03e7-0d2c-4b4c-45d713d0f1fd@nvidia.com> <4cee0097-4f08-1990-112f-6e39229f59ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cee0097-4f08-1990-112f-6e39229f59ef@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:50:57PM +0800, Rao, Lei wrote:
> stricter checks, and if prp2 is not used but has a value, some warnings will be
> printed. According to the NVMe spec, it seems to write a reserved field produces
> an undefined result, so maybe clearing it is better.

NVMe is a little weird about reserved fields settable by the host.
I don't think your controllers warnings are correct, but given that
the cost of clearing is very low I think we should clear it in Linux.
Please resend a patch with the clearing in the right place as suggested
in my previous mail.
