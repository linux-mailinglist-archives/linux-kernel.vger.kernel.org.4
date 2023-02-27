Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8016A46B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjB0QHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjB0QHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:07:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF4921970
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677514024; x=1709050024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XaqUCRPxJCEP+4LkIaXq8C52rHZtBFl42QMvotTeXGs=;
  b=jDfonnAlaHwebM1AT+0RtnOjb/nrlNx2ecA9xsjw9bxEmoFAawUaV3ga
   sopacSlxXa1yVv6ozZGZkIQpbuz5U5akO4nk5vwbR4oUC6Xe234fRcICq
   aV7tKPuCgqezYQ+Llywl64Nc73yMfvU0Ap1HF9f65drnTT7qOTyZTvTGa
   /U/sQ+qimAU0P7t/IoFWUN+KtWq3FveXfkLc5OytxZN6fnGLCjHSYumLd
   hCPM5MajMVWUTg8rmbHuu83EU5oF6HkgQdrloU6FTyzHMxFAo3os2Ns5M
   /Fn+pmRxGHDjsBrpBsI67H9RzxCbGHsMN2smjuU9QbNZIbkx5Dvk88QAW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314317826"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="314317826"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="742622331"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="742622331"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga004.fm.intel.com with SMTP; 27 Feb 2023 08:06:46 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 27 Feb 2023 18:06:45 +0200
Date:   Mon, 27 Feb 2023 18:06:45 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Message-ID: <Y/zVFfSLoO5Fz/3D@intel.com>
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
 <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:40:11AM -0800, Rob Clark wrote:
> On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Add a build option to disable modesetting support.  This is useful in
> > > cases where the guest only needs to use the GPU in a headless mode, or
> > > (such as in the CrOS usage) window surfaces are proxied to a host
> > > compositor.
> >
> > Why make that a compile time option?  There is a config option for the
> > number of scanouts (aka virtual displays) a device has.  Just set that
> > to zero (and fix the driver to not consider that configuration an
> > error).
> 
> The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
> guess that could be done based on whether there are any scanouts, but
> it would mean making the drm_driver struct non-const.

dev.driver_features is a thing.

-- 
Ville Syrjälä
Intel
