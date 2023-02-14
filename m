Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6F696FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjBNVfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjBNVfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:35:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F82712;
        Tue, 14 Feb 2023 13:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676410513; x=1707946513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VPGTDJyhjIdDevAm/7izz9E6Kei7p3VCLOPhAdXLQng=;
  b=YTdPoob10rqijDPOkBWd2tjsyty/jWfwzEMvyDlLzINvfkW2W2cpMXdK
   diZEiRkaT6wJyQX0EpLwHwOS/jpo4bqY48tZgWWNkhI7TXq2gXMyTMO3G
   dzIbY7nk0XsQ5zuR3Dp9273IhMScdJxlkdcuB4FZQ4p4u8F9T5GTprUeC
   bIweFBmmC3MipjYG/mM3X1P0uccHzG0FNJ/VWA/nwCy4bWEL/OlzJcEKh
   0kZ6TthsU+x/+ph54i54RFZOYKTfPMGPz5EV/eBwiiUh741B+GgjCi3g7
   hXnDXmQKheF2pKMlPaV+Bt/nxwXxR68AJw/TNLhQipW95O7s9MoHkQqBm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="393679207"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="393679207"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701779514"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="701779514"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by orsmga001.jf.intel.com with SMTP; 14 Feb 2023 13:35:08 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 14 Feb 2023 23:35:08 +0200
Date:   Tue, 14 Feb 2023 23:35:08 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>
Subject: Re: [PATCH v1 RFC] video/hdmi: Fix HDMI_VENDOR_INFOFRAME_SIZE
Message-ID: <Y+v+jFKiQ3Rj2aYL@intel.com>
References: <20230109223110.1165433-1-martin.blumenstingl@googlemail.com>
 <Y+DPQjukgC0BELkN@intel.com>
 <CAFBinCBpbRu9xfCEfZJfT7t3doV=+CX03+h7W+HsoW5T4X0W0w@mail.gmail.com>
 <Y+oa6O6+s5UXvOP6@intel.com>
 <CAFBinCC6RRiN0=XYNw464omzjHrRcNZn39i3_Ztfq6M2xMpgRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCC6RRiN0=XYNw464omzjHrRcNZn39i3_Ztfq6M2xMpgRw@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:26:24PM +0100, Martin Blumenstingl wrote:
> On Mon, Feb 13, 2023 at 12:11 PM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> [...]
> > > One could use HDMI_VENDOR_INFOFRAME_SIZE with this as well:
> > >   u8 buffer[HDMI_INFOFRAME_SIZE(VENDOR)];
> > > But it would only result in an 8 byte wide buffer.
> > > Nobody uses it like this yet.
> >
> > Not sure that would make any sense since a vendor
> > specific infoframe has no defined size until you
> > figure out which vendor defined it (via the OUI).
> My understanding is that all of the existing HDMI vendor infoframe
> code is built for HDMI_IEEE_OUI.

Only because no one has bothered to implement any
others.

> 
> > I suppose the current value of 4 is also a bit nonsense
> > as well then, becasue that is a legal value for the
> > HDMI 1.4 vendor specific infoframe, but might not be
> > valid for any other infoframe.
> >
> > We should perhaps just get rid of HDMI_VENDOR_INFOFRAME_SIZE
> > entirely.
> My thought was to make it the correct size for
> drm_hdmi_vendor_infoframe_from_display_mode(). Then developers using
> this "common" vendor infoframe don't have to worry much.
> If there's another vendor infoframe implementation (which I'm not
> aware of, but it may exist - since as you point out: it's vendor
> specific) then the driver code shouldn't use
> drm_hdmi_vendor_infoframe_from_display_mode() but rather implement
> something custom. At that point the person implementing that will also
> need to know their specific infoframe maximum size.

Yes but that other infoframe will still have
type==HDMI_INFOFRAME_TYPE_VENDOR, and
HDMI_INFOFRAME_SIZE(VENDOR) would again
give the wrong answer.

-- 
Ville Syrjälä
Intel
