Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8FA740333
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjF0S0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjF0S0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:26:16 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40B1700
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1687890362; bh=kHHAfYHgwP/dgzjiS72xnT+VmChITKgsJ5UUW7bIOtQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=d3NSY15OuwAtB595Yd141LrxkHdcjRN8qpbjex6nvBkfMCixJavVB7Lt/+3uRCL3S
         gj9OEsluH9NVW7NtrF9VHnUEU8qwhr2lqrfN6rJhsjb2tl7iFukv+r4s02Vbj1tYHN
         /PPT2lFhL2ihPB/V+IJLt1ATRKKb0LdBau8TnwoY=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Tue, 27 Jun 2023 20:26:02 +0200 (CEST)
X-EA-Auth: 9efLsvJKcKvnhci5w9xFlXD2LS7yzv66pA/KXBJc08NWD2BoLncs6YY+6AbJzknFlyRZiv5v7VwiHMG0h0i/wJa2qg8sZ7u+
Date:   Tue, 27 Jun 2023 23:55:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH] gfs2: Replace deprecated kmap_atomic() by
 kmap_local_page()
Message-ID: <ZJsptSAVHroP5hDk@bu2204.myguest.virtualbox.org>
References: <ZJiUKeVy7G6ZkX80@bu2204.myguest.virtualbox.org>
 <1905283.taCxCBeP46@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1905283.taCxCBeP46@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:11:46PM +0200, Fabio M. De Francesco wrote:
> On domenica 25 giugno 2023 21:23:21 CEST Deepak R Varma wrote:
> > kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
> > 
> >  		}
> > -		p = kmap_atomic(page);
> > +		p = kmap_local_page(page);
> >  		amt = size - copied;
> >  		if (offset + size > PAGE_SIZE)
> >  			amt = PAGE_SIZE - offset;
> >  		memcpy(buf + copied, p + offset, amt);
> 
> How about using memcpy_from_page()? 

We can do that. I will include that in v3.

Deepak.

> 
> Fabio
> 
> > -		kunmap_atomic(p);
> > +		kunmap_local(p);
> >  		put_page(page);
> >  		copied += amt;
> >  		index++;
> > --
> > 2.34.1
> 
> 
> 
> 


