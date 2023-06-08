Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AE727967
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjFHIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjFHH77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B622D66
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E2C649E8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E548BC433D2;
        Thu,  8 Jun 2023 07:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686211171;
        bh=QZuWevEGbS7eH2QLlHDqrU/R3vNNbwBkMxJ4axuXrX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dF3xz25m+LQkLdlwXOwbZZjt1/wv+xR4bFflH2QjCLC+7NriFigEBzeRodOtmVBhJ
         v2yYDfpCcf02TcZrie+aIln2HvEM9QmHJcxtTKElYUGlHKrf9CRezjgXJ9GKaYjbtg
         czaVrAG6gxS/9Ulo3AwVRZbPDlD6x9AfQYMDu23I=
Date:   Thu, 8 Jun 2023 09:59:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        jmarchan@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Dongwon Kim <dongwon.kim@intel.com>,
        James Houghton <jthoughton@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm: fix hugetlb page unmap count balance issue
Message-ID: <2023060803-trailing-ladder-2d53@gregkh>
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
 <CADrL8HV25JyeaT=peaR7NWhUiaBz8LzpyFosYZ3_0ACt+twU6w@mail.gmail.com>
 <20230512232947.GA3927@monkey>
 <20230515170259.GA3848@monkey>
 <20230516223440.GA30624@monkey>
 <20230607120312.6da5cea7677ec1a3da35b92c@linux-foundation.org>
 <20230607205310.GA4122@monkey>
 <20230607140001.6685b0a058511f125a005da4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607140001.6685b0a058511f125a005da4@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:00:01PM -0700, Andrew Morton wrote:
> On Wed, 7 Jun 2023 13:53:10 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> > > 
> > > BUGs aren't good.  Can we please find a way to push this along?
> > > 
> > > Have we heard anything from any udmabuf people?
> > > 
> > 
> > I have not heard anything.  When this issue popped up, it took me by surprise.
> > 
> > udmabuf maintainer (Gerd Hoffmann), the people who added hugetlb support and
> > the list where udmabuf was developed (dri-devel@lists.freedesktop.org) have
> > been on cc.
> 
> Maybe Greg can suggest a way forward.

I'm guessing that no one is using this code then, so why don't we just
remove it entirely?

thanks,

greg k-h
