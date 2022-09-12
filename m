Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C55B5A26
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiILMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiILMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:31:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705D112AA4;
        Mon, 12 Sep 2022 05:31:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id wc11so5263501ejb.4;
        Mon, 12 Sep 2022 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date;
        bh=edwp85zlOX7yw7YEYC2YVlvs7GJrKAVU7cYkpEsth2s=;
        b=Pt8n98hKt58SxviaSOEmFbNsr6aNvKhho6HhT7w4wDvCOF1GeZXTu2kEteMc54hGZ7
         8S6Hcu5zmi7r1cudyvLlQf7VFeg9N3i7+wdgy0dvWpFSiXi8fgdvXgh+wHnWrKWl+yHy
         Cbo1/VS1YCHu0WLBAIayfWqBsJoCZgRf+kSbsD6hMj96PMp4Y06HgqOmOt+LqlZeutWz
         m3QaiDpGmd9rflDkQMSIirtbd/kllBiYD2aAdPKklM/yPBHlM/wPaSvCvexa4FTsxal0
         GlEnVgaSrxDYq8kTsJ7p16fKkiDUrUXedugfbRJBkg2mGa/h+AuXD4SW0A3BkXuOjtkc
         CNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=edwp85zlOX7yw7YEYC2YVlvs7GJrKAVU7cYkpEsth2s=;
        b=d+f74y5MmIDfKOEoCJtPfjRkFvSDGlOYNJI2bu5M7v3hLfDe5iVG5cQoUpUK3klWA7
         nplkVWCDxp1FCCXToMtpVQXO0zh1AVPegrn7X7fbb6k3t9H/16KepKbpo7WZkObeMq+B
         9J8g+jihK/PVZV5FdFblpGwJAmspR+usPIGlebLXXB2Tr+KWh315mhDiguGiRFt7OP6L
         N/XFs/1+RHUoUuztCB8tVycHd1Dc1kuqB6RdOg9x6TBvsWNnlOvghKA4OByAMu0b+605
         KLt90V4N8H4B9AvCiCRvKECtzNs4x3mwyYeNlmIhNlQ0fMW5keL6QJy19vObeqDIYOJx
         RrWw==
X-Gm-Message-State: ACgBeo2cU+tpdsee+F74u7S2RhncWEFl7ked28F4EZTLovuMOUpGtOeM
        GkCO2VMLOeADlQ8icXA0C0Q=
X-Google-Smtp-Source: AA6agR6nO1LJ+qTl0cn3qDdtRZbDRHUzUeMQlHTo37tlV8NmM+GRlu3ubNT/USe2Qdv+pCdn7ICtOw==
X-Received: by 2002:a17:907:72d6:b0:742:133b:42be with SMTP id du22-20020a17090772d600b00742133b42bemr17618229ejc.581.1662985873397;
        Mon, 12 Sep 2022 05:31:13 -0700 (PDT)
Received: from localhost ([2a02:169:1e9::acc])
        by smtp.gmail.com with ESMTPSA id kz8-20020a17090777c800b0077a8fa8ba55sm4182681ejc.210.2022.09.12.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 05:31:12 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:31:11 +0200
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [RESEND] HID: steam: Prevent NULL pointer dereference in
 steam_{recv,send}_report
From:   "Silvan Jegen" <s.jegen@gmail.com>
References: <20220803111831.387506-1-lee@kernel.org>
 <Yx8cYZnmnN09lD4A@google.com>
In-Reply-To: <Yx8cYZnmnN09lD4A@google.com>
Message-Id: <3HW30DP4UX94G.2T1G25E825X7D@homearch.localdomain>
User-Agent: mblaze/1.2-12-ga352b8c (2022-09-04)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi

Lee Jones <lee@kernel.org> wrote:
> On Wed, 03 Aug 2022, Lee Jones wrote:
>=20
> > It is possible for a malicious device to forgo submitting a Feature
> > Report.  The HID Steam driver presently makes no prevision for this
> > and de-references the 'struct hid_report' pointer obtained from the
> > HID devices without first checking its validity.  Let's change that.
>=20
> This patch has been floating around since the beginning of July.
>=20
> It fixes a real issue which was found by creating a virtual
> (software based) malicious device and registering it as a HID device.
>=20
> There is nothing preventing a real attacker from creating a H/W
> version of the device in order to instigate an out-of-bounds read,
> potentially leading to a data leak.
>=20
> Would someone be kind enough to review please?

AFACT this patch has been applied by Jiri on the 25th of August already.

Is a review still needed in this case?


Cheers,

Silvan

>=20
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Cc: linux-input@vger.kernel.org
> > Fixes: c164d6abf3841 ("HID: add driver for Valve Steam Controller")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/hid/hid-steam.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> > index a3b151b29bd71..fc616db4231bb 100644
> > --- a/drivers/hid/hid-steam.c
> > +++ b/drivers/hid/hid-steam.c
> > @@ -134,6 +134,11 @@ static int steam_recv_report(struct steam_device *=
steam,
> >  	int ret;
> > =20
> >  	r =3D steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];=

> > +	if (!r) {
> > +		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to =
read\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (hid_report_len(r) < 64)
> >  		return -EINVAL;
> > =20
> > @@ -165,6 +170,11 @@ static int steam_send_report(struct steam_device *=
steam,
> >  	int ret;
> > =20
> >  	r =3D steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];=

> > +	if (!r) {
> > +		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to =
read\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (hid_report_len(r) < 64)
> >  		return -EINVAL;
> > =20


