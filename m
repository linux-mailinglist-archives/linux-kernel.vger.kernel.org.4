Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FBC6D8F69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjDFG3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjDFG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:29:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19BA26D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:29:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id ce4so12091617pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680762556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWGJHZGuLO/YuuWqIvXgJSP33m7hrVTQlRsDLK3HYVU=;
        b=tbNME8VJ9ofUZcpyvEsVPMkIkRCP/8IgJy7M4DQOwyIqjtYMTaQ9TRonfmLKOFfQ4v
         9r7lA3W3ca/Ir8arbXVJhSHoPkqsi2OldovZCyA9k9ZgFpVws39W5YhJW41uR30kzL51
         bHZw3Oe3dfE8mQFtkTBqG1Ci2Tx2EPBOjorhdyrJdKrO64iXUvBgViEJ6NHFDBHaZfJM
         4FrylSweuq9evN+DpmFcGZBnP3C8x8I1NlHuW1ZXw015rjx9d3UKsaFbkTY3Xz1kOTyv
         7PoCynrYx0Y882iC+V/qGu/Mm3AhqKFV1kRrhnslVfrYKf6Wf/uYlxHc4UclV8uXueRp
         O/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWGJHZGuLO/YuuWqIvXgJSP33m7hrVTQlRsDLK3HYVU=;
        b=AUzrD6jMcseV6nZT9hR6k5PIlfSt+9xgkwd1LMki26tXtIzaPsh+/zBJ3q6HoPyxga
         ZmkNj6IDoaAdjOOIeKNB0Ku3YQukeUhDEomsMuSACQk2sU0GFEduQSXdgR+YEHtUWm9I
         eWPfTYELCsc0ZjYVzp7vzO3/0Z+8TqzXzD0ou8WFGFjYIJoeRKL1FpoVmNIK5yGm+V8o
         jy56/aUN/+UxVHYnHcmQBZDYUIOyF86tDjTI9IXHGlAC8gTrUnOLhf6YGDeVSroyyBVR
         dA8cfE/gi2Qfd77SiMl3wWGKt9kdZ5q/lGCFIR9s/0d5LlIDWsIQj7zPev7gIKKgPWVP
         eXMw==
X-Gm-Message-State: AAQBX9fFQR0jXOodKZ8eQ25bLMoTqXVvHYy8F21b1wUG5imImjJ9LkTd
        ShTi8tGZI8sf2SkJkYotOdpgxx7Exmd4ZriPoLEpGA==
X-Google-Smtp-Source: AKy350Z1Uk4CKsniVcpdenQLsCUynBqHQF5o2fSFC9yyDZ+FgUFRpa9Oqjs/NoGExcOGvFXzgWAkeqxwdDud9AFlMIU=
X-Received: by 2002:a63:551d:0:b0:507:4737:cdb5 with SMTP id
 j29-20020a63551d000000b005074737cdb5mr2749471pgb.8.1680762556446; Wed, 05 Apr
 2023 23:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230406061905.2460827-1-badhri@google.com> <20230406061905.2460827-2-badhri@google.com>
In-Reply-To: <20230406061905.2460827-2-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 5 Apr 2023 23:28:40 -0700
Message-ID: <CAPTae5LJtkrqOC_4D0zfbp0LhEwMToXcOr31XM3gjYvf9e1B-w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] usb: gadget: udc: core: Prevent redundant calls to pullup
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

Apologies resent V1 again instead of V2. Have sent V2 for real.

On Wed, Apr 5, 2023 at 11:19=E2=80=AFPM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> usb_gadget_connect calls gadget->ops->pullup without
> checking whether gadget->connected was previously set.
> Make this symmetric to usb_gadget_disconnect by returning
> early if gadget->connected is already set.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Fixes: 5a1da544e572 ("usb: gadget: core: do not try to disconnect gadget =
if it is not connected")
> ---
>  drivers/usb/gadget/udc/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.=
c
> index 890f92cb6344..7eeaf7dbb350 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -708,6 +708,9 @@ int usb_gadget_connect(struct usb_gadget *gadget)
>                 goto out;
>         }
>
> +       if (gadget->connected)
> +               goto out;
> +
>         if (gadget->deactivated) {
>                 /*
>                  * If gadget is deactivated we only save new state.
> --
> 2.40.0.348.gf938b09366-goog
>
