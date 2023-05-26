Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DAA712D60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjEZT0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEZT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:26:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E53E51
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:26:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso728876f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685129158; x=1687721158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6DrHgCFY4VauCddEqvyJr/ELyZNf9sKAZHK7/qr+50=;
        b=1fZcXW8cRHgMnWT4prXi7NLHFSMIWcDDBhXNjf7n46YyigPwVGzHTUB7Q4//p4Z1sB
         wcSXYsG1ZQx2LBQrL/XVzl52+KYHCKN2cxvamiNZ6DfIxlHwnY4NNyQG5X8r8yh6IIyX
         HO816t2FVu/g86954JmJkH8jFQMglKi5hzQMWj1Ul4Ie1M5ijrPgjLq8OFqrIgLRbVms
         ikBopAqfYciPsMpVuMsT60IZ01rUm1xwh9F1/pzojr67AF4YIcpMr2KGqEUXJyOk7okj
         gzIkzltmxldnw2p/PrFBipfW8Mg0to7bpXaXwrFLFCYo7DJAunQFkCfIf54lhaUi9x8c
         MqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129158; x=1687721158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6DrHgCFY4VauCddEqvyJr/ELyZNf9sKAZHK7/qr+50=;
        b=C84J+Q6joZCz5Zbqa0+eDkCuP/AaRTxar4w7NNg2QBjnq+X6Zi1anUoHTlnHWfp0SZ
         6din8zrv2UCIQuk66YhQYsTxtK/TTBDhuLDLL5PJpvoCRAfBuo/QTe6CMfCZYAPFX6h3
         oF6Cy/gtTt2SBIHIg8ME2HWe90BzPwWEc1+3/f2ZQQPje/6U31Q50bIQTsSfRacgyjOU
         mRjHdUrfREtFPX5n9AFZNYN5t8pw4jd01rn5XpxBXG3yJDLf0kGtVwAJwjVFblC3Bmeq
         ry+fs3LYXRkaAgxoHao4v4HHxPfMpIw8zKHkdrVMFxUsG7vmnJSQfvTBumzf7TZmAoVJ
         x0Sw==
X-Gm-Message-State: AC+VfDxF33A7hKYlc/Do11eZWRCXWVauvZ8sTeWh1fRlUOhHyFSC+SnQ
        egViL7hmGuXs+FnVW6eYtjIWOy+qnM6WLwXgIxP/4g==
X-Google-Smtp-Source: ACHHUZ5RJ764F8x+H8Zvoem2nWjpzLlLe+acRLbm26xAm7v5HFVz+63/Y72Q6TjAzd/VFGDYJNLxOX+4DTC0ekA3sDw=
X-Received: by 2002:adf:cd8e:0:b0:309:4620:e155 with SMTP id
 q14-20020adfcd8e000000b003094620e155mr2075261wrj.49.1685129157886; Fri, 26
 May 2023 12:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230525173818.219633-1-royluo@google.com> <2023052600-survey-fondness-27ce@gregkh>
 <CA+zupgzTe7pVhByLPVr4tn-94kCMZbzNHxf_iVyTa3qi6bzvAQ@mail.gmail.com> <2023052619-morbidly-expediter-ab80@gregkh>
In-Reply-To: <2023052619-morbidly-expediter-ab80@gregkh>
From:   Roy Luo <royluo@google.com>
Date:   Fri, 26 May 2023 12:25:21 -0700
Message-ID: <CA+zupgztYNMHLw1zZbzMw4KLtmSf7hUNZN_4-jsmFGPHU=3bDg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     raychi@google.com, badhri@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 26, 2023 at 11:34:44AM -0700, Roy Luo wrote:
> > > Also, what userspace code is now calling poll() on your new sysfs fil=
e?
> > >
> >
> > We are looking at adding the code to the generic userspace components
> > if not hardware abstraction layer in the userspace.
>
> I can not parse this at all, sorry.  Care to rephrase it and point to
> some real source code?
>
> thanks,
>
> greg k-h

I meant the userspace part is still in development and it largely depends o=
n
how the kernel part plays out. Hence I'm trying to get early feedback here.
The use cases we're aiming at are described in the commit message, is
there anything specific you're looking for in the userspace code? I'm happy
to answer questions you might have.

Thanks,
Roy
