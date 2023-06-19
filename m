Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8E73555F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjFSLEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjFSLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:03:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9C199E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:02:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f9d619103dso313641cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687172558; x=1689764558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1ugOR/KEVGYUAKk/Qgjdj0XOASdnjFM7amQnwAGBpE=;
        b=SMYN+zoY8GakUy6Uui72WHzodYo4MHpEx/QctJPwsbuqUf5i29Ochiy97P533vCVyM
         YlCNiLJjO6JeEhOOsTVnpFgtDX02fkeyJiT6b7LHJjD/y02ikcRTElHFPeezbKTyGnG6
         QnbY9xkKPfpoCL1JGVv/39WHW/Dw0YImMN+Q9UPLn9CkwR6+/XfOh8SWFAWWnjaBoIPU
         8vakdZ1aWdhas5CR3LhXOhm+1Ef29MJEADGvGv8+MJa6EcBKGkqA1HDjtF9Q/jjHL3WH
         JhfdRFRUVSOhdOjd3hmHqUCr24uX+rbehT5VW1njAzqHoOQ/Mv7raoAAAT2G/Qzoeufs
         R1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687172558; x=1689764558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1ugOR/KEVGYUAKk/Qgjdj0XOASdnjFM7amQnwAGBpE=;
        b=DHjPdfrxbW+Gw7inqAXsXV6jU3mKZB/Ls9164i7qxIK89cLpwYQTMGqq57hsB4mvF9
         dn7LbJEljqJUawnY1f0UtBWQmWPJWK1STrY3N7vJr2IgtEGvaFqBaCOz2bGBqjjdNXHx
         dP70basD12KYzl/JSYBN5rCtBx+snz2nkqQo28m4YabXt1zFCzOWyCm/85cfQdKhD73Y
         LcLAqC4gYUW31XJxbSjqMU605VNsi6o9cu7rYy3q5PyZ7d2N92lyLJOzaEv4XTjEJ4S2
         UmR/YhWmoIHmwPDHjuizV85OKSZ27HOhst3soUx7Ojtb4d4l506+Hld5hoP6a78hzGyr
         Fofw==
X-Gm-Message-State: AC+VfDxn15an1/DCd84/AxVwuFS1PkvK4jJtBnWYQEu2G3G9o6cpYKCr
        0WbrKMM4u3gV5KWbrz7xLbN9GqsKeD/PL4MRH04d5w==
X-Google-Smtp-Source: ACHHUZ5D6gOzxDPBzlWVen/WvBANfbbBPs2oeYrfU58bLqsgPMrlOYxAltoM+w4lQ2unLBjlVHFxfQHfYi5QgORGpoc=
X-Received: by 2002:a05:622a:1745:b0:3ef:3361:75d5 with SMTP id
 l5-20020a05622a174500b003ef336175d5mr1105234qtk.11.1687172558235; Mon, 19 Jun
 2023 04:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230619090336.145738-1-mmpgouride@gmail.com>
In-Reply-To: <20230619090336.145738-1-mmpgouride@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 19 Jun 2023 13:02:27 +0200
Message-ID: <CANn89iJgM1-SBzHXDdur+MgK2cBBeOacKOWz=zPyEa2mee3fOw@mail.gmail.com>
Subject: Re: [PATCH] list: Remove unnecessary WRITE_ONCE()
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 19, 2023 at 11:03=E2=80=AFAM Alan Huang <mmpgouride@gmail.com> =
wrote:
>
> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") added
> various WRITE_ONCE() to pair with the READ_ONCE() in
> hlist_unhashed_lockless(), but there is no need to protect
> ->next with WRITE_ONCE(). Therefore, this commit removes those
> unnecessary WRITE_ONCE().

Why are they unnecessary ?
They seem just fine to me.
Please elaborate.
