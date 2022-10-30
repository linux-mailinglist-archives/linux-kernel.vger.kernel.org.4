Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95925612B35
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJ3Pat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Paq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:30:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0360D0;
        Sun, 30 Oct 2022 08:30:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15A1C68AA6; Sun, 30 Oct 2022 16:30:41 +0100 (CET)
Date:   Sun, 30 Oct 2022 16:30:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -nect RFC v2 0/2] block: fix uaf in
 bd_link_disk_holder()
Message-ID: <20221030153040.GB9676@lst.de>
References: <20221020132049.3947415-1-yukuai3@huawei.com> <20221020164712.GA14773@lst.de> <0ad09045-1012-e86b-41f2-a88d02e8f1ed@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ad09045-1012-e86b-41f2-a88d02e8f1ed@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:15:34AM +0800, Yu Kuai wrote:
> Hi,
>
> 在 2022/10/21 0:47, Christoph Hellwig 写道:
>> As mentioned before I don't think we should make this even more
>> crufty in the block layer.  See the series I just sent to move it int
>> dm.
>
> It seems we had some misunderstanding, the problem I tried to fix here
> should not just related to dm, but all the caller of
> bd_link_disk_holder().

As far as I can tell the problem was just that patch 1 in my series blows
away the bd_holder_dir pointer in part0 on del_gendisk.  Each holder
actually holds a reference to the kobject, so the memory for it is
still valid, it's just that the pointer got cleared.  I'll send a v2
in a bit.
