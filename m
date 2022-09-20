Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4755BDF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiITINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiITIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1676555B;
        Tue, 20 Sep 2022 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663661473; x=1695197473;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NpXFnndhkQG9hC09OmD04EE4e1t8OODVtE0sPkSoK7I=;
  b=DmJcOwMqeZRFmOxuome3v/k3B7g/1+epzgEhkWX7SAvXTTJXnbu3xrF4
   t6VFZF99fE/21FHqz33JnN229ehuwBpQ6c5cTNvCef2RBI0GuUyamyvV1
   G/Pzi2AUhENxsv9N+kielpsMrZ7XmyUE874W/XeO1chZLuGjDqsGu2IRQ
   snVljn7OxOhsOCSrvrvneLSNfrAKaXBJB7VD7VCEjcK8QAlE7MTYUxLOw
   m2QlfvHFHczYD5XybWlcBxo8pAWLt9Ju30Pe1/RUznTRYuCnkXouYnwod
   XhllsKs2Qdb62ma9BlZfMjsT1uos10MFNDCoRkY0ThO+hJB8g4QDPccQ5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297222696"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="297222696"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:11:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="614304129"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:11:10 -0700
Date:   Tue, 20 Sep 2022 11:11:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/10] tty: serial: extract tx_ready() from
 __serial_lpc32xx_tx()
In-Reply-To: <20220920052049.20507-6-jslaby@suse.cz>
Message-ID: <3c92a9b4-c531-d960-a3cd-827c42f7f48e@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1092543553-1663661472=:1766"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1092543553-1663661472=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> The condition in __serial_lpc32xx_tx()'s loop is barely readable.
> Extract it to a separate function. This will make the cleanup in the
> next patches easier too.
> 
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I noticed that wait_for_xmit_ready() uses < 32 for the similar check 
which seems fishy...


-- 
 i.

--8323329-1092543553-1663661472=:1766--
