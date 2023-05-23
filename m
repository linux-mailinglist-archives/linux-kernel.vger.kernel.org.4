Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78F70DE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjEWN5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbjEWN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:57:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653F8E5F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:57:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-253340db64fso6811218a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684850233; x=1687442233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE5pljgoQG181tjwuhg4W/JZgWLsjKIcNLZqb+B2pwg=;
        b=naCmkZ+ge6/s2VO38wiDl4LMWZA24oDqNGbSyjWkqLEEpsSrL2UZfnEbbWaQwyahab
         djCRmY33ZnhyT4jLZLEdTnPT4HN1BqKmpG5k9BYhUbHqfHj5+jMEvv4jtxX1C1w4b2tW
         26ufViFYncJYmgNOqcaB8+wh+SlPc5JJlA9PldXPXmaDE5GcogmwOWirr/1Tl2sd/qOT
         W2g9NUZFJN1hjZqqe9q3iOps0XxyY4T3xAtZk9+T8wr12wn4KptpmrAVBNVaOaUSz4Lu
         vE+CT3YvLckAixfu21WF+eve7jxbwYOsKeI3eDd7dtO+thGK3Au3oVGzTxB23gcnAAi2
         gbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850233; x=1687442233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE5pljgoQG181tjwuhg4W/JZgWLsjKIcNLZqb+B2pwg=;
        b=SRUl1JKIA3SUZv44Baa0b5TSapnPK4qg/oiDkoYYcBVr4M+3FS6LQVwhJs37DI41No
         4QhD95DZBmoj96dhqC+PumBA1Z1+o4Hhzw2bm9RuaTMu0RsIgULUJigZxseoZPHAYjou
         8gliJwO2nhHHUtEZI7ISMabxVIGosRTQxeLWhMaLU+gE6KU9mCZ5f5vvzinLVXM/QhYG
         KMmKODuHTmI5gSlRZ2miD7GM6h4D6PNMps6hZgAVoLPiuy7Up7K55XsdZDs7EOJrlf4W
         XBVzI7Ja497op/x4vZiIScM25DjzaCKmEsX2WkLmOKHQXwcbqlCfMMxC2SXtODGqlL3b
         zr7A==
X-Gm-Message-State: AC+VfDyRjXpbjMdvLbWIf5FgMAzMDMM0LPoPtWbWxlf7T3+C+Li3QOSw
        /ICp1LNjc7EDtBdIL9izj+M=
X-Google-Smtp-Source: ACHHUZ6Id+zBNB8WNjEYqXttPKy16f58rmZEC2yONMtyCsgnTTKt4TcgKh5kBq0/CauftKSKxHUivQ==
X-Received: by 2002:a17:90a:71c2:b0:255:70e1:e41 with SMTP id m2-20020a17090a71c200b0025570e10e41mr6031679pjs.19.1684850233201;
        Tue, 23 May 2023 06:57:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s31-20020a17090a69a200b0023a9564763bsm8226319pjj.29.2023.05.23.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 06:57:12 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v8 1/6] ksm: support unsharing KSM-placed zero pages
Date:   Tue, 23 May 2023 21:57:09 +0800
Message-Id: <20230523135709.6902-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1925d301-462d-6b33-8867-4e1646b2dbd6@redhat.com>
References: <1925d301-462d-6b33-8867-4e1646b2dbd6@redhat.com>
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

>> ---
>>   include/linux/ksm.h | 6 ++++++
>>   mm/ksm.c            | 5 +++--
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index 899a314bc487..7989200cdbb7 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -26,6 +26,9 @@ int ksm_disable(struct mm_struct *mm);
>>   
>>   int __ksm_enter(struct mm_struct *mm);
>>   void __ksm_exit(struct mm_struct *mm);
>> +/* use pte_mkdirty to track a KSM-placed zero page */
>> +#define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
>
>If there is only a single user (which I assume), please inline it instead.

Excuse me, I'm wondering why using inline here instead of macro is better.
Thanks! :)

Thanks for reviews.
