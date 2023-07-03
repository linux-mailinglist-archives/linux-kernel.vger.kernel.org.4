Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F2745E62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGCOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGCOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:19:49 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84CE5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:19:46 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b7541d885cso3500021a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688393985; x=1690985985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EnErmhjmWaSfn41HhKA4gTkH21PVtrL/UDLuzw5vo8=;
        b=RkVJ3NhlalPsYlTt8MsoPsguViVv6ysJOA3DBja30DI6ECNV/ezxUi/d1/bKx2/UNq
         E3fnb/CCYgoSQJuuFgdoR4SoLl9JT/VSWhapvhcWGyJaI7XFvgx+qPbp1YeFZ8xoR+mv
         zG482qbjrlVU4tcicmJqtSVT+uNvhQS1wZBA6MbwthHo7oFtzlsnmOPZAmkcNR47beNN
         gWzqth8sGlw0FtBawJGnr2DVDHTBxMpNff7iheywB0BAwZu2fWuszPaI9SCLKqyTapSt
         Tc1ncfEwe2rOog5XbRPvzLsUJRPxI/wLle3ZbslOMuZcsYPVe9u37RCzt9UM5S9I+UsD
         bbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393985; x=1690985985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EnErmhjmWaSfn41HhKA4gTkH21PVtrL/UDLuzw5vo8=;
        b=L32Erj8/t92Gq4/XpCAaL35gjR7deXFGK2E6lOu/x6hKpW9X5GpjO2SWqfZcFi6tGT
         wZU0FFsin6pX5S42ssQkNlX5NmZI0suU0w+70MwxgOEGzhl6UGyw57932qPKktG4dppc
         BEUY4yl0nrwXTQD1ZUudrOkxdqL64vmlO3uicMOVouwJqyU4835AuweNfjib5DFdG3ab
         O38kDAL237arB3foRSq/qx/7Ain8Qrpd4ZWxJyYxA17LJNzUSG1KwrpwNGpAFJIuEeXU
         P4/xhh8yn6slsgcBsCtErM7eOdbZ9+pEhcJYhnam6Xde+SgdDBvptTyshcCHUfKvRYBY
         Kixg==
X-Gm-Message-State: AC+VfDy09CgF9ATz2YIejXUDZPisVo9AKDMHJeJviUolN/wz5D3q/Ekz
        nhebjyHkvOigjqcU/rHwglac8UIpDQj4IqfzFsV8Jo2sSh4=
X-Google-Smtp-Source: ACHHUZ4OWmxXEOnJzRnIIK+/u3NuKyqEiMhgbAhEyiQ3AEW4tDK2BrIuisobffgh0Z4r0O/Qzr3JkGYIv34c4Pc7p9Y=
X-Received: by 2002:a9d:7dcd:0:b0:6b7:558d:579 with SMTP id
 k13-20020a9d7dcd000000b006b7558d0579mr9261749otn.32.1688393985288; Mon, 03
 Jul 2023 07:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230703123243.7795-1-duminjie@vivo.com>
In-Reply-To: <20230703123243.7795-1-duminjie@vivo.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 3 Jul 2023 07:19:33 -0700
Message-ID: <CAMo8Bf+rgAnzMF732rzNgWbnmijFbr1yd5aCiY1Hcf4qdpj6FQ@mail.gmail.com>
Subject: Re: [PATCH v1] arch: free dev before return
To:     Minjie Du <duminjie@vivo.com>
Cc:     chris@zankel.net, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, 11162212@vivo.com,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minjie,

On Mon, Jul 3, 2023 at 5:33=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote:
>
> We fixed a bug where the variable dev
> was not freed before return.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  arch/xtensa/platforms/iss/network.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to my xtensa tree with the following commit message:

   xtensa: ISS: fix etherdev leak in error return path

   iss_net_configure frees etherdev in all error return paths except one
   where register_netdevice fails. Add missing free_netdev to that path.

--=20
Thanks.
-- Max
