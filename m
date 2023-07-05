Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF62748A6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjGERb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGERbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:31:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDE198E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:30:57 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-401d1d967beso23351cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688578246; x=1691170246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qbXsoCe7w/XOHo1SaGjsh2yo3yyNMYpgkyzsih6E44=;
        b=nyRzlhSrPOr21dTylHgE0obueBITQ3V0QUA/xCI0iDpmMIQdGmUT/zy/5p9hWxOGEG
         JOPGiLGFtCHRVjmjU/0yYsW375jpfmrCsWdTf7naL8f+Z2tTj8lAq+JddpBYxEgMsOpt
         a1TgntP+DjrFgKB/lsWVplE7IT8gteiZpAjTMkhn1VZrHSteI+ugeF+sXLaPPFaoC+wW
         z8aZWCVwedTmMNtAm+dctQhWAYrqc/Y4TTvhV1Wso7o3fsIgs21eUS7EEEBSKoVvgKHG
         pG+gGA6E1UedWqdt/eEjUF4vA9C9B8jTTbM7TWAz9dRFtux8AiHs5cBWkk3CGSOAyw1I
         p+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578246; x=1691170246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qbXsoCe7w/XOHo1SaGjsh2yo3yyNMYpgkyzsih6E44=;
        b=KDuT1L/X9U3TQygDnMwOeWfdNH6GCwnHz/h13nRor4i+imSWX5zsx+GRz/YoCeU7JZ
         7vnY+F9JUvjfxfriOgH0jno2rmX9kpj0x0rBBiegSg/zDKg6AFkgKn+iRyVYHsLsSTqy
         nC5SpAFZwsjvuk6IWfNr/uv0XyQWRTOxTfO0QGXS5eWmsa+K+8NKPk2tQ+EoD4h4i+M/
         wze49izUbwKGUhmazFZdRFaNoghR04xZyLwX10moIGOzNd0MsmJrOij5wKuQDYxrrYlT
         avFc9i/IFh1FZ40dBhncHwK6oESfGx/MCdxqsTdZGtdFvtFa5XAAqEW1SIylhJssNja2
         d09g==
X-Gm-Message-State: ABy/qLYE7kf9JCZ5/O45wTrDwG/8dl7POVaa4WO+BTmRhjo8WQ9w9e+N
        SeLl0ZLFKLUou6pFQc/DLlr/Ez2IzSIj699AZTI+3c8dJx6yHNbuXA==
X-Google-Smtp-Source: APBJJlEmUBhhD5XtNVz8/AVhw+5ZwlOdH1sJayz8r6eglL1ZtFqhfYtRfEMscc1ZyGFYkAhbaNXye1/gEFX1t/b2j4c=
X-Received: by 2002:a05:622a:199a:b0:3f8:6685:c944 with SMTP id
 u26-20020a05622a199a00b003f86685c944mr7368qtc.14.1688578245744; Wed, 05 Jul
 2023 10:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230705141626.461-1-11162513@vivo.com>
In-Reply-To: <20230705141626.461-1-11162513@vivo.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 5 Jul 2023 10:30:33 -0700
Message-ID: <CANDhNCqGmY7F2FRAPs6vGkv2UL0TV5WDzFUEq-QXeRxYijS9Cw@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Convert to use time_after macro
To:     Zehao Zhang <11162513@vivo.com>
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        Zehao Zhang <zhangzehao@vivo.com>
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

On Wed, Jul 5, 2023 at 7:16=E2=80=AFAM Zehao Zhang <11162513@vivo.com> wrot=
e:
>
> From: Zehao Zhang <zhangzehao@vivo.com>
>
> Use time after macro instead of open it for readability.
>
> Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>

Thanks for sending this along!

Acked-by: John Stultz <jstultz@google.com>
