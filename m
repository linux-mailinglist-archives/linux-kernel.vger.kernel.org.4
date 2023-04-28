Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3CA6F1BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjD1Pla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjD1Pl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:41:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BC8AF;
        Fri, 28 Apr 2023 08:41:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8b3ecf59fso102120091fa.0;
        Fri, 28 Apr 2023 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682696485; x=1685288485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3VErSpuylynLkUN12PRxQCfO6PMorntvr8IR8nKdKs=;
        b=HWFLccrjCbosVhL492Rzg7+eCBgG1hmOYNBDPDvB4pR/gZphAA17xyiHXpibj9TjS3
         WhfsFfgScx47o8L0R6WgRlAkQDlnKaLkdT9a/8gRd1Xtv3leglFWOC/kUXJ783fDwESP
         fI5n5qvDvIdjLXXDqZ8ffTx/9CdDX8+KuVPuSoWniiFHP4V3UF7EaaLG/oucj0RhTPAf
         sU5x+TioT3GmpJkwWlkK6GmFWltYh5rtN3T05JaPRpmvAYYfRoq7MgD6RJQONopN9ehP
         OspOC6TOga2Kno8p7Q/SY0c5HsJH0vBcgH+/HXnIU4ssPCdsKroxvireAmmWU9Pe9IWr
         nHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682696485; x=1685288485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3VErSpuylynLkUN12PRxQCfO6PMorntvr8IR8nKdKs=;
        b=KTnEHW5F6/SxQQCWTQuP5XVA3fG4f3qYF3+vcRb9VILRVr7qkWSGPVy8tqXws5ZRt4
         g624IFi2YmsztZJw1RbBL8jjpJAApoGzhO3jDFo7eFRlxWo6Cx2tJ8z9RYi/w3jkmeAK
         m4Fn2+1P5GLIGDwYXLqDYaewB2zXm8Mj8sbLNx0kYYiH4gT0yR9uR1ASDcSbfH/7Njgw
         AMkICEzg51ptpaVQ0IU2PdtXqfbTZkG7WRKoP6FkZcgC0UZ+XmZdeVWnt7nomMpkn+zr
         Q3l7hwqy07D/ardaCgi+b03ZgmtC8JrwzmvloaeQzXz7koZ+zWk743NICPcVr48E2201
         fBZQ==
X-Gm-Message-State: AC+VfDxwFkI1xpNODu3/05dNzQZrXZs43vrWB10/qh5WmP5tM2GMe42M
        LppxiK4Kg/qd9MB8gWNoL18PsQVN9ElNVK2/X6t9xfUkdII=
X-Google-Smtp-Source: ACHHUZ7leFNSSwEfc5SpQhgZnvITeGYbELfytlPnEAiACkYibO/seWLHZy8TYF5RdZmKXJ2U4pmwk5CKtSRc/5fwlbk=
X-Received: by 2002:a2e:9248:0:b0:2a7:b1de:3ff7 with SMTP id
 v8-20020a2e9248000000b002a7b1de3ff7mr1636260ljg.16.1682696484571; Fri, 28 Apr
 2023 08:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-13-jorge.lopez2@hp.com>
 <cf54c6f4-d177-4904-82ee-9d33566fb920@t-8ch.de> <CAOOmCE8rpA=XvWBxcyRVu_gOHie3qN0E15Rs9bLfhb6tPZ7tyg@mail.gmail.com>
 <479b18e3-a35b-45c7-8c8a-cd30af646977@t-8ch.de> <CAOOmCE87dV6pnnU7r8Ycf0XcVERpRFRZeK6=y+nC+_Fc1EuJMg@mail.gmail.com>
 <7bdac640-cf61-429f-acd0-f8aa40b41e73@t-8ch.de>
In-Reply-To: <7bdac640-cf61-429f-acd0-f8aa40b41e73@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 10:40:59 -0500
Message-ID: <CAOOmCE9pWqqN1zNAfdaWFL_cZvSfiEpQjETVeECR0BAw9-sVDQ@mail.gmail.com>
Subject: Re: [PATCH v11 12/14] HP BIOSCFG driver - surestart-attributes
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 10:21=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-04-28 09:58:01-0500, Jorge Lopez wrote:
> > On Fri, Apr 28, 2023 at 1:03=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > On 2023-04-27 17:17:57-0500, Jorge Lopez wrote:
> > > > On Sun, Apr 23, 2023 at 7:16=E2=80=AFAM Thomas Wei=C3=9Fschuh <thom=
as@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-04-20 11:54:52-0500, Jorge Lopez wrote:
> > > > > >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++++++=
++++++++
> > > > > >  1 file changed, 130 insertions(+)
> > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestar=
t-attributes.c
> > > > > >
> > > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attri=
butes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
> > > > > > new file mode 100644
>
> <snip>
>
> > > > > Instead of not returning any data, why not show as many results a=
s
> > > > > possible?
> > > > >
> > > >
> > > > if count * LOG_ENTRY_SIZE > PAGE_SIZE then I prefer to return an er=
ror.
> > > > if the count is correct but a failure occurs while reading individu=
al
> > > > audit logs then we will return a partial list of all audit logs
> > > > This changes will be included in Version 12
> > >
> > > What prevents the firmware from having more log entries?
> > > Wouldn't these audit log entries not accumulate for each logged
> > > operation over the lifetime of the device / boot?
> > >
> > > This would make the interface unusable as soon as there are more
> > > entries.
> >
> > BIOS stores a max number of audit logs appropriate to the current
> > audit log size.The first audit logs are kept in a FIFO queue by BIOS
> > so when the queue is full and a new audit log arrives, then the  first
> > audit log will be deleted.
>
> How does it determine "appropriate"?
> This would also be great in a comment.
>
> If the BIOS is just using FIFO the driver could return the first
> LOG_MAX_ENTRIES entries.
> This would avoid trusting the firmware for a reasonable definition of
> "appropriate".
>
> > >
> > > > > > +
> > > > > > +     if (ret < 0)
> > > > > > +             return ret;
> > >
> > > And this should first validate ret and then count.
> >
> > Done!
> >
> > >
> > > > > > +
> > > > > > +     /*
> > > > > > +      * We are guaranteed the buffer is 4KB so today all the e=
vent
> > > > > > +      * logs will fit
> > > > > > +      */
> > > > > > +
> > > > > > +     for (i =3D 0; ((i < count) & (ret >=3D 0)); i++) {
> > > > >
> > > > > &&
> > > > >
> > > > > Better yet, pull the condition ret >=3D 0 into the body, as an el=
se-branch
> > > > > for the existing check.
> > > > >
> > > >
> > > > Done!
> > > >
> > > > > > +             *buf =3D (i + 1);
> > > > >
> > > > > Isn't this directly overwritten by the query below?
> > > >
> > > > buf input value indicates the audit log to be read hence the reason
> > > > why it is overwritten.
> > > > This is an expected behavior.
> > >
> > > So this is read by the HPWMI_SURESTART_GET_LOG method in the firmware=
?
> > >
> > > Make sense but need a comment.
> >
> > Done!
> >
> > >
> > > > >
> > > > > > +             ret =3D hp_wmi_perform_query(HPWMI_SURESTART_GET_=
LOG,
> > > > > > +                                        HPWMI_SURESTART,
> > > > > > +                                        buf, 1, 128);
> > > > > > +             if (ret >=3D 0)
> > > > > > +                     buf +=3D LOG_ENTRY_SIZE;
> > > > >
> > > > > So 128 bytes are read but only the first 16 bytes are preserved?
> > > > >
> > > > > The documentation says that each entry has 128 bytes in the file.
> > > > > And that they are separated by ";", which is not implemented.
> > > >
> > > > The statement will be removed from documentation  (separated by ";"=
)
> > > > audit log size is 16 bytes.
> > > > >
> > > > > Can the audit-log not contain all-zero bytes?
> > > > > If it does this would need to be a bin_attribute.
> > > >
> > > > Bytes 16-127 are ignored and not used at this time.  If the audit l=
og
> > > > changes, then the driver will need to change to accommodate the new
> > > > audit log size.
> > >
> > > buf is not guaranteed to have 128 bytes left for this data.
> > >
> > > For example if this is entry number 253 we are at offset 253 * 16 =3D=
 4048
> > > in the sysfs buffer. Now hw_wmi_perform_query may try to write to 404=
8 +
> > > 127 =3D 4175 which is out of bounds for the buf of size 4096.
> > >
> > > Writing first to a stack buffer would be better,
> > > or pass outsize =3D LOG_ENTRY_SIZE.
> > >
> > BIOS currently stores 16 bytes for each audit log although the WMI
> > query reads 128 bytes.  The 128 bytes size is set to provide support
> > in future BIOS for audit log sizes >=3D 16 and < 128 bytes.
>
> And if an old driver is running on a new BIOS then this would write out
> of bounds.
> Or if the BIOS is buggy.
>
> If the current driver can only handle 16 byte sized log entries then the
> this should be used in the call to HPWMI_SURESTART_GET_LOG.

BIOS WMI specification indicates that the HPWMI_SURESTART_GET_LOG call
expects a 128 byte size output buffer regardless of the actual audit
log size currently supported.

Return Values:
Byte 0-15: a requested Audit Log entry (Each Audit log is 16 bytes)
Byte 16-127: Unused
>
> Storing it in a 128 byte stackvariable would also sidestep the issue.

The driver hardcodes the audit log size to 16 bytes.  If the new BIOS
provides an audit log that is larger than 16 bytes, then the logs
provided to the user application by the old driver will be truncated.
