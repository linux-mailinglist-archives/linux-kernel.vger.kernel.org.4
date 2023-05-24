Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9D70EFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjEXHzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjEXHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:55:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D73B6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:55:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so440988b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684914944; x=1687506944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX2B4bEaAlSoT9esPLaj9XAKt9Dpa0mkiSapMFXuv3Q=;
        b=jYfZnFBwdllj3lBbr3grVPfUGpXtIHW92GZJk2eMyDCCdcMmI7G2Y9NzVjk394UHix
         tR7Q+Hg/9HQXg8ryTeq/LrGqw5Odezuc1XcqBkMBmv72h9lZZrpEkY31BFSAlhwYVuaS
         tV3K2u9eqnCQwlqik3mf2ZqdRBFlWGDUoTWAeY5MAS1FOvCu47pcgqZgymIgnJIn74r4
         gEi7E+AopJjq6fnelrQMs1ayE6A+ayYh+JcaUWxIoVulH4EEmDNCAK6QOloSrwqVho43
         nF3lFTQtuJpU8zT0oAOdisRygOFnNR424kcQM+hGrCDQAa74XicyFLb0t5F0SKPe/Ped
         zzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684914944; x=1687506944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX2B4bEaAlSoT9esPLaj9XAKt9Dpa0mkiSapMFXuv3Q=;
        b=jDyJOky1QJw1tpXgj5hh+q5KvhoKUgFNAmHPbFQig0G7BEmGbdXyJsCcpG7DCeGiw8
         5jL0NyOkDVDuwyWFQWvkkENhhc9M22T5U/MbAjR6s8UY6YbavYwwh5XekHUC/T4OD6Vi
         632iFefGMEm4cMy/ZH7oyu0A6SuzUtx634Bcq5s6Ba1azgSY+B2i63QAhiYIg+HAQvzI
         15alSP3IQW3u1FAgb3CIzHewP6N1r7S6afql+ZfGvv0si2jQPxvwRXPKw8VD4Qnq9IUv
         mvSuoknkN6WDAoOVczx9x4WOTEUT20DTGvgx/R9A2w1u/lJfhml1IINrJQHsnQYhrl5V
         eevw==
X-Gm-Message-State: AC+VfDw1/QnkLKLF076GwOUjVixBdeSuEP3N6PT1AqeW/khuwGP/nFpP
        deWGp7Spi0O2rv1ONyQ9mkE=
X-Google-Smtp-Source: ACHHUZ6hxr9Dc2l7EB8ReE5uo5Xxjw4BVr7ZeJFh1NwVMnCm4hCjcqqkAmaB/O3V6K8qzPHZrE3CGQ==
X-Received: by 2002:a05:6a00:b50:b0:640:defd:a6d5 with SMTP id p16-20020a056a000b5000b00640defda6d5mr2357697pfo.12.1684914944196;
        Wed, 24 May 2023 00:55:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k4-20020aa78204000000b0063b6fb4522esm6885034pfi.20.2023.05.24.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:55:43 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v9 2/5] ksm: count all zero pages placed by KSM
Date:   Wed, 24 May 2023 15:55:39 +0800
Message-Id: <20230524075539.20844-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <52bfd744-3086-a22a-e2e7-8b64d5fccfcc@redhat.com>
References: <52bfd744-3086-a22a-e2e7-8b64d5fccfcc@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +extern unsigned long ksm_zero_pages;
>> +
>> +static inline void ksm_notify_unmap_zero_page(pte_t pte)
>> +{
>> +	if (is_ksm_zero_pte(pte))
>> +		ksm_zero_pages--;
>> +}
>> +
>>   static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>>   {
>>   	int ret;
>> @@ -103,6 +111,10 @@ static inline void ksm_exit(struct mm_struct *mm)
>>   
>>   #define is_ksm_zero_pte(pte)	0
>>   
>> +static inline void ksm_notify_unmap_zero_page(pte_t pte)
>> +{
>> +}
>> +
>
>Having proposed that name ... I realize that we call this function 
>whenever there might be a zeropage mapped (when we have !page after 
>vm_normal_page()) -- but it could also not be the zeropage.
>
>Not really able to come up with a better name :)
>
>ksm_notify_maybe_unmap_zero_page ?
>
>ksm_maybe_unmap_zero_page ?
>

Analogous to the existing name of ksm_might_need_to_copy, so maybe we can use
'ksm_might_unmap_zero_page', 

>
>Maybe someone else reading along has a better idea. In any case, the 
>logic itself LGTM

