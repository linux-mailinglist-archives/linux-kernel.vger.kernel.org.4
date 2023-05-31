Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4A718EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjEaWkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEaWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:40:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF37121;
        Wed, 31 May 2023 15:40:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3063433fa66so152649f8f.3;
        Wed, 31 May 2023 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685572837; x=1688164837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi6o6YBQqUF5E3caW8zl2Irs9/xXSVFAwQzFaKiXZmI=;
        b=ilcExTWptvZ35tJBshw5zSrbw7gIgcclVFsp3D2GCUQ/UFw7/qMzwny0HagS/eZxHO
         W4MsBd1MJspYRXY04Fg9dt4UTlfVixT9+7DFLZPJO3kjCFXR/bKB36RTbNS7b1MqOZwe
         orthUIigTa6Lmm/X/qgqYDOFPXjnQW7RWvUlBSBATxGWGNGoKXMi+++flZjg/on7FZx7
         8Fy/1vdHb6sITdtXDPqTYzwoCJTgL8y8onc6R0O5Q/ZuDOD9Vqzn8eqD1J1Dfx8bIPLe
         r/lpKU8GJ+P2x0QJhTD3ti+pAyY4IZ9yye0FzEsUdir5cyGlS8IWflXlaNqhQeWdBXcD
         7IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572837; x=1688164837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mi6o6YBQqUF5E3caW8zl2Irs9/xXSVFAwQzFaKiXZmI=;
        b=aiznCNuedWvLLM5STNtqCVsTxQx7hRIYGQuwuKX2GqkWMKqY1BSesJiF7796MfZj/w
         IuPFz+6y7doG2kH1gAsBprcDUqy8y6RsxkOzt/abx03DZdr/og08UuZvKp0UmzTLxhfF
         ZnbEXexa2c2LKAOISFTJo/FInZzvKwSxlW+YP0z4tZcomLW497q+cTinD9PTWX2mTBgK
         fdRHoptaHKLEJyN+JQdYdKXd70/t1YKhGvIKPZx0V0RpO7YgWUw6QEnNLUY1SwV5wMkw
         9blMT8JnHKRwPbSw51VRr1cUgnUc7iMfb3RNBfM0crudSlOdEZFMibkY7QKgKrHb6hdo
         /OFA==
X-Gm-Message-State: AC+VfDyDsOWIPmv+x8JNdURaXTsxQmFzmZ8yAV6G+atLqtfIICm4wJak
        A1k1OozVrmwrplM6oq4W+CZ4EN0b5Gwn20uJRMw=
X-Google-Smtp-Source: ACHHUZ5UviObvhddrwCqGP2Y/rchKHebgaKxm9q2zoSp9v0pc7hyzheOv/b9GzQ3xzKHhz8/ILXvf4VAtphN5f3yzzU=
X-Received: by 2002:a5d:474d:0:b0:309:38af:91c6 with SMTP id
 o13-20020a5d474d000000b0030938af91c6mr360372wrs.68.1685572836768; Wed, 31 May
 2023 15:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230530155818.368562-1-azeemshaikh38@gmail.com> <yq1zg5kcgac.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1zg5kcgac.fsf@ca-mkp.ca.oracle.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 18:40:24 -0400
Message-ID: <CADmuW3V=b3SOvijU0MPCBadpcRBtRYfT5eWVQOvL8WH-z-BqbA@mail.gmail.com>
Subject: Re: [PATCH] scsi: libfcoe: Replace all non-returning strlcpy with strscpy
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-hardening@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 6:03=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Azeem,
>
> > strlcpy() reads the entire source buffer first. This read may exceed
> > the destination size limit. This is both inefficient and can lead to
> > linear read overflows if a source string is not NUL-terminated [1]. In
> > an effort to remove strlcpy() completely [2], replace strlcpy() here
> > with strscpy(). No return values were used, so direct replacement is
> > safe.
>
> Applied to 6.5/scsi-staging!

Thanks Martin!

>
> PS. It would help if you could submit changes like these as a series in
> the future so I don't have to track each patch individually.
>

Sure, I can do that.
