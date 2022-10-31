Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49196135E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiJaMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiJaMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:20:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94CBE30;
        Mon, 31 Oct 2022 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667218799; x=1698754799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+P60X3IgMg3iYwoWyATV+RqcqI07sfegPr0ApUl2Jbo=;
  b=bEG0bGCX/jbXUR0YB+aO7Fuk6tI6slwNhJW7KcI6H0xXScX1R/VQQwPR
   53hwsgBzMWdBJqopUxBMH26BIkdXqcQBJ1A+iB5ohtsry69e3mAJ/60Mn
   itXNBztPRsXrYxcdoLYvkXaf3vaFulMDAsMgloo5Nw9JWF5fkPLs8vIoO
   r28RMaDGKirioh5esnmLUKpmwin9jT2oGW6/7CHwk73T0hoe2Thfl15Fn
   1M/vwAbyJQmzI59jdQ8KisUB58hH7s470K5+XzNZZbX84CqjR64kWA63v
   MfM/uYtGkchwVSdDvJYkp0ILv971Q6mprUks5SjFqgC8SsonY19zwUUCH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="373094862"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="373094862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 05:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="776114148"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="776114148"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2022 05:19:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 00105107; Mon, 31 Oct 2022 14:20:19 +0200 (EET)
Date:   Mon, 31 Oct 2022 14:20:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     andreas.noever@gmail.com, linux-kernel@vger.kernel.org,
        Martin Liska <mliska@suse.cz>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt (gcc13): synchronize
 tb_port_is_clx_enabled()'s 2nd param
Message-ID: <Y1+9g7jgDY9Opg10@black.fi.intel.com>
References: <20221031114323.10356-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031114323.10356-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 31, 2022 at 12:43:23PM +0100, Jiri Slaby (SUSE) wrote:
> tb_port_is_clx_enabled() generates a valid warning with gcc-13:
>   drivers/thunderbolt/switch.c:1286:6: error: conflicting types for 'tb_port_is_clx_enabled' due to enum/integer mismatch; have 'bool(struct tb_port *, unsigned int)' ...
>   drivers/thunderbolt/tb.h:1050:6: note: previous declaration of 'tb_port_is_clx_enabled' with type 'bool(struct tb_port *, enum tb_clx)' ...
> 
> I.e. the type of the 2nd parameter of tb_port_is_clx_enabled() in the
> declaration is unsigned int, while the definition spells enum tb_clx.
> Synchronize them to the latter. And do the same for
> tb_port_clx_supported() where the enum is propagated.

Actually in both places we want to have bitmask of possible states so I
think unsigned int is the right one here.
