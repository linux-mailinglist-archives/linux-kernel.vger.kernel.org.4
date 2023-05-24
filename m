Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA970F43C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjEXKaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjEXKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:30:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E119C;
        Wed, 24 May 2023 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684924208; x=1716460208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vn5Q1SbhiGzeSmlcv4/TFQZ8fpr6DMKn7d980ADEli8=;
  b=Cwpr8nOatR6p6OZbRyNfLhwGd7SZE2kvLDP46rSHMY+io47zEUJ3t6mD
   uIdvCM/mhAh2MxsuGAGIn6g+9hxfYE0gX94ZyAmF3iJbM1Y3NEb4unrku
   HTjZTGJSth0CwxKjwkaQ33peNQ9GRfx7Vas0Uk3OX/6T5cOW0fdAlEUCv
   Sox3trq4KpOJVvaQ9IvgyB2bzFj8DhCUAiKWgwysE4cmQHgMXFBWujgx9
   DTVJoroyrW2hwGwk8COwyqFm8wYQfC/GRRYlUF6+eLHo12aQizOPY7aVs
   nOO8k4rQB1HrNz1iA7q7EJljGAjJxbjMcsE9A0MmolKf3XUrBvqogvABS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="351035769"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="351035769"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 03:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="848693324"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="848693324"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 May 2023 03:30:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 May 2023 13:30:04 +0300
Date:   Wed, 24 May 2023 13:30:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: correctly access opcode
Message-ID: <ZG3nLDeJQQTq9W2z@kuha.fi.intel.com>
References: <20230523162314.114274-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523162314.114274-1-minhuadotchen@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 12:23:12AM +0800, Min-Hua Chen wrote:
> hdr->opcode is __le32 type, use le32_to_cpu() to cast opcode
> to integer in the switch..case statement to fix the following
> sparse warnings:
> 
> drivers/usb/typec/ucsi/ucsi_glink.c:248:20: sparse: warning: restricted __le32 degrades to integer
> drivers/usb/typec/ucsi/ucsi_glink.c:248:20: sparse: warning: restricted __le32 degrades to integer
> drivers/usb/typec/ucsi/ucsi_glink.c:248:20: sparse: warning: restricted __le32 degrades to integer
> 
> No functional change.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index b454a5159896..1fe9cb5b6bd9 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -245,7 +245,7 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
>  	struct pmic_glink_ucsi *ucsi = priv;
>  	const struct pmic_glink_hdr *hdr = data;
>  
> -	switch (hdr->opcode) {
> +	switch (le32_to_cpu(hdr->opcode)) {
>  	case UC_UCSI_READ_BUF_REQ:
>  		pmic_glink_ucsi_read_ack(ucsi, data, len);
>  		break;
> -- 
> 2.34.1

-- 
heikki
