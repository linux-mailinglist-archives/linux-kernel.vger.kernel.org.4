Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE7645B28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLGNlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLGNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:41:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061C59176
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:41:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kw15so10627015ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtuzOfw0Oi0U8E5fGsLC9amop5MnEpGVuaEzshiOd2A=;
        b=MoXad6POrKxM+1W1tpTYK0V/OAfkJ8/5ZfglWKfn4OVK/dpJoQLI30qKWoExXjVwk9
         TrtW4BntvSL0vTXRWLgwSKj1aue+B6dTv5RSUqJC5REBoEkHXPuzGUzEm4A/ELWfaC4j
         82d0N+kvsP0Y+Dex9cozH/7hs8zcFLpJWihpWHZqTtQx9RapuP2cVBnEwlNbeSY17aqe
         vNKK7Jn/7HNKVBZ+own0ke+EPRJ0b2Mo4yur7rVyW/PAsjCBNT/mOi7Kss0B4D/dYlnH
         m9opYgalLf8pL6RjStNmYJITFDDRuG8BBf++X4UTY6OpI1IFjyKok3eA69fDsYuKsKIi
         WOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtuzOfw0Oi0U8E5fGsLC9amop5MnEpGVuaEzshiOd2A=;
        b=TlNYKg0lnc7n4ihIN7eWFftVoiBF8z0r1ySTsVmdaH8FAgdDmkgaPyG4s3krUxP99k
         99SsWhraxtjZb+81JHmYrVfVm5L0T1mblSotSvcoxozui7USjHL3fu8tvVU3oGL4hAVq
         SLPQF0vY4JG+4UKwYjfpP90BaWlWWsSgZw7yYtqH4dKy8dtNHRdGI17/ao+xfzzHvPYS
         oAy5N1CN4tve6BeCDAgdFuPOW8fI4GQVkDIB5xwFS2GMdYUdUA+9j3TXkAU0jGvz44o+
         cb/uqseoEURUqLACUxUyGNWb8cBcGrCWWK4OToDUAxjTPcnxuoBxw70fBZyxlDIqR4J/
         nDfQ==
X-Gm-Message-State: ANoB5plrhw/YNrxN4yzlu/cZADkuZBtT37CQ4xxJbTki00pb/UpNaYiU
        IeCwevjBn3Dy8uCaH7GtabxcOyIvy5b6cAXgC3w=
X-Google-Smtp-Source: AA0mqf5lc/G1mvDAUTXao/P5lwqse/TLFm614gQpaRxZzlpXx2ryyaZOP6NYha22JQyxFjAI4elmaA==
X-Received: by 2002:a17:906:a209:b0:78e:ebf:2722 with SMTP id r9-20020a170906a20900b0078e0ebf2722mr73484504ejy.490.1670420475980;
        Wed, 07 Dec 2022 05:41:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b007bc3a621224sm8561495ejo.196.2022.12.07.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:41:15 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:41:14 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Add check for kzalloc
Message-ID: <Y5CX+kYKoXeDppNT@nanopsycho>
References: <20221207022000.44043-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207022000.44043-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Dec 07, 2022 at 03:20:00AM CET, jiasheng@iscas.ac.cn wrote:
>On Tue, Dec 06, 2022 at 05:47:01PM +0800, Jiri Pirko wrote:
>>>As kzalloc may fail and return NULL pointer,
>>>it should be better to check the return value
>>>in order to avoid the NULL pointer dereference.
>> 
>> Okay, so? Be imperative to the code base, tell it what to do in your
>> patch description.
>
>OK, I will describe the changes by the patch in more details.

It is not about details, it is about "imperative mood".


>
>>>@@ -462,6 +462,17 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
>>> 					       GFP_KERNEL);
>>> 		pf->gnss_serial[i] = NULL;
>>> 
>>>+		if (!pf->gnss_tty_port[i]) {
>>>+			for (j = 0; j < i; j++) {
>>>+				tty_port_destroy(pf->gnss_tty_port[j]);
>> 
>> You are destroying port which you didn't call (pf->gnss_tty_port[i])
>> for. Also, you are introducing a code duplication here with the error
>> path couple of lines below. Please convert this to goto-label error
>> path so the cleanup code is shared.
>
>I will convert this to goto-label in v2.
>But I have a question that the j is from 0 to (i - 1), and therefore only
>the initialized port will be destroyed.
>Is there any wrong?

You are right.

>
>Thanks,
>Jiang
>
