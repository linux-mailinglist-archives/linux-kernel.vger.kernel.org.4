Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D166E19C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDNBfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDNBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:35:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F3CA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:35:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso4726410pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681436112; x=1684028112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plCLedIYAsqNnF0GFCSLgqWvPF9OpWHyrxzXNdvY8IQ=;
        b=biVpw3y6TVDKHZQR+2MDdpqk9NQdEoamzjv8Haj+VIuc51lvg5QNl5Ftd1SXcmkLpH
         rgpR9HbbQPk7w1SAh/047X0BA+wv+SdAyMHMMuo1gaQwVgjnYol/jBFDBDQ6r96INd8R
         z477L1cYgfNsm6VMCZUzJq6LlBDS0F/C+AC6E+ldHTPyqvZZQZJXbK0JEBmRKWHTyuu3
         78S/JNpommNl33fEwf9f0VajqOQxOvFX/PTSG41B20MVIQ3wkHb60If7l4tYcm0EaSIj
         JqRkMHFOtRHTYGnxY19ZXK/OMI2ZWQrv9N9jL58e039fgOIpTHMj8JNEtAMt+9vFlpMo
         OCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681436112; x=1684028112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plCLedIYAsqNnF0GFCSLgqWvPF9OpWHyrxzXNdvY8IQ=;
        b=SuhvCg5Bzxl4GO4nGe7utGj5F+kDdzYc3uic9fA0tyyuAH6xoOJlYtTQbBGz29khge
         PsxMeAOpOz1HkzdwGW89e9vOT1z/axDydFGtRnWHdS95L0XihToGkudmN+soCzpk5BWr
         GDwdzf3jbeBHxlC0N/vcarPeDcnoveicK6GYSULcN70sMBkr2saiHU+3TxKSUaFeonGX
         dltQ0IlQDCiDySIMPp+wHN/AeVada9DWwe9Fvz9iOZ7JgupefoiCNnB+J3Xb5eMgiJgc
         g+Z8aRqKFP+jDxazWWEcL3vD6eSwJO5ytJdS8gts7hMWaj5rRItcL61nc3X0jQeL6n0p
         myZw==
X-Gm-Message-State: AAQBX9fhQyapL5bEVXY/DfJz95cVWWbuUuL/tUpmVB3kbmak0b7OsyrE
        x14UJqBTrtwI+qhsN4qwrOE=
X-Google-Smtp-Source: AKy350Y8w1QKb4DEb6j4qg8xa1LERVJD9HGnXcsED39DUxLPYMu5P/HZqKO5I9yl0YqYaGJjcxw0Rg==
X-Received: by 2002:a17:90b:180e:b0:247:4186:69b4 with SMTP id lw14-20020a17090b180e00b00247418669b4mr110482pjb.21.1681436111651;
        Thu, 13 Apr 2023 18:35:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090aa60900b00246f9725ffcsm1902634pjq.33.2023.04.13.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 18:35:11 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Date:   Fri, 14 Apr 2023 09:35:07 +0800
Message-Id: <20230414013507.184195-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org>
References: <20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> The core idea of this patch set is to enable users to perceive the number of any
>> pages merged by KSM, regardless of whether use_zero_page switch has been turned
>> on, so that users can know how much free memory increase is really due to their>
>> madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
>> all empty pages will be merged with kernel zero pages instead of with each
>> other as use_zero_pages is disabled, and then these zero-pages are no longer
>> monitored by KSM.
>

We have sent the v7 series, so some old codes might be changed, and no need to talk
more.

>We appear to have some outstanding activity on this quite old patchset.
>From my notes:
>
>- An unresponded-to question from Claudia:
>	https://lkml.kernel.org/r/20230307192421.30ab869c@p-imbrenda
>

Claudia is right, but the v7 patches don't rely on rmap_items now, so we can skip
this comment.

>- Hoping for overall review from David
>

David's review is great, and we accept his advice on the basic approach in v7 patches
to track the ksm zero pages. and now the v7 patches use pte_dirty to mark the
KSM-placed zere pages. But since pte_dirty is related to architectures, and some
architecture may treat pte_dirty as writable, so we restrict the feature of tracking
ksm zero pages only to the tested and well-working architecture.

>- Another query from Claudia, and a response indicating that a v7 is
>  in the works.
>	https://lore.kernel.org/all/20230307194320.79373a26@p-imbrenda/T/#u

The v7 series don't changed it there now, then we can skip it.

>
>- Another unresponded-to review query:
>	https://lkml.kernel.org/r/20230307195119.745d0b46@p-imbrenda
>

The v7 series have referred to Claudia's review but made a few modifications.

>- Another response indicating that a v7 is coming
>	https://lkml.kernel.org/r/20230307195313.2e21245a@p-imbrenda
>
> So I think I'll drop the v6 series.  Please address all these things in
> the next version and let's start over.

Yes, the next version is here:
https://lore.kernel.org/lkml/202304131346489021903@zte.com.cn/


