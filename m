Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E557170E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjE3WnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjE3WnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:43:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBCAEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:43:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f7bf29550so783928566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685486593; x=1688078593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8RVXLYgdzUMV2q+6sOMeXIaKNwf83t9uqStvN0uPe4=;
        b=dKveP6ipxEp3Shiie7EcNlQLqfCSPHCSuSWwct2C8fNa3z2smQZ5x82L1AfFtbZQbE
         f+mbLo34TgNhELb1iYmU7oZhFFePacmZDYZTF7mw7LMD581jzm70W14PbDE1LZY0YB3z
         N5LLs90PPDPiQO8+LzNDbYKdgp/f4wr4O2Zck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685486593; x=1688078593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8RVXLYgdzUMV2q+6sOMeXIaKNwf83t9uqStvN0uPe4=;
        b=Ilo6hNrXxWCJehxkOQMKEveX9bkgPw/CIWCuIss520zo1JM7veLeOisfEN3zQ2g9Tj
         CYnv3y679aJ28DwOfP46mdiUIaALrOKWC7dc71kim8nkWgwpmACZBxEpNzF72nwrJ91M
         0vLI4RkaFc1yKBpA5vbJ0abWejDF0uje2F1tFe0/pU31rtXQiM2RYC9ig9i3E7AuRJyp
         Wb010gvi6O0RLe1jnlB4udoDoiEbmD5Rrumm775b8cTBQXHfkYgYpo865KQCjp7b5sO0
         BbMybYJgRDwHcM4/jRvdO38Yn6rXjuwQUDktHoG7T8B9sQk+TmP9B8dZfDO2kPZ+nPzF
         FAaw==
X-Gm-Message-State: AC+VfDwIz6vfWWmkLFQZupJQaPoWF1hTcF/dOWgDdVYNyVCWqjOasvp8
        ENuPghCdAbbA6Nh56oseLY+OIpuJP3+j9yQ1G3dsc4MU
X-Google-Smtp-Source: ACHHUZ65PfgHaos5MWAPMnENBSaiXHf3MUD2i9V7V81c8iYyxIZtuLQ+BpbFXHc+/LN9ewRP4qF6xw==
X-Received: by 2002:a17:907:7285:b0:96b:e92:4feb with SMTP id dt5-20020a170907728500b0096b0e924febmr3578912ejc.60.1685486593337;
        Tue, 30 May 2023 15:43:13 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709060b5300b0096621340285sm7955300ejg.198.2023.05.30.15.43.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 15:43:12 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-96f7bf29550so783926366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:43:12 -0700 (PDT)
X-Received: by 2002:a17:907:3da1:b0:96f:aacb:6f15 with SMTP id
 he33-20020a1709073da100b0096faacb6f15mr2905332ejc.31.1685486592131; Tue, 30
 May 2023 15:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com> <64767669744d4_168e29489@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64767669744d4_168e29489@dwillia2-xfh.jf.intel.com.notmuch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 18:42:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whHjT-KWPjQK8iSaHJa7WX_LuKgZt_iX+jDxRxDD2Zjdg@mail.gmail.com>
Message-ID: <CAHk-=whHjT-KWPjQK8iSaHJa7WX_LuKgZt_iX+jDxRxDD2Zjdg@mail.gmail.com>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 6:19=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> I know that the "Link:" for "mailing-list thread where patch originated"
> is mostly useless information [1], but when it comes to quickly reporting
> test results on the output of "git bisect", it comes in handy.

It was literally there in this case. We had multiple links, and you
may just have been overwhelmed by the pure cornucopia of links.

In this case is was the third one:

    Link: https://lore.kernel.org/lkml/ZG%2Fa+nrt4%2FAAUi5z@bombadil.infrad=
ead.org/
[3]

which linked to that thread.

It's the links to pure patch submissions that are useless (ie the
"this is where I sent the patch"). Those lore can find for you
automatically.

Links to actual threads with background and test commentary are
useful, and I add those myself. There were several of them.

                  Linus
