Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D366275FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiKNGia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiKNGi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:38:28 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A43B92
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:38:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y4so9229779plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nDx7KtSQ67Z6YH9mVmBsIDEMrVyzlgtcOk21cgdaMQ=;
        b=gQekpeAW0ywzEgh5crhnDBFu9TZwRqjCv1Gx2X+rhEq5HKXr6JPRK03ygiWz5ufKub
         3ENSroRbKSqWTTMc4VzSFVF2MY4Ih57NAUcNlwqVRrsHF4VzUkrDTyjJrNR80FruPqeU
         +aNRJaHidLrRiE3YZPPZplJwVOm0tMw/jc0NOraeoZp2wR3db0z6G7ZxSmwYvIQ5ZxbL
         v/eEhDS+rHtAticu8mVokWjRr/B4cte6bWtfs2A8ROe81PQgBjJEYLOyMGKovDuLg3kh
         BSelLrWQr64jFzA7F+VPAT5DI7JJe6fdE3RONVlJ8E3JbwaK0A5Quw2y1+xlclU6kW1G
         7wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nDx7KtSQ67Z6YH9mVmBsIDEMrVyzlgtcOk21cgdaMQ=;
        b=0851T4JEwxdGXNm5ZcGJTg5xfDMrqCTanJR8Ks9PPpxMNE7c9gvdmNLQKldaaN+Pko
         pfExui7k8MvYeL8kuKrJMktHyIScaaoUQrCEdll/lcFkYrMq/tpA4pYY1+W9hV/UC4FN
         Xb1VwMKp5k1/pWQRkHWumJkXfXoNmTucTndUY1oNaasq/PLEInwDxbCkBCBxddQcP9HJ
         o3efD+Qm1Bz9uVeuKmMlpdc/LtPhbS/ecrzHQvKZvTnrRPKN4ExpaBwM7n1Oi159sSEa
         OJ331tF6kW63hNtVZkScfVcEzsJwUJWGAALyNJX944whzykaRs39kyHB03lxl3DJgBJB
         lYVw==
X-Gm-Message-State: ANoB5pnSN7I1z0A8TmsK2LunJTwvBVAnLIhh9CKMuJcQNSaAhKCZj5aC
        1rmWLdbcpHsx/RmhNXVIJGuZPYqQMcMSfUsNJeWcjppBZCQQ5g==
X-Google-Smtp-Source: AA0mqf5FDuEl0xSQvls5eYj+NtCulVu0oTk/RDwUUBlWukvbTG1EiSLWh4I10VxQODUPCOCmb8D6XljnfykJylBdM8k=
X-Received: by 2002:a17:902:ab92:b0:188:b0db:cd5d with SMTP id
 f18-20020a170902ab9200b00188b0dbcd5dmr10590873plr.104.1668407907075; Sun, 13
 Nov 2022 22:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109160708.507481-1-ludvig.parsson@axis.com> <20221111161336.msozo7l632jvbwcn@bogus>
In-Reply-To: <20221111161336.msozo7l632jvbwcn@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 14 Nov 2022 12:08:15 +0530
Message-ID: <CAFA6WYNwgr6_TA03W4cYfZkOvbdF0DO44_CnAsdZbLcuDHur6w@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     =?UTF-8?Q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>,
        Jens Wiklander <jens.wiklander@linaro.org>, kernel@axis.com,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 at 21:43, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Nov 09, 2022 at 05:07:08PM +0100, Ludvig P=C3=A4rsson wrote:
> > Currently there is no dependency between the "linaro,scmi-optee" driver
> > and the tee_core. If the scmi-optee driver gets probed before the
> > tee_bus_type is initialized, then we will get an unwanted error print.
> >
> > This patch enables putting scmi-optee nodes as children to the optee
> > node in devicetree, which indirectly creates the missing dependency.
> >
> > Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> > ---
> >  drivers/tee/optee/smc_abi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..be6f02fd5a7f 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *p=
dev)
> >       if (rc)
> >               goto err_disable_shm_cache;
> >
> > +     /* Populate any dependent child node (if any) */
> > +     rc =3D devm_of_platform_populate(&pdev->dev);
> > +     if (rc)
> > +             goto err_disable_shm_cache;
> > +
>
> While I agree with idea of populating dependent child nodes from here,
> I am not sure if it is OK to give error if that fails or to just continue
> as there may be other users(like the user-space) for the OPTEE in general=
.
>

This uncertainty is simply because the inter subsystem dependency
issue can't be resolved by this. See my comment regarding FF-A ABI on
the other thread [1]

[1] https://lkml.org/lkml/2022/11/14/29

-Sumit

> --
> Regards,
> Sudeep
