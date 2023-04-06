Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B46D9143
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjDFINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjDFINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:13:17 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00A5242
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:13:16 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id u97so3215880ybi.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680768795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s37AKX46druDkQMukFY2wjOtd4UDmaJrvLEgrvY9bU4=;
        b=nrSafKY0nVFK23NtqSDbq36ZroC2qJOvKZrGvQr2QkYsGlKAjzqDUxSK5MFpX+pIom
         zm1tokTzkYyxjOP1ZxjGw6rzdAIxm5xhWmPy0olG7nzGFJm3f3kw20jT7Ew1Asewhkbx
         TasrqL/9bXj7AGVSol29rvvYUk/37XyVnVWapWliLJJNv6jr5gDjZzwoChW1SAgF9+GC
         4UYPa37LhaCGR87mi5f1yVaQkjpm1l+5LCfn9IJPDPCKt/esnFUTB8gOdOHuVAaQs0S3
         Z+ZTHEWJAERRXGMF2nctXeHg5TQJPs343YSTVvNa07CtvJuIS4MxLK7I5ZCOY07ceeZC
         1Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s37AKX46druDkQMukFY2wjOtd4UDmaJrvLEgrvY9bU4=;
        b=q75ogauYIjFYfBFv+HGHyeYWGKHMLvZ1bnY0el9dJhMK4i5ha9uhR0lPZTBjbHQNAg
         nfF4BJ+Ce5S70AgzxupuX9dEfXlVgih44+2LfoT1TNv2L9zWT+mpYkKtT7APGWKkgbKm
         GNNjgj0JS/Sm9xOuTT0p1tHU41SHoOYd0ay3PDbzo0scEZOBj9xNCA0H/BU/r45NlFPJ
         FXEmYmDtuec31zFkOk0x32XN3JVH/iWbFoAvyjkWzTErYfHoJ5I46es6a8tkwY1tFSRK
         53OoN3ctYIQKbtUCQD1zr3rjmYXWCSNxrWWoHURC0piOfXOctRz/ag6RVDzwLMYSUFso
         QnZA==
X-Gm-Message-State: AAQBX9ec3+tETx7uRhYYU1KtOYERRF3UTWjQPhC5RcdUGWs2sfiWf+XP
        5odu9y7/NlR+USSMNWIzWPXt4WEIKv4O+vgJJl8BDw==
X-Google-Smtp-Source: AKy350Zfk5N0s61DTsl9VnLEj+Ajk4UDuW7STcEJQQgs7kgMhWDYvSKMwIj3WKmJkboudvnSGA7KP7OZSeL2wh7bFyI=
X-Received: by 2002:a25:da46:0:b0:b09:6f3d:ea1f with SMTP id
 n67-20020a25da46000000b00b096f3dea1fmr1566211ybf.4.1680768795347; Thu, 06 Apr
 2023 01:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230406063450.19572-1-yuehaibing@huawei.com>
In-Reply-To: <20230406063450.19572-1-yuehaibing@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Apr 2023 10:13:04 +0200
Message-ID: <CANn89iJTKBVcF4agyJfV-TbtH12Uky=vkDJ9eoxKML9N0K7gAw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: restrict net.ipv4.tcp_app_win
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, dsahern@kernel.org, kuniyu@amazon.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 8:35=E2=80=AFAM YueHaibing <yuehaibing@huawei.com> w=
rote:
>

>
> 'maxwin' is int, shifting int for 32 or more bits is undefined behaviour.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

SGTM, thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>
