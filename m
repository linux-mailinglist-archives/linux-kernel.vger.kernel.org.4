Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5636E8CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjDTIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjDTIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:24:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A340C6;
        Thu, 20 Apr 2023 01:24:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8DA1218E9;
        Thu, 20 Apr 2023 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681979055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QiP5e/+4S7KnMOT6XDJPynS4EU6xSJzZUOwhN1ceQZ4=;
        b=Ka0LrcOK1yn6kwCoYM3XsQIK3ZxWeM/e5JNhtgI0SFtoekmncvrSclbNcgq/12E5RNfh1B
        tKSbwcPVGtT2/YC5w4McbNVc7dh9FfvwOH8tot50WNK+ZaF895gnFjMRlXXnj5hsiArUo6
        6uoNtinW8lqu1FVp2C/SaiZWbIwF/AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681979055;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QiP5e/+4S7KnMOT6XDJPynS4EU6xSJzZUOwhN1ceQZ4=;
        b=6zrfcF8lR9nuEfShfTTEJY9Eum3YmV16Vcd4njIN65Y9hLrVFotV6yrzuvZesxoabLhKWx
        vYy9P6qmJcw26SBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99D2F1333C;
        Thu, 20 Apr 2023 08:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xKWCJa/2QGSZbAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 08:24:15 +0000
Date:   Thu, 20 Apr 2023 10:24:15 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Message-ID: <qflkb4gu5lz5wx2oka5ceclj7ez5ic5oyofd3tzyjapjyrorlk@e7kkpa6bxwun>
References: <20230419085643.25714-1-dwagner@suse.de>
 <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
 <9a1f1709-baaf-5661-2cbf-c34e2da9e42e@grimberg.me>
 <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27235520-2e63-2891-fd0a-ff758f18032e@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:11:33PM +0000, Chaitanya Kulkarni wrote:
> >> Those jobs are meant to be run for at least 1G to establish
> >> confidence on the data set and the system under test since SSDs
> >> are in TBs nowadays and we don't even get anywhere close to that,
> >> with your suggestion we are going even lower ...
> >
> > Where does the 1G boundary coming from?
> >
>
> I wrote these testcases 3 times, initially they were the part of
> nvme-cli tests7-8 years ago, then nvmftests 7-6 years ago, then they
> moved to blktests.
> 
> In that time some of the testcases would not fail on with small size
> such as less than 512MB especially with verification but they were
> in the errors with 1G Hence I kept to be 1G.
> 
> Now I don't remember why I didn't use bigger size than 1G
> should have documented that somewhere ...

Can you remember why you chosed to set the image size to 1G and the io size for
fio to 950m in nvme/012 and nvme/013?

I am testing various image sizes and found that small images e.g in the range of
[4..64]m are passing fine but larger ones like [512-...]M do not (no space
left). Note I've added a calc function which does image size - 1M to leave some
room left.
