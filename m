Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583566BE001
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCQEKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCQEKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:10:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640004BE93;
        Thu, 16 Mar 2023 21:10:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j13so3791292pjd.1;
        Thu, 16 Mar 2023 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679026209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIKfGOOSg6F9/5n9W9XnRFoZ02qcEmZDdMXjHXsF83Q=;
        b=gxnJvs+eiyMhefX0NjlZ8BBLBgnP9HIzjr/mYrY/iFPALywGoh4LzL3AgsNr3FCBAh
         RaYkFNdxgEceroxKWQnOCd3n5W9ahdUHn1G051Fkpsdazqg9JoxSDhJ7PrIgJL46CYLx
         EDih7ILAIAXAHR2IqWygsMp5YSZTvCeMTukRnyYoaG4/h9DWwrijGn9IRnWZDGFztw5s
         S3Mx/e3wrlYF6kk7vtWrNm25CoeoLP421+B6mwgL8It7HjDrBC8n+EFs286MX/t+5+DR
         Bw19KPAIPbEsLEzKRhM9E+18r9/WOYwIjdQ6jLNMc1DjlaRmO9l5uGsNpqqXtEWrWyDE
         EODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679026209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIKfGOOSg6F9/5n9W9XnRFoZ02qcEmZDdMXjHXsF83Q=;
        b=ZjodeR1PcvVxHcVqwq64Qojh90NO5Cq6okELSsN9Xi2pQOId2yPmiowLxOeUNG1BP1
         A78agGVg5gQNQu7NBKVLNoF7oOhELI+6pDBUWHNUmRqqGdT2dN+XttcMWMgvxNEwAVyw
         g5QL6PYkgBtAozRtJxbTYYp4L7i4hUk7EB3il9OvByErtwbVjtf0MZMoibSy3hjyEoR6
         betfPZnmvf02Wrsl4q4NjSHUB9qtIwl+SFueCOF57lmRQiz0OLIT859ICCfVkQ+YmmpL
         Tp+iJYFdbFtjkE2uHthkzEfYuOdUxyQLZTu/voF0nwN8NecFsgJUlLdfo2l5k6vzcl9j
         PDwA==
X-Gm-Message-State: AO0yUKV3eCYKO1VroHoWbpkWpI2xaq3NggqgMO2shpvY4f2cDxqaQOu1
        v5BbUn/j9DayUKrIyBAd0iiVKh8GPKYLCzprJ54=
X-Google-Smtp-Source: AK7set8p/Hc+TPkQxZLiZHd2EGyDyr7Noi5cmw/cpSMaPi5hOBD3K+c9yESPVnWgQwk2M5swXAQZo9mFTKdLcz5AXnc=
X-Received: by 2002:a17:90a:b896:b0:23d:30c2:c5b7 with SMTP id
 o22-20020a17090ab89600b0023d30c2c5b7mr555688pjr.3.1679026209724; Thu, 16 Mar
 2023 21:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230316181623.1603914-1-zyytlz.wz@163.com> <ZBNpAJOqeoqc23Y2@kroah.com>
In-Reply-To: <ZBNpAJOqeoqc23Y2@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 12:09:58 +0800
Message-ID: <CAJedcCzCq72UdFyuLJHP-cH-KzmhtA3EERGXSzdXnosOXqWYiA@mail.gmail.com>
Subject: Re: [PATCH v8] usb: gadget: udc: renesas_usb3: Fix use after free bug
 in renesas_usb3_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, skhan@linuxfoundation.org,
        p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
        phil.edworthy@renesas.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, yoshihiro.shimoda.uh@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 03:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 17, 2023 at 02:16:23AM +0800, Zheng Wang wrote:
> > In renesas_usb3_probe, role_work is bound with renesas_usb3_role_work.
> > renesas_usb3_start will be called to start the work.
> >
> > If we remove the driver which will call usbhs_remove, there may be
> > an unfinished work. The possible sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the renesas_usb3_remove.
> >
> > Note that removing a driver is a root-only operation, and should never
> > happen.
> >
> > CPU0                                          CPU1
> >
> >                                        renesas_usb3_role_work
> > renesas_usb3_remove
> > usb_role_switch_unregister
> > device_unregister
> > kfree(sw)
> > free usb3->role_sw
> >                                        usb_role_switch_set_role
> >                                        //use usb3->role_sw
>
> No line at all?
>

Sorry, I'll remove the empty line. And I think there are other ways to
trigger device's remove like directly unpluging the USB device if
accessible. I think we nee to append this msg in the next version.

Best regards,
Zheng
