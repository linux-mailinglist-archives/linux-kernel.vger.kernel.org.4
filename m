Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC306C708B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCWSvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCWSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:51:19 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2052B9D8;
        Thu, 23 Mar 2023 11:51:18 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id v48so15661862uad.6;
        Thu, 23 Mar 2023 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7rJrp2dOHV1j5NCWXM4QuReU2h7dm4LnETqwXvwR/g=;
        b=b3L07cJbUDjD4qPaniBzGrNLTuAzXaafn1ZV902PTvHWo0lB2Hw03KSbl3ZrF1s8TM
         SC3DXK30ttYijF39AbWWaRX0yY2nFY/umHdtMFf9IovBu/jusmta4s37SgrjkHn9Qyfq
         cEm/Jyc1WEPiQvL6Xbtuqb/DUoNFe6NYtRQq10UasIQB+NqjdH1MSG1z+S1fms528akD
         GiD0II80li+W06q+VsgOqDvgP/A2qbwSaZ6GKzUhtpZ3Z1vKuYVfnmJgF90fKyNFARC7
         fkwOVuv/LK9iCGYG0kuLSl5v3buV8a4ZlgsNc8/+U/uVSfFPCd7l+rZZhpJxtj60opBx
         I0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7rJrp2dOHV1j5NCWXM4QuReU2h7dm4LnETqwXvwR/g=;
        b=TjFo6PI/JAZ7Kcf4sKTMYmXFtE4J3s29GwhdYULztIJH7dEqzNYJg2KnvJ3/1jy4wf
         Hm0UIa2Nzns8BCJFyyG5NNsb4HVqsrHgK7+XeUsaBW+e9uzKdo2jOmII5owDp6gVcDot
         +fGpzgiMcu4F0dSFTOQBp0Thw/TJzUpx7WjmvOKQufAudwrWMz0MJXYMzjY6bfNJ/n5V
         8MYbT6uUtdx+TiIQnM/yKRRLV6v/2v9h0OzuNv1Nx4FO/bU2n2vwvH4s+3ahiXziBH2F
         ZWDobjiGdmFyVvx1iRKHRTGzwDOTOek7pzRD1p/lXj/ob9si17hCQteq4mj2bEbzhlpT
         O5zg==
X-Gm-Message-State: AAQBX9fCFsOEDc6IKIhTsLk3EUMzScTBYqtyyB3i1kzcNT5W+485KOEe
        370Ggr+Ca3Tgqr7Zbv0IQRNzZ9T7uywZ1dx9o/8=
X-Google-Smtp-Source: AKy350ZK0vvIo4tWch8s5Vr3XQgaPQ2E9jDGSvj8F+I9wcF4sewDw7ErDRFmxK3SPo4XdYzwdoB3XkCbipaM4yEVvEg=
X-Received: by 2002:a1f:9cd3:0:b0:435:b6ce:23e7 with SMTP id
 f202-20020a1f9cd3000000b00435b6ce23e7mr399976vke.0.1679597477953; Thu, 23 Mar
 2023 11:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230323144833.28562-1-clin@suse.com> <20230323144833.28562-7-clin@suse.com>
In-Reply-To: <20230323144833.28562-7-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Mar 2023 20:50:41 +0200
Message-ID: <CAHp75VfnVzrVLUpXdspw1H-e4qxVzia+hf_2uJ5xgSm6Q0C7ug@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 4:49=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
>
> The .data field in struct of_device_id is used as a const member so it's
> inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
> because some members in s32_pinctrl_soc_info need to be filled by
> pinctrl-s32cc at runtime.
>
> For this reason, struct s32_pinctrl_soc_info must be allocated in
> pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
> to represent const .data in of_device_id. To combine these two structures=
,
> a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.

So, the first patch has to be embedded in this one, correct?
Don't forget to compile and test your contributions beforehand.

--=20
With Best Regards,
Andy Shevchenko
