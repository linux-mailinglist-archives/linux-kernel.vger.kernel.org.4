Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24DB6FDACA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjEJJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJJbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:31:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC7910F5;
        Wed, 10 May 2023 02:31:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f22908a082so4791684e87.1;
        Wed, 10 May 2023 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683711107; x=1686303107;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHkiT6Uiynl0Lruythe0Uk6VgeBS4SqWbF3W79uTkOQ=;
        b=XBkSADTR4TScrcB27eBtMX/nsX8ZEZDE/tSEpJp9ibkEuX1/v8nVP7uCIUvpSrolMY
         wvKD5HLh3L/64IzOnN0/CSiLBPT5zqYR2xOVhQhadzlnfWj+VYKs5MIFhGgVqaOy6USZ
         CMNg/UupDl+9Q5uvhQ3Cbo80n9zDZ8BJqSXW60SaQ8HD20mLa/YaZKRtpsaIdevWUCcp
         xjJUUO2R/vc+sqU256M0tFZiG1guQgz8Wn+4OQAJG4AwUwP+CkILhrvVjuvBCIfzLReF
         DfC4mF2r1N65Jk/YJ8RWQS9wf+nCysqBEyfUk+WRhmM0mUmWUHtnvVSKHrJlAPvDCIjj
         Rcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683711107; x=1686303107;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHkiT6Uiynl0Lruythe0Uk6VgeBS4SqWbF3W79uTkOQ=;
        b=GQ8E+iCKoCMwpLYkK9YzPKs/aEfIEH8m6IfRumiB2srOpzhLBheEh4ZHULHSnULGW7
         bxniAc25ySWIfnxp2xKkf6GkfNGfU1ujkxaqiIY93NkelIA3joTtvvDM6NcPtLy1KerB
         FLmgKPx9+6SUOsoUGhgkZ6VLToPNksyOPwGeHuI/rVsM5Czp7qNH2wYzUkGmVwzEAZ4N
         mcZPDaPh8QJ8djwDDoINSfHJ3QKzzSo0k021ExlMnQzzQkFfN6zDBg604aR17CMxW/ca
         Jz9bWk25LlkDeRR5j5xJ5Eux3ZQbDM0pTkTrxdoV/ZBv3opFnkK9n3hD6ELULMJCbbnH
         D3Vg==
X-Gm-Message-State: AC+VfDxeHvIWDLZU7XB1L1vt19Us2/lVIRvjCEyLyGIDkIGk4ZDl4cqz
        nNQgzHaxAFqEwtNZtnARLZYVU1WT4vg=
X-Google-Smtp-Source: ACHHUZ7Gr1dzdpi5ADr+OqFL1vY/Srp+tgQIV00ug9sEtf+f3XhebE+tndbF72z8KvuaD5cdNdyoUw==
X-Received: by 2002:ac2:4c8a:0:b0:4dd:af29:92c1 with SMTP id d10-20020ac24c8a000000b004ddaf2992c1mr1391092lfl.44.1683711106673;
        Wed, 10 May 2023 02:31:46 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.86.195])
        by smtp.gmail.com with ESMTPSA id v15-20020a056512096f00b004b55ddeb7e3sm667654lft.309.2023.05.10.02.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 02:31:46 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com
References: <20230510075252.31023-1-quic_kriskura@quicinc.com>
 <20230510075252.31023-3-quic_kriskura@quicinc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <cb8c326c-b2b4-2fe8-cdfc-f78908b1d1bd@gmail.com>
Date:   Wed, 10 May 2023 12:31:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230510075252.31023-3-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/10/23 10:52 AM, Krishna Kurapati wrote:

> In the event, gadget_connect call (which invokes pullup) fails,
> propagate the error to udc bind operation which inturn sends the
> error to configfs. The userspace can then retry enumeartion if
> it chooses to.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> changes in v3: Rebase on top of usb-next
> 
>  drivers/usb/gadget/udc/core.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 4641153e9706..69041cca5d24 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1122,12 +1122,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>  /* ------------------------------------------------------------------------- */
>  
>  /* Acquire connect_lock before calling this function. */
> -static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
> +static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
>  {
> +	int ret;
> +
>  	if (udc->vbus && udc->started)
> -		usb_gadget_connect_locked(udc->gadget);
> +		ret = usb_gadget_connect_locked(udc->gadget);

   Why not just:

	return usb_gadget_connect_locked(udc->gadget)

>  	else
> -		usb_gadget_disconnect_locked(udc->gadget);
> +		ret = usb_gadget_disconnect_locked(udc->gadget);

   Likewise here?

> +
> +	return ret;
>  }
>  
>  /**
[...]

MBR, Sergey
