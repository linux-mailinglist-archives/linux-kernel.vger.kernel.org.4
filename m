Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E370F82E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjEXOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjEXOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:01:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAE99E;
        Wed, 24 May 2023 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684936892; x=1716472892;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JqaNSBpB1Y3By+PIMe1ztMXiAF8ywA/Mfx2FrrbgG6M=;
  b=GDcbKEEhvrT8qx0grpCTHmzVNKV/UJOfrnDZ8E5mOUgPPy2+VSoIU25K
   N08II5dCpnBg/S5mJuoevr3cwfpAZ6SLZGr1FaYgdv0uGiZAK/IZ+fs32
   /KmSnSp1Yv/3grhY6FHMMXuM/XgIlusd04McB4j3ZjnfhpMy8Ylblyrqi
   qUXJj0QEmxiYa8ttyTq2P/1KS8vflPT5swQ1BPNt2gVUMuFAOg3ozcRxh
   IG1q2T/B3/cBNh7gW8A1GlFkg3gFfLGzfR9R8DxL1G/UdZTkrGJSo5yDk
   UCkjB5Q77E0IfqUnvhG0B+onK62mvToYLs0Lpq/b3wW3c4Ah+O23mBnRh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="381816503"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="381816503"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 07:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="774262059"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="774262059"
Received: from nwhelanx-mobl.ger.corp.intel.com ([10.252.55.15])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 07:01:17 -0700
Date:   Wed, 24 May 2023 17:01:15 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_pci: remove unreachable code for ASIX
 devices
In-Reply-To: <aee8ff85-5716-424e-3773-33700fd90dc2@linux.intel.com>
Message-ID: <62142324-dc90-788a-f040-72ef11192e6@linux.intel.com>
References: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com> <2023051343-cringing-junction-54f7@gregkh> <188db6e4-d1de-6643-f6e1-5cb3807b28ee@linux.intel.com> <2023051533-harmonize-ozone-bc72@gregkh>
 <aee8ff85-5716-424e-3773-33700fd90dc2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Jiaqing Zhao wrote:
> On 2023-05-15 11:49, Greg Kroah-Hartman wrote:
> > On Mon, May 15, 2023 at 10:36:30AM +0800, Jiaqing Zhao wrote:
> >> On 2023-05-13 18:28, Greg Kroah-Hartman wrote:
> >>> Please follow the documented Intel kernel developer requirements before
> >>> you submit this again, based on the changes that process will require.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >> Sorry I am unable to find this "Intel kernel developer requirements". Is
> >> there any link or contact where I can find this information? Thank you.
> > 
> > Contact the Intel Linux developer team and they will point you at them.
> > This is a company-wide requirement, it is odd that your normal "Here is
> > how you can contribute to Linux!" training at Intel did not cover it?
> 
> I contacted them and there is no reply so far. Could you please tell me if
> there is any general available docs about this or point out what I'm doing
> wrong in this patch? Thank you very much.

I've pointed him to the right direction (now that I noticed this has 
just gone on here).

-- 
 i.

