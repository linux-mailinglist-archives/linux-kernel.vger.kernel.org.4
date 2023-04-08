Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689DA6DB913
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDHFgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHFgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:36:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E00C66C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:36:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a25eabf3f1so5183455ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 22:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680932173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xKEp1vGQoHylUbCKGMB8I0y56DWTKFPtIpn1BJwUXQ=;
        b=FgskmU4FyY+9Vc26t1ffAaQC/h3UmBwArGhMLqdS6Yv3NhDvOzXxlGaw2IS1rzFBf6
         Sc1wrTOfVTBKKsccERiZa/BYKbshwLJJwnUnOUpEI7ejG/YiwnWqY0ehAN4Vlj7eKCJi
         QNQRyzhTdp4jx1PXDDdq/iNltQhHbwCk/FWRB+XjDAq8aoVPOcOXX7D+QbepFrXynBci
         Y6oSYp4pRs9UVhehqwXo8PHnBUWxgBeabromim6SS/cNDuBUTleOFt3JX2MkMyc3hBk4
         wgRNMmIGAk48M4wRz9X7/gc8sjd3rW1+rOsxEDZXNPwL8Nv1HOql2HfZEX9wSQ4gfL7T
         LeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680932173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xKEp1vGQoHylUbCKGMB8I0y56DWTKFPtIpn1BJwUXQ=;
        b=45tZTmuvHBqdzB/1ruORzLjTUNWkyAZX3JQEF2LsrQ09sYQoVDM/4XHqqkCI7KP3Nk
         NBehj0u3x4YAzeRx2kG0sjbEnUgK3YJHKqWFvrNAvZXd5J3FP8JtY7gSEQH/T5NMmDrC
         SUAhl7qwjEQiINMr3iskTMbrezZcdjoIIcAJ9Hfd9lA2wOBpdeZd90eYVU4cXcNIeY/v
         EP3LZDZ5ajaOmyEs0TKbJjsCFCF5ygsDv3+Yl7oZIl0TvcEgXM4QRfIDhnlavBDJZ1Db
         PFv30mIBuIxHMB27osfA8LbQC1LZt2FxvGBE2Ut/8/UDnwWwPZifBJ/0yKRzgwPKrg4W
         Hihw==
X-Gm-Message-State: AAQBX9eSUWssjKdr50lfJgxFgyGZ3p8ZoQyMvQDzrdlIhc6jpoW7U86o
        AhDm8S611uEn2cOqamOggUG7lg==
X-Google-Smtp-Source: AKy350ZeTSJD8x+I2T6S6eGklcOinuABtyV99vGlRap2IofVQlQsWuwjNk4r+R5nsddsvGzt1gvC3w==
X-Received: by 2002:a17:903:844:b0:1a5:1f75:ed7b with SMTP id ks4-20020a170903084400b001a51f75ed7bmr1586923plb.2.1680932172979;
        Fri, 07 Apr 2023 22:36:12 -0700 (PDT)
Received: from [10.200.9.10] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id ja3-20020a170902efc300b001a525b082a5sm533938plb.199.2023.04.07.22.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 22:36:12 -0700 (PDT)
Message-ID: <fffd59ff-eaa8-bba7-03f2-9fc27620bd1c@bytedance.com>
Date:   Sat, 8 Apr 2023 13:36:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230408050822.ezdbhc6j7zuvutrm@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/8 13:08, Josh Poimboeuf wrote:
> On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
>> Make __get_wchan() use arch_stack_walk() directly to
>> avoid open-coding of unwind logic.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Can we just have a shared version of __get_wchan() for all
> CONFIG_ARCH_STACKWALK arches?

 From a quick glance, I think it's ok, but we still need to define
the arch's own get_wchan_cb(). I will try to do it.

> 

-- 
Thanks,
Qi
