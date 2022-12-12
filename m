Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13F64A816
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiLLT0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLT0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:26:03 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA260F3;
        Mon, 12 Dec 2022 11:26:00 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id o136so455000vka.2;
        Mon, 12 Dec 2022 11:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESQVzuiXA+YFG5RaGAGNaA3TQ4uKoPjaUcpuFUSSAcs=;
        b=QtXxSERuOoxILd4PGG3KpQhKmeyeGV6nVD0fCj3Q1dyT1/BFASLNeC9hEPc0wjokj5
         mjENy96mlsY9fZ3XYuoTJINI205HKKvc7ecaPUkWyzz5u9R2uYaAhYNZfv+eK2UV4x+3
         bxcJSajtiW1GEa8nfumT6o9cEfdwA9czA9j5m78QR0ZmHHHgFdbnJVJm/d0sWTfUhMsa
         nnyX0+sRLHq4UuxbamKvyUNAaGf5pm5DreihTLLNrg4PMgYGVwL0h05gC6Xp3mfXth5J
         h5ObLwErVvjFVl+Nv2GmV/3BJW5PROcibU7ZUqnFWH+s338+bEiM5xHkSMde1dewHjxR
         NojA==
X-Gm-Message-State: ANoB5pmK2mKwka49uraxm7+Vc7tRrzbPTQF8kjpclqFcxTMy7eE7oW7t
        d8bNcP2c8+7TIGlW31MYkbE=
X-Google-Smtp-Source: AA0mqf7ybW8R/kpJyFRmMWAY4mntd6VU1+id5W7SYgVzahwYbdDlABANGYne3YiFcU3oF9+CMNjDDg==
X-Received: by 2002:a1f:2712:0:b0:3bc:632f:63bb with SMTP id n18-20020a1f2712000000b003bc632f63bbmr9164258vkn.4.1670873159634;
        Mon, 12 Dec 2022 11:25:59 -0800 (PST)
Received: from [172.22.37.189] (rrcs-76-81-102-5.west.biz.rr.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id q11-20020a37f70b000000b006faaf6dc55asm6341067qkj.22.2022.12.12.11.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:25:58 -0800 (PST)
Message-ID: <3be5c295-b939-cc2f-be4c-40a2a136104f@acm.org>
Date:   Mon, 12 Dec 2022 11:25:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
 <71a10a4c-a726-edac-c5d3-1bfded690503@acm.org>
 <BY5PR04MB6327C72DC776F2A244F8DCD1EDE29@BY5PR04MB6327.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BY5PR04MB6327C72DC776F2A244F8DCD1EDE29@BY5PR04MB6327.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 01:10, Arthur Simchaev wrote:
> Regarding your comment, we can do that, although I don't think we should cover for those FW basic bugs.
> Please let me know that you prefer.

I think this version is good enough. I will post my Reviewed-by.

Thanks,

Bart.

