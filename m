Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC176D28AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjCaTb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCaTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:31:24 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23882031B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:31:23 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id h34so16911104uag.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680291083; x=1682883083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+3dxiSE1b5vMH8CGGajC9u8RQm7fB9GO6qLHC2uiED0=;
        b=mw2AmrfS0Nxie4InDrhi9cdWmJuP1bvHcGUpK8/JmOI0zD4F/vIQAp5F+K8NeQELCY
         YwIVNQSd7eB7LUrkWnRss0WXSKP+pTP4+gzLS0i+gcGaZcuxTvdsL/nlv3m6zcpRKwBu
         p1MgKqI9yT1w94qw/e8LEdTo9uybAhDY9V3hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680291083; x=1682883083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3dxiSE1b5vMH8CGGajC9u8RQm7fB9GO6qLHC2uiED0=;
        b=1zi7G8ggrQnCXd1uRL6hw9SE2dBsfLxfbp3xAJBqa6YNIJJtwborXy3cpGui2BHGZX
         2sBblA6N090WgUKo9DU4qAJDg7tiB8BNXk2QQqt0B/sJOxEpouVQfghZjXtKlywVxa4S
         wmlAyX/U5x3wcJ8urJv58I8+BIQGjFvDhMnmcwn9DXykAQJ/0LojOsEMfdTZeSqc+a4e
         zw7paQaqNsm1coeICK64wigVHFxuITgABYxdXOvx4bHrhn77okR/G16XponU8qw5U2RC
         N8nlZ4jnbJan8/WHZmInU9f6C4eCdH8oq2DGJ1rFG22TpSDxNtjQr7ERbBn4HInBsq9V
         LqTg==
X-Gm-Message-State: AAQBX9dtRO/T8xvgUqgNA+/sAlgV8T5VZnurmcj+rI0+cCkbymlr5Bbd
        5kuUBAWEP5nJ+aoCs3Oyzyee9nGaJKmwAqzB76ffHg==
X-Google-Smtp-Source: AKy350andnC9439itOhIGftw2sv9M2P+o8+hQiPu07abkIvKMy6vw0xdngqBOgatacpoGdgs6WFpAxtzkIkgPqImNYs=
X-Received: by 2002:a9f:354a:0:b0:764:64c1:9142 with SMTP id
 o68-20020a9f354a000000b0076464c19142mr6416703uao.0.1680291082859; Fri, 31 Mar
 2023 12:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230329220753.7741-1-mario.limonciello@amd.com> <20230329220753.7741-5-mario.limonciello@amd.com>
In-Reply-To: <20230329220753.7741-5-mario.limonciello@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 31 Mar 2023 13:31:12 -0600
Message-ID: <CANg-bXCN_86i41OZ1mAv5G9cOXm_0i+LApXEjtg96Rxx5BYiqA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] crypto: ccp: Use lower 8 bytes to communicate with
 doorbell command register
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Felix Held <Felix.Held@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Unlike other command registers used by the PSP, only the lower 8 bytes are
> used for communication for both command and status of the command.
nit; bytes -> bits

Reviewed-by: Mark Hasemeyer <markhas@chromium.org>
