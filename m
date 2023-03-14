Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF06F6BA37C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCNXVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCNXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:21:19 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0E6305C4;
        Tue, 14 Mar 2023 16:21:18 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id rj10so6401825pjb.4;
        Tue, 14 Mar 2023 16:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678836078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTQ7I6gEq/wz6ZhaT13oVoyn1XK6+uvwTMIlBtJLUPo=;
        b=TNQM40Eq5LDLQsFobyir8r9fPYbTzSLh9tQmE0sDHghRvm3g6I0K5iFlXQUVcMQr4X
         6+8XJ94SAlF7dxHXf3jfAUyn9i7JASHdlxqNBNcdTBYmdebS3XWsjTQay0o6CVAtnpvm
         HWifiAbHe770VswhMiQgeY8mgRiepArgOV4WqgmPUISvov8phlQd5FGOxE3RFCXAJ5a+
         hlTrrdNwPLkqhgv9GwR343yA6mTMVEvofKL7N1CyArcdQ42XYJ57I5wZohrQiSpsTS5m
         A1GxkEugRjiDCcb9WhEMxihQnt+xWp13p2FjWqHc726tiqe2lWRLM1TvB6RYqzNj+WDs
         +rJg==
X-Gm-Message-State: AO0yUKV6FFy744LbqfT7LB1izASMW50clOb2d1sTlF53OmzZq0JAT/Vx
        MuFkd6L89pKu7xbpmNVXfAA=
X-Google-Smtp-Source: AK7set/NyLqv5k2p0JDFsAd2z1ShpVSrNW3r+zoLi8Lj2uvXgRFdLpqo2Yl7oH6prG4ifjoXU1JLgg==
X-Received: by 2002:a05:6a20:63a1:b0:c7:4bf5:fa0a with SMTP id m33-20020a056a2063a100b000c74bf5fa0amr32385885pzg.48.1678836077941;
        Tue, 14 Mar 2023 16:21:17 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b005cdbd9c8825sm2116947pfi.195.2023.03.14.16.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 16:21:17 -0700 (PDT)
Message-ID: <c98a3741-273b-8a69-016d-5f3e79f8a71e@acm.org>
Date:   Tue, 14 Mar 2023 16:21:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Content-Language: en-US
To:     Alexey Klimov <alexey.klimov@linaro.org>, peterz@infradead.org
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, klimova@google.com
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230314230004.961993-1-alexey.klimov@linaro.org>
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

On 3/14/23 16:00, Alexey Klimov wrote:
> The delay is found to be in device's ->shutdown() methods called from kernel_restart():
> void kernel_restart_prepare(char *cmd)
> {
> 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> 	system_state = SYSTEM_RESTART;
> 	usermodehelper_disable();
> 	device_shutdown();	<---- here
> }
> 
> The driver in question is ufshcd and its ufshcd_wl_shutdown() shutdown method. It often blocks on scsi_device_quiesce() and upon manual checking it seems that it sleeps on blk_mq_freeze_queue_wait()/wait_event() in blk_freeze_queue():
> 
> scsi_device_quiesce(struct scsi_device *sdev)
> {
> 	...
> 	blk_mq_freeze_queue(q);
> 	...
> }
> 	||
> 	V
> void blk_freeze_queue(struct request_queue *q)
> {
> 	/*
> 	 * In the !blk_mq case we are only calling this to kill the
> 	 * q_usage_counter, otherwise this increases the freeze depth
> 	 * and waits for it to return to zero.  For this reason there is
> 	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
> 	 * exported to drivers as the only user for unfreeze is blk_mq.
> 	 */
> 	blk_freeze_queue_start(q);
> 	blk_mq_freeze_queue_wait(q);	<--- sleeps on wait_event() here
> }

Please let me know if you want me to resubmit patch "scsi: ufs: Remove 
the LUN quiescing code from ufshcd_wl_shutdown()" 
(https://lore.kernel.org/linux-scsi/20220331223424.1054715-14-bvanassche@acm.org/).

Thanks,

Bart.

