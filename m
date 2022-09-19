Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F45BCE18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiISOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiISOKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:37 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2531371
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:36 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z191so22952737iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1DwDVcE9Q7fJnvzqJ95nLyaymD/H1xmCXUcLA5QnNqs=;
        b=I+5dK2Lropv+/49qWmABlU7JVzFW8/PAdOTt47JCfdzdFjvoS9e622gDzpNbCoVVGc
         O7WjybSmFafhUCZSKk4rdvmzPXrUO6+zh//MP8KR2uMuoFNIOrwtFz7Kyb2GhjW/3Zlz
         KhkVo6HG7R8qCC6Ak4INMXwT/6EItuJEudDTa2PdosbuZCrINM0JhQiC8/g3GJ47XVvq
         N5RGiuodznlnngCxgFBv28RTgAxIpNkqBHS4J0FwH4I+fvtFfsVD8EgRgWCLFZPLSJ5T
         CWq9YrX1M9LQOU63nuNvuSaNGfBj0foZbggX2x9UmG2iWIP+bS8zkJen4psYfYdYwfZx
         p+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1DwDVcE9Q7fJnvzqJ95nLyaymD/H1xmCXUcLA5QnNqs=;
        b=BNeNa/PqeBm2njOdTuvg7a5Mh9I0XrcDYuQ2nhv2n/1VKDhwnXRs61AGBnEYSVcXx9
         2SNieHm8NGn7sVvqVbzUunEPanX0lqzISsy2e4nMxv9pUEDXCp4HHwb4IGsc8uvvMFZX
         B6yBi8XUokc3NqVLUAEbL8Si38TMfstK43PIu6jPjk5LI37IryoGZf45OI8gUsZpbD/M
         6nX56rhq/yxtbelLYAD+Lej45HWnBE3fR9CXdNsUZQYNJiaGvbOXcwFq/yWKj40pYI1E
         Gb2ID32V0Xb0kqSCtlNJW9sYrQno361l9/rvz3wJDYACBk3dPTqOyx559fOiUTjD1d/+
         d0Qg==
X-Gm-Message-State: ACrzQf1jT7MqKnm1qyiQiCxaj7tMD2i8k2xX/t3Dx/hnJCa+23+3DiW9
        G4+UTrhqnSDp7DkdT1FQ4rTGRBDw8x5dng==
X-Google-Smtp-Source: AMsMyM6Bs1+NdJwv1qGYlqvXnmtuML1sRA+RH/tv6xUV+aEZ7TB09Uow7JAEBvBny0KXIyZQ9ldYcg==
X-Received: by 2002:a6b:5c10:0:b0:6a0:fbbd:3241 with SMTP id z16-20020a6b5c10000000b006a0fbbd3241mr7092750ioh.166.1663596635564;
        Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z8-20020a027a48000000b00358437173c3sm5470510jad.53.2022.09.19.07.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 07:10:34 -0700 (PDT)
Message-ID: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
Date:   Mon, 19 Sep 2022 08:10:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
To:     Liu Song <liusong@linux.alibaba.com>, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
 <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
 <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 10:10 AM, Liu Song wrote:
> 
> On 2022/9/18 00:50, Jens Axboe wrote:
>> On 9/17/22 10:40 AM, Liu Song wrote:
>>> From: Liu Song <liusong@linux.alibaba.com>
>>>
>>> NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
>>> so when "nr_ctx" is equal to 1, there is no possibility of remote
>>> request, so the corresponding process can be simplified.
>> If the worry is the call overhead of blk_mq_complete_request_remote(),
>> why don't we just make that available as an inline instead? That seems
>> vastly superior to providing a random shortcut in a driver to avoid
>> calling it.
> 
> Hi
> 
> This is what I think about it. If it is an SSD with only one hw queue,
> remote requests will appear occasionally. As a real multi-queue
> device, nvme usually does not have remote requests, so we don't need
> to care about it. So even if "blk_mq_complete_request_remote" is
> called, there is a high probability that it will return false, and the
> cost of changing the call to "blk_mq_complete_request_remote" to
> determine whether "req->mq_hctx->nr_ctx" is 1 is not only a function
> call, but more judgments in "blk_mq_complete_request_remote". If
> "blk_mq_complete_request_remote" is decorated as inline, it also
> depends on the compiler, there is uncertainty.

I'm not disagreeing with any of that, my point is just that you're
hacking around this in the nvme driver. This is problematic whenever
core changes happen, because now we have to touch individual drivers.
While the expectation is that there are no remote IPI completions for
NVMe, queue starved devices do exist and those do see remote
completions.

This optimization belongs in the blk-mq core, not in nvme. I do think it
makes sense, you just need to solve it in blk-mq rather than in the nvme
driver.

-- 
Jens Axboe
