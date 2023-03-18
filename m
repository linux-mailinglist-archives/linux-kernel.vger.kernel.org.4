Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738776BF87C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCRHji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCRHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:39:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5CD38EAB;
        Sat, 18 Mar 2023 00:39:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p20so7532168plw.13;
        Sat, 18 Mar 2023 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679125174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KifuD1TEh3F1Ne+hI+4GjlOzrP3hRlNmdxQcN1SglFY=;
        b=BLjG+7RU2Kw97QqDxBzh7SslTBRDNk9W0FpQqz4U1L/hKvcY+Q2v+A892mF2w5KRWT
         Zz4gvIOEapoD7AKDSsp6rqhq+z2lHKsl4wGcLGcGkqPtDQpYzFpRxHnudFaM3AsitosH
         iZ7B7sp/71/0mxZ8rlHavtRucOBw+o+NsJSf6AgFDl7a129hnsFydwT+QeLxMXhmplN8
         09v6Hy0oKmMvuvaEFZdZtzeqiNL5kt4oENFAO7PcIWSCFpd+JvSDbkuGboFAEOIFw6IX
         7LMOlYWVJ+fivg2esDTCzYvmStb6UqHfDOegT9UO1qo9vevmN0ya1F31EghrbL8OHHOn
         EQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679125174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KifuD1TEh3F1Ne+hI+4GjlOzrP3hRlNmdxQcN1SglFY=;
        b=FzCCk2FseLdq2KQSxqio4mahUkej/ecOfNwvZBstuJg/ND2mBtnSkRtkK/zspyxP3N
         SZot7Bh8CxFlqGHlLfUYx6vQ3+nhd8I7s+SZ/eQgQzUNYjWFGHGCquxgag/dylHpWqhw
         MXv2q0k4GWOlDJG6U1f3rtBpQRV9iq4SEBdvDLBUjVbNs1sPOL37dVOJznSV0CgWx0dC
         4B5L046bajtkv3RVEIY1ezoMpU919ZLu4NlTJIVCE7Ah3b1fns0Y98ZR7gycrqLjcKEZ
         P3AElZuostsjuKNhsJbvjaT5YVyZSJP39SXMEGaH6saBYVOW4/TJboqFZMqJB7aO4GFt
         H21g==
X-Gm-Message-State: AO0yUKWaGl5EXp2ZEsquFPH4Cvyq6NyuSBSX5mUK3Q2/uANikgjtZpjy
        TSH2+p3C830ENHfQFFOsHrfQ2x5gATnuHrUkqWQ=
X-Google-Smtp-Source: AK7set/Z40nLC1Dpb97U3BNPdlud05w7i6nWUY2w8RmmwzIO38rQL693RYVobLrr/QhlmgktaA6BMabvhxe9l5KrxtU=
X-Received: by 2002:a17:902:f80b:b0:1a0:4321:920e with SMTP id
 ix11-20020a170902f80b00b001a04321920emr3752280plb.12.1679125174445; Sat, 18
 Mar 2023 00:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230317100954.2626573-1-zyytlz.wz@163.com> <d05ae776-ee19-2ce0-c06b-9825e5cbea82@linuxfoundation.org>
In-Reply-To: <d05ae776-ee19-2ce0-c06b-9825e5cbea82@linuxfoundation.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 18 Mar 2023 15:39:22 +0800
Message-ID: <CAJedcCwK8Z_nuBM4NnM1PwbTqTnfX2n6UEy9dd5LKf_GScq=xA@mail.gmail.com>
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
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

Shuah Khan <skhan@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8818=
=E6=97=A5=E5=91=A8=E5=85=AD 06:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On 3/17/23 04:09, Zheng Wang wrote:
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
> > Fix it by shutdown the timer work before cleanup in vudc_remove.
> >
> > Note that removing a driver is a root-only operation, and should never
> > happen. But the attacker can directly unplug the usb to trigger the rem=
ove
> > function.
> >
> > CPU0                  CPU1
> >
> >                       |v_timer
> > vudc_remove          |
> > kfree(udc);          |
> > //free shost         |
> >                       |udc->gadget
> >                       |//use
> >
> > The udc might be removed before v_timer finished, and UAF happens.
> >
> > This bug was found by Codeql static analysis and might by false positiv=
e.
>
> This statement that this could be a false positive makes me hesitate
> taking this patch.
>
> What kind of testing have you done with this fix? Were you able to test
> the scenario of unplugging usb?
>

Sorry I did't make a full test for I did't have the device. The
attacking scenario if based on other cases.

Best regads,
Zheng

> thanks,
> -- Shuah
