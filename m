Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF86552E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiLWQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLWQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:42:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF4631E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:42:33 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA0C068AA6; Fri, 23 Dec 2022 17:42:29 +0100 (CET)
Date:   Fri, 23 Dec 2022 17:42:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, oe-kbuild@lists.linux.dev,
        Sagi Grimberg <sagi@grimberg.me>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn:
 missing error code? 'ret'
Message-ID: <20221223164229.GA31884@lst.de>
References: <202212222333.vrYfUBqM-lkp@intel.com> <20221223154754.GA30339@lst.de> <Y6XVnWCNx6cB7Itw@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6XVnWCNx6cB7Itw@kadam>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 07:21:49PM +0300, Dan Carpenter wrote:
> > -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
> > +	if (!ctrl->host_key && !ctrl->ctrl_key)
> >  		return ret;
> 
> ret is uninitialized now.

Yes.  Should be a 'return 0'.

We really need to turn the maybe uninitialized warnings back on.
