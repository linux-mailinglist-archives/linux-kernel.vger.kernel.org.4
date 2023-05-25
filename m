Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09446710A84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjEYLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbjEYLCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:02:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43F19C;
        Thu, 25 May 2023 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685012564; x=1716548564;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JUZRchCrUXgDaPejlQfvti7Go2spVqBqTTI8DzIipZk=;
  b=YFcitSV7sQazdAoXzqK9xD1Ffcf7t23aP1g8v72mqd5DsqZNP28M8Ee2
   zrnJ3DT0hh1JNdpKrudd/W1kZjOnNTd+l+dMdexEefIOPYy6rCw74927m
   VjXeUVqMO42j+BIe79wuu7UKfG0kMIAXvLiizfWonpc5LGv8KSlX2ssQg
   d569LGDn+dQOJkApEXB52HHoZbFDkUxpqgXnM9TM3g2T7VXHVF0MWWwrP
   U9s5pS4/jwWF4oNtwDtkQfESSaueSby0l+IzVAKkwIgmfc4bqGnoSsKAV
   JTvjDsjWWy0ZUcdCwOE4MQCzMamiBIWrJbdXuEPcpW7A5OAa9ONTRCi8/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338430744"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="338430744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951402317"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="951402317"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:02:21 -0700
Date:   Thu, 25 May 2023 14:02:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 03/11] serial: sc16is7xx: mark IOCONTROL register as
 volatile
In-Reply-To: <20230525040324.3773741-4-hugo@hugovil.com>
Message-ID: <751bc02d-d06f-55cb-cb7a-a39871a0775d@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com> <20230525040324.3773741-4-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Bit SRESET (3) is cleared when a reset operation is completed. Having
> the IOCONTROL register as non-volatile will always read SRESET as 1.
> Therefore mark IOCONTROL register as a volatile register.
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

What is the impact of this problem? That is, what doesn't work? I only see 
writes to SC16IS7XX_IOCONTROL_REG. If there are no concrete problems 
fixed, don't put Fixes tag.

-- 
 i.

> ---
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 00054bb49780..a7c4da3cfd2b 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -488,6 +488,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
>  	case SC16IS7XX_TXLVL_REG:
>  	case SC16IS7XX_RXLVL_REG:
>  	case SC16IS7XX_IOSTATE_REG:
> +	case SC16IS7XX_IOCONTROL_REG:
>  		return true;
>  	default:
>  		break;
> 
