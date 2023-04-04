Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC56D6C8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjDDSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:45:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A44CA;
        Tue,  4 Apr 2023 11:45:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C8D7522A5E;
        Tue,  4 Apr 2023 18:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680633929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2+BLfyX04cXsJfFa52442u6GnlmwYcaW/9sIJfLFl8=;
        b=Q+178Bg1AtacSEswMQlgFo7ZyOWe1oadAxMZc6UEdkwjeaxAIU7/sLEljVYodTJ+ShcteH
        XTIKVCj4pLcroILggsvtNLpWAiUIyYG/pF0dfCI3KdwK9NUDgzplL/hHzG9HOFx9cSm9YZ
        81WUQ0jiaH1Ytr6pWn/yO7AgBTWNqA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680633929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2+BLfyX04cXsJfFa52442u6GnlmwYcaW/9sIJfLFl8=;
        b=H4xcSJyHZ5cW7aZV4/Y+5PsH5cpps07wKQI8TmRHS+ifWe4M+0AeaeBNF/NbyJiLuFAeKh
        nynsB034nIXsV+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90FA81391A;
        Tue,  4 Apr 2023 18:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SVfhIUlwLGRIZAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Apr 2023 18:45:29 +0000
Message-ID: <18625db0-5b3c-000f-2d01-14350701d52c@suse.de>
Date:   Tue, 4 Apr 2023 20:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 02/19] block: introduce ioprio hints
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230404182428.715140-1-nks@flawful.org>
 <20230404182428.715140-3-nks@flawful.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230404182428.715140-3-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 20:24, Niklas Cassel wrote:
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> IO priorities currently only use 6-bits of the 16-bits ioprio value: the
> 3-upper bits are used to define up to 8 priority classes (4 of which are
> valid) and the 3 lower bits of the value are used to define a priority
> level for the real-time and best-effort class.
> 
> The remaining 10-bits between the IO priority class and level are
> unused, and in fact, cannot be used by the user as doing so would
> either result in the value being completely ignored, or in an error
> returned by ioprio_check_cap().
> 
> Use these 10-bits of an ioprio value to allow a user to specify IO
> hints. An IO hint is defined as a 10-bits value, allowing up to 1023
> different hints to be specified, with the value 0 being reserved as the
> "no hint" case. An IO hint can apply to any IO that specifies a valid
> priority class other than NONE, regardless of the IO priority level
> specified.
> 
> To do so, the macros IOPRIO_PRIO_HINT() and IOPRIO_PRIO_VALUE_HINT() are
> introduced in include/uapi/linux/ioprio.h to respectively allow a user
> to get and set a hint in an ioprio value.
> 
> To support the ATA and SCSI command duration limits feature, 7 hints
> are defined: IOPRIO_HINT_DEV_DURATION_LIMIT_1 to
> IOPRIO_HINT_DEV_DURATION_LIMIT_7, allowing a user to specify which
> command duration limit descriptor should be applied to the commands
> serving an IO. Specifying these hints has for now no effect whatsoever
> if the target block devices do not support the command duration limits
> feature. However, in the future, block IO schedulers can be modified to
> optimize IO issuing order based on these hints, even for devices that
> do not support the command duration limits feature.
> 
> Given that the 7 duration limits hints defined have no effect on any
> block layer component, the actual definition of the duration limits
> implied by these hints remains at the device level.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   include/uapi/linux/ioprio.h | 49 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

