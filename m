Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33366EF62E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjDZOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241290AbjDZOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:18:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D472B4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:18:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24b3451b2fcso5213811a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1682518691; x=1685110691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MwzWOCWIuspDBg7KAFQQxg5GAo3xlUEzmvG1oTBePk=;
        b=C4z89VF+rBbWLGv/jhTMwmKtVZdtJtTYr9ZmKte8XcQa7c4ZcToPjW91qqV7oqPRv8
         89pPpJ6M89gWwRRH8emA0cVGEf+5K0poWHsKzgvIQRnTohLAbvGsL5nw9E09ihiHsp6+
         1mFH1pYwRvR7wGuTU+0atLoubi3DpvUgovf+Sw9ZNcrHKxR30ZhicPMUkGjjBZr1hn9J
         raSZyRqFbduuOFtKJYfbPvbgzMXxpUT99HgXWrpAPOGCQLcMpKGPp9nd0dGqxPYexokM
         0U9SqmzY8v3cwRkmc1dtZGTTGMz1dvj+hLVxuIH3oKKSucF3KNGGBcPfg8Q2+BO5e+Sp
         sZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682518691; x=1685110691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MwzWOCWIuspDBg7KAFQQxg5GAo3xlUEzmvG1oTBePk=;
        b=UkZ7TA6P/AgWJ0NdRUozg6Oqzi2adTTYptMqkOWoFuoPTG5JPydEPGBHEXtkQ01Zun
         RfU+0m6xc1LL7NiXJtNsS05UI/RvHot+kB6L6nXx2ZjQPw7N3s7saGFJJsJweBKVXirA
         BO5G1uqg04NXqOOnGdzAJf1VKhh2bGbPgDQ9VykW1HOZFCKADLA6dXBnGMqK+3MMOKyQ
         ra/tHdI/4pXsUSLb6ph+pcy2YrxIau3HXlRFiFCkAkxKLBIaVeSQpbk4BRohwstpjhK3
         JzOAanxzkyVYBKwZxMDjnPJ+PqeAggvSWYq47vglqL5jS+tZdXNtC/xbIRx3lbwwddZx
         B25Q==
X-Gm-Message-State: AAQBX9dJ5TgcP7GsmTDLV9to44vw4akP2R7qjqqIZwBugtC9GSnLRsD6
        OcAomuu/drqZAtcybNKNwQBsV+u/KrPZo8SFxw3AdGT+n3HTH/96OhA=
X-Google-Smtp-Source: AKy350ah7qQRQdHFbI9G1+Rzv8005bT1Dz13JOX87BIdn+B4KCjaAHPEOM6muh7yjOnK0OtbtBhQUVouDjWUW/WydOI=
X-Received: by 2002:a17:90b:390f:b0:246:9170:a9be with SMTP id
 ob15-20020a17090b390f00b002469170a9bemr20240108pjb.13.1682518691193; Wed, 26
 Apr 2023 07:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230420102316.757-1-honda@mechatrax.com> <20230423121528.259d3cd4@jic23-huawei>
 <CA+Tz-SEAyXcJ++YDzDC=ySd1gOC-j-DDp8sMHBUCSy9Q3wQ4HA@mail.gmail.com>
In-Reply-To: <CA+Tz-SEAyXcJ++YDzDC=ySd1gOC-j-DDp8sMHBUCSy9Q3wQ4HA@mail.gmail.com>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Wed, 26 Apr 2023 23:17:34 +0900
Message-ID: <CA+Tz-SFamk0Fmy7Zhk+7pcMxCkt1wacO=UCtCjTjpeocJ5AnXg@mail.gmail.com>
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Wed, Apr 26, 2023 at 9:02=E2=80=AFPM Masahiro Honda <honda@mechatrax.com=
> wrote:
>
> I understand. I'll fix it.
>

Sorry, I made a mistake.
I would like to wait for a conclusion.

Regards,
