Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E176FE31E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjEJRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbjEJROt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:14:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E397F4203;
        Wed, 10 May 2023 10:14:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5A581F747;
        Wed, 10 May 2023 17:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683738864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2RPcnuD/B5/jpEGRvPjSZU9zdchad+gheYdPhvKsik=;
        b=CDhVusS9912eGykAiQg6jDXMItwGdq4OE7PYs9GVcisKsjLU9Ik0z5HcqXvw98UMJmZNUh
        RhZ+NcOiLFCSKWbpVFHP1Zwad+oTKc0Oh4kGJY1gEjR5EYnBLS7bsllaSZQ0sF5Z4BKS8v
        dLXHCyJthyPPYg7i+ssI+LGL80Z109E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683738864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2RPcnuD/B5/jpEGRvPjSZU9zdchad+gheYdPhvKsik=;
        b=+MV2TCiVhwrQVmQhz0kE4dKRD3/8Sq2ueROZPM78U8lF9yXdmTnCmGdTfBimjYWSFH/H82
        ckOAlFD5+0bsLJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37BE413519;
        Wed, 10 May 2023 17:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGEpOe/QW2SZCAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 10 May 2023 17:14:23 +0000
Date:   Wed, 10 May 2023 19:14:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 10/12] nvme/rc: Calculate IO size for random
 fio jobs
Message-ID: <vlq7hqrweo527daqh7m5iidcvlhujxsc3hwmeqm2oen4dbucsa@3yo2lm3d6aap>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-11-dwagner@suse.de>
 <xqdnjtl5m6idy7kecwpc6nho74twnvcslkvxnyto6aflz54y5p@6rqao2i3ro2r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xqdnjtl5m6idy7kecwpc6nho74twnvcslkvxnyto6aflz54y5p@6rqao2i3ro2r>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 11:31:10PM +0000, Shinichiro Kawasaki wrote:
 > -	_xfs_run_fio_verify_io /dev/"${nvmedev}n1" "1m" || echo FAIL
> > +	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
> > +	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
> 
> Here, _xfs_run_fio_verify_io is replaced with _run_fio_rand_io. May I confirm
> that this replacement does not affect this test case? Same question for the hunk
> below.

This is on purpose. The test just wants only verify that IO is still working.
Because _xfs_run_fio_verify_io has the minimum requirement of 350M for
nvme_img_size. When I wrote the test I didn't know this and thus this change.

I'll update the commit message to include this info.
