Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFAF6717D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjARJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjARJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:24:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36777798F6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:49:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id r21so4124512plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACMX/rYtpwog5RBKFT4Bl4KCPeviYqcrlPIVvg3gfv4=;
        b=TTRxm6HEV3Ax5bsr6E+mCXOjTdUde7Aavz4/DKVeRo4IbvjIRbzBX7gjOi+OnD8V/B
         ZsQNgHykS68MCvlH2tzV/JnJpGjFr/6NGpRTrPhg374STYJDWD+HRxHsYGcaozsROY3o
         +cd8DAoh6RFbgtR55896pQL4qi0+wirhLBSAdzHfFkwAfwb9Op3vIUD6v7bSCe/WNAEZ
         Tsri4uNHixsLJhl9KQ8DydyfQajRm+BWcobiLge/ZY/KU5VPnTXo+oi7bpdC+Yps4UUd
         ksgCec7OMjsDulyLr91JhQbo+hck56MRa0zFjnTokjHjyhaApGoMX77yQdVynBHQBwo4
         0GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACMX/rYtpwog5RBKFT4Bl4KCPeviYqcrlPIVvg3gfv4=;
        b=13p94QYN8ohgzOf1GXUICweQfkeN4mZHGtnK5vxdLBIjxbh7CxHSdWLFzR/Ehm4MZ0
         SIaFdADHDsNAXTQV1qnA7OyMmdLvgvddtQAhBtwfI4+KEn0vn4ZGT1YsT5htK+Luepdd
         hFvU6Jq86PE6TPMQcA8VHnXJkMetcOcX9zf470126UDYa92CfykbGKM6AAE/wxt4Xcet
         abuAKep/qvckjdbF19Z+Y5Z09mhP1tMOWbf7RfvDC+s0DNNyf7f+9CThytHwlmnYEu3T
         jMOWj0e2gg4m2ZjPZXkElPl26ypwXH8u5nKoOlQZ+xwAsre6/iIAy57VDsv0DraYzUZK
         Vfzw==
X-Gm-Message-State: AFqh2kqP7mgn46zKuuWSM8WLfnj2izvSrKnmjz5bBpDftWbMhaIfVYkn
        JgMhHLXY7pm7wcLc7LPrRJNPYg==
X-Google-Smtp-Source: AMrXdXuC6FRTTT3m2sKNJd3v7eYjibMNTVCRskuIxXGz018rzDhmQVGzqorCxJaR8ZGowLy3/ns0wg==
X-Received: by 2002:a17:903:200a:b0:188:640f:f41e with SMTP id s10-20020a170903200a00b00188640ff41emr5663995pla.4.1674031766608;
        Wed, 18 Jan 2023 00:49:26 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id z20-20020a170903409400b001933b4b1a49sm17152344plc.183.2023.01.18.00.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:49:25 -0800 (PST)
Date:   Wed, 18 Jan 2023 14:19:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Wang <bhuwz@163.com>
Cc:     rafael@kernel.org, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Wang <vincentwang3@lenovo.com>
Subject: Re: [PATCH v2] cpufreq: Register with perf domain before
Message-ID: <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
References: <20230118044733.29391-1-bhuwz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118044733.29391-1-bhuwz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-23, 12:47, Vincent Wang wrote:
> From: Vincent Wang <vincentwang3@lenovo.com>
> 
> We found the following issue during kernel boot on android phone:
> 
> [    1.325272][    T1] cpu cpu0: EM: created perf domain
> [    1.329317][    T1] cpu cpu4: EM: created perf domain
> [    1.337597][   T76] pd_init: no EM found for CPU7
> [    1.350849][    T1] cpu cpu7: EM: created perf domain
> 
> pd init for cluster2 is executed in a kworker thread and
> is earlier than the perf domain creation for cluster2.

Can you please give detail of the exact code path, for mainline kernel
? I am not sure which kworker thread are you talking about here.

> pd_init() is called from the cpufreq notification of
> CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier
> than that cpufreq_driver->register_em() is called.

-- 
viresh
