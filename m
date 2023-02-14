Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD75695F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBNJgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjBNJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:35:56 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B7026BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=WPNAPgJOGwrjbjhKNT4dc1zFH1lpGuqzCM/8y0TMxek=; b=qpSxV78fD7dv4ofdbUd0tcnwfI
        EdWll8OWfU83zwE2sE7+G+rTwE+Gc2yF81f+su2F2DJGHehyP9INoTuGKrVs+7gmalmPBQCWItjAb
        df02sUgVuMVyfiC3XkWUZGLy7RKS6yKMAqxB9UVSM4cjoQOJ/zpS3mBjL8IMjDo6qkSvgjqABWtWA
        Ok+GQK5GwHNcJ8saUcTfkiMcqKaIiSUQJ7/T6mgmbcCVdHW/WHAg1c9dRmvDWjB+PEONjQGecgCGv
        YqOitcxHCz/AmK8wjGLoRl3WCBmgbX1VvqaR+M6vPJwutPgDb2Q4S9Hwd8oo/HOhQo/fwibnzikl1
        OBZ3VI7Z3wuE3+Ay+Nj6dj2/TetJAbxEMa1afuHn/vIQMS8S5wB+Nl5P27NkHMHH0DkCzgJ60IN4e
        IoaGh26IQsc7Y9S5vprV+iMVHy2UogPZpxSff5+Szr6hZw4HnCDGVBdNRDoKJKat2RTACgx5NkrpD
        uCg/80/O7jdhp353r2gqY7zMTDa6iQbvZtpRxgjz/CRu5N+/55YdK/rGeaFO6THrnAe2p88aP1P67
        QVzqfflJyBRhEo/DWUit3/RlXag0tgqmgyT8V1FrzHfjkl2NYbc+fJavCvpd2s8onfVKK8ZEZcQzR
        vT85khSdf4Nv4iUU64ZkN0YW68PhK5rooZkZP+X1Y=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever on signals
Date:   Tue, 14 Feb 2023 10:34:36 +0100
Message-ID: <2526146.SOovFYVi4y@silver>
In-Reply-To: <Y+q7vvc2Sek8d7wG@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org> <2973654.udxrvWzM6v@silver>
 <Y+q7vvc2Sek8d7wG@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 13, 2023 11:37:50 PM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Mon, Feb 13, 2023 at 07:45:34PM +0100:
> > On Monday, February 13, 2023 7:26:54 PM CET Christian Schoenebeck wrote:
> > > On Saturday, February 11, 2023 8:50:18 AM CET Dominique Martinet wrote:
> > > > I've been working on async RPCs for a while and never had time to debug
> > > > the last issues this had, but by limiting the async clunks to failures
> > > > the impact is drastically smaller and I've not been able to reproduce
> > > > any more bug so far.
> > > > 
> > > > This will require some more testing and I'm tempted to say this is not
> > > > worth rushing this into the merge window next week-ish; the new problem
> > > > Jens reported with task_work isn't really new and I'd rather get this
> > > > right than rush new bugs in given the sour experience I've had with this
> > > > patch series... Hopefully it'll get in this time.
> > > > With that in mind I plan to take the patches in to my -next branch after
> > > > the merge window, so this has time to get reviewed first.
> > > > 
> > > > I'd like to measure impact on performance as well, but really spent way
> > > > more time on this than I already have, so that'll have to wait a bit.
> > > 
> > > I have not observed performance degradation, nor any (new) errors. So for
> > > this entire series:
> > > 
> > > Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> > 
> > Sorry, strike that. :-/
> 
> Ugh! thanks for the test, I'm not making much sense of the trace (folio
> wait bit means some background write isn't happening when flushing
> before the setattr?) but I'll try to reproduce and have a look
> today/tomorrow

Yes, apparently it tries to write dirty pages of the mapped file and keeps
hanging there [fs/9p/vfs_inode_dotl.c:586]:

int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
			  struct dentry *dentry, struct iattr *iattr)
{
	...

	/* Write all dirty data */
	if (S_ISREG(inode->i_mode))
		filemap_write_and_wait(inode->i_mapping); <-- Hang

	retval = p9_client_setattr(fid, &p9attr);

	...
}



