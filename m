Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9205E7788
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiIWJnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIWJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:43:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB96130BE7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663926192; x=1695462192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7Nj4ZKloUj2mmPrfDMHTxoMovegH27pXgUKU8WiMcUY=;
  b=gmyjPZ9sZboQeiKMRzikTZu6P4jpd9wLumcMgY0CcAG+y/GJSnOaEioU
   FwDkoGKXaQiH1mBE3w2wJsO4zK/aHp7x2ZoLsJ8xkDnL7378r8RJVa47D
   UExbAeoQI08/aurP0P+SHwnNEFOQKzB0zbSJ3SoBg4WTY6gCzYYu8+q1i
   Zxce7TAuzLYqV08jCt6deW77uygTLbHxXCXNQLdRJDhfwsG0dXCX8tdsX
   wmaCPo9TM4+FFNXuNzt186a2PXdwjMFnOKaht8k5Y+9/j9WYvSCg4PlH/
   aWBBRs6WNo43lsiZxVu49Xfnm767yQk0i2oKN635+XRY9rmDioxnFjARB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299277157"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299277157"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 02:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622464644"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga007.fm.intel.com with SMTP; 23 Sep 2022 02:43:08 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 23 Sep 2022 12:43:07 +0300
Date:   Fri, 23 Sep 2022 12:43:07 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Use drm_atomic_get_new_plane_state()
Message-ID: <Yy1/q1WY2vD2Q8RF@intel.com>
References: <20220923083447.1679780-1-javierm@redhat.com>
 <Yy1271xW1SOlL41e@intel.com>
 <7ccc4b30-0f85-6870-0c60-9897fdb374b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ccc4b30-0f85-6870-0c60-9897fdb374b9@redhat.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:16:00AM +0200, Javier Martinez Canillas wrote:
> Hello Ville,
> 
> On 9/23/22 11:05, Ville Syrjälä wrote:
> > On Fri, Sep 23, 2022 at 10:34:47AM +0200, Javier Martinez Canillas wrote:
> >> The struct drm_plane .state shouldn't be accessed directly but instead the
> >> drm_atomic_get_new_plane_state() helper function should be used.
> >>
> >> This is based on a similar patch from Thomas Zimmermann for the simpledrm
> >> driver. No functional changes.
> >>
> >> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > 
> > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> 
> Thanks.
>  
> > I wonder how many naked obj->state dereferences are still
> > left in places where they should be using the get_{new,old}()
> > stuff. Might have to write a bit of cocci to find out...
> > 
> > 
> > Btw on a somewhat related note, I've been thinking about bringing
> > for_each_crtc_in_state() & co. back (got removed in commit
> > 77ac3b00b131 ("drm/atomic: Remove deprecated accessor macros"))
> > but this time without any object state iterator variable. Now that
> > we're more often just plumbing the full atomic state through I
> > think there are bunch of places that don't need the object state(s)
> > within the loop at all, so having to have those variables around
> > makes the whole thing a bit noisy. Also IIRC we had to add some
> > (void) casts into the current macros to hide some compiler warnings
> > about unused variables. Could get rid of at least some of those extra
> > casts again.
> > 
> > I don't suppose there's anyone interested in doing that so I don't
> > have to? ;)
> > 
> 
> Maybe you can add an entry in Documentation/gpu/todo.rst, explaining
> this and putting yourself as a contact? 

Seems about as much work as just doing it.

-- 
Ville Syrjälä
Intel
