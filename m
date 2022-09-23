Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6775E7AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIWMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIWMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:24:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152413EADA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:19:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so330720ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u32wzLxrZs/mi8kueHNrXwiGsYayMHcA5H98ffopLtw=;
        b=EMG5EtZs7vBbTCuvQM21M/UpaapxJxcexsDTE9ow6dwxlQbCF/SkGGNmEXpBZ1bloX
         gtYEYA/jfyAb9BiN+TmFc559FftkFOdaOHpxeXB2Wq0+jhI9/6cGG++xA/1eGjHmBNpN
         L1SJte0BM55ZTQeZiHZSkwZvNHg2uyYeKepog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u32wzLxrZs/mi8kueHNrXwiGsYayMHcA5H98ffopLtw=;
        b=ehig/KgqeLjsAhta+17TbW1MpGuBnZsshLeSsuP1ZPBYJUDK3GHV7HDnjwBoKYX7p1
         PzhK8DhnVENj2RQc5O8nN72888A4dJsi2miAk7hRMXgkNfdJis5ET+k+qUbVUw+eZ47H
         FiGfN6QBNEFjwLC5gT5T80ePsjMkcDmeZf6/SKwhV+XfaXyPMY8EINpuuVMwLYTgEV7X
         w4BDa22FnkqC+0Rd5qso0DYg7xppYWGMhTffVyMgAZjQomoADBI9REq49ALMfoGM9YvE
         X3oZYkUlp5dorVrk8k3cGAWOFsdk1Ds+6VNcQmPD5XJ8/j2Rggd8vxbidmalmtbliV0e
         n+HA==
X-Gm-Message-State: ACrzQf17ApSLejMPf4VeFUgIzuAwfXuXpNIoc86AP+9U/dG1ea2WTtj/
        2lW/8JvxyuwvhXjPmhsQPrlaEQ==
X-Google-Smtp-Source: AMsMyM5eqSnSwOTzWZgkrF6u/fPzLIP1nivW1c9nergAV/bMnz4F/njbuRATbefl0jYiv2GGHkUZYQ==
X-Received: by 2002:a17:906:8a7b:b0:781:8016:2de1 with SMTP id hy27-20020a1709068a7b00b0078180162de1mr6856309ejc.54.1663935557305;
        Fri, 23 Sep 2022 05:19:17 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906b08d00b0073dbfd33a8dsm3998397ejy.21.2022.09.23.05.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 05:19:16 -0700 (PDT)
Message-ID: <36fc5ec8-12a3-fc04-a8da-59d4e08e41b6@rasmusvillemoes.dk>
Date:   Fri, 23 Sep 2022 14:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist
 nodes
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Phil Auld <pauld@redhat.com>
References: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 21.49, Andy Shevchenko wrote:

> + * which allows to count the exact maximum length in the worst case,
> + * i.e. when each second CPU is being listed.

I don't think that's actually the worst case. I think that would be
where 2 out of 3 cpus are listed. I.e., with 16 cpus

0-1,3-4,6-7,9-10,12-13,15

is certainly longer than

0,2,4,6,8,10,12,14

It's trivial to see that no bitmap with four consecutive bits can be a
worst-case, and any bitmap with some three consecutive bits is as bad as
the same one with the middle bit cleared (the rep just changes a - to a
,), so the worst case is definitely obtained among bitmaps with at most
two consecutive bits.

Rasmus
