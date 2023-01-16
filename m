Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99066BEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAPNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjAPNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:04:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2D1710;
        Mon, 16 Jan 2023 05:03:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5140267838;
        Mon, 16 Jan 2023 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673874222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HTDNZq8o98W3LfkLNWznZ2gGr+LyFivo+02SGi1JGM=;
        b=f1gWOTxZd+01daI39fPUkEdnRvZAub6QxTYFSFYxqKaw7IBjylrVUfemyo3rWCZW/j63A0
        TPG841KJc19d/I2Qb4l6c/lDOmiGG2LImqzp3ori3LjkLvGF5OEvDIkpPYLVEPd6R7glKG
        PGrnDcjA7S+F0718tsiCy6DCYqg5JV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673874222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HTDNZq8o98W3LfkLNWznZ2gGr+LyFivo+02SGi1JGM=;
        b=Z9ekvVCmLtCFGeX1DBAAHlfiA0paaJhPjQlGPceNFjLzFTAEHnVai4GReoacXLmJLUKWh7
        rPc4WbuPBPzNvVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41F15138FA;
        Mon, 16 Jan 2023 13:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W9EREC5LxWN4MAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 13:03:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C2546A06AD; Mon, 16 Jan 2023 14:03:41 +0100 (CET)
Date:   Mon, 16 Jan 2023 14:03:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, arie.vanderhoeven@seagate.com,
        rory.c.chen@seagate.com, glen.valante@linaro.org,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH V13 REBASED 0/8] block, bfq: extend bfq to support
 multi-actuator drives
Message-ID: <20230116130341.lci7hixndnxvjuhz@quack3>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo!

On Tue 03-01-23 15:54:55, Paolo Valente wrote:
> Here is the whole description of this patch series again.  This
> extension addresses the following issue. Single-LUN multi-actuator
> SCSI drives, as well as all multi-actuator SATA drives appear as a
> single device to the I/O subsystem [1].  Yet they address commands to
> different actuators internally, as a function of Logical Block
> Addressing (LBAs). A given sector is reachable by only one of the
> actuators. For example, Seagate’s Serial Advanced Technology
> Attachment (SATA) version contains two actuators and maps the lower
> half of the SATA LBA space to the lower actuator and the upper half to
> the upper actuator.
> 
> Evidently, to fully utilize actuators, no actuator must be left idle
> or underutilized while there is pending I/O for it. To reach this
> goal, the block layer must somehow control the load of each actuator
> individually. This series enriches BFQ with such a per-actuator
> control, as a first step. Then it also adds a simple mechanism for
> guaranteeing that actuators with pending I/O are never left idle.
> 
> See [1] for a more detailed overview of the problem and of the
> solutions implemented in this patch series. There you will also find
> some preliminary performance results.

Sorry, I didn't find time to look into this earlier. I've just had a
high-level look into the patches and I have one question: Did you consider
a solution where you'd basically duplicate all of the scheduling for each
actuator (thus making them effectively independent devices from the point
of view of BFQ)? From the first look it would look like somewhat simpler
solution than splitting all the BFQ queues and implementing special
injection mechanism for other actuators and perhaps lead to better
utilization of the actuators. OTOH the latecy and QoS for tasks using
multiple actuators would be probably worse because it would be basically
determined by the busiest of the actuators. So I'm asking mostly out of
curiosity :)

								Honza
 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
