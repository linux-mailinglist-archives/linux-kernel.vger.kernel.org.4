Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEA73FA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjF0Kmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0Kmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:42:51 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6ED10CB;
        Tue, 27 Jun 2023 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b6mr6IUj1sLKRFPC3AWOY5M8vnn/8M/C9oYU60Dvbts=; b=dR9ol1QSKJfK37McjDOz41Gsv0
        neGIJPSNJah6e0ntbkCkVhdo+dfy5MXj/zjGGmjB2fyUvBM9b/AMTEKfA8Pt+7XLM/XzB6zWCReeP
        uyIxa/yfYC4zQTIAsvKh0chKBxbXcFI+vdnleBudNHab8ZNbAdX1So/1EdquIwvaAcZcrLHASDFFH
        Bgx22cUwiPmM6M0cg9q1wInlsxibkDPYsMFFGB/z+HEly1KdnZVd3ZP6Yz2mXhxHZfdDWFlJGn6EX
        3jXcNSCSDRg9f4x6763Kx6/okBhfM5G3J6hcvHZzNMQt7CrwB0oYOe8j5rO31GiAgYFnLFKHGzP9q
        yE0NBpmA==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qE69V-00GFnB-4Y; Tue, 27 Jun 2023 10:42:29 +0000
Date:   Tue, 27 Jun 2023 10:42:29 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>, sfrench@samba.org,
        linkinjeon@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Duplicate unicode tables in smb/cifs/jfs
Message-ID: <ZJq9FcdFLQIZ8cja@gallifrey>
References: <ZJhPIYSUzBpuqosh@gallifrey>
 <25821273-d391-1502-ff8a-07ea7a59c8f3@oracle.com>
 <CAH2r5mvwZnd+S8CmZGQSdtnAWD45YjFx-1j0EaFBR3Qn-SjHEA@mail.gmail.com>
 <ZJov5VNakxNXU0Mk@gallifrey>
 <CAH2r5mvEWeSOM=NYrxSG1EZ1py-DSkOrwEyh+_L-KuFLVWktQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mvEWeSOM=NYrxSG1EZ1py-DSkOrwEyh+_L-KuFLVWktQw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 10:42:00 up 99 days, 21:16,  1 user,  load average: 0.08, 0.04, 0.01
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

* Steve French (smfrench@gmail.com) wrote:
> On Mon, Jun 26, 2023 at 7:40 PM Dr. David Alan Gilbert <linux@treblig.org>
> wrote:
> 
> > * Steve French (smfrench@gmail.com) wrote:
> > > probably is low risk to make the ksmbd/cifs (server and client) code
> > common
> > > for this
> >
> > I'm up for trying to do that mod; do you have a feel of the best way?
> > I guess this is two copies to avoid symbol clashes if both the server
> > and clients are built/loaded on the same kernel?
> >
> 
> First step would be to move common Unicode/UCS-2 header definitions from
> fs/smb/client
> and fs/smb/server to fs/smb/common
> 
> Second stuff could be having a common helper module in fs/smb/common
> similar to
> fs/smb/common/cifs_md4.ko

OK, let me have a crack at that and see where I get to.

Dave

> 
> 
> > I guess the clean way is to make this a separate .c/module that the
> > others depend on and hten you have a nice single copy in the binary
> > as well as the source.
> >
> > The shorter hack that at least avoids the source dupe would be to
> > change the declarations in the uniupr.h files to a #define that then
> > instantiates it with different names in the place those are #included.
> > You'd want to move the uniupr.h up somewhere, to hmm fs/uniupr.h ?
> >
> > (Incidentally, I think the UNIUPR_NOLOWER is always defined
> > so that whole chunk can go in both of them).
> >
> > I guess the next level would be trying to merge parts of server/client
> > unicode.[ch] - but I was just eyeing up this particularly simple dupe in
> > that odd uniupr.h.
> >
> > > (and leave the JFS code alone as Dave Kleikamp suggests)
> >
> > Well hmm; my reading is the tables that JFS uses are *identical*
> > to these; so if this header was somewhere outside of fs/smb it could
> > probably #include it and just use the same table, with a
> > no-binary-change.
> >
> > Dave
> >
> > > On Mon, Jun 26, 2023 at 12:03 PM Dave Kleikamp <dave.kleikamp@oracle.com
> > >
> > > wrote:
> > >
> > > > On 6/25/23 9:28AM, Dr. David Alan Gilbert wrote:
> > > > > Hi All,
> > > > >    I just tripped over three sets of duplicated unicode tables and
> > > > > wondered if anyone had tried to rationalise them:
> > > > >
> > > > >    The pair of:
> > > > >     ./fs/smb/server/uniupr.h
> > > > >     ./fs/smb/client/cifs_uniupr.h
> > > > >
> > > > >     are identical except for formatting.
> > > > >
> > > > > ./fs/jfs/jfs_uniupr.c,
> > > > >    and I think this is the same with some change in variable name.
> > > >
> > > >  From JFS's point of view, I wonder how relevant any of this code is.
> > > > The Linux port of JFS originally was interested in compatibility with
> > > > OS/2, which had case-insensitive file names. (Case-preserving, if I
> > > > remember correctly, but names would match in a case-insensitive
> > manner.)
> > > >
> > > > I would be surprised if anyone cares about this feature anymore.
> > Without
> > > > a JFS_OS2 flag set in the superblock, none of the case-conversion code
> > > > comes into play.
> > > >
> > > > I assume SMB cares more about this and if Steve has an opinion on how
> > to
> > > > address this, I'd be happy to follow his lead. Probably better than
> > > > ripping function out of JFS that could break some user that I'm not
> > > > aware of.
> > > >
> > > > Shaggy
> > > >
> > > > >
> > > > > (I'm guessing the same thing is implemented in a bunch of
> > > > > other places as well in a different way)
> > > > >
> > > > > Would it make sense to swing fs/smb/server/uniupr.h up to
> > > > > hmm, maybe fs/uniupr.h, remove any of the cifs_ prefixes
> > > > > and then use the same include in all 3 places?
> > > > >
> > > > > Maybe then later look at using some of the nls code?
> > > > >
> > > > > Dave (who just tripped over this stuff)
> > > > >
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> >
> 
> 
> -- 
> Thanks,
> 
> Steve
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
