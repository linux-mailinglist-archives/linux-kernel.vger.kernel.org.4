Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7831E611CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ1V41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJ1V4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:56:23 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F0E24C102;
        Fri, 28 Oct 2022 14:56:22 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id c24so5952138pls.9;
        Fri, 28 Oct 2022 14:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRxOJs0CrcGRU71XFSlw3IgjDlkrMUlaAe5RLb6zS/w=;
        b=LFjMsluKwrIluzDM4iHJemE7BuLWrSSvNkebQQOUC/mr8l+0uu+nYELSmELg+OCR5m
         wSKvKHrVz/X+5/wO/Y0k78ECUjoul2bquUi33ydGNXcjiiUjgKy/Oljz2S1012Iuihqv
         gLA2kpgyfYsx8Coci5sEG2sEd82Id22WzM6FeNS0bAICE4P7uQQbBmMG7OzjKzFA9ZJ1
         9Q9fKxDEO5wbp0M6Al7AkH/hblqY0/ULb5hnDz1gM0uV9E5XuGIVVC9cMMqoMCndIjhc
         qXfoeVCLo9GvjrDoH4emMUgY7a+JaZWvqx+BH2rL0CbatO1aMIqEAjzEo0YTXV5LMC9A
         KWwA==
X-Gm-Message-State: ACrzQf1mBMwfrLOfVF2UVgTqFMj2NCZB6aCkFJyceXV21QPcUKpm3CSr
        uunx8yV6Gj33HKdOcnqdYaw=
X-Google-Smtp-Source: AMsMyM4uKDLG7ECuZMK5mLyvCKvvNk+/R9jMhajRHsYGLg8JhrUI76TZDV0ixXqLWa0IeHt4xf+/CQ==
X-Received: by 2002:a17:90b:954:b0:213:c01:b8ce with SMTP id dw20-20020a17090b095400b002130c01b8cemr18931873pjb.168.1666994181757;
        Fri, 28 Oct 2022 14:56:21 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0020a821e97fbsm3015068pjq.13.2022.10.28.14.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:56:21 -0700 (PDT)
Message-ID: <410bdf50-b7a0-9157-724b-9410f23f21e7@acm.org>
Date:   Fri, 28 Oct 2022 14:56:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 13/17] ufs: core: Prepare for completion in mcq
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <200c3ff9c2f3f83fb6f04afb4c83da01e5f27f1f.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <200c3ff9c2f3f83fb6f04afb4c83da01e5f27f1f.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> Modifies completion path APIs and adds completion queue
> entry.

Modifies -> Modify
adds -> add

Patch descriptions should be written in the imperative mood.

Otherwise this patch looks good to me, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
