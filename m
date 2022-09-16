Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECD5BAEEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiIPOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiIPOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:06:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43334AED8E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663337161; x=1694873161;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6Y35qyUGEJdFxo9fITySx0oXT97wWrIULMbRg5QQQFM=;
  b=Op9O8QDf+TOWuCNMa8ZuKo26zWkTvlHQlFXrtnAf01+d9XFMChIY2DTE
   x5A8JCTZV9tAdzrJJ9FMIbfqfMUleJl6q3H5Rx5ighPSviT0OEYJ5GrfN
   i1NVeBGBHjF7/WXW6EjnPsplFq5f9ABprJweblZL0+F8BInKPVo0+S8K+
   CXECkGLP7PTgefz/SiVuy4mhtBWfgFSIWjWTX1lw+df5FkMLcdAIEQAMA
   iwHjj3n3h/owcPwFB4w/YGKaL0Wg38P7EUk+rzwrrbEwHms7FwICUZK8J
   pQJcvd8vxtbXlSbQUTF22jQfBeLnPn9GtdWsmfju5qYxfggtWG+6ccNIN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="385287937"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="385287937"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:05:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="613260360"
Received: from lroque-mobl1.amr.corp.intel.com ([10.251.209.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:05:57 -0700
Date:   Fri, 16 Sep 2022 17:05:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hyunwoo Kim <imv4bel@gmail.com>
cc:     arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
In-Reply-To: <20220916140353.GA235538@ubuntu>
Message-ID: <51585a1-d236-5e26-a41-125ae4d0a0eb@linux.intel.com>
References: <20220916134751.GA234676@ubuntu> <21d84319-4d1a-8d8e-a098-947772406faf@linux.intel.com> <20220916140353.GA235538@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1097490929-1663337160=:1788"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1097490929-1663337160=:1788
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 16 Sep 2022, Hyunwoo Kim wrote:

> On Fri, Sep 16, 2022 at 04:54:11PM +0300, Ilpo Järvinen wrote:
> > On Fri, 16 Sep 2022, Hyunwoo Kim wrote:
> > 
> > > A race condition may occur if the user physically removes
> > > the pcmcia device while calling ioctl() for this tty device node.
> > > 
> > > This is a race condition between the mgslpc_ioctl() function and
> > > the mgslpc_detach() function, which may eventually result in UAF.
> > > 
> > > So, add a refcount check to mgslpc_detach() to free the structure
> > > after the tty device node is close()d.
> > > 
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > 
> > > @@ -2517,9 +2548,14 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
> > >  	if (debug_level >= DEBUG_LEVEL_INFO)
> > >  		printk("%s(%d):mgslpc_open(%s) success\n",
> > >  			 __FILE__, __LINE__, info->device_name);
> > > +
> > > +	kref_get(&info->refcnt);
> > >  	retval = 0;
> > > +	mutex_unlock(&remove_mutex);
> > >  
> > > +	return retval;
> > >  cleanup:
> > > +	mutex_unlock(&remove_mutex);
> > >  	return retval;
> > 
> > Just move the cleanup label instead.
> 
> I'm sorry, but could you please explain a bit more?

The last two statements of the cleanup path and the path above it are
the same.

-- 
 i.

--8323329-1097490929-1663337160=:1788--
