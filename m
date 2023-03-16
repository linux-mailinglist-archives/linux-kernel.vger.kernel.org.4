Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD96BD7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCPSCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPSCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:02:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF05A180;
        Thu, 16 Mar 2023 11:02:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso2421328pjb.2;
        Thu, 16 Mar 2023 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678989758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/Eo4V+Z0M5Xyp9bJ7HxEGh6BO/Z11FNLae87KRgCgI=;
        b=PF8YirE//rTEesc4/j1T6RdYGocgKF2Sjv4QFC3vyW+DPtfyW2J2gVQr8pERaBCo5K
         AV8j+KO0rgJUWXd1A0wjfnPy+9f4OGWL3+HXMvvBcc+fDsU+KK0t73xgcupXdGXckf9m
         L/VN/3j0qWwFrm+n9ITSuBXsOnGtPp1ZyU+z7qf1jD08cSyRGxbCbXlS8EM61CTYgkMB
         ryw+5UOQ5XW9Qef0osDpYDUbLdq2P7SDAxUPV49gDAe4F+IvH9BURBAta/yy3T6udJTp
         97hFMUyl1ZW9gpjT+CS0PHY3+BuYR6Y9d1wkCVuJS0tMMs1AWxXQMeyNyz0quU1MFTHG
         JcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/Eo4V+Z0M5Xyp9bJ7HxEGh6BO/Z11FNLae87KRgCgI=;
        b=Fh+expsigBcEKKiOkZ3c8zIuq3/BhDgtGuUBnTlYzWdYvm+ae1sWStt+lbczUGIa3j
         NOixXGpxWVTNjBCEWktK0vVcMKma2H35e8N/Giqr5AVJqy50wCvPjAUxC3am51TFteq3
         Xwd72rzTlWrh0b/MIy0MfcwJf9FfkfcKzQvz+5GQLIWOkraCiTI2JoIE72PSGd7fJiDu
         cxQ/ju0wPhs93kUEYJoHHayJBdW43z2y+XlaVl3dpKAikomizHNbDCxTy3WuZB0N6KQ9
         YMhic0xW35joxzw6nVjfG0vxW9di0jnbTYYJuy75NY4p9QgM9qcVsxgHUIAgr70b1q3/
         iXGg==
X-Gm-Message-State: AO0yUKXdAhCqG9kiVxZDEKIYz7hvzrYig+2TKi3T4PluiQUEVg+FwgB6
        VT91Cd9a4Z3tr3v0ECTiET824g0bUdW/jbFOJ44=
X-Google-Smtp-Source: AK7set/dZMLsB2inQfF7n/BBtjOdYcrnPi53cTa8Itr8YyHKWaQrzZuUpCewejSuTqMbcTGC2+3RhMRKsxt8eNJmHvE=
X-Received: by 2002:a17:90a:910d:b0:233:d551:40a7 with SMTP id
 k13-20020a17090a910d00b00233d55140a7mr1408119pjo.9.1678989758072; Thu, 16 Mar
 2023 11:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230316174432.1592087-1-zyytlz.wz@163.com> <829d7a70-8e73-43fd-e819-6ced8c83c12e@linuxfoundation.org>
In-Reply-To: <829d7a70-8e73-43fd-e819-6ced8c83c12e@linuxfoundation.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 02:02:27 +0800
Message-ID: <CAJedcCwbDKa59CJky=KtGcpHq8o6v2x3V6rop+uk4J8rMqeTFQ@mail.gmail.com>
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
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

Shuah Khan <skhan@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=BA=94 01:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/16/23 11:44, Zheng Wang wrote:
> > In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_ti=
mer.
> >
> > When it calls usbip_sockfd_store, it will call v_start_timer to start t=
he
> > timer work.
> >
> > When we call vudc_remove to remove the driver, theremay be a sequence a=
s
> > follows:
> >
>
> When you resend the patch as you indicated would, please add details
> on how you found this proble,m.
>

Get it, I found it by static analysis. So this might be false postive.

Best regards,
Zheng

> > Fix it by shutdown the timer work before cleanup in vudc_remove.
> >
>
> thanks,
> -- Shuah
>
