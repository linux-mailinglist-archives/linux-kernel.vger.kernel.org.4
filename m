Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881A85B3E71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIISAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIISAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:00:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852D6364
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:59:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y17so698322ejo.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=273KJVUIjaB1QIyJW3Sl3DHo+oLOYiNHF5nS/ot7tzw=;
        b=IsHxMtoGtIkUZBDTZGlWMRk+bjBCQwoj/WlJulDFg4ieGLjJ2pluQwpWhPIPzk1f7I
         dOJuGoOPDtXRI8VGZcyqmFOm/RfhdafwFA4r4OhV2Q/jiSpZBp0zsORsEaLFrmFfM1Ey
         eIKsVaKtwMoA0oovMecx06tskY88SG0Q/9B0VTqoVxvyityn1IrSk2lBSRr2NiEm5Se9
         HvioWL4zEm/uGDHgz7CofFAFUmdXR7yJRSmmwZxl1m0Jer/prNw9K+8QoNpIcvF1qXBz
         qocw1QpIEmYYSNSfV3SWdMhs21VulT5nRrE1NDZQcLUCzJOvg2m/VZjra/4j+LCd64T0
         eorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=273KJVUIjaB1QIyJW3Sl3DHo+oLOYiNHF5nS/ot7tzw=;
        b=jsLHTOJhEPGGtB9i3nD08XGW2HFn3jGP1gDzo/UA8qzUzJdo0rkIr+63MxvlYZ46Qt
         VFG3wLvsOPBHTS9Is7P0JCu+g1n5ai4x5Z3nCGU5jxnnmB9h6GlFmrltNYX8s1Osb/mn
         dcVai/qqb1JeEii1NZogBp53TwO0EI/CkdoiEpTEHQUD6krDjRH1pXTPuZvuz89lPMpe
         kdIMOeeoqAc0JvVns70U7oz54GZRRa9tm+pK9/X2hP796NBoR/qOn7d9bSBoWnZNmD6M
         MBzZNHy0OE2wIJ2c+XJrlxdeu8JSvrMOigI+ljqDn+Lfb3iy3/ZnrzQ9fbzltK/0Bjhi
         cAkA==
X-Gm-Message-State: ACgBeo1CemputznWM37AtxTVLmNAmJ9GzdPuFLZ4blNzMBdMw0Tf33H6
        DPLweemUE8dMYkh7P1RXHp8=
X-Google-Smtp-Source: AA6agR6edoO22IOba2dzePXDN6j6lE8PL1IxCHaW7Kp94y9dgXXrXp7bMc0Jmrci623jer6pjgyE/Q==
X-Received: by 2002:a17:907:1c12:b0:742:7a6:a1b6 with SMTP id nc18-20020a1709071c1200b0074207a6a1b6mr10461344ejc.159.1662746367364;
        Fri, 09 Sep 2022 10:59:27 -0700 (PDT)
Received: from [192.168.1.103] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402138a00b0044625884285sm719600edv.49.2022.09.09.10.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:59:26 -0700 (PDT)
Message-ID: <499af3df-5fed-91b5-9006-0ce3bac41c1d@gmail.com>
Date:   Fri, 9 Sep 2022 19:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: vt6655: fix potential memory leak
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220909141338.19343-1-namcaov@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220909141338.19343-1-namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 16:13, Nam Cao wrote:
> In function device_init_td0_ring, memory is allocated for member
> td_info of priv->apTD0Rings[i], with i increasing from 0. In case of
> allocation failure, the memory is freed in reversed order, with i
> decreasing to 0. However, the case i=0 is left out and thus memory is
> leaked.
> 
> Modify the memory freeing loop to include the case i=0.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>   drivers/staging/vt6655/device_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 3397c78b975a..a65014195fdc 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -743,7 +743,7 @@ static int device_init_td0_ring(struct vnt_private *priv)
>   	return 0;
>   
>   err_free_desc:
> -	while (--i) {
> +	while (i--) {
>   		desc = &priv->apTD0Rings[i];
>   		kfree(desc->td_info);
>   	}

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
