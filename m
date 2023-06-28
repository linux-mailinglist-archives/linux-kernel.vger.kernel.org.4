Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C99A7413ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjF1Ojh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjF1Ojf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:39:35 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104831BE9;
        Wed, 28 Jun 2023 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=Y+h3psH8kyepKt0SHm6nKIRinuAsAOc2xGKERSPlzLo=; b=qp5CNnbUzq2Bev6266GGIkarzA
        4Lk6OATQG1sHfy87MfKK2/pMQn0OourcKXNT+8OS6dT2SlBzthbPlYz5Fh1zvpsvcKxf4EhHIw3o3
        ExolsLzc3Gw6yKodX4Ggzs6q7FeD6Zoc1HlN+ICNu2uEIHNeziRJaCSTHLj3b+wkVmLQZ0qN50gdM
        WZdO6nlo/C80lHStpmFTvO/+LWbbFfs+7FJ8BWUvs9d9OjpltMgBJIMkRxtncSBe5WRhE/RjfyZNt
        9/HTqFj2FxfFT9kxn3pH/7w6fywboachTkuNNrOxQ1DgKNvcmg35skm20oFw0S0JNwjbNNu2nuJZm
        MUfcIH9w==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qEWKC-00GTcI-69; Wed, 28 Jun 2023 14:39:16 +0000
Date:   Wed, 28 Jun 2023 14:39:16 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>, krisman@collabora.com
Cc:     Tom Talpey <tom@talpey.com>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linkinjeon@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
Message-ID: <ZJxGFBzuhU8t5rcx@gallifrey>
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey>
 <ZJw50e0pvn/IN5Gj@gallifrey>
 <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 14:38:21 up 101 days,  1:12,  1 user,  load average: 0.02, 0.01,
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

* Dave Kleikamp (dave.kleikamp@oracle.com) wrote:
> On 6/28/23 8:46AM, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > > * Tom Talpey (tom@talpey.com) wrote:
> > > > On 6/27/2023 9:14 PM, linux@treblig.org wrote:
> > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > 
> > > > > The smb client and server code have (mostly) duplicated code
> > > > > for unicode manipulation, in particular upper case handling.
> > > > > 
> > > > > Flatten this lot into shared code.
> > > > > 
> > > > > There's some code that's slightly different between the two, and
> > > > > I've not attempted to share that - this should be strictly a no
> > > > > behaviour change set.
> > > > > 
> > > > > I'd love to also boil out the same code from fs/jfs/ - but that's
> > > > > a thought for another time (and harder since there's no good test
> > > > > for it).
> > > > > 
> > > > > Lightly tested with a module and a monolithic build, and just mounting
> > > > > itself.
> > > > > 
> > > > > This dupe was found using PMD:
> > > > >     https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > > > > 
> > > > > Dave
> > > > > 
> > > > > Dr. David Alan Gilbert (3):
> > > > >     fs/smb: Remove unicode 'lower' tables
> > > > >     fs/smb: Swing unicode common code from server->common
> > > > >     fs/smb/client: Use common code in client
> > > > > 
> > > > >    fs/smb/client/cifs_unicode.c                  |   1 -
> > > > >    fs/smb/client/cifs_unicode.h                  | 313 +-----------------
> > > > >    fs/smb/client/cifs_uniupr.h                   | 239 -------------
> > > > >    fs/smb/common/Makefile                        |   1 +
> > > > >    .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
> > > > >    fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++
> > > > 
> > > > So far so good, but please drop the "cifs_" prefix from this new file's
> > > > name, since its contents apply to later smb dialects as well.
> > > 
> > > Sure.
> > 
> > Actually, would you be ok with smb_unicode_common ?  The reason is that
> > you end up with a module named unicode_common  that sounds too generic.
> 
> I'd suggest make it generic and move it to fs/nls/. I'd run it by the nls
> maintainers, but I don't think there are any.

Steve & Tom - would you be OK with that?

(Copying in Gabriel Bertazi, owner of fs/unicode; although this isn't
utf-8)

Dave

> Shaggy
> 
> > 
> > Dave
> > 
> > > Dave
> > > 
> > > > Tom.
> > > > 
> > > > >    fs/smb/server/unicode.c                       |   1 -
> > > > >    fs/smb/server/unicode.h                       | 301 +----------------
> > > > >    8 files changed, 298 insertions(+), 993 deletions(-)
> > > > >    delete mode 100644 fs/smb/client/cifs_uniupr.h
> > > > >    rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
> > > > >    create mode 100644 fs/smb/common/cifs_unicode_common.h
> > > > > 
> > > -- 
> > >   -----Open up your eyes, open up your mind, open up your code -------
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > > \        dave @ treblig.org |                               | In Hex /
> > >   \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
