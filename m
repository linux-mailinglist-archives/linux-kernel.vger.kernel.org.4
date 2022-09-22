Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEB5E5B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIVF6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiIVF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:58:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74DDB4428
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:58:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 593C568AFE; Thu, 22 Sep 2022 07:58:15 +0200 (CEST)
Date:   Thu, 22 Sep 2022 07:58:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Rishabh Bhatnagar <risbhat@amazon.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, axboe@fb.com, kbusch@kernel.org, mbacco@amazon.com
Subject: Re: [PATCH] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Message-ID: <20220922055815.GA27619@lst.de>
References: <20220920191932.22797-1-risbhat@amazon.com> <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:10:58AM +0300, Sagi Grimberg wrote:
>
>> If swiotlb is force enabled dma_max_mapping_size ends up calling
>> swiotlb_max_mapping_size which takes into account the min align
>> mask for the device.
>> Set the min align mask for nvme driver before calling
>> dma_max_mapping_size while calculating max hw sectors.
>
> Does this fix a specific bug? if so it needs a fixes tag so it can
> go to stable backports as well.

Hmm.  Basically this is another fixlet for nvme on swiotlb, which
already drove adding the max_mapping size and the align_mask, and
it seems we still hadn't covered all corner cases properly.  So
I think it basically has been broken since day 1, but nvme on
swiotlb only started becoming "interesting" with the trusted
hypervisor schemes.
