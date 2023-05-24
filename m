Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ACF70EDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjEXGiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbjEXGhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:37:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24D1B4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:37:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f588bc322so72909566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684910268; x=1687502268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brJzMXvkfv8iVKsnhp0h4JdmFtEYpznm5TlOBJEp16s=;
        b=Weexqk//NZq+rt2AT/BtTddYNlLuYh1PygOLDpvzaPdrN5w/b5u6CDao3qwbRknub3
         9AZPa5L1lCWgxo/kkXOAVvKIv/saGh7euEKwwIfGXYeMYMoctSxUPqWZaSCeQRsTCn+2
         PjXWf6mP89M2wF+HWhZXCuy2XFofvkKAfSJxmIhSjugzLkeX9VksfxKyyAjOEZK7U/EJ
         2wpaAT+97u2vIOSawNnngnUTaAbUpCJJuCD8jFdWFJ6lfDfS38B3co0lQP/Wm2/cH7+w
         yZBDYPKZigsEiIz9Ut3GUEtXAjONVTGwRjhWgcQgsVzyHaTwcbhWQ9YHpVFprS86pRBE
         YLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910268; x=1687502268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brJzMXvkfv8iVKsnhp0h4JdmFtEYpznm5TlOBJEp16s=;
        b=JJgMz5wE7RN7UoTJU8+46tfHyS5qh49Ee+bSu7H5ZUsVBT+qr5GKWBaZjS5VTUaxIJ
         THnY2fgACNmI5G772J37+pdhY6DkLlUnR8AAOVGk+ZtYaXzOWE8UrVPmsFt26caWJ6Ze
         G0LvUZUTeC6Y3legs3oPuipZD7cpjlhkPESvxfTm9r0qdIYNyXsRKEvUtfG/Zv1sPTa9
         SThFqnZXPBVonAU7sibp0IUskT/xlIJV2s1GIZ3gk64AxhM3X2dipeQYztki5Ls/PWVX
         Y+nTRlQOjzquyphJNAsnH+bLwS5ut/x9BpU/krdvgI3nlNkAkyce4EeZcL+SL8bM9fjd
         NVgw==
X-Gm-Message-State: AC+VfDwE0mUe6n4AqCuf7V86G0S8vMr78tAMUpM9Ixx1aDvNEcbVtkrr
        NCz86nFFvJHeBAS8TXsbHiNuwmjnsdA29cbaJwEGxQ3hndxWU4riDwg=
X-Google-Smtp-Source: ACHHUZ4cbkK6SlqdJwjzlaaBY4Hh/YfAN3VHrtZKsFt+0EMzFAIDgekZ7/oQjRf+LMv+imGASkYr8vmWbYfao5BP80Y=
X-Received: by 2002:a17:907:36c3:b0:966:a691:55ed with SMTP id
 bj3-20020a17090736c300b00966a69155edmr15883800ejc.70.1684910268561; Tue, 23
 May 2023 23:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230523214127.4006891-1-pranavpp@google.com> <20230523214127.4006891-3-pranavpp@google.com>
In-Reply-To: <20230523214127.4006891-3-pranavpp@google.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 May 2023 08:37:37 +0200
Message-ID: <CAMGffEkCgnUXZAhctgfuqZ-VssQ81h5RXDqJOG-RXD4T1Ui5TQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: pm80xx: Add fatal error check for pm8001_lu_reset()
To:     Pranav Prasad <pranavpp@google.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:41=E2=80=AFPM Pranav Prasad <pranavpp@google.com=
> wrote:
>
> From: Igor Pylypiv <ipylypiv@google.com>
>
> This patch adds a fatal error check for pm8001_lu_reset().
>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: Pranav Prasad <pranavpp@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm800=
1_sas.c
> index b153f0966e5d..e302d5879bb7 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -918,6 +918,16 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *l=
un)
>         struct pm8001_device *pm8001_dev =3D dev->lldd_dev;
>         struct pm8001_hba_info *pm8001_ha =3D pm8001_find_ha_by_dev(dev);
>         DECLARE_COMPLETION_ONSTACK(completion_setstate);
> +
> +       if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
> +               /* If the controller is in fatal error state,
> +                * we will not get a response from the controller
> +                */
> +               pm8001_dbg(pm8001_ha, FAIL,
> +                               "LUN reset failed due to fatal errors\n")=
;
> +               return rc;
> +       }
> +
>         if (dev_is_sata(dev)) {
>                 struct sas_phy *phy =3D sas_get_local_phy(dev);
>                 sas_execute_internal_abort_dev(dev, 0, NULL);
> --
> 2.40.1.698.g37aff9b760-goog
>
