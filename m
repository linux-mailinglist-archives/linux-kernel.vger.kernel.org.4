Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D481741701
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF1RLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjF1RLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:11:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4210C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:10:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56cf9a86277so360427b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687972257; x=1690564257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hBGoSmAipjb7uFaXgommTCgThqhf3N/MwIcztkSaf0=;
        b=LKSYSGBSIRpYNWo6GB3fAX7Sp7LGTqtVknZjcmaruG6ULOl4SWX3oMH6i1meJ7Jc7h
         FQ429XW5BEHayOaB/G+854ylw3GR7iowaxfbA1xFNokKPSfZU9qHK8I56VYb3cj8v3Im
         45og0RH/taCs9T6G0wgZA+ZvGKFqM1dg8NtbsIkZV4SfXADT8WOBUrRVnR+Zm4s8RAaz
         L1yZuP/h04SwgiLgw/XhRTH6aFoMtzqLI2jNnU/1vQzPQvGtZzT2jgG0IfoYr8+mTB61
         /6ygnTJiq0wZgf6c3XYT7MrTU9iIeg//d3keWlxl8gQY1GX+VQQyb5ID7ENUwO9M5Nw6
         BwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972257; x=1690564257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hBGoSmAipjb7uFaXgommTCgThqhf3N/MwIcztkSaf0=;
        b=fIg8Yr8XsT+HMxo3BUPBnuiaBWOzsFEDxPKmtL331dhVIuwoCAQjksM7A7mR+mDP+u
         dCfGiLgwYrzr7M4yfDaR9crwQrEF4AbgVT08Iwe4ULypflWMGxTZe2bhl/0kBGflwHyB
         vGb8KlRc0NomQDioeB+d6a9KG/YNTEJtN0Ia/nm19KA9fXO6VdtvO2SudsW1oE/oXaap
         BkMtISCFrzb+ND4oMtNrxTzOxJ+kiGi37TNzwMup7+0paxiL6fxEmgszZW2INQvukXWr
         J4CAtpmyMpAEKmqO+mnHjhN+PQbJNSUVhIvCpIssmfyCHaFMZcQqR3yPvezywtKueVml
         NNUw==
X-Gm-Message-State: AC+VfDytCVhq+tGYYfrK0KFzsSWbJCoahJ8BYbxiffLj/wQP+QJPFNut
        cRGayzt7a2IejxstjziGLAdy+dy5looUF685xQ==
X-Google-Smtp-Source: ACHHUZ537w0kvhE6ZiJ53ujP+GdQhdrmWEWLOQ3XFca0OfxDBa47iNnq2FuExHLMS2z28CiKkkkGNs1j3Za/uWd1MQ==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:ee8e:ae51:26:66dc])
 (user=yuxiaozhang job=sendgmr) by 2002:a81:ae07:0:b0:570:200:18e1 with SMTP
 id m7-20020a81ae07000000b00570020018e1mr14077449ywh.3.1687972257123; Wed, 28
 Jun 2023 10:10:57 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:10:55 -0700
In-Reply-To: <2023062832-barrier-strenuous-9499@gregkh>
Mime-Version: 1.0
References: <2023062832-barrier-strenuous-9499@gregkh>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628171055.1312737-1-yuxiaozhang@google.com>
Subject: Re: Re: [PATCH] pstore: ramoops: support pmsg size larger than
 kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the patch.

On 28 Jun 2023 07:30:16 +0200, Greg KH wrote:
>What is that max size?

The max size is arch dependent, it should be 2^(PAGE_SIZE+MAX_ORDER). In our environment it is 4M.

>what in-kernel user is hitting this in the pstore implementation?

We are trying to use pmsg to hold a core dump file, so we have pmsg-size=32M and thus hit this issue.

Other than us, here is one I found that trying to save dmesg beyond kmalloc limitaton:
https://lore.kernel.org/lkml/b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com/T/

Thanks,
-Yuxiao Zhang
