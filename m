Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014E68BD4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBFMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFMu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BA5212D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675687820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYEzzWsthRxTp8gijqWqv4ELdCHbswXqxLlHty5ZBP8=;
        b=J9NxtQ8T5Mlm+VnrZnFAVzUl5OWANRDURXgZ4p6/k5HuBpYTBlCyCeYI3C+7OAxQJDoHX1
        qyqXRd1zT6uz8Yx1bkIqSK+UCfXrVoCwY7MaXmGOho11cTuUF29IQs+SlEkaI3BJAjUgMV
        XaqHOOjLzBmISmyW7lIKr3hdgPfWqd0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-PAkUB58WPJiJ2bmBH33XuA-1; Mon, 06 Feb 2023 07:50:19 -0500
X-MC-Unique: PAkUB58WPJiJ2bmBH33XuA-1
Received: by mail-ed1-f69.google.com with SMTP id bo27-20020a0564020b3b00b004a6c2f6a226so7415541edb.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYEzzWsthRxTp8gijqWqv4ELdCHbswXqxLlHty5ZBP8=;
        b=kixQib0PL3L9JFb/aAAZQemiYQOUqssYyvlw93nWT5wnzUhNQymDNbIZg3nKhgF9dT
         5VDZvZwBXAK85A/3SfRWIYZ9M9FsJMLICvgygihdqIfRFPA98hfNxj3jCb4YkP8XOsHy
         yMFvCPdpAe8fErdikSBAKGBuYa9MC83m7HbCww9+SNq5itA4JBn8vUyoluyYwap8n4Te
         a3TGAz1n0iCL76NE3kIY7pA2GK3jyiU1VfWmNKPCKHqDOMCEiP+uiA+Xr/Bj8sMgN+RC
         CC/AJTixGXtMCx7MyTTONEvtfCnvu3oIEzCh8eRpZZI+Sf/0jezMyMm7ngrRHPURQuRw
         73jQ==
X-Gm-Message-State: AO0yUKVWQWdPuyVIw36vhGr3Rv12YeGHgDNfuKYj10AtUPonOveR6u86
        2z+k8LMWDhjNRc/7ARfASdNiQsBHA6Vo0+kNSMEol92ll1/Q03S81xEHWnEqfExGSXlHRoz5KlD
        kRqj9zNBDsVvBo1AZuPdN2eUb
X-Received: by 2002:a17:906:7fd8:b0:87b:d376:b850 with SMTP id r24-20020a1709067fd800b0087bd376b850mr19930836ejs.10.1675687817986;
        Mon, 06 Feb 2023 04:50:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9m1NdclbQ2IYh8xsEuFCHEV2zUtmdYpCc8PzUqMVk5WjAjaCRM3BeLbrBFejJ1eluuNxFbmw==
X-Received: by 2002:a17:906:7fd8:b0:87b:d376:b850 with SMTP id r24-20020a1709067fd800b0087bd376b850mr19930828ejs.10.1675687817816;
        Mon, 06 Feb 2023 04:50:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hz19-20020a1709072cf300b008847d7ed37bsm5445974ejc.100.2023.02.06.04.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:50:17 -0800 (PST)
Message-ID: <d03d0df4-5664-e732-6fb1-ac8a7c02ae22@redhat.com>
Date:   Mon, 6 Feb 2023 13:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/7] MAINTAINERS: Add entry for TPMI driver
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
 <20230202010738.2186174-8-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230202010738.2186174-8-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/23 02:07, Srinivas Pandruvada wrote:
> Add entry for TPMI (Topology Aware Register and PM Capsule Interface)
> driver.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f61eb221415b..6f3aaa7161d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10683,6 +10683,12 @@ S:	Maintained
>  F:	arch/x86/include/asm/intel_telemetry.h
>  F:	drivers/platform/x86/intel/telemetry/
>  
> +INTEL TPMI DRIVER
> +M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/intel/tpmi.c

Note this is missing:

F:      include/linux/intel_tpmi.h

I have fixed this up while merging this.

Regards,

Hans





> +
>  INTEL UNCORE FREQUENCY CONTROL
>  M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>  L:	platform-driver-x86@vger.kernel.org

