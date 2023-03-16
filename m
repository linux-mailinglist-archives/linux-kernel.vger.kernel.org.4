Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7656BD79F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCPR5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCPR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:57:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C41CBED
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:57:46 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b5so1191581iow.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678989465; x=1681581465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aDWkwASLDX6LxmzoVpUeVRoGDzEvjyyZP/F526cKds=;
        b=Q5pO4RIJpD7ELBOWVKg/s8acznu5aKOft7mxJK+kPDndEOfdat+84uzzRdfFaLGhOZ
         dChQX2G0lC7RFvMniTJbXXEwf5lbvtUoj5LAK/2VPiI/WHoTpjLx9clJMsc9LeBTAudY
         8thpmCHRwh3rKogP0nzWf/JkvJTG5aIpXzebU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989465; x=1681581465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aDWkwASLDX6LxmzoVpUeVRoGDzEvjyyZP/F526cKds=;
        b=F2QszJrMixHiz4v/8QU5Q02D0g9DjJda0Iqi6JnjejZ0z8eaaXpI8biksQOw57Rrcr
         pUH0iivQABKa8hvOY8aU1Zy35KJpl33Tba6drXbCJNgOd5FclTl2AjoK4+chTAuVCYM8
         qLrnWNQJPXi/a5bTnpMksW+i59UGfvilVVXCvfJB5SPyLoTAC4BWpfSEamXigLMRbrq9
         0dlnWOVIuaxEw5M0bxF8v/zNz0Tvi8mlvS5KyK4eVlceSRQgrL97LUrs5XmwEfT8sxGh
         F/vJ2+MTsuCzsUT8Lgm/iNf7ycWxJwAGmlFDi9E1n7V2kw45ulG2x7saJv8cMlMt1/9e
         ffCA==
X-Gm-Message-State: AO0yUKVCOZNSdZKflNIxA9bqsFmm52CaTYYM3+8Bs1IiUlE3pwbVMYLP
        BLld280kv4USpiDCglDmiA+PQw==
X-Google-Smtp-Source: AK7set8anCUkXWw2JY/XWz1HHFWfdIPp17MEXEPVDi/cdcTBaOD5gfislthPcGyNnmQpUrPAPDn7Kw==
X-Received: by 2002:a6b:6e08:0:b0:74e:8718:a174 with SMTP id d8-20020a6b6e08000000b0074e8718a174mr4006330ioh.1.1678989465416;
        Thu, 16 Mar 2023 10:57:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dj5-20020a0566384b8500b004061d3cce02sm1345464jab.67.2023.03.16.10.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:57:45 -0700 (PDT)
Message-ID: <829d7a70-8e73-43fd-e819-6ced8c83c12e@linuxfoundation.org>
Date:   Thu, 16 Mar 2023 11:57:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230316174432.1592087-1-zyytlz.wz@163.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230316174432.1592087-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 11:44, Zheng Wang wrote:
> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_timer.
> 
> When it calls usbip_sockfd_store, it will call v_start_timer to start the
> timer work.
> 
> When we call vudc_remove to remove the driver, theremay be a sequence as
> follows:
> 

When you resend the patch as you indicated would, please add details
on how you found this proble,m.

> Fix it by shutdown the timer work before cleanup in vudc_remove.
> 

thanks,
-- Shuah

