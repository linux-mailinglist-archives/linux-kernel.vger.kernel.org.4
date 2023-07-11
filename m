Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654C74EC75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGKLNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGKLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:13:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F889B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:13:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so63353905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689074005; x=1691666005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLCSxIig1E6lDTEDhD9ibzAe8m3WEahllr3ouLgYn1c=;
        b=nzLVIA+PTb3SSi7DlWsGUsWL0rkRaezLG67wZ9+BrJp3AN5vFhk9E0dU6Vk52JEQKR
         2vLUlE/D2AteRhGj4dkHYehNCRxLhFq+LUlYcCZRPHvbm7eEpmU7fLT2U9Csc3sEues6
         t05grkaVvaeeg8n1TVm5MNd9z8nH1MAqcyU2CaWLXISalkxxjV7Xe5gxUKR9QmNOlkk+
         h+XoqvVHH6LnqoYvxTnbG9LNgn0+TDx0w9g8VedeMKOc+HEFDuU9xw36PM00it1+SSCA
         n5zaeQuoXryACKo6BTsqMOjcASK3ca8qDzOvq31ASaP592CcVNBYtvPlMOA4eKVY6img
         jBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689074005; x=1691666005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLCSxIig1E6lDTEDhD9ibzAe8m3WEahllr3ouLgYn1c=;
        b=VSbGlWbyDIvkU0iHGXwVx/ZlrelWEtRSKdCOcCk1IzCnfj2JPKDaMxGU8xuV7oKprh
         ZI6uxfn1T/p2p489S0sN1/uKZVN6J3MXkg3PT75z96N2bDIaHqC6aGEJWO0PBtU9wJu6
         f2Y/04ReFeiVuHCIBnACA4dJHVXjfZ50x3yzVtpT+gLPzw8c/fSoGmpsZ+tlCyiUjFEt
         W6Imtq3/J/GyZTg+kUtD4advpsfG6Ok+olEgGkFFg99IN5YeIzlT7iQD1KiB/RDjdtDD
         NW69uFmL7Cn3CgzXNXt3ioXIqjs5QN125fRJAjkZuPVqInk/iGOmioBkaeoubBVcp2ih
         D6iQ==
X-Gm-Message-State: ABy/qLY940d6WRb3weUlcK5vlD+L3fXrhb+3l+v0SDc+sw0JA4yLK0lu
        V+7Rw0KaiB4OjRsNtS/SoIdzWQ==
X-Google-Smtp-Source: APBJJlHUs43WSGSKNzoDZD3KQlU5rLMuF/7dsLdNmMbgfPJIjEa2I2xQi/A5h+V8aI33ZuQwpwX8Uw==
X-Received: by 2002:a1c:f706:0:b0:3fb:b637:22a7 with SMTP id v6-20020a1cf706000000b003fbb63722a7mr16506974wmh.4.1689074004968;
        Tue, 11 Jul 2023 04:13:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c225300b003fbb0c01d4bsm2259571wmm.16.2023.07.11.04.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:13:23 -0700 (PDT)
Date:   Tue, 11 Jul 2023 14:13:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
        olvaffe@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: remove some redundant code
Message-ID: <7f67ed65-647a-44d7-a262-d3f1f48d90b9@kadam.mountain>
References: <20230711090030.692551-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711090030.692551-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:00:31PM +0800, Su Hui wrote:
> virtio_gpu_get_vbuf always be successful,
> so remove the error judgment.
> 

No, just ignore the static checker false positive in this case.  The
intent of the code is clear that if it did have an error it should
return an error pointer.

regards,
dan carpenter

