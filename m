Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04E96B9BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCNQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCNQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:36:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC8D98874
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:35:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y11so17232007plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678811755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAjOGSckdnHm2OeMQYUM/H8ogajGHwJv7Y0Pfhetrqo=;
        b=YY6a/HY/Ed27pEnqu16WhVNf7b7IgiVZvBJ+CSSWPTb6ob7HqOBFeqFpAb5eBYfnAG
         y1cSlN9AMhOyvENpuEnB9IErBs38Wcmwo3jPwDYLwL++k3IXLTZDhMW/ecXGR6CV9bTD
         Q2GCHg91XC6efMKUKbwd84UkB/sZcmwZW6fgyI0z9lDJ7t0QQme6BtLdpYQ/jyHAlHwK
         XnioqfMtfJLY1Cw6wQkyJsz1xVbFzDsJgk0CmiqFneUwvsQ5BCyJyyoWpaZXLRgRrUd3
         ZmnfCDkclrR22EvGR2bqIzgv/ftTO+bBNPQFl7PfyLqLitcmZGKo0AUoILosdsNzkC9n
         6EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAjOGSckdnHm2OeMQYUM/H8ogajGHwJv7Y0Pfhetrqo=;
        b=etS4q8uPJ2QsTS8XefTjsAn8iEODSrF1c5vxf9GKd+u+UnbefL7YSf6jkp7anhd5GU
         RixRQM7fPw98aAr1DpsSVuHxXvdGHCC2LX0/ywVtcFrF4JtAuHKqdvMfJyTDVr6F19ne
         i7YqzBT9o1lo2eiDlFFuhWRrcd28Ux+6JLOk+prX7z4eyil5K7UIMSTjsHD7xbLi0CC/
         elewnmTzAWucQJMavjzjoPLIZ8YnBaGLsWEC5hsOOXZFP4gAJ7AoV5LiQB/tHv6WzLzx
         5BOZKTLlVqZlnbNG2GApeKKefaNvFrj1U59tAccnU6xFQ1kMwCjguyvavhOXsMeWybTD
         LDPg==
X-Gm-Message-State: AO0yUKXeaambrvDhFfoHvSWeaNSSD+/5PgH0AAJdgo4q1a6Ej7/m3UED
        HCIXCGQSgsAnLJVmiXWvJH5uLKH+WzmPgJ5pBc/ktSZ/0QNqQnfJTKU=
X-Google-Smtp-Source: AK7set9MQFVEuaVVZUed71FCJWttmpPWL2umLBPapaPng/dWbVxf40Fp6VidXNphtio+jUHqZTxVe2bHy36mlemk5fQ=
X-Received: by 2002:a17:90a:6e06:b0:23b:5161:f66f with SMTP id
 b6-20020a17090a6e0600b0023b5161f66fmr3206753pjk.9.1678811754855; Tue, 14 Mar
 2023 09:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230313232719.3565369-1-saravanak@google.com> <ZBAQZKY+PuVeGDu1@kroah.com>
In-Reply-To: <ZBAQZKY+PuVeGDu1@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Mar 2023 09:35:18 -0700
Message-ID: <CAGETcx_ns6qvApMp=Xq2yhK--YJgZjy5LnWNAGFbxOdY1FRnCQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 13, 2023 at 11:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 13, 2023 at 04:27:19PM -0700, Saravana Kannan wrote:
> > Add a build time equivalent of fw_devlink.sync_state=3Dtimeout so that
> > board specific kernels could enable it and not have to deal with settin=
g
> > or cluttering the kernel commandline.
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/Kconfig | 10 ++++++++++
> >  drivers/base/core.c  |  5 +++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 6f04b831a5c0..da91b409482f 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -230,4 +230,14 @@ config GENERIC_ARCH_NUMA
> >         Enable support for generic NUMA implementation. Currently, RISC=
-V
> >         and ARM64 use it.
> >
> > +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> > +     bool
> > +     default n
>
> n is always the default, no need to say it here again.

Ok, that's what I thought, but then I got confused by the other
default n in that file. I'll fix this.

>
> > +     help
> > +       This is build time equivalent of adding kernel commandline para=
meter
> > +       "fw_devlink.sync_state=3Dtimeout". Give up waiting on consumers=
 and
> > +       call sync_state() on any devices that haven't yet received thei=
r
> > +       sync_state() calls after deferred_probe_timeout has expired or =
by
> > +       late_initcall() if !CONFIG_MODULES.
>
> I think you forgot a noun in this last sentence :)

Hmm... reads okay to me. I'm open to suggestions if you want to tell
me exactly what to put in here.

> And add something like "You should almost always want to select N here
> unless you have successfully tested with this command line option
> already"

Will do.

-Saravana
