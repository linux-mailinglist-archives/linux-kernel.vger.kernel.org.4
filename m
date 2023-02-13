Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF29694410
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBMLMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjBMLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:12:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F119F1817A;
        Mon, 13 Feb 2023 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676286725; x=1707822725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5V7ibw1r5Bmu9z9b7YvauYuBzcaPkTNEeovkdnv9j0E=;
  b=OE2SJpLIAjA1hDGVA/kNeDS0Fy9ahwiGVsJzibUasVvNCgtE1QflWLfT
   xadNMmz7ZpLe6NQJOV8No5mz64AgJGI4d2mcp0KxbRuiypmqLWCGHjl+1
   ETnq82GTXS+/qGUwz/Yorn0yzXg4+ZyQ6/+a+aOqaVwV3JEWcNLJyTAw1
   TPoXfxuD8IdrCE+/U7HGWtc15t04zCNW27DYIiNMTl6v2pjkGEVNEdh7I
   3lGa0lpIe3p47TUa31PEyNheyqgStfddTNVlAidWy2wsCJO67KLibISZ0
   LbvFuBu34A9Wq8+azfvpBfXYV6feRd/osJBFkO3W29aDiE+/M/ljKek88
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="311228732"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="311228732"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 03:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="670785834"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="670785834"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga007.fm.intel.com with SMTP; 13 Feb 2023 03:11:37 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 13 Feb 2023 13:11:36 +0200
Date:   Mon, 13 Feb 2023 13:11:36 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>
Subject: Re: [PATCH v1 RFC] video/hdmi: Fix HDMI_VENDOR_INFOFRAME_SIZE
Message-ID: <Y+oa6O6+s5UXvOP6@intel.com>
References: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com>
 <Y+DPQjukgC0BELkN@intel.com>
 <CAFBinCBpbRu9xfCEfZJfT7t3doV=+CX03+h7W+HsoW5T4X0W0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCBpbRu9xfCEfZJfT7t3doV=+CX03+h7W+HsoW5T4X0W0w@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 09:43:50PM +0100, Martin Blumenstingl wrote:
> Hello Ville.
> 
> On Mon, Feb 6, 2023 at 10:58 AM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> [...]
> > > Change HDMI_VENDOR_INFOFRAME_SIZE to 6 bytes so
> > > hdmi_vendor_infoframe_pack_only() can properly check the passed buffer
> > > size and avoid an out of bounds write to ptr[8] or ptr[9].
> >
> > The function should return -ENOSPC if the caller didn't
> > provide a big enough buffer.
> Indeed, I'm not sure why I didn't notice when I sent the patch.
> 
> > Are you saying there are drivers that are passing a bogus size here?
> Thankfully not - at least when I checked the last time drivers passed
> a 10 byte - or bigger - buffer.
> My main concern is the HDMI_INFOFRAME_SIZE macro. It's used in various
> drivers like this:
>   u8 buffer[HDMI_INFOFRAME_SIZE(AVI)];
> 
> One could use HDMI_VENDOR_INFOFRAME_SIZE with this as well:
>   u8 buffer[HDMI_INFOFRAME_SIZE(VENDOR)];
> But it would only result in an 8 byte wide buffer.
> Nobody uses it like this yet.

Not sure that would make any sense since a vendor
specific infoframe has no defined size until you
figure out which vendor defined it (via the OUI).

I suppose the current value of 4 is also a bit nonsense
as well then, becasue that is a legal value for the
HDMI 1.4 vendor specific infoframe, but might not be
valid for any other infoframe.

We should perhaps just get rid of HDMI_VENDOR_INFOFRAME_SIZE
entirely.

> 
> Do you see any reason why my patch could cause problems?
> If not then I want to re-send it with an updated description.
> 
> 
> Best regards,
> Martin

-- 
Ville Syrjälä
Intel
