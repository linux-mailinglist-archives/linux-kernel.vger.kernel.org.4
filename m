Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529E45F41E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJDLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJDLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:22:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675A829374;
        Tue,  4 Oct 2022 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664882546; x=1696418546;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zV6XaQw7cFV+W0fZ4qt53I+U/j7E5pxnhTY/GN5mI2c=;
  b=FfK6gHFLfqWK3EtfEhy4oTNPvVUHY29mC98YH+DJGoZrm/DVRRyojCS7
   jywZSSVVuSumK20I57wTlhtS+qKbm2yyYTBrT6cd/cQyNbCIYk7MQoTfl
   cC+/LqtkQAhhDSR17OvjPZpTH41hIqQFsy8tVqUcWAOvaTJ66I/g1RE+N
   VCeU9D482MsWUm9AqlhX9o7ibjxzeGi56lDO4VstZsXG4ms9xxVcUZnG6
   MOPKN5c9HTkirEMrPM2olxWW0iGedRVo4Waar5fDf1vVWJ8UzRg1yoqez
   UHAY65LUeMYPjiba1iaqjOwqYCD1kH05GKsgQZHv0P5tXiTM7vJOd66Z5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="290105399"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="290105399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 04:22:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="654737955"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="654737955"
Received: from kmreisi-mobl.ger.corp.intel.com ([10.252.39.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 04:22:19 -0700
Date:   Tue, 4 Oct 2022 14:22:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] tty: serial: use uart_port_tx_limited()
In-Reply-To: <20221004104927.14361-4-jirislaby@kernel.org>
Message-ID: <ac4a5f21-fd2d-6981-eedd-1bca72a9237a@linux.intel.com>
References: <20221004104927.14361-1-jirislaby@kernel.org> <20221004104927.14361-4-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2081053952-1664882543=:1585"
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

--8323329-2081053952-1664882543=:1585
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Oct 2022, Jiri Slaby (SUSE) wrote:

> uart_port_tx_limited() is a new helper to send characters to the device.
> Use it in these drivers.
> 
> mux.c also needs to define tx_done(). But I'm not sure if the driver
> really wants to wait for all the characters to dismiss from the HW fifo
> at this code point. Hence I marked this as FIXME.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Perhaps you missed this one in the earlier mail. ...Anyway, here it's 
again:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2081053952-1664882543=:1585--
