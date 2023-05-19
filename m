Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F870A15B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjESVOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:14:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC9397
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:14:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so954240b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530869; x=1687122869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIrenhBfdJ9S1GglddRp7FAjwWj6W9avRM9R/GOtq4o=;
        b=S6JW210SimyXQteMWDUCvnrjqHSMWR9FlhpN6Gfp8JzEhWQsc/oawiq3wLPDUZA9vK
         fBzaGKtIlZ1TIUeiQOm/SdN98MjUGkNdW6mOGMb0VAT6a0zyW2oHeScXhM0vALh+Q9U3
         00mdNeGsdjXBsYWyVisypxU/dTZ9sqejCiOYtl8Yoo1qeB34jnmBlQc7G8w4j360jsvZ
         F9J0YoUVbuFUPYidnTyV4facw2EVUg69OJ7nZPF3ksqC+/ZCqa/GPlgzFKVbuQvzC0xB
         o32Kl9kUzd/oXbLVJgkO4+94p4BtGxG8bunOphyLZtgzG8WhvpNbFFFqUEFCv0HgftpS
         QnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530869; x=1687122869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIrenhBfdJ9S1GglddRp7FAjwWj6W9avRM9R/GOtq4o=;
        b=boEzHpX6RfQXdrUwYDEbOX6lrfIKm+LteWGowncs611cOpoIYt9obZzk6tOUFbOdGZ
         5J9cNQpEQa1ItZU6nMa9setWgkuwBiNT+DZFA7NcIk3MGLRQcRvAsOqdpZXfvVG+t5gB
         LXl1BHZSMsZxf56B95U8Uc9Q06Jk92fOr/uZ4JRbCf93eb6yfBT4QUqabbUabqp4BhYu
         9L6W35vVeNnqSs2AMp2UIuWScdXJoJrq1Tli8Z6KPq28U81o20wszjFrXlpNo4EslTvQ
         mSV8vuQWkIedtZKXPO+ezqTkFhTsQc5/6JEuDHxwSeWoAS8EELnEpyaOcYV3LvssLroZ
         qffw==
X-Gm-Message-State: AC+VfDycBavRsdZCMLi9iKWaDlv9a8gIe4vxDNinHM+Hl0psQD5Pcgt8
        cnl+k41bWwZVB3S9ho5PuDc=
X-Google-Smtp-Source: ACHHUZ4dMVRliZxns6wTFOga0mP6iABSlp+aoUohWPu+fMi/VXG6CHEbD8VZs/+6Pm/X/5KPWjTHJg==
X-Received: by 2002:a17:903:183:b0:1af:98e:5b9b with SMTP id z3-20020a170903018300b001af098e5b9bmr673080plg.10.1684530869217;
        Fri, 19 May 2023 14:14:29 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709028f8200b001ab0159b9edsm54318plo.250.2023.05.19.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:14:28 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, minhuadotchen@gmail.com,
        perex@perex.cz, peter.ujfalusi@gmail.com, tiwai@suse.com
Subject: Re: [PATCH] ALSA: ti: Use pcm_for_each_format() macro for PCM format iteration
Date:   Sat, 20 May 2023 05:14:24 +0800
Message-Id: <20230519211424.3381-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZGV9m6KbuIMWOX13@finisterre.sirena.org.uk>
References: <ZGV9m6KbuIMWOX13@finisterre.sirena.org.uk>
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

Hi Mark,

>On Thu, May 18, 2023 at 07:42:15AM +0800, Min-Hua Chen wrote:
>
>> Thanks for your comment. I think the subject should be changed to:=20
>> "ASoC: ti: davinci-mcasp: Use pcm_for_each_format() macro".
>
>Yes.


ok, I will submit v2 for this.


cheers,
Min-Hua
