Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE99740B89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjF1IcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjF1I1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:27:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA043AB8;
        Wed, 28 Jun 2023 01:20:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D4BE1F889;
        Wed, 28 Jun 2023 05:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687931540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sI2fzc8FIgVRp6/0G7OEBOQsc7dDWyTTvRQA68GkrJE=;
        b=k+161G7z8ioudxMwi+XLxMLHq1hwIXR9LVsqtLWJEi98nGOtwRbBAjOGkMOJGCAApQvrHq
        /oePJqE83iHoP0n6hyLQg+owuRj3WfmOA3bj/qDNokZfewoQqWygF3pPxU2dPpzGdbXRiW
        B4KsS1TD10fnSjFpe4NBFEbJSwENhy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687931540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sI2fzc8FIgVRp6/0G7OEBOQsc7dDWyTTvRQA68GkrJE=;
        b=F5z1fUKdECyVhDAIDynzs/DRaJMTBnYpB0wU0CfQbWaEW7ncFZ7+skXJ1EtH6nVcG43fis
        byvA1LRkfTx7cZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B86113483;
        Wed, 28 Jun 2023 05:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /eLfHZTKm2S/CgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 05:52:20 +0000
Date:   Wed, 28 Jun 2023 07:52:19 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Message-ID: <bfkbjiznom3lddrec4skyi7245dff5sohpvitzv6fkaaln6w7t@bery27x4o7qd>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <6he5owg5e6h4vq5uwhw7jo3cncwrrlgjdxnq6csr5wlopbwk5c@l434fr2edukp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6he5owg5e6h4vq5uwhw7jo3cncwrrlgjdxnq6csr5wlopbwk5c@l434fr2edukp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:13:48AM +0000, Shinichiro Kawasaki wrote:
> > +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> > +
> > +	queue_count=$((queue_count + 1))
> > +	if grep -q "${queue_count}" "${queue_count_file}"; then
> 
> Does this check work when the number in queue_count_file has more digits than
> queue_count? e.g.) queue_count_file=20, queue_count=2

The idea is that it should be an exact match. Let me figure out if this does
what it is supposed to do.

 > -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> > +	hostid="${def_hostid}"
> > +	hostnqn="${def_hostnqn}"
> 
> I guess it's the better to move this hunk to the 3rd patch. Or we can mention it
> in the commit message of this patch.

Good point, I'll move this to the 3rd patch so this change is in one patch.
