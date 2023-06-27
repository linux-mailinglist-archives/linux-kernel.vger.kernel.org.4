Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93F973F0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjF0CGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjF0CF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:05:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDD1BE7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:05:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6689430d803so2144543b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687831553; x=1690423553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9W0T2K90Nbqp3wdusKBENigq0uDRTlq5SfN1o8FmM2w=;
        b=dzQd2FEIhfvAM+5W4mD12pYegvrFiDYqYtnCHb/TKRhdsoNfN5cxvKVg0+kkXhtjHH
         AjaG1qOHVO48jMgphdzKRBAUBQQJQ7alFwcazB7tfKIiC5hINRhjh5P9HbFAXEX4NR59
         7nzmlLz+ycXB1Qk3R5PpbYG8IIxmJF9B7Q5JYFxk00EzhcyFG2uXB13CKvRY5qePF0Kg
         GKQqN63/RdDVJ4T0BBQBUAbEn/kYQc6zERR7i47MxNyhWg7ShH+52j9DkGYjKQaDE9hQ
         Zea5g2abm2pW0LmfnXAWqFMzV0U6++mHdsQIheiEHoqcLarbS3BDI0eZBifSXtLo34xp
         nKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687831553; x=1690423553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W0T2K90Nbqp3wdusKBENigq0uDRTlq5SfN1o8FmM2w=;
        b=U8+PH2pfeb3LD/amKODnAIH8Ljv/46Bbh8pJHHNHFmZlTbSyudNNLGxcsxwwwkd6Kn
         fWBpVmIkmUOM23Zgml8gH0Y/HI4Ts8OTizCdlY5bHQPZhSHgS+SRwgKkb/6PnRMawcTe
         1figD59aqt0gzxzLEz3VPRqxXMbSRPnw5JvK9H7NxYRT6zWrptNF14fHu18eeJNEKuNF
         M4faHaKirnpFKyqeSEe+SrXd+v0xZHyDTMl7x0vM7dzvZzPeRQErZqw1bSIlkULhttvg
         rbdf3tbtJsamR47CrrPdK3sjzlNjOc5SDOXyp/ngOXs8VtxgXqJZVoPKI3fZpAEgtnxb
         q+mw==
X-Gm-Message-State: AC+VfDylfYJK2N89QwkOcYTD5Zf4NhIIMDhyWdccagNRiTrHuJvF6jtE
        TNX2APbQHpBDu/EvlqCPSUlvSw==
X-Google-Smtp-Source: ACHHUZ7z7oxMCDncyvCt4YnRlV7xEhwgWbo9aCIsPAc1Ta6RkOicZYhVjAHYYoGE4pxa9vWPS59D8w==
X-Received: by 2002:a05:6a00:2e10:b0:666:ae6b:c476 with SMTP id fc16-20020a056a002e1000b00666ae6bc476mr30177833pfb.25.1687831552989;
        Mon, 26 Jun 2023 19:05:52 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id a16-20020aa780d0000000b00666e2dac482sm4350500pfn.124.2023.06.26.19.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 19:05:52 -0700 (PDT)
Date:   Tue, 27 Jun 2023 07:35:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] OPP: Properly propagate error along when failing to get
 icc_path
Message-ID: <20230627020547.pek7ld44p4g7lbno@vireshk-i7>
References: <20230626134645.57902-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626134645.57902-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-23, 08:46, Andrew Halaney wrote:
> fa155f4f8348 ("OPP: Use dev_err_probe() when failing to get icc_path")
> failed to actually use the error it was trying to log:
> 
>     smatch warnings:
>     drivers/opp/of.c:516 dev_pm_opp_of_find_icc_paths() warn: passing zero to 'dev_err_probe'
> 
> Make sure to use the right error and pass it along.
> 
> Fixes: fa155f4f8348 ("OPP: Use dev_err_probe() when failing to get icc_path")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202306262008.guNLgjt6-lkp@intel.com/
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Applied. Thanks.

-- 
viresh
