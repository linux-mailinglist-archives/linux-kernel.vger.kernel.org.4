Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F26235FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKIVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKIVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:39:54 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBC2A26D;
        Wed,  9 Nov 2022 13:39:53 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id z26so17932159pff.1;
        Wed, 09 Nov 2022 13:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51UKphScOkAZk/JYPQyyUdQI4rigXll8VtuS8/WSFDU=;
        b=YsEXlJxd6/pYHeKPq8sYc2EYVpCH0jFDMjjhJ6K7Q4v8upHnhjY+gjikaiPsMxDoYC
         boEfhElAoXGKl9B8wsNyl0o/UAwcZ6MF4uf3v+6aq7zga3197mRQCexz+hmmjcTLefX5
         qXD3Rt8d1yxndLivB8bRvb5jrlP7JhuacAjlJYvTotYVxfPvGlyhAJvMTtRy3WwdPIgC
         NwzZpKuN9wo20uay33DBiKinm3ETjVdPuOmcbEKIONgOlMbeBiYiw5df0VtQQedSjNbR
         Bzxdr60GQaCuUaPP75MgGzt+Tk8SqdHbjmWUjiipO+lY/7SxcLh5xquPoGW6B27+wz1/
         VV7Q==
X-Gm-Message-State: ACrzQf3Yt7aw643oIP3z0zV4Btq+RewkGVjCsMfeP4nz+JYF8YhGGBaH
        PYAEptgEeQiu7aWe2pmgo0Q=
X-Google-Smtp-Source: AMsMyM5X6TiKoY3iecrp7/h3ctRCOf3bOkygYB/QBw3VdmC27evIrdLQykHpQh7grO8F57r8vkoPZg==
X-Received: by 2002:a05:6a00:1582:b0:56d:4bc6:68c7 with SMTP id u2-20020a056a00158200b0056d4bc668c7mr55891573pfk.31.1668029993334;
        Wed, 09 Nov 2022 13:39:53 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b0017f7628cbddsm9596636pls.30.2022.11.09.13.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:39:52 -0800 (PST)
Message-ID: <1cb92354-ac65-6038-59ec-3f82b613cab4@acm.org>
Date:   Wed, 9 Nov 2022 13:39:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 09/16] ufs: core: mcq: Configure operation and runtime
 interface
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <9d69f52798bed75f5e66176b975f105e8e625902.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9d69f52798bed75f5e66176b975f105e8e625902.1668022680.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 11:41, Asutosh Das wrote:
> Runtime and operation registers are defined per Submission
> and Completion queue.
> The location of these registers is not defined in the spec;
> meaning the offsets and stride may vary for different
> HC vendors. Establish the stride, base address and doorbell
> address offsets from vendor host driver and program it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
