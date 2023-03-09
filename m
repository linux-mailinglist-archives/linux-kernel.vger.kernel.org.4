Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179436B21C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCIKqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCIKp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:45:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60956797;
        Thu,  9 Mar 2023 02:45:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a9so1490191plh.11;
        Thu, 09 Mar 2023 02:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678358726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syVx+vjdf/ZCrQkBBKtgWw7KFf16AwGumErh0SNakMY=;
        b=RMfuFP3mDNznKhLqGvBYhoijvFUiShtojQD9/XXBSWaozsV5lIm8ssQlgQIWfK1Xbh
         z3WIPFZagV1zjPpyNKKXDcMm9Qk/NmrAKSBJYlSkfoAXDtbywjHxsJP/nS901YGO9BGc
         QWw28wEikC1YqIM1e3TWHAYq8oxQLzVWpIPBS9LcttLzt6OZ7q2RiXOa4RBYxzpt2xfd
         4NHm5SBgjgLy1UTfNk8u2puDOKuAOASqrZDSql3pTd1bAacuEHSKyTXvql5OEzqjmt/p
         oqtrNWz3QKiLkAqHSkG3mcRGpUOxvbmi51i4cx4QaQo9WqyE3nEmSOvjPUzWsedqmV0r
         IwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syVx+vjdf/ZCrQkBBKtgWw7KFf16AwGumErh0SNakMY=;
        b=NLzOHet7NsqWJDfGYprlBLigLTWXDR8oh3rY2VkKOPs8hqwDiYe4I6Df2Yj1kVHSwk
         CKOMmTNJQ+MYmoCXxxfpzIcZdg+s7ybB7yi0Qty/aXh3q5hX9rmWVX/wnhkDDFQ79tZm
         o8tU4+Zeoz9cPhBK/sZaWDUBTBlWwOm6B9WORY/+QWQ+hTwiAOwXZc8F+fjTmETzzcSX
         s6eR0lU1OWb7Jtq6d0u5yCAwaq7g+nP7RnrQicY4XgAJm83GSExUL0kREUDc0mwBOrJI
         FyJIPxku+iMnVPvG2l0HGbz+8ili65LOYkyAtg0xD9T1mx8X4TSf0fEi1i5O7hVFeidP
         81yA==
X-Gm-Message-State: AO0yUKWlPwUCb0eBLivf5kSj7ZnEupxbm6FTzHt2RXoU0EDB47LTlqXj
        MRJQpmnDgL3vCd/94W2j1rxJUQZfIJ4Iub/k7/k+qFvqhl3jsw==
X-Google-Smtp-Source: AK7set9wVn30YXm55DaP7zMI+PaHXqrCLIffmIm/qdvgb/14tq0QJwGlqbKlTk3VTYzmc5kMS1madgEGh/Lav7/SY8k=
X-Received: by 2002:a17:902:ef92:b0:19b:636:b153 with SMTP id
 iz18-20020a170902ef9200b0019b0636b153mr8117005plb.6.1678358725826; Thu, 09
 Mar 2023 02:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20230309092821.1590586-1-daniel.lezcano@linaro.org> <20230309092821.1590586-2-daniel.lezcano@linaro.org>
In-Reply-To: <20230309092821.1590586-2-daniel.lezcano@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 9 Mar 2023 07:45:14 -0300
Message-ID: <CAOMZO5CdLXMtBbdH1j1RLFL=t5ZGXVgi5=Aw5pde1QNcCAVKxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal/drivers/imx: Use the thermal framework for
 the trip point
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 6:28=E2=80=AFAM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> The thermal framework provides an API to get the trip related to a
> trip point id. We want to consolidate the generic trip points code,
> thus preventing the different drivers to deal with the trip points
> after they registered them.
>
> The set_trip_temp ops will be changed regarding the above changes but
> first we need to rework a bit the different implementation in the
> drivers.
>
> The goal is to prevent using the trip id but use a trip point passed
> as parameter which will contain all the needed information.
>
> As we don't have the trip point passed as parameter yet, we get the
> trip point using the generic trip thermal framewrok APIs and use it to
> take exactly the same decisions.
>
> The difference with this change and the previous code is from where we
> get the thermal trip point (which is the same).
>
> No functional change intended.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V2:
>     - Remove extra tab inserted in the previous version

Reviewed-by: Fabio Estevam <festevam@gmail.com>
