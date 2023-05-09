Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22A6FC202
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEIIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEIIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:51:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5A2D78
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:51:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f38a9918d1so82981cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683622277; x=1686214277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IraX+oUBLwvjqiInA0j8uPl6x32yOtC/TKYx6LHl7NM=;
        b=BLgnfB+PuGcbYmgEOPPmpjUx2YJHLULGn7h+bbr4+wdFwvgdYKdJkIZnX/xWFvmk4+
         acrXlWH6YS3jtuWkMhYWrOpI+JTot/uZ8ywxUXtxGnfzvMYlscQzw3ZjN5yxpMdOHpJF
         4t1Q/s6kedVAlxQPil8ZnhgWDWB6z1k0HuFpisZLHj+7c2u17bkb64u6UOimgJ5lqpd4
         9KCJrtHdxVY6ggT2DVru491nXjhjH2+zvUuKCN+3ezyImS/FPrnDqqg0NkNcbCISFIJw
         Iu1frp3INjfXlgCX1stSwSActYiO4ZiPmx6m1NrglJKAdNm3YYUpAzQ0MxXft4fviDcZ
         vXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683622277; x=1686214277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IraX+oUBLwvjqiInA0j8uPl6x32yOtC/TKYx6LHl7NM=;
        b=O7VcJKRPhQmwJDJW65Md9G38qWIqDxBVtxjDui2247Jd3tJcdHfysZmB82NjxeEBDq
         oFZKCjE8lWD8vTn6jgToUfGbeTYCw0z0wfKcf+DGAKCZKn5M1F7UrVqPLE5drwN4J7JG
         egnekUkNKefV7U5U0q8gq6mk5SAGs4iP32GnuBq/TsW6d8tH6C4rBCBhjaKlrhfOh8Ab
         YP6Z1fM2ml5CWVachjaLJz8+7oyZn9umQVM/QwvN46VYBDq5ncO1ndKIj/ut/uuuMm6l
         dh0wuxIQvFmVyse7FXm/gtCuZgs0gC9a9mNHUtPEIEyBUq2eW1B5KKf9m7ZCoj5CGS6e
         zlRQ==
X-Gm-Message-State: AC+VfDyHvw+q4bX72QjmzCUdvC2E8jyys2j8HBdo6/ABW5giaLlDIk3l
        4I+fcWoQQ9irrwbLwJHZ/ZkCH8scBud7MEbtkad0Aw==
X-Google-Smtp-Source: ACHHUZ7YU4f2zXcAlzkXjAsKg134MNWnY7UvWFVpebS39DMB6pR42HByDVKqHv4THJgichhxGBfyoI1EdjHW6lRd3Yo=
X-Received: by 2002:a05:622a:130e:b0:3ed:86f6:6eab with SMTP id
 v14-20020a05622a130e00b003ed86f66eabmr338833qtk.14.1683622277300; Tue, 09 May
 2023 01:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 May 2023 10:51:06 +0200
Message-ID: <CANn89iKEqUFMNKb6axZpkLEJbhZB285-Vpiq_ybBB6LO9ny4SQ@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: remove special handling for SLOB
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 9:12=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmail.c=
om> wrote:
>
> Commit c9929f0e344a ("mm/slob: remove CONFIG_SLOB") removes CONFIG_SLOB.
> Now, we can also remove special handling for socket buffers with the SLOB
> allocator. The code with HAVE_SKB_SMALL_HEAD_CACHE=3D1 is now the default
> behavior for all allocators.
>
> Remove an unnecessary distinction between SLOB and SLAB/SLUB allocator
> after the SLOB allocator is gone.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
