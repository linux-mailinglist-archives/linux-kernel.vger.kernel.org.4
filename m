Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595A64B188
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiLMIvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiLMIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:51:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53342192
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:51:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0458D68D06; Tue, 13 Dec 2022 09:50:59 +0100 (CET)
Date:   Tue, 13 Dec 2022 09:50:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        Klaus Jensen <k.jensen@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme-pci: fix doorbell buffer value endianness
Message-ID: <20221213085057.GA3998@lst.de>
References: <20221212150243.41283-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212150243.41283-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 04:02:43PM +0100, Klaus Jensen wrote:
> -		old_value = *dbbuf_db;
> -		*dbbuf_db = value;
> +		old_value = le32_to_cpu(*dbbuf_db);
> +		*dbbuf_db = cpu_to_le32(value);

As the buildbot noticed, this now means dbbuf_dbs needs to be
a __le32, and the endianess annoations will have to wee through
quite a few places.
