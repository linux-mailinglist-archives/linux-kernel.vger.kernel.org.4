Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1B6EE5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjDYQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjDYQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:40:35 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A8161A4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:40:32 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-545d82e1a1bso1836538eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682440832; x=1685032832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYcOlDUgSQC91lLFNrwBssd/XfJKfDHEQlezinTEY+o=;
        b=MZ17Z0PQPxrm+4cDWrptsGy3ZyzNCoH3CIJB9ZQkscmtEzDMYvvHTIReyN5ujqSeNl
         DYNW05IOb3cdRrCjN/jD+DqlINOq06XW6VZs3geziSG/+OJNoFlSjKcp11Vb+DSrftes
         WlswallJPeZhY5zG8xf6QL5FV43gEb4jVehezQkY4dDFtS67ZO7xObFanZgeS9JwIaKg
         WJomoPU+MqM2loEt4np8Qq34a1xeg26DlNDXRSHHTQGiQj26Uhtz6WyCWwsBjQm9SVaI
         xrS4KBahpprAOTZnoP/f+40zIEzNjCM+5ApbJ709+pK3UxC1TguFUXueeOZDxSu+A6lK
         B7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440832; x=1685032832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYcOlDUgSQC91lLFNrwBssd/XfJKfDHEQlezinTEY+o=;
        b=OXE/5VKZ5NlNKHJwCR5jl1u3uAnnu0PdatZ7WtIbLa/sEWyEpeQdHRlH5RYxy66svd
         sXZQGiDyqhWWUbS8M3pCQJQ6rgRRytLlUYocanSwLaftel7zNEwweQrIN22OT7oPT2h7
         KveHcmwmZDM5/RCq+UMNgCJ8+X6rgiBX6EVdFMTqdJ9CKBFgpcvinJQreEpKLdLOsCvV
         8piq4NvY9s8e5T0IYvf2+0mwBv3jvzGVC/z4mqEfF+UhdMe1VQ4771J/9RknQrQA0r6I
         uVMTJIKDtmHFoQz/c9yDieVn3KerkODBKlrBix+9YgpxhWBhF92nBQn7NCogo/RsZat/
         X8Fg==
X-Gm-Message-State: AAQBX9dNj6AfSoayINpoYqJUuyGNyrZ+CBGEGl6ulTuLZt9jPI4q3Qry
        QTFPbRtEfcNvTvNpmbcPnu2DAUBOGPfYuh+RTXhGkQ==
X-Google-Smtp-Source: AKy350a2yB0nuemt+nmOjYhCexYuzX14O4BypIJ/FXvrQcHOcfU42ioJZfQbPIJU/yW46F8FfUsNHvc7eUksmTSqZe0=
X-Received: by 2002:a4a:a50f:0:b0:547:8bfc:be38 with SMTP id
 v15-20020a4aa50f000000b005478bfcbe38mr3717702ook.1.1682440831648; Tue, 25 Apr
 2023 09:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <6faea48203e5fe2f4c95106dd95ffceed8c5f236.camel@hadess.net>
 <254bb806-c5ac-371e-4e25-1cfa5c8ce388@gmail.com> <f82bdf01743b11e92873c5c9937ae253bd1c8bb3.camel@hadess.net>
In-Reply-To: <f82bdf01743b11e92873c5c9937ae253bd1c8bb3.camel@hadess.net>
From:   Siarhei Vishniakou <svv@google.com>
Date:   Tue, 25 Apr 2023 09:40:20 -0700
Message-ID: <CAKF84v1+TzJcBbp57NcCsrD2LJFvLUC1djskNKoq2sykkNEFfQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add rumble support to latest xbox controllers
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Edward Matijevic <motolav@gmail.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right, confirmed on the BLE support.

I uploaded a new patch with the C-style comments and added the
xbox.com link to the commit message.

On Tue, Apr 25, 2023 at 9:07=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2023-04-25 at 10:46 -0500, Edward Matijevic wrote:
> > > > +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708    0x02fd
> > > > +#define
> > > > USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE        0x0b20
> > > The 1708 model uses Bluetooth Classic, not Bluetooth LE.
> >
> > The new firmware adds Bluetooth LE support to the 1708
> > and prioritizes BLE over Classic which necessitates the change
> > The controllers are broken without the "new firmware" IDs which are
> > for BLE
>
> Oh! I completely missed that. So both the 1708 and 1797 used Bluetooth
> Classic with the old firmware, and support Bluetooth LE with the new
> one. Am I understanding this correctly?
>
> If that's right, looks like I might need to update Wikipedia ;)
>
> Seeing as you will be updating the patch for that comment style
> problem, you could probably add a reference to this article in the
> commit message, it seems authoritative enough:
> https://news.xbox.com/en-us/2021/09/08/xbox-controller-firmware-update-ro=
lling-out-to-insiders-starting-today/
