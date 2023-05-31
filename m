Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55F718EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjEaWlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjEaWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:41:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAE511F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:41:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so205350b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685572863; x=1688164863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtSHrKf9FFhhMQ62tucQUCDkhjQ9Kszms7jWwtFDsZY=;
        b=SQxesh06GdJOvXg5faM/LLzHy17vXsEvwVJlsmnZVmT3s4Qn7IjkyprEnp1Y+lBR5l
         gsvYgnsqnpyyqbXSYMwIUWhYMUxBSVEiytjIk7R1MGQ6xdDUM0O7Kq7cXQ8AUFGqeTcR
         C5R0FDs4kP1yCNsHMPwn6k5TmT9QGuMbALEXQOlfX83RGa/xu9pXCTcyYJWQd3FZtwmV
         SMuKD4kf8YGXK02ZCZHUThPzxNNRUnH0bGAX9ED27eykw9Ih6/Db9Dyzkc5WMjRdK4SD
         UFtY3GIFF5uckr7nIQmZNaEz7e/WlLgAzzxDTtdkqeI4CR5HW2FyVKLYoh8gmM7bEkxi
         s7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572863; x=1688164863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtSHrKf9FFhhMQ62tucQUCDkhjQ9Kszms7jWwtFDsZY=;
        b=MA7VxxgC8c9s7KVYzY5UPvHGhaVIPaM5+g23Q2qMRDqYRyN1YRNQAyAnjhRLv8qfyT
         X5iCA7aFzyyxX5q4OYbC8t1io7AtEH0E1Qf8TnbnAFlpIkJy9ElgpxxeBIRZSILTY7mu
         NGvjspYpmfUAcjkPjnnCYProffgDEFegzkN7wdzcPKcvdBDifKTj2S+2zq8fgnbOnlnW
         LNVEQFAe89HGYiR5MEDmgo9iuBNzi9bNu+96t00kH5qW2Qx6iGAjLB/RQ05Cpv+v4KtU
         CPbhDnEHzsc4MoR+XQ/y+QiBCrkTLOlHrWf6gUU7ObIf4Gjz5Y4hmVerF72JDlWfJpf/
         ByXg==
X-Gm-Message-State: AC+VfDxoVMQShypVcC5tdgCSG2vcBfSVhaiM1ZGzmLqst3tsV5YUm6g9
        mkTdfjXDZrgdMBdVBa2dxq71UH7AmOFGZP87Q+qdxQ==
X-Google-Smtp-Source: ACHHUZ6CJrQvthDs2dN2bwOogDV+l8V98W69LSns2SQ2WXHyvmWNzKzjASdr3wWC99BuQWsOBcSmpU3pe5CW8sqEZPw=
X-Received: by 2002:a05:6a21:100f:b0:10b:8024:d253 with SMTP id
 nk15-20020a056a21100f00b0010b8024d253mr4758297pzb.26.1685572862969; Wed, 31
 May 2023 15:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531040203.19295-1-badhri@google.com> <20230531040203.19295-2-badhri@google.com>
 <618e4f17-2799-4838-a21c-184c9303bef6@rowland.harvard.edu>
In-Reply-To: <618e4f17-2799-4838-a21c-184c9303bef6@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 31 May 2023 15:40:26 -0700
Message-ID: <CAPTae5KrTBa-=JuBDD8iVCx1+Hqd14yWOiCRkAg0+a75Q9QcXA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:55=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Wed, May 31, 2023 at 04:02:02AM +0000, Badhri Jagan Sridharan wrote:
> > usb_udc_connect_control() does not check to see if the udc has already
> > been started. This causes gadget->ops->pullup to be called through
> > usb_gadget_connect() when invoked from usb_udc_vbus_handler() even
> > before usb_gadget_udc_start() is called. Guard this by checking for
> > udc->started in usb_udc_connect_control() before invoking
> > usb_gadget_connect().
>
> After a merged version of patches 1/3 and 3/3 have been applied, it
> seems like most of this will not be needed any more.  Maybe not any of
> it.

Without the connect_lock introduced in this patch, wouldn't the
usb_gadget_connect()/
usb_gadget_disconnect() through soft_connect_store() race against
usb_gadget_connect()/ usb_gadget_disconnect() through
usb_udc_connect_control() ?

On a side note, I am working on merging  patches 1/3 and 3/3.

Thanks,
Badhri

>
> usb_udc_connect_control() gets called from only two places.  One of them
> is in gadget_bind_driver(), where we know that the UDC has been started
> and connecting is allowed.  The other place is the vbus work routine
> queued by usb_udc_vbus_handler().  If that place checks the new
> allow_connect flag before calling usb_gadget_connect(), nothing more
> will be needed.  You just have to make sure that the allow_connect flag
> is set in gadget_bind_driver between the start and connect_control
> calls, and it is cleared in gadget_unbind_driver before the
> cancel_work_sync call.
>
> It's possible that a new mutex will be needed to synchronize accesses to
> the allow_connect flag.  That's something you will have to study and
> decide on.  But if you can avoid adding one, that would be best.
>
> > Guarding udc->vbus, udc->started, gadget->connect, gadget->deactivate
> > related functions with connect_lock. usb_gadget_connect_locked(),
> > usb_gadget_disconnect_locked(), usb_udc_connect_control_locked(),
> > usb_gadget_udc_start_locked(), usb_gadget_udc_stop_locked() are called
> > with this lock held as they can be simulataneously invoked from
> > different code paths.
>
> It's a general principle of kernel programming that locks protect data,
> not code.  So if this patch were to be accepted, you would have to
> change this description to say that connect_lock guards various flags,
> not various function calls.
>
> Alan Stern
