Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49B6180AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiKCPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiKCPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:09:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37600165B6;
        Thu,  3 Nov 2022 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667488106; x=1699024106;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=yeW9eeJhsyvz9FzwMMUudELqRBI7Xek1EfSMp8Ul2nw=;
  b=BW3RwmU+snPa8vkBFIgICQq1H4gCCfBGceuO9h2MEaFINqSXefS8VL3R
   9rEew6p2mK3SO5pXkwVSI6S6NMVP/xtKBwN1bz0KIMFxYM2RGjNA3ezmn
   Hkk1yHMxsebYO6Z9oHbtP0kvZv36w0ZLJvShJW+gWU5WTUORst9HDz9WN
   NgdxNt0pfegB1GYpJl1FShnK5ILRhyyXuADeaKWTEv39U7G6VvYmTYJtQ
   aIROiAsXaX2Pc5xN7xLwlwfqeYV1+e6qYJObMAfnFI/u8/eYic26sr7MU
   YyDCpP5uFeGTgjcbFqwkKZqjTSm1zUqe4AWM6OlKIr9yuHeKYImSXSXCL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="309704952"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="309704952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:08:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666003047"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="666003047"
Received: from jsentis-mobl.ger.corp.intel.com ([10.251.215.225])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:08:23 -0700
Date:   Thu, 3 Nov 2022 17:08:20 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] tty: n_gsm: add parameter negotiation support
In-Reply-To: <20221103091743.2119-3-daniel.starke@siemens.com>
Message-ID: <ca6a13b-2bb-6bfb-3720-41677fcaea96@linux.intel.com>
References: <20221103091743.2119-1-daniel.starke@siemens.com> <20221103091743.2119-3-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2136426116-1667487869=:1757"
Content-ID: <ca68bd6b-a3e8-76e-e3ae-2e2415aeefff@linux.intel.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2136426116-1667487869=:1757
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <4441385a-4cbd-aff5-5cf1-29398bc7f055@linux.intel.com>

On Thu, 3 Nov 2022, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.1.8.1.1 describes the parameter negotiation
> messages and parameters. Chapter 5.4.1 states that the default parameters
> are to be used if no negotiation is performed. Chapter 5.4.6.3.1 describes
> the encoding of the parameter negotiation message. The meaning of the
> parameters and allowed value ranges can be found in chapter 5.7.
> 
> Add parameter negotiation support accordingly. DLCI specific parameter
> configuration by the user requires additional ioctls. This is subject to
> another patch.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>

Thanks.

For all three patches:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


BTW, you should have carried the Reviewed-bys over in patches 1-2 since I 
already gave those tags for you for v2. Please try to remember to collect 
the tags next time if you end up resubmitting a series.


-- 
 i.
--8323329-2136426116-1667487869=:1757--
