Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC10567A8BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjAYC0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjAYC0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:26:13 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4FB4FAD1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 18:26:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c124so3935346pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 18:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cV6KVSSGtNGRJfjfNYuzBr00PLE2dEnEYHcWPWC/oR4=;
        b=q6NPvXAOBggDueidnANdnVGu82GP1bJPyX7fIbKtgO0NKaZrpFtRiR1YcwdY0qebXJ
         hVhwHtMyZnHgQTulEVj5X0jkz1RcUShwu1+nKO0M2ZWCuJg/9TqvIhcTDAUzgD9eQWzq
         Qpa9N6HQxkDNP4gUF3pQB3AcVqT2EE3dJ2bu7xxChjNhTDornigg9fe0nIrt0Y36gPyE
         Vaq62tahohaWY21rorNZojRSCRtoFUupkDjhM77krZoKFwD55FAjMuLcH4gbmvtWzaSz
         e9WfEfqR8ZMlbeUF13hNwPHjkFtOe4HVyHEy7XDZRPwwp5Wt4WB5siML9N+CfEAnE6q3
         PoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cV6KVSSGtNGRJfjfNYuzBr00PLE2dEnEYHcWPWC/oR4=;
        b=dYSrmqeDkbMgsYDohpnTRFiPQHcFAlWStmc5Sz+L5j324iKTLsSnLvLuaLbpaoe7nG
         gLL/lqqDUpGzcyniSo5EglOsyXtj4tyiaG5n8wNdDv32kusapOaSJO7CJZCa7MMIMw6l
         CdhNIiftZ8o7CEHwrCI0w3eiJ9ifdJD/Zfl2fQBmtCS6BoC4wrOl13dJAw8XlxWl2sEH
         V3GxnD9aIimOxwEbrzOb7LUyfEF3brsn9Fl5kZmTGzVlpfqnLDwfMDMsRWAQcO59vpAQ
         25+DCq8Vy6B5KYUSzF/t1PrChJWd/wvKx+0fqThOoR7Cl1BPSvpfF4zZxmj//PDGoCSx
         +row==
X-Gm-Message-State: AFqh2kpO42q3GFsch+YTarc+EJA4voGBEBnpjIsx6fm+uuTB2rjDyaHu
        dSzrWWFyuVOF+/YNr69yVBmGHvNcgUWE4keLPwEMkFfp/VMqpwPs
X-Google-Smtp-Source: AMrXdXs8uKpeQsvDll5Udxcxiwcr0NQ4r+nS4f5zAQj/5ra2qzkjWd+JVKiVIeci48T38u+iQBRiqv54IXGYfmMSVIg=
X-Received: by 2002:a62:5258:0:b0:58b:a608:6956 with SMTP id
 g85-20020a625258000000b0058ba6086956mr2793251pfb.12.1674613572254; Tue, 24
 Jan 2023 18:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20221109170341.36785-1-steffen.kothe@skothe.de>
 <CAGETcx9fx3TcgeD+pMyp+LuGfd=hOo5_Weeii2W1Mbd1T2Ua0Q@mail.gmail.com>
 <Y205W3kavB5tIDK3@p50> <CAGETcx9Z2_Oc-L8Y0x+zuPUEgeaDSnFSFUSU+nxcF5Rxtf6FvQ@mail.gmail.com>
 <Y29qN1fFq4SFXCT2@p50> <cff9a58b31e3493fb1231db54705bb30@AcuMS.aculab.com>
In-Reply-To: <cff9a58b31e3493fb1231db54705bb30@AcuMS.aculab.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Jan 2023 18:25:35 -0800
Message-ID: <CAGETcx9io_3DYqpyo4yPZjicp+P83oZ5zuRP9FRNxXB1+XcGrQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: dev-needs.sh: Enforce bash usage
To:     David Laight <David.Laight@aculab.com>
Cc:     Steffen Kothe <steffen.kothe@skothe.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 2:30 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Steffen Kothe
> > Sent: 12 November 2022 09:41
> ...
> > What about a re-write of the script in POSIX compliant style? This
> > should work then in every shell derivate without weird checks.
> >
> > This would remove for example function declarations, arrays and so on,
> > targeting to the same printable output but with different logic in the
> > background.
>
> A quick read:
>
> - remove the word 'function'.
> - remove all 'local', ensure names are unique.
> - use 'printf '%s' "....." instead of echo -n.
>
> That should be pretty near portable.
> Some shells that don't object to the 'local' keyword don't
> actually implement local variables!
>

Steffen/David,

I'll happily test and take any updates that's at least as readable as
what's there now, as long as it continues working with toybox.

-Saravana
