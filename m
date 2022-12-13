Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2664AF59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiLMFc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLMFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:32:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852713D43;
        Mon, 12 Dec 2022 21:32:48 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f20so2234268lja.4;
        Mon, 12 Dec 2022 21:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm9joTADv9j0tGCJx1JGU7wkHn1gQO4t8dEAYaWXy70=;
        b=RJ89sCv95B86fePFNIw8H8q36kNGtnKn9vO/d0aReZkcx8fTSv0+pQfLQXd/P0BmU5
         n/RhsjnZp2rHcKo0q4lZlQ4VkAVkgXFvcLRQbl8WFEdyCh+UTxVz0IFLZJyYxxPfoxem
         6DoFsbp46mI+q1Zm7GJ/PmOQmelZh8VEGjTAev36HXgHJ2ZbtJdQtmpBLwaffzQCNIZy
         IaM8a8B9ZTLbI2/aH5vLvBJL/kMxLCKYoA+PLBIVg6u8cOtzccfjQe5CS+CiaWEeXvF4
         HTPAvN1FBueHl1V+jdE4Pxdkol/tfM2IAa34m20A2KjUwQoGubZ4H3cjyelZuWMGLxHP
         76uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qm9joTADv9j0tGCJx1JGU7wkHn1gQO4t8dEAYaWXy70=;
        b=kfoKjfXnRvxTc2IzLJk4MjKVv2ZVGZJbhZKrpT4NF/f5l7SpjONBb36NqcK8VP2FYC
         0khZp2wkZ9Sdj8qsOUeaHTGnbPn7w1TmTvw1rr7WQ1t7L6DNAqwv89rzfLNLQmnSyk+e
         LM7ZFGp9w3Sf0+T3OjT5m5xPKihmUr93aT/cvEB48ijd/G7eA/R7GA7cVd6Di6bjbpQS
         eaSBCLqRIyuK03FTAyuF2R/vkyuX1zBfYLvkAGB5BkbNjRSsZAhTgKNXmhMkIunXxIo+
         xKgQSAQ9nkwGieTpgEfZcre03Yy8BL0Vvl/ZYLICEJkyCRqdU0NISw94n4CADat3+5ai
         +LXQ==
X-Gm-Message-State: ANoB5pmtx+UZobFtZYfgbsiGxoWulYZ85zQbzA86TdAXE+MbV1BBF5XO
        m8iTmjbQtOLwt7pDPaEqGZAafdsQr1+y4FxWa5H7YEpIDz6Q
X-Google-Smtp-Source: AA0mqf46EQTHpmYYKuD32y8kyBx9XB2ds8BeeUCVtOBg92geJdHPie+7BcpJJbgbfg0QwB3aX5SbyEYaiZHO/VFMtEs=
X-Received: by 2002:a2e:8887:0:b0:279:f19b:2192 with SMTP id
 k7-20020a2e8887000000b00279f19b2192mr7781433lji.471.1670909566618; Mon, 12
 Dec 2022 21:32:46 -0800 (PST)
MIME-Version: 1.0
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com> <1670763911-8695-2-git-send-email-Arthur.Simchaev@wdc.com>
In-Reply-To: <1670763911-8695-2-git-send-email-Arthur.Simchaev@wdc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 13 Dec 2022 13:32:35 +0800
Message-ID: <CAGaU9a_Td7Ks0tJmkxev54CJrCy0Fs89juzUd=M0G+m8+eS7wQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ufs: core: Remove redundant wb check
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     martin.petersen@oracle.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 9:08 PM Arthur Simchaev <Arthur.Simchaev@wdc.com> wrote:
>
> We used to use the extended-feature field in the device descriptor,
> as an indication that the device supports ufs2.2 or later.
> Remove that as this check is specifically done few lines above.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
