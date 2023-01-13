Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E86689EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjAMDKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjAMDKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:10:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A441621AE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:10:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso21337430pjl.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C90ocOCbYhc9KPmslTn+kJF/0Z1JIADREHRqXAQ2xPc=;
        b=2TQ1+RKZQ3MCeMpvGj5KJi0VAyT+C5F/4PPGTxF6hToUg1V14iAyazYjPcNpbhnw/b
         FDDMXal+Dbi35IjtmHXyO6/j5J/DyCJ3UAG/eMN3cH+vHo3LhhxV+QVE6We0BSmDQkAC
         93vQGN80wHFcJWCYDkj1H7/X6+Q6yvJatoRD5NgXHbI7Fs9scJdvx4MfYhvE1TFYMTDl
         6e0DrTb/8+GlCn225Bkkx23B+LCwIiDOr+09+jcVSkTp7gtoXrlU2B6UozMhxk//gT4+
         hjJC+MRkP0dkj2zCHHVwe+PP+stWPO0j/N70XPmAhDB5qzQyInc3avdVcO0v8sjtBFhd
         W8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C90ocOCbYhc9KPmslTn+kJF/0Z1JIADREHRqXAQ2xPc=;
        b=Nsar4LTrv7+No00qKGN54aPXsCoRQ3OH1QNgvWXrW9GRQENoOhozQxuWZBoKHBMGhx
         GYUaj3AEm0rYFK1Gs1ZUETr6irm0frNRiXyWJXYW2militUuJWVWX+rRPUjfUkpO1xjN
         hEi9aCeUrrXqVJRCZiUh3bATRyGL+EBgJxWEfweO3uJZwnVdSq4WzoZPFjD7KnXkf52m
         PEkFAliV1kNSh0VDy84RhVUvejKa+0rldf69OeGBmKIvpyuzJxFH6ndMODLAbvdPu/Bj
         5wo43FIrpsiCwRazDJfXZuys1tp8rCXUpHdOEOAELxEN43NTQs6OtNwYTXyFUnnC3RG6
         XKIQ==
X-Gm-Message-State: AFqh2kpVDqBJstGIEll/k8au2SGN5u+uVmDlUmg+uQtKW81tzLTuNkuy
        y/cD19bu3Ktcui7mYOUjbC8j7w==
X-Google-Smtp-Source: AMrXdXvFLhchaoEsq2N6JhlXRZAj8tpW+mzYDUn34CBDcg7V2BJHyDpEQKXDzzvA95QhpBRpFbAKuw==
X-Received: by 2002:a17:902:8497:b0:192:c804:89db with SMTP id c23-20020a170902849700b00192c80489dbmr8876861plo.1.1673579409550;
        Thu, 12 Jan 2023 19:10:09 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b0019339f3368asm7915119pld.3.2023.01.12.19.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 19:10:09 -0800 (PST)
Message-ID: <c3f1a97e-8a5b-5f8f-1e36-359d8319131b@kernel.dk>
Date:   Thu, 12 Jan 2023 20:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] WARNING in io_cqring_event_overflow
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        syzbot <syzbot+6805087452d72929404e@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000694ccd05f20ef7be@google.com>
 <746dc294-385c-3ebb-6b8e-7e01e9d54df5@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <746dc294-385c-3ebb-6b8e-7e01e9d54df5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 11:11 AM, Pavel Begunkov wrote:
> On 1/12/23 10:56, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> WARNING in io_cqring_event_overflow
> 
> #syz test: https://github.com/isilence/linux.git overflow-lock

I picked this one up so it can make the pull this week, jfyi.

-- 
Jens Axboe


