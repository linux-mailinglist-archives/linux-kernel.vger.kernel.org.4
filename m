Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC348636B20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiKWUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiKWUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:31:03 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DAD48DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:26:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j16so29789771lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+SY6H+ASUzdWQAFa/AimOgEOUr3m9mP0SkfLMEBDEY=;
        b=UZGOJ5khgyJP8rK9BaiD4cIFc5szUoeBQHbpMdpb9L4zwdOBYtINiQzjO3mafWueBO
         MerEVi8InCMcbt5K+8Qs9DYaxovdSV9Nr2TdztfIXBrios88jzuI5Z222qdpp6vUuw+/
         PerkGoS1BDOMdMobaw0nHB0HgCQELqCxXM54Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+SY6H+ASUzdWQAFa/AimOgEOUr3m9mP0SkfLMEBDEY=;
        b=DYuSvlkM6nXY0J3pLhV8LIiDkvkT3owLypt+bU9ncQ46mT4jvxqPY82qDpmvY1vWv2
         kqpj4PYL1NDHnsX0+JHCOfDSWTxjUvHSyaTODWoxmuFoWHRH/OL74OC4OAHNTBNOQJY7
         M22HwF4vs/rmS7fmqQJNLaGwlJoOe0f6Jx3zqrqVb53gZQZZW/AtWOPJ2zl/nAN5Hjj8
         eXI0QZLqxpR8q4e6qtXVCX789MfDKMTJ48sm6L7ndhI2YaKtJWp1xakBvyOSTGWiQANo
         lR6w1sGqwxF8CNDYUg4so1bMz0dpBZUDa/9oqRQuVFP65d8J7vs8Ug0EBdxP5ur1a0OQ
         k5QA==
X-Gm-Message-State: ANoB5pnHYqrM1+JTu6/4yySYt/MW7Z78gs8go1txHDbIoNDAQZRAqshH
        eZuTqRYFJDjWTzVy7ZC3dLt2MRk7NnOzK5nuuqlisA==
X-Google-Smtp-Source: AA0mqf7ADnrNqxBDpnqHEOFPEDq4bmZfZg5LDEblHGw3d1kpr4ieIUohtl1V5QxQQERMef6N8eiEIyW/s5T+s2EYLbE=
X-Received: by 2002:ac2:46f8:0:b0:4af:5088:8fa3 with SMTP id
 q24-20020ac246f8000000b004af50888fa3mr10538465lfo.538.1669235167770; Wed, 23
 Nov 2022 12:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20221110203405.611600-1-dualli@chromium.org> <20221110203405.611600-2-dualli@chromium.org>
 <Y35tVQb2y+gRdfpb@google.com>
In-Reply-To: <Y35tVQb2y+gRdfpb@google.com>
From:   Li Li <dualli@chromium.org>
Date:   Wed, 23 Nov 2022 12:25:56 -0800
Message-ID: <CANBPYPjqO0pVQseqGXfi8sNVOu=ZfqUF8WiDD01EF=SgkenbMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binder: return pending info for frozen async txns
To:     Carlos Llamas <cmllamas@google.com>
Cc:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, surenb@google.com, arnd@arndb.de,
        masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:58 AM Carlos Llamas <cmllamas@google.com> wrote:
>
> This looks good. Could you rename the new op to signify the frozen
> scenario though? We might have some other instances of pending
> transactions in the future so might as well be specific here.

Done [1].

v3: rename BR_TRANSACTION_PENDING to BR_TRANSACTION_PENDING_FROZEN to
    signify the frozen scenario and avoid potential confusion

[1] https://lkml.org/lkml/2022/11/23/1472
