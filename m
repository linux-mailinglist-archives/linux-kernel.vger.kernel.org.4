Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1902C6CAA87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC0Q0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0Q0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:26:33 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1831707
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:26:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id h27so8013308vsa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679934391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STHUvTYbsFLxECkk6Ly3TGpifupwlelS3imRFFmcQ1g=;
        b=I3xcPyZz0Nt3ES4tHyCTFf23qez+BpAxS/rO/QjdDLM+z/s2hBidzFRiZcqntrPSDS
         Z5qWZK168IgAAc+Fusp+l//Mek01dRDhZivNtiPtvOiu5oj8hbbtcTJJiftgaiv7X0di
         hG59TxwL1YL/w5/hxH1Bd6LyaKXVxw+Ql4OO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STHUvTYbsFLxECkk6Ly3TGpifupwlelS3imRFFmcQ1g=;
        b=qYpRldG9i9dK2K3akNnHoUOiY1YYI70Hn4uWZeeUPIuJWpDQsoT7oA+AXvm+QPb7Ss
         RwbrAeRCZyIGh9XcRv4utJJ04Ri9voCo6eCn2k3UFq1FseSSYnfumZqK/vyhA3YO36CG
         nNlTy1+P8OjMBOknhxPSprN0iErQZJOCJzcfjtoAwMnnVtb28PGZYAHEV2cfyXz3VMKm
         CrtdMm+podleJQLbV/2ShCTwthRbkzngYR1ckrO0yNaQ44euQg6AZ1i+DG5pDNZBAGOO
         EkUUDJmSKlNgEI6vX4tSNw577CrYRISL+EDo78x9YlbHXi6uOeepHLM0ymuViwbPrUnD
         uP0A==
X-Gm-Message-State: AAQBX9etRGUBWdOouHL0SNrOFSpaE8jAnFNIZLbOH8AwA0qjBDWW9+dJ
        3BoQftPphT+sAsP+0WefzFerSagQst+KOYMMt+Fb5w==
X-Google-Smtp-Source: AKy350bn+gneDCey7btdlGuOb4uNyw6uKx89wGx6d6nUkuM0Seabm5DPMfnDkpjY1BJK9O/Fjs0NUgmKxLEbIuX6o1g=
X-Received: by 2002:a67:c202:0:b0:425:d096:fd42 with SMTP id
 i2-20020a67c202000000b00425d096fd42mr6060497vsj.5.1679934390956; Mon, 27 Mar
 2023 09:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230322210227.464-1-mario.limonciello@amd.com> <20230322210227.464-3-mario.limonciello@amd.com>
In-Reply-To: <20230322210227.464-3-mario.limonciello@amd.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Mon, 27 Mar 2023 10:26:20 -0600
Message-ID: <CANg-bXCcbQn3CfDh6YVrSsxUAAAySR05+dVzvQ=XxLb0HaHeaQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] crypto: ccp: Return doorbell status code as an argument
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -int psp_ring_platform_doorbell(int msg)
> +int psp_ring_platform_doorbell(int msg, u32 *result)
>  {
>         struct psp_device *psp = psp_get_master_device();
>         struct psp_platform_access_device *pa_dev;
> @@ -184,6 +184,8 @@ int psp_ring_platform_doorbell(int msg)
>
>         val = FIELD_GET(PSP_CMDRESP_STS, ioread32(cmd));
>         if (val) {
> +               if (result)
> +                       *result = val;
>                 ret = -EIO;
>                 goto unlock;
>         }
The bitfields in the new mailbox architecture have changed, as it is
now a dedicated mailbox for I2C arbitration. The 8 lsbs are used for
command and response status, and bit 31 is the ready bit.
Accounting for these changes, I was able to get the TPM contention
test to pass locally. I also removed calls to "check_doorbell" and
"check_recovery" as those steps weren't described in the design doc.
