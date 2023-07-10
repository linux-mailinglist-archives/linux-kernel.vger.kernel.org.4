Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60674DCC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjGJRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGJRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:49:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9564128
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:49:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so9518934a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxeverywhere.org; s=google; t=1689011375; x=1691603375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3fPDJkJSayhRNB4BcC6rS+X8788M3CNjhDGuen+6y4=;
        b=D9JhgLsqr9QZNB692aU86cCtBh/ZGjpD7pyQX908xwIRqYXkThYqltBoTeLa2ZF3dh
         y0ox+g0uZNFpbk4lL+fpikRLCfSb/MelWdr+qspy6JnBnhCzirhdNOTDL3bwrAt3tEqb
         04/h0wxTNJX2HIKjnLb/5fpRPChjzMH07W5qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689011375; x=1691603375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3fPDJkJSayhRNB4BcC6rS+X8788M3CNjhDGuen+6y4=;
        b=ZY+WJgrgxXW22WboHmwrHLk2EPJC2YnvnNcuyjiBJ+guCq+lRHL3muGcGDlX1wxlm9
         ktvivhT2M6l/jkvxVFufStI7RPcQQrNYRJ8CgHugAjWFJutMCoUyAL247uNquW/VlFHs
         enXV/RKwEUHGkX98LkKVRixlWjyv+fEpUoG8wsDTBAP6ZBQMmu3orWAp5qgpyyIXSD9z
         tiUubtuEAqw9i26ITOVWvyDWPmyLW2PsL7NnY2ExXjTlhsClkRInc95nfvY64Hkg0tOE
         chEvtuqeoW8oUYlIYwN1vJPtgQvNWF30H23B+LfGPlPExMTX2OO0z9UjVmB+knq2gD0D
         NTPA==
X-Gm-Message-State: ABy/qLY7ISw14SjpUp0+Oi1Qbwnp0rFYiWLy8p65NX82n1WYXIVhw+OG
        U4WGJRtEqFdShzgSCeyFnfNSpA==
X-Google-Smtp-Source: APBJJlFFKXHt2Q96u8BmShNFV74GO43Bjf0If8DEYBq8SooT0TpOvc70Sq9JQlj01rldsaOtWmOx9Q==
X-Received: by 2002:a05:6402:1e89:b0:51e:3341:a9b5 with SMTP id f9-20020a0564021e8900b0051e3341a9b5mr18502684edf.18.1689011374986;
        Mon, 10 Jul 2023 10:49:34 -0700 (PDT)
Received: from localhost (83-84-189-87.cable.dynamic.v4.ziggo.nl. [83.84.189.87])
        by smtp.gmail.com with ESMTPSA id m23-20020a056402051700b0051ddf53c623sm17683edv.2.2023.07.10.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:49:34 -0700 (PDT)
From:   Jan Visser <starquake@linuxeverywhere.org>
To:     mario.limonciello@amd.com
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        andriy.shevchenko@linux.intel.com, dridri85@gmail.com,
        friedrich.vock@gmx.de, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmschulte@gmail.com,
        npliashechnikov@gmail.com,
        Jan Visser <starquake@linuxeverywhere.org>
Subject: Re: [PATCH v2 0/4] Fix for interrupt storm on ASUS TUF A16
Date:   Mon, 10 Jul 2023 19:49:26 +0200
Message-ID: <20230710174926.5760-1-starquake@linuxeverywhere.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <994042dd-9532-0dfb-8f86-98c897db75fd@amd.com>
References: <994042dd-9532-0dfb-8f86-98c897db75fd@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes keyboard issues on my Asus TUF Gaming A16 Advantage Edition FA617NS-N3085W

Thanks!

Tested-by: Jan Visser <starquake@linuxeverywhere.org>
