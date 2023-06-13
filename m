Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE872DCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbjFMIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFMIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:46:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F947BB;
        Tue, 13 Jun 2023 01:46:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5187a752745so135702a12.2;
        Tue, 13 Jun 2023 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686645992; x=1689237992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gm3y3c9SC3WmG+sMuJQnvI8NH+hyxGs194qjs9xteCc=;
        b=Mn2kGGs1rTyCzkMgpLy+Xc88RqGBJ/oUyUx4w6UQlWaMTJVqubTjLtLTVD2gv4OTAf
         r0f2TstyXNFKwviLkDCct2IRpHr5BglY+kyd29KUrQFpFFPm82wvOW2VjpHy4QxbVPUG
         lGlS3CznR92r5MGs5fr6L7xM7jkr9wefQiML3t0ID6cfp8gmuinyQMG28sb/ugULIvRi
         ZjLF8PpggMt6dadO5O58LE2PMDxb8+tCMQgCh9UrXrFFXRAvf1eGl1slZBd48USEHWun
         JVxSZTxQRUjzUYiSStAXDbUABq+FarvYLdB/Idc5n66mP61rBZg3mMmanc7X+MXnTPoP
         fE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645992; x=1689237992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm3y3c9SC3WmG+sMuJQnvI8NH+hyxGs194qjs9xteCc=;
        b=A9YR3lHO0glo3ERg1RSgSzUKaD5SmbhbWXh2huFOxImCIPZxtfsLmv3/cWGP3Exa9X
         6wld2iqgblPxmx60LExSrkCRwkBpAap96AF+r2YL2JNPT+/asA7KsNPtEEO73ASwp49m
         H9IM+nLBXuP2iX2942/vtqF6LEqskzFSQPMydCFQDbkFsEP3EqAgs1VyEnvI/wIBGkt3
         VCrpEZ07XHQlBrQvGzsWJffgyyHR1sqNNnCw4zEAI6u7fCmaKJR/PNhKDD4t+VfL56mh
         Mv0H5nbtkUc3MDUV3dWpb+rxS+cLdO9KfvHz8ZZFf/DncWq94QS3UFtEWjgNqDhbsRQg
         IulA==
X-Gm-Message-State: AC+VfDxPWz9R8ZCgtxyqNKIUYu8RIDF0YEpgXepkZsUrer4rgxdMwqpO
        8q4Xsx1jyylr5pDrzXWrJGw=
X-Google-Smtp-Source: ACHHUZ7kGoeSl5kX6/T2sHXdzDUX1Ixt8nh3bCz6EFLdtg477+/Qg1jhrmYmcSQffYMsIc8ZNM0SIA==
X-Received: by 2002:aa7:d402:0:b0:516:4394:243b with SMTP id z2-20020aa7d402000000b005164394243bmr7426738edq.23.1686645991406;
        Tue, 13 Jun 2023 01:46:31 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7c489000000b0051422f31b1bsm6025034edq.63.2023.06.13.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:46:31 -0700 (PDT)
Message-ID: <0ee291f54c38b9c88c9fd5bac15f7421663c7276.camel@gmail.com>
Subject: Re: [PATCH v1] iio: ado: ad7192: Add error check and more debug log
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date:   Tue, 13 Jun 2023 10:46:30 +0200
In-Reply-To: <b38cb68185b078fe346727b6dceb17967a56c18a.camel@gmail.com>
References: <20230613054250.472897-1-markus.burri@mt.com>
         <b38cb68185b078fe346727b6dceb17967a56c18a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-13 at 10:19 +0200, Nuno S=C3=A1 wrote:
> On Tue, 2023-06-13 at 07:42 +0200, Markus Burri wrote:
> > Print read and expected device ID as debug warning.
> > Add error check for ad_sd_init() result.
> >=20
> > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > ---
>=20
> You have unrelated changes but they are easy enough to go in same patch
> (at least for me). Hence:
>=20

Actually, consider my tag valid after fixing the typo you have in the commi=
t
message...

> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
>=20

