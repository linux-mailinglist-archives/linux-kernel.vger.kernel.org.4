Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8A671AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjARLbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjARLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:31:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF905DC27;
        Wed, 18 Jan 2023 02:51:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E49AD204B1;
        Wed, 18 Jan 2023 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674039083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/9erNZdmzZn06cCNOJDly4yn3eTixjSiK6j9e1hIz0=;
        b=ZZ64m24AmxiunAMNKMk1YSLi61k72uBpxt6gftuoB5sdtukVtpzIqukV0XZxBrgxeKTNvS
        lB4zfOvU0DjBhcR7HKtIwT/T8E/Oyw0zhYgInbqGnuldi6aQz/k1bObogoBRz4M3i66nu3
        er5WssaIJAuOa3N9RKkhl3lhez4wEy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674039083;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/9erNZdmzZn06cCNOJDly4yn3eTixjSiK6j9e1hIz0=;
        b=euhQysow3RJUvUioeSoWe8nop2Xt3mGFRF00fzmNQSKGQwfW2NjvSrMRBh7v7BgzODktN2
        xcXeD7DNWd86G5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4244138FE;
        Wed, 18 Jan 2023 10:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1SRxMyvPx2ObZAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 18 Jan 2023 10:51:23 +0000
Message-ID: <ce97ebc9-f8c1-cd1e-f364-60866cfb092a@suse.de>
Date:   Wed, 18 Jan 2023 11:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 00/21] blksnap - block devices snapshots module
To:     Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <Y8cNVv4O+vjL+aAy@redhat.com>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <Y8cNVv4O+vjL+aAy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 22:04, Mike Snitzer wrote:
> On Fri, Dec 09 2022 at  9:23P -0500,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> 
>> Hi Jens. Hi Jonathan. Hi all.
>>
>> I am happy to offer a modified version of the Block Devices Snapshots
>> Module. It allows to create non-persistent snapshots of any block devices.
>> The main purpose of such snapshots is to provide backups of block devices.
>> See more in Documentation/block/blksnap.rst.
>>
>> The Block Device Filtering Mechanism is added to the block layer. This
>> allows to attach and detach block device filters to the block layer.
>> Filters allow to extend the functionality of the block layer.
>> See more in Documentation/block/blkfilter.rst.
>>
>> A tool, a library for working with blksnap and tests can be found at
>> www.github.com/veeam/blksnap.
>>
>> The first version was suggested at 13 June 2022. Many thanks to
>> Christoph Hellwig and Randy Dunlap for the review of that version.
>>
>> Changes:
>> - Forgotten "static" declarations have been added.
>> - The text of the comments has been corrected.
>> - It is possible to connect only one filter, since there are no others in
>>    upstream.
>> - Do not have additional locks for attach/detach filter.
>> - blksnap.h moved to include/uapi/.
>> - #pragma once and commented code removed.
>> - uuid_t removed from user API.
>> - Removed default values for module parameters from the configuration file.
>> - The debugging code for tracking memory leaks has been removed.
>> - Simplified Makefile.
>> - Optimized work with large memory buffers, CBT tables are now in virtual
>>    memory.
>> - The allocation code of minor numbers has been optimized.
>> - The implementation of the snapshot image block device has been
>>    simplified, now it is a bio-based block device.
>> - Removed initialization of global variables with null values.
>> - Only one bio is used to copy one chunk.
>> - Checked on ppc64le.
>>
>> The v1 version was suggested at 2 November 2022. Many thanks to Fabio
>> Fantoni for his for his participation in the "blksnap" project on github
>> and Jonathan Corbet for his article https://lwn.net/Articles/914031/.
>> Thanks to the impartial kernel test robot.
>>
>> Changes:
>> - Added documentation for Block Device Filtering Mechanism.
>> - Added documentation for Block Devices Snapshots Module (blksnap).
>> - The MAINTAINERS file has been updated.
>> - Optimized queue code for snapshot images.
>> - Fixed comments, log messages and code for better readability.
> 
> [this reply got long...]
> 
[ .. ]
> 
> But you've already bypassed me, my hope is that Jens and Christoph
> agree that we need this line of development to be in service to other
> areas of the Linux block subsystem and its drivers that were
> established for the purposes of remapping IO.  It cannot just be
> the subset needed to cement veeam's ability to use Linux for its
> purposes (but I completely understand that is the point of veeam's
> exercise).
> 
That's why I proposed my topic at LSF/MM, precisely to figure out how to 
handle these issues.

Cheers,

Hannes
