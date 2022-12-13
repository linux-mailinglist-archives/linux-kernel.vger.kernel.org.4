Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9564B7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiLMOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiLMOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:54:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2A2188B;
        Tue, 13 Dec 2022 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670943270; x=1702479270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZatOAHNkQsW1nDuKDZq+RkkySdsy6O82Kh9XxlKI6Hw=;
  b=MrfJyXNJ5fIKwE495Vz3LTVpMCOk2xUN/GmMmF64HweSeRIvJL6pOW8r
   tKHlFLoX3lfa8FOQwui4ZEe35T0n3uvRBiNQRKc1zr45H1/LAS7blTlgE
   vj7m0x5UxmNMRGmGM1p2GQjYEPmqgKNHdvkl5PPJj9++t08GQ14ygLkJy
   bk4BFVf7PemUrQ67YozyehtLRXL9z76qB710UGrRXMFSFAeYsttrJH0z3
   L7kajOYcJrzPhFMlpkFcOxzXviCZ1pZkTTNZ2/Lyh50JC6LbvBWuxa63A
   k3rlN8j1/1B7rt8fD5Eu/WYLvX1Mw3s3D/YsdQ1L6Pt19xMGdYfFa0/Aa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="315784093"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="315784093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 06:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="737419417"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="737419417"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2022 06:54:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BE73AF7; Tue, 13 Dec 2022 16:54:46 +0200 (EET)
Date:   Tue, 13 Dec 2022 16:54:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt (gcc13): synchronize
 tb_port_is_clx_enabled()'s 2nd param
Message-ID: <Y5iSNppygdGM3Ls6@black.fi.intel.com>
References: <20221212102936.23074-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212102936.23074-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 12, 2022 at 11:29:36AM +0100, Jiri Slaby (SUSE) wrote:
> tb_port_is_clx_enabled() generates a valid warning with gcc-13:
>   drivers/thunderbolt/switch.c:1286:6: error: conflicting types for 'tb_port_is_clx_enabled' due to enum/integer mismatch; have 'bool(struct tb_port *, unsigned int)' ...
>   drivers/thunderbolt/tb.h:1050:6: note: previous declaration of 'tb_port_is_clx_enabled' with type 'bool(struct tb_port *, enum tb_clx)' ...
> 
> I.e. the type of the 2nd parameter of tb_port_is_clx_enabled() in the
> declaration is unsigned int, while the definition spells enum tb_clx.
> Synchronize them to the former as the parameter is in fact a mask of the
> enum values.
> 
> Cc: Martin Liska <mliska@suse.cz>
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Looks good now. I will pick this up after the merge window closes.
Thanks!
