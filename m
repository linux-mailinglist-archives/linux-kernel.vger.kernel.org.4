Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9894164CE35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiLNQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiLNQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:39:07 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5E5FDD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:39:06 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 79so2330358pgf.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbDNBydaewl5dltimDBqmtpJAJq+VfTZXoANK7KfgaM=;
        b=FfGyrKw/pmdyACIFzyBjx3+I1RbAhXpY1KnMvcvd+IcY08hb1o4LUYI2jEIuzO+mFU
         IgAhBi3hP4RrTENiY/AvN82n/S44+iEqYaPvULsrJ9dxTtrbC/XbDwJFSvm5WCy2qF6i
         0OIdfwcoq7wp6CwHFi6W5FtXCOO4Glo8XLi1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbDNBydaewl5dltimDBqmtpJAJq+VfTZXoANK7KfgaM=;
        b=qxiiZXbfgSaUVoT53e2qOyaslnHbUtEMXAeHFuirWmPUq8+/gYXj2AC2SLax7VxTug
         0NY26nZvN5psPMqJfvdBKosZyQOwBN0mv1+ssV4xiysnJ0DPLPWkvabSh489JTuwMKBQ
         FfxSiN907CU9zAlfcw6STK7Sew53oGRBYKvcMwExA6wl6btAwkTwElVo5is5snS63Tl4
         ylk+laplGwcHAAHTBIsQ5yJhwO6+gQcbJep27PkxVKT9hJ1SHcOTGgLa+HUiWV6YCFc+
         sLldfKLKTOS3EwyngSwcVKA6R/jzHd/nXb3wuq0RWH4499Iuwn6ptHClauLj5plsu0U5
         9VYQ==
X-Gm-Message-State: AFqh2kqui4734h2uoOxZJoj0NjF2ZukKgr2GmzUHZhNUVtwib+zDIOBE
        x2PmMZpkaoOTnIGr/RSAhbpbVivgUkhTaKFwW0Q=
X-Google-Smtp-Source: AMrXdXuK/epToRDvptJRxvQZ5ZUgU7qFWwFeVNAGTiJjxvnj7el+GTJ7I3N08l6iUfpGZ6po+gW92A==
X-Received: by 2002:a62:388d:0:b0:57c:c79e:2a41 with SMTP id f135-20020a62388d000000b0057cc79e2a41mr2715579pfa.1.1671035945521;
        Wed, 14 Dec 2022 08:39:05 -0800 (PST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id k201-20020a6284d2000000b00576f9773c81sm59534pfd.211.2022.12.14.08.39.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:39:04 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id l10so3891062plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:39:03 -0800 (PST)
X-Received: by 2002:a17:902:ce04:b0:174:af35:4b90 with SMTP id
 k4-20020a170902ce0400b00174af354b90mr79455890plg.8.1671035943448; Wed, 14 Dec
 2022 08:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20221212-uvc-race-v3-0-954efc752c9a@chromium.org>
 <Y5nEgDOXFNDPf8/Y@pendragon.ideasonboard.com> <CANiDSCvLjr6NK3pL9NpLap44Zcc22OEbyRANXq90dtG+udro4Q@mail.gmail.com>
 <Y5nP1RXbd7mCkmCD@pendragon.ideasonboard.com>
In-Reply-To: <Y5nP1RXbd7mCkmCD@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 14 Dec 2022 17:38:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCsHR2DNPNRkDNELSJcUqUbtxwGY_Rie=3o0NUF+qzDr7g@mail.gmail.com>
Message-ID: <CANiDSCsHR2DNPNRkDNELSJcUqUbtxwGY_Rie=3o0NUF+qzDr7g@mail.gmail.com>
Subject: Re: [PATCH v3] media: uvcvideo: Fix race condition with usb_kill_urb
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Max Staudt <mstaudt@google.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, 14 Dec 2022 at 14:30, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> > > Isn't this still racy ?
> >
> > Indeed...
> >
> > I could add a mutex just for flush_status
> >
> > what do you think?
>
> It may be possible to avoid that. I'm giving it a try.

Just sent a new version without lock...





-- 
Ricardo Ribalda
