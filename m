Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BFB70DED6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjEWOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbjEWOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:11:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DDE43
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:11:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1afbc02c602so14681965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684851074; x=1687443074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H4Y9LOWc0olNcXTJ1OgzMgJyqMLn68QmxQ5MJNIIbk=;
        b=hm0QvYO2s07hmkORFZZR4aVyZ/jqwyle0dMvFSk5q15ngH4GxUS3LLxTamXa5eElWb
         IOeM/maPPtabDfU38GwHjIrtz342LMcUoGsDWCVgOWhU9XSyQ/I0NY/k85ptEnu/KgVN
         BHRGywKBmdEkHTGKKm4f8ndGWoqzUi9TJL+6nftZkBXFAXyXmVqmsQXAX0auRKSPjz56
         Q9l/vZTG9ApPNNZY4IECfKDjWpMw6liB4F3zHjtfICmFbRzWJHb0JH6qH12Q7AgJlGDZ
         CuqEJQS/9sM+JX18ywoGohtrVQiMB4qVj//D43zfO8X1/+FWPQOcPqRCnOrPpHVU2p+R
         +jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851074; x=1687443074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1H4Y9LOWc0olNcXTJ1OgzMgJyqMLn68QmxQ5MJNIIbk=;
        b=SPgJpe+/RErpzWIxmvIzc2Pn84mkdIE08TkvcDgAS2YqCFYDzaWe0FH7Nxb+aE4o3D
         LqPOQ6DACtjHn4Gu62SvjMXcAAKdq6mG2rxIvP0fuHA1ti8NaxDVZFlNnO6Zxc5XQO1Z
         Eaffwo2Vyf9H7rNf+nHk6pfc5wGECq/0/CLUuGk5HV6+eGPpzNocGsyovOIFk8qUnbKC
         6uFrgRcg+M3Fm+CmcfVRLFmHZqF5SVESq5E4/g6IBe9rygB7hxPtXWJZN4a0P134xIxV
         7vmvJVfXPPurWOMWGoTpTBeGmicIuWWhDmVUV4lbeBIim3PLzCXY23JvICfBQF23tK5S
         6gVA==
X-Gm-Message-State: AC+VfDwMV88QsTm8Byn9wwKTuF1ja7HnQVbCVzByI/iVX5yJiGgeBbCH
        BOJjvViGFnhY8YLHA5idcZU=
X-Google-Smtp-Source: ACHHUZ4ycx9P+8OCyOMv6MFBgubqypR+yajC3BrfXalqIHe3gYxh3BEODb7MOEU+664j5MNHZkU9iw==
X-Received: by 2002:a17:902:e5ce:b0:1a2:a904:c42e with SMTP id u14-20020a170902e5ce00b001a2a904c42emr16753653plf.24.1684851074083;
        Tue, 23 May 2023 07:11:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001ac937171e4sm6834511plf.254.2023.05.23.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:11:13 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v8 1/6] ksm: support unsharing KSM-placed zero pages
Date:   Tue, 23 May 2023 22:11:04 +0800
Message-Id: <20230523141104.7029-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4b7e4d48-f0f9-c0b0-e8e1-2678d0306252@redhat.com>
References: <4b7e4d48-f0f9-c0b0-e8e1-2678d0306252@redhat.com>
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

>>>> ---
>>>>    include/linux/ksm.h | 6 ++++++
>>>>    mm/ksm.c            | 5 +++--
>>>>    2 files changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>>>> index 899a314bc487..7989200cdbb7 100644
>>>> --- a/include/linux/ksm.h
>>>> +++ b/include/linux/ksm.h
>>>> @@ -26,6 +26,9 @@ int ksm_disable(struct mm_struct *mm);
>>>>    
>>>>    int __ksm_enter(struct mm_struct *mm);
>>>>    void __ksm_exit(struct mm_struct *mm);
>>>> +/* use pte_mkdirty to track a KSM-placed zero page */
>>>> +#define set_pte_ksm_zero(pte)    pte_mkdirty(pte_mkspecial(pte))
>>>
>>> If there is only a single user (which I assume), please inline it instead.
>> 
>> Excuse me, I'm wondering why using inline here instead of macro is better.
>> Thanks! :)
>
>Just to clarify: not an inline function but removing the macro 
>completely and just place that code directly into the single caller.
>
>Single user, no need to put that into ksm.h -- and I'm not super happy 
>about the set_pte_ksm_zero() name ;) because we get the zero-pte already 
>passed in from the caller ...

Oh, I see. Thanks
