Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BF63A250
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiK1Hv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiK1Hv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:51:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F031580E;
        Sun, 27 Nov 2022 23:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DF5BB80AF0;
        Mon, 28 Nov 2022 07:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B70CC433C1;
        Mon, 28 Nov 2022 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669621912;
        bh=Riui/4cfiYYWVT5yX9lAFHFSkrIuz9b2i3KqgnDUjz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peZFYhjnDvffa0LPiVXJE6HRSCKpXj17GK9FUT2SIOKf6RKupBRZ6YxtTwpvPp6fr
         RO2pT/MNnJ2+M1dEgSKqeD/MkMef1xmySNzybrVmZtOv4hL9REmwpItCIf6YBXvDEb
         EdsBbQaLLjGEaR55S3symrh+ZdMQuC1YGOpjhn8E=
Date:   Mon, 28 Nov 2022 08:51:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
Message-ID: <Y4Rok2iAOekw/tSJ@kroah.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-2-casey@schaufler-ca.com>
 <Y38D1s3uQ6zNORei@kroah.com>
 <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
 <CAHC9VhR9h1GF6VGovp1+UB-vt+QNofjmecPwLqE3OviKQHRMcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR9h1GF6VGovp1+UB-vt+QNofjmecPwLqE3OviKQHRMcg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 10:48:53PM -0500, Paul Moore wrote:
> On Fri, Nov 25, 2022 at 11:19 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On 24/11/2022 06:40, Greg KH wrote:
> > > On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
> > >> Create a struct lsm_id to contain identifying information
> > >> about Linux Security Modules (LSMs). At inception this contains
> > >> the name of the module and an identifier associated with the
> > >> security module. Change the security_add_hooks() interface to
> > >> use this structure. Change the individual modules to maintain
> > >> their own struct lsm_id and pass it to security_add_hooks().
> > >>
> > >> The values are for LSM identifiers are defined in a new UAPI
> > >> header file linux/lsm.h. Each existing LSM has been updated to
> > >> include it's LSMID in the lsm_id.
> > >>
> > >> The LSM ID values are sequential, with the oldest module
> > >> LSM_ID_CAPABILITY being the lowest value and the existing modules
> > >> numbered in the order they were included in the main line kernel.
> > >> This is an arbitrary convention for assigning the values, but
> > >> none better presents itself. The value 0 is defined as being invalid.
> > >> The values 1-99 are reserved for any special case uses which may
> > >> arise in the future.
> > >
> > > What would be a "special case" that deserves a lower number?
> >
> > I don't see any meaningful use case for these reserved numbers either.
> > If there are some, let's put them now, otherwise we should start with 1.
> > Is it inspired by an existing UAPI?
> > Reserving 0 as invalid is good though.
> 
> I haven't finished reviewing this latest patchset, but I wanted to
> comment on this quickly while I had a moment in front of a keyboard
> ... I did explain my desire and reasoning for this in a previous
> revision of this patchset and I still believe the
> reserved-for-potential-future-use to be a valid reason so I'm going to
> ask for this to remain.

Then that reasoning and explaination needs to be here in the changelog
so that we understand and have a chance to agree/disagree with that.
Otherwise we, and everyone else, are left to just be confused.

thanks,

greg k-h
