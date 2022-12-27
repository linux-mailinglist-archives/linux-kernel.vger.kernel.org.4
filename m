Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550E365687F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiL0Ih6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0Ih4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:37:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C31D7;
        Tue, 27 Dec 2022 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672130276; x=1703666276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JdaJO+fkzogC42+/Cx0uzxpw8R6GdnStKstxrzQC840=;
  b=CTZxoLaPEn3qMHspEUiYL1sVj9gOPDFewbqwuESqXmtuapYv3XeJbccg
   wWgJSDHxW3ABdkRzarDyAR6XOqYYl554JycoxOGggC2nRO2uV6dZ+fSTw
   KDFF7gip+rmS6OzT5+KkuBlv+Xektshv5mwfKYizxfy/B96ElonAHrG+7
   YyPrbBZVwRM6DJ9exdnM6Oe9FkUIpa3WQDWDWkP8h/MzBKCKiCY0KPLmo
   fWXJL2qzzcwlJLoKxnhpvHqkUr4y8fRz8e3/zPQyAyPFFWK71pzdHTmGR
   LBqU+PNVThOlrYzkNkEtvaX8AdB6MekTiwrqUeaktt6VsQc5Uwfod7NXA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="385090269"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="385090269"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 00:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="760268759"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="760268759"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 27 Dec 2022 00:37:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7B985159; Tue, 27 Dec 2022 10:38:20 +0200 (EET)
Date:   Tue, 27 Dec 2022 10:38:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt (gcc13): synchronize
 tb_port_is_clx_enabled()'s 2nd param
Message-ID: <Y6qu/MeTAwqZURDg@black.fi.intel.com>
References: <20221212102936.23074-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212102936.23074-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Applied now, thanks!

I changed the title slightly to avoid words like "synchronize" because
that makes me think this is fixing a race condition somewhere but in
fact this is simply fixing a function prototope to match the definition :)
