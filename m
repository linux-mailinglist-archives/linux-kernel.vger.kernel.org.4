Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05074065B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjF0WFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF0WFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:05:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84E0212A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:05:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26307d808a4so1479011a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687903509; x=1690495509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DYHe4bnJRWcnzs0u1zgwhRUtJrGQi+1XUL5Mm+Ohjs=;
        b=yMUwX+WrY5rt4zP0GksI635sC1Rp7YPOaGDvrzF3kYAXfvZhc0pBaStaiggmfgaMI2
         uXHp5zmSiWZTeFXmec3EeLVLmX2Z3h7r2f8QlfT1pScDsv/oqbrB5Ld5dVQE138qdnMt
         D0A9DQldSDNHP/92kOy7zkW29wihZorlu7uHsSqekq+A5O8GhYnfdq9yfbggInm8HGYN
         pZDakz2K6IOYmmGOYjWISRAcEz6l1BI1yUXP9FcsoXj23q1vNUDkn1GouE9y3J1eJI3+
         HSoen8uLEJ0DRWnfBp3+EBRV5/34Op2K5xWZu91IHqx9LUm1pVhJ3513uW+8lUg7ZTrx
         Pk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687903509; x=1690495509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DYHe4bnJRWcnzs0u1zgwhRUtJrGQi+1XUL5Mm+Ohjs=;
        b=jiwv8h8218CSyykLfTcIjCihTLjcgp2k2071FzT5D9OKPWym3ux5+z/Yj1P7lsFZx7
         3nUcAYG8wPcjQQSt7RTL4cIKa8X7mKpl3QbjqKemU1aoEt136FUHqbBAGVfwfc0nt2fg
         bZJZx7H7cqXPEOH36E8XV9rULVngyg63SIo5E7QLL/usbMMcWbP8Agywi64HdIFbwtW4
         xQpxL/QsBTGXj8Ukw3aMyvL3d2ez0wXiCzL2Cnd+NlBA0jb6f/r3tnumMbggQvd2cfJn
         oTX1Hqzs7L5yHebZmBA0/tr8Aoscpno3dFJLGpESO6Az0BRK/9NyxVtdfSBx3SwmXWLa
         IoOg==
X-Gm-Message-State: AC+VfDxZqvMs8pz8/B2Jgas487wWSOgb7E7sqQFR3sPPU+1sUlHPtxND
        J7+iv+wJusceSEfxIBQrsOa6iw==
X-Google-Smtp-Source: ACHHUZ51GdeT0rkklPTvRnFBvywqgG6ZZCt1e8bXjVFeoZTq0FBzGiBdbxrdCOG9WAlsKh01EySO3Q==
X-Received: by 2002:a17:90a:19c9:b0:255:d86c:baec with SMTP id 9-20020a17090a19c900b00255d86cbaecmr33128882pjj.46.1687903509282;
        Tue, 27 Jun 2023 15:05:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090a064f00b002533ce5b261sm8935406pje.10.2023.06.27.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 15:05:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEGo6-00GzGq-0o;
        Wed, 28 Jun 2023 08:05:06 +1000
Date:   Wed, 28 Jun 2023 08:05:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZJtdEgbt+Wa8UHij@dread.disaster.area>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627201524.ool73bps2lre2tsz@moria.home.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:15:24PM -0400, Kent Overstreet wrote:
> On Tue, Jun 27, 2023 at 11:16:01AM -0600, Jens Axboe wrote:
> > On 6/26/23 8:59?PM, Jens Axboe wrote:
> > > On 6/26/23 8:05?PM, Kent Overstreet wrote:
> > >> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> > >>> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
> > >>> either:
> > >>
> > >> It just popped for me on xfs, but it took half an hour or so of looping
> > >> vs. 30 seconds on bcachefs.
> > > 
> > > OK, I'll try and leave it running overnight and see if I can get it to
> > > trigger.
> > 
> > I did manage to reproduce it, and also managed to get bcachefs to run
> > the test. But I had to add:
> > 
> > diff --git a/check b/check
> > index 5f9f1a6bec88..6d74bd4933bd 100755
> > --- a/check
> > +++ b/check
> > @@ -283,7 +283,7 @@ while [ $# -gt 0 ]; do
> >  	case "$1" in
> >  	-\? | -h | --help) usage ;;
> >  
> > -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> > +	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-bcachefs)
> >  		FSTYP="${1:1}"
> >  		;;
> >  	-overlay)
> 
> I wonder if this is due to an upstream fstests change I haven't seen
> yet, I'll have a look.

Run mkfs.bcachefs on the testdir first. fstests tries to probe the
filesystem type to test if $FSTYP is not set. If it doesn't find a
filesystem or it is unsupported, it will use the default (i.e. XFS).
There should be no reason to need to specify the filesystem type for
filesystems that blkid recognises. from common/config:

        # Autodetect fs type based on what's on $TEST_DEV unless it's been set
        # externally
        if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
                FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
        fi
        FSTYP=${FSTYP:=xfs}
        export FSTYP

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
