Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD34612AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJ3OZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3OZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:25:49 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4FAB4BB;
        Sun, 30 Oct 2022 07:25:48 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3925116pjk.1;
        Sun, 30 Oct 2022 07:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlUsVXBEKnWSmUCDw//iMFATDePe/mdqp+ek5UTPNEE=;
        b=hJdbgh6ctGN7mp4ogK32sS4uj4giZxKXtTs+ml1N754c2VXP8Z7MjapNLnkRwurkOl
         o6J969hNgjTxKsYDDnQtKJNV/VsXXkriB+3H/bH0V7HGJBMtVaHLGFTswhp2qyZOAUJk
         RDNtkWBJWVP0EgsnGCxem9ix+9kwgMgSjU/L/N5pYe8+ia06MqTWASuAe8Yrm3wwSUdO
         AFUAacH2ThNWf7z+v8lI/xnhYOutwnrFmjvVNnWvbIbdiHbDgDZWq7WL/Bu8GWDR5Aqi
         tjWSKR7uCviZlE6YaWSEFZagc3ckuiTSOL3jo06Lvd/nlqsv7JVtm9U5z8XNKUpj7Upi
         5kxA==
X-Gm-Message-State: ACrzQf1YxAj4fmHnioYhraNxmI87XgCrCrzkQDZAjcdLYJpv7pa1UTYl
        gtd6kCEzu4Sxqn6B2ZnAM4XAhr1Bojo=
X-Google-Smtp-Source: AMsMyM6kbsZX1AjQpVrp9L1PHMcJdfj4whBoZlmlCsbKzzpmVhCS34FDVE6CLk69TeseCfE6bfZMzw==
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr9805926pjj.17.1667139948115;
        Sun, 30 Oct 2022 07:25:48 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id s4-20020a170903214400b00177e5d83d3esm2789734ple.88.2022.10.30.07.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 07:25:47 -0700 (PDT)
Message-ID: <9a758d91-42c5-d6b3-ddde-9c2b89d741a6@acm.org>
Date:   Sun, 30 Oct 2022 07:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Content-Language: en-US
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
 <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
 <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <42681e4e.15223d.18426b71124.Coremail.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 19:27, Jinlong Chen wrote:
>> I think this patch introduces a hang for every caller of
>> blk_mq_destroy_queue() other than blk_queue_start_drain().
 >> I don't see why the patch introduces a hang. The calling relationship in
> blk_mq_destroy_queue is as follows: [ ... ]

Agreed - what I wrote is wrong.

> So I think there is a redundant call to blk_freeze_queue_start(), we
> just need to call blk_mq_freeze_queue_wait() after calling
> blk_queue_start_drain().

I think it is on purpose that blk_queue_start_drain() freezes the 
request queue and never unfreezes it. So if you want to change this 
behavior it's up to you to motivate why you want to change this behavior 
and also why it is safe to make that change. See also commit 
d3cfb2a0ac0b ("block: block new I/O just after queue is set as dying").

Bart.

