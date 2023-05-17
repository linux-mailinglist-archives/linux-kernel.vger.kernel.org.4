Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E27707001
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEQRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEQRwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:52:17 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 10:51:55 PDT
Received: from p3plwbeout26-06.prod.phx3.secureserver.net (p3plsmtp26-06-2.prod.phx3.secureserver.net [216.69.139.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992ACD2F0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:55 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id zLGmp1uHj0mOMzLGnpNwyI; Wed, 17 May 2023 10:49:01 -0700
X-CMAE-Analysis: v=2.4 cv=fPD8YbWe c=1 sm=1 tr=0 ts=6465138d
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=3-RhneuVAAAA:8
 a=FXvPX3liAAAA:8 a=IfMCuqTOASDaTjgOz58A:9 a=QEXdDO2ut3YA:10
 a=VLVLkjT_5ZicWzSuYqSo:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zLGmp1uHj0mOM
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.87])
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pzLGl-00032a-NG; Wed, 17 May 2023 18:49:00 +0100
Message-ID: <5a2af52b-f8cc-7118-2d08-44bcba1b8fd4@squashfs.org.uk>
Date:   Wed, 17 May 2023 18:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] squashfs: cache partial compressed blocks
Content-Language: en-GB
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net, kernel@axis.com
References: <20230510-squashfs-cache-v4-1-3bd394e1ee71@axis.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230510-squashfs-cache-v4-1-3bd394e1ee71@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfGpzRkmGje/tWM/aDykcqxyBf07ZPvze2/+rTrdQ5k6OM4NpYy3RtVwEUq8mFpWAEfaZ9Gof11Y6IlxBKyZBI8UTO+wT+Hau4wqd/bi/w8jv6Bf3+LUB
 1AAPwAAElMq8E6nfFI4GJ6QYM3v0njDeFMpKbSyMtqoOLwAchHYZtdoFLXonB+US5VBBMKmP89Cz2U0HiNtUwudIkAKM7oDoJVM=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 15:18, Vincent Whitchurch wrote:
> Before commit 93e72b3c612adcaca1 ("squashfs: migrate from ll_rw_block
> usage to BIO"), compressed blocks read by squashfs were cached in the
> page cache, but that is not the case after that commit.  That has lead
> to squashfs having to re-read a lot of sectors from disk/flash.
>
> For example, the first sectors of every metadata block need to be read
> twice from the disk.  Once partially to read the length, and a
> second time to read the block itself.  Also, in linear reads of large
> files, the last sectors of one data block are re-read from disk when
> reading the next data block, since the compressed blocks are of variable
> sizes and not aligned to device blocks.  This extra I/O results in a
> degrade in read performance of, for example, ~16% in one scenario on my
> ARM platform using squashfs with dm-verity and NAND.
>
> Since the decompressed data is cached in the page cache or squashfs'
> internal metadata and fragment caches, caching _all_ compressed pages
> would lead to a lot of double caching and is undesirable.  But make the
> code cache any disk blocks which were only partially requested, since
> these are the ones likely to include data which is needed by other file
> system blocks.  This restores read performance in my test scenario.
>
> The compressed block caching is only applied when the disk block size is
> equal to the page size, to avoid having to deal with caching sub-page
> reads.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>


