Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D174344B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjF3FeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3Fd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:33:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D23582
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:33:58 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401f4408955so118471cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688103237; x=1690695237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVktAUTo8uqqiwGeF3etOt9dgoCyOsZaU9oSN6UEZBE=;
        b=37sn0xlL0STS3tToajGcCaIcWU2UbLFGoVgjNL7zfRHQZ3wAJXov4luYHzHYf6phIB
         6s43JYgF9MtPsFk9w5T9IZy+NsYsBb/mPAwFaLjPp3XT68Nci0E0GHfcY07GxlxqfXSm
         GGiWeklNLLxBgu6y6LuoitKvoejsIywVwRrpqjsntNW/Gxv4uK6CXtDh/0NvXuCkNqun
         iam8LBz++AkvKxNgLEJeC4CFgErOfJ7RS4Fpnjj9BdYCNX/sMZVwJVM+b1saWaMDo5SD
         3YkigFIE4EHi72mBLW99H8OFjtUP0scmoE9d90L2E9GN7+1xS8BNXhUDbcAwOmWXZiup
         euDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103237; x=1690695237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVktAUTo8uqqiwGeF3etOt9dgoCyOsZaU9oSN6UEZBE=;
        b=NugIp9ZbH7Q44/vcFayeSbSxMoKx2aCBz8n0Y53XCS8L5UCgKZcq0W5exPNVZv8hY4
         IjxQFuADTprNm6qrbDzPiGOLLJFc4v9/1UmG+Ft9+kYgjuEsufRkrdmYHlIaP8Dg3wu0
         tNyDlxWQ4nmsenCtIpC8vw2/u/OjgcqcpN/JCfCVwIDgkcuTkVudJZ9T+ZCNWHf7gXNS
         F5vvl6gHwB8EHmG7ZIYnycIZ7iqEC6ubkLUBzaIcqRghSm/P43YUtLWOTr1lwfP6VHoa
         X6G/xiKJS/bEd8bbw5EFHamV4H7l29HpiftvoZWApbSPMyyMkEdprQU8UeUHDTtKutH7
         6YjQ==
X-Gm-Message-State: AC+VfDyKOWHdG7KC5G0mDFRvPHMtBfBXsGULcnifcRltAGLWVfdRq9yY
        /0WC3WdTrA6i7GM6VxyKzIR26zaHcxXA2o9hNfPUiZ+5UN0HTQZHNWw=
X-Google-Smtp-Source: ACHHUZ42pHAQjS8oNAQHuXraTYAthPXAQg0vmckJ+g/JK/W3yZ0uwon02og73a/o/nMdcIHS66b0v9fIhBVdP16B0J8=
X-Received: by 2002:ac8:7f4e:0:b0:3f8:1f30:a1f2 with SMTP id
 g14-20020ac87f4e000000b003f81f30a1f2mr801884qtk.26.1688103237494; Thu, 29 Jun
 2023 22:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230630032653.26426-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230630032653.26426-1-qiang.zhang1211@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 30 Jun 2023 07:33:46 +0200
Message-ID: <CANn89i+Yw_3FEjo_dYSknhmyfoOCD-1S0OSRR_GoyMjQPjcu6w@mail.gmail.com>
Subject: Re: [PATCH] net: Destroy previously created kthreads after failing to
 set napi threaded mode
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Wang <weiwan@google.com>
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

On Fri, Jun 30, 2023 at 5:27=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com> =
wrote:
>
> When setting 1 to enable napi threaded mode, will traverse dev->napi_list
> and create kthread for napi->thread, if creation fails, the dev->threaded
> will be set to false and we will clear NAPI_STATE_THREADED bit for all
> napi->state in dev->napi_list, even if some napi that has successfully
> created the kthread before. as a result, for successfully created napi
> kthread, they will never be used.
>
> This commit therefore destroy previously created napi->thread if setting
> napi threaded mode fails.
>

I am not sure we need this, because these kthreads are not leaked at
present time.

pktgen also creates unused kthreads (one per cpu), even if in most
cases only one of them is used.

Leaving kthreads makes it possible to eventually succeed to enable
napi threaded mode
after several tries, for devices with 64 or more queues...

This would target net-next.

If you claim to fix a bug (thus targeting net tree), we would need a Fixes:=
 tag.

Thanks.
