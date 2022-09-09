Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251445B2E67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIIGBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiIIGBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:01:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31EE1A89
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:01:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k80so1155159ybk.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zZ8jJlzfW5ni1oE/+tdYMxOdGoMqiiHVTECd9TNmHoE=;
        b=FOoy81KGKOz9ngRAqabXhtCs/NZfHJnkIqC2EVX5WUCbNA6e/m5MM/bl4dDmnjTovB
         Qh4GUC66j8uEF8PnbaaXW15BRIm/CJtYMfTsHdfOIwSUUOc4YnTbbPVnPWDWIFO6IUZB
         fYCHEpv2rjAe1OFmKkUytJ6lMIbOUyl893yy48m/bDwHC5PVdVQny2wwABqJjE4qamQw
         xLTMDG+bLO+ZBTNihZ3EFV7nkwsZ0Qne1pZNx9necuBEwZqWA7hRyOzoD6xGJlmg9YM5
         /ybdG2yTfXSGvYB+s7WyguKWrlozrtnWlx0aKVmZCnUjdkJVbBwoKDXwxmIyUPylIAdT
         vw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zZ8jJlzfW5ni1oE/+tdYMxOdGoMqiiHVTECd9TNmHoE=;
        b=cUaFMxFd7R6OwBKJuf6x3UlajHbvh1reKHxBT9ZxSLmFx16iaj8LFxYJfriMTcPemO
         V/gb52CwTxo5NF/0CQQt2fDThWNievswAdv1mxGwPmoG8XUIJNGYBd6cCQaqzVV/PEcY
         Bm5cwMPdbwO9cGFVG55Qjxf3M6bsv+4GESJzNQOt5xy2TLUUX6tog6M03GU9FpinRG69
         O4sTus25ta7VlICyZB3ufrnkv1jR9xmjg/2IpMvHieMQtgu41XQVPSBGqcIoY6GoRHx8
         IFDJSSxHPfDVy4w2zOcY0pJO+uBueuN3qBS5OaYOrtSdO4mTho29lVG+eovxlzCIm4rL
         2boA==
X-Gm-Message-State: ACgBeo304ZNoei0WiJhuVpr6kUvzUpR1nMQhbzOIboM4qsMeXjjiyYdp
        wW42QJHBxoPnprDG2pknladVMdgwlu6wvRTW00A=
X-Google-Smtp-Source: AA6agR7D1hRiZW0n15HZiHh0btPBxMcV1jngPBPde488w3tmA6WU3A7yy3ke3aB1+WQi+OIkJoTbvzCftXQA54Op/gQ=
X-Received: by 2002:a25:9a85:0:b0:69b:79d2:7f4e with SMTP id
 s5-20020a259a85000000b0069b79d27f4emr10449738ybo.379.1662703300042; Thu, 08
 Sep 2022 23:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220909053038.33188-1-namcaov@gmail.com> <YxrTiN1OuJ2cbtrn@kroah.com>
In-Reply-To: <YxrTiN1OuJ2cbtrn@kroah.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Fri, 9 Sep 2022 08:01:29 +0200
Message-ID: <CA+sZ8B_VtmUWnvvfWBUV1WVq_=gRid+6ffGRQwdxp+9DYcLDtw@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: fix potential memory conruption bug
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Just out of curiosity, how can we be sure that sizeof(unsigned int)
is never 8 bytes? The C standard doesn't say anything about this, as
far as I know.

Patch v2 will come later today or tomorrow.

Best regards,
Nam

On Fri, Sep 9, 2022 at 7:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> sizeof(unsigned int) is not going to be 8 bytes, so there's no memory
> issue here.  But your fix is good, so can you please just rewrite this
> to be "make it more obvious what is happening" type of patch?
>
> thanks,
>
> greg k-h
