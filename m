Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02248710958
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbjEYJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbjEYJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AD19A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685008598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6hI85KYFXecZ4TFaVRfX5VbflWtTsorELlETNCsufk=;
        b=WTsX6YZ0hO2E0eQMDsw4wzcVX/rs4InusLreUQ9bu1+akODdPZP8IgJX1lHpCZhC2zcmsT
        gHuzSmMRa6iT7t3ueuSaWQUurj1FfscspbInhTHSR+/P8uo1OBwHMyoyqjOijh0leEfVJb
        d5PZTf05GjBW7pQhfd/n5+qPNQ/7SUg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-V2O2rwQWPXaWZhgy7WzoMw-1; Thu, 25 May 2023 05:56:36 -0400
X-MC-Unique: V2O2rwQWPXaWZhgy7WzoMw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-96fffd1ba46so43845966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008595; x=1687600595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6hI85KYFXecZ4TFaVRfX5VbflWtTsorELlETNCsufk=;
        b=Qe3ejlf5ouv7jOlIpBSAWKbRY9VKQ5zvY0tPsMfhDnucHD+Lj9O9fijqt1AT0oLZnx
         RXSeTcfyTsoqkqjZF2MLv0O77xFTxmJSZx8A2/TidDZmrZvw4e+kd87M6Vgo9rn1s2hF
         tFrKxf4/uw7Aorux9euahai/z3RBMXhrARNt4o6s7SpeVvihJ4rbWR/C98R3taYJN+ww
         pWMy4aB906CKboNhZtbXOIYfYlnnkGBnVDex2PSwzBTGpfK50tHTZWFlAn944QRSwbBy
         4nVXn7kVfyXtinOngJTPQLHR/Ggg2ANNcXbZ6ISHmsE/6zWQ2qmslml2JybaKk+uePpQ
         gLrA==
X-Gm-Message-State: AC+VfDz7z0/d1dlZQ2Vh5A3TFkZkYvCNYBE/KjNBom0jI0nTHLoki3e3
        I9PigwUJTUU0cp9PuIg2Kd+hp5ZO7gQ41m0DNKrWKZghWAjEr8UEl39igzba9Vvznng21U9OaTz
        unrwjQDFqKdv/ordQ8dvUV+t3
X-Received: by 2002:a17:907:ea1:b0:96f:6c70:c012 with SMTP id ho33-20020a1709070ea100b0096f6c70c012mr1144460ejc.45.1685008595404;
        Thu, 25 May 2023 02:56:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NxUhXTjVpSolwDAs1ytrmiQ+dWzfSSVxM7FPSpsoLypUxbCiRayn1g2CMEdlWpwI5JjAg7w==
X-Received: by 2002:a17:907:ea1:b0:96f:6c70:c012 with SMTP id ho33-20020a1709070ea100b0096f6c70c012mr1144443ejc.45.1685008595097;
        Thu, 25 May 2023 02:56:35 -0700 (PDT)
Received: from [192.168.0.46] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090614d100b009658475919csm610605ejc.188.2023.05.25.02.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 02:56:34 -0700 (PDT)
Message-ID: <98d42e27-31a3-6394-d4fc-f95f3524aa2e@redhat.com>
Date:   Thu, 25 May 2023 11:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230522115605.1238227-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 13:56, Miaohe Lin wrote:
> cpumask_weight_and() can be used to count of bits both in rd->span and
> cpu_active_mask. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks,
-- Daniel

