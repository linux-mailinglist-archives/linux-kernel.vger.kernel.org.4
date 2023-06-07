Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64C972549E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjFGGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjFGGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:47:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C0172B;
        Tue,  6 Jun 2023 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686120440; x=1717656440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L4HD2p8QbiMW6GGx5gom7ezNLuCrpPtc3HdETlGEmL0=;
  b=GpFtlF264g+2RkexNVG9WIAaH3jixfABa1ZtEcxutXzpH/ltrCYcw4Nr
   sKLDYfQholRnxqelUbe9KTJkDDcmGADKbfY9lC6qbwpxNXqGiS3aSXxJ8
   Pg8D0vgM2MyLX/uuYSvlk1cS9DXvXBMuQxPet6d2Aieo5VUZkvfXn5gku
   pCFxw2CDYQfZK+5eBj1rolu9ksROYnbZeAOMN1PlSHaPKjd74fNKNvtTl
   eMi80Azv/qNSmVEuFgFHWLwZZigFhGyBON5hryMGdzancXc8rFsRmay8i
   D7/SrhjnaJlafUBNVHNFE28ju893SUGZY0X2VBJewzmkYFRZwgmB7+bsf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355759146"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="355759146"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 23:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="742476143"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="742476143"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Jun 2023 23:47:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5E29534F; Wed,  7 Jun 2023 09:47:08 +0300 (EEST)
Date:   Wed, 7 Jun 2023 09:47:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] streamline_config.pl: handle also ${CONFIG_FOO}
Message-ID: <20230607064708.GD45886@black.fi.intel.com>
References: <20230607061417.13636-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607061417.13636-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:14:17AM +0200, Jiri Slaby (SUSE) wrote:
> From: Jiri Slaby <jslaby@suse.cz>
> 
> streamline_config.pl currently searches for CONFIG options in Kconfig
> files as $(CONFIG_FOO). But some Kconfigs (e.g. thunderbolt) use
> ${CONFIG_FOO}. So fix up the regex to accept both.
> 
> This fixes:
> $ make LSMOD=`pwd/`/lsmod localmodconfig
> using config: '.config'
> thunderbolt config not found!!
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: andreas.noever@gmail.com
> Cc: michael.jamet@intel.com
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
