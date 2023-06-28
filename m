Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F27412C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjF1Nlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjF1Nlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:41:47 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D2129;
        Wed, 28 Jun 2023 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=EPySIftZSA/ANVv7duy+nkpNF1TRSIy5ZkBMzXpU3B4=; b=UN6LVzBThsGmqA3+M7gmTxfh1l
        zMVyubo43pIUiCCMKEzgJSXs8rhru8EwKMOZvlO/ekv+vM4VkuQOcSPy8mlYA6WE/lblOu9Ulio8P
        Zt8p2SXv6APS2z3SP6RI9Av+YriIxYFvrWXapRlB5mwcW7B3uwpN3u/vW9TX9UraBMF6cvHp6OJ71
        hlhfXBm85dK6NFNyb9SOn6JyCblqLjjNrx+PzqWXWt47x6q4zKp9T+KE+oVYECmID0M/qbazE2gtS
        g+bmH3BNR2s/LOFIju1kaf2zO5OUlG286VA2GKn1t5hrHV4/6Y/TYbrN4bFSzQXZon/Jv1WIcSiQx
        3zprm/ew==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qEVQG-00GT0N-Px; Wed, 28 Jun 2023 13:41:28 +0000
Date:   Wed, 28 Jun 2023 13:41:28 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Tom Talpey <tom@talpey.com>
Cc:     sfrench@samba.org, linkinjeon@kernel.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dedupe smb unicode files
Message-ID: <ZJw4iLlFWRMq6a3S@gallifrey>
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 13:41:22 up 101 days, 15 min,  1 user,  load average: 0.01, 0.05,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Talpey (tom@talpey.com) wrote:
> On 6/27/2023 9:14 PM, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > The smb client and server code have (mostly) duplicated code
> > for unicode manipulation, in particular upper case handling.
> > 
> > Flatten this lot into shared code.
> > 
> > There's some code that's slightly different between the two, and
> > I've not attempted to share that - this should be strictly a no
> > behaviour change set.
> > 
> > I'd love to also boil out the same code from fs/jfs/ - but that's
> > a thought for another time (and harder since there's no good test
> > for it).
> > 
> > Lightly tested with a module and a monolithic build, and just mounting
> > itself.
> > 
> > This dupe was found using PMD:
> >    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > 
> > Dave
> > 
> > Dr. David Alan Gilbert (3):
> >    fs/smb: Remove unicode 'lower' tables
> >    fs/smb: Swing unicode common code from server->common
> >    fs/smb/client: Use common code in client
> > 
> >   fs/smb/client/cifs_unicode.c                  |   1 -
> >   fs/smb/client/cifs_unicode.h                  | 313 +-----------------
> >   fs/smb/client/cifs_uniupr.h                   | 239 -------------
> >   fs/smb/common/Makefile                        |   1 +
> >   .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
> >   fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++
> 
> So far so good, but please drop the "cifs_" prefix from this new file's
> name, since its contents apply to later smb dialects as well.

Sure.

Dave

> Tom.
> 
> >   fs/smb/server/unicode.c                       |   1 -
> >   fs/smb/server/unicode.h                       | 301 +----------------
> >   8 files changed, 298 insertions(+), 993 deletions(-)
> >   delete mode 100644 fs/smb/client/cifs_uniupr.h
> >   rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
> >   create mode 100644 fs/smb/common/cifs_unicode_common.h
> > 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
