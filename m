Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC01570ECCA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbjEXFAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjEXFAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:00:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267718C;
        Tue, 23 May 2023 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=edfaHMR4YECUnGbotyyMF5SacmYMp3ZU5F4DQmNY/7s=; b=uOXqxTrJImRqsmHMilxK6MCQEv
        KI3v8/yqFEgl4ulo+p+bdyVTA3kY0O1FXw40ENov2CvbludFu26kje+1Ml+5uQI2CCpeyoGnTrthO
        cVzWJvRbrDa7dZ81etpc9bjOaqGhAGjRE5cHe3eMbqsfknhSjkPPf+BCmpmNkkVncRYLDrgykPe4V
        y867kdNdppijjZlgV9pJx1R61tAcVtonnEXY3FkV6iN+M98KQ+mXt8hNg/R9fA7qdRxMhBLbRGldL
        twTRvHoXRNjTxnrEApCmu1Vqt7XVb3qC7n01O87thLWmrjewHv3AdxLvpwEH21KZEYFvvmPvYAkgb
        5DaICZJQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1gbH-00CMaO-18;
        Wed, 24 May 2023 04:59:51 +0000
Message-ID: <e96e4e85-7371-2859-b9a5-0f2c1f3b97d9@infradead.org>
Date:   Tue, 23 May 2023 21:59:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/24] block: move the code to do early boot lookup of
 block devices to block/
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-16-hch@lst.de>
 <b384f464-92c6-6a14-4072-1faa9fa6a6a8@infradead.org>
In-Reply-To: <b384f464-92c6-6a14-4072-1faa9fa6a6a8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 21:58, Randy Dunlap wrote:
> 
> 
> On 5/23/23 00:45, Christoph Hellwig wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f08b83e62c6222..3f8cf6dc7de887 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5452,7 +5452,7 @@
>>  			port and the regular usb controller gets disabled.
>>  
>>  	root=		[KNL] Root filesystem
>> -			See early_lookup_bdev comment in init/do_mounts.c.
>> +			See early_lookup_bdev comment in block/early-lookup.c
> 
> Patch 13 does this:
> 
>  	root=		[KNL] Root filesystem
> -			See name_to_dev_t comment in init/do_mounts.c.
> +			See early_lookup_bdev comment in init/do_mounts.c.
> 
> Should this latter chunk be dropped?
> 

Oh, oops, reverse order of patches?

-- 
~Randy
