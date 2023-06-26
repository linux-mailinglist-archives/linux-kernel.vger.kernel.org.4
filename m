Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19F73D945
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFZIM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFZIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:12:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B795;
        Mon, 26 Jun 2023 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687767130; x=1719303130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ns/4/u3WBXGnVF2I2EuAZvqrfT4RbnnVjzxvtkNfXE=;
  b=bAEgZlNGIe3x8MLt1kA/DiofLJl2o6JTuGqcPq7XVdfWGXoCf+QnJFSW
   r84z2y8yJ9Fzjx6fpTEqlBOubc3EWZfwuAwr78KK8x3AHN67oceiYExto
   0aVBziB3ISlAou9r9RxCQcOo3TwEoRy22X8e537ECWmgmQpwMP+DYj/6C
   xvm6AwNPOMZUII+x3tmUFQSoVLxpKdGfqVGQpoU4NU5JVk/DCDRoeNMf3
   ynaX2hUqjRiOYq6/pkDM/WTpCVQh5OkrmXSeFn8RoCb+N3PM4nLfGQRPP
   mBgC+i875hztWWOSsxWyz8s8kkX47rPXiV1GzObkYOl+aMnlPxU55V1gp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447589501"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447589501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860597303"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860597303"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 01:12:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 11:12:06 +0300
Date:   Mon, 26 Jun 2023 11:12:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: ucsi: call typec_set_mode on non-altmode
 partner change
Message-ID: <ZJlIViwb9sfNrgjH@kuha.fi.intel.com>
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
 <20230614-topic-sm8550-upstream-type-c-audio-v1-1-15a92565146b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-topic-sm8550-upstream-type-c-audio-v1-1-15a92565146b@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Sorry to keep you waiting.

On Wed, Jun 14, 2023 at 03:10:39PM +0200, Neil Armstrong wrote:
> Add support for calling typec_set_mode() for the DEBUG, AUDIO
> accessory modes.
> 
> Let's also call typec_set_mode() for USB as default and SAFE
> when partner is disconnected.
> 
> The USB state is only called when ALT mode is specifically
> not specified by the partner status flags in order
> to leave the altmode handlers setup the proper mode to
> switches, muxes and retimers.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 2b472ec01dc4..44f43cdea5c1 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -809,6 +809,23 @@ static void ucsi_partner_change(struct ucsi_connector *con)
>  		break;
>  	}
>  
> +	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
> +		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
> +		case UCSI_CONSTAT_PARTNER_TYPE_DEBUG:
> +			typec_set_mode(con->port, TYPEC_MODE_DEBUG);
> +			break;
> +		case UCSI_CONSTAT_PARTNER_TYPE_AUDIO:
> +			typec_set_mode(con->port, TYPEC_MODE_AUDIO);
> +			break;
> +		default:
> +			if (UCSI_CONSTAT_PARTNER_FLAGS(con->status.flags) ==
> +					UCSI_CONSTAT_PARTNER_FLAG_USB)
> +				typec_set_mode(con->port, TYPEC_STATE_USB);
> +		}
> +	} else {
> +		typec_set_mode(con->port, TYPEC_STATE_SAFE);
> +	}

Can you do that (set safe mode) in ucsi_unregister_partner() instead?

thanks,

-- 
heikki
