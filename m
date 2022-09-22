Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83D05E703F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIVXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIVXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:33:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39323B5E70;
        Thu, 22 Sep 2022 16:33:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z13so15683464edb.13;
        Thu, 22 Sep 2022 16:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=1LXt/Xl96l/h02gNxY14SP+hwlW2CW/zPqjudi4txZc=;
        b=fqv/zq/AbEapAt+EgPEsbPLgCgTCKZ1NBLK27LsD6DzCubtAIgALh3KY6ZlKTbJ2o1
         m3B2BDzf2agcYCMmME6LzPKdo4o4NNKlEks2Z+noR/HY72y/W8KAPKUuuhyTqh+LJdTF
         ICzVzDLgoEegddS87mBSGb78ihj00VMB1q1fm27Mlx3PoLMMvhu25Ho2QnuS2o93fS+K
         tdnQ5gBHb6Jwbj0t1EHvRzlu17tuQza+iEn9QIT30AdSuvJHZqZuYwTaUxUK17jggLGu
         jwqPII8dCx+uqSjHq476mQ/x3YHqiRktPuPx79a6b0rHG7uiMMcjBchYwCtynqb4xAw2
         IAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1LXt/Xl96l/h02gNxY14SP+hwlW2CW/zPqjudi4txZc=;
        b=TPr5EqOk/oThaUoPCg6aDIDeM6Mx+WTtZwkP0p6Z9+DhtxboqQJpPf9jdRpOz1cN/u
         oScNPhs0qNB6amYWixRAXVyLL6+NFCZfDt23aFacTryfAteuNvHbCwgNhKOUk2/yyljy
         c8yBjEZHUacIt2HOpJWL6eyzNn/2tKqK7eI9oND557v733icZBcyjXRewXzBWtnrArTe
         si53y8kikH7O7XYLQ49lJuWxBu52zF7IkKOtpp3hEQjlmIl3xa1Ik3tA7cFACj5eqGsZ
         GI+oIF+XHJZU4Ko1Bnz67AUKA1KXL5C5HPcN8Jvi00Y/jdS5Al9ABKoC4WbRif0STbaJ
         Q0zA==
X-Gm-Message-State: ACrzQf10IpcDM5MtCo7SCJMWAVYyp/z+o4cw4TdQPJVtaWyFamaMJgrs
        S8dea1f7tuxeRe6D8VZayvOixBcwktLnqY6SCG8=
X-Google-Smtp-Source: AMsMyM5DiFBYbthi2FE2gsNbylvHS3uLjW2CJDgWIMSs+MGoMI7WxG6kvXEF3qzDcScXRg1BjFhd18LJR3IHxpCtG8E=
X-Received: by 2002:a05:6402:901:b0:454:2b6d:c39 with SMTP id
 g1-20020a056402090100b004542b6d0c39mr5581802edz.50.1663889587565; Thu, 22 Sep
 2022 16:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
In-Reply-To: <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 22 Sep 2022 16:32:55 -0700
Message-ID: <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Ferry Toth <fntoth@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>
> Hi,
>
> On 22-09-2022 12:08, Andy Shevchenko wrote:
>
> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>
> If the extcon device exists, get the mode from the extcon device. If
> the controller is DRD and the driver is unable to determine the mode,
> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
>
> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, c=
an you
> share bisect log?
>
> I can but not right now. But what I did was bisect between 5.18.0 (good) =
and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on =
the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: d=
wc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit =
before that (good).
>
> The effect of the patch is that on Merrifield (I tested with Intel Edison=
 Arduino board which has a HW switch to select between host and device mode=
) device mode works but in host mode USB is completely not working.
>
> Currently on host mode - when working - superfluous error messages from t=
usb1210 appear. When host mode is not working there are no tusb1210 message=
s in the logs / on the console at all. Seemingly tusb1210 is not probed, wh=
ich points in the direction of a relation to extcon.
>
> Taking into account the late cycle, I would like to revert the change. An=
d
> Ferry and I would help to test any other (non-regressive) approach).
>
> I have not yet tested if a simple revert fixes the problem but will tonig=
ht.
>
>
> I would be happy to test other approaches too.


It's a bit hard for me to suggest an alternative approach without
knowing how things are breaking in this case. I'd love to order one of
those boards to repro and fix this on my end, but it looks like this
HW is EOLed and out of stock in most places. If you guys know how to
get my hands on those boards I'm all ears.

Barring that, Ferry can you dig more into this failure? E.g. is it this hun=
k

@@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
                 * mode. If the controller supports DRD but the dr_mode is =
not
                 * specified or set to OTG, then set the mode to peripheral=
.
                 */
-               if (mode =3D=3D USB_DR_MODE_OTG &&
+               if (mode =3D=3D USB_DR_MODE_OTG && !dwc->edev &&
                    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
                     !device_property_read_bool(dwc->dev, "usb-role-switch"=
)) &&
                    !DWC3_VER_IS_PRIOR(DWC3, 330A))
@@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
        }
 }

that's problematic or moving

 static int dwc3_probe(struct platform_device *pdev)
 {
        struct device           *dev =3D &pdev->dev;
@@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
                goto err2;
        }

+       dwc->edev =3D dwc3_get_extcon(dwc);
+       if (IS_ERR(dwc->edev)) {
+               ret =3D PTR_ERR(dwc->edev);
+               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
+               goto err3;
+       }
+
        ret =3D dwc3_get_dr_mode(dwc);
        if (ret)
                goto err3;

to happen earlier? Does tracing the "mrfld_bcove_pwrsrc" driver (the
excton provider in this case AFIACT) show anything interesting?
