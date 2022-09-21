Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29C5BF8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiIUIVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIUIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:20:49 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F782D2D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:20:43 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l8so3884653wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bmO39YEWije4rH+HKh/s0rFob5lUA/WlZwpEHZX6kGY=;
        b=t5Zr3RyOT2hZHbWw51Vs4Pdgl0/ZesbSP/XIb1L74/xv5BptWLF8zWPXlyir7XhxkV
         l39wkiTEQeS8StM76XUxrzIYfcelXHKmmv5I+OhBHVBe0FWMiua+xWb/Ko1O5oL/3Fgy
         i+0dR+dKubcRBKiTqrjbLMeu1IKak/pOZoOBfrm7lK56HR0dMPmK0b8gsdb6ZER6hYv4
         52Bh6sbUKiH6V3+IdQjr4sON8VgkGIDHHseP3M+/XSy94Jaz/kTXUsMqwbTkkDsIMZgb
         aUsBOCGMCwS5OvC70tS9YVrDFL/Tx5/wsqUn2ZK72Qftt7czNyjRbGkKjsdV+1LOze0f
         MRug==
X-Gm-Message-State: ACrzQf1F5WPHvRrIKljcaDSAmmYtVRLGHnzrlPnePr1t2Vr2xH1JLTRY
        VnRpP7mPyKwfhzv/i3TWiA3edoqGb80=
X-Google-Smtp-Source: AMsMyM7RC9ua0j8zujZr4oMDXeypixegOnSpSmKUFrJ24NaFUdoUfN1znalBM/v71PLUrrMbArKYow==
X-Received: by 2002:a05:600c:19cf:b0:3b4:c8b6:15c6 with SMTP id u15-20020a05600c19cf00b003b4c8b615c6mr5079311wmq.85.1663748442287;
        Wed, 21 Sep 2022 01:20:42 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm1710430wms.1.2022.09.21.01.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:20:41 -0700 (PDT)
Message-ID: <cc1729fb-0a4e-b9f7-caf2-26716629aa2d@grimberg.me>
Date:   Wed, 21 Sep 2022 11:20:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND for nvme-6.1] nvmet-tcp: Fix NULL pointer dereference
 during release
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920131617.63540-1-pizhenwei@bytedance.com>
 <325841d0-16a5-a8dd-fb06-332e7b37721e@grimberg.me>
 <ecdacc31-0e9f-2dc8-297a-477d24e4f581@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ecdacc31-0e9f-2dc8-297a-477d24e4f581@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi, Sagi
> 
> What about letting this patch fix the kernel panic only, and I'll send a 
> followup patch to remove nvmet_tcp_finish_cmd after this patch applies?

That is fine with me.

> 
>> Other than that,
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
