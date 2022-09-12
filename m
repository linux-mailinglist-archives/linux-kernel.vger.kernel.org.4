Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B65B5A79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiILMv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiILMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:51:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D72F016
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662987115; x=1694523115;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:cc:to:from:message-id:date;
  bh=x6ts4vYetUp3ZpQvj/K2OaDXvW8F2f5htt/5hA4EZwI=;
  b=aIFbHQKO1eQDE4c1nB1Im3Ta6qkujlzJQMpidcDdw8s6/d5a58U9avnC
   ITYNhtV0RLRfSfuQ1gmtsMElppRQRCOVD+0thgI5ntDm2URxq8QFV2bs9
   FUwh8V4WZ41/Cz3jVVjFZO49YkkawI+3IuGxIlumlhE91OUjr+0w2nJhF
   4yIWPcmO8ESJAe+62TcvKNS17eewpt3CgNL38r5ljqZfNbdBzK5g3OBcv
   d0szTdnvG7/eONncPjuBwrQDBzmdo+MKi4fJO5ba+PXsSUPUx0P8EEW8Z
   T8/KTwWU1CDB+KK3mL7Ncgja6i7F2gOG88gfcotfyjQ/hfjbARdj1yAT1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359579899"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="359579899"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:51:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="616036465"
Received: from cpboland-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.16.28])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:51:51 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a3512279e0ebcd7c4d60926f118dbd435e0b7819.camel@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com> <YxDLFWjIllqqh9de@kroah.com> <166271909777.4265.10724483511179344068@jlahtine-mobl.ger.corp.intel.com> <b959d485-5986-4524-8a84-6086f1076cc5@intel.com> <a3512279e0ebcd7c4d60926f118dbd435e0b7819.camel@intel.com>
Subject: Re: [PATCH v7 00/15] GSC support for XeHP SDV and DG2
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <166298710888.11680.7585009367799223281@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Mon, 12 Sep 2022 15:51:48 +0300
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivi, Rodrigo (2022-09-09 19:33:45)
> On Fri, 2022-09-09 at 08:17 -0700, Ceraolo Spurio, Daniele wrote:
> >=20
> >=20
> > On 9/9/2022 3:24 AM, Joonas Lahtinen wrote:
> > > Dave, do you have a preference how to deal with the mishap here,
> > > shall I do a
> > > force-push to drm-intel-gt-next to correctly record the Acked-by or
> > > revert and
> > > re-push? Or just leave it as is?
>=20
> Dave and Daniel, this question is still pertinent.

Discussed with Dave and I did a force-push to add the missing
Acked-by's.

Daniele, I think the tradition is that you have volunteered
yourself to improve dim to nag about missing Acked-by's for
patches outside of i915 when pushing to drm-intel-gt-next.

Regards, Joonas

>=20
> > >=20
> > > Quoting Greg Kroah-Hartman (2022-09-01 18:09:09)
> > > > On Sat, Aug 06, 2022 at 03:26:21PM +0300, Tomas Winkler wrote:
> > > > > Add GSC support for XeHP SDV and DG2 platforms.
> > > > >=20
> > > > > The series includes changes for the mei driver:
> > > > > - add ability to use polling instead of interrupts
> > > > > - add ability to use extended timeouts
> > > > > - setup extended operational memory for GSC
> > > > >=20
> > > > > The series includes changes for the i915 driver:
> > > > > - allocate extended operational memory for GSC
> > > > > - GSC on XeHP SDV offsets and definitions
> > > > >=20
> > > > > This patch set should be merged via gfx tree as
> > > > > the auxiliary device belongs there.
> > > > > Greg, your ACK is required for the drives/misc/mei code base,
> > > > > please review the patches.
> > > > With the exception that you all don't know what year it is:
> > > >=20
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Daniele, why were the patches applied without this A-b?
> >=20
> > Apologies, I usually rely on dim to pick up all the correct r-bs and=20
> > acks from the ML and to warn me if something is missing, and I didn't
> > realize that it hadn't automagically picked up the ack.
>=20
> I understand the feeling. Recently I merged a patch from Vinay relying
> on patchwork to get the reviewed-by and I forgot to double check.
>=20
> dim picks up the "Link:", but I don't believe it picks any ack or rv-b
> from the mailing list. Patchwork does if you use pwclient or something
> like that.
>=20
> Anyway, lesson to both of us to always double-check, regardless the
> tool used.
>=20
> >=20
> > >=20
> > > I'm just preparing the drm-intel-gt-next pull request and now it
> > > appears
> > > like we're pushing a lot of commits outside of drm without any
> > > Acks.
> > >=20
> > > Please reach out to the maintainers *before* pushing code for other
> > > subsystems. Unless you get an explicit ack to do so, do not push
> > > such
> > > code.
> >=20
> > I'm assuming you mean the i915 maintainers here, given that there is
> > an=20
> > ack from Greg in this email? Rodrigo was in the loop of us needing to
> > merge this via drm, so I thought I was good on that side. I'll make
> > sure=20
> > to have an explicit ack on the ML next time (which is coming
> > relatively=20
> > soon, because there are some more mei patches in the DG2 HuC series).
>=20
> That's my fault indeed. I was following the movement, but I failed
> to step up right after I saw Greg's ack.
> Although I also noticed some re-send and reviews in progress even
> after the ack, I should had been more active there.
>=20
> Sorry,
> Rodrigo.
>=20
> >=20
> > >=20
> > > Quoting from the committer guidelines[1] the first rule is:
> > > "Only push patches changing drivers/gpu/drm/i915."
> > >=20
> > > In those cases, please ping a maintainer and don't rush things.
> >=20
> > Will do. And apologies again for the mistake.
> >=20
> > Daniele
> >=20
> > > Regards, Joonas
> > >=20
> > > [1] https://drm.pages.freedesktop.org/maintainer-tools/committer-
> > > drm-intel.html#high-level-guidelines
> > >=20
> >=20
>=20
