Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B366775B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAWHh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjAWHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:37:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E47AA6;
        Sun, 22 Jan 2023 23:37:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9272F1F385;
        Mon, 23 Jan 2023 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674459472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQJX024pkVuVQR0VnwcnTYOudHsfg50IcUdugQxvxvs=;
        b=GOzDfUXYh1i6hahRLr7pZXsrKaZGe9LpzWhPy4jyblpbKPmD9EEhgL16eXL8drL0drmV5V
        5opCih7ve1E3yQfQvq77XWulZYWFRxnmZ7+0YbupxC6xx2Iyz5VawObs39/glhYyGt28xj
        upV9Kf418742oxeQDmJKI8e7+qWYqcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674459472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQJX024pkVuVQR0VnwcnTYOudHsfg50IcUdugQxvxvs=;
        b=cCD1dV91Lf1UY0GoF9uDGEyYR2QxkSQwtNEdMi0kB9NJ9xsmo5NqXkcETdmBA6bS4XiFem
        jPUDhWgigsqKORCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60846134F5;
        Mon, 23 Jan 2023 07:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 55TbFlA5zmMSOgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 23 Jan 2023 07:37:52 +0000
Message-ID: <cd7625e4-c246-c1dc-e607-64e7b7d93434@suse.de>
Date:   Mon, 23 Jan 2023 08:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
 <20230122075710.GA4046@lst.de>
 <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 19:24, Jens Axboe wrote:
> On 1/22/23 12:57 AM, Christoph Hellwig wrote:
>> I suspect a comment in the Kconfig for the old PARIDE code to point
>> to this and maybe even a runtime warning when using the old paride
>> code would be great.
>>
>> But except for that the code looks awesome, so let's get it merged ASAP:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Since Ondrej is probably one of the few (maybe the only) user of this
> code, why don't we just kill off the paride code in a separate patch
> right after?
> 
Go for it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

