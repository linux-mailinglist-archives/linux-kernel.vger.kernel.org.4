Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770D1743C07
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3MjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3MjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:39:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107EBED;
        Fri, 30 Jun 2023 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688128758; x=1719664758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9JFsKVgRGsIvIRB2Q5vucWs4VLbp1cDbASzqdun9B4=;
  b=Z662+asxUCwszNXB+zYS4UOVDPXnT00gAYnd51yCFf0b8DwOXlchiVrE
   bWJyX4PCZHF/sAl9u6m6UfXW+eFZ3+btLxvfbQyDb9+1woRNyhCo3jSSc
   XffojHoax85zE7Xk29zzaCNpeuTauIE9PLFHkdPf+RleCn5xeeI6h0XLR
   e0LC4NR/JOyOjOFU5hYnAcUm70l2IlmX868mdHDGbLTWLlHDmy9FH8SR7
   wpNWp1s5OSFzwp7aEvk+cryFchz/aHO5HwukUyVb0rbwqxmiipC3Fb976
   fvUYMv/v/+3qkbwwa11m4LEptYnTjH9Hq5PvPa6rvDN1mHJ2Oj0z8ulSB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="448760439"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="448760439"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="862280256"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="862280256"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jun 2023 05:39:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Jun 2023 15:39:13 +0300
Date:   Fri, 30 Jun 2023 15:39:13 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: Set port->pd before adding device for
 typec_port
Message-ID: <ZJ7M8T9q2oGGvuam@kuha.fi.intel.com>
References: <20230623151036.3955013-1-kyletso@google.com>
 <20230623151036.3955013-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623151036.3955013-2-kyletso@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:10:34PM +0800, Kyle Tso wrote:
> When calling device_add in the registration of typec_port, it will do
> the NULL check on usb_power_delivery handle in typec_port for the
> visibility of the device attributes. It is always NULL because port->pd
> is set in typec_port_set_usb_power_delivery which is later than the
> device_add call.
> 
> Set port->pd before device_add and only link the device after that.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
