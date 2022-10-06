Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE85F69D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiJFOkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiJFOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D68A9A9F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665067217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+tXcwSOV4d4EWIv9hMkfRyVLOs87m6DQEHcwhzbxwE=;
        b=hztYbzUMbbtrC7+Xr6nf2C+vama1M8DDI+lNdEuJn5Wt142mfwhSfvHckeTPktT/bwoB2A
        MSedFXUUl7khR+j2V8ZPrjZGPeSLG319YDrxx5uf8msd6qIwjBu9ALHzKumHVL8madgRvU
        vR6i8F2B2tSYQ6rWzCLDguLsXMdq2v0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-UDXB2-NMOQG24sLvTkhkBA-1; Thu, 06 Oct 2022 10:40:16 -0400
X-MC-Unique: UDXB2-NMOQG24sLvTkhkBA-1
Received: by mail-il1-f199.google.com with SMTP id j1-20020a056e02154100b002f9abf53769so1669639ilu.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+tXcwSOV4d4EWIv9hMkfRyVLOs87m6DQEHcwhzbxwE=;
        b=xZ05IPOXa/+u8Urtnfc5QQy6w1h7OGQEkx6jVjjF0XaHG10euWsKXoVhLlkDlwxSGl
         7Odfq/yI7ZSHt+0NeueZeKCYidQFCYnDUTQrUAPE527ILWDanO9nNYjR1zZkDpiYhxUp
         HIRWVZkPEbNJs1Jv6TlOOkQHXRAYUigFDVvUGbNrI8iwbmbJ8FgbXkCp3/CzAPKtdF/l
         R3uI7V5/FXwVXfkbQZk2qIjlYxcYUv/uo3rGelyA9MgMLhZbCQNGJ2HUk9l9HrIAs8Vz
         DCF7fcQ6Edj/BYYfRRrzbfgL9NBUDKbef21evTYCwaBOaMAc6orgYPJ8q7+h9jheOl1n
         tGBw==
X-Gm-Message-State: ACrzQf1h2jmj9UULb/Dvqdh/s+YDWBYNA1tHe2pyoIE8Fvao4GR246uC
        tvn7RYgNqXZPEHOL8ghM3WNGgJOJS0YZ+6x+i255KbDMvEkLaTs8sBA01Qfl/HEIHZYvU9cLKF6
        evlpxn2pIv47hNSRCb/wjkmzu
X-Received: by 2002:a05:6602:2d8b:b0:6a5:3332:9bcf with SMTP id k11-20020a0566022d8b00b006a533329bcfmr56060iow.211.1665067215908;
        Thu, 06 Oct 2022 07:40:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7PS+ghlX3Fgu57Ciup7KgD/GG+m2sG+bU/XEsDP15MrevQn26Tsa1Y2KiI3SdvPZ6FqNY3Hg==
X-Received: by 2002:a05:6602:2d8b:b0:6a5:3332:9bcf with SMTP id k11-20020a0566022d8b00b006a533329bcfmr56050iow.211.1665067215702;
        Thu, 06 Oct 2022 07:40:15 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id b19-20020a026f53000000b0036353ba86c0sm2509913jae.9.2022.10.06.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:40:15 -0700 (PDT)
Date:   Thu, 6 Oct 2022 10:40:13 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: correct ref_aux clock for
 ufs_mem_phy
Message-ID: <Yz7ozWHRoYSlZu/0@x1>
References: <20220830180120.2082734-1-bmasney@redhat.com>
 <Yz2VnYHaTHVpiJAM@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz2VnYHaTHVpiJAM@hovoldconsulting.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:33:01PM +0200, Johan Hovold wrote:
> You should fix the Subject which still refers to the "ref_aux" clock.

I'll send out a new version with the updated subject to make it easy for
Bjorn to pick up.

> I can confirm that this is needed also for sc8280xp-crd and sa8295p-adp,
> so with Subject fixed:
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks!

Brian

