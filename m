Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD17269DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjFGTc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjFGTcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:32:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F91FF5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:32:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso776415a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686166369; x=1688758369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLelqnNqmcMAoImMjplPjV1ztAlXuNLPnBgh5nS/iok=;
        b=Rl+95lalCHlSRFdiRRh0+R69gqLU3YF5esuOpi5Df4Qnqw9SDFzfgfrfmWf4raSudo
         ziQeq3dArftEy/45Z/4cGQJXmQaqx97l9IwdvJgYtUaMY4aFXCk8nYoL8MRxe71ua1Iw
         8ye9kDFniP34AAWb5HfHJvo45VQ3Mp3taiWxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166369; x=1688758369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLelqnNqmcMAoImMjplPjV1ztAlXuNLPnBgh5nS/iok=;
        b=Yk8EK+xMaddvi1hyUIX+llOtulGbqM4ihYIZQK2K4ta0Y6ND9NzuO+bvLAOE/SWYNJ
         PiT1pb6h++OKHyVbAedMZ99CRgHlRIa5xyxUqknUTTZkA47yAFSB5U8BnSgpO90xSp+K
         8iZbUG7dWTilllBgOlg7UKVeSY5IxJwYtuS2TJuOZAhDZDMYp9WbSvXZC6DyehiA3Zpl
         2wo5aRbeJuDYZSmbORhuMDfp17aiioPUNaW/axkt3/YKQ8QL8MkffecknHlTxOmjpjaq
         x7tgH0PWXLMF+lGbojjBl4BF3DxtCujFwnxXGa8z8YaXAbZsqftqJJXsGemu7C8RVNcz
         ao4A==
X-Gm-Message-State: AC+VfDx/uU7OrK6yf4St0IbZwDF9wdEIpY4LE811xwQiuSEi+o+RTsPW
        lF/xbCOrBvffBDhuRCONyz2PlEwiRjmaEpeG1dim/A==
X-Google-Smtp-Source: ACHHUZ71JjTOW/CjUWvcKCiS9g39CACSEmexGbYCIP6ul6vIoata9d+dxLBxZP8qXoqWt29/CXSLHpq3LcC+mV75Mnw=
X-Received: by 2002:a17:90a:a092:b0:256:4ee5:6a1a with SMTP id
 r18-20020a17090aa09200b002564ee56a1amr15072711pjp.24.1686166369673; Wed, 07
 Jun 2023 12:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230605204010.2239676-1-pholla@chromium.org> <2023060611-coach-entitle-d4e4@gregkh>
In-Reply-To: <2023060611-coach-entitle-d4e4@gregkh>
From:   Pavan Holla <pholla@chromium.org>
Date:   Wed, 7 Jun 2023 12:32:38 -0700
Message-ID: <CAB2FV=7jaQtj9-0Md2DJm7FEzrfyxyMjfXq4Oaa1tLc4qagPTQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: Fix fast_role_swap_current show function
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bleung@chromium.org, pmalani@chromium.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 11:47=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 05, 2023 at 08:40:09PM +0000, Pavan Holla wrote:
> > The current implementation mistakenly performs a & operation on
> > the output of sysfs_emit. This patch performs the & operation before
> > calling sysfs_emit.
> >
> > Series-to: LKML <linux-kernel@vger.kernel.org>
>
> What is this line for?
>

Sorry, this was intended for a tool that simplifies git send-email. I
ended up not using the tool, but forgot to delete the tag.

> What commit id does this fix?
>

Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type=
-C")

> thanks,
>
> greg k-h

Please look out for V2 of this patch.

Thanks,
Pavan
