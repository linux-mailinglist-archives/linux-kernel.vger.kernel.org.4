Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA505EE89F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiI1VuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiI1VuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:50:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFB40BC6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664401802; x=1695937802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jAp6g8IDteEvN7gUomIvX4l/pOqtMF+B6XRGdqqJEU8=;
  b=MlL3FMwAa/X12MXB/MWEjYbxIovByvLjvgj6ERuI8aSxNiA9F3knOca5
   RKZDGfNQaucpGEM8ATCOtKBLXkgTEI/czp+ilZdNe6k0aLUe5FIjciCfL
   5FGZ0g2OcwCBQjMjXEa7PtvbGOdI7IOwL73ZcSzciv1XTX265H7uPkgEy
   hMgLKBBLXa70FVjldMUGUFS6dd6MRAPg788jZQIHUlGqkjU1AhCITHJXI
   YMyX0+Q7HaNeHLbt6XjNAqOt4UUQCsiWLZ1R0E6DNpcD58osPGzLb97EV
   Mxq6BfkHeaerZOlBgxLNbLiLT0WOhpqRZpCHl0qppoKYDHjBGxGy7OEMb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="328094853"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="328094853"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:50:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="711127393"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="711127393"
Received: from rtbolt-desk1.amr.corp.intel.com (HELO [10.212.184.123]) ([10.212.184.123])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:50:01 -0700
Message-ID: <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
Date:   Wed, 28 Sep 2022 14:50:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220928142109.150263-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really don't like the idea of *both* a new boot parameter and a new
Kconfig option.

The warning mode worked as intended in this case because it got a user
to file a bug and that bug report made it back to us.  It's kinda funny
to respond to that report by reducing the misery.

On the other hand, all the report resulted in was finger-pointing at a
binary Windows applications that neither we nor probably anybody else
can do anything about.

It boils down to either:
 * The misery is good and we keep it as-is, or
 * The misery is bad and we kill it

My gut says we should keep the warnings and kill the misery.  The folks
who are going to be able to fix the issues are probably also the ones
looking at dmesg and don't need the extra hint from the misery.  The
folks running Windows games don't look at dmesg and just want to play
their game without misery.

The other option is to wait and see if there's any kind of pattern with
these reports.
