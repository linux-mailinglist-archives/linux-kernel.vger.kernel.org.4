Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036B4706AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjEQOLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjEQOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:11:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E961BE;
        Wed, 17 May 2023 07:11:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso830511f8f.0;
        Wed, 17 May 2023 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684332698; x=1686924698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e+r2uc4OmPDjJgVs7Z2mAj6c/sVqSu98zPAwKRes6Q=;
        b=ZeOoZLCrH48x6d6nKsY+aXfSIgw2t6M/Eb3b5QzxJlkQsRW1sNU/aAVTzoH/hwKSwF
         fEohluQLOPyJ1zXYbST44k8sQ2iCZ5sXvQHltD7KKXTJip/yrH3Gf4B8U+esfu6UFyHC
         A1VnSx1DLs3WtYGzB80hIkVmu8oIGE0gDr9/qSKCB7geSyLLn0HfQXRgy90xuJdYRg9M
         09jPvvegFJv5mg0oHHKmea3/Ym2RsDvHrKc8M7HEkkw5vk92M3Ql6EbClRNnNNrQUJGG
         RD3fYI7Qhvm0i3Fk0BWYDFltbnJP2HdSwSsVVqIwAVU3EqTkzmTEoDM4I3jofUWltZUw
         HYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684332698; x=1686924698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e+r2uc4OmPDjJgVs7Z2mAj6c/sVqSu98zPAwKRes6Q=;
        b=ALkuy2NN7pj3NAUtPSGe/ixoF80/iDjFlLmcyZRZkETvEe9nPRdYeHAZIuV49UqQ+O
         QdTfciXsoD9D+Vwyh+7D0dfWCJBMZQlniDNUL7uOwIgHZxtAfMFIvuhXoR54RPFirIak
         yipiJYcgJN8fRppEVOLppj+7YQa1f+r3pEob49IkvZqim5gHjz1ccALdVEl2a3DTndmG
         rP1aTmNl9voyZ045i/JlTVsJEcYtFTqgGAJNPwqiB9JLTspKSk3B3zPIz4m89U23OsXe
         tIq8nAm7kSFitkezszxc2iQRep7i+9YETbbaXvgbwW6TsfBjw2Ly7KaU3aoTAzRHzw7p
         wprw==
X-Gm-Message-State: AC+VfDwBumJgfoL7/Y4wgjjyQBWPRXBm9jKDReJajemUOd6KFviAh5fF
        blGwwDi0yaDaRy5pMo+bmC5bUhaKEotJph3/Z/VeaXg+Lhk=
X-Google-Smtp-Source: ACHHUZ6T5VvF1IFuVPUJP7oTXLbsycEg7Y8ZRHU1N/T1coXjsDiqL9cXwRXyU5glly89GgPksLmyX6Z5nSFZoNjTeTs=
X-Received: by 2002:adf:ed49:0:b0:307:82e3:70cd with SMTP id
 u9-20020adfed49000000b0030782e370cdmr865690wro.14.1684332697598; Wed, 17 May
 2023 07:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230516025404.2843867-1-azeemshaikh38@gmail.com> <yq1cz2zu42r.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1cz2zu42r.fsf@ca-mkp.ca.oracle.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 17 May 2023 10:11:26 -0400
Message-ID: <CADmuW3U+AMVf5xDVTri4Mtyk1GnHf+E_6kPJcsNUSPjF05u7qQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla2xxx: Replace all non-returning strlcpy with strscpy
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Tue, May 16, 2023 at 9:42=E2=80=AFPM Martin K. Petersen
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
> Applied to 6.5/scsi-staging, thanks!
>

Thanks a lot for the quick response Martin (on this and other patches
too). Just for my understanding, do you mind pointing me to the
6.5/scsi-staging tree?
