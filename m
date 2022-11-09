Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D41622263
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiKIDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:03:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ECD63F3;
        Tue,  8 Nov 2022 19:03:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F92F2253D;
        Wed,  9 Nov 2022 03:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667963008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AahacXl0LjGDU+aPu6eWT1p/Z9IsaDvNUBLIggy5mHc=;
        b=vxxmenHxiStbw6bwNmZooecHGNPIe+eqivgrtUljFwjugBM1M3JdIMSN2iH1ZaTdyNdorG
        kusHYyv2VggMJrh/c3HhKlDkMCYQzZ7iA9HDc79rKygXlDC5hWIEVcRJVkai0hq01OuYAz
        YBCAupMXupkhvBx3eD6pkyfLOTFiiZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667963008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AahacXl0LjGDU+aPu6eWT1p/Z9IsaDvNUBLIggy5mHc=;
        b=4MeANHdTJWCU4yHpP7WKKKlJIFn64mRG7m8cx9WUpKCBQd2ISUpoIIQ7NlCAKRwSgEVpLg
        adF0zq5TP3rFSkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07E871376E;
        Wed,  9 Nov 2022 03:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JxTlN38Ya2OWNAAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 09 Nov 2022 03:03:27 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Organization: SUSE
References: <20221105231055.25953-1-krisman@suse.de>
        <f2d6dfd6-1234-2545-7955-07db078faa54@nvidia.com>
Date:   Tue, 08 Nov 2022 22:03:26 -0500
In-Reply-To: <f2d6dfd6-1234-2545-7955-07db078faa54@nvidia.com> (Chaitanya
        Kulkarni's message of "Tue, 8 Nov 2022 23:28:11 +0000")
Message-ID: <871qqcg77l.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chaitanya Kulkarni <chaitanyak@nvidia.com> writes:

>> For more interesting cases, where there is queueing, we need to take
>> into account the cross-communication of the atomic operations.  I've
>> been benchmarking by running parallel fio jobs against a single hctx
>> nullb in different hardware queue depth scenarios, and verifying both
>> IOPS and queueing.
>> 
>> Each experiment was repeated 5 times on a 20-CPU box, with 20 parallel
>> jobs. fio was issuing fixed-size randwrites with qd=64 against nullb,
>> varying only the hardware queue length per test.
>> 
>> queue size 2                 4                 8                 16                 32                 64
>> 6.1-rc2    1681.1K (1.6K)    2633.0K (12.7K)   6940.8K (16.3K)   8172.3K (617.5K)   8391.7K (367.1K)   8606.1K (351.2K)
>> patched    1721.8K (15.1K)   3016.7K (3.8K)    7543.0K (89.4K)   8132.5K (303.4K)   8324.2K (230.6K)   8401.8K (284.7K)
>
>> 

Hi Chaitanya,

Thanks for the feedback.

> So if I understand correctly
> QD 2,4,8 shows clear performance benefit from this patch whereas
> QD 16, 32, 64 shows drop in performance it that correct ?
>
> If my observation is correct then applications with high QD will
> observe drop in the performance ?

To be honest, I'm not sure.  Given the overlap of the standard variation
(in parenthesis) with the mean, I'm not sure the observed drop is
statistically significant. In my prior analysis, I thought it wasn't.

I don't see where a significant difference would come from, to be honest,
because the higher the QD, the more likely it is  to go through the
not-contended path, where sbq->ws_active == 0.  This hot path is
identical to the existing implementation.

> Also, please share a table with block size/IOPS/BW/CPU (system/user)
> /LAT/SLAT with % increase/decrease and document the raw numbers at the
> end of the cover-letter for completeness along with fio job to others
> can repeat the experiment...

This was issued against the nullb and the IO size is fixed, matching the
device's block size (512b), which is why I am not tracking BW, only
IOPS.  I'm not sure the BW is still relevant in this scenario.

I'll definitely follow up with CPU time and latencies, and share the
fio job.  I'll also take another look on the significance of the
measured values for high QD.

Thank you,

-- 
Gabriel Krisman Bertazi
