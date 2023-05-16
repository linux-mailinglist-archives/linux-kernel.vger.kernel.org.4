Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB07056F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEPTUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEPTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:20:40 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 12:20:37 PDT
Received: from p3plwbeout18-03.prod.phx3.secureserver.net (p3plsmtp18-03-2.prod.phx3.secureserver.net [173.201.193.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4938A48
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:20:37 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id z0BCpnWAIkHboz0BDpqF5e; Tue, 16 May 2023 12:17:51 -0700
X-CMAE-Analysis: v=2.4 cv=RqEAkAqK c=1 sm=1 tr=0 ts=6463d6df
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=3-RhneuVAAAA:8
 a=FXvPX3liAAAA:8 a=IfMCuqTOASDaTjgOz58A:9 a=QEXdDO2ut3YA:10
 a=VLVLkjT_5ZicWzSuYqSo:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  z0BCpnWAIkHbo
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.87])
        by smtp12.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pz0BC-00069X-P0; Tue, 16 May 2023 20:17:51 +0100
Message-ID: <74ebf1cd-ce00-1aa2-8258-1bd336dc8470@squashfs.org.uk>
Date:   Tue, 16 May 2023 20:17:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] squashfs: cache partial compressed blocks
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net, kernel@axis.com
References: <20230510-squashfs-cache-v3-1-9f56ffd43f03@axis.com>
Content-Language: en-GB
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230510-squashfs-cache-v3-1-9f56ffd43f03@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfEUwdQfatenP11ZzINr6M1WgmS4p0TUxmmj+czk55tvdi7gTstxoQO/M4AtIzSSSKxwDw6xuG577GBuhklCwY6PjWKPLDylJDSFNhIyqMTMAOT+6Zx1l
 YmS697hzzVEm9Py3o+DQSFh+uCkJAlMcAbv4wd0yC5nUmA+STbd/jyYAd3Kgjwc1vnw4NnAqMAbd3NasYG/pQTS1TP7nyrD0sLo=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 09:22, Vincent Whitchurch wrote:
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


