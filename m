Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8D63C851
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiK2TZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbiK2TZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:25:33 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600861E3C3;
        Tue, 29 Nov 2022 11:22:43 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id io19so14402363plb.8;
        Tue, 29 Nov 2022 11:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud7QUQrd40h0Xyjtk+wC6bX6renF5UjjCEwypxPzWbY=;
        b=kG/AQCQULhSSPnElbR+0UswMt+8adcA2nyKl20+tvq4vgtatUzsSW9isc4JQYt5iLa
         EgW1YSnFOcj1c5GrNiBPILJm+oyjJAJlyDldggj4bpCykL2zZQ+fklbmpVe8PZm2Tm/g
         /mCo4F2q3V51IJgm2oJrvjbaZwuIMAbKDahYgvucq5gi0/sWBZb4GArq2J0TCDqNeH0L
         No/nYLflZ0SqGPjiBSYDug04Ox3XSKjuSlYq5YHSZHxEOibtmLNzt4FyqDGHmKOq6Pdc
         Guy2u/c7oHC8gqFPuuKSJLuoYZrFtHxzRWtFHOqjwbGSkDyle0/iZcWSskvfy+teyDrk
         Dz5g==
X-Gm-Message-State: ANoB5pkBlEaZVgyvXUKC3XiwBpavJzx7OWbh4cLKdZtmhJkJk3Hj6TIy
        u8ruIXJ4Dt2mntdn9EvG5Ee/tNbIzYY=
X-Google-Smtp-Source: AA0mqf74NWcZBGgWlmT1N9eayQRdNZmN5bY+tJ7R4lYGyiec59ZGomU4zmG2JjRFNKoH5mxbfzzdsg==
X-Received: by 2002:a17:90a:e398:b0:219:61e2:226b with SMTP id b24-20020a17090ae39800b0021961e2226bmr7449pjz.11.1669749762806;
        Tue, 29 Nov 2022 11:22:42 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:7d15:8e62:30bb:9a14? ([2620:15c:211:201:7d15:8e62:30bb:9a14])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e34a00b001873aa85e1fsm11089481plc.305.2022.11.29.11.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:22:42 -0800 (PST)
Message-ID: <df585a3d-f69e-7a9f-d006-b58bed56d2bb@acm.org>
Date:   Tue, 29 Nov 2022 11:22:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v7 06/16] ufs: core: mcq: Configure resource regions
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669747235.git.quic_asutoshd@quicinc.com>
 <c655d1e62f619818e034f76c90330393cba8c79b.1669747235.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c655d1e62f619818e034f76c90330393cba8c79b.1669747235.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 10:53, Asutosh Das wrote:
> Define the mcq resources and add support to ioremap
> the resource regions.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

