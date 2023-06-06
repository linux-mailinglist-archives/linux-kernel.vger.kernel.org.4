Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24920723423
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjFFAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFFAsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:48:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20339BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:48:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so1885a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 17:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686012492; x=1688604492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mQ9eLij8YgncwHX2mMe28rSprJZicmC7rEXFuA4odw=;
        b=Pqya30+r1Ph+oAXKvQDmIJ0WyE6AP38UeyMyzP6hSMaHIaZ3jHKp0LKE+/i1Wfl/Mi
         slriLOuvoWSE532zAlq+X0iofWuop+TokHHpHqUfEaCzb7pVBJQwA0dwJ8tHRegdEscU
         fLAfwZEfG259O7JI98lMeCjR4Hem8RwLILSPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686012492; x=1688604492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mQ9eLij8YgncwHX2mMe28rSprJZicmC7rEXFuA4odw=;
        b=a0N9HmYK2wYm6L1c5mRClU+489A6ddqicoA6wDUeSsyNAw4SjriYmUOZdW4KluikNx
         jAUy0vAVzhDE9Uu/G4aag8iQnE/MyKHB4tlJavig4Zs6f9ksOAq+h/7fqCdhULn6s4gg
         nilEfMYYF9Q5YxhMJCkkfUlhjIAbJjJ6ZzRwoYsRtVFDAbgEaN6/F9MnBB2WVE/mj+fg
         1cQUX8cxf11vjYhMJLFexAPSzn4Ci4KiLwnzv1SNQZunxfEhE6ZCIkk2SCH/KMlgFlXD
         SXzG0LJRKGGyxTJrzcetjOk+oTHzqz4xgv0Sffd2KEDrdA+AeruwJQ9qcmXfB2SSUaka
         r8HQ==
X-Gm-Message-State: AC+VfDyB/Lbmdmdw7iVe+Lm2jdr7OUm2dfXVUdHPutpGqPCV1qJdzTAM
        8Qs60p2yEkl5eyQntCvpt4TPkSShJIaDyYudSbzdYA==
X-Google-Smtp-Source: ACHHUZ6MtFnpvJIN1r2+0uK2xkNqoIrPwOpO+DuD+4llUCtwZMjmfWWzssehMhr/XRwXTmzfmG1wV1njH3v9vIunRhw=
X-Received: by 2002:a50:d65d:0:b0:516:6453:1b76 with SMTP id
 c29-20020a50d65d000000b0051664531b76mr20551edj.5.1686012492347; Mon, 05 Jun
 2023 17:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230605204010.2239676-1-pholla@chromium.org>
In-Reply-To: <20230605204010.2239676-1-pholla@chromium.org>
From:   Benson Leung <bleung@chromium.org>
Date:   Mon, 5 Jun 2023 17:48:00 -0700
Message-ID: <CANLzEkuvM27MKTBFBVFcbZLZhxC27RUPpJp18jyxdQCG-BdzdQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: Fix fast_role_swap_current show function
To:     Pavan Holla <pholla@chromium.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pmalani@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,


On Mon, Jun 5, 2023 at 1:40=E2=80=AFPM Pavan Holla <pholla@chromium.org> wr=
ote:
>
> The current implementation mistakenly performs a & operation on
> the output of sysfs_emit. This patch performs the & operation before
> calling sysfs_emit.
>
> Series-to: LKML <linux-kernel@vger.kernel.org>
> Signed-off-by: Pavan Holla <pholla@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks!
Benson

> ---
>  drivers/usb/typec/pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index 0bcde1ff4d39..8cc66e4467c4 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -95,7 +95,7 @@ peak_current_show(struct device *dev, struct device_att=
ribute *attr, char *buf)
>  static ssize_t
>  fast_role_swap_current_show(struct device *dev, struct device_attribute =
*attr, char *buf)
>  {
> -       return sysfs_emit(buf, "%u\n", to_pdo(dev)->pdo >> PDO_FIXED_FRS_=
CURR_SHIFT) & 3;
> +       return sysfs_emit(buf, "%u\n", (to_pdo(dev)->pdo >> PDO_FIXED_FRS=
_CURR_SHIFT) & 3);
>  }
>  static DEVICE_ATTR_RO(fast_role_swap_current);
>
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
