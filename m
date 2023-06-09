Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDA72A112
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjFIRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjFIRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:16:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A83592
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:16:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9a81da5d7so4021cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686331003; x=1688923003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecm1QYdUqsWB57X2yqu85CdUobAhAVwcZTf8Ain3A0U=;
        b=Dbk1iH8UR8Hhu+l5vn74Qenk9bBwWK3IVeciJcYkkeICg2G4xpGVdvHuuB6bIdoPTH
         z0r8FsvY97eNjF/1aMstFcney41zyt2FRNGDYBvkcJTqCkMMVUSQOrhyZ2Zz1h0sSWcZ
         xoC3+6rTeJJNZkoF+Pr/B5Sd/aWDgN0ezBLvb+rV9KxkzP6a+AS5L2GOFnC/QVEzBujD
         FxjaNKCMI986k2U3SN1jgW6K8orInm19ON34i0JhPeGKXssUSyzbiSeOA/Ob0+vqRCrV
         I0nSz0Ez7U+meV/Z9Yks9lC5s2npu+Eg8kQMLQ9hzl17WSIT1VzrcnvwLV1nRAja7u14
         nYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331003; x=1688923003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecm1QYdUqsWB57X2yqu85CdUobAhAVwcZTf8Ain3A0U=;
        b=GWbjF96rOR2zItyTxpTlT1wJq+hmsZGU3L/i6RqQ6WXHK6HAveRyVkiYEjrCbXM2Zl
         xO2wZT9Z2PFOVuNQeLpjxj9MmriZywRhHF5NDJ/H5yVBLvuWNNbXXw+RmNWx1z2wD89e
         gCwVpGFAvPCFqPi9BpCirMKymEUzn5utOjZZECX3sooXBjVgfO9TNZo2NFXNkON82+Qy
         TUs4BUA7Wnv3kWed5+6QKOwzQ068pwteEdfCNKozrnqzxDnSpxJSm/dSAcEKYogDnoiO
         OJBn03wYfMgGyXGaJU9Luc7uKfSqR4J5JI2x/Rt3X+kUudyfKi+2bGl6/tsOZ2Lv1/1n
         bPBA==
X-Gm-Message-State: AC+VfDxDwRwXcxp05Suql6895NLvNHiXNKEzPSwi/jGRaszU0BDmG3mP
        V+6p34LTkeQTTX4+j/n2QqZN3jWchZUzYH6UnZKqHw==
X-Google-Smtp-Source: ACHHUZ40Nvmlp4+hKBEVkgexqXmx13ZcYBb8Qkg4Euz8CIXuk/unOVMTpck9Pvuf3KfJhVWrBew0zJ7HwzsMfE8KY7k=
X-Received: by 2002:a05:622a:214:b0:3de:1aaa:42f5 with SMTP id
 b20-20020a05622a021400b003de1aaa42f5mr353977qtx.15.1686331003590; Fri, 09 Jun
 2023 10:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230606121813.242163-1-linmiaohe@huawei.com>
In-Reply-To: <20230606121813.242163-1-linmiaohe@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 9 Jun 2023 11:16:07 -0600
Message-ID: <CAOUHufZxN12YX8gDvOTaAyWyL_6BFKU_x=1wMNKBHMKbYmVxng@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: mark kswapd_run() and kswapd_stop() __meminit
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 6:18=E2=80=AFAM Miaohe Lin <linmiaohe@huawei.com> wr=
ote:
>
> Add __meminit to kswapd_run() and kswapd_stop() to ensure they're default
> to __init when memory hotplug is not enabled.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Yu Zhao <yuzhao@google.com>
