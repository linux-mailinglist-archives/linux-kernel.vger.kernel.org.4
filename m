Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD76690FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBIR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBIR4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DEA5C8BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675965348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oa+ktop1BYES3skoN4AMzzvadGJgLPq6XyHc2PRg6eM=;
        b=F3xvmgQiou8WHG8OHZG1eA4n+d+47t4Agjqb17B3j8ejptz7RtTvLcnFrR8CsIj619sJn/
        etj5vCKC5gXOYwPq+/D0+mnTnAK6a0goi7yaTyJNa83/uZwUcPSDZ5wxuNIBx2tol6ejgV
        UnKj8LV1hmWsHkb8YUkfdjOwPJiAhEo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-XIyk3TxoMYGzVQoQe-YO3g-1; Thu, 09 Feb 2023 12:55:47 -0500
X-MC-Unique: XIyk3TxoMYGzVQoQe-YO3g-1
Received: by mail-qk1-f199.google.com with SMTP id ay10-20020a05620a178a00b0072db6346c39so1709784qkb.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa+ktop1BYES3skoN4AMzzvadGJgLPq6XyHc2PRg6eM=;
        b=mIQwBW4yBuDGXWGzPin+AnnXDiXPEIwcVQh3PkXw3hsgIMq3DgMz8+Kb67v+0KjBrN
         EBmrALpzkscN1uoA/FgLzRcn5uKYzlOrI1elWBW1sK0xC3/LW3p4tTJl5wZK2jtzUmkK
         F5mq7zEY0LWgbEwPEKHmI3eV/rlsMUjk8XgnOrnDus5vBekL1Of2glxjr6C/rp22tPTQ
         uXoKqTorqo2w0FfvSvHKoatbNCENqBvxJAt9uoBqQnrjrQvZ8IIuKpoKncNZ9N9M1qgU
         UgNv5Rxv7VkLNXTTd3SYH4DuTEby1bXHAZHu/Irnxess6bPtCFmKfs1XtPaaGKRsBdpW
         z1dg==
X-Gm-Message-State: AO0yUKXf7yrP+BnPC6K0WcwpI4XyiCVFLLEaDqFO3E33VjWF/0mKFM5o
        XNowW0fRcHccJ89h3oQiz37Vqg3qZvwtjVaGJtNaLMS0pT0SkX3DQRii+Q4L6tZbGWLURGFIRnR
        DknG8zalVvp4YCc31cCV0cyxm
X-Received: by 2002:a05:622a:1191:b0:3b9:d14c:39f8 with SMTP id m17-20020a05622a119100b003b9d14c39f8mr21105984qtk.40.1675965346665;
        Thu, 09 Feb 2023 09:55:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/EOyziLvc75r9JFsPQJzCXaNqdElWwIHMkkLhHIshpbF9jdVnZnANxp7Vy1J0R/i+ywQXWzQ==
X-Received: by 2002:a05:622a:1191:b0:3b9:d14c:39f8 with SMTP id m17-20020a05622a119100b003b9d14c39f8mr21105956qtk.40.1675965346477;
        Thu, 09 Feb 2023 09:55:46 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0072c86374ddfsm1790776qkd.71.2023.02.09.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:55:46 -0800 (PST)
Date:   Thu, 9 Feb 2023 12:55:45 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/3] soc: qcom: socinfo: add support for SA8775P
Message-ID: <20230209175545.zdbmqonumht7fzbo@echanude>
References: <20230209095753.447347-1-brgl@bgdev.pl>
 <20230209095753.447347-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209095753.447347-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:57:53AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add SocInfo support for SA8775P.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Chanudet <echanude@redhat.com>
Tested-by: Eric Chanudet <echanude@redhat.com> # sa8775p-ride

-- 
Eric Chanudet

