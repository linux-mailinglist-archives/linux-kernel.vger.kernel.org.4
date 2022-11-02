Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C61615B71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKBE24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:28:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4310C6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:28:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so852014pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGNiahs6hX5ZvMHkL2FovfAhXr5AX8OYLJp5JLaYUCU=;
        b=j7sT/eTuWOFh4nxlTckUHUlheNTNZry/B3vaZ31/z8qoUmHkWtsdc31aTiqWojROLW
         h+joxl12X39mR768q+urvQFEsHA3l7qTGADYEKAncj3OSi7GbUlB7US5DT+8Jw1VJNKL
         dA1jj3MQqUMEbse0RSZ7uNLpfX7D4HjEMJvmvJYbO8CIwFGZOS9LNiOqpwh7Tm1wqcfR
         L4puIMmN8KF33MkP/1/MCNHQ/CSYIvzShfpvhTE3tt73PiluLhs12cLQt9SbbhvwNUMe
         1uzjyTZ/0xES3nrbQ5GWbr2MqV2C5AA8z16lVLIBcQ+pKGE6IBjFr0zXs0eEGLtL+DfM
         xUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGNiahs6hX5ZvMHkL2FovfAhXr5AX8OYLJp5JLaYUCU=;
        b=Zc9gWimRclh8fM6raUgOzrHgPHYbWD7yg2znichnyhMe+Up6PTFpmTvD2Jdfcaj7CY
         xL6TkZowYf5NJKQ4lycb9APXzGuBoIWpcFMlB1uQOtTlemzeGMyJLdOoM4bOczwhErz2
         h0z6RcPpZycsPPKHsTzrqSMHnlE58O+cqqBSgrQVeGWXtN9HtmE/W7ine33XCbMHaFAz
         5x9NdyO/xMQ05nA5X+w3xmU7+K4jOIB2ftrL9ogTqsTCUocC9RBB2UuO73tSjQr9EgDv
         zIoyJp1xXwOJhPHbVjkwCrYdGKlCTCQkcBIF6fT/93WqZC6CRaWSKcMNYLgZ/E2STjWQ
         jkuA==
X-Gm-Message-State: ACrzQf0m84B7bfKdyjKpF5wMmVd+AdG0o3vik6+xBrcEtPmutksHII1E
        h0WvwkEUtoNmJ7mWZd776irLEA==
X-Google-Smtp-Source: AMsMyM4xh8AbMmR+mGtUChrGRjwUGbaKq6o9iCpRPiFkv4uKhs/y2DXP2sWUkw3nooe4OdnCvmppHw==
X-Received: by 2002:a17:903:2352:b0:186:aaed:e7b8 with SMTP id c18-20020a170903235200b00186aaede7b8mr22467061plh.47.1667363331996;
        Tue, 01 Nov 2022 21:28:51 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id kx2-20020a17090b228200b00200a85fa777sm406615pjb.1.2022.11.01.21.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 21:28:51 -0700 (PDT)
Date:   Wed, 2 Nov 2022 09:58:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221102042849.q3qnaoebeudpbpnv@vireshk-i7>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
 <20221025073254.1564622-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025073254.1564622-8-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-22, 13:02, Manivannan Sadhasivam wrote:
>  	for (i = 0; i < num_domains; i++) {
>  		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
> +		static struct clk_init_data init = {};

Why not make this part of a driver level structure instead of static ?
And what will {} do ? Initialize to 0 ? static would have already done
that.

-- 
viresh
