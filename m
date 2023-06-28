Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17E17412F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjF1Nr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjF1NrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:47:13 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BCF211D;
        Wed, 28 Jun 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=eH4SjeRhHKBa6HEjUBhnoQ960B2age+5x0TL7nsavJA=; b=DyyA54ASxxJe8S2eoum8Zfiy5b
        Y41wiTqwy6W3H8XHKox2u8szf9sHXsTB/e5hppG6pi2dWknnXd/ZPBjXDy3LdIQjEC+hyU0MglEKV
        wous5aLK5FwjMGI9K535HuIWx+B8QRL/sBPhWnZLPVEqnKei5n4iqJnOCEj3eLIePj9VcXEnyircK
        soQyb8HF0VdvzFcfZ040oVDviKk7cocybAwllBHFJ74rYpRXyES4wht6y9TQULRte/QnzP9nDCCX6
        2dDv2+Uv8GLxL75OGt3w5A6PnZ0UtqUeKkBoFPbpDQ/8bm91gfJMdmF09aj6xfXQBK5L2OEZhjPqH
        rPtY9SmA==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qEVVZ-00GT5O-B5; Wed, 28 Jun 2023 13:46:57 +0000
Date:   Wed, 28 Jun 2023 13:46:57 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Tom Talpey <tom@talpey.com>
Cc:     sfrench@samba.org, linkinjeon@kernel.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dedupe smb unicode files
Message-ID: <ZJw50e0pvn/IN5Gj@gallifrey>
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZJw4iLlFWRMq6a3S@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 13:46:24 up 101 days, 20 min,  1 user,  load average: 0.01, 0.03,
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

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> * Tom Talpey (tom@talpey.com) wrote:
> > On 6/27/2023 9:14 PM, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > The smb client and server code have (mostly) duplicated code
> > > for unicode manipulation, in particular upper case handling.
> > > 
> > > Flatten this lot into shared code.
> > > 
> > > There's some code that's slightly different between the two, and
> > > I've not attempted to share that - this should be strictly a no
> > > behaviour change set.
> > > 
> > > I'd love to also boil out the same code from fs/jfs/ - but that's
> > > a thought for another time (and harder since there's no good test
> > > for it).
> > > 
> > > Lightly tested with a module and a monolithic build, and just mounting
> > > itself.
> > > 
> > > This dupe was found using PMD:
> > >    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > > 
> > > Dave
> > > 
> > > Dr. David Alan Gilbert (3):
> > >    fs/smb: Remove unicode 'lower' tables
> > >    fs/smb: Swing unicode common code from server->common
> > >    fs/smb/client: Use common code in client
> > > 
> > >   fs/smb/client/cifs_unicode.c                  |   1 -
> > >   fs/smb/client/cifs_unicode.h                  | 313 +-----------------
> > >   fs/smb/client/cifs_uniupr.h                   | 239 -------------
> > >   fs/smb/common/Makefile                        |   1 +
> > >   .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
> > >   fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++
> > 
> > So far so good, but please drop the "cifs_" prefix from this new file's
> > name, since its contents apply to later smb dialects as well.
> 
> Sure.

Actually, would you be ok with smb_unicode_common ?  The reason is that
you end up with a module named unicode_common  that sounds too generic.

Dave

> Dave
> 
> > Tom.
> > 
> > >   fs/smb/server/unicode.c                       |   1 -
> > >   fs/smb/server/unicode.h                       | 301 +----------------
> > >   8 files changed, 298 insertions(+), 993 deletions(-)
> > >   delete mode 100644 fs/smb/client/cifs_uniupr.h
> > >   rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
> > >   create mode 100644 fs/smb/common/cifs_unicode_common.h
> > > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
