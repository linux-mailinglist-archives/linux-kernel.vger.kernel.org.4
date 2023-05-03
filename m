Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F36F56C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjECLCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjECLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:01:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97D4EEC;
        Wed,  3 May 2023 04:01:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 57D2E2026F;
        Wed,  3 May 2023 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683111685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=giRbGlJ7BtkMEI2nBL5riFwP8VXDM1hYxyICWNGQcyM=;
        b=SC5qFogIbsLugdAIrv4hGxyeN3T2YqLS9zASugfAgtpyJ01F/oTNgVLMtcpsHotcQVyxk5
        x9l95/yUuejIdovQRC0wLRjr1kxdiUE/VGbq8N2wE9xXP0bv1TZSdpg8yS9NfJDyFZ1fIQ
        ZT4+dRTJx8AJF0FUADr9BaIJp3z1AH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683111685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=giRbGlJ7BtkMEI2nBL5riFwP8VXDM1hYxyICWNGQcyM=;
        b=joH9aa7l4k8xl5k6sZVzBoaCUNoVdvP2ciAkdZMazpiVVakMp+sWyzJ5HW6JTH3kfEu/Sx
        W3OuEb/Qft3nOpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4703B13584;
        Wed,  3 May 2023 11:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d3ouEQU/UmRCSgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 11:01:25 +0000
Date:   Wed, 3 May 2023 13:01:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Message-ID: <2ercejt6r2qjkbpaoueh66nred4ooqb5wskx5m3xn2slb5kasw@zwssje3pm4mu>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-10-dwagner@suse.de>
 <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:41:37AM +0000, Chaitanya Kulkarni wrote:
> On 5/3/23 01:02, Daniel Wagner wrote:
> > Limit the number of random threads to 32 for big machines. This still
> > gives enough randomness but limits the resource usage.
> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> 
> I don't think we should change this, the point of all the tests is
> to not limit the resources but use threads at least equal to
> $(nproc), see recent patches from lenovo they have 448 cores,
> limiting 32 is < 10% CPUs and that is really small number for
> a large machine if we decide to run tests on that machine ...

I just wonder how handle the limits for the job size. Hannes asked to limit it
to 32 CPUs so that the job size doesn't get small, e.g. nvme_img_size=16M job
size per job with 448 CPUs is roughly 36kB. Is this good, bad or does it even
make sense? I don't know.

My question is what should the policy be? Should we reject configuration which
try to run too small jobs sizes? Reject anything below 1M for example? Or is
there a metric which we could as base for a limit calculation (disk geometry)?
