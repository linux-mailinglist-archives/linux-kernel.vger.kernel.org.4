Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D126E768C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjDSJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjDSJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:41:31 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA751387E;
        Wed, 19 Apr 2023 02:41:13 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f1754e6ac2so4822515e9.1;
        Wed, 19 Apr 2023 02:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897272; x=1684489272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrbQ52WnCDEzpuP7mp+Xy8URjdCv/Ow5DtS1hYS2qVQ=;
        b=KI7kXz3RVeQyr7Xi2TDWwntQGUR8xuJ+AQMLE7DzUtiUDPYgv3Y6CFkfhRFjDJ8Itv
         PfBuFhYnba4gF1O3ywQl+4YfJkkPb9MUdRS3Cx5nVarwNRm411SYbYU8ciVrl/6rmXxJ
         Cl16JMLxKAJBEg9ZLTdRfzE62UEHJgff3ONUPFLort3y7ZOS7r+drzwaMG8BYQ4aRLuC
         RV+4bp4It8KPdzJn8GkqBeKoaNTZy8nVKXaWhBOOe8JuwlCLqfttSjFt+zeNWSN3lX0o
         OiMQblrZjoCF+D3LVUb8dCivwGzTFmGe/syniv1iF+kcp5n+yvgJBJPSXPTbC+ClY+1L
         1w7g==
X-Gm-Message-State: AAQBX9dF6C1mdeRxaZ60jNo/uXXT9cKo7WnOYPGB43fqnM5dZ4g0zaZN
        u1TDhNWckOvaWJr5TGKa1BZO2aCyq7I=
X-Google-Smtp-Source: AKy350YN/Rf2SZ1ME0rb1VR3LA6oyESPfK71x6IS5j3OPheOdpplpGnd4DdvemgbvhcXY4+S55JHBw==
X-Received: by 2002:a05:600c:310e:b0:3f1:78bd:c38b with SMTP id g14-20020a05600c310e00b003f178bdc38bmr4795553wmo.4.1681897271920;
        Wed, 19 Apr 2023 02:41:11 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003f0aefcc457sm1608734wmo.45.2023.04.19.02.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:41:11 -0700 (PDT)
Message-ID: <a58b526d-2e29-6c4a-e277-b684f98636eb@grimberg.me>
Date:   Wed, 19 Apr 2023 12:41:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse
 order
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-2-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230419084757.24846-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/23 11:47, Daniel Wagner wrote:
> We need to free the resources in the opposite order as we allocate them.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index b44239446dcf..ec0cc2d8d8cc 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -204,10 +204,10 @@ _cleanup_fcloop() {
>   	local remote_wwnn="${3:-$def_remote_wwnn}"
>   	local remote_wwpn="${4:-$def_remote_wwpn}"
>   
> -	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> -			       "${remote_wwnn}" "${remote_wwpn}"
>   	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
>   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> +	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> +			       "${remote_wwnn}" "${remote_wwpn}"
>   }
>   
>   _cleanup_nvmet() {

Does this fix a bug? if it does, than it should probably be documented
that there is a driver bug because userspace teardown ordering should
not trigger a driver bug.
