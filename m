Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3856D28AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCaT3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCaT3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:29:44 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9E20C07
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:29:43 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id n17so16872370uaj.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680290982; x=1682882982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nkeRp6lZuw2oE9ccSgxZK71jO5cGE2tSZwW3ZkFdEqk=;
        b=X7GQ3vC66U9gz9UKunrb9Cre/IMkVznLMyYFgIQoVAxbyQY4vTYhuhmA2k3tfmqYee
         0LbX7lId1tFsK1owk2nydnV17xAh9x3XezhwtQqzyGNu+8Tp81HoidQRNvrvKThhiTkh
         Crlb++sW/O1f+yNcbcWvesh2mVjGz5urwn2ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290982; x=1682882982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkeRp6lZuw2oE9ccSgxZK71jO5cGE2tSZwW3ZkFdEqk=;
        b=MaYsEBurcft6A1rj/S2cAw82uTX1ZgBPOORYkpXaA3fC2Ydu6kgarmbYen0MDquwdj
         Nq+zQCt6QaBHf9/6Tq3LJtmW7vFdYo7HRBp//NfSjN3fnk0P3M5iAjx5B3wb1zuxYKz0
         B/KD3kKfJjDfryWJcTlINHnl1wqO28+4BvDwVsVkLR+AKzw42KS1YOve7jvdxIhc4JvT
         sz5g2fjxyN7PtlDKhb2zBEMdgNHQBPfTHC8lY0uxHDn2gcgjFkQUenz6m1XNSebv//AB
         FumGbjoA0/fnibWbe3BTLHNOD2lOg8i8yKkPCeKk3t168lMF70uPxQ3xPANSARxwSr8r
         NbzQ==
X-Gm-Message-State: AAQBX9eGiCg4Uxj6MXqAK95CCXqgx9q5XNnG12ko0SOT0IG5hg+zx6qI
        mP9NRqeDvLX6GJYJrcXl4n3k0SUHDIyW3y3OUMPDpA==
X-Google-Smtp-Source: AKy350ZI8+x8V76aORHqljangOkbwMyJ7k9+bO6cD/qS6MBwGLxNCVzh1a61XK+QDEebi60pzPtz/OpBaNyBcLI3q4c=
X-Received: by 2002:a05:6130:215:b0:688:d612:2024 with SMTP id
 s21-20020a056130021500b00688d6122024mr22017553uac.2.1680290982611; Fri, 31
 Mar 2023 12:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230329220753.7741-1-mario.limonciello@amd.com> <20230329220753.7741-4-mario.limonciello@amd.com>
In-Reply-To: <20230329220753.7741-4-mario.limonciello@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 31 Mar 2023 13:29:32 -0600
Message-ID: <CANg-bXBLWLamLYf7TAAk+wiP5WVK2HWb-x12Yvw3Siq4nQq=EQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] crypto: ccp: Return doorbell status code as an argument
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

Reviewed-by: Mark Hasemeyer <markhas@chromium.org>
