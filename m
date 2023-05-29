Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF5714D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjE2Pl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjE2Pl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:41:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78394A8;
        Mon, 29 May 2023 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685374916; x=1716910916;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w/u+IjLUbY+uBycEW2YEaZDefdA9TPsQohr+akmnCn0=;
  b=VikxalKXb2CHGaAvszgPtu0N+Ov5SkINqwpxt5weh838q8TeOP3T8JlW
   BMrgpB3G2yEaImuj0nIyMv7HdWAlTzq5vKtP5XnSc4dP5TzFHS+MbOacD
   1IsvqsgivDjAt1/7rn6D0BiqyCeKz1RxWXXQ96Axacyio8+lfXk6xaHME
   Mr2ze3wdgF2OJ1quFrsmO2aUQxxx8gP5nNXObvsu52Gyt/YKjQD/8aR03
   nL+9KX09H9qVKaVb/r/zUApGAm2BrO1wH1LSIF0kBMoodxVANAC5BAt2W
   QTuQmUkjCXGY6uqmuRYdlbft8i7RvNsOdRSs/VcrAa0uL+/jDtjjvepWl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="382986158"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="382986158"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771203503"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="771203503"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 08:41:48 -0700
Date:   Mon, 29 May 2023 18:41:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] platform/x86: think-lmi: Correct NVME password
 handling
In-Reply-To: <709df78f-4313-460a-87da-f4d302ed8912@app.fastmail.com>
Message-ID: <2796a7d0-8010-ab14-23a-9f69ee9d465@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <20230526171658.3886-3-mpearson-lenovo@squebb.ca> <a52f69f-2dc4-fe76-9f89-e1c143d2bb27@linux.intel.com> <709df78f-4313-460a-87da-f4d302ed8912@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1210459766-1685374910=:2737"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1210459766-1685374910=:2737
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 May 2023, Mark Pearson wrote:
> On Mon, May 29, 2023, at 8:03 AM, Ilpo Järvinen wrote:
> > On Fri, 26 May 2023, Mark Pearson wrote:
> >
> >> NVME passwords identifier have been standardised across the Lenovo
> >> systems and now use udrp and adrp (user and admin level) instead of
> >> unvp and mnvp.
> >> 
> >> This should apparently be backwards compatible.
> >> 
> >> Also cleaned up so the index is set to a default of 1 rather than 0
> >> as this just makes more sense (there is no device 0).
> >
> > These two sound entirely separate changes. If that's the case, please 
> > make own patch from the send change.
> 
> Ack. It was all related to the index setting and seemed trivial so I 
> lumped together but I can split. This patch series is turning into a 
> good learning exercise for my git skills :) (which are limited)
>
> > Hmm, index_store() still allows 0, is that also related here? Please check 
> > also ABI documentation as index default seems to be mentioned there as 
> > well.
> >
> 
> I'd rather not limit it so 0 isn't allowed in case our BIOS team does 
> something weird in the future; but right now 1 is the default so it 
> makes more sense.

Sure, do what you feel makes sense here. I was just pointing out the 
perceived inconsistency in case it wasn't intentional.

It might be useful to add one sentence into changelog about the reasoning 
so it can be found easier later on (effectively the paragraph you wrote 
above with small tweaks is enough I think).


-- 
 i.

--8323329-1210459766-1685374910=:2737--
