Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627B35BDF54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiITIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiITIHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:07:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A765800;
        Tue, 20 Sep 2022 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663661058; x=1695197058;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LDmwkAU000T6mLap+2OX+lzhHFSGTgusUbXuvHtm0z0=;
  b=AxUIS/gxQKZzafwefou8DvkyRiQEnlXfKPhrS+2v8mINRzwYElgj9Yrx
   xJcEtq5sQmTixSfVOk7tDwg5ZMKDvSAlMn2gUX+QYv53MUE9/OKNSS5YN
   TpKueCN7fGU+t3CwCBZ8mivc3lsUmIhx99HVXfRfOpSMcYBBqxlU2+BVv
   oai2VbSTDaLj+v7EC41/xO9r570NhfYReqHx2GnuIPdch/Av3ZYzSY3JJ
   B/8MwuKFpqAPiPAMdl91MITtW6id5bWRjRpAX9EybwRKvWtdNQnJE586j
   57lat8tDaqe5Lo4SfdN6GSvPUjAgd3780jbyQ71GGdKBia3t1+tNAaM5b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="286677793"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="286677793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:04:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="649486121"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:04:15 -0700
Date:   Tue, 20 Sep 2022 11:04:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 03/10] tty: serial: altera_uart_{r,t}x_chars() need
 only uart_port
In-Reply-To: <20220920052049.20507-4-jslaby@suse.cz>
Message-ID: <259b72f4-21d9-7575-784c-63b534e7a9c5@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-536135200-1663661056=:1766"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-536135200-1663661056=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> Both altera_uart_{r,t}x_chars() need only uart_port, not altera_uart. So
> pass the former from altera_uart_interrupt() directly.
> 
> Apart it maybe saves a dereference, this makes the transition of
> altera_uart_tx_chars() easier to follow in the next patch.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-536135200-1663661056=:1766--
