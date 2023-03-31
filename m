Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AEC6D28A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCaT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaT3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:29:09 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658020619
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:29:09 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id ay14so16871033uab.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680290948; x=1682882948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nkeRp6lZuw2oE9ccSgxZK71jO5cGE2tSZwW3ZkFdEqk=;
        b=jsmTyKyyOdeTa5k7uiNpZZ4BupnT3Eb1Y0GOkElSaDZ5R28muawvLbT9aENaCtUfUw
         5jhEJ60yvufKtwaRTRXpE4iCdnathQ5eSPgJ52snsgOx3JoV9nvOv0PMZcxjHLodpmLq
         u3+uWIh/fs7Rrpbz7N8lR0Od+VmKEbHSr2TPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290948; x=1682882948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkeRp6lZuw2oE9ccSgxZK71jO5cGE2tSZwW3ZkFdEqk=;
        b=2Bn75M4azETndb5cE94VNgldBxN3Mrdmt0CVfDi9GkGRRbPFT6J6+pcnoy5/+oLcVe
         vSexybD7BGmxrKOd2s7Rvx4/cvz3YB+MqnVCWEXgCmJJ8RbZzKjHIrPv23Av67Pqo9rJ
         HAe8xLeeLYUR4Lu+vS1MsKdBh52F5F/B/vpRRC2/dTZ9Omyuqv75br9cIF5Pj/K8l5gB
         ofr31iffdatiVav9p4H/7Ck22rWr1rKssSdDpdKqTRsXXkyZOd7u3q+nncQyvwJvvSV8
         /48fyjniv+w+/WxOei7i7rHBVtX4nftbyVJd3hA2mNfufZmcic1DHTM0G2JqXVzuNaga
         YmRw==
X-Gm-Message-State: AAQBX9cSyHj2YhnD8eVaIzD1Ym4EAtw/VBeVPxTtg23suOjTXxJPKE3B
        dxRXdu0ETF+WO42FB+JRhowMWJuDJdrMzAAS4iKQig==
X-Google-Smtp-Source: AKy350Ymw3sFG2MNM86EWmDocGroeGyN5wMNlvYa018MthB6WfkObD8wqVo2i2XWXlj5Lv63/Ca+Wv/pf0WI7CeYMsk=
X-Received: by 2002:a1f:944e:0:b0:436:998e:a71e with SMTP id
 w75-20020a1f944e000000b00436998ea71emr15140047vkd.3.1680290948102; Fri, 31
 Mar 2023 12:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230329220753.7741-1-mario.limonciello@amd.com> <20230329220753.7741-2-mario.limonciello@amd.com>
In-Reply-To: <20230329220753.7741-2-mario.limonciello@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 31 Mar 2023 13:28:57 -0600
Message-ID: <CANg-bXCyH3X8SLOW_dNTTwrO7RO-6PuP8jZFNKAin=HJBD7yTA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] crypto: ccp: Drop extra doorbell checks
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
