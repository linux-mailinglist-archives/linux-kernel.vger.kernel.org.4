Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540B75BDF50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiITIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiITIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:06:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B90E642E1;
        Tue, 20 Sep 2022 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663661013; x=1695197013;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7owMPWYTYzQF/jdc0DQumQQdh/FX8zgVR5aMD6KlqOY=;
  b=MrYblQfpvV38hTKUmKBxCIy6J7EXJIthFK4dgdmRYySU3jH32IvUqVWx
   KBhZL8YPMjXKF+VJmVkkY7Op8eWPcAfqsU2E4sKIvCqteubLor2OyvVmO
   G6P7jVIsTv0qq0c7PEHFzaJ2Zkc9cd6mT3SyivOSwFgsSRP8CBswINVcf
   E3d8TDZogJR0eq3CoDhqZ/UJi8Y/UiMQrljO2BLfC2P+28qBrtBGIc8qA
   +kaMUFjHJL9V/PnNgZfmnV85hHFHQdp1Gdb4XF99N8I/jurwEQtAEIiMd
   6Vu/ITzB9tH0nn99Cty+78Q/uNyDmgz4dyy8MUTvHPn/UfGKpKWnKZjwZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279356116"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="279356116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:03:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="761207120"
Received: from bdallmer-mobl.ger.corp.intel.com ([10.252.59.238])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:03:28 -0700
Date:   Tue, 20 Sep 2022 11:03:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org,
        =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 02/10] tty: serial: clean up stop-tx part in
 altera_uart_tx_chars()
In-Reply-To: <20220920052049.20507-3-jslaby@suse.cz>
Message-ID: <de61dd2c-f452-9d6-41b5-77ad68eacf86@linux.intel.com>
References: <20220920052049.20507-1-jslaby@suse.cz> <20220920052049.20507-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1001280159-1663661009=:1766"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1001280159-1663661009=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 20 Sep 2022, Jiri Slaby wrote:

> The "stop TX" path in altera_uart_tx_chars() is open-coded, so:
> * use uart_circ_empty() to check if the buffer is empty, and
> * when true, call altera_uart_stop_tx().
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1001280159-1663661009=:1766--
