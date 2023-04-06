Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2798A6D8E00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjDFDcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFDcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:32:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0B213D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:32:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n13-20020a170902d2cd00b001a22d27406bso20403990plc.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680751954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBLdjQ2Sx3gID5YPP8UTpMv/+YYtQNABoLcsaIMqgpY=;
        b=NX5rc5JhgVbqA8LK5Y0tfvtf1I5HPEbaZyIcv1UkHucbL5NdvtHaEokrc9pF0+q3NB
         QqXDnBTXsfo4a64F6d4T/b+Pv8pKRvva/VLqm/9HtRMB7qusqmn4aElwahu1y23npN22
         IsgIroFtgV6Eo1jlDD8vmVo26n+s5P8zb8IWaPj8RcYkI1IVE+lgtZ8nRS4O6qgKYrDL
         30eQ54C60XzLetr86UN8w5c1MYfMHqzWVtijMUfPiASFwn8wV2zwxOYmV4yZIKAh+wD/
         CAt5dFdewEZ11jov3zxkOmkWNroODgZUq1ao0xamxX3nXZVHX0IHri5MJVD8/j+AUwKt
         u32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680751954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBLdjQ2Sx3gID5YPP8UTpMv/+YYtQNABoLcsaIMqgpY=;
        b=06Mugzz5kjONJGe1WmrGi4ZR16u38MDh2j2Zqs0k8XqYNj1CLpuQ4bsGrJNfC5HCyb
         5G+Xp2c6SGa0KktYsS5qea6JZRkcc2iIa+aNi/q0hN4x3NHt0AFm/m65YN3frXfKGrdm
         mA3wzU4NJawUIhP0SdyQ8iGULcNMerSfikvbBzdyNpPoS7znjeKpPJGpVRJBHDqLLjPd
         d8sefi97meZO4RV8kO56T/bCs4OlDi8D0p6AlobOo/FiFv8nV8VpFU3SSsNqTZDjG11n
         FJgXRjhqSkPkJXXoiB9s8XZTqsU6thgZ5zD8j00Kr+Top1M6Yu/bW0MR015GiNbH/dUf
         VgnA==
X-Gm-Message-State: AAQBX9cUB/GVXTrn410cJohIBihuZPY9Jzo2z3rSI8+yA4lJzK60TuMP
        PokrcfZiWrpfawxSKFDoYxT+NUiOJ/c=
X-Google-Smtp-Source: AKy350al2zbUkyqfn8XGPWlk/Rw6pGDk6wQ9IPJfuIJerTrG8XWdmWTYG5fgQQrHSJY7uTLM1gE6gRglwpA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9b91:b0:1a1:9015:4d5c with SMTP id
 y17-20020a1709029b9100b001a190154d5cmr3270761plp.3.1680751954171; Wed, 05 Apr
 2023 20:32:34 -0700 (PDT)
Date:   Wed, 5 Apr 2023 20:32:32 -0700
In-Reply-To: <20230404122652.275005-1-aleksandr.mikhalitsyn@canonical.com>
Mime-Version: 1.0
References: <20230404122652.275005-1-aleksandr.mikhalitsyn@canonical.com>
Message-ID: <ZC49UDfayQ+XJRUt@google.com>
Subject: Re: [PATCH 0/2] KVM: SVM: small tweaks for sev_hardware_setup
From:   Sean Christopherson <seanjc@google.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     pbonzini@redhat.com,
        "=?iso-8859-1?Q?St=E9phane?= Graber" <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please tag patches with RESEND when re-sending the exact patches with different
To/Cc fields.  Not a big deal, but I blinked a few times trying to figure out
if I really had two copies, or if it's just time for me to log off for the night :-)
